Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC321DF270
	for <gfs2@lists.linux.dev>; Mon, 31 Mar 2025 19:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743449828; cv=none; b=JZS2xy/nOQlLArPrJcePPQk14cixLZ8efmWz+Pa8/nHknMy6mS34G1L9M2YNqtAmu9lMsa92pTGYmXQT/I6YulRbtvDK4W9JcMnFN62ttpkC9juGoJ2rvKNLs+H9h9DgBuuqYcvrO8lJOQUnsp7O0zb57B51Uv0vx+uPzjGwMNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743449828; c=relaxed/simple;
	bh=wS0MPg0Vrq8XaIBsH1FRIvlQR9bNwjbFAKN8PNkcWRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SbNOBxpTPKdjuw0VDeU25SkAdLtnese56x6fxBFeo9xRqEAOhJzT/PnV3CU0A4lrtMvaVL2LdYO40Do5HeKPIz6ZTJqxUl0A9cnk+ke1QBkYPsEjXTpVBGsSBLW3VutMFDM6CzC17tyZ3G3sB26qUvV10vgRsB0jZz1Utl2JUSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NLv9/9al; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NLv9/9al"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743449825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=49EH0YBkq80au5wcRsabywx2fTWUf9Jb0oNAUNgkQKI=;
	b=NLv9/9alDNi6O0+oamYPbZsykdO9+NpJE3KjVSsMFWl3et8Zip88PFwmTcgYsGwNJuSvje
	t0OFEA2zlQLfkZExxZevybAXVtYof5NWQAqNDllBG/rlH/5O5G+D3LT87sLgtVg0CPXK9w
	7RgfjLyEMEoeOnhcD1trkVrVV6EKYPs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-WtIWZY4ONbuvZ3mmIsBn5A-1; Mon,
 31 Mar 2025 15:37:01 -0400
X-MC-Unique: WtIWZY4ONbuvZ3mmIsBn5A-1
X-Mimecast-MFC-AGG-ID: WtIWZY4ONbuvZ3mmIsBn5A_1743449820
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED2FC180AB16;
	Mon, 31 Mar 2025 19:36:59 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0C102190DB07;
	Mon, 31 Mar 2025 19:36:58 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: agruenba@redhat.com
Cc: stable@vger.kernel.org,
	gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH gfs2/for-next] gfs2: use delay during spinlock area
Date: Mon, 31 Mar 2025 15:36:56 -0400
Message-ID: <20250331193656.1134507-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

In a rare case of gfs2 spectator mount the ls->ls_recover_spin is being
held. In this case we cannot call msleep_interruptible() as we a in a
non-sleepable context. Replace it with mdelay() to busy wait for 1
second.

Cc: stable@vger.kernel.org
Fixes: 4a7727725dc7 ("GFS2: Fix recovery issues for spectators")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/gfs2/lock_dlm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index 58aeeae7ed8c..ac0afedff49b 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -996,7 +996,7 @@ static int control_mount(struct gfs2_sbd *sdp)
 		if (sdp->sd_args.ar_spectator) {
 			fs_info(sdp, "Recovery is required. Waiting for a "
 				"non-spectator to mount.\n");
-			msleep_interruptible(1000);
+			mdelay(1000);
 		} else {
 			fs_info(sdp, "control_mount wait1 block %u start %u "
 				"mount %u lvb %u flags %lx\n", block_gen,
-- 
2.43.0


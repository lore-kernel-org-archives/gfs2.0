Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394F62F5323
	for <gfs2@lists.linux.dev>; Wed, 23 Jul 2025 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753284126; cv=none; b=NT1ZTF6Dif6wUZ9QO483mcQnG5cCNABlQni0rduqSPtpD56AqULgccy3LIdGVflj390bZvNFyZAe7XDsjNSxGzpRS/OSftpTshneYbPWXKh1dl0wINSovC31K2oaeGqVKKTmdkE5OG2ugaoiGJAOioYmORK0tMia+Y6jEMY2aw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753284126; c=relaxed/simple;
	bh=GJtOlf0TCvR0KKGiU6Owa6Xk0u/tzuAaWfVtjjG/BWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=O/xm/dSQ5+/UDzDbw8G9beHMhMJAZexP9rpF8MUdLOx8plHHyP2yABcnyAd1H94PiY1spwvdh4xNtK/i6dgHBL81E9WyoXBJtWiNK39wFZIEcGCdP97AZMYi2yd3o7QmImZ6HA/wteB5pRvc6569gTTgglNAONjVrVsHcQm58PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DJnQlKdp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJnQlKdp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753284122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ywEwX7dcfw6en2gXL945+hArcHieMDPM85+ENJzjkhw=;
	b=DJnQlKdpNtpafnD1CjGv5dYBO/gwtNMrRjfHCMZsyGM3f6iHs3el++FMVtxm5mgphLCgT+
	0J59l724GiBCPEF/f3PwbgQLwLrTtFe0HBUhHqPD4TRfaO0XEOQs0xKhenvX3Gjnha1g8d
	ay4dUlMb0OwbwB70EAn6EVDsVMPmmWI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-lZT5mmBGMSG-BKt3u1km8g-1; Wed,
 23 Jul 2025 11:22:01 -0400
X-MC-Unique: lZT5mmBGMSG-BKt3u1km8g-1
X-Mimecast-MFC-AGG-ID: lZT5mmBGMSG-BKt3u1km8g_1753284120
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E08D1955F45
	for <gfs2@lists.linux.dev>; Wed, 23 Jul 2025 15:22:00 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4C4B51955F4A;
	Wed, 23 Jul 2025 15:21:59 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: agruenba@redhat.com,
	gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH v6.16-rc7 1/5] dlm: check on unequal 3 to allow more values
Date: Wed, 23 Jul 2025 11:21:52 -0400
Message-ID: <20250723152156.2988833-2-aahringo@redhat.com>
In-Reply-To: <20250723152156.2988833-1-aahringo@redhat.com>
References: <20250723152156.2988833-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kh3VNxZ2E0j33GLQnrz_Y0MG_TahD8HRBGn3h2wmH4k_1753284120
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Currently everything that is above 3 as dlm_lockspace_release()
parameter is recognized to do everything what 3 does. Currently there is
no defined value above 3 to introduce a new value that does send a uevent
to the user space and adds this value as uevent attribute.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lockspace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 1929327ffbe1c..ee11a70def92d 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -730,7 +730,7 @@ static int release_lockspace(struct dlm_ls *ls, int force)
 
 	dlm_device_deregister(ls);
 
-	if (force < 3 && dlm_user_daemon_available())
+	if (force != 3 && dlm_user_daemon_available())
 		do_uevent(ls, 0);
 
 	dlm_recoverd_stop(ls);
-- 
2.43.0


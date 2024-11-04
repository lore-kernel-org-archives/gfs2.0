Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DF51FDF81
	for <gfs2@lists.linux.dev>; Mon,  4 Nov 2024 22:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730757864; cv=none; b=k+0zFLwzJjSLspg4EhZh9pAafvuz1NGJhmFiU1NXrvVO1jnLLy7Qk6h8tbw4TVk22OFAha2dtUguuVnaf2CdqQNU1QS6XsJJakOuWjyIo5t72fYDW3QYYjIxHmwj727RiK4j6XZMqE0joyyAokkxVNyRyVp+13cMVbCRTrM6rbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730757864; c=relaxed/simple;
	bh=HeaW/QogAJkNCGhtL4qMQRg6ELIUxUJ09vd753dSS1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MrzB42WPh/aPjs41ocV692kCFhzsFc8LkXMDoWrzK5qcyBUr1tjAqv4qbFOc61s064zGAW/uN74wa1f4eJyVXWrxcW6oHT0bZQCiSaOR81a7/JLeXFIuOZlGmqmPtZ5rLUSmlfFr5r6PAwa3/TYXeLYEZqQG3nhqIj/3+cWX1YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UlFDp3Qa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UlFDp3Qa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730757861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gNpROon65EmRh7ptB4RpSLw3+gLBD5thhPwSCfRO1Q0=;
	b=UlFDp3QacjbtBIagnUu/mcmRuKpHSzMAqqtjN6ZIbdOxEv3KiCpjmr+ZOuPZ5pe8dmb+Ns
	n+D4NGPYncIbgRVZ71Vtx2NRatb4i9oF0Ujls6Ks7nrM9bIsVoP3KHjc2n6CfOFXUOtQVW
	DWc9tev7Jd63hICMBozLuy/Ra6QwD7o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-1hTf-s9UPbCtJsSnWQdJ4A-1; Mon,
 04 Nov 2024 17:04:20 -0500
X-MC-Unique: 1hTf-s9UPbCtJsSnWQdJ4A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 16B90195608C
	for <gfs2@lists.linux.dev>; Mon,  4 Nov 2024 22:04:19 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6325819560A3;
	Mon,  4 Nov 2024 22:04:18 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next 1/3] dlm: fix recover_conversion() if grmode is unknown
Date: Mon,  4 Nov 2024 17:04:15 -0500
Message-ID: <20241104220417.3883898-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

When a pending PR -> CW conversion is interrupted by a fence. While a
fence happened the master lock node of the pending PR -> CW conversion
was removed from the lockspace an recovery try to solve lock
dependencies. A new master node will be elected and the original granted
mode of the PR -> CW conversion cannot be determined anymore. In this
case recovery will set lkb_grmode to lkb_rqmode, but this will leave the
lkb in a invalid conversion state. Later on recovery will grant the
recovered lock state and it can't move out the lkb out of the conversion
queue to move it into the granted queue as the grmode is equal the
rqmode. At the end the lkb ends in an invalid state with grmode set to
DLM_LOCK_IV that can't handle future conversions.

To avoid this case we need to set the grmode to something different than
the rqmode. In the particular case we only run into PR <-> CW conversion.
If the rqmode is PR the grmode should be CW and vice versa to signal a
valid conversion on the conversion queue.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/recover.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/fs/dlm/recover.c b/fs/dlm/recover.c
index 2e1169c81c6e..7f748b21f1fb 100644
--- a/fs/dlm/recover.c
+++ b/fs/dlm/recover.c
@@ -831,11 +831,31 @@ static void recover_conversion(struct dlm_rsb *r)
 		if (lkb->lkb_grmode != DLM_LOCK_IV)
 			continue;
 		if (grmode == -1) {
-			log_debug(ls, "recover_conversion %x set gr to rq %d",
+			/* the information of rqmode was never lost, but
+			 * grmode was lost. The lkb is on the convertqueue
+			 * and requires that lkb_grmode is different than
+			 * lkb_rqmode to be granted later by
+			 * dlm_recover_grant(). The real grmode is unknown
+			 * but as the rqmode is either PR or CW we just
+			 * set grmode as the conversion queue indicates
+			 * contention because the lock mode was incompatible.
+			 */
+			switch (lkb->lkb_rqmode) {
+			case DLM_LOCK_PR:
+				lkb->lkb_grmode = DLM_LOCK_CW;
+				break;
+			case DLM_LOCK_CW:
+				lkb->lkb_grmode = DLM_LOCK_PR;
+				break;
+			default:
+				WARN_ON(1);
+				break;
+			}
+
+			log_debug(ls, "%s %x set gr to rq %d", __func__,
 				  lkb->lkb_id, lkb->lkb_rqmode);
-			lkb->lkb_grmode = lkb->lkb_rqmode;
 		} else {
-			log_debug(ls, "recover_conversion %x set gr %d",
+			log_debug(ls, "%s %x set gr %d", __func__,
 				  lkb->lkb_id, grmode);
 			lkb->lkb_grmode = grmode;
 		}
-- 
2.43.0


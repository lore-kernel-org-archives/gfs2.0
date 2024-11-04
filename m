Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD741FDF8E
	for <gfs2@lists.linux.dev>; Mon,  4 Nov 2024 22:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730757864; cv=none; b=Xcz/AeVNxSOqcLnr2abDLp+a/KDAfYtJA/dGINOhldc1Ee7R0Cnp+hT1Yaca2xvpxbOptlLB0TPbKx1AgyomHeiznzXsZ+q6ftGLFGeJ+sTPzz6skzSwu5N8kuW3qJKYx7kMGWKtz8MZGiOyiJEaWJHQk+fOTTJm1HzT0MZ4g0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730757864; c=relaxed/simple;
	bh=hi4Q0htEQVQVtGjV9WPIInLmwSYnssgCiszlCcx5cMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NIlMHmDu0CbG/hOTkhHrh/bCR1N4/S2NjSIgy4hgn5nHWp/JLjPoq//13LuzcRuXylCOucNeDOKa0kw80K9ZOyc8deythcwuXXvojUUVJxTv4+3adRw8CE4eP1gMa7xl9i5XgjsgNhwKs96HAqqoPZfQapIuPyd+wLPbx0Rp6Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DxiYsd1+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxiYsd1+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730757862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0AIGQMLjZ0Qllkz2p/c1nLmbgr9J9NtKem/2JmYgDBs=;
	b=DxiYsd1+uq2i5dU3eMPm/cwvJtZKr82cPd71VhwFKxBDADmv/lVDe15quQdle5AXh36jTf
	TjZlVHm+W+TW7BEy+Sx27iGxGvpc6UcNyLGVGinyWRhNgWS1AIjCkm/mT3d8XeC0cc9dhz
	arjT7mBcOL1jJpSMrZkLDvo0ANn7/T8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-BemG04U4NEmfTjliztpUyg-1; Mon,
 04 Nov 2024 17:04:20 -0500
X-MC-Unique: BemG04U4NEmfTjliztpUyg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1901B1955D4F
	for <gfs2@lists.linux.dev>; Mon,  4 Nov 2024 22:04:20 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4A8F51955F3D;
	Mon,  4 Nov 2024 22:04:19 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next 2/3] dlm: add grmode sanity checks and debug info
Date: Mon,  4 Nov 2024 17:04:16 -0500
Message-ID: <20241104220417.3883898-2-aahringo@redhat.com>
In-Reply-To: <20241104220417.3883898-1-aahringo@redhat.com>
References: <20241104220417.3883898-1-aahringo@redhat.com>
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

We had earlier issues regarding to look for invalid cases when DLM
conversions were called in a invalid lkb state or if recovery handling
set lkb states. Cover those cases and let the user warn them about that
we were running into those. While on it add more debugging information
for the kernel logger when we run into those cases if rqmode or grmode
is in some invalid state.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c    | 15 +++++++++++----
 fs/dlm/recover.c |  2 ++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 966a926c301b..b883bb94e3e8 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -2830,6 +2830,11 @@ static int validate_lock_args(struct dlm_ls *ls, struct dlm_lkb *lkb,
 		if (test_bit(DLM_IFL_MSTCPY_BIT, &lkb->lkb_iflags))
 			goto out;
 
+		/* sanity check to do a conversion on a invalid lkb state */
+		if (lkb->lkb_grmode == DLM_LOCK_IV ||
+		    lkb->lkb_status != DLM_LKSTS_GRANTED)
+			goto out;
+
 		if (args->flags & DLM_LKF_QUECVT &&
 		    !__quecvt_compat_matrix[lkb->lkb_grmode+1][args->mode+1])
 			goto out;
@@ -2852,14 +2857,16 @@ static int validate_lock_args(struct dlm_ls *ls, struct dlm_lkb *lkb,
 	case -EINVAL:
 		/* annoy the user because dlm usage is wrong */
 		WARN_ON(1);
-		log_error(ls, "%s %d %x %x %x %d %d", __func__,
+		log_error(ls, "%s %d %x %x %x %d %d %d %d", __func__,
 			  rv, lkb->lkb_id, dlm_iflags_val(lkb), args->flags,
-			  lkb->lkb_status, lkb->lkb_wait_type);
+			  lkb->lkb_status, lkb->lkb_wait_type,
+			  lkb->lkb_rqmode, lkb->lkb_grmode);
 		break;
 	default:
-		log_debug(ls, "%s %d %x %x %x %d %d", __func__,
+		log_debug(ls, "%s %d %x %x %x %d %d %d %d", __func__,
 			  rv, lkb->lkb_id, dlm_iflags_val(lkb), args->flags,
-			  lkb->lkb_status, lkb->lkb_wait_type);
+			  lkb->lkb_status, lkb->lkb_wait_type,
+			  lkb->lkb_rqmode, lkb->lkb_grmode);
 		break;
 	}
 
diff --git a/fs/dlm/recover.c b/fs/dlm/recover.c
index 7f748b21f1fb..011153fcb84f 100644
--- a/fs/dlm/recover.c
+++ b/fs/dlm/recover.c
@@ -855,6 +855,8 @@ static void recover_conversion(struct dlm_rsb *r)
 			log_debug(ls, "%s %x set gr to rq %d", __func__,
 				  lkb->lkb_id, lkb->lkb_rqmode);
 		} else {
+			WARN_ON(grmode == lkb->lkb_rqmode);
+
 			log_debug(ls, "%s %x set gr %d", __func__,
 				  lkb->lkb_id, grmode);
 			lkb->lkb_grmode = grmode;
-- 
2.43.0


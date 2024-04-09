Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E285414F12C
	for <gfs2@lists.linux.dev>; Tue,  9 Apr 2024 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712681126; cv=none; b=A2GipEJ5Vg3DLQoSrQ1EApO7MMtL8erQ6n8N3zw+anhf+KcVl8pRpxiwysFCdBgpgjmjp2VTSVqB7xoq5EXBDG2zEf0ysGzkw0kKdCd1IYhf10rqeWG01RBDJr0inm1W7wm3fYgWNCeZQG0nhXrsVf5hKpa/1tQtxURfi2rvlGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712681126; c=relaxed/simple;
	bh=/zp161utTrW0In+lp3Hjc8i68n4JKBSf7FL4bl8+uIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=puDmdNhL1FQWczpaYd1hdh9qfMLR+P6dVvYcYS+4QAb668s/1/tDAJRSmJiBN3OO1bEZFth6Y/oX2uwr0W8utgXMDCiOrYCMlpKQolg29g9azxI1dTJ7EK4N9dyh8sr3HVz/NfdgMoxHWGCd5LYL6dB1+/xPbZRLcNgpp4oovbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K+y0Uyck; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+y0Uyck"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712681124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kmUyvcqy/GIeoSzgw52/Ce4PQQFd8ykAq+5dIEcXp9Q=;
	b=K+y0UyckFBr/C7OXfYpzndg4t0kGs9TPrgOwmHQE7QaNrlgcE4Z6nWokfNaK319Z/R7Jjr
	940klzaTyI5h8e30w1rm/I/uNXSlkykOg3ZSXq+Q5h2SM7rzlnQNjG8zLZKerFlYmh+kfk
	uPPT/6NS0MSq50xLI9ugtDTfEzys0PY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-1_5xubujMgWE66tzDvBbhQ-1; Tue, 09 Apr 2024 12:45:22 -0400
X-MC-Unique: 1_5xubujMgWE66tzDvBbhQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 30CA41049BC6
	for <gfs2@lists.linux.dev>; Tue,  9 Apr 2024 16:45:22 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.28])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A6BB0C0157E;
	Tue,  9 Apr 2024 16:45:21 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 11/15] gfs2: Fix "ignore unlock failures after withdraw"
Date: Tue,  9 Apr 2024 18:45:01 +0200
Message-ID: <20240409164508.79570-12-agruenba@redhat.com>
In-Reply-To: <20240409164508.79570-1-agruenba@redhat.com>
References: <20240409164508.79570-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Commit 3e11e53041502 tries to suppress dlm_lock() lock conversion errors
that occur when the lockspace has already been released.

It does that by setting and checking the SDF_SKIP_DLM_UNLOCK flag.  This
conflicts with the intended meaning of the SDF_SKIP_DLM_UNLOCK flag, so
check whether the lockspace is still allocated instead.

(Given the current DLM API, checking for this kind of error after the
fact seems easier that than to make sure that the lockspace is still
allocated before calling dlm_lock().  Changing the DLM API so that users
maintain the lockspace references themselves would be an option.)

Fixes: 3e11e53041502 ("GFS2: ignore unlock failures after withdraw")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 4 +++-
 fs/gfs2/util.c  | 1 -
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index fa047331ea3c..ec1f8eb28950 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -810,11 +810,13 @@ __acquires(&gl->gl_lockref.lock)
 	}
 
 	if (sdp->sd_lockstruct.ls_ops->lm_lock)	{
+		struct lm_lockstruct *ls = &sdp->sd_lockstruct;
+
 		/* lock_dlm */
 		ret = sdp->sd_lockstruct.ls_ops->lm_lock(gl, target, lck_flags);
 		if (ret == -EINVAL && gl->gl_target == LM_ST_UNLOCKED &&
 		    target == LM_ST_UNLOCKED &&
-		    test_bit(SDF_SKIP_DLM_UNLOCK, &sdp->sd_flags)) {
+		    test_bit(DFL_UNMOUNT, &ls->ls_recover_flags)) {
 			finish_xmote(gl, target);
 			gfs2_glock_queue_work(gl, 0);
 		} else if (ret) {
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index 0535a0206512..09238604d741 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -350,7 +350,6 @@ int gfs2_withdraw(struct gfs2_sbd *sdp)
 			fs_err(sdp, "telling LM to unmount\n");
 			lm->lm_unmount(sdp);
 		}
-		set_bit(SDF_SKIP_DLM_UNLOCK, &sdp->sd_flags);
 		fs_err(sdp, "File system withdrawn\n");
 		dump_stack();
 		clear_bit(SDF_WITHDRAW_IN_PROG, &sdp->sd_flags);
-- 
2.44.0


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F3A41C62
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761956580; cv=none; b=VzDIbSOzNwmV3VEE+GFFK1GUbwyMnPDLG7JlEzxClyA0F1RzDhoRsayuNjbGWM8+qPTZZWe1UdZUZ2aXrDET3ryaUVvZLmAokO3IrdiUHqmU1gSbtfI5lh41BYbe9oYWdLBsap0M3h+rj93mh5k5gv4wfkCCwIcNY+3IkwbuEXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761956580; c=relaxed/simple;
	bh=y+T35o0EvrqbCfaW2v2Jy2lF2hZtJvtOpHlWytkBQ0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=IWJ3xx6kOEc/iaUrnb7ofPG5G3jTGD0fN0nnEzRyw+4L395dMUHZKSTGfIsfqD11t3jNelT4vOUc0f32NLXxWe8gu1Oy5OrWMJODCP5Ok07zLDpD1kU/NgCXvT8gCKh+CZ1uHZjbkig93ygvt+SYafxZFo6oroXwc34/0tuAQwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZhXdZ4/i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZhXdZ4/i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761956578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yVShmMNMq7c7y2CkDcaE4oyeiKiwsdhLihBoyoBkMCI=;
	b=ZhXdZ4/idACQ7QRtxyp+MeTpGwv2dpDN9GVfIliAOytAQ0bynbjwyj0/ROz5YTT3LAaoYY
	AIm8XOi3LXeUMFTc94cLrR+6740bKo1ugfiH1Ixr1c/tytH1eGqCy1qfdUwhVSBXGvBfCa
	pUg1nB/bMYVWfuXtwzkxq/0UOiW6haI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-V5Yps3MvPoqxLKVcJ5Dk6w-1; Fri,
 31 Oct 2025 20:22:56 -0400
X-MC-Unique: V5Yps3MvPoqxLKVcJ5Dk6w-1
X-Mimecast-MFC-AGG-ID: V5Yps3MvPoqxLKVcJ5Dk6w_1761956575
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B44451956068
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:22:55 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A9211180035A;
	Sat,  1 Nov 2025 00:22:54 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 12/24] Revert "gfs2: Force withdraw to replay journals and wait for it to finish" (4/6)
Date: Sat,  1 Nov 2025 00:22:21 +0000
Message-ID: <20251101002234.1286383-13-agruenba@redhat.com>
In-Reply-To: <20251101002234.1286383-1-agruenba@redhat.com>
References: <20251101002234.1286383-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YGNjsP0frh6odZc9hXl3HQoBYI7Xk9T0FGoLcdPci3g_1761956575
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The current withdraw code duplicates the journal recovery code gfs2
already has for dealing with node failures, and it does so poorly.  That
code was added because when releasing a lockspace, we didn't have a way
to indicate that the lockspace needs recovery.  We now do have this
feature, so the current withdraw code can be removed almost entirely.
This is one of several steps towards that.

Reverts parts of commit 601ef0d52e96 ("gfs2: Force withdraw to replay
journals and wait for it to finish").

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/ops_fstype.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index e8e2ed783c7b..19ef5bc93723 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -745,8 +745,7 @@ static int init_journal(struct gfs2_sbd *sdp, int undo)
 		error = gfs2_glock_nq_num(sdp, sdp->sd_lockstruct.ls_jid,
 					  &gfs2_journal_glops,
 					  LM_ST_EXCLUSIVE,
-					  LM_FLAG_RECOVER |
-					  GL_NOCACHE | GL_NOPID,
+					  LM_FLAG_RECOVER | GL_NOPID,
 					  &sdp->sd_journal_gh);
 		if (error) {
 			fs_err(sdp, "can't acquire journal glock: %d\n", error);
@@ -821,13 +820,10 @@ static int init_journal(struct gfs2_sbd *sdp, int undo)
 fail_statfs:
 	uninit_statfs(sdp);
 fail_jinode_gh:
-	/* A withdraw may have done dq/uninit so now we need to check it */
-	if (!sdp->sd_args.ar_spectator &&
-	    gfs2_holder_initialized(&sdp->sd_jinode_gh))
+	if (!sdp->sd_args.ar_spectator)
 		gfs2_glock_dq_uninit(&sdp->sd_jinode_gh);
 fail_journal_gh:
-	if (!sdp->sd_args.ar_spectator &&
-	    gfs2_holder_initialized(&sdp->sd_journal_gh))
+	if (!sdp->sd_args.ar_spectator)
 		gfs2_glock_dq_uninit(&sdp->sd_journal_gh);
 fail_jindex:
 	gfs2_jindex_free(sdp);
-- 
2.51.0


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411A332BF49
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599060; cv=none; b=iS8kj21jv1/DISDNe64KYe+25zhIVkEXwtnk54rpo3rY//ujA/l8+SbBYQsuFiDBM2WNfGDnjEu5LZH2gbI0u+yVLH9oEg2nCrWS36BgSP5dt4VO9vOSK00B6Vc9SMMEsPSEXbAKP28WPoDSmUV3Ynofi/VirTLI6xsPTNGuyUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599060; c=relaxed/simple;
	bh=+Z4oQfhqPUXiBzEPBk5UU9J5ADPiHDvysJ5FA2bbOqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=GBzqHz2k66ErTy5Bqwd92PuLB615qii8uYi6szxCPcHwEcPafvGYpZF7bLoEntRw4vRJgxUmqK5KEOMEIraCfmyka2627tqdGIwXSv11d3NEelwzBpgPmECTr/Ytti63rS9b8zipRbF1H99c9oFc4DiMaHdIW6eU0KRwHJauUlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P1OTROTG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1OTROTG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757599058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=knGG4+ABzMlhk/Vsz2mNEtAt2lwz0h2ixbech/XQ0dM=;
	b=P1OTROTG+SS174dFZaS7xKQcmGU2vHzEN2bR5jr/3Srl5Jcq/7jy4ql8ls1FxD4H/Hv6nG
	feVd1ZB0gNM19mjOHs7ooIPR+Hrh7CB+Cn9Fd8cU5q1k+9lA1WYtBIkr1RKDKXKFRY+MEU
	uKDPlV9ZKwKT6EdpPPf5Cw4//ROls94=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-t5jR_98HMWGZagl95Xn8JQ-1; Thu,
 11 Sep 2025 09:57:37 -0400
X-MC-Unique: t5jR_98HMWGZagl95Xn8JQ-1
X-Mimecast-MFC-AGG-ID: t5jR_98HMWGZagl95Xn8JQ_1757599056
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B00E1944EBE
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:57:36 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.31])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 20FA219560BD;
	Thu, 11 Sep 2025 13:57:34 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 04/20] gfs2: do_xmote cleanup
Date: Thu, 11 Sep 2025 15:57:09 +0200
Message-ID: <20250911135726.657575-5-agruenba@redhat.com>
In-Reply-To: <20250911135726.657575-1-agruenba@redhat.com>
References: <20250911135726.657575-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Q7kefWIQk_80RtZRfsQhSFOHDpEe1WrRV18RFf4tH-Y_1757599056
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Check for asynchronous completion and clear the GLF_PENDING_REPLY flag
earlier in do_xmote().  This will make future changes more readable.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 09af1fe12503..f1383e9445be 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -816,6 +816,12 @@ __acquires(&gl->gl_lockref.lock)
 		ret = ls->ls_ops->lm_lock(gl, target, lck_flags);
 		spin_lock(&gl->gl_lockref.lock);
 
+		if (!ret) {
+			/* The operation will be completed asynchronously. */
+			return;
+		}
+		clear_bit(GLF_PENDING_REPLY, &gl->gl_flags);
+
 		if (ret == -EINVAL && gl->gl_target == LM_ST_UNLOCKED &&
 		    target == LM_ST_UNLOCKED &&
 		    test_bit(DFL_UNMOUNT, &ls->ls_recover_flags)) {
@@ -823,14 +829,10 @@ __acquires(&gl->gl_lockref.lock)
 			 * The lockspace has been released and the lock has
 			 * been unlocked implicitly.
 			 */
-		} else if (ret) {
+		} else {
 			fs_err(sdp, "lm_lock ret %d\n", ret);
 			target = gl->gl_state | LM_OUT_ERROR;
-		} else {
-			/* The operation will be completed asynchronously. */
-			return;
 		}
-		clear_bit(GLF_PENDING_REPLY, &gl->gl_flags);
 	}
 
 	/* Complete the operation now. */
-- 
2.51.0


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7432E9EA4
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599064; cv=none; b=IwTAIkvrSoov/ySSc6sBbt76CCMqfLAqRBm2/W3ejGEgnYg1ZRgVAWiQ2OGp89DLkAUNi1ajxR5Ji76e/iNHvUXauyyTDQNJhe2CngiNLYWlT1s0gaI7ghculnZi8isFaJY+GxvE+kzznAeT5SiShgRhtMq9brRIZPT/8KFvY0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599064; c=relaxed/simple;
	bh=xVwMb3xuFEpLAXIj5dFrlrVZbTg911pbcnFevBUy6xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=LPTuvdZLWWBqaQMlC83sTx5K9Udju+QdwxiGpvFNuHCcOmPCngDT/Zm6MwPSRHaEYziC5t4BY7FcF14XIu2zXU82yUBZ9FqD8VCYI+9nxYisguI35d0xf8S2QDHhKgnv754VcwT76GMFLH02rY1JtBZzSz55B1w+lwM2xqyjzmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=azyBWbZm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azyBWbZm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757599062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z7fLZAOKs+X+iMJ84YQy5pwBWLHCTLWFCR/eaFdYChA=;
	b=azyBWbZmFPncTvCyeAE9D8MNLssOXXw1ViWZu2dfYmZc84j/IpVvnTP469ctZTt69QS8kk
	uft+htJqZozlyAaY+dkcetEuGz3kl5DwPfDx2Peh51L2fAe8CZrqd9RiwqxoeZUg/2+NcB
	pv2p+niPDajnKjHfoIOEb5MrAs8Yu3w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-40kZ724sNlqC83nB2Jjs1A-1; Thu,
 11 Sep 2025 09:57:40 -0400
X-MC-Unique: 40kZ724sNlqC83nB2Jjs1A-1
X-Mimecast-MFC-AGG-ID: 40kZ724sNlqC83nB2Jjs1A_1757599060
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2031A1944F01
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:57:40 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.31])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E5A3919560B1;
	Thu, 11 Sep 2025 13:57:38 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 06/20] gfs2: Partially revert "gfs2: do_xmote fixes"
Date: Thu, 11 Sep 2025 15:57:11 +0200
Message-ID: <20250911135726.657575-7-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: WNddhXviZiNcNDSMI7sIYBC__C2dT1h16DyKgqGq7vg_1757599060
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When the lm_lock hook which calls dlm_lock() returns an error,
do_xmote() previously reported the error to the syslog ("lm_lock ret
%d\n") but otherwise ignored it during withdraws.  Commit 9947a06d29c0
("gfs2: do_xmote fixes") changed that to pass the error on to the glock
layer, but the error would then only result in an unconditional BUG() in
finish_xmote(), which doesn't help.  Instead, revert to the previous
behavior.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 8a7f947883cd..5bdb11de5b13 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -832,7 +832,8 @@ __acquires(&gl->gl_lockref.lock)
 			 */
 		} else {
 			fs_err(sdp, "lm_lock ret %d\n", ret);
-			target = gl->gl_state | LM_OUT_ERROR;
+			GLOCK_BUG_ON(gl, !gfs2_withdrawing_or_withdrawn(sdp));
+			return;
 		}
 	}
 
-- 
2.51.0


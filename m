Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A76E2D46B5
	for <gfs2@lists.linux.dev>; Wed,  2 Jul 2025 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751469948; cv=none; b=MiTncvIKLj64eFrXPtp0GJkFmRUGLjgCUEyIWD9nIRmkxeMulnk+Jk4smD1Q49xGQcYT6fYsCKESJFN6XLJMbCI7GxPVY8wn5i6cQtOQVD5xix05GfeSTbET8pPVqij3E4ZGcS6OMfxI/eeqYyKKeKMOY9RYuniizhEdvfgyDis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751469948; c=relaxed/simple;
	bh=FkLGmFaQWgggu1fxcXsa+Qofjdbhg6Pko+RkXy43fOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=G4Ki/0uteHFNrrY50K9mIpwTO2veDhaSooNIUgy8mbgLevNrF6j6+NforLeuNBZs2wE8D8tVrQ0gsaan49V6fdR5pLcXgVTs5Js+Z8UL/kulURjGKfjoONdxo8sinwh6GoECOazFBtJkJHmq1nysHw5zPliFUGLcuUboHOYQ8+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VsbIGP2j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VsbIGP2j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751469945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EDe3sm3FA+pA3DuC82KgXKIl41vJ+zgbB1UXN/cqX3s=;
	b=VsbIGP2jIqEWULfOBjkD59NYeTbeAQhf5N24NJhQ6k/5gwensgxC7O8KNrF6aTR2LDH9Px
	zgWYjVwMsCxibrc7CsOyzPK4/VPsJkNhL0/7NVjAzKM9W02gAjrDXMEn1cnUpHicshhGvC
	LKxVA1ju/ELrePoNQLikK0uB1SwjV/M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-hK7wNfTXPEq7vgD19a_88A-1; Wed,
 02 Jul 2025 11:25:44 -0400
X-MC-Unique: hK7wNfTXPEq7vgD19a_88A-1
X-Mimecast-MFC-AGG-ID: hK7wNfTXPEq7vgD19a_88A_1751469943
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D5AB41944CC1
	for <gfs2@lists.linux.dev>; Wed,  2 Jul 2025 15:25:43 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.210])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8D8371956087;
	Wed,  2 Jul 2025 15:25:42 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Andrew Price <anprice@redhat.com>
Subject: [PATCH 2/3] gfs2: simplify finish_xmote
Date: Wed,  2 Jul 2025 17:25:35 +0200
Message-ID: <20250702152537.21742-3-agruenba@redhat.com>
In-Reply-To: <20250702152537.21742-1-agruenba@redhat.com>
References: <20250702152537.21742-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lzAhL8j05Mbk1xfhbkxB9pQSGR8WhkhiUt1un8AiuKg_1751469943
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

As a follow-up to commit a431d49243a0 ("gfs2: Fix request cancelation
bug"), it turns out that any call to finish_xmote() is always followed
by a call to run_queue(), either

 * directly when glock_work_func() calls finish_xmote() before calling
   run_queue(), or

 * indirectly when do_xmote() calls finish_xmote() before calling
   gfs2_glock_queue_work(), which queues a call to glock_work_func() in
   work queue context,

so remove the code in finish_xmote() that duplicates the functionality
of run_queue().

In addition, the code this commit removes is missing a check for the
GLF_DEMOTE flag which indicates that no further promotes should be
performed, so if that code didn't get removed, that check would have to
be added.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Reviewed-by: Andrew Price <anprice@redhat.com>
---
 fs/gfs2/glock.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 5dfb89475894..debdade97240 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -616,14 +616,6 @@ static void finish_xmote(struct gfs2_glock *gl, unsigned int ret)
 				list_del_init(&gh->gh_list);
 				trace_gfs2_glock_queue(gh, 0);
 				gl->gl_target = gl->gl_state;
-				gh = find_first_waiter(gl);
-				if (gh) {
-					gl->gl_target = gh->gh_state;
-					if (do_promote(gl))
-						goto out;
-					do_xmote(gl, gh, gl->gl_target);
-					return;
-				}
 				goto out;
 			}
 			/* Some error or failed "try lock" - report it */
-- 
2.50.0


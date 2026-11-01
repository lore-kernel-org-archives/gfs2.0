Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793564461;
	b=omF9/vFUKP8tbp7SdeGv1rMmYekgRQyPvoWVViO+VwHU8+DSq0kVpQVLqepRLmBzCZwp
	 BTaTFOiXHhg9XGk6oriIsak/ZefAzXo8ErzWWZxbjYM5aQGeqRRDEPuHoH7pjwVMhWbIZ
	 nkA4LZ+PbQOWIQ+4L+azR1UQSlqOUG3Xzz+CPpDXvEEB9Zmn375oVrfVESODn+xomlO2Z
	 eXETMHdycYDXlXeSmzG5UhqqLG9l2/Z7MNWbfsQwQYRR9igiFq1JkR4UvgPQtLjb7TLPq
	 5Gzq4BnLdwv9lMhF6z3ZiQweO4882ZBAHc61PSCQ2xXFsfEPmsJc5KZCQ6r9qPhAwog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793564461;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=SnRdbO0JDb2AZxwFBP4Xv5/rs2/QFL91VtSYQ1cDbUY=;
	b=j9j7IdSXOuUec2McUi8oNPutKgimPb3SGoes29q3SSMxPu8IAfI5DBU7+nQmUROtmP7z
	 p9/UMDUySBXWzBwPwyTHwQUo25JK2qS76ySiH09klRrp9l2st+D4lOT4VYsIbifUopq4a
	 R1Dg9K4Qbmz8cERpzORL1Dw85kPMLNqKwqqgo4R9dstd9SEQcxxmS1gnZ931YmeFpLPEC
	 3WlDPK2k2gzjIJHheR8CjC4mXuict5AlLaerCWQRQLgYrFfitfeeuSCmRWojbGYwuJA6f
	 bXU5UPZBpykg35OLFuxJ0JvWJSV2gGIUmckhzFrX9P1Di3Df3ME4fRa64C2bmtfKWVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DDMH5tLG;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02D2606A327
	for <gfs2@lists.linux.dev>; Sun,  1 Nov 2026 20:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B02D2606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DDMH5tLG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793564459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SnRdbO0JDb2AZxwFBP4Xv5/rs2/QFL91VtSYQ1cDbUY=;
	b=DDMH5tLGn/uorv+zWl9j7D1Ov3nCJvsN4B+XaTaL3Lk/aJpsWDtm0sELMY99OhQvZtdG9k
	/Kx+PQEW+qY2o5rJt6sSSWonNTBS2XtLzdbsPvK1kpsweh+gYiV8SplbeBZQeY9dVs9yHt
	d0AExdUeaG13zv2/6h/tW9m4zjP4yKs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-8ssmoo3WPOaZVhnsJfSBfA-1; Sun,
 01 Nov 2026 15:20:58 -0500
X-MC-Unique: 8ssmoo3WPOaZVhnsJfSBfA-1
X-Mimecast-MFC-AGG-ID: 8ssmoo3WPOaZVhnsJfSBfA_1793564457
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF03B18007F4
	for <gfs2@lists.linux.dev>; Sun,  1 Nov 2026 20:20:57 +0000 (UTC)
Received: from agruenba-thinkpadx1carbongen9.rmtat.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CA39B1956086;
	Sun,  1 Nov 2026 20:20:56 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 3/3] gfs2: Minor error message improvement
Date: Sun,  1 Nov 2026 21:20:52 +0100
Message-ID: <20261101202052.963555-3-agruenba@redhat.com>
In-Reply-To: <20261101202052.963555-1-agruenba@redhat.com>
References: <20261101202052.963555-1-agruenba@redhat.com>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Fyd3BfYXQP9tHO-dIrozCp-M9p2qrDGqwp-qounr9ns_1793564457
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Use a symbolic glock state name instead of the numeric code.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 8c0ce9aacc6b..aa11168255e9 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -595,9 +595,9 @@ static void finish_xmote(struct gfs2_glock *gl, unsigned int ret)
 			break;
 		default: /* Everything else */
 			fs_err(glock_sbd(gl),
-			       "glock %u:%llu requested=%u ret=%u\n",
+			       "glock %u:%llu requested=%s ret=%u\n",
 			       glock_type(gl), glock_number(gl),
-			       gl->gl_req, ret);
+			       state2str(gl->gl_req), ret);
 			gfs2_withdraw(sdp);
 		}
 		return;
-- 
2.56.0


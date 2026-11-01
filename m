Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793564460;
	b=CvnkJg1PFga2HCZSuLXI+TcN0T4ajBWUjQQ4ekfWxhYnQDNYmCCuezj3a8tZJJlg+lrY
	 D1foWv51ZwyVdvoU3Nqh/faQH2cnCbzO299S7p2+HjUKfmzkpZdu7iXpKL2D6WcjXYEUE
	 MrqbGD7w6mU/hOXYmOfY0Mkd9A8Z36ayI+wQk3MjtYAC8xmXlLLIGBgOQVpQjIpBX2w+W
	 C9mNwXwe9KJBJUtQp6JrFhc8ElASFb3H7TCQOKwwpMN2Q3WMf2Kw//8assAKNRowM314f
	 BHARpDmyr6VgvHojtySO3asGZgkjm6Efkz6Dv0UlPh6oqHKuCQUpwNmTT7H5udyJEzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793564460;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=Oh6AvmXycxAGPorLf63ciQDPh05b5/WxosycpkEvj8o=;
	b=QSwoQncMHd/jC6TiAMoDa0X+aKjwsRE59chMPr3J+mGBwaKB9kBCl1WwQflgV7c9oWM4
	 jm2fNfcxblXxMM/i2oswzSxAiYEu+YsiQ9ZrklN9A2wiO+k3/prrHV+87V5UDB12V++m+
	 DSdV3rTLibpoFnsknb16+ncX8y7aIsnDZvw6wb2D3ZdUATsxcWxpYFhivBL94+IUFAbxu
	 UNDmOXv4ueCirsH8gks0Afs3m48+MawrALTOXKp6hAYJgzjG1bJ6ibRM3EZPzlCd7lu3L
	 N+hBbwUw48+FuwdJr+wx5YSKJRLl8WEy5iFTgz2R+mmrFAd+MVmxLRlus9xq/ggKV8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iExjdRP+;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0502F606A324
	for <gfs2@lists.linux.dev>; Sun,  1 Nov 2026 20:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0502F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iExjdRP+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793564458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oh6AvmXycxAGPorLf63ciQDPh05b5/WxosycpkEvj8o=;
	b=iExjdRP+93N7q56IhlaOix0/6zru8F5PQRsn1NB+nqxLpesUQ8nd/rTH5+DbdbVCtMPGuw
	FkfP1Xp6RgiAyPIH8E7lZcelXdVDszGjDOVLe5sDKjTWMWMsJE89Wh7PYZth2w88ysZZ+u
	JS+X0rtt2PSfIZKlsVj2RFNIkT7mlR4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-164-NTyCPC7sPsiq7RAqUwjSsg-1; Sun,
 01 Nov 2026 15:20:57 -0500
X-MC-Unique: NTyCPC7sPsiq7RAqUwjSsg-1
X-Mimecast-MFC-AGG-ID: NTyCPC7sPsiq7RAqUwjSsg_1793564456
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B0C21955F28
	for <gfs2@lists.linux.dev>; Sun,  1 Nov 2026 20:20:56 +0000 (UTC)
Received: from agruenba-thinkpadx1carbongen9.rmtat.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8FDBC195608B;
	Sun,  1 Nov 2026 20:20:55 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 2/3] gfs2: Don't BUG during a withdraw
Date: Sun,  1 Nov 2026 21:20:51 +0100
Message-ID: <20261101202052.963555-2-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: Tl9RkvacaYuV5a2ANVtydo3ELaT-n560IL_F7Wlp9Zs_1793564456
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Recent testing has revealed the following BUG:

[] gfs2: fsid=STSRHTS7386:withdraw0.0: about to withdraw this file system
[] gfs2: fsid=STSRHTS7386:withdraw0.0: gfs2_withdraw_helper failed with status 1
[] gfs2: fsid=STSRHTS7386:withdraw0.0: glock 2:13127 requested=1 ret=4
[] gfs2: fsid=STSRHTS7386:withdraw0.0: G:  s:EX n:2/3347 f:lDpyo t:SH d:SH/0 a:0 v:0 r:2 m:200 p:1
[] gfs2: fsid=STSRHTS7386:withdraw0.0:  I: n:20/13127 t:4 f:0x00 d:0x00000001 s:3864 p:0
[] ------------[ cut here ]------------
[] kernel BUG at fs/gfs2/glock.c:585!

This indicates that we are withdrawing the filesystem and finish_xmote()
has been called with status LM_OUT_ERROR on a glock that is being
demoted.  This happens when gfs2_withdraw_glocks() cancels pending
locking requests, but finish_xmote() thinks that it's a communication
error with dlm.

When finish_xmote() processes the result of a locking request, it
usually retries failed demote requests until they eventually succeed.
However, this is futile when the filesystem is already withdrawing, so
change the code to bail out immediately in that case instead.  This
prevents the BUG described above.

In addition,  when an actual protocol error occurs, withdraw the
filesystem instead of triggering a BUG().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 9f6995dc4346..8c0ce9aacc6b 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -562,8 +562,10 @@ static void finish_xmote(struct gfs2_glock *gl, unsigned int ret)
 	/* Check for state != intended state */
 	if (unlikely(gl->gl_state != gl->gl_target)) {
 		struct gfs2_holder *gh = find_first_waiter(gl);
+		struct gfs2_sbd *sdp = glock_sbd(gl);
 
-		if (gh && !test_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags)) {
+		if (gh && (!test_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags) ||
+			   gfs2_withdrawn(sdp))) {
 			if (ret & LM_OUT_CANCELED) {
 				list_del_init(&gh->gh_list);
 				trace_gfs2_glock_queue(gh, 0);
@@ -596,7 +598,7 @@ static void finish_xmote(struct gfs2_glock *gl, unsigned int ret)
 			       "glock %u:%llu requested=%u ret=%u\n",
 			       glock_type(gl), glock_number(gl),
 			       gl->gl_req, ret);
-			GLOCK_BUG_ON(gl, 1);
+			gfs2_withdraw(sdp);
 		}
 		return;
 	}
-- 
2.56.0


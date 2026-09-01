Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A1848CD5B
	for <gfs2@lists.linux.dev>; Tue,  1 Sep 2026 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284847; cv=none; b=IQeylpVNU8aIm5dhoF255oSr1655Ou88Q9nLBqYPZ0Vs2tzhEYb+D9jcjDI7gfU83oyHitbVV97y9ppNNX0XSTl6HPI+kBMzJDBq+UP2mZfrLG9H5EkcFLjZUld6/zJzppQmTDnFuuRYDwjMViFlsYq7DfhP0qi9aW8X9vJIU/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284847; c=relaxed/simple;
	bh=UNDj5nkYG87JsTv0AsAv3PBXtY2PMGFli9ekkjzzmdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=unN0OYY/y9rzOo3uAtDCChSpheoHOH7W/19o4QEjIGu5kh/7pKeGXMbktnMujuqSL9CGL+5LdD0You1+B4v8H61C5aGgfelIIauPku/N3hpcuZIy2be3AVbPJQqeE9PPIo938RP0Yo2KN8mz28bl4l4AntzA774/6jEqzr9kfE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cr1M+BgO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cr1M+BgO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788284845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lY3V1l2Y9JppOzwi9QBhIgpg0oeqJ4H8iL9TRqfJyXY=;
	b=cr1M+BgO5Qy1CVQsvpTzAUhWQjaGHkIpfAOrF+IRtazDqX4Bfp5wuUg++dezsVJoyRQD5c
	gZI9ECbmx3cvPItA1szdcfcXG4wEG4q3Jh6VgK9rJk5B79u1Fs/97WS2NxhtgaQ1q9NpuQ
	V1ju+skBiUah1N4RIynzkgvqkotasR0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-vkUp9jGKNj2rnxyg5r5jAA-1; Tue,
 01 Sept 2026 13:47:23 -0400
X-MC-Unique: vkUp9jGKNj2rnxyg5r5jAA-1
X-Mimecast-MFC-AGG-ID: vkUp9jGKNj2rnxyg5r5jAA_1788284843
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 305BB1801BE1
	for <gfs2@lists.linux.dev>; Tue,  1 Sep 2026 17:47:23 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B216218005BD;
	Tue,  1 Sep 2026 17:47:22 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH RESEND dlm/next 3/8] dlm: validate userspace lock resource name length
Date: Tue,  1 Sep 2026 13:47:10 -0400
Message-ID: <20260901174715.3825582-4-aahringo@redhat.com>
In-Reply-To: <20260901174715.3825582-1-aahringo@redhat.com>
References: <20260901174715.3825582-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y-uCKxJykrxUw7b9z6FQgFFvL7zIZgPjoegF4HQwBR8_1788284843
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Samuel Moelius <sam.moelius@trailofbits.com>

The DLM userspace device accepts a flexible resource name after
`struct dlm_write_request`.  `device_write()` bounded the total write
size, but did not verify that `i.lock.namelen` was covered by the bytes
actually supplied by the write.

A short `DLM_USER_LOCK` request can therefore claim a full
`DLM_RESNAME_MAXLEN` resource name while providing no name bytes.  The
request path later hashes and copies the claimed name length, reading
past the `memdup_user_nul()` allocation.

Reject non-conversion lock requests whose claimed resource name length
exceeds the flexible name payload supplied with the write.  Valid lock
requests with complete names are unchanged.  Track the payload length
before compat conversion so 32-bit requests keep using their own request
header size.

Assisted-by: Codex:gpt-5.5-cyber-preview
Acked-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/user.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/dlm/user.c b/fs/dlm/user.c
index cd7e142ca670d..0b0a7e1bd1095 100644
--- a/fs/dlm/user.c
+++ b/fs/dlm/user.c
@@ -512,6 +512,7 @@ static ssize_t device_write(struct file *file, const char __user *buf,
 			    size_t count, loff_t *ppos)
 {
 	struct dlm_user_proc *proc = file->private_data;
+	size_t name_payload = 0;
 	struct dlm_write_request *kbuf;
 	int error;
 
@@ -545,6 +546,7 @@ static ssize_t device_write(struct file *file, const char __user *buf,
 
 		if (count > sizeof(struct dlm_write_request32))
 			namelen = count - sizeof(struct dlm_write_request32);
+		name_payload = namelen;
 
 		k32buf = (struct dlm_write_request32 *)kbuf;
 
@@ -561,7 +563,13 @@ static ssize_t device_write(struct file *file, const char __user *buf,
 
 		compat_input(kbuf, k32buf, namelen);
 		kfree(k32buf);
+	} else {
+		if (count > sizeof(*kbuf))
+			name_payload = count - sizeof(*kbuf);
 	}
+#else
+	if (count > sizeof(*kbuf))
+		name_payload = count - sizeof(*kbuf);
 #endif
 
 	/* do we really need this? can a write happen after a close? */
@@ -571,6 +579,15 @@ static ssize_t device_write(struct file *file, const char __user *buf,
 		goto out_free;
 	}
 
+	if (kbuf->cmd == DLM_USER_LOCK &&
+	    !(kbuf->i.lock.flags & DLM_LKF_CONVERT)) {
+		if (kbuf->i.lock.namelen > name_payload ||
+		    kbuf->i.lock.namelen > DLM_RESNAME_MAXLEN) {
+			error = -EINVAL;
+			goto out_free;
+		}
+	}
+
 	error = -EINVAL;
 
 	switch (kbuf->cmd)
-- 
2.43.0


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2831591FC
	for <gfs2@lists.linux.dev>; Wed, 29 May 2024 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002247; cv=none; b=WmYj9KCWv359tqdIg7F3pngNtc/TEykwfdTjtPqlm0dELumF2TFqNf8T9FZhNuK3DazTA3nNobqmKjsbWUutXiUZ/E90Ax/5SOhpuYytnkaUF5rVtJvLqUhTw6mQzUAqXvCVModzg1c5imvVZHMBk3k3ES+UN95AQMbHI82J6dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002247; c=relaxed/simple;
	bh=amVI1dAnvtxzo5F42CdBWaSgMYXvXw8KHA9cQzkVTeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EQC6kI6udI9AZXVggsWcdcWGO/hy8t2Hl77DRqiNj77wsUk/rW+EDkWBi3If5eedRVWUOg9k6d93MUZjwTnlB72vAUZeK3ifZ6KTXESiRhTLSkElPNbhlMzIKq3DQ4q8XD9OailZMATN3JJj4zBPTva+TbSeD6LWvKB0eFowApw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fvF97+Jh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvF97+Jh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717002244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wA5Q5FtubfgfKAOuxpQbMb1IkK7FzLeoDA9TThxb0go=;
	b=fvF97+JhlXNW7rKa0dF7OEn9QdiF5G+4f/QRj+bs+cQB7w1S4DfS14cKG7hKYtQpSY1JSs
	V3aTJlPxObyO7/aTx6nOSc6OTZBT2MAGudRHxf9D5hf8aV5V4EDP8+H9Y9Eh6V3p9nVxf4
	5wKT7PVue5Ru+79SAeJTibiAW6zSkJ8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-aGpkWgB9N_Go9We2jAxwAw-1; Wed, 29 May 2024 13:04:01 -0400
X-MC-Unique: aGpkWgB9N_Go9We2jAxwAw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A769285A58C
	for <gfs2@lists.linux.dev>; Wed, 29 May 2024 17:04:01 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2B48B492BC6;
	Wed, 29 May 2024 17:04:01 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 10/15] gfs2: gfs2_glock_get cleanup
Date: Wed, 29 May 2024 19:03:47 +0200
Message-ID: <20240529170352.571141-11-agruenba@redhat.com>
In-Reply-To: <20240529170352.571141-1-agruenba@redhat.com>
References: <20240529170352.571141-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Clean up the messy code in gfs2_glock_get().  No change in
functionality.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 5fed5a22a8e7..2d4e927c4d2f 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1203,13 +1203,10 @@ int gfs2_glock_get(struct gfs2_sbd *sdp, u64 number,
 				    .ln_sbd = sdp };
 	struct gfs2_glock *gl, *tmp;
 	struct address_space *mapping;
-	int ret = 0;
 
 	gl = find_insert_glock(&name, NULL);
-	if (gl) {
-		*glp = gl;
-		return 0;
-	}
+	if (gl)
+		goto found;
 	if (!create)
 		return -ENOENT;
 
@@ -1271,23 +1268,19 @@ int gfs2_glock_get(struct gfs2_sbd *sdp, u64 number,
 	}
 
 	tmp = find_insert_glock(&name, gl);
-	if (!tmp) {
-		*glp = gl;
-		goto out;
-	}
-	if (IS_ERR(tmp)) {
-		ret = PTR_ERR(tmp);
-		goto out_free;
-	}
-	*glp = tmp;
+	if (tmp) {
+		gfs2_glock_dealloc(&gl->gl_rcu);
+		if (atomic_dec_and_test(&sdp->sd_glock_disposal))
+			wake_up(&sdp->sd_kill_wait);
 
-out_free:
-	gfs2_glock_dealloc(&gl->gl_rcu);
-	if (atomic_dec_and_test(&sdp->sd_glock_disposal))
-		wake_up(&sdp->sd_kill_wait);
+		if (IS_ERR(tmp))
+			return PTR_ERR(tmp);
+		gl = tmp;
+	}
 
-out:
-	return ret;
+found:
+	*glp = gl;
+	return 0;
 }
 
 /**
-- 
2.45.1


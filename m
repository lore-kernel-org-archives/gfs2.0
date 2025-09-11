Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EB6309EFF
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599069; cv=none; b=UcZ+ahoOEkLgzRQZ6IWORVjx+zu62pyYsyxXLb8ywafOX/LBDgKwxCwsMNN3BanI63/+kBM5w5q8tv6KQQs0KMGfbIlUtUZDBVQnt80x1JZNXNiGx+uviJfZB/qYJA+HYIPJIYo7w+c4GVWxZtBaZ5yfJRV3yRZBUU2aOBjGm8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599069; c=relaxed/simple;
	bh=1PvmCA9hjrUAl8Guui8uOiAAv1fZdzLm5DhwiXW5Vg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=JqgXOnTGHlrN5DDs9I6l1gYzmysES5NV3LmTWevwcORqqXfTK8etF+HJJspSyIHvmIz/F7oBUzJwx8wTTa4Kep7ul7+Xcq3cY2Lj9Iq6vZl+nadNrx8JQiKeH2xfDZCgd8DST6tyjLEcZPUdiH+ZChG5tT6kmANBT5abjRlKX6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qaf0MjIB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qaf0MjIB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757599066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mORohB//cLCd4rtYdHfeP7YUPc16H1gAtucQi7q3TOU=;
	b=Qaf0MjIBsXplEq8ygZaDZEakYlPlWmyKUeBjOqWHwEBo85/RwVa2yMjB7zXm6LISFKEHs+
	GQkAHF8oemmYQeRHSR6K/cmMvK8eYYNj3sT9CORCLXkOveASBP+WRm8RkqWHrfiJE8Tik/
	VKZEMqtE93fhqlV2GfbSk9iHHTBL0vI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-UZOTaPOBMjmAXJfAlbM4aQ-1; Thu,
 11 Sep 2025 09:57:44 -0400
X-MC-Unique: UZOTaPOBMjmAXJfAlbM4aQ-1
X-Mimecast-MFC-AGG-ID: UZOTaPOBMjmAXJfAlbM4aQ_1757599064
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C687B19107DB
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:57:43 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.31])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8929219560B1;
	Thu, 11 Sep 2025 13:57:42 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 08/20] gfs2: Sanitize gfs2_meta_check, gfs2_metatype_check, gfs2_io_error
Date: Thu, 11 Sep 2025 15:57:13 +0200
Message-ID: <20250911135726.657575-9-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: yqxgwU6HzywJ5nCusnDzgNHXjYvXAuJenV8O1aVJGfw_1757599064
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Change those functions to either return a useful value, or nothing at
all.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/util.c | 23 ++++++++---------------
 fs/gfs2/util.h | 34 +++++++++++++++++++---------------
 2 files changed, 27 insertions(+), 30 deletions(-)

diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index 020dd21ad51e..56412f63f3bb 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -471,13 +471,11 @@ void gfs2_consist_rgrpd_i(struct gfs2_rgrpd *rgd,
 
 /*
  * gfs2_meta_check_ii - Flag a magic number consistency error and withdraw
- * Returns: -1 if this call withdrew the machine,
- *          -2 if it was already withdrawn
  */
 
-int gfs2_meta_check_ii(struct gfs2_sbd *sdp, struct buffer_head *bh,
-		       const char *function, char *file,
-		       unsigned int line)
+void gfs2_meta_check_ii(struct gfs2_sbd *sdp, struct buffer_head *bh,
+			const char *function, char *file,
+			unsigned int line)
 {
 	gfs2_lm(sdp,
 		"fatal: invalid metadata block - "
@@ -486,18 +484,15 @@ int gfs2_meta_check_ii(struct gfs2_sbd *sdp, struct buffer_head *bh,
 		(unsigned long long)bh->b_blocknr,
 		function, file, line);
 	gfs2_withdraw(sdp);
-	return -1;
 }
 
 /*
  * gfs2_metatype_check_ii - Flag a metadata type consistency error and withdraw
- * Returns: -1 if this call withdrew the machine,
- *          -2 if it was already withdrawn
  */
 
-int gfs2_metatype_check_ii(struct gfs2_sbd *sdp, struct buffer_head *bh,
-			   u16 type, u16 t, const char *function,
-			   char *file, unsigned int line)
+void gfs2_metatype_check_ii(struct gfs2_sbd *sdp, struct buffer_head *bh,
+			    u16 type, u16 t, const char *function,
+			    char *file, unsigned int line)
 {
 	gfs2_lm(sdp,
 		"fatal: invalid metadata block - "
@@ -506,7 +501,6 @@ int gfs2_metatype_check_ii(struct gfs2_sbd *sdp, struct buffer_head *bh,
 		(unsigned long long)bh->b_blocknr, type, t,
 		function, file, line);
 	gfs2_withdraw(sdp);
-	return -1;
 }
 
 /*
@@ -515,15 +509,14 @@ int gfs2_metatype_check_ii(struct gfs2_sbd *sdp, struct buffer_head *bh,
  *          0 if it was already withdrawn
  */
 
-int gfs2_io_error_i(struct gfs2_sbd *sdp, const char *function, char *file,
-		    unsigned int line)
+void gfs2_io_error_i(struct gfs2_sbd *sdp, const char *function, char *file,
+		     unsigned int line)
 {
 	gfs2_lm(sdp,
 		"fatal: I/O error - "
 		"function = %s, file = %s, line = %u\n",
 		function, file, line);
 	gfs2_withdraw(sdp);
-	return -1;
 }
 
 /*
diff --git a/fs/gfs2/util.h b/fs/gfs2/util.h
index 2a8a1fac611a..da0373b1e82b 100644
--- a/fs/gfs2/util.h
+++ b/fs/gfs2/util.h
@@ -91,9 +91,9 @@ void gfs2_consist_rgrpd_i(struct gfs2_rgrpd *rgd,
 gfs2_consist_rgrpd_i((rgd), __func__, __FILE__, __LINE__)
 
 
-int gfs2_meta_check_ii(struct gfs2_sbd *sdp, struct buffer_head *bh,
-		       const char *function,
-		       char *file, unsigned int line);
+void gfs2_meta_check_ii(struct gfs2_sbd *sdp, struct buffer_head *bh,
+			const char *function,
+			char *file, unsigned int line);
 
 static inline int gfs2_meta_check(struct gfs2_sbd *sdp,
 				    struct buffer_head *bh)
@@ -108,10 +108,10 @@ static inline int gfs2_meta_check(struct gfs2_sbd *sdp,
 	return 0;
 }
 
-int gfs2_metatype_check_ii(struct gfs2_sbd *sdp, struct buffer_head *bh,
-			   u16 type, u16 t,
-			   const char *function,
-			   char *file, unsigned int line);
+void gfs2_metatype_check_ii(struct gfs2_sbd *sdp, struct buffer_head *bh,
+			    u16 type, u16 t,
+			    const char *function,
+			    char *file, unsigned int line);
 
 static inline int gfs2_metatype_check_i(struct gfs2_sbd *sdp,
 					struct buffer_head *bh,
@@ -122,12 +122,16 @@ static inline int gfs2_metatype_check_i(struct gfs2_sbd *sdp,
 	struct gfs2_meta_header *mh = (struct gfs2_meta_header *)bh->b_data;
 	u32 magic = be32_to_cpu(mh->mh_magic);
 	u16 t = be32_to_cpu(mh->mh_type);
-	if (unlikely(magic != GFS2_MAGIC))
-		return gfs2_meta_check_ii(sdp, bh, function,
-					  file, line);
-        if (unlikely(t != type))
-		return gfs2_metatype_check_ii(sdp, bh, type, t, function,
-					      file, line);
+	if (unlikely(magic != GFS2_MAGIC)) {
+		gfs2_meta_check_ii(sdp, bh, function,
+				   file, line);
+		return -EIO;
+	}
+        if (unlikely(t != type)) {
+		gfs2_metatype_check_ii(sdp, bh, type, t, function,
+				       file, line);
+		return -EIO;
+	}
 	return 0;
 }
 
@@ -144,8 +148,8 @@ static inline void gfs2_metatype_set(struct buffer_head *bh, u16 type,
 }
 
 
-int gfs2_io_error_i(struct gfs2_sbd *sdp, const char *function,
-		    char *file, unsigned int line);
+void gfs2_io_error_i(struct gfs2_sbd *sdp, const char *function,
+		     char *file, unsigned int line);
 
 int check_journal_clean(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
 		        bool verbose);
-- 
2.51.0


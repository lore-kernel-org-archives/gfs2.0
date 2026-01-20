Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8535426D3B
	for <gfs2@lists.linux.dev>; Tue, 20 Jan 2026 12:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768912437; cv=none; b=YKbnzzSgnULM90y3KLezgLhmuqFpcsDqNxUI/+BQ9P+rIbQdF2gX3BWbGDzUGPauTIg6PCsJ8aywZGHPhyEb/frkDY22C+jbUqOeDCcRUvUofadecujApiEtk7uxmuLulo0w0t5JIBXY5c9NKcJEZGggzqhBFgh1PBbP3mecA7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768912437; c=relaxed/simple;
	bh=vPU2V50o5jpPnvrbKJzOO+bcSFJqLPqe32WzSG2rqCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p6ftUoBCuZUm4b+BG2Rqn4WVzOpTFBuvaZHgGrd66J7ZzQ8zi244vu7vi90joQ2KFuzM+acYAr0lS+a1XJr3MdPESRqyIv1RWQ8epkKOaEoMfy8ByRYi2SugJ0PgMXwHUo5uf7O+X26kztGUwA4HIX7kt/bG5lAq4kSJ2LpOcGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzTJL6kR; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzTJL6kR"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b6fd5bec41so1167697eec.1
        for <gfs2@lists.linux.dev>; Tue, 20 Jan 2026 04:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768912435; x=1769517235; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TG6EI6RBrBqfcG1Qj/7XoK7r3FMDle9OXgLojBRhNAU=;
        b=NzTJL6kR0KHVUMbZPEu8OA0nqUXC1fLsu3HfnMGb4jsYHoGzAkBEZg3FtndXWw/6jd
         XICwpcH4MsZ23bcPtMlORygFGoeX1spc4YZvaw83eIVD1s7/HG76gV0pb1//Mkk9jbr/
         vx3Lf6XMeLnrXwugDSuA28YBJfMTqrh4fQXSrU9kXl8WUQrK0pxLMcEY5T+usM47G78+
         SUTi2EX1YlnaShqlu/Ukktbyj8xRYqzVYp6AZ5aDlSbdkZtqr9C78L132OdB/0ntHv5N
         YisYnQedHaQEtxfcvwv3PMuvhLVoO08j5Xn287jLrJlhGfq9HYzuRvzK6nhovMrduYsp
         YHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768912435; x=1769517235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TG6EI6RBrBqfcG1Qj/7XoK7r3FMDle9OXgLojBRhNAU=;
        b=NOQGmBNMAOIprtxxgkDrSOh1V+Mp++g6EI7U9qDYlAggDo1ghUY4u1+LE3o78uJumc
         qiAXtjWlk+qM/dVb0bX/2GemOzvvp7QdTyXKQ/8Ig+sIdH6OK0j78YghwNj+qiieW/xf
         emtq/vxHMJTZTHCpOAS1CxsooJ5dWeSySwTy4l4X06InG2yoUk+nSRlp+kHnauCXvXPe
         /+AhLRWicgbjex9uQguzQdCmcFDjrSgvpR8t200PqPvfV71tHper3phSL0P5LWihY2zt
         yU22UWwG+HNT6RThCrp+P8PCA7yTXoqoCEDgnOtFLaz64jsWrSqJeSRofJRKRjNk+kTv
         1Jtg==
X-Gm-Message-State: AOJu0YzYR5TdLdoQzKDwLxq/AG1mYI386y7jKBrdg16Bu2h2is8P3xig
	j04UweICrWzqAprC7VZ9e2l4NBJfKn1/YC595cuJRHn7OvQgTbbDfpWd
X-Gm-Gg: AZuq6aIoAHGCQ/ZudpcfMjEamVhpY9qFIA7seAX6lVbr3Psc6bThdNsTHUFdvjI+O+g
	p993v8ru/xfOcXVOORIQdDjtBYz/h8rYWFHsWjPSLNlJ+DoB8nGtbsIuHsZQXZ+gzpNuo8ADaTN
	UIdqE3ChnnfuZNhieDrFgisCxvRdthiP2RtHPNWnT5UHEllpg183nfPsMqx3BYCn9SKqTJ3ZnBH
	p+6IxtmjhaJnF4LbS/3L+K0rs9oYfljJVuqP4KJzKD6Y3HKrsYlTCwyUkizP9KaCw5q57pUSOkh
	9plc95+0FG15Am7ezaw1ZmGkrY7pMgc2KnFigEfj0lMDIBIwZywl+LJkPc6mddRGT28YBxAWNgm
	L39oYDkiwS1keloeXKVmisFDTmZLXhER2TB2GnHIS9qCgmP3J9NpNZdX9GZ2kPMoGWxFexvFJ6F
	blo26/J/anHJo=
X-Received: by 2002:a05:7301:678e:b0:2a4:3593:968d with SMTP id 5a478bee46e88-2b6b3f2ee49mr7293985eec.10.1768912434418;
        Tue, 20 Jan 2026 04:33:54 -0800 (PST)
Received: from fedora ([187.120.157.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b34c11dasm18676778eec.2.2026.01.20.04.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 04:33:53 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Subject: [RESEND PATCH] gfs2: do not evict glocks with populated address spaces
Date: Tue, 20 Jan 2026 09:33:39 -0300
Message-ID: <20260120123339.70724-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Metadata glocks may have associated address spaces used as caches. Avoid
reclaiming such glocks under memory pressure while their mappings are
still populated or their state is not unlocked, as this can lead to
invalid page cache state and GLOCK_BUG_ON().

Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
---
 fs/gfs2/glock.h | 30 ++++++++++++++++++++++++++++++
 fs/gfs2/super.c |  3 +++
 2 files changed, 33 insertions(+)

diff --git a/fs/gfs2/glock.h b/fs/gfs2/glock.h
index 55d5985f32a0..12f57461f687 100644
--- a/fs/gfs2/glock.h
+++ b/fs/gfs2/glock.h
@@ -305,4 +305,34 @@ static inline bool glock_needs_demote(struct gfs2_glock *gl)
 		test_bit(GLF_PENDING_DEMOTE, &gl->gl_flags));
 }
 
+/*
+ * gfs2_glock_not_evictable - check if a glock is not evictable
+ * @gl:	The glock to check
+ *
+ * Glocks which do not represent normal filesystem inodes (e.g. statfs, quota, rindex)
+ * may have associated address spaces used as metadata caches. These glocks must not
+ * be reclaimed under memory pressure while their mappings are still populated or their
+ * state is not unlocked.
+ */
+
+static inline bool gfs2_glock_not_evictable(struct gfs2_glock *gl)
+{
+	if (gl->gl_name.ln_type == LM_TYPE_INODE)
+		return false;
+
+	if (gl->gl_ops->go_flags & GLOF_ASPACE) {
+		struct gfs2_glock_aspace *gla;
+
+		gla = container_of(gl, struct gfs2_glock_aspace, glock);
+
+		if (!mapping_empty(&gla->mapping))
+			return true;
+	}
+
+	if (gl->gl_state != LM_ST_UNLOCKED)
+		return true;
+
+	return false;
+}
+
 #endif /* __GLOCK_DOT_H__ */
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index f6cd907b3ec6..86544cdafe53 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1164,6 +1164,9 @@ static int gfs2_show_options(struct seq_file *s, struct dentry *root)
 
 static void gfs2_glock_put_eventually(struct gfs2_glock *gl)
 {
+	if (gfs2_glock_not_evictable(gl))
+		return;
+
 	if (current->flags & PF_MEMALLOC)
 		gfs2_glock_put_async(gl);
 	else
-- 
2.34.1


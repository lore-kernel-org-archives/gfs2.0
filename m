Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FF33164D6
	for <gfs2@lists.linux.dev>; Tue,  3 Feb 2026 10:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770115246; cv=none; b=BW5gmPOvkMPY2dCKru6BiZHprMDvRbyXats7UB7H7zaoJ6A8vMlmO2uL7WRGdR/50zhJ1TyO4iegGOnlvprXgU/Ie+UqMAbEmhKPv+Dhm4+/ucuGfSmYb24bYDiEHnkiTv9vqGvEY1ACcKgmZPe9H+EN9Sw2KUiwimwFvnDJvCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770115246; c=relaxed/simple;
	bh=vPU2V50o5jpPnvrbKJzOO+bcSFJqLPqe32WzSG2rqCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CqZ6ZukuNurKoXp/xf6+cluaZ9DBa+JORJwHCWc9JcgntmfXMP2EgfaVOtPtsEJ4j8iKyuaUtQ5NfFwPOqmh1ulw/e0BZgbeMAieeGC27/KxURV6K9mK+mtvNWpmuZoAZfCJbzCwBOJY4vnRtlvwNgnNNgYu7qcSR7jKwcBNLU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bz9zjygH; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bz9zjygH"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-794d4f11a20so21948397b3.1
        for <gfs2@lists.linux.dev>; Tue, 03 Feb 2026 02:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770115244; x=1770720044; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TG6EI6RBrBqfcG1Qj/7XoK7r3FMDle9OXgLojBRhNAU=;
        b=bz9zjygHXEuN00r6PgAx1/nq6p39AYX4Gi7oZzG7AMWkNV5yc7lIYlHAXJZlm7qQ7h
         kMrPNNWiZTOQhj1uqBbYkYluiae2attdP4c72aZkp9IX7ID94q46f2oDPkl9/YWg+fHb
         aPxESPpKLjmQcsIeVb4i/dX4KFkTRRQDfn7ARWf0MwtfozvYOhMkaRrV3Jb069osHp3q
         u9TtRZ94SetKDxFzjtyEJbwlNWHaofQ3sC4Fu/n5WJ6siNmoLaILqAEgjHU07jgRebB4
         T/1EDm3tEFG2xJJ5HaIrvyXCRsCLbsraHCrHoWGHHHu+/BFvoim6nz7Wbp/nU7aOu9pl
         X8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770115244; x=1770720044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TG6EI6RBrBqfcG1Qj/7XoK7r3FMDle9OXgLojBRhNAU=;
        b=DlnPg+78xAbO0JGpY5VNHCeC+mbMlu12nCUs4pGmYi0iaGIq6jb0QMlJ3S2SneLblV
         BUt/BVnpd06f6NeSn1cIimf/fagKuY/I3ZCZEGBhpNa32jcMKus7niz6CTW4aq+PHlOB
         0dH4cFRJqK7i1ag2k7hhnCalPZ+IOqcuFylF9HW6t3dXQJGzoNmk6kpKE9gkcaPg+vZX
         AUG7+7CqJf5gFftkGgVhFHPwBc2lkQJpEkvOzWn0Ysfx68GDZorakbYhPbeYR+lEEIDu
         Rd0p9Jfr8h7tR5h6mvhOM8Hf+uxXYh05od4cljnf4Uk+EqBq9ZpmAtQPBXkHvnhUMpPd
         TZ1Q==
X-Gm-Message-State: AOJu0YwfyRcFsiYA4sQVcq4ybTgBImTPwwrEct3iFtmmTOfO3CSFGTlG
	hj4baZ+Hs5+T9ZUUdU57Cnmc+YDLYkkay1oWXg9YzplfEn1BE7QvQRME
X-Gm-Gg: AZuq6aKrdvGFLPdcfBEKtu35BoBiw2X0No3R/e54t0QWWnGyMAEJupgPYmaS1p/Xw0K
	D3WFgSnsUjS4K20p1g1Sz+z0HGVELUSQFgFlwhT/4rGnDvcR+T7TtMq6F4+OMwfqujPJ6BhRCvF
	wcWLy5ulL5N4dpo1iJb1MpIvow9ppMMFct8IYZztY0RX87QbXZXknwzrLSBRQNET45cmSrTwCZj
	GB1BOawngbQ9HF3kYMMiUfXymfjiGBe++DT7P01aFgOc1/XRcDeC7i/GR1bZshYtOrpJA/9NSuM
	aZzdgt15WTfV9RbpaRE7gpUHiH9Ex323Eoz6ZE/TSVuIK5P4gow3VPqezBg7ust0fK1nTg4k75L
	LiGFWakMRqFt+JqqZhnlOIiC4eQ93HLVcoOWJLGOW2+PxARe2IL8dXxQOrEQvAUt69D3NJ7BuIr
	aWnQUNjzyHCw==
X-Received: by 2002:a05:690c:2703:b0:794:bd20:ea1f with SMTP id 00721157ae682-794bd210154mr72796687b3.47.1770115243635;
        Tue, 03 Feb 2026 02:40:43 -0800 (PST)
Received: from fedora ([187.120.156.78])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794d4a54de7sm47138167b3.38.2026.02.03.02.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 02:40:43 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Subject: [RESEND PATCH] gfs2: do not evict glocks with populated address spaces
Date: Tue,  3 Feb 2026 07:39:41 -0300
Message-ID: <20260203103941.12918-1-trintaeoitogc@gmail.com>
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


Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C6B344D9B
	for <gfs2@lists.linux.dev>; Sun,  8 Feb 2026 22:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770588743; cv=none; b=SMsRH/RP3Gn2cQQ6B4cayPu465mlWXDVAqf2iPPrBwPJM3hCZk4hTVqRiTQ5UXfLPFiE5ZvyLIa8cPA7rM+8bzNv0u4s90t2ayi2m/wItmVtYvcvraDQc/JMcWpC+klGCb+dHSW/vY6jNkALpjDiwXeIPV/1CAEudG1y7+x9+3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770588743; c=relaxed/simple;
	bh=3434Rh+P7hIVnR5FrEbOerNrTX0TkzhDFEvO1sbJk9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HQwts0Jt7+j2+aFBfsIJ5fN7xyll67v2sQ5cndTEcvM7fSmTIJ2miGv2Xr+caMGttcDLUg9KJ8GRRWQC4b4xD+yveilhg1rOqnRjEwZfQW1HRXgrOSxq4cEOCYYIOinnYDGp+lV1tAwIEWzKF09DeDMEzXwquQFAVK15c7KW70k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amSUvS34; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amSUvS34"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-794911acb04so22119287b3.0
        for <gfs2@lists.linux.dev>; Sun, 08 Feb 2026 14:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770588742; x=1771193542; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5u7HvU/qv5ExBJjQqEceuf5F7enjLIIjfK/O6HizMHI=;
        b=amSUvS34lu1Wzq5HoK4g0Du4q2aa6gouM/yZAhG2/GHxiHypnNgr9QUt+prBtnzNyL
         gpPzJcFf/CeSsKS6VknAPlje6PMMR15l4y/s4glaJUUkNDN8S0GLyDLliEZs1rQF0D/w
         1dIOZR2nSf6d++YR6Ti0jm6HgyF1vVxD6HLFJbcYngSZ1WypaBUyCE0kBE9mHFV3aB8M
         u2OLp4vddJbUie9Ukju8mvQptWAWjw55WEPmtc6dbBTIAQtQkEeyvrhFZchMpZGtiJUw
         apY5URyiRvb5xNnboVBw7GuUbaR3x7wpLnSc/jPLOAEPi83zizj+FtgZDX/AQ7LO/LpE
         fONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770588742; x=1771193542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5u7HvU/qv5ExBJjQqEceuf5F7enjLIIjfK/O6HizMHI=;
        b=IFFmgNNJKVe9goEcFq3tqC3SnSkWc3+pB75o5a3Ram34gmmhlT29OBnH1VGOK9jbl9
         hxxPkbJKiON1xolLcbkZyxQ8S3xxJ/tykzRULddhbFOYYKvy6TDyFrGr5W/DqRDlBdwN
         woCvLJdf5B8BwZK3+Wpza4HhvnkmHLQh508mYmL9+0XqU1EsQ4x0lhX6G7cnc8MnNe+j
         GC9El8s+mXrzblIJvnWpWh98no2XrX2zRPhlPYu+Bn8pxJjeo5DiPgdxckrLydbd8nQV
         1ADJDOBzgvCwVJ3Xi4KqybfRJeSs5J9t7FGUvYo9CMXbz49qyx0N7jdD3r2aiChvJUkq
         +X2A==
X-Gm-Message-State: AOJu0YyNbtE63adu3Ca9mFM8L1QefmY4TArYf4X0jJnytbwfunh9YWRj
	3uF+2wtFBZk9tFQoqFf1uOxg3WeiUBmgQxaE4p4Ppx/TrI8p0ypyMKQF
X-Gm-Gg: AZuq6aLJSR7uo20hto9oUqcD7oVFP6PYHS7BV6Rl4K3WEOnztk0iPtpd3HwzFO2BJg8
	7gQMjbGvfujtkUFoAztn4jd0nR0PYmLLAV8MM1xv7TymrIuuMQbNlnzX8kgQ/zp0gb/4qpQajEp
	EVdVqYCkji7SF2dzY3NUxXaY9bkbLMKam1/izw9umnPTgIalnpH+n+5L0LksvvSYgwcHi8lIUb8
	35j013wbUM6+r7K5lbRnKhm1wgu5/7AdA3Y+Ec/+ni4cVM5Q8xt16OuxQfuO8I7aD6JMA3A5yJJ
	12ns5to8fiijwqGvPkPmeXr6OIZ9Kzv/vdlPRNx4bU1xrjVF4l2088lN74Ek8X36qmfwBJtNT5A
	+dTgeyAGTCwtvsDZOA6G492vo1OChYN6ZFhqKe4b0jiyLPK8GpuSZ7zKtUFovdT7LhSB+meZJoj
	Zbzo9zrJo7oDE4NhYEK+cpvlaIaOM=
X-Received: by 2002:a05:690c:fd1:b0:794:d639:375 with SMTP id 00721157ae682-7952aa49d4amr94286897b3.1.1770588741821;
        Sun, 08 Feb 2026 14:12:21 -0800 (PST)
Received: from anish-GV62VR-7RF.lan ([2603:6081:24f0:35f0:dbe3:27f9:6ac3:4647])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7952a28697fsm76164317b3.50.2026.02.08.14.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 14:12:21 -0800 (PST)
From: Anish Mulay <anishm7030@gmail.com>
To: aahringo@redhat.com,
	teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Anish Mulay <anishm7030@gmail.com>
Subject: [PATCH] fs: dlm: use sysfs_emit() instead of snprintf()
Date: Sun,  8 Feb 2026 17:12:15 -0500
Message-ID: <20260208221215.205864-1-anishm7030@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow the advice in Documentation/filesystems/sysfs.rst:
show() should only use sysfs_emit() or sysfs_emit_at() when formatting
the value to be returned to user space.

This patch replaces snprintf() with sysfs_emit() in the lockspace
show functions.

Signed-off-by: Anish Mulay <anishm7030@gmail.com>
---
 fs/dlm/lockspace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index ddaa76558706..23975bb394eb 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -69,7 +69,7 @@ static ssize_t dlm_event_store(struct dlm_ls *ls, const char *buf, size_t len)
 
 static ssize_t dlm_id_show(struct dlm_ls *ls, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%u\n", ls->ls_global_id);
+	return sysfs_emit(buf, "%u\n", ls->ls_global_id);
 }
 
 static ssize_t dlm_id_store(struct dlm_ls *ls, const char *buf, size_t len)
@@ -83,7 +83,7 @@ static ssize_t dlm_id_store(struct dlm_ls *ls, const char *buf, size_t len)
 
 static ssize_t dlm_nodir_show(struct dlm_ls *ls, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%u\n", dlm_no_directory(ls));
+	return sysfs_emit(buf, "%u\n", dlm_no_directory(ls));
 }
 
 static ssize_t dlm_nodir_store(struct dlm_ls *ls, const char *buf, size_t len)
@@ -101,12 +101,12 @@ static ssize_t dlm_nodir_store(struct dlm_ls *ls, const char *buf, size_t len)
 static ssize_t dlm_recover_status_show(struct dlm_ls *ls, char *buf)
 {
 	uint32_t status = dlm_recover_status(ls);
-	return snprintf(buf, PAGE_SIZE, "%x\n", status);
+	return sysfs_emit(buf, "%x\n", status);
 }
 
 static ssize_t dlm_recover_nodeid_show(struct dlm_ls *ls, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", ls->ls_recover_nodeid);
+	return sysfs_emit(buf, "%d\n", ls->ls_recover_nodeid);
 }
 
 struct dlm_attr {
-- 
2.43.0


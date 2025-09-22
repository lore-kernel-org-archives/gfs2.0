Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2383B253B52
	for <gfs2@lists.linux.dev>; Mon, 22 Sep 2025 17:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758563592; cv=none; b=boKphIK9CM96I/5grCrAh7gz8w5uzyAp7Bh+wH7TP+19aTkfbyeZpHfhE4fuybfc1LquzdJwy0c+Tje4AVU/RNFhfZJmXA08te8Z+o5xYM1BTyg3q4rDMpeaDZ/Hwc/VGUr9KjJomap45eh6G+6zQ17VSqwLmKxD9K2IVHM3jXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758563592; c=relaxed/simple;
	bh=W0IBqEn4vKCxJysl6LgMrpm5cVfjcQPQF0Y/qKrqeYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jjt5LfEs5wQ4rWKIY82IGKO8c0hv5DbNzea0KVo6KbwTzNhmFG2UJMlUYtp+SA1JwJs9XEfWTm6FUiz0c2l9eLUZ9lJGL+hczQF7r/aR275fRPjYuv9w+J26Ef2RFeP58UdZ5E2NixqU6QZrjDrTKDQvJE1SjQYw5vp69Zp4uNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCuX9WpE; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCuX9WpE"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77db1bcf4d3so3328583b3a.1
        for <gfs2@lists.linux.dev>; Mon, 22 Sep 2025 10:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758563590; x=1759168390; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1PW7jSTm6gj52V8YlRuR1GgS0xiUlm6k3Tk0zo1+DlE=;
        b=YCuX9WpEnYK47XCYWxIoLBANaShs602+aWu/+rE9WtNE7Wc4JjIKutKrT4Ar4N2Hx/
         OSgd+VeRvIPHryf/nkPF7eAv4F3z6cNnB+vidOgyoYZH10saBhjRKKueH/4B70xLWbNt
         H6GldHEcLV+6njuQ9gdvbs5b1JUIDmxBKxpt+sjUFKPQyvVZOez40Yzgz+5YO2L1yDDs
         uKQbOTputTqCmH186H3E+RP2Qm5fBOm6IEnCQ29VLhQ0Q8hzsZKwO6q8Z7r2yyghzvPc
         ueI1LNqcediF2TQYjInSA0bQWt7nmSk3y9y9jfLKo6l5Ncbv39OoIH/7zl3IRrA1cDkN
         cdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758563590; x=1759168390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1PW7jSTm6gj52V8YlRuR1GgS0xiUlm6k3Tk0zo1+DlE=;
        b=f2iXWGrjsOOph1SkNsjoAwLpKENHLZDLHLjFcHjcN06HGoKtCswU9WIQWqQB87JGMk
         SWm+2ZFy0DtulzSOMfJHKIEHLR4HBugGTW7NMSqlk40/lwVzr3/JrFQL5ZU/hyvfOrOY
         frxtfJKzJrI1YjzYA1DufCTAHW1z43pkKQXe7YMWJRANHWhZJxgmO6V38YiZtRSaMjBR
         uNMtkxj5d6ulEr8dyirpEudJXigU/9/7+U2tvmtBTBOCW3kY1xgwexSU1MBm9lCIfWJu
         rEf/yi71rnaCIZy4gZsZRLT9ch/oxhyF45i6G1lSQH2hKJaqKMAjquT+kRALa37MYGbC
         AOQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPgG0OW465/W5ZAHPLMiXTtJRg9BV1ijbCDn3ldYIjuH9EbUBgmk+kyPrQJnjxF6dtLZoI@lists.linux.dev
X-Gm-Message-State: AOJu0YzYuStCL6zrwu7iVjQ4qmv/8aZK6fA61Xc4Kx5dxav/f6KXPdIw
	uvokGMY00fUDsfb3vJhd2dfyYLBx9WXmi+R7L+AY0+6fPHV1fvFO08pj
X-Gm-Gg: ASbGncvLu5w2XSXtn1y2PIZ2/npfEx/l3b2LXRL3JJ+QIV8YBHAE0YuzDXUh0Dez9cO
	2G0eP/QHtLhY6j2qCYZCG+5D3zHWdSOXGuhWKc2J+Idyy5xrJxhxdh71s8tcSmOyrbEM4aN0UPq
	HVBeFc0LxBKNMGQRUXp80hImxfZ+KdEG1h22hyfUicLO9+aX3iKskJ83NDx0ZyCXxWLBRfai/7T
	YYZ7ApU6+w882yf2x1WQZpgZ3oEWuSJQcA37ifuYh+1W241bTgg2yQnxe5gfXxzwQpo4Ln0MCva
	ieCnuMfyEYgK3ajxvtu2j8ngsQV3HrSSNuXNBh6xXinGGHzfHLGBJMIjG9aGPUPSpdLkLQuiwxC
	ZBEu8m2Z1feCYFMP5ZOknxBh2Gh59iBQy8TyKHPA=
X-Google-Smtp-Source: AGHT+IHXcGCJS70xReRq+Wy3QVb3T8j7BoFqDnjWo5Uiys9rv583dMTnMXyGMLcS9mpOIkkI1dAQew==
X-Received: by 2002:aa7:8892:0:b0:771:fa65:ae6e with SMTP id d2e1a72fcca58-77e4e9b283fmr16807554b3a.17.1758563590323;
        Mon, 22 Sep 2025 10:53:10 -0700 (PDT)
Received: from itsmeut.. ([103.215.237.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f2c8aa554sm5040797b3a.34.2025.09.22.10.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 10:53:09 -0700 (PDT)
From: Utkarsh Singh <utkarsh.singh.em@gmail.com>
To: agruenba@redhat.com
Cc: Utkarsh Singh <utkarsh.singh.em@gmail.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	rpeterso@redhat.com,
	david.hunter.linux@gmail.com
Subject: [PATCH v2] gfs2/sysfs: Replace sprintf/snprintf with sysfs_emit()
Date: Mon, 22 Sep 2025 23:22:22 +0530
Message-ID: <20250922175237.37474-1-utkarsh.singh.em@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation/filesystems/sysfs.rst mentions that show() should only
use sysfs_emit() or sysfs_emit_at() when formatting values returned
to user space. This patch updates the GFS2 sysfs interface accordingly.

It replaces uses of sprintf() and snprintf() in all *_show() functions
with sysfs_emit() to align with current kernel sysfs API best practices.
It also updates the GFS2_SHOW_UINT macro to use sysfs_emit() instead
of snprintf().

Signed-off-by: Utkarsh Singh <utkarsh.singh.em@gmail.com>
---
 v1 --> v2: Code style cleanup and maintainer updates 
 
 fs/gfs2/sys.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index c3c8842920d2..487fff098465 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -59,7 +59,7 @@ static struct kset *gfs2_kset;
 
 static ssize_t id_show(struct gfs2_sbd *sdp, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%u:%u\n",
+	return sysfs_emit(buf, "%u:%u\n",
 			MAJOR(sdp->sd_vfs->s_dev), MINOR(sdp->sd_vfs->s_dev));
 }
 
@@ -68,7 +68,7 @@ static ssize_t status_show(struct gfs2_sbd *sdp, char *buf)
 	unsigned long f = sdp->sd_flags;
 	ssize_t s;
 
-	s = snprintf(buf, PAGE_SIZE,
+	s = sysfs_emit(buf,
 		     "Journal Checked:          %d\n"
 		     "Journal Live:             %d\n"
 		     "Journal ID:               %d\n"
@@ -140,7 +140,7 @@ static ssize_t status_show(struct gfs2_sbd *sdp, char *buf)
 
 static ssize_t fsname_show(struct gfs2_sbd *sdp, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s\n", sdp->sd_fsname);
+	return sysfs_emit(buf, "%s\n", sdp->sd_fsname);
 }
 
 static ssize_t uuid_show(struct gfs2_sbd *sdp, char *buf)
@@ -150,7 +150,7 @@ static ssize_t uuid_show(struct gfs2_sbd *sdp, char *buf)
 	buf[0] = '\0';
 	if (uuid_is_null(&s->s_uuid))
 		return 0;
-	return snprintf(buf, PAGE_SIZE, "%pUB\n", &s->s_uuid);
+	return sysfs_emit(buf, "%pUB\n", &s->s_uuid);
 }
 
 static ssize_t freeze_show(struct gfs2_sbd *sdp, char *buf)
@@ -158,7 +158,7 @@ static ssize_t freeze_show(struct gfs2_sbd *sdp, char *buf)
 	struct super_block *sb = sdp->sd_vfs;
 	int frozen = (sb->s_writers.frozen == SB_UNFROZEN) ? 0 : 1;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", frozen);
+	return sysfs_emit(buf, "%d\n", frozen);
 }
 
 static ssize_t freeze_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
@@ -194,7 +194,7 @@ static ssize_t freeze_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
 static ssize_t withdraw_show(struct gfs2_sbd *sdp, char *buf)
 {
 	unsigned int b = gfs2_withdrawing_or_withdrawn(sdp);
-	return snprintf(buf, PAGE_SIZE, "%u\n", b);
+	return sysfs_emit(buf, "%u\n", b);
 }
 
 static ssize_t withdraw_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
@@ -397,7 +397,7 @@ static struct kobj_type gfs2_ktype = {
 static ssize_t proto_name_show(struct gfs2_sbd *sdp, char *buf)
 {
 	const struct lm_lockops *ops = sdp->sd_lockstruct.ls_ops;
-	return sprintf(buf, "%s\n", ops->lm_proto_name);
+	return sysfs_emit(buf, "%s\n", ops->lm_proto_name);
 }
 
 static ssize_t block_show(struct gfs2_sbd *sdp, char *buf)
@@ -408,7 +408,7 @@ static ssize_t block_show(struct gfs2_sbd *sdp, char *buf)
 
 	if (test_bit(DFL_BLOCK_LOCKS, &ls->ls_recover_flags))
 		val = 1;
-	ret = sprintf(buf, "%d\n", val);
+	ret = sysfs_emit(buf, "%d\n", val);
 	return ret;
 }
 
@@ -437,7 +437,7 @@ static ssize_t wdack_show(struct gfs2_sbd *sdp, char *buf)
 {
 	int val = completion_done(&sdp->sd_wdack) ? 1 : 0;
 
-	return sprintf(buf, "%d\n", val);
+	return sysfs_emit(buf, "%d\n", val);
 }
 
 static ssize_t wdack_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
@@ -459,7 +459,7 @@ static ssize_t wdack_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
 static ssize_t lkfirst_show(struct gfs2_sbd *sdp, char *buf)
 {
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
-	return sprintf(buf, "%d\n", ls->ls_first);
+	return sysfs_emit(buf, "%d\n", ls->ls_first);
 }
 
 static ssize_t lkfirst_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
@@ -492,7 +492,7 @@ static ssize_t lkfirst_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
 static ssize_t first_done_show(struct gfs2_sbd *sdp, char *buf)
 {
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
-	return sprintf(buf, "%d\n", !!test_bit(DFL_FIRST_MOUNT_DONE, &ls->ls_recover_flags));
+	return sysfs_emit(buf, "%d\n", !!test_bit(DFL_FIRST_MOUNT_DONE, &ls->ls_recover_flags));
 }
 
 int gfs2_recover_set(struct gfs2_sbd *sdp, unsigned jid)
@@ -550,18 +550,18 @@ static ssize_t recover_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
 static ssize_t recover_done_show(struct gfs2_sbd *sdp, char *buf)
 {
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
-	return sprintf(buf, "%d\n", ls->ls_recover_jid_done);
+	return sysfs_emit(buf, "%d\n", ls->ls_recover_jid_done);
 }
 
 static ssize_t recover_status_show(struct gfs2_sbd *sdp, char *buf)
 {
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
-	return sprintf(buf, "%d\n", ls->ls_recover_jid_status);
+	return sysfs_emit(buf, "%d\n", ls->ls_recover_jid_status);
 }
 
 static ssize_t jid_show(struct gfs2_sbd *sdp, char *buf)
 {
-	return sprintf(buf, "%d\n", sdp->sd_lockstruct.ls_jid);
+	return sysfs_emit(buf, "%d\n", sdp->sd_lockstruct.ls_jid);
 }
 
 static ssize_t jid_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
@@ -626,7 +626,7 @@ static struct attribute *lock_module_attrs[] = {
 
 static ssize_t quota_scale_show(struct gfs2_sbd *sdp, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%u %u\n",
+	return sysfs_emit(buf, "%u %u\n",
 			sdp->sd_tune.gt_quota_scale_num,
 			sdp->sd_tune.gt_quota_scale_den);
 }
@@ -679,7 +679,7 @@ static struct gfs2_attr tune_attr_##name = __ATTR(name, 0644, show, store)
 #define TUNE_ATTR_2(name, store)                                              \
 static ssize_t name##_show(struct gfs2_sbd *sdp, char *buf)                   \
 {                                                                             \
-	return snprintf(buf, PAGE_SIZE, "%u\n", sdp->sd_tune.gt_##name);      \
+	return sysfs_emit(buf, "%u\n", sdp->sd_tune.gt_##name);               \
 }                                                                             \
 TUNE_ATTR_3(name, name##_show, store)
 
-- 
2.43.0


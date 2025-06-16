Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73D1295D8F;
	Mon, 16 Jun 2025 10:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750071401; cv=none; b=hU5FpjiCA+WCpEXnuM8BZ+SYJ/W91ehWLVltzG3gv74Q/M1TJKNsKZBwFG96saePSKOf97Tz9q/8ATX0V9r04Jhyw/UrbXe+K0sY9ooHKtztkF2zKslB7oygdp3t7Bsftdfijij5yhv8c9WlRrLWMh6a5tYLQWQ1woLtr02NCrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750071401; c=relaxed/simple;
	bh=CkOxFf7EE54QiWk3H3djGE1kHgl8sxStzqzBqhoUAzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=POEXpeGJVVjpXRADKolhZiIEBRJxevfm2KQv8OLpWdeNWl/ZkQv6HtYtJ49qM9nevOrcnToIeBk4nEJoZjSReDwfC5r0UppwqQ3GC+kCsgPQifDjin6y/wgQXL+NrAnBLrltJhvaQh6AOo2eTqshGNyQF39snXPw4WLtoEzC3W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpeT2GwD; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpeT2GwD"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-235e1d710d8so52254075ad.1;
        Mon, 16 Jun 2025 03:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750071397; x=1750676197; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BdDBWycVFIVV412Xw0TdxhPfgA72SVqwCO00BmRsjEc=;
        b=ZpeT2GwD/XDWEdmVPftY2tG2qEOrwo8ocg700C5Oe7FfAwGdCry3KcZW0GpyHMAtLc
         Ck0aluBz1XDy+ewNromacsunGThgTnPsP41lyor5NIACb8jnXVH/sZq4fV0RQswEPGKN
         GcxPWkrM2ytA+A2fZPz3SUIA9fNgo02EI/CFwMxF7CdtgVWHfKUM1OEiOdWev4fJqgB5
         P//hHJngCwpnohSDQsypZe8j8avfzBYfp/onxZwO12D6d/+QcRUO6yxVrOqDhaAOkKS8
         7/63RKPlhERbjbVIO9kKez3wjqbrI6VbA9dSx8PvXAmOztCjcZfGsJgHrZMktSHsDBGP
         PICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750071397; x=1750676197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BdDBWycVFIVV412Xw0TdxhPfgA72SVqwCO00BmRsjEc=;
        b=mKs+Ea0S+1IFGQyHK1D9inqnEbtLKpMTfla2lsyZKbOpL0PNIdtpICg808VUQZ6J0x
         oOoQ3c5DZFMbbmzDDloXPaCHmtUw9sgfqSa+NpqAgWe1BUA4ihFWX7psfdXXJ5oLXFyt
         oTk2hN51s53PyoOkEDYFmPA/rFcGOQ9c68k21Ops2sJnxIKb2xbMi5uZtImfsjo9LDr0
         H139s9BdCzmgGSEYTCvYQa3oAyz01pv6iHn718ZV1O7KvsdS4LgyrfnHmgW58xLQz5Mj
         +YBwRAuEOlyJzZMw6r1Q5E3D1stXO4zCnOSlUZzBEddCzv5e+B4K8l3CRW/ZzID4z29N
         3Qaw==
X-Forwarded-Encrypted: i=1; AJvYcCU4Yg3/s4N694LiBJ7KRgMyBbPzTguuBtrYCk7NHZiwO+Wx8rustsF72iieNORY+MYwJ9jjkGTAl2am+yIhRI/yFH2xq0A=@lists.linux.dev, AJvYcCUrMsqnZb0OnKZIarTOo4vXf+9KB7swATcSGPYclIXQ/byA6bYoo3e2V7uQxneiUGiskpTX@lists.linux.dev
X-Gm-Message-State: AOJu0YwciG+gn9kCL4/3LOaogBbVv80nIa3HM5bHiGBHzF23ppoNHajz
	+VUf4AZ9T9InqlfzJNuCx7Aj0TyJjORnBJ/gybDT1ZPsZq+5qug/s/VkSXBmJASn
X-Gm-Gg: ASbGncv0BDzBkVOePgDP+wDhRpZPlNwB5+9JbPDc3EzHSHBoo7IheQcA7fntTiB+vDz
	ZlWmo4/mCzQd0FhnUtCee6A8deAcu6n3cQBewSRvhQAr6vMUiOGhgvhQnnyj690PIhuMTmTRVuM
	6tt43pLiwDzGw3OdfkjJOQPOz50mUZIfw4Uesx/CDQ/UnSbC+MnwfuUX0uMuUay0Kx+ecyczKJi
	nXwC0Yqw6LmYsLbT+yaJX8B9ouUcF9t7oFeQYvadxZlmixG/4Ft0vK7+EtkdAYPL/qShbzIU1pW
	IYvT/lUeAF58bpvyjZLSfr6yV4VZAchzk6TxzsXJ7NU3tulgL4QkKN9BwgbSREFgRCTUFWTGJDa
	8Uqw70Z71in40xjI/TA==
X-Google-Smtp-Source: AGHT+IHbTcVdwxhdfcP798T6pP1VsYxzzYGaXdvIwkCmRvnp/SY1JJEv6fQ/wVRyxzqBhML+XIv4lg==
X-Received: by 2002:a17:902:ce81:b0:234:f1ac:c036 with SMTP id d9443c01a7336-2366b40b7c2mr115347415ad.50.1750071396733;
        Mon, 16 Jun 2025 03:56:36 -0700 (PDT)
Received: from manjaro.domain.name ([2401:4900:1c68:884c:5800:7324:c411:408d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deaaa15sm58456615ad.173.2025.06.16.03.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 03:56:36 -0700 (PDT)
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
To: agruenba@redhat.com
Cc: skhan@linuxfoundation.org,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: [PATCH] fs/gfs2: use scnprintf() in show functions
Date: Mon, 16 Jun 2025 16:26:26 +0530
Message-ID: <20250616105626.372040-1-pranav.tyagi03@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace all snprintf() instances with scnprintf(). snprintf() returns
the number of bytes that would have been written had there been enough
space. For sysfs attributes, snprintf() should not be used with the
show() method. Instead use scnprintf() which returns the number of bytes
actually written.

Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
---
 fs/gfs2/sys.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index c3c8842920d2..25c1d71359ed 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -59,7 +59,7 @@ static struct kset *gfs2_kset;
 
 static ssize_t id_show(struct gfs2_sbd *sdp, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%u:%u\n",
+	return scnprintf(buf, PAGE_SIZE, "%u:%u\n",
 			MAJOR(sdp->sd_vfs->s_dev), MINOR(sdp->sd_vfs->s_dev));
 }
 
@@ -68,7 +68,7 @@ static ssize_t status_show(struct gfs2_sbd *sdp, char *buf)
 	unsigned long f = sdp->sd_flags;
 	ssize_t s;
 
-	s = snprintf(buf, PAGE_SIZE,
+	s = scnprintf(buf, PAGE_SIZE,
 		     "Journal Checked:          %d\n"
 		     "Journal Live:             %d\n"
 		     "Journal ID:               %d\n"
@@ -140,7 +140,7 @@ static ssize_t status_show(struct gfs2_sbd *sdp, char *buf)
 
 static ssize_t fsname_show(struct gfs2_sbd *sdp, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s\n", sdp->sd_fsname);
+	return scnprintf(buf, PAGE_SIZE, "%s\n", sdp->sd_fsname);
 }
 
 static ssize_t uuid_show(struct gfs2_sbd *sdp, char *buf)
@@ -150,7 +150,7 @@ static ssize_t uuid_show(struct gfs2_sbd *sdp, char *buf)
 	buf[0] = '\0';
 	if (uuid_is_null(&s->s_uuid))
 		return 0;
-	return snprintf(buf, PAGE_SIZE, "%pUB\n", &s->s_uuid);
+	return scnprintf(buf, PAGE_SIZE, "%pUB\n", &s->s_uuid);
 }
 
 static ssize_t freeze_show(struct gfs2_sbd *sdp, char *buf)
@@ -158,7 +158,7 @@ static ssize_t freeze_show(struct gfs2_sbd *sdp, char *buf)
 	struct super_block *sb = sdp->sd_vfs;
 	int frozen = (sb->s_writers.frozen == SB_UNFROZEN) ? 0 : 1;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", frozen);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", frozen);
 }
 
 static ssize_t freeze_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
@@ -194,7 +194,7 @@ static ssize_t freeze_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
 static ssize_t withdraw_show(struct gfs2_sbd *sdp, char *buf)
 {
 	unsigned int b = gfs2_withdrawing_or_withdrawn(sdp);
-	return snprintf(buf, PAGE_SIZE, "%u\n", b);
+	return scnprintf(buf, PAGE_SIZE, "%u\n", b);
 }
 
 static ssize_t withdraw_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
@@ -626,7 +626,7 @@ static struct attribute *lock_module_attrs[] = {
 
 static ssize_t quota_scale_show(struct gfs2_sbd *sdp, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%u %u\n",
+	return scnprintf(buf, PAGE_SIZE, "%u %u\n",
 			sdp->sd_tune.gt_quota_scale_num,
 			sdp->sd_tune.gt_quota_scale_den);
 }
@@ -679,7 +679,7 @@ static struct gfs2_attr tune_attr_##name = __ATTR(name, 0644, show, store)
 #define TUNE_ATTR_2(name, store)                                              \
 static ssize_t name##_show(struct gfs2_sbd *sdp, char *buf)                   \
 {                                                                             \
-	return snprintf(buf, PAGE_SIZE, "%u\n", sdp->sd_tune.gt_##name);      \
+	return scnprintf(buf, PAGE_SIZE, "%u\n", sdp->sd_tune.gt_##name);     \
 }                                                                             \
 TUNE_ATTR_3(name, name##_show, store)
 
-- 
2.49.0


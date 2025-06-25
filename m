Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2DB2BDC00
	for <gfs2@lists.linux.dev>; Wed, 25 Jun 2025 22:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750889753; cv=none; b=KkK9C46btnB2iXngT2CK/laYb8+wCfrWevlGPoCV2lcifF7HSRzUDq3SekyKahLqjAtuTyzmW8pSn7j+HMIGkwCjR9LNJIztvZY5s5ljTfuQOfQPYsGzbrHEzwFE0I9FsonGKD7aYRY31HGO0oNbj3jEAVK47GlSWmAmqhyuE/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750889753; c=relaxed/simple;
	bh=ylUWsqBdv7tvsvdpMfdW9ujSAH2BGmfxAz/cPhecY5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Th1ZmsrnyDnhMxcdmm7uDMBwFQ2gvHK8rZP3A0dGtEtkJGccGIP6/uQOJ02GbQJCWoMTj/VwYLmaE22+piHRyxkdqKPH5qccHmKjpPI1MQq+45qDlz/CC+jHXZGL9srQUz7fpjxUngZNNsN3OYLXKYPZY4901yUZagiabI+KewU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQUsgw2d; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQUsgw2d"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23636167afeso4355015ad.3
        for <gfs2@lists.linux.dev>; Wed, 25 Jun 2025 15:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750889751; x=1751494551; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i1/PgKpNQEL4CZ/x5npolCmb2YPYwo+H2VVcT6JHico=;
        b=bQUsgw2dKlDIY7AWTR2OJp9+NNiIVSAX4TtHWSIgJ50Pb/2nKUD/D5tdvwWFitzdPM
         IIXbYkG5SMM0owXJWnFqWTX+XsVocY0mzuRRc865nkyFBQcAg4/tmkEL2c6wIw0L9UWH
         KWthoj5dGIk6hjJf3fyRIV2pEVvhO1ibLM/VGcxjt6wLMkpbFbYrBJDPlby3tNGSM4B0
         K98kzYEIkaVKEcMpQVMvDSCymUECMEw2LYcQcyEaZ1XqpTfJhGgnXnmJ/vV/gzl/JICm
         Lb2cGDp6uax+dcDflxHH0W2b5pH/XuxRCdm25SVYLuziL61Z+P1aSIBq2FQhOiqGtxZH
         geIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750889751; x=1751494551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i1/PgKpNQEL4CZ/x5npolCmb2YPYwo+H2VVcT6JHico=;
        b=NwFeM5ArO4tw9ukPPt4sV2TF6mwk+NpoicRPB5xRrYx5PC33553u1iXfgWsmhqY+Sl
         CLgpPbAT4x3iBBxShAaN9mwHl/2hVzKwrElxZb1Nu8pygBb2duJRq4umUzi44zXOsFfC
         vunualuriYfNO2RB8yshSFS9Z0NV1xJuq6jr9fpVLV+f9rbYxE0DTRRnwZRyu48HvGhZ
         rlDvbFm9FPSjropxGXPS19DofLapLduZncHws8kwFO1gjcvjCDhZELQw0qiKwJNr5/Fw
         ROJR7zu+/JU2rrNfH7Kq/SX+e+vB5UPdF7YLDNazkKeqyHr/4pogXQDLj4PPnMxm7p9i
         4SXg==
X-Gm-Message-State: AOJu0Yz+SrQla07AUc9wiZkpfUijJCObCNPmZg85gzz33GS0uAdN/0bJ
	f6HZJqdb5PyItC2qsNXdrxZ7hPrzxntf1LPKqmk7JIei7w967wKlbzPkoWa2xQ==
X-Gm-Gg: ASbGnctNncCgVMJd0y9OnxILUV9AWqAa6hBBjPY2CSwxmscwseGyKn+tpiaTawuQ7q3
	POpb1sJ23hy+EiDdii+7PJ5UBGNW3sRKRHjaKCkj8s0K8rJeMBzbkzZXqMdxx06/F/vZLPZP5zm
	w07/sPnwbXxonB9e8zs9rvi58/VdO1sor7wx27I78lMIFsCR7ev3m35KJNtlOVhrq++xQbyoa1S
	77LTEiMp4InBIHc+5c6H8kWnvL4FGsTC9CpeoNQwDrI09vDBQD4FBNc0CjXj+HZrvYojuXQushP
	wIoLQ7ivUqMJ46atjftLdjzt3BbaOcYL6ZT8BtIuJkQxNXYGfTO9xpCFcfZ3CQ0eskWVG5HO3V/
	8tH0=
X-Google-Smtp-Source: AGHT+IF447eXoeCPMZ9fSborn0oc0o77ApQohY3vn62RRe/f5MId9QjXnzTMTAtUShcwzCs4rGS+mw==
X-Received: by 2002:a17:902:f684:b0:235:60e:3704 with SMTP id d9443c01a7336-23823fc3f99mr87140675ad.12.1750889751418;
        Wed, 25 Jun 2025 15:15:51 -0700 (PDT)
Received: from itsmeut.. ([103.215.237.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237f7579cddsm84397535ad.202.2025.06.25.15.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 15:15:50 -0700 (PDT)
From: Utkarsh Singh <utkarsh.singh.em@gmail.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Utkarsh Singh <utkarsh.singh.em@gmail.com>
Subject: [PATCH] gfs2/sysfs: Replace sprintf/snprintf with sysfs_emit()
Date: Thu, 26 Jun 2025 03:41:38 +0530
Message-Id: <20250625221137.108313-1-utkarsh.singh.em@gmail.com>
X-Mailer: git-send-email 2.34.1
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
 fs/gfs2/sys.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index c3c8842920d2..77bd35b2f594 100644
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
+	return sysfs_emit(buf, "%u\n", sdp->sd_tune.gt_##name);      \
 }                                                                             \
 TUNE_ATTR_3(name, name##_show, store)
 
-- 
2.34.1


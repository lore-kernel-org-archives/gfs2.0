Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C35327CB02;
	Mon, 16 Jun 2025 10:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750070092; cv=none; b=t6H7BUcmWIN+bCHLNaY3J1vNxxhnGkX5/t5tf+6zV/nXnX+0/1RrPJU+gpcM9AhiVzU1A6wV6903jwsCcadUfv3FW1CUjmIiQ+W8q+sbADrNPhN2l/gwSR63EXJ8zM6g27w5pUNUrdKWS7C1QC+IC+Q6RQ+UB8jPO0Lm0uu02ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750070092; c=relaxed/simple;
	bh=QJj6d/XvkwafLouwkZN2Bs7P9fFv23Sw+aXRuAkxI6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JQY6ZuJxRrl+pozhJB9WGbCNwMPBRqe6UkzfgoK+ZTet1uJgM5S6hQEx5ARyU3Kvz+IJ4xYrxAp2dLmAlVBvYaN1tKMO5hpYvUdlZzWEhEJKQCEPUrcqikriT9CLs0dDsehkFF3JS1aOPOuoHvpvpO2KsAqTEaEfMUx2vXshEkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bis/YFTT; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bis/YFTT"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-312116d75a6so3662218a91.3;
        Mon, 16 Jun 2025 03:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750070090; x=1750674890; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AgVtK53u/8CO0Tn5cqq/MjJJhd4l/AhPN3dvjhANa6o=;
        b=bis/YFTTrSvTRImn8rBp6qZTOoJZ2HKPsM+SF8oBKnboDVeUFxKM7g2xDsbBUvGOUP
         zUHafqOaY4TSJG5Aqb4N9lPxd5dxn4NT3xerwlN4Agsqpz9xnHpZP5+1SGBfWLpBzdnQ
         XHml/Zj4JHCBZesxMaSC0vLYuPsHIkTxVDQLVzAOUEVNKbvD94QHFAjltbLlEbzR5bok
         K98fCG3KvSyCHI/MYtJx9+MUbCAFKHoCuquQlUQnvC+0jWm5yZW66UK//Vexjxv+GFtk
         IqtjrGbOzgTBp7ZXoJLynUxdn0Zdve/Urkaq21wMPdul7SWD0CbZGQacWGXIXtqjCDVm
         yPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750070090; x=1750674890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AgVtK53u/8CO0Tn5cqq/MjJJhd4l/AhPN3dvjhANa6o=;
        b=gSepJhkpnBxGOYbw3JL7MKWlxaJO4J1jSbjtC/580TTss05PO+0ntjtqIjVyRUegvk
         N5pezGLXyEThYMKO2w01srDrAh8Bd2YOJk+MlbMiSgpGO0/niUbe9/KJ7fvAl4xN/M0h
         +2cCkQDFzIhVWFiqWno7qEw0YpqOXt7SAT9iSSO27Y8uDJwux9Kl1g50Tcp80/OT/3Ta
         ySFVA1WxvKH9ChesiSo5CLcPexpjZzp53sQhGfKhOC/9GnAKhdFLbGq3aPmRGd7mrSk1
         F5XqBYEwTDyhLMPtye0LbfTzN8pnhfgD8su18S+MU4ziHqURtOWspJ/NkCNwGe01sA1q
         /Rkg==
X-Forwarded-Encrypted: i=1; AJvYcCVOVefRUUsDIRvRSKad+Biq/SAjHGpYle6gsU+EEwFT/b2qO4+IaMka/aDTVkxRXX81ioz3qMCeQOqA4irFt7fbTdflNgI=@lists.linux.dev, AJvYcCXqmt8IvGwIPjfYyOfatAHUCVJ8/iJyiUWtByMex5VnjafaQ0lTWDn570ocJZx+jHwzteSv@lists.linux.dev
X-Gm-Message-State: AOJu0Yxn7o3UiokZfqOUViXvqe87oGmjgqjI1q1xlHoyMNAp1OPzyLxK
	wzOn1gMt4+j9kOB1UYw3EULUVet9+ziLmNpk9TGFwmaDLMJGDmZj303H
X-Gm-Gg: ASbGncuXyHTXBx2UD51LnyyKbJSBTmfn9mUtQoEQrbQiqHNR4MO2rjDk6mTcmb9+ShN
	w1rp/IEzbrUXPitQh35pM7VWWnGtrJ6Fju/mPm8YtDcO6ZakHbvcPNln11MsjGYUNGdn7SDLc7x
	gX7MmX73rJSzo0kV3KE1Um1K7k2fx5L3leI/Nt0W4H6rpoK3hNeG2W4G1WrwfCzrq7mbuybybeA
	f8OAXhLFwpRsr/HxzAwlJC5wtkAxPtljNvo7U9howPm96FHiIiFVk1cO7+4MSlqGCfKT/DSF1Bm
	bL3Y5Blt0TRtMeLhsOSQJ7KAbpwZPs5dXFZlU4dkLH0q6ciom+7lEtnHUuInKbaXcuELd/ifzp7
	n90gGPH4=
X-Google-Smtp-Source: AGHT+IG6h26aE1WGfwOudTzmIlkH9EQXeChWHEfk86k4KgPgaSC22agFnSLV5tt1WNAmJ6x9w5NMnA==
X-Received: by 2002:a17:90b:4d8c:b0:313:1c7b:fc62 with SMTP id 98e67ed59e1d1-313f1d589b3mr11053333a91.22.1750070089588;
        Mon, 16 Jun 2025 03:34:49 -0700 (PDT)
Received: from manjaro.domain.name ([2401:4900:1c68:884c:5800:7324:c411:408d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365decaf4csm57628215ad.218.2025.06.16.03.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 03:34:49 -0700 (PDT)
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
To: aahringo@redhat.com,
	teigland@redhat.com
Cc: skhan@linuxfoundation.org,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: [PATCH] fs/dlm: use scnprintf() in lockspace show funcs
Date: Mon, 16 Jun 2025 16:04:41 +0530
Message-ID: <20250616103441.370330-1-pranav.tyagi03@gmail.com>
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
space. For sysfs attributes, snprintf() should not be used for the
show() method. Instead use scnprintf() which returns the number of
bytes actually written.

Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
---
 fs/dlm/config.c    | 2 +-
 fs/dlm/lockspace.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/dlm/config.c b/fs/dlm/config.c
index a23fd524a6ee..10486a46a540 100644
--- a/fs/dlm/config.c
+++ b/fs/dlm/config.c
@@ -185,7 +185,7 @@ static ssize_t cluster_##name##_store(struct config_item *item, \
 }                                                                             \
 static ssize_t cluster_##name##_show(struct config_item *item, char *buf)     \
 {                                                                             \
-	return snprintf(buf, PAGE_SIZE, "%u\n", dlm_config.ci_##name);        \
+	return scnprintf(buf, PAGE_SIZE, "%u\n", dlm_config.ci_##name);       \
 }                                                                             \
 CONFIGFS_ATTR(cluster_, name);
 
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 1929327ffbe1..2e83e381e54c 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -69,7 +69,7 @@ static ssize_t dlm_event_store(struct dlm_ls *ls, const char *buf, size_t len)
 
 static ssize_t dlm_id_show(struct dlm_ls *ls, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%u\n", ls->ls_global_id);
+	return scnprintf(buf, PAGE_SIZE, "%u\n", ls->ls_global_id);
 }
 
 static ssize_t dlm_id_store(struct dlm_ls *ls, const char *buf, size_t len)
@@ -83,7 +83,7 @@ static ssize_t dlm_id_store(struct dlm_ls *ls, const char *buf, size_t len)
 
 static ssize_t dlm_nodir_show(struct dlm_ls *ls, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%u\n", dlm_no_directory(ls));
+	return scnprintf(buf, PAGE_SIZE, "%u\n", dlm_no_directory(ls));
 }
 
 static ssize_t dlm_nodir_store(struct dlm_ls *ls, const char *buf, size_t len)
@@ -101,12 +101,12 @@ static ssize_t dlm_nodir_store(struct dlm_ls *ls, const char *buf, size_t len)
 static ssize_t dlm_recover_status_show(struct dlm_ls *ls, char *buf)
 {
 	uint32_t status = dlm_recover_status(ls);
-	return snprintf(buf, PAGE_SIZE, "%x\n", status);
+	return scnprintf(buf, PAGE_SIZE, "%x\n", status);
 }
 
 static ssize_t dlm_recover_nodeid_show(struct dlm_ls *ls, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", ls->ls_recover_nodeid);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", ls->ls_recover_nodeid);
 }
 
 struct dlm_attr {
-- 
2.49.0


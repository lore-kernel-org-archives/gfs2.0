Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F172F5C603
	for <gfs2@lists.linux.dev>; Mon, 17 Feb 2025 04:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739765446; cv=none; b=JHSn3NVUyYTSQLN7SYG8Ovs70k2bjF4kpH0Lag5QUVrfz/ky0OiE7cLCo2PYMtN8LlxPxcZR12B0gN5+K4E7dH8VAKLwk614jfLi8FmVFNQt8xRNrsmweOQ8u+ZwYu9XprSnStX/yiM7RM1jD5P59HbyCnBSO/txfUtB2WveehQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739765446; c=relaxed/simple;
	bh=UMaPutujyDAb5iBHrtFh/y1qI9ktfsOe/ZHf+S5XvWU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bFqoYzTB+Y2vbhI00gp+3OslElnHc/IX2oc38xOl+SjbivBBUFxuy44wMQE8mwipQHIJZzezL6aHZ3hbEGcncw1y2LoJ5PuwLBx7hxFAdTRfQHiNvd4XUAl1EdKSEav/jGuidHJivCM8KjTiMBuICkdphVBigb0ZZs5OJ2HE/K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b=l4xm1Z6j; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b="l4xm1Z6j"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5deb1266031so6849454a12.2
        for <gfs2@lists.linux.dev>; Sun, 16 Feb 2025 20:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.com; s=cloud; t=1739765442; x=1740370242; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dRvN5rcy5TnvgoMdGp5N5UOA9EEdQFnO93KkfqoEeas=;
        b=l4xm1Z6jYKRRY0+NqzB2jRvK2HKZ3OA5xgWBSsjzY/NChrIweM3hOHdUr3u4JcoFkv
         KxriU5A2bq/t5pjbN8MTlFFrV7+nsnHMXaQzwfVesf5cMlo4Ezf8ZA4UcT3bR9jWpeAF
         DRnbmjEI8RvI9W3AZKvV0h+bzFX9I2vOSOfEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739765442; x=1740370242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dRvN5rcy5TnvgoMdGp5N5UOA9EEdQFnO93KkfqoEeas=;
        b=Yb/WheJAtVSxnFeXWuV755h8T0xCVjne1sIWdwN/9Pf6ViXuD6rEQzWBPXsPj4nptn
         st/2numvvoInDhql0V0gDKJk5cF8klsnXvAD6gcl2XuFzeqFVwrKfOwDBTci/KpwA8td
         LPNrBKl9aPY7Q4A68aqkjmoJBCoeB23ov6506qEBHyejT2wjAFRu1S0u7s4bXA/dFtd3
         yshl9nWPmCw4vvsCrViaubHXnPcv+l+em0qJ+Zol2GstZ8GTGwJ+lRqGDnDta8Js14B1
         jFmbuk2p3ZwX9TSSwWhome784yC/TzH5e+p/5MAaWq/efDRhLtISA3MXnu4uxO7AviRf
         Xf3g==
X-Forwarded-Encrypted: i=1; AJvYcCXaNAKuCAmD5c8UUNkSp2MtKTXFZP23unLYz4gM8Vi/DWFDz9CJjR8ms7uEnCxjsM4Zn8RQ@lists.linux.dev
X-Gm-Message-State: AOJu0YzpOPj01BPUGZoH9nhXOe5PHf4Og/14NW3+a0e3It8uttbreqn8
	IEj2NY1nixwzkifBaEM/jW1MEok5UiF25gq+r8VCdN6Y990AyfTOd+at7ErPiVY=
X-Gm-Gg: ASbGncvQpRH1mH1VePj9omYBvUy0/Cmf6mUmtUzRvLOlrxCvxjH1fbwjp9qs7UgWYrZ
	l2Qd6N3bzc5dmcsVkH7/vGIIUbnUL9dRdsFpusESnREHsN5hMXzVrZeExL5mHGSims6wedWhmyh
	TikRano+8xpN/bZFZSFjiDOI4ocqo4EPBJRW44Ny5BdOUKPaMaXJjw0/vKnqfNTdEMW/3aynhUk
	raN2QU2HVBpuxXozzEi4DetBo7sn1jHPIUZkIZM5EgytbK0nwiJ8EGXgCLpar2Mtu9yOMc1xoRs
	8SSB0aL8xZHnhCrRkfW4IHM1BFd0G1X5F5ljIQ==
X-Google-Smtp-Source: AGHT+IHm7++UNqdBg3vPTO6BkdFxFWkmL9pUr6s+bIqZbUxLLtHl3aNQD6l/pvdhcBzz+HJg2ZYzPA==
X-Received: by 2002:a17:907:1c21:b0:ab7:faca:a323 with SMTP id a640c23a62f3a-abb70d677c5mr829487166b.39.1739765442288;
        Sun, 16 Feb 2025 20:10:42 -0800 (PST)
Received: from localhost.localdomain ([154.91.3.20])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb91e9d96bsm209201266b.122.2025.02.16.20.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 20:10:41 -0800 (PST)
From: Chunjie Zhu <chunjie.zhu@cloud.com>
To: Bob Peterson <rpeterso@redhat.com>,
	Andreas Gruenbacher <agruenba@redhat.com>
Cc: Chunjie Zhu <chunjie.zhu@cloud.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fix gfs2 umount timeout bug
Date: Mon, 17 Feb 2025 04:09:27 +0000
Message-Id: <20250217040928.34561-1-chunjie.zhu@cloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

  If there are heavy lock contenions between nodes in a cluster, at
  fs umount time,

          node 1                           node 2
            |                                |
	    |                                |
     iopen glock lock    -->       iopen glock go_callback
            |                                |
	    |                                |
         EAGAIN                       try evict failure
	    |                                |
	    |                                |
       DLM_ECANCEL                           |
            |                                |
	    |                                |
      glock complete                         |
            |                                |
	    |                                |
    umount(clear_glock)                      |
            |                                |
	    |                                |
 cannot free iopen glock                     |
            |                                |
	    |                                |
    umount timeout (*)                       |
            |                                |
	    |                                |
      umount complete                        |
                                             |
                                             |
				       umount succeed

Signed-off-by: Chunjie Zhu <chunjie.zhu@cloud.com>
---
 fs/gfs2/glock.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 4a280be229a6..bf2445f0afa9 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2120,6 +2120,23 @@ static void thaw_glock(struct gfs2_glock *gl)
 	gfs2_glock_queue_work(gl, 0);
 }
 
+/**
+ * IOPEN glock might be a zombie glock instance due to lock contention
+ * between nodes in the cluster during fs umount, then it causes umount
+ * timeout
+ */
+
+static int is_zombie_glock(struct gfs2_glock *gl)
+{
+	if (test_bit(GLF_LOCK, &gl->gl_flags) &&
+		test_bit(GLF_DEMOTE, &gl->gl_flags) &&
+		test_bit(GLF_BLOCKING, &gl->gl_flags) &&
+		(gl->gl_name.ln_type == LM_TYPE_IOPEN) &&
+		list_empty(&gl->gl_holders))
+		return 1;
+	return 0;
+}
+
 /**
  * clear_glock - look at a glock and see if we can free it from glock cache
  * @gl: the glock to look at
@@ -2132,7 +2149,8 @@ static void clear_glock(struct gfs2_glock *gl)
 
 	spin_lock(&gl->gl_lockref.lock);
 	if (!__lockref_is_dead(&gl->gl_lockref)) {
-		gl->gl_lockref.count++;
+		if (!is_zombie_glock(gl))
+			gl->gl_lockref.count++;
 		if (gl->gl_state != LM_ST_UNLOCKED)
 			handle_callback(gl, LM_ST_UNLOCKED, 0, false);
 		__gfs2_glock_queue_work(gl, 0);
-- 
2.34.1


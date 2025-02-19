Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B63F8BE8
	for <gfs2@lists.linux.dev>; Wed, 19 Feb 2025 02:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739932321; cv=none; b=h3Ygfs9LD2+PAI3wSkPCiNOvmHx4OGV7k9QDlqsUes71dGTM7ROkjPxLuCHf1api8/VE0dVUAgLkslPG/UKfWV9vmBsgz/kTRuptYmWefTrcdGm0vVrSo+XxrzQGyS7jVYFX2nyaGI/uLSylcwDpaGspjW/2kHJZdg4BgUAZg1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739932321; c=relaxed/simple;
	bh=vtNCEh2s4yfr7oWGmkL/KiyGBmJ7liD0fOsxJY8sIXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WMk/sQ++P/qUJ3fR6CtUHV8ze78aneGDB2PgDSkvAIw7G4X2xZqUDGkfbF7L8sX619ZLzxpqmifXM5Kl5xMcAlYgoFh6ojgTOojnLY4StKvGKiWz646oqsid3hyeHkzbPukKRPDoqbLg/VlheDGlKv041K+FdE9bJaT8ymgieVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b=PkdivrFT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b="PkdivrFT"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220f048c038so80189815ad.2
        for <gfs2@lists.linux.dev>; Tue, 18 Feb 2025 18:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.com; s=cloud; t=1739932319; x=1740537119; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMbzBLa4cAlmfPQi7VUGkd1l2tBGQkhyu/SotgYTeck=;
        b=PkdivrFTv+jRo5C7eBdtV6ZUnBxjibP1+Hi9dkDyvtiTO313BX7PovbAF+wsxoCTjg
         3HEly7gzipjghqhHQTR6nlAV26h9RPqnaCkgapXh6gY12dB2sdOBd22TLIiAcvnxExV9
         Lq8x6uNivh6dDp75DvEHLpyJsnM2yXHLgTcFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739932319; x=1740537119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMbzBLa4cAlmfPQi7VUGkd1l2tBGQkhyu/SotgYTeck=;
        b=spVlCbi8HYLJ/rprIpzF9yyRUPi1IzneAuRIPV4HatglUg4zv1YXMP+bZDBNXXnQxl
         FJlKcfVN/6yOufyOoRQBKRv9NFMNPEVeL6JRsonCdSuDT15SNurjXy8O1mlS1cvemom5
         JORNdvQ9rkdzCLZymBwVAX95qMVyceDL/WznLtJCvSEMVfsdule9w0EcALaJUP6F1rrf
         2hCodeWG+xfh73YSlTSYwj5T6iU/i9PYy3DQMOd9SUIb6LZcyDvSWNaWVMajUmYk9jX7
         pio2UX54kjHk167PLz4lhyxlWaZFMiE4c9fWz+3VEFNljSmTwm0LiWZDV7pRT9jVjytq
         iDjA==
X-Forwarded-Encrypted: i=1; AJvYcCWz0xBFleYJc3w//ud408UfAX7sTPQDswlY5+b1w8HYcCG7EDdCvZPeYUgo+KzSx253PtEQ@lists.linux.dev
X-Gm-Message-State: AOJu0YzDq7WJQGCTJL/AtKXb17xTu2Qsj8rOAHg9EpHUD9pOvwzl6OyZ
	t/KStFYCnmgDDxLuyb5x2utQaXg+NzSwOiYd7bMOtOhy61Cn05HUnmVphBl6Vjw=
X-Gm-Gg: ASbGncu3Zfb2q/GZI+Ss9UIbXVQhNKG6AZediZWvQk1KMfBx014jG2mr75/qHhhr1NJ
	uDzEhCAYSdBwdzLhhSKmjaC8oxbmvHmTJxexdYjfkbI+zpge1PJK9cdCDysa8EcTlro/qqJAxMX
	bMiHesmvJmFoZS8HggnAgK9SephxD+dqSQX/Uuk6X2MNT0/bHYL0easHUwTtIv7M0cpRXo+oaYT
	5BAJAecxcYkuMJ7IWoPfVp0zTTPpdGTuj2S2E+PcppoJ2fuXSDYbBlOC2Wq0A6hRVr/8bPpOZGf
	Ce1+hYvtNIXGUor1+CyloNXXgubEV0xTLpNBAQ==
X-Google-Smtp-Source: AGHT+IHW+XXFajOXMQh82qC+hUX4SWHOEwAm/IPVuoAhxDKSgoy8z/LA4zU9drz2cmOSG/TO1iilkA==
X-Received: by 2002:a05:6a21:688:b0:1ee:d8c8:4b8d with SMTP id adf61e73a8af0-1eed8c84dd2mr944002637.7.1739932319592;
        Tue, 18 Feb 2025 18:31:59 -0800 (PST)
Received: from localhost.localdomain ([154.91.3.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242546158sm11248290b3a.16.2025.02.18.18.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 18:31:59 -0800 (PST)
From: Chunjie Zhu <chunjie.zhu@cloud.com>
To: Bob Peterson <rpeterso@redhat.com>,
	Andreas Gruenbacher <agruenba@redhat.com>
Cc: Chunjie Zhu <chunjie.zhu@cloud.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [v2] fix "NULL pointer dereference in gfs2_recover_func"
Date: Wed, 19 Feb 2025 02:30:44 +0000
Message-Id: <20250219023045.45240-1-chunjie.zhu@cloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218093003.41966-1-chunjie.zhu@cloud.com>
References: <20250218093003.41966-1-chunjie.zhu@cloud.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

before checking WITHDRAW flag, we have to check inode pointer

v2:
  fix gfs2_sbd NULL pointer deference

Signed-off-by: Chunjie Zhu <chunjie.zhu@cloud.com>
---
 fs/gfs2/recovery.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index 44806513fc06..8434dd385ac5 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -400,7 +400,7 @@ static void recover_local_statfs(struct gfs2_jdesc *jd,
 
 void gfs2_recover_func(struct work_struct *work)
 {
-	struct gfs2_jdesc *jd = NULL;
+	struct gfs2_jdesc *jd = container_of(work, struct gfs2_jdesc, jd_work);
 	struct gfs2_inode *ip = NULL;
 	struct gfs2_sbd *sdp = NULL;
 	struct gfs2_log_header_host head;
@@ -411,16 +411,20 @@ void gfs2_recover_func(struct work_struct *work)
 	int error = 0;
 	int jlocked = 0;
 
-	if (gfs2_withdrawn(sdp)) {
-		fs_err(sdp, "jid=%u: Recovery not attempted due to withdraw.\n",
-		       jd->jd_jid);
+	if (unlikely(!jd->jd_inode)) {
+		fs_err(sdp, "jid=%u: Looks like withdraw is ongoing, skip recovery.\n",
+			   jd->jd_jid);
 		goto fail;
 	}
 
-	jd = container_of(work, struct gfs2_jdesc, jd_work);
 	ip = GFS2_I(jd->jd_inode);
 	sdp = GFS2_SB(jd->jd_inode);
 
+	if (gfs2_withdrawn(sdp)) {
+		fs_err(sdp, "jid=%u: Recovery not attempted due to withdraw.\n",
+		       jd->jd_jid);
+		goto fail;
+	}
 	t_start = ktime_get();
 	if (sdp->sd_args.ar_spectator)
 		goto fail;
-- 
2.34.1


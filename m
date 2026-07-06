Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36E83BAD81
	for <gfs2@lists.linux.dev>; Mon,  6 Jul 2026 18:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783360813; cv=none; b=epDy21s2VLyDbenQlb7nTmsVfBm7M+UF24eQ3CBC8trY0C7YyNsw5s6aw23N/jECljGsch+IfpwneIGjbZckp3ggEYZS8uWCCEClNok7/ZiUb6yJw7AVMo86K+OhmJY7hWR8a27VVQSr2lth3zoga/wEQIv3nBgiy2s3BPIhWpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783360813; c=relaxed/simple;
	bh=bsnh9gOaL7Rt2V+xeyeNRAfwOn3S2p6enNw0gjImK+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NvQB7DDPp4BBvv62PKQC173ITjdZp84vK/9Q7srwnOM1JEWdDaC6qn35zGhlkRD8rvbo43/ZdrJ0dCsPtvgHQ2TD+LR9yyleV4KKEISBPXM9oYeccAFw8hV8+7ds5/WYAUgRPHmzg8m1KI8o44vs5Iqx28kL/yGMybaVkAWdaZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGwtDkuD; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGwtDkuD"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cc6dd436c6so16551535ad.2
        for <gfs2@lists.linux.dev>; Mon, 06 Jul 2026 11:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783360811; x=1783965611; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1i9opHM4bOHdKev3pbWNXUYFj+izXMcvOiuJ5Sb6Isg=;
        b=OGwtDkuDABA6rAgEv1ADxeRvuRnqqOlthCd3GZYCnWvudmroE2K0AmbYWTkGzR9anQ
         c8NV7AUJ7F0bWo0XxJMCY7DgFA1iMb+D7uJvpnTjk2iaLf/u/0nAxltX75aya6hwc3gb
         PTUHVJRi6fV46f0hnvOpxT9axO1Z4xBUIe4YeVYFDhDVfE3vsxY9orje2so5rh1Hjjhj
         kFhRCQGT5NTppi/Vw2zZdu9jYqHe9PBEwaD5iNkwXxJPa4NPg85mQyOO3D/3SCrL3aHi
         jgHYHbLRMuyPx41ds94LDcN6fARiZBKCe6bZYpC8C0uyvDb6D0cpWu8IlaiAvOfQigXH
         +ynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783360811; x=1783965611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1i9opHM4bOHdKev3pbWNXUYFj+izXMcvOiuJ5Sb6Isg=;
        b=NBbyIXSLbGEHVr5p55b6WQYqkqFPrxD18q/hZBEh+2Hm5qZZI9ZeMixSv/oJ3YCIKj
         YT1fe/fpKy+JuVhRo1oX1K5/NSQiThP3tN8BGPL2LOvs4LlB+czHMDj+b9PEyTfn0FHb
         cJ1JSXeTTd5nNrJMESNAIYOGWmVphf3QbHoeCiZNDA6CjKiN9MYItz7pZ3/xvH86tmHm
         rhV9aKt/939MY2iFfH9IBFuToTuhEGkcnUpPo1si6hUAi8j6aC6C+7Wl2bPxSbgG3jzT
         w0uzThbmxEnPLIowpJYXhjR1EOUvL1JNvJE8nOEO6nYcJBysvedcYSgBdVbc33C6Lf4o
         uB1g==
X-Forwarded-Encrypted: i=1; AHgh+RrCLEmcVMH4lzhHng5MicaVMbuTK2J+cmgAa+chdKmaJ5u47pMbPnZ03V6gP6H3DvaAcFnb@lists.linux.dev
X-Gm-Message-State: AOJu0YyA+rUn1F1EbATCepRNY8R7xXpb0vMREj16KeYwVl9Kd9xrK1V9
	LeBdjg+MIMI93XEwdB5nHdnbeoi7+udjklFJOWFFTEjix23FbASL2S9v
X-Gm-Gg: AfdE7cknamNe5adrtAlWLgD52Cpfc+vIzYLpCHfwgHM+A6gaPgV9pkhWiWxuSEOtFZR
	1p5wCEYgzV3LIXmDU1rl2yTAJHeXYBGppf9gIIS0H36RAp+9CnoXQsvB9Ih6hLXVi4lCre4r/Hh
	bJAh1xHs3YW5TxDeiHLGD02kzQ7wZOmoAuY252XZKXzzzwcdNzGO7VVuFUcFrW7aAO4rLgHUsSe
	NzO5NGo+8s82J6JixSMg6Hyr7Rgpa1MPtVt1aEPqA/RKStsCa/NMke7eN4v7jEyG6RgvY5Hsr7V
	PURPOKOhZMrxryIEKqIKEPT3wiZ+hTgkaIipiR5Asnpb2Oe0h9Czp7YJF6yckp2S5pxaL9uq5I1
	lUA9os4jjZA7cZkaFZpIdwI24LEJ9K2yZeTwJhugM8g3Oygy90pJJWx6mv+wDWonmdh9PGtZ3Eb
	LJc7BC49q8M3xZVPUfmqCnKAs=
X-Received: by 2002:a17:902:ced0:b0:2ca:1b97:70c5 with SMTP id d9443c01a7336-2ccbe617d59mr15890325ad.4.1783360810922;
        Mon, 06 Jul 2026 11:00:10 -0700 (PDT)
Received: from ustb520lab-MS-7E07.. ([115.25.44.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad7893dadsm54829455ad.74.2026.07.06.11.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 11:00:10 -0700 (PDT)
From: Jiaming Zhang <r772577952@gmail.com>
To: anprice@redhat.com
Cc: agruenba@redhat.com,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	r772577952@gmail.com,
	stable@vger.kernel.org,
	syzkaller@googlegroups.com
Subject: [PATCH v2] gfs2: reject oversized dinode sizes before i_size_write
Date: Tue,  7 Jul 2026 02:00:03 +0800
Message-ID: <20260706180003.2124317-1-r772577952@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <74871a78-5243-4898-8e63-92e918912980@redhat.com>
References: <74871a78-5243-4898-8e63-92e918912980@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A corrupted GFS2 image can store a dinode size that is larger than what VFS
i_size can represent. gfs2_dinode_in() reads the on-disk di_size as a u64 and
writes it directly into inode->i_size. If the value is larger than S64_MAX, the
incore i_size becomes negative. That negative value can bypass the existing
stuffed inode size check:

inode->i_size > gfs2_max_stuffed_size(ip)

Later, gfs2_quotad may try to sync the quota file and unstuff the quota inode.
gfs2_unstuffer_folio() reads the negative i_size into an unsigned length and
passes it to memcpy(), turning it into a huge copy size and triggering a
out-of-bound issue.

Reject dinodes whose size exceeds sb->s_maxbytes before storing the value in
inode->i_size. Also make the stuffed inode check use the raw on-disk size while
it is still unsigned.

Fixes: 70376c7ff312 ("gfs2: Always check inode size of inline inodes")
Closes: https://lore.kernel.org/lkml/CANypQFaF6bvORKKbRALvEL0k_epFaneFiOQqco4gjdmKVbdURg@mail.gmail.com/
Assisted-by: Codex:gpt-5.5-xhigh
Cc: stable@vger.kernel.org
Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
---
Changes in v2:
- Drop the defensive unstuffing changes in bmap.c.

 fs/gfs2/glops.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 28f32424ee64..8c5d257451d5 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -393,11 +393,16 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	umode_t mode = be32_to_cpu(str->di_mode);
 	struct inode *inode = &ip->i_inode;
 	bool is_new = inode_state_read_once(inode) & I_NEW;
+	u64 size = be64_to_cpu(str->di_size);
 
 	if (unlikely(ip->i_no_addr != be64_to_cpu(str->di_num.no_addr))) {
 		gfs2_consist_inode(ip);
 		return -EIO;
 	}
+	if (unlikely(size > (u64)inode->i_sb->s_maxbytes)) {
+		gfs2_consist_inode(ip);
+		return -EIO;
+	}
 	if (unlikely(!is_new && inode_wrong_type(inode, mode))) {
 		gfs2_consist_inode(ip);
 		return -EIO;
@@ -418,7 +423,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	i_uid_write(inode, be32_to_cpu(str->di_uid));
 	i_gid_write(inode, be32_to_cpu(str->di_gid));
 	set_nlink(inode, be32_to_cpu(str->di_nlink));
-	i_size_write(inode, be64_to_cpu(str->di_size));
+	i_size_write(inode, size);
 	gfs2_set_inode_blocks(inode, be64_to_cpu(str->di_blocks));
 	atime.tv_sec = be64_to_cpu(str->di_atime);
 	atime.tv_nsec = be32_to_cpu(str->di_atime_nsec);
@@ -462,7 +467,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 		return -EIO;
 	}
 
-	if (gfs2_is_stuffed(ip) && inode->i_size > gfs2_max_stuffed_size(ip)) {
+	if (gfs2_is_stuffed(ip) && size > gfs2_max_stuffed_size(ip)) {
 		gfs2_consist_inode(ip);
 		return -EIO;
 	}
-- 
2.43.0


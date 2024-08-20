Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CBD18E361
	for <gfs2@lists.linux.dev>; Tue, 20 Aug 2024 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166541; cv=none; b=O0azgajunPKqMkEg/A1PPbc7fC17BWXPZPMzDlz3eAfk97lHTU+Rhb1zl+FWWKWPHIVBviEtnI9sHKROBI26MKZcpbcrbAHkEp2wqG590hzkE9w1z1Xn+Un1E0ukDFUftfWn9HvycVS824x4WS8LkiV9lgxOXw5A5TNuR1E6HK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166541; c=relaxed/simple;
	bh=eIBe5VU0rwzRYmoZ+ezGTfEUNZB4FKbZoyKyuWgfjEU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pT4Gc5uqnixdLAwhxLsjvsJ+qpUbgHulW/tK51BI0dIubtffns64TsAW7NTsJ2Ppkgai4/W5DKLvS8AgCKpffeNMOooQDjzhyR2njD5XFSFz3jFaAScb2OuloylFoIW5MUUBJzhBzDDisCiZElLcN4gc3Ko6Tw4lMJx6lek8yak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKtYcyxk; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKtYcyxk"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-201fae21398so33665945ad.1
        for <gfs2@lists.linux.dev>; Tue, 20 Aug 2024 08:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724166538; x=1724771338; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W/VVL2iFwMtIglkiNUI7sZ7vpqFc9+UuopSaFpbmGHU=;
        b=cKtYcyxkVhow5u95DhsMchJ6PvKip6WGY7u6VwI18Ijwp1cO76FXzRrAmSdSOc10/i
         ECsJip3GK6m0UrFc0t0vls9eRePhkJele0QcJpGg/3aidzo1VXjAuYo9WO1rs708IAxt
         KQA21vZBjVxh/66/SHefayNA2e08SUzijJduqWdT5la8V+DY+Lhb+m5jQiWZnpdsv+Mk
         8w77Yvt1RT+0X2jnWqcTvKRwMdDKGGyymhDHLi/alHBEY5apdnjVhuETdU/X+wPjQFEB
         j9TUs/cCP6Ac7dcjzc0w4KtsYf5oWKG64eZgqYfb3IA5CC3TcVJG7Cq50+i4az+6uQZ2
         pmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724166538; x=1724771338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/VVL2iFwMtIglkiNUI7sZ7vpqFc9+UuopSaFpbmGHU=;
        b=tAvZNMUnRUAtIfMqVgcIimQdH6Bds1C6LWqztw09oaIjXmOP6mtKYVUZDmQ1jvHL0Q
         XDuIPsPvP85XKKoDwkkMgb4jJH5z5ZWsk5p0k1JDCPLN/ToZZ2iKkNwwDiDcJn4giT+/
         2eKnb8X985Mh9rWCuhdq75B9ClK8NxIV2UTYdGo9hpt+z2s9c01XHtBE+CovPsELB16S
         jDc2k3bK8njBADh+NgRg1shMv9RWn5w3vwfCfdzzjFlsPQetvCqIimPrBj+N6TSpkSc8
         lOgdAr7ZvZwE5ks6f6sJ6zDrMUdNVZXoY5Qke8rLQNeH+W3j4WVqwNTUiO4Nrue/G4xb
         bixw==
X-Gm-Message-State: AOJu0YyYdlHk0yineG9NHlFVb83PEjJoAtv/GZ/K2wqJ5/DcY8VSP7r+
	VFB++Jzzcg5vCJsRa+RhJOJCnyynpz30QPGG3Se/CzjlXIo2iS5P+ru2Cws3
X-Google-Smtp-Source: AGHT+IFFSAlPPJrEB2CHN3/9oCW5VDc9wktc5KS2Mnp7P63mo1edOgBdh/CJLhEtlPtauLWNHjqYOA==
X-Received: by 2002:a17:903:247:b0:1fd:92a7:6ccc with SMTP id d9443c01a7336-20203ec1b8cmr146835015ad.30.1724166537516;
        Tue, 20 Aug 2024 08:08:57 -0700 (PDT)
Received: from localhost ([36.112.193.99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f038b40csm78834595ad.220.2024.08.20.08.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 08:08:57 -0700 (PDT)
From: Julian Sun <sunjunchao2870@gmail.com>
To: gfs2@lists.linux.dev,
	syzbot+d34c2a269ed512c531b0@syzkaller.appspotmail.com
Cc: agruenba@redhat.com,
	Julian Sun <sunjunchao2870@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] gfs2: fix double destroy_workqueue error
Date: Tue, 20 Aug 2024 23:08:27 +0800
Message-Id: <20240820150827.139326-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When gfs2_fill_super() fails, destroy_workqueue()
is called within gfs2_gl_hash_clear(), and the
subsequent code path calls destroy_workqueue()
on the same work queue again.

This issue can be fixed by setting the work
queue pointer to NULL after the first
destroy_workqueue() call and checking for
a NULL pointer before attempting to destroy
the work queue again.

Reported-by: syzbot+d34c2a269ed512c531b0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d34c2a269ed512c531b0
Fixes: 30e388d57367 ("gfs2: Switch to a per-filesystem glock workqueue")
Cc: stable@vger.kernel.org
Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
---
 fs/gfs2/glock.c      | 1 +
 fs/gfs2/ops_fstype.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 32991cb22023..5838039d78e3 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2273,6 +2273,7 @@ void gfs2_gl_hash_clear(struct gfs2_sbd *sdp)
 	gfs2_free_dead_glocks(sdp);
 	glock_hash_walk(dump_glock_func, sdp);
 	destroy_workqueue(sdp->sd_glock_wq);
+	sdp->sd_glock_wq = NULL;
 }
 
 static const char *state2str(unsigned state)
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 0561edd6cc86..5c0e1b24d6ec 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1308,7 +1308,8 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 fail_delete_wq:
 	destroy_workqueue(sdp->sd_delete_wq);
 fail_glock_wq:
-	destroy_workqueue(sdp->sd_glock_wq);
+	if (sdp->sd_glock_wq)
+		destroy_workqueue(sdp->sd_glock_wq);
 fail_free:
 	free_sbd(sdp);
 	sb->s_fs_info = NULL;
-- 
2.39.2


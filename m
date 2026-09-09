Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EB2486E68
	for <gfs2@lists.linux.dev>; Wed,  9 Sep 2026 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944507; cv=none; b=jq70xh2wtNDbdiNPm9s70TRVhVWfpSwqhT97vRoQq5+G5WBQwiFHJe5qxIuBOYPl5EQBEsVW3+ttY6viZiljqzsISkAu3NqFcBRf85oOIL+/KYNGtVi1eat3y3eactZ/Y/7wlFtKOGnBnupF1F6pycw/XwpOtru+7BR92uF9qnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944507; c=relaxed/simple;
	bh=HwU/ru9C3cqaYxeWB4WaVZIJTnLTox6zR3se4so5PpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WWRNLXOuyyXsAG4wmpaTzIc0LHGWUzyYksFszK9a+YyK3aHoLlX+lt30po0U0xl2u5yl1TI3rqcoFlNnjRsRNkkjehMiX4BqbWToc8lushPIAEtUt96fOe+LeQVjCWZuHiTh0GleOMqBk3UXn08IjStu7tPnxgMQG78fWKgI270=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HzhCjLpu; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HzhCjLpu"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-398d2b28acfso4185704a91.1
        for <gfs2@lists.linux.dev>; Wed, 09 Sep 2026 02:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788944497; x=1789549297; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fnw+bbx2n8GI1P1qJxz04Evujcp+PRs2H97tReO8VaY=;
        b=HzhCjLpuFsu+6kyO+53twCcBooHJYeeC9Hx88YfojSRjcXUVRCn44lwQdJu2LgtQJs
         6skxSBHwZX1jn9JToRlylRgiFxPKOT27B+VF8230Rh5naScQOeUE/9/j15ekazqmk9WN
         0w3K7fU4Pid16G6vSFWRcfpZ+MqOup5N+H2yZgimBFmyzLG1V1t3pZANjosbMOuIxwTE
         4HjamTbWdKSZJN9GPwHL7S7Ji07tZ+3ftm7NOvgyXYE0KfBPAuuoHgiuE0GYbTOEIqpm
         O5er2XIIM9Hefw4WYRNC0RdXw9fhNknyCIA/MAGF618ERqrEjhKwteMI4QYR0fkug1go
         GgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788944497; x=1789549297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fnw+bbx2n8GI1P1qJxz04Evujcp+PRs2H97tReO8VaY=;
        b=GjOUdw2Sffubwi6kxaU8wXdYBk6MMCwsgsmb+VJHXbWz9UXyz0t2zXs6SocoevSV/h
         gel2UdsJXo/Wn6SamcTlTrwnJmiP/FKZnSrf30gPQU3gvhUEG8mE778ccoZF7AeA+GSo
         WKEbhUVq8o99gd/H5WsczJ2G2gheYnsu9duA/zbN6+MX6LnAMHrPUr4944BAkh7J4FI7
         XoHhhv/KMWZJI4WL8vv28hkNeRNOWc8/mANBr+YNRdV5pHtiZJqz1QII78lqPxcfvN6J
         9jgv79rJ1SGQfWDaJ/NP4AiNL/m4S6VWdrXWoj1nKO/azz3e83g5FL1R3GrYkBycjvB3
         bs6Q==
X-Forwarded-Encrypted: i=1; AKwUvBzTfARJzZRd6bpzCt8YDUlcp456wT+1uyxvaSdyWBz3++RRhmChDiyNqbRmZqFADfGytE13@lists.linux.dev
X-Gm-Message-State: AFuF++nvSsX9TjjbwqF2JRGXpIpqD8NZKgT5t5yPkv0sAZ7WvEnKr8o3
	xlzV7Gt5FNNakc+qNC75julxlOenZDV0tolEyqgH7g504CH1aMkFXMyyocOyUUL/v+g=
X-Gm-Gg: AYBFou2BKuPVIXAYZpe5ssFtrTxK16NYeDpLlHTLc3RUcQ7xz5raG1Of7VBOw8Da2Q8
	hcm5QjG+8EqK16qPavGtsHvMPqBTj0rdzpXsQbd8SM44smLBp+k5VCqVIKGUl1u8cHho1ISosbX
	/EhHSV8HvVn5wos6hwuMeHmloO2zbo0JIzK5OcTBkWUdQv9UYM6wvaVFWfaRHOezbdev+Grkfoq
	uIZ0c86dhk1pySM8Yjg+9VKvZ3tHmLwgp8a03VY6IuzdaPIickBmtOwLkopbqH8gvZaDu5QwMwP
	zbHkWbseXqxDNpqS6nSyS0TMRDLeK1eRuhwZ/eN6gPddwgYtK1ndgqKYJNHkWKXgcccmnTT69ig
	EA0c9UGgWBgcTAJFdNjXqhwZF/OnYRAT4AMVLcsT2Gl4x60lJHNgi2P1MpHzhrVHC8Tbj/+/bq8
	lKZuwcpBcN0GcAYEMSFOfKvl+IqwZGvakjNl8gDQ1TZOv7kX5ijBaQFtyC11jB3aU8sBLYwkuy4
	0zs
X-Received: by 2002:a17:90b:1343:b0:398:d93a:b343 with SMTP id 98e67ed59e1d1-39b26123302mr60180972a91.3.1788944496615;
        Wed, 09 Sep 2026 02:01:36 -0700 (PDT)
Received: from localhost ([106.38.226.186])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39bac3a2809sm4683088a91.10.2026.09.09.02.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:01:36 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-security-module@vger.kernel.org
Cc: jack@suse.cz,
	agruenba@redhat.com,
	mic@digikod.net,
	gnoack@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	aleksa@amutable.com,
	legion@kernel.org,
	djwong@kernel.org,
	ebiggers@kernel.org,
	sandeen@redhat.com
Subject: [PATCH 5/7] gfs2: use sb_for_each_inodes() for cooperative eviction
Date: Wed,  9 Sep 2026 17:01:10 +0800
Message-Id: <20260909090112.790006-6-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260909090112.790006-1-sunjunchao@bytedance.com>
References: <20260909090112.790006-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert gfs2_evict_inodes() to sb_for_each_inodes(). Take and drop the
inode reference within the callback, with iput() outside the list lock,
to retain cooperative eviction. The iterator preserves the walk position
and removes the need for toput_inode.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 fs/gfs2/ops_fstype.c | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 718e0da7dfce..acdbf9ca44a3 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -996,7 +996,7 @@ static int gfs2_lm_mount(struct gfs2_sbd *sdp, int silent)
 		switch (token) {
 		case Opt_jid:
 			ret = match_int(&tmp[0], &option);
-			if (ret || option < 0) 
+			if (ret || option < 0)
 				goto hostdata_error;
 			if (test_and_clear_bit(SDF_NOJOURNALID, &sdp->sd_flags))
 				ls->ls_jid = option;
@@ -1719,6 +1719,19 @@ static int gfs2_meta_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
+static int gfs2_evict_inode_iter_cb(struct inode *inode, void *unused)
+{
+	struct super_block *sb = inode->i_sb;
+
+	__iget(inode);
+	spin_unlock(&inode->i_lock);
+	spin_unlock(&sb->s_inode_list_lock);
+
+	iput(inode);
+	spin_lock(&sb->s_inode_list_lock);
+	return 0;
+}
+
 /**
  * gfs2_evict_inodes - evict inodes cooperatively
  * @sb: the superblock
@@ -1741,31 +1754,10 @@ static int gfs2_meta_init_fs_context(struct fs_context *fc)
  */
 static void gfs2_evict_inodes(struct super_block *sb)
 {
-	struct inode *inode, *toput_inode = NULL;
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 
 	set_bit(SDF_EVICTING, &sdp->sd_flags);
-
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		spin_lock(&inode->i_lock);
-		if ((inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) &&
-		    !need_resched()) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-		__iget(inode);
-		spin_unlock(&inode->i_lock);
-		spin_unlock(&sb->s_inode_list_lock);
-
-		iput(toput_inode);
-		toput_inode = inode;
-
-		cond_resched();
-		spin_lock(&sb->s_inode_list_lock);
-	}
-	spin_unlock(&sb->s_inode_list_lock);
-	iput(toput_inode);
+	sb_for_each_inodes(sb, INODE_ITER_NORMAL, gfs2_evict_inode_iter_cb, NULL);
 }
 
 static void gfs2_kill_sb(struct super_block *sb)
-- 
2.39.5


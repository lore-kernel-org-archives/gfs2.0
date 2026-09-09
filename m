Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191483B2FCC
	for <gfs2@lists.linux.dev>; Wed,  9 Sep 2026 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944484; cv=none; b=t0r3j4euN+4vYflnLn33GQfycV9Nd3Ip36VK3Ir5Ca5uirmovGNVKVx717mStnTP9I8DESPHLjkx4SOUbvmnAuhB9RA0BSNIZGU0/nafxD65FaDYmt146xaj2UItg0isVu8WBTNjNjXUG9e/pZWu7tOtwnWhbMaaGP6N2vXIHNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944484; c=relaxed/simple;
	bh=qIa/OOPRF8eUOfN7emCsEmTA8N7RP5NPcMNXTb2hiYo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZuzyJdiXyugT3ct0ohkwkYD9sfc0mszHFjXY4ySHe86tpP0yucGyLzgO6653MPhBfhrZ6I8LjFLykEqDYxaqhZDxgGBlMJ7bOvzKcSRjCunWpcTGY9OKtC/5C99t1GTzilzO9E2Fo1vGd7/GGoohdZ9GVd9VYUx8V5LhAmrrGn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XbqRKzkb; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XbqRKzkb"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2db18e5cb56so54335675ad.0
        for <gfs2@lists.linux.dev>; Wed, 09 Sep 2026 02:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788944476; x=1789549276; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oiZZoK2m1udHvSG78cGXbZoP5Fh5l1Q4IJu628L6gi0=;
        b=XbqRKzkbKQZqsdeEPVQb1Ymv83n2Yiiu3fdskjn1xEHjBZB4xYNNZm8XK07S032F4q
         bxniRo0zlafcY0fmdErRlZsaaam7UwJUA2aYqor4hvpAcGb+2UKuPSw9Z3Ei4Ntdb6+1
         it3VyrebIsRT8qu9YQuFCTTTkHGiggeBWclWitxFIMVdejAxxFhQotY6XLM9atQRySBf
         zBJZJA4XgYvLI4khzMN1UqNdPEZngVKf7FokjjEXvKpBIRMFLCU4WT44iIeug+e0al10
         kE6uigpBVRLoQ96MrelGFPy8ocrkdkM9GXjCbH8HVPoXDair8AAnrqeLC2DhKs4x30tr
         ZtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788944476; x=1789549276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oiZZoK2m1udHvSG78cGXbZoP5Fh5l1Q4IJu628L6gi0=;
        b=GngpqXcIjINjl8jkt2wK4iLX8GbMlg6sNjS3KR776POV/B0pBhv9xqrdW9//C8t6Yf
         Qi4eJmIrz9qLeU1xQaKjv32uVPci5IXsEUOnPhjeTnYigCnHIgQYRzzYQ2HnwSgaN1H1
         Y6/92LZzK2PSCHRVIt1gCK7o8eXxs7hq94285Qgsvyg4C5s0TffEYSC2mkdFpwTHDbZR
         BQZ0d7ycs4hRAmtir1k99cIvObeoXgW+/9DE0+LCcRnx5wJRprQ/GCTNbb4ncAN9J9hf
         1YXz7pvDmiB0rFpJ+v3fRrFvM+2oQoVQL156ILIEY2MtFiA05LeKdgNMUG/1+V1OEiZX
         PwDQ==
X-Forwarded-Encrypted: i=1; AKwUvBy4iPRR6rcfsVNUZBPCOxNoxwUGmVtS0thK0NxVme8Hq9r0KR0yLLl45Yts4VtaugibIsat@lists.linux.dev
X-Gm-Message-State: AFuF++nt2sN+IP2sPp5vnSU+/2a/fgfOHXuOr5ZEznRl7R9YWXaErCRt
	3SW8oCJKbzaKlQ4uoAJwiRiF/buSyrUzHSTqpjBrES032yXKNmBUIr8CICc7lcDhfRE=
X-Gm-Gg: AYBFou1KfbuETUJ+b9MJkSk2LtdgeHktCoFlPPXiYfogTx9gwZkEPhB5i2GP9Mw/iAD
	5Vw7YkmdtkYWtu4yyV30t/W6UjvVVj8fURcfGEd9DoQuPu9fcp/KbdZx6qEC5aC/VCswAgsS9Mm
	QPVwtsmkKVWbBWVQC/5EmcP68XQkkI1Vdc7xIyOUNVLVJRF86KIFLOdmEKvVBOE6K62/DCItkVR
	GP53JGP1Rrb1HwoN568FEapMhJIGTMkyShLCpKT7W/NmbZMWQPMSnn/SG81eHzgiJ1H0nHQHoSB
	OZCmX71aCO+2WPrgWlDoXpYHYxEe5jc//0wNPTHq5QXHAsufzRxAcKnWBbdhYkhjaIyXlAwihDf
	S2mIcfYjhHtkbjdJItC0uPZOcYZhzh+W6Vpm7ApeQb0oejUj4bhFI6JYcBP/i/ds4XaHma/fCxt
	bfhg2Jj5mtm4r6EMWM8gCJoE1hT6NlLgIVWm0Jv6XgPNMl4Uh3DJw6OwIpYs6XSBfgVWhR3I05H
	kA=
X-Received: by 2002:a17:90b:528e:b0:38e:ad9d:1161 with SMTP id 98e67ed59e1d1-39b25ee67f0mr51440982a91.0.1788944476217;
        Wed, 09 Sep 2026 02:01:16 -0700 (PDT)
Received: from localhost ([106.38.226.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b2612d3f1sm30763517a91.13.2026.09.09.02.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:01:15 -0700 (PDT)
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
Subject: [PATCH 0/7] fs: preserve superblock inode walk positions across lock drops
Date: Wed,  9 Sep 2026 17:01:05 +0800
Message-Id: <20260909090112.790006-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Motivation]

We observed hung tasks in production during disk hotplug operations. A
kernel thread spends a long time in evict_inodes() while holding s_umount,
blocking other users of that lock and causing further stalls.

The problem is that evict_inodes() restarts its walk from the head of
sb->s_inodes every time it reschedules. When a large number of referenced
inodes remain near the head, each restart scans those inodes again without
making progress through that part of the list. The repeated scans can
delay eviction long enough to trigger hung-task reports. This is the same
problem that [1] attempted to address.

[Approach]

This series introduces sb_for_each_inodes() for two purposes:

  1. Consolidate open-coded s_inodes walks behind a common entry point.
  2. Retain each walk's position across drops of s_inode_list_lock.

The iterator mechanism follows the approach used by cgroup task iteration,
such as css_task_iter_next(). Active iterators are registered on a separate
list, sb->s_inodes_iters. Before removing an inode from s_inodes, the
removal path advances any iterator whose next position points to that
inode. These updates are protected by s_inode_list_lock, so a walker can
drop the lock and later resume from its saved position.

Existing walkers, such as drop_pagecache_sb() and add_dquot_ref(), already
contain their own position-preserving logic: they carry an inode reference
across iterations so that they can resume after dropping the list lock.
Moving that responsibility into sb_for_each_inodes() simplifies these
callers and lets their callbacks focus on the per-inode work.

Patch 1 removes trailing whitespace from include/linux/fs.h.
Patch 2 introduces sb_for_each_inodes().
The remaining patches convert existing walks to the new interface.
remove_dquot_ref() and nr_blockdev_pages() are left unchanged: their
walks are simple and do not require the inode->i_lock locking imposed
by the callback interface. Converting them would add an unnecessary
lock/unlock overhead for every inode.

[Testing]

I tested this series with approximately 20 hours of xfstests case
execution, repeatedly running the auto group on ext4 and XFS, no new
issues were observed. And with this patch applied, the hung task that
previously occurred on every run no longer occurs.

[1] https://lore.kernel.org/all/20241118114508.1405494-1-yebin@huaweicloud.com/

Julian Sun (7):
  fs: remove trailing whitespace from include/linux/fs.h
  fs: introduce sb_for_each_inodes().
  block: use sb_for_each_inodes() in sync_bdevs()
  fs: use sb_for_each_inodes() API.
  gfs2: use sb_for_each_inodes() for cooperative eviction
  quota: use sb_for_each_inodes() in add_dquot_ref()
  landlock: use sb_for_each_inodes() when detaching a superblock

 block/bdev.c                   |  85 +++++++++----------
 fs/drop_caches.c               |  44 +++++-----
 fs/gfs2/ops_fstype.c           |  38 ++++-----
 fs/inode.c                     | 142 +++++++++++++++++++++++--------
 fs/quota/dquot.c               |  72 ++++++----------
 fs/super.c                     |   1 +
 include/linux/fs.h             |  29 +++++--
 include/linux/fs/super_types.h |   3 +-
 security/landlock/fs.c         | 150 +++++++++++++--------------------
 9 files changed, 295 insertions(+), 269 deletions(-)

-- 
2.39.5


Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF61A3B05B8
	for <gfs2@lists.linux.dev>; Sat,  1 Aug 2026 22:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785621691; cv=none; b=chHT42PpSglW0Q36G3ANXuH7pKkROVeqoFHGtAl9lGdvXrvFrYFVvdEcFW8fVrlh45CsLa2olHEUReL6uHdfLs5CgzCGihc7kDZaTULHIHEsL5cOPTmYyLOLgzvtaDUYQ0whmxqvoYrawtZsilKv17nL7byCY7cKJ8zjtuDoidI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785621691; c=relaxed/simple;
	bh=k+XwpsvdR4lXnK8J7akvyHhiQeX6iOLIGH6lriW/zZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=glZ7rVvWpOrmvh7bLEhlJBsHWVRS/o1YqOcjsX70PFppadyGFTZYKWM7lHr+aRIzUtwuZBe8i/9sOiuO8LuSmG1A7BwhqeNtRZ/ytSMr9iHARa8GAPI93Kp0N8bGOrVbnoU6NowkiI59ruHa7K5qlerx72X07H3RR8LSMNBUN7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s7oigMqq; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7oigMqq"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81ed2a00f12so31638337b3.2
        for <gfs2@lists.linux.dev>; Sat, 01 Aug 2026 15:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785621682; x=1786226482; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qR4j1ND7sU3DHEeB5SkE24JFiOq+gxamuNrGyu3FS3k=;
        b=s7oigMqq4ugGyzl1szOnHhn/qHgBnJSejdHSqW6rkOEtKhXpjjMXcIdz07wEvpgUvV
         031bXhH9NNNDb8qH42oX9Sb47tTmDGQIwQu3TN0Bl0wT3NbYu2HUvSNOoUBS3TdxjMju
         b7J5zeyIiiuCB7d9zbDUEPIv0xvXFBBqt4xcnIEZlthht2sfwDiCQDPCen2v6p5kd1c8
         7vbf3+0zOq4Tx+0ciAZPbKMV/oj45YzUkiSWDSsXmdx1IBjlHHkRxv7mCb/e47BUiSMB
         WttCpIew6aNyp4U3c6CAnO81m5PIxLgW141t17gh40iuGPq4JlaSgvgD6QvZqmThIjbL
         t7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785621682; x=1786226482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qR4j1ND7sU3DHEeB5SkE24JFiOq+gxamuNrGyu3FS3k=;
        b=R4Jj9PpT9pJisKtDMybrL6FjkaXkHM6O57wjSCLuodHpDd2PW3eKDtgDB/IrJsa7dS
         kKpzApPeQr/wnl+fKyxGpueTgJ8oTIUt/4qwEli4KC6MzTEahYcJY3HNcaETEYqr8jXO
         /CdFUMRZlM4P2YWak20TeKhzr2sVT1ebRo1qLOImQBVXmmEXMOUcgTXbfa7xLHyrABih
         jxpFWF6FD2UYW+lgfvbrDPshncQ0TqyeBi1arTg1gB4C+R2wRsEPXC0lt9joWmYD9JGS
         3QHhQP3Y4ykQXd56BBhv1TFM5ZMNCnURgbGD2+7OfQNNltDm3z/3AEFboPlLd7asQfal
         PxNQ==
X-Forwarded-Encrypted: i=1; AHgh+RrZEDopy24GbmPr+FXJZOLqvOU6if24SLhxiEq+3sgqRw5DdM4QopqbnnLF/BfF17rcMHWH@lists.linux.dev
X-Gm-Message-State: AOJu0YzPFMlgIL6lolznbihthFuUJxaIZQBU7uTQ/3X93ECJDX3AWdwx
	AQ7ZVaQg5QBhWEl5LIpNlk16mykd2MhlWBzMzC6bOmpGykQbH92Z7Rsy
X-Gm-Gg: AR+sD110eDhqgur6LDOxcc1cnNGbGmV1VdDmH4Yz5uuQH3TvWLhRRDAWP9aU3DzxO5z
	xQiIGwAZ6opPyuUBizycpq0gTs/VHR7qI9GfB0IzCSL38azWealAFNyTaBsoY3hIcwCKvXniJI0
	+X+l5+kQoQCsUJxZVJG+t5v6CiQ/l//sHO/niBO6MUFkbyd9gd6/oorMoCTCjA32D4HTMC4cjdI
	f3CtPvAMDegoa8/ofTnTE0HO93sV+T5VfDq5EFsVSUXC7xiHnQgWRjiDq/5vqdckoUQ7xrHuNuD
	IyJ0CYN3K8Y0DlGj/qnb10Qxj8APMh6j6iJXU4r2DV8zkavf9ACrXDHYwr/emd4M6eXfXc6PP4l
	GdlbutkfsFYEovn3xH6pJRyPxx4HtlspdoOpZF4q8j35c2iWHJi8aY3Y8751e1flcvi8z5py/u6
	8mTAhBRpQgnKrhcwmkfElqjta9GgClOymlkKaEETD8Qr/4Jsu+5MPqO07aURcNgLdxfJlt8Ke4Q
	i7dFxV2
X-Received: by 2002:a05:690c:6d07:b0:81f:27f8:2de4 with SMTP id 00721157ae682-81fd4a04799mr74061547b3.8.1785621681823;
        Sat, 01 Aug 2026 15:01:21 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd0d6fbbsm29903767b3.25.2026.08.01.15.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 15:01:21 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Bob Copeland <me@bobcopeland.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-ext4@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	gfs2@lists.linux.dev,
	linux-karma-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Shi <coshi036@gmail.com>
Subject: [PATCH 09/19] omfs: check for an inode write error with buffer_write_io_error()
Date: Sat,  1 Aug 2026 18:00:53 -0400
Message-ID: <e7e644120766bc3e7ea9598754f7b56000da42c6.1785621505.git.coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785621505.git.coshi036@gmail.com>
References: <cover.1785621505.git.coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__omfs_write_inode() spots a failed synchronous write, on both the primary
block and each mirror, by testing BH_Req together with !BH_Uptodate.  That
relies on the write completion handler clearing BH_Uptodate on error, which
this series removes: a buffer whose write failed still holds the data the
filesystem asked to be written, so declaring it not up to date is wrong and
makes callers re-read it.

BH_Write_EIO says exactly what this code wants to know, and it implies
BH_Req, so each pair collapses into one test.

No behaviour change today - a failed write sets BH_Write_EIO and clears
BH_Uptodate together.  It stops being a no-op at the end of the series,
where the new test is the one that still works.

Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 fs/omfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
index 1d915ef72119..bc37029a4afb 100644
--- a/fs/omfs/inode.c
+++ b/fs/omfs/inode.c
@@ -145,7 +145,7 @@ static int __omfs_write_inode(struct inode *inode, int wait)
 	mark_buffer_dirty(bh);
 	if (wait) {
 		sync_dirty_buffer(bh);
-		if (buffer_req(bh) && !buffer_uptodate(bh))
+		if (buffer_write_io_error(bh))
 			sync_failed = 1;
 	}
 
@@ -159,7 +159,7 @@ static int __omfs_write_inode(struct inode *inode, int wait)
 		mark_buffer_dirty(bh2);
 		if (wait) {
 			sync_dirty_buffer(bh2);
-			if (buffer_req(bh2) && !buffer_uptodate(bh2))
+			if (buffer_write_io_error(bh2))
 				sync_failed = 1;
 		}
 		brelse(bh2);
-- 
2.43.0


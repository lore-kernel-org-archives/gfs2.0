Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC4547254D
	for <gfs2@lists.linux.dev>; Thu,  6 Aug 2026 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035582; cv=none; b=UYlw4QH9BxLVYBtpNy94yuewZYgPnw2ja4ZJfqQWamlfrS15cHx5GVCvjbMF8cjnFFZkZGSQWagbaC+eXeM5P8sc6f3XNY/wWZ5oP1TcX3tDpOVYqQgq0x7w8GlxmtYeD/+SZ0BeLqFFJeXLE31iVBZKQl/vuxXXC7uHTWqfC/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035582; c=relaxed/simple;
	bh=tpriWxWOl+J6JwWfTTr6TdF9jz0JsOXJvxWyKOuU9Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVGKwzwsvspARZgjOcfz80U6rDV21mUtzSOcaXEzDC/SWZYXKftbYtKMPwzjjw/BCYsr7yi6izuvx8zUvwz00G8CY6g+AnRZe0DholPDxKb3qqp8NtIG2gmR28YegC4BXE97Tj/UB5676+ObzIExCazDAAzg70ZL26rBmLVdcx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cL5J0DGw; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cL5J0DGw"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5bfc5b77c02so1791984e0c.0
        for <gfs2@lists.linux.dev>; Thu, 06 Aug 2026 09:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786035579; x=1786640379; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=duwKRHlWbKUb/BOL4rfzAJNO2P4dXrVaNM+8BQLZ4gY=;
        b=cL5J0DGwY8j364XPISNMM/Ap9DL2DUzSviXDlE4KPTm8+HeOtsY8BWXzgAUQOhz92c
         wobfTj+VRrXx6KW+BeO3C/iLPNFwiQ5dMItdV2RkLnboCaYVMi5IDfvCddyy+CLNKbAJ
         DXRMF7V0zqfAc9QVHN4xYpparQ1jGx2a8BEQZYYNLshTAAElcN5zJpVB6yCo+8L2fc1a
         0s2508nBu7ewxZaFZgBxStnZmIVn4FE20fEZ7Yg44caDncp3KnLRBfWGISmG5qvD5RLQ
         mxQB8Yak0d2x530SXLU9sDVqH3UpsgYtXWk6ewBTKk8KDAPKwKAyQlaTyYU1DvmZIhJj
         998g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786035579; x=1786640379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=duwKRHlWbKUb/BOL4rfzAJNO2P4dXrVaNM+8BQLZ4gY=;
        b=scdwpnCM4RUSw91254hLeaHTBc9Dpf4IbGOEPqWShBfrttqcwH0RyZKi/CdsvnEQmP
         3zcWKCFBBDWrYLHjQBwvlYJ8KA+EjuPLYapmi0fCA0B4MlB653LwrJkdopczPL4Bkx0t
         eLcPXtPLHDdON91URCP0pjC5l+GNgoiBy3Qd2W2ng/dbHm0m0GubC6qGzbqJycNhOnBX
         GiDwGcDY6azuE7VVNHPT3n9UYCgD5txWF3vFTjujcjZcYLtKUUwATe2KWJLiQFLR0tVx
         ElQsuynpLIRwxsJdLi753DP3m4V0K5wkZvPKbJyQqx9ShS7GvFhPVM9vi+svnd/x70f3
         BKRw==
X-Forwarded-Encrypted: i=1; AHgh+Rq6g9zOJDv+VfcKzCmk3gkS9f85uRVpgtaxQm7IHqD3EfIzCoouCr6oe04LT2rKVjsz2noT@lists.linux.dev
X-Gm-Message-State: AOJu0Ywwane4OnsGZAO0cloXXYoTzNpwV4a/kcsjTZy/FXgnaxB60qVn
	oKGrspG9hGLRpK8T9IRVGXCvVWy8NirACo9lHqJM28sVsjFCzDb/uKGO
X-Gm-Gg: AR+sD12JNk+/PKa15WHLIcmbGOSNhzA5inrnVianVMfF00/eVviTP1dogJcY9HUwDfV
	OQwY+PgwsqvhFJfue9e/SZs9/zi8D5WLNuXfwg+l+hWjijQs3j1OqZIhorYOKsjJVPY/kHVi65a
	TWGhXTscKpgNaAzX8k/sKujz0JVrBCdz8KJbYFJA/twGbhfWGwUus4RpZrykG61oHe5frSciYQU
	UmVLAwNsrM7W7s40/gEL6vq0Dcvjvn6MJXuh6MCVwypp/f5TmWPtEuU5OPkRsc/RmPDWudXYMeK
	GpN6EE5GudMRIKlG9KEUIJnpsdP4NdpjDo9QJl7o3SZ1UhkvM0rwcvaQLDaIqEDFR6HH3yOeVBm
	30vIiSVJfd8+VkFOZmSsf/HfLh03tk7OFEab1LksoxEATo5e6gdbDCZyrnpK1LPzu1x7l4baXIo
	pUIV52tUzQJnmOsBWPFp9BeOS6lWDxB0njJ4cIdB7JRhUpjjA9ary+5NKMvjs7da2f4HJyG0N4w
	SVObPZaUQ9pHKmUGw==
X-Received: by 2002:a05:6122:3d0e:b0:5bd:b27c:bace with SMTP id 71dfb90a1353d-5c3d926476emr2526056e0c.14.1786035579340;
        Thu, 06 Aug 2026 09:59:39 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c3d05c594fsm3706321e0c.8.2026.08.06.09.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 09:59:38 -0700 (PDT)
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
	Zhang Yi <yi.zhang@huaweicloud.com>,
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
	linux-kernel@vger.kernel.org,
	Chao Shi <coshi036@gmail.com>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: [PATCH v2 09/21] ext2: check for an xattr block write error with buffer_write_io_error()
Date: Thu,  6 Aug 2026 12:58:32 -0400
Message-ID: <fcc530fffd0f1e18e8cd1a3974bc0ccc5b4c4b66.1785951556.git.coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785951556.git.coshi036@gmail.com>
References: <cover.1785951556.git.coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ext2_xattr_set2() spots a failed synchronous write by testing BH_Req
together with !BH_Uptodate.  That relies on the write completion handler
clearing BH_Uptodate on error, which this series removes: a buffer whose
write failed still holds the data the filesystem asked to be written, so
declaring it not up to date is wrong and makes callers re-read it.

BH_Write_EIO says exactly what this code wants to know, and it implies
BH_Req, so the pair collapses into one test.

No behaviour change today - a failed write sets BH_Write_EIO and clears
BH_Uptodate together.  It stops being a no-op at the end of the series,
where the new test is the one that still works.

Acked-by: Weidong Zhu <weizhu@fiu.edu>
Signed-off-by: Chao Shi <coshi036@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext2/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index be63f89402a3..39005ec23fe5 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -769,7 +769,7 @@ ext2_xattr_set2(struct inode *inode, struct buffer_head *old_bh,
 		if (IS_SYNC(inode)) {
 			sync_dirty_buffer(new_bh);
 			error = -EIO;
-			if (buffer_req(new_bh) && !buffer_uptodate(new_bh))
+			if (buffer_write_io_error(new_bh))
 				goto cleanup;
 		}
 	}
-- 
2.43.0


Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4C8385D62
	for <gfs2@lists.linux.dev>; Sat,  1 Aug 2026 22:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785621681; cv=none; b=pn1+QAK5fcBTEnzpxOxBW+t15BvQBOODyayRstkVUEVocq3/VB9UZkBH9vqdLzCLoqHLs2wAKyt/T/7vredakidsdMkGXIHKczOR8yqibKjFwO+fwRayrzIipiO5kXgsNyI3gi+ezpYEyw1xv/dZLehjcAZkyp96WPc7vVLmL4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785621681; c=relaxed/simple;
	bh=0vTXRoH3hdLZk9GtOk2DqiSHrzqM0Eca0oDK4MAlmLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=trWPw4MqdCWJ8h2B0IaXzkf14Jmf/maPwyxdWcv4Z+3M3VmNFAm/lkSokibYsAOd4lM4hIBjLYI2wUHre8eo7VcPMc0SgucNkLD1ww2Kuj48Uhkx2AZa2DW1GZ+9SM2eo8R1YxnCYCznxeU1RhYIsBA4PJKBRETZirqSe2pYF5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4UGYnfd; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4UGYnfd"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-81ec29f1d07so28555307b3.1
        for <gfs2@lists.linux.dev>; Sat, 01 Aug 2026 15:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785621674; x=1786226474; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TKbaZIzhd+ZroWBcz7LzJbdFmiCbzToVe0S18iQ99Z0=;
        b=U4UGYnfdmMnFJEZJ559/Q88C2MHR86mVtRe4cXcbP/H/4NV1DVNtqHKlJNJaGB9+c2
         nc0pEEis88z/f1y/mvCUiJJMuWr81KvvmzR9OkIyoGn9cFGvJq86Lq2iCzFtsbc81sTK
         yJikFPprVO+2Nhb5J2AydNMeNqYzeP5Y5C0IGcCwS/psJeDOXC2OZCklNxOgfuUAGzyC
         QwNFpUhDqHEYpsWjgcLm/VB9LigRGD9CbRrTdTTLeFTohxDancnuIaZRbIAYFDDtLEdR
         xA+1dDeqUXrZlycfjPHEa+Do11uEli6OdevU6s841wVjrx6eosXxA2qLZJ77CC3DzfcA
         ugAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785621674; x=1786226474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TKbaZIzhd+ZroWBcz7LzJbdFmiCbzToVe0S18iQ99Z0=;
        b=Dcax21zBeH/SD5VNXNizgzKGNuFWfs/Wk3X/hzVd2XuFcNaDD1Q3Y0gDvjvqaof9iy
         FmB6wm0hhMV/4JOmyRYcBpwYl5aQHa6tY5wxH4gEm5eoAx0L/VJusIC1BG41OcUtYYJ6
         I9UhDReV1qE396f3Cvaa9/hVIWNZ5C5Gk/fsY3aGM7eGpi+2UOGgsjrP6RdiXAR2su08
         uBDIxxEw2bFdMjn7JXzMpvuFbNgSYUAhW2/vbu6qFSbUZQbtpLjOSanPRrX4qtWrNuWp
         gZBzKc2MWfLClb1hFqMFd6JSHH0d7p5vN9rEO6FCftvviEvJtjVPTqK4XdmMJ6qPhC7G
         WlXQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr2VRgjBXbPPxGL3NH2iVQD7TVTTI1rL9JQLcAZ1UczoDRe3+INZRLgzOP4zxKo9VwfBnCD@lists.linux.dev
X-Gm-Message-State: AOJu0YxagGFxk/wjCUB4ldu0F2JsJ6wZ36EkUTDgXWfSMwDqQ6UQfwoh
	wIGdj5TgMRciWKR9pEWv3ERRQNIm/1M1U76pMqBtZ/iYOyW6k9S66NrE
X-Gm-Gg: AR+sD12f/5g7bjZfYutahgujgOvuC/KHgQhNCVx/c/Wh/UcIJuusf6BBH/0U6fppjIt
	GXy3gle9URbdzgLvzAhmlcazCC3g27Tsc9Ty58MFA4eQ6FxExbwbjkRqXWWWxjEtObst26YBLrU
	0LbP7EHxcygAsJzYe86UK9Cb94lSuYt7wb0M9i6JApjjM+U+UFoyLsSX02YPl3fyMFDbXuk01W6
	mVmqrifIcepKPkuDu5/pi3RISVKC9k+tLJ7sXSckiNV9LzZwzjFvhL9lCK/jU00pWBb7irmLqGI
	RdjBEpw2d60SMXNPN8PIgQk3CQW90iz0XOdFfd7WD2BzOLK2249pOOwONCb/opTV4/fkzgOrnNz
	My15ApY4ufcBoya8x8S+qvrFlSJBGWQxNzdSFsulfmFNnhVr1V5J4ZBhKdQKdzIDAiV+q7O1gn7
	2fiJC8fUQalFJmilncnQh/KjlCfWWD5E0L7b4Vm0w6cHAgNbijS5txD/0TYC5Va7SxxVt1V8RRX
	ZpDXMY=
X-Received: by 2002:a05:690c:dc2:b0:81e:c7d2:f26 with SMTP id 00721157ae682-81fd49cae43mr67970467b3.6.1785621673554;
        Sat, 01 Aug 2026 15:01:13 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd0d6fbbsm29903767b3.25.2026.08.01.15.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 15:01:12 -0700 (PDT)
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
Subject: [PATCH 04/19] buffer: clear BH_Write_EIO when a buffer is forgotten
Date: Sat,  1 Aug 2026 18:00:48 -0400
Message-ID: <1bf058fd5867bceeede78d99844b49a26ed6f3c5.1785621505.git.coshi036@gmail.com>
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

BH_Write_EIO records that the last write of this buffer failed.  It is
cleared when the buffer is submitted for write again - see the
test_set_buffer_req() check in __bh_submit() - but a filesystem freeing a
metadata block never submits it again.  It calls bforget() and hands the
block back to the allocator, so the flag outlives the block it refers to.

That does not matter much today, because the write error is also recorded
by clearing BH_Uptodate and the buffer is discarded soon after.  It starts
to matter in the rest of this series, which stops clearing BH_Uptodate on
write error and makes BH_Write_EIO the way a failed metadata write is
reported.

bforget() is where a filesystem says it no longer cares about this
buffer's contents, so clear the error there alongside the dirty flag.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 fs/buffer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index 04fcc34e4fa6..7889c30d8715 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1091,6 +1091,7 @@ EXPORT_SYMBOL(__brelse);
 void __bforget(struct buffer_head *bh)
 {
 	clear_buffer_dirty(bh);
+	clear_buffer_write_io_error(bh);
 	remove_assoc_queue(bh);
 	__brelse(bh);
 }
-- 
2.43.0


Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD36485CC2
	for <gfs2@lists.linux.dev>; Thu,  6 Aug 2026 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035598; cv=none; b=fEBHqnsKPmNxR3G6KFOvViRSLrz3Jw1JRnILa7ISVl8wo4KytykeNkWzYCoJyRvogJoyoNM3lUXu/fgHQ1OG80kpdLNWaXnOSlN7Ewy0TsHpHrCb2to8Gr4I+d0HlQ2wXYbtrpAe04/jMP65jY7oj6dFUZ09GkiGo12ANjZpwAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035598; c=relaxed/simple;
	bh=0neISYJFH5vf1iYeHnX8wDVudHaEvy72ntuqHszFLec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BNQKO6LFFfm85+xnzpiFptwgbROoJZLzndXnSYXjy14PQ6nhZcZP347CtCjcHW8fXtkR8WPsyqaRqMy/7kJ/CiYYEJhYdZEkB1BwQC1SpxZztmos8aisXDFD6goJvlz++jCKUPyq9UGHstmkkTqTx32MqxD1QCx8rcoEt5V36JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKt3fmSW; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKt3fmSW"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5bfa4c51c2aso775175e0c.0
        for <gfs2@lists.linux.dev>; Thu, 06 Aug 2026 09:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786035596; x=1786640396; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DRJjTotyJT+hr0WWdtFL/ctkn8lHZ3M1r+YQr9eg6EA=;
        b=QKt3fmSWP8OddxFbxWcuOZ7zSdtBrbMW4vKhVThxevM7plpEkqC8tG6sI8KMj8dk1R
         21SowkcQen3HvcebWiD45R1YVAODx681YMBYrYm9Ivjc0u9bkn80AJaMqi25EAt5b14D
         G1vrPlFLG2uaZAavIVTPrLD/NeACbbCfAngdIaRAHmil4Ruc1tVkT47/rEBB7ZvbTxcA
         +AqxtPzb/kGFKzRvHgMH150MWiDDN70e255wFNmcciKGKS4R/Z60IXLiR7+HnylAhr6y
         hSGID5q3HY8vUML4x9L/XHK3p2V545cuMJqNSxYjrnCZdOCYXCmrmnyzC0lc1uuiUVOI
         eq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786035596; x=1786640396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DRJjTotyJT+hr0WWdtFL/ctkn8lHZ3M1r+YQr9eg6EA=;
        b=Sjdm0EJHoXlrfOCItI29qcPBxlrDFwMpGVpz84sIchPTwrXgmawnBd+it3PNMZ6yqK
         NVCshmGbn9dN3UJ83FoUE0mlJGTDIVvzEWLM0rxFZLDXvbm10ONiVoq+Qy7B4G1UztTy
         /t4lGfMACO56KVW/dHQe4/jsj4IMVaoRBfScSjmrTXss9+W6Ym7gS/T6vptpO9AU+rfx
         /t3BguBawMz05MfL/AysGSrg6xzdoqHUaJUp1uCIGqU6K8JZBZfErrxydn6ffknlNsA0
         QhqAUjw6mbUI3aA6OCfS5aLdB6CA0+E6FSRU6jDGpUzjDllEN5yrWVIRb+xF5GDoc84P
         LgiQ==
X-Forwarded-Encrypted: i=1; AHgh+RqwomujJEneQPh2Vu3NQTa2LbiM6bOAt+QnrK6H7DfPi7hask7kVeisSb+pPVAmGOVGAN8u@lists.linux.dev
X-Gm-Message-State: AOJu0YywDa++Y4oKHYu/I/Ew2QEmzJfelVj0956tvRopjV3evUuHTIg8
	TiGIp00SrOzvqBtyOHZjttm9XoSlDuyc9Lga9UUZcDo+mZdxtdmIag5f
X-Gm-Gg: AR+sD11LGJmMzrM4HVR+lSrdmd/h+CWC+tZpmwTZZFGbIN/toiYoe8EDCXewwecRg9s
	zyF/AC/Pl3lRQOqx8PS2H5eqnQvlsqaIwTWz9oZc4j04eCSdejo5YLV20l9zyN9dVLgCVENqKUC
	ZP+OZAQIlOcd0vnkhEQ3+XmZdKUHG+Al7Bw1BtxNXBDAmlOvYpx7KGg1vrYON7AyluxTKqAEZyf
	VkiCuFXqTclSK84HSGbv9n7ohDXa9Mjs8QRzIKVJonIUY7YMzPSn6TD844ZwXrAGOab/pg/b9gb
	5qa+CA+r9/VeNBKSCZ2TBuTJrMBtdT8zS0LhBjI1mUma7648UChuq61ahKeH1BuNRK/yXS60P1q
	xvJaxB4i2EbPoupDBs/b55KqUztzhTIZj9EhWBL5a4UQeq1emwOgiYQMPH+KQM5CT6WfiPnoN9a
	CYJLiWaI71K2fZSRMBeuow9F5ruyh6oXt7kAnNyVnJ7s5HpDwnQwxWVzblwCMwbzEPt3N52pyf0
	RqUAjM=
X-Received: by 2002:a05:6122:678b:b0:5c3:cbde:1bcf with SMTP id 71dfb90a1353d-5c3fe48e12dmr170712e0c.9.1786035596101;
        Thu, 06 Aug 2026 09:59:56 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c3d05c594fsm3706321e0c.8.2026.08.06.09.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 09:59:55 -0700 (PDT)
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
Subject: [PATCH v2 14/21] ocfs2: check for a metadata write error with buffer_write_io_error()
Date: Thu,  6 Aug 2026 12:58:37 -0400
Message-ID: <05cd3c34f2dc69b542db7baaef058cd75005d4cb.1785951556.git.coshi036@gmail.com>
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

ocfs2_write_block() and ocfs2_write_super_or_backup() detect a failed write
by looking at BH_Uptodate afterwards.  That relies on the write completion
handler clearing BH_Uptodate on error, which this series removes: a buffer
whose write failed still holds the data the filesystem asked to be written,
so declaring it not up to date is wrong and makes callers re-read it.

Test BH_Write_EIO instead.  Note that ocfs2_write_block()'s test is the
positive one, so the sense has to be inverted rather than the flag simply
swapped.

The comment in ocfs2_write_block()'s error arm needs updating for the same
reason.  It said the clustered uptodate information did not have to be
removed because the buffer was not marked locally uptodate; after this
series it is, so the reason no longer holds.  Not advertising the block to
the cluster is still the right thing to do - the data is in memory but not
on disk - so only the justification changes, not the behaviour.

No behaviour change today - a failed write sets BH_Write_EIO and clears
BH_Uptodate together.  It stops being a no-op at the end of the series,
where the new test is the one that still works.

Acked-by: Weidong Zhu <weizhu@fiu.edu>
Signed-off-by: Chao Shi <coshi036@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ocfs2/buffer_head_io.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
index 7bfe377af2df..733ceda79ca1 100644
--- a/fs/ocfs2/buffer_head_io.c
+++ b/fs/ocfs2/buffer_head_io.c
@@ -66,12 +66,14 @@ int ocfs2_write_block(struct ocfs2_super *osb, struct buffer_head *bh,
 
 	wait_on_buffer(bh);
 
-	if (buffer_uptodate(bh)) {
+	if (!buffer_write_io_error(bh)) {
 		ocfs2_set_buffer_uptodate(ci, bh);
 	} else {
-		/* We don't need to remove the clustered uptodate
-		 * information for this bh as it's not marked locally
-		 * uptodate. */
+		/*
+		 * The buffer still holds what we tried to write, but it did
+		 * not reach the disk, so don't advertise it to the cluster
+		 * as up to date.
+		 */
 		ret = -EIO;
 		mlog_errno(ret);
 	}
@@ -446,7 +448,7 @@ int ocfs2_write_super_or_backup(struct ocfs2_super *osb,
 
 	wait_on_buffer(bh);
 
-	if (!buffer_uptodate(bh)) {
+	if (buffer_write_io_error(bh)) {
 		ret = -EIO;
 		mlog_errno(ret);
 	}
-- 
2.43.0


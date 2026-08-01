Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E7D3D1CBE
	for <gfs2@lists.linux.dev>; Sat,  1 Aug 2026 22:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785621696; cv=none; b=l71D1d0O1uJ8b22GGFmq95ZrvpUrwtgtQHf1x5PltRkm35zoKUV6unzqn77UBDyZFa9tcY090CKdbMOXBH68AviVMR0fvenKvzqb5g2vfLPby9hO94v3CWn2qJC2ZLsdpMYRgtPCxoxQ2wwXrWWAa/kTgki/YLf09ZJe1Oer1Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785621696; c=relaxed/simple;
	bh=11/QTy2yfnrD1wjLL3sT4kKYG83gGCLz7L/Upg/VVro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecVOvxoujEPcbjYxAlphPOYTksP4wi4mXIHX/61MbOYsXp/3hEl8GaXiMWBJGn2cvu8DTrw6CnfRYsgQD6pusa2pgJ36+mE1huRDqadtbky0Ox1TjKTSeKkUZ3b60uteMU/9BHkd0FyngYuqDlxstxIRfceXPNNF/2eFcfqSZQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1tLX1t9; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1tLX1t9"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8114a4542b2so33657767b3.1
        for <gfs2@lists.linux.dev>; Sat, 01 Aug 2026 15:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785621692; x=1786226492; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6crITnQf0AA10KnjmQzAxCPQHRm39qApxGuVVNfjYZs=;
        b=k1tLX1t9+e8HgN7BK+zILr+RuMVSxwLwvkTroyP3hqtX6bhDkypCYtdOVIqINL/uAM
         VkEF3zia+CV2BVN+9B1iH1ysbf2NvhcuTtB5Vmgfr0BgL7n3hAHPH9GVh47wBhjX0BUS
         YcU8oWnpF9R8Ziye2CZRGUWMWmc1CdumttIrK3BM96Lkqa3L1t8MY6LcFsHzHx/08mxu
         ooQ5/cTiG3FfBukAsIpmle/QPGqOD2GUdlHH63GIjFSmXMyenQI6CsFTTSF1eH2Z21xM
         bN0ebIvwDGM5IY4YrdnqVQxUytMRVjIcQoeWgUQkkVhdM2ISH5XfgXXU/Ga6mn7zOng3
         bJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785621692; x=1786226492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6crITnQf0AA10KnjmQzAxCPQHRm39qApxGuVVNfjYZs=;
        b=EiRAu4chL0Jv0Y4EwnA/CLsSfwSUxRUlhhn9tOU9CJ2NvhsnYdyARHGedjpFbIjKQH
         ZOWVAvJC0sm0MyofbURcYwMweOph23JjsOBLLzIsi0L9IqSkCEu604j1GCafUX77wCwG
         WiRoJY/77dF2+8xFb7DNqjKJFtCkzOMyh61BLbWdrsLwWmBqCwXKraxKff0aiPxy88ik
         yj5f4ArwkoUFCggbuQr59F2yGdUb0ih2VHML+GzqBhXrIf48FlrndNPfJmmeAxiht7OO
         Qn0hNTFSTBj8tx7ZeBgcx0BHExo6X8Ml+6AacSeGDHR52myeWjLmxhIUKaRtSSBVeusV
         ++tw==
X-Forwarded-Encrypted: i=1; AHgh+RrtEdt6AFiqe/7GFvO5/jLaKaJBAixQO+irnVTuE9cG2KzUKk40lRAsAaUv7A4X311gvknJ@lists.linux.dev
X-Gm-Message-State: AOJu0YwCw7OL41GPyG08J2fbQBbRhdGDS2DAH9S0/BqHMDMC028K+Yxo
	IHlBDWDr8jB/4nOs3Qc3aRgsO3/1tW1IVLjwNZOeebi8JcIeLiSMJH58
X-Gm-Gg: AR+sD13wXw9W1EB1PzUO+2xqKBZZePFjjKUY5tdJfwBNmzAVKnOLk8StZnraHBPRLL/
	oZIbpyQTMou8jeOsuGIx8EblFYzb6rGg00ihTWykrRt3VSqyn26ChQj0Br/qgQKKcwSahC0LQpC
	T6KFq1fR79igpAJFXOZcBHy2Lj5QrPdS1+jouUPy9vq3x/iA/OLJLINyOL320RrRjnIP6I53wTg
	lqIAOggxoGno5Wb00ncjTmA2hkB8zPtYJSh7VwHju9DwlnRN5We2mmm/juIBAQf7/RKOb4TwOGz
	i2htYrrM7q14ppf0wV55U1QGoU07n7d8uEGJwwsqyKn6Gjij3oGfOoOeTid2VUsoZt6JRTD+KW3
	9mGC2tcbOZOr8XdNJqAlnV315YqGbWwtXqCv2qAidy171Whr522rizaQiy6e7ASrPPpdSLLb5ZT
	eAWRnq23YFOYkLr5ha8XHZBwPVVLMzg9L+SiPbMuVJmi1i4gea58/eKX+w7LG+893A7cY+Ugv3k
	xyZBwc=
X-Received: by 2002:a05:690c:450a:b0:809:9422:8c47 with SMTP id 00721157ae682-81fd4b5a2e1mr70880997b3.22.1785621692499;
        Sat, 01 Aug 2026 15:01:32 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd0d6fbbsm29903767b3.25.2026.08.01.15.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 15:01:31 -0700 (PDT)
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
Subject: [PATCH 16/19] jbd2: report journal write errors with BH_Write_EIO
Date: Sat,  1 Aug 2026 18:01:00 -0400
Message-ID: <f0e0fd8516487b774d8cf1384949a0c616921fbd.1785621505.git.coshi036@gmail.com>
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

The journal's own write completion handler,
journal_end_buffer_io_sync(), reports a failed write by clearing
BH_Uptodate, and the three places that wait for journal writes look for
that.  This series is removing that convention: a buffer whose write failed
still holds the data that was supposed to reach the disk, and saying it is
not up to date makes callers rewrite, re-read or WARN over data that was
never wrong.

Set BH_Write_EIO instead, with mark_buffer_write_io_error(), and test it in
journal_wait_on_commit_record() and in the two commit-phase waits.

The two changes have to go together, because commit phase 4 waits on a
mixed list: descriptor blocks are submitted with
journal_end_buffer_io_sync(), while revoke blocks go through
write_dirty_buffer() and land in bh_end_write().  bh_end_write() already
sets BH_Write_EIO, so converting the consumer alone would keep working for
revoke blocks and silently stop detecting failed descriptor writes.  With
the handler converted, both halves of the list report the same way.

mark_buffer_write_io_error() is safe on all of these buffers.  The shadow
buffers from jbd2_journal_write_metadata_buffer() have no folio and no
associated mapping, so it does nothing beyond setting the flag.  Descriptor
and commit blocks are ordinary buffers on the journal device, and marking
the journal's mapping with the error is what write_dirty_buffer() already
does for revoke blocks on the same device.

Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 fs/jbd2/commit.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 60273cddf434..8912786ebebb 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -39,7 +39,7 @@ static void journal_end_buffer_io_sync(struct bio *bio)
 	if (uptodate)
 		set_buffer_uptodate(bh);
 	else
-		clear_buffer_uptodate(bh);
+		mark_buffer_write_io_error(bh);
 	if (orig_bh) {
 		clear_and_wake_up_bit(BH_Shadow, &orig_bh->b_state);
 	}
@@ -169,7 +169,7 @@ static int journal_wait_on_commit_record(journal_t *journal,
 	clear_buffer_dirty(bh);
 	wait_on_buffer(bh);
 
-	if (unlikely(!buffer_uptodate(bh)))
+	if (unlikely(buffer_write_io_error(bh)))
 		ret = -EIO;
 	put_bh(bh);            /* One for getblk() */
 
@@ -840,7 +840,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		wait_on_buffer(bh);
 		cond_resched();
 
-		if (unlikely(!buffer_uptodate(bh)))
+		if (unlikely(buffer_write_io_error(bh)))
 			err = -EIO;
 		jbd2_unfile_log_bh(bh);
 		stats.run.rs_blocks_logged++;
@@ -883,7 +883,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		wait_on_buffer(bh);
 		cond_resched();
 
-		if (unlikely(!buffer_uptodate(bh)))
+		if (unlikely(buffer_write_io_error(bh)))
 			err = -EIO;
 
 		BUFFER_TRACE(bh, "ph5: control buffer writeout done: unfile");
-- 
2.43.0


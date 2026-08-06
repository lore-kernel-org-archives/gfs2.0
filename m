Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127D948B397
	for <gfs2@lists.linux.dev>; Thu,  6 Aug 2026 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035608; cv=none; b=YPi41CMy3tyFhGuGAFAldXkOXr6WRpgr8UJy1ns3Fc0NE+XCJHb7K+dB06xfGtCxIYOn0HOvNTqOzgshJ35jpyWq/W+4S29xt23IOTW1TFfNL2SUlQgGbqGInznuUuzmqk9yonA/fXxwyJ+8IAxjWyEoB8fDSNv3w33Y1ifFmhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035608; c=relaxed/simple;
	bh=nwDfftK6tDKKFwsyIY1zmP/nNMRDmqL5O9HNMSOfLoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=karXQ5OpzfWHXG5dNTDdPUw454QptN1CYvJjUuac6/PsSMkFATwiOAeiv+B/ILfy3Bff2znyUd0xmVvKtn7HUz3HTLCxzUqqDFQUtER0Fhd12moKtxUEUI7yw+7oH+hxkvxic0AGBIyw3+tVo8z5Tfl48aFEBfJnwkJHLOF0Jzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+QTjiVG; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+QTjiVG"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5c38565e774so714140e0c.2
        for <gfs2@lists.linux.dev>; Thu, 06 Aug 2026 10:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786035606; x=1786640406; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VOSQ52yeWBlRERTYkX4++c0c05H07NL60x8ILsT5aXA=;
        b=e+QTjiVGJO7eDsSVvPR8IKdrCUJLkpbf6ZlffLmiwN+Ef1XZfOLeGj7yr+RH4HYX0X
         7BG3kz6F+32Clsc9a3LQiHlRMCWuDJuCEc8mwUHJhRvsQf8an5st8sh5SooT13eYxMN7
         xSQhdz2LdBnGZnA7ClD6mMTl6RY6jkgYn0szqAlWQJ6RH90nrWcwO/U9TEblqn9CxkbJ
         aiPIO0ihJNyUH1Qg8IZesqn5FR5eh/Thu9U4kIsk8u8rfX+e4hJinwB4F1H5Uz1ZrKVz
         rYrR3QlRLCla/tcpaalNcSZUMp4T95l2Z8MHJaiDrABai28rx0gPXYRUgyaqAGCFVVC/
         6KxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786035606; x=1786640406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VOSQ52yeWBlRERTYkX4++c0c05H07NL60x8ILsT5aXA=;
        b=lGBlCG+hkJwN3qNFmWg64uoYShDXs+Khm15R44xWfSc8HElm72NbqEz8MxxCDkdaEw
         VtjKWggu6J3Uf1AOTgN9m28mFJfzj2jIhxuo2tRWPUB9NODuKOcy1LL0oQ9QEg5VBvhF
         qALqBHsddmAog3px6l9p9v1bbYiCsuT+QpAKWVZeJlcVbgSyw9WO7xHEBl/ENu9zsjOy
         4pcKZxFDpB0oHYVJYhS6fzweaFesQonOClughoW48zU2veJg8vIi9w2hCV5vJZODN+Cd
         oa3VsTeyoTDQnzewFaNxG/cftWHxBYOU9q2D5dvkJ1EyLuAGosT8L3wCw7fxiV/tYaaS
         mhVg==
X-Forwarded-Encrypted: i=1; AHgh+RqPxfzSjLb7rrH3nioDV3b4Vh1Z8Ygwo73ZggRDhdVh7RGezEVIFPdoyjiMX7vhTqmy2iqC@lists.linux.dev
X-Gm-Message-State: AOJu0YzXN3aMlzhuxDY59Vx3nK3Qv/biHEG8+uanqQ2tAS6qUAHDsKGT
	b39gM0+EVlpeBBpcCmerJspz/+jDzjquaVA55Dk1I6yBmuUS2YHWWbcb
X-Gm-Gg: AR+sD12vEXx3iacuhNRSaLYsAoFXQuu8xEQYY8OJUvHX7CqmGrvMjuiSD78TFFGRMEv
	uQCqG9u3GuQdYWEFr1/tIoBJw4OQJEyyPsGKVheInrVap88XZntWsMUg+VzMB+hrkdQvLO6Tbou
	RHfHRF19cY4z6EFCCY5mpeZGQvcKZQKub6VsNHusCVKcMWGnlkI9CNliaxP3xIQBA4D/qJvDB7k
	f9D8UZ9w4DS/qWMu7WVkeIaTdpYXXyWdQOkUqdSf9UV5Xli1BOsM93hNa5o7VcFFUDe6tNOkTyl
	+iW16M8V9JKdkMUlDTckYSHEH4WeCYUaCAJJsxGpXAJXNMY7Qc/OFAwtYL6T6/xaGdJriZ0DlG/
	vQvlRtz4OJy4CsVtVG5MGVvNXxjSFuxWLuwLomlz/uWcsMr2Vb+MbBz2ADvVwFimgeaSX5dYh2n
	Du0FlF80tlOrTFbquxf97Vpi5uTqDApQ7MGzdjKu7UJxeoQMQxyW578aEMwaVMrrmgZ1beUTRYG
	mCOnLc=
X-Received: by 2002:a05:6122:8f88:b0:5bf:b3a0:388c with SMTP id 71dfb90a1353d-5c3d91849cemr2185136e0c.6.1786035605840;
        Thu, 06 Aug 2026 10:00:05 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c3d05c594fsm3706321e0c.8.2026.08.06.10.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 10:00:05 -0700 (PDT)
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
Subject: [PATCH v2 18/21] jbd2: say what jbd2_freeze_jh_data()'s assertion is actually checking
Date: Thu,  6 Aug 2026 12:58:41 -0400
Message-ID: <713ffb9c0cdfe55499b3cdd2c06a59a2c152c46c.1785951556.git.coshi036@gmail.com>
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

The assertion that the buffer about to be copied out is up to date is
correct and stays, but its message - "Possible IO failure" - describes what
a buffer that is not up to date used to mean rather than what is being
checked.

Once this series stops clearing BH_Uptodate on write error, that reading is
wrong twice over.  A failed write no longer makes a buffer not up to date,
and a buffer that does carry BH_Write_EIO is fine here: it still holds
valid data and the journal will write it again.  What the assertion is
really guarding is that there is something valid to copy at all.

Say that instead.

Suggested-by: Jan Kara <jack@suse.cz>
Acked-by: Weidong Zhu <weizhu@fiu.edu>
Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 fs/jbd2/transaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 5cc7d097b2ac..85d84d909f78 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -920,7 +920,7 @@ static void jbd2_freeze_jh_data(struct journal_head *jh)
 	char *source;
 	struct buffer_head *bh = jh2bh(jh);
 
-	J_EXPECT_JH(jh, buffer_uptodate(bh), "Possible IO failure.\n");
+	J_EXPECT_JH(jh, buffer_uptodate(bh), "Buffer not uptodate!\n");
 	source = kmap_local_folio(bh->b_folio, bh_offset(bh));
 	/* Fire data frozen trigger just before we copy the data */
 	jbd2_buffer_frozen_trigger(jh, source, jh->b_triggers);
-- 
2.43.0


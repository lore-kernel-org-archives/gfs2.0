Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D794396B76
	for <gfs2@lists.linux.dev>; Sat,  1 Aug 2026 22:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785621676; cv=none; b=QZJL/YhjIPn+WssDTWYzlaIN1OTh6aMSD4YkGRaDBHi6Y5wA3txTtDRj00KyChdueSjd06nHsIg9AgRX9vWk7KQdmYP31NxZljU1mf2FzOlCNJ3N+yAsq5C54ZAHxaUJ8un5UUaW7Ci9zv4UZ/PNt7+EIzV39Gv5Deq8zIbioOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785621676; c=relaxed/simple;
	bh=SjXMq5r8DMa+oHg54Pyb7CIIaYbycUjnXKa6wiUICzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tRslDFYirHOeIwdZmvroDT7m9+zsDnjKuV1d7bWlL99GxsWpjF04+y6rU3ptkGhmvKSSJeS1/WA+R510cdDFk7gT/bcE/lp6zp94c3bEHacO8OuQROs/gPDp4AQjHOHq34OYcnpYsROARf9aY/1IAyi4Pkk4I80AkGE4GJzp5Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0HYN30o; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0HYN30o"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-81dfdbd86d1so22029607b3.1
        for <gfs2@lists.linux.dev>; Sat, 01 Aug 2026 15:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785621671; x=1786226471; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gohFf3fZxhqEtiFe2bU4t44nrD74JSO89+v5O5dAsXE=;
        b=j0HYN30owEJC51z3Xr0SVGTXuulX2fx/xZdFJl8i6pdKEVFIglGcWC+QACkR8CPi0d
         yNrUH3twE/XEfOoMntQfMFDi6+50U1OeWBejb7rEj5Yfw+ytukiQJdeEY2tz6KLuzqx2
         V+NDkOSBEYOKqob4uvs+dnLPHFfv2uWNzk/tBPqkLEpBTh+pYzxtb78qFy+MzOjLVRvw
         m336+4lbz7aF68ATgbnk4w3uJyu6K6UQtGPZmz/NIteh5Qk6N/dLwt5bzGGsyyW7U7PV
         Avmc88UasaztYQdjeKyPR2NxaMpCgWSrXijR21evTjIrTgZei1Zhgmi5LMK1GIcjWHbA
         5+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785621671; x=1786226471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gohFf3fZxhqEtiFe2bU4t44nrD74JSO89+v5O5dAsXE=;
        b=hsdAhL8BlvGzVk/nRYklVqCzDyJuYkj5BK1ZE/Ix6kb4m+NEO7vmC/ImANytA7OjxQ
         i4Ikm7F1eFv8wj5Ti/X/9Ops9sMfk/5ncSmR6RPtUwodaFmDP9ngGBmu6NHrquXQG0ml
         tkhdBe8Mx7q9+AS0UY9akGXhhiXjAtfrdovPnO4Dzz1Z2cGehfnVq0N+iCzcCqNwj4VB
         CX8y/yblmlsDvUNWzZkWi+xe152PTE7F7P08/jf9kbz+4J32MhfUjZEvVZ+x78WcMf++
         9UIo3Hei2b6cCEJ+GWXNpeetLNdOCFGV3YCIJO2cfDzbt3KISihVTXn4Jkp/ColXMBLC
         WVIg==
X-Forwarded-Encrypted: i=1; AHgh+RoyfFGMRJAjEcCG4IpKUz5O/myIADvZuwGUSrEBtLMGbhKUH2H6txmw+TGYxqE2yljD5Yiy@lists.linux.dev
X-Gm-Message-State: AOJu0YzRV6FvTfyXUyQN8SqitwQzXJ80fUw72cvKdvZX6KuS9B3sffMC
	m0FQsNkhQeJ9ELEeCegPoMQxwd48QTRomMXpS1UWkj9RehhZBD+qeyZN
X-Gm-Gg: AR+sD13zw2lGmOAKEV6XhYP5Y6OuwmVwY0A1dsRnA4ADE+KSCT1AB2jkt+JJnNqT/Jz
	Ia+epNnnsPgan+6fPkVqZg1CUp7ljOegWdSdXorxS8TF+rLTO++py010L7Ql5IGNl/Ue6TBkfhw
	PTgzAsiEX4o81uHK6gSGe48ea9VuxVrbwCn/h/NP39dfALVw/Q83V75ViCatfoKIk9pJyDuliOe
	hbrO0EYIiHAKWklbn6FEl3PotGqNaAdiwKRoEgGNe7T24oGBTvF5NPBSLSxHIHMxGCef+0qxuMD
	VunxeEyF6+oyXP1V0vTLdQZWDoTBGH4Z4j8AG8X497lC3Tj4L+i8U2U1T85pVbX+yMGIBn3Lgkr
	mHkPXNcIEA8b4Y8pNBhEOfy0xiCWgEHvX5UHjcCrjSuZRFMS9IrMUsuK5bAGd5y+W4BNgaHHz64
	wK7L/y903u/gJSxBVERGnpL8LN39G+kcE373r9Y43FmB02TEKBO41/28kV3q9C23o7zwpsbeSO4
	Y1KC+XyapLxKQxkKnI=
X-Received: by 2002:a05:690c:6e12:b0:80d:66b2:82c with SMTP id 00721157ae682-81fd4a95542mr74278777b3.16.1785621671027;
        Sat, 01 Aug 2026 15:01:11 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd0d6fbbsm29903767b3.25.2026.08.01.15.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 15:01:10 -0700 (PDT)
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
Subject: [PATCH 03/19] jbd2: point the shadow buffer at the frozen data directly
Date: Sat,  1 Aug 2026 18:00:47 -0400
Message-ID: <2824f30bbc43e6a0b318564fa641228e9a096e37.1785621505.git.coshi036@gmail.com>
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

When a metadata buffer has to be copied out before it can be journalled,
jbd2_journal_write_metadata_buffer() writes jh->b_frozen_data rather than
the page cache copy.  b_frozen_data is kmalloc()ed, so folio_set_bh() makes
the shadow buffer point at a slab folio.

That is not something the buffer_head layer can reason about.  A slab folio
overloads ->mapping, so a shadow buffer looks like it belongs to an
address_space when it does not.  buffer_set_crypto_ctx() already has to use
folio_mapping() to avoid tripping over this, and it is the reason
mark_buffer_write_io_error() cannot be called on a shadow buffer today.

Point the shadow buffer at the frozen data itself instead: leave b_folio
NULL and set b_data.  The previous patch taught fs/buffer.c to submit such
a buffer.  The two commit-path checksum helpers are the only other users of
the shadow buffer's contents, and they take the data directly rather than
kmapping a folio that is already mapped.

Note that the shadow buffer must not be passed to bh_offset() while
b_folio is NULL.  All four callers that can see one are handled here and in
the previous patch.

Tested with ext4 mounted data=journal,journal_checksum on a metadata_csum
filesystem, writing files whose every block begins with the JBD2 magic so
that escaping forces the copy-out, then crashing with sysrq-b without
unmounting and replaying the journal on the next mount.  Recovery
completed, the file contents matched, e2fsck -fn was clean, and an
instrumented build confirmed the b_folio == NULL path was taken.

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 fs/jbd2/commit.c  | 12 +++++++++---
 fs/jbd2/journal.c | 19 ++++++++++++++-----
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 3029cb6f6d64..60273cddf434 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -330,6 +330,8 @@ static __u32 jbd2_checksum_data(__u32 crc32_sum, struct buffer_head *bh)
 	char *addr;
 	__u32 checksum;
 
+	if (!bh->b_folio)
+		return crc32_be(crc32_sum, bh->b_data, bh->b_size);
 	addr = kmap_local_folio(bh->b_folio, bh_offset(bh));
 	checksum = crc32_be(crc32_sum, addr, bh->b_size);
 	kunmap_local(addr);
@@ -357,10 +359,14 @@ static void jbd2_block_tag_csum_set(journal_t *j, journal_block_tag_t *tag,
 		return;
 
 	seq = cpu_to_be32(sequence);
-	addr = kmap_local_folio(bh->b_folio, bh_offset(bh));
 	csum32 = jbd2_chksum(j->j_csum_seed, (__u8 *)&seq, sizeof(seq));
-	csum32 = jbd2_chksum(csum32, addr, bh->b_size);
-	kunmap_local(addr);
+	if (!bh->b_folio) {
+		csum32 = jbd2_chksum(csum32, bh->b_data, bh->b_size);
+	} else {
+		addr = kmap_local_folio(bh->b_folio, bh_offset(bh));
+		csum32 = jbd2_chksum(csum32, addr, bh->b_size);
+		kunmap_local(addr);
+	}
 
 	if (jbd2_has_feature_csum3(j))
 		tag3->t_checksum = cpu_to_be32(csum32);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 09efa337649e..9e4cb04587b4 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -329,6 +329,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 	struct buffer_head *new_bh;
 	struct folio *new_folio;
 	unsigned int new_offset;
+	bool frozen = false;
 	struct buffer_head *bh_in = jh2bh(jh_in);
 	journal_t *journal = transaction->t_journal;
 
@@ -354,8 +355,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 	 * we use that version of the data for the commit.
 	 */
 	if (jh_in->b_frozen_data) {
-		new_folio = virt_to_folio(jh_in->b_frozen_data);
-		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
+		frozen = true;
 		do_escape = jbd2_data_needs_escaping(jh_in->b_frozen_data);
 		if (do_escape)
 			jbd2_data_do_escape(jh_in->b_frozen_data);
@@ -400,13 +400,22 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 		jh_in->b_frozen_triggers = jh_in->b_triggers;
 
 copy_done:
-		new_folio = virt_to_folio(jh_in->b_frozen_data);
-		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
+		frozen = true;
 		jbd2_data_do_escape(jh_in->b_frozen_data);
 	}
 
 escape_done:
-	folio_set_bh(new_bh, new_folio, new_offset);
+	if (frozen) {
+		/*
+		 * b_frozen_data is slab memory, not page cache.  Point the
+		 * buffer at it directly rather than at a slab folio, whose
+		 * ->mapping is not an address_space.
+		 */
+		new_bh->b_folio = NULL;
+		new_bh->b_data = jh_in->b_frozen_data;
+	} else {
+		folio_set_bh(new_bh, new_folio, new_offset);
+	}
 	new_bh->b_size = bh_in->b_size;
 	new_bh->b_bdev = journal->j_dev;
 	new_bh->b_blocknr = blocknr;
-- 
2.43.0


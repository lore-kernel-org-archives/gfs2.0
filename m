Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510D2440A3C
	for <gfs2@lists.linux.dev>; Tue,  1 Sep 2026 03:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788233845; cv=none; b=RMlwfKC8DF10JHDJCh0BK1Ei8pwGva+JcyH2NRdNvPwUENIie4EA2PfjHX4Id25wbto5XvGc+eGeL38Y6NWm8DLvxAaqKnWGMBJ/Yvq9QP99XyxA89l7sJtbxiq+mp43lriOLLJ8wSguOsjhJU1Usyvkzars0djUJoZlpmXc+ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788233845; c=relaxed/simple;
	bh=yqJJYKb+G/E22m/OAgvFzqj5UMSEptqYLIVuMXJV3FM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T43trqOKAkRlbnnaTrl3Ly0caMhaYH41InBAzGvtKjk/HzU5WVhrD03wa9B3KrIeEaZYHQH1W8aqN4HSVN+PoviY+M7pTlC0/nrx4G6KnQG26a9Ip5zYGvIlA/lTQTpE4XGinW05ljYaLSmyUQaKDI9Dq5VW89oUS3IgTejr4HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJal7EG4; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJal7EG4"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc1ceadbd16so4640572a12.2
        for <gfs2@lists.linux.dev>; Mon, 31 Aug 2026 20:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788233841; x=1788838641; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Y/fADxvRxExbmfjSF20mYAtoYxHc/TwJOV7kDL/3Bkg=;
        b=LJal7EG4WicqDQPPvF1htBJDiHoGiFYxWNp7tXb5haGifAQoz3uN/ifF3Xrbq50Oqs
         V+vNlEgw71rK/hqYXT9xnGe5eDDRe5i1RmWZfqVAwwJSLLoR9LjrwIZEZsv8NC8uCHfI
         nBH11TwfSAz4j6WK80oNFDmkH7Wi+tYno3EhyJmSnoBeu5OKFYirljGwL19jeMu08KHH
         aUFkoZhtzRf/OeHRvT6GvmI9n3JzKhtlZ1H74DYwDlcZ0NK6v7GTZ2qAumDudJlBIB5v
         VSw32evwqgeZLB8m6RKYLslyv63pEYZdksFo4YjJBVbwcuC5LsS7hoJD/g5oa3EnYihY
         PZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788233841; x=1788838641;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y/fADxvRxExbmfjSF20mYAtoYxHc/TwJOV7kDL/3Bkg=;
        b=auQf3S6rJtiKM3o3Xlo1Y5yS7zngxEgG2zU1lto+qN7uR+XxQ6TN6420xphhN0rNfu
         v1prUBn3k2CTRDvo8yFiJayXnGmDqkS9l3gqGwl+uibkqM/mHsbjwYircHe+sh+/Orfv
         3Hpv9fSPl+LiJB1nMJJfHBN8zii5I3nLI9xqfcs9BeHsdKnYiO30qfj2gmcQDU+yVZTt
         UwZmukGwTgwDJ8VR/55N0n48JaxuN8QxtGaZ3nWhFZjADUDhC5d6A6Yxm8Aikbi9KOGa
         A0rbHI9vns+ZnUQcnde+DKLjoS4SGJoS0k7WgutQc64y36nn+YcQThNj9TXhhIkBNZzS
         3HDQ==
X-Forwarded-Encrypted: i=1; AKwUvBzWvLJNZV/4rxnEH9PKlotE2lJKXFFeYmF0mYzv1zi/ulUkDidSN2+ZvNmpayP2jkeaY7Xr@lists.linux.dev
X-Gm-Message-State: AFuF++kI6zE/zFmlX6fc5WwbtiM58/pdGAwFmmwzf+YRoINPkhJdEjG1
	ilrCx0QeOU14dcEa49uLwv/nenKZvKSvlIdW+x8PPQeRLEkyZursqzhS
X-Gm-Gg: AYBFou3ZepW9bSBghoQgV94Burbfjmj+vRQdsN2L0rUggfCVZoYqpDtncDSJZ+avVvW
	KZGhdnyJljeyZYphadAuxTDfIRUQJZp6CEVFYDJgdlDHepdVUtoO1gcsfCsVqjOtmCarRTrvSft
	fuvDJQYLjcTb+ugHXlonjH4FrApav3anuUQb35B0ObdXPwQXMmbnFvq5t/UAUo5x4JqYcGVd+qN
	dz2SDhfMWyeBug3k6TwATBNAH62Nl2NhDmmVEb9JWI0P7YdSmhymS5JFyCupQydDji2ZITG9A6J
	Cu1MXLi2A6sE4kuh9LZeCJfFUa1uWoXBp4OML4ekT8hku/NFxSEO029NEysjrHOjMgesS+y4u7f
	Nw4NXPY/1Icyj4jInq88ZrAPs1yj3TvhfeNgDm6g6Vknx6aITtWc4l8A7dLb+7PJB3MnguaLAxW
	vyR48T8ZcKo7jbsNf+MAyWie+DqMJgQH7HBMfrpGbpMEzP2BstXhzt451zhrVMl4Etd4CNnZrL0
	+uuGSL8ujVO
X-Received: by 2002:a17:90b:1e05:b0:398:9bd5:490c with SMTP id 98e67ed59e1d1-3989bd54c4emr26982077a91.19.1788233841226;
        Mon, 31 Aug 2026 20:37:21 -0700 (PDT)
Received: from [30.134.112.244] ([107.151.169.131])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9e907fsm30635648eec.25.2026.08.31.20.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 20:37:20 -0700 (PDT)
Message-ID: <20d3b629-e052-492f-9a24-ee700b259c37@gmail.com>
Date: Tue, 1 Sep 2026 11:37:14 +0800
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/21] jbd2: point the shadow buffer at the frozen data
 directly
To: Chao Shi <coshi036@gmail.com>, Jan Kara <jack@suse.cz>,
 Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Baokun Li <libaokun@linux.alibaba.com>, Ojaswin Mujoo
 <ojaswin@linux.ibm.com>, Ritesh Harjani <ritesh.list@gmail.com>,
 Zhang Yi <yi.zhang@huawei.com>, Zhang Yi <yi.zhang@huaweicloud.com>,
 Bob Copeland <me@bobcopeland.com>, Namjae Jeon <linkinjeon@kernel.org>,
 Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Andreas Gruenbacher <agruenba@redhat.com>, linux-ext4@vger.kernel.org,
 ocfs2-devel@lists.linux.dev, gfs2@lists.linux.dev,
 linux-kernel@vger.kernel.org, Weidong Zhu <weizhu@fiu.edu>
References: <cover.1785951556.git.coshi036@gmail.com>
 <6140cd23beb88e99f40eaeff4044a16213f6caab.1785951556.git.coshi036@gmail.com>
From: Joseph Qi <jiangqi903@gmail.com>
In-Reply-To: <6140cd23beb88e99f40eaeff4044a16213f6caab.1785951556.git.coshi036@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/7/26 12:58 AM, Chao Shi wrote:
> When a metadata buffer has to be copied out before it can be journalled,
> jbd2_journal_write_metadata_buffer() writes jh->b_frozen_data rather than
> the page cache copy.  b_frozen_data is kmalloc()ed, so folio_set_bh() makes
> the shadow buffer point at a slab folio.
> 
> That is not something the buffer_head layer can reason about.  A slab folio
> overloads ->mapping, so a shadow buffer looks like it belongs to an
> address_space when it does not.  buffer_set_crypto_ctx() already has to
> work around this, and it is the reason mark_buffer_write_io_error() cannot
> be called on a shadow buffer today.
> 
> Point the shadow buffer at the frozen data itself instead: leave b_folio
> NULL, which it already is out of alloc_buffer_head(), and set b_data.  The
> previous patch taught fs/buffer.c to submit such a buffer.  folio_set_bh()
> is now needed on only one path - the one that journals the page cache copy
> directly - so it moves there, and new_folio, new_offset and the flag that
> used to pick between them all go away.
> 
> The two commit-path checksum helpers reach the shadow buffer's contents
> through a new kmap_local_bh()/kunmap_local_bh() pair, which handle a buffer
> with or without a folio.  Memory outside the page cache is always mapped,
> so for those there is nothing to map or unmap.  Mapping it anyway would be
> worse than pointless: with CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP,
> kmap_local_page() hands back a one page mapping even for such memory, which
> is not enough for a buffer bigger than a page.
> 
> Tested with ext4 mounted data=journal,journal_checksum on a metadata_csum
> filesystem, writing files whose every block begins with the JBD2 magic so
> that escaping forces the copy-out, then crashing with sysrq-b without
> unmounting and replaying the journal on the next mount.  Recovery
> completed, the file contents matched, e2fsck -fn was clean, and an
> instrumented build confirmed the b_folio == NULL path was taken.
> 
> Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Weidong Zhu <weizhu@fiu.edu>
> Signed-off-by: Chao Shi <coshi036@gmail.com>
> ---
>  fs/jbd2/commit.c            |  8 ++++----
>  fs/jbd2/journal.c           | 29 +++++++++++++++++------------
>  include/linux/buffer_head.h | 29 +++++++++++++++++++++++++++++
>  3 files changed, 50 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 3029cb6f6d64..0c85af91f9b2 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -330,9 +330,9 @@ static __u32 jbd2_checksum_data(__u32 crc32_sum, struct buffer_head *bh)
>  	char *addr;
>  	__u32 checksum;
>  
> -	addr = kmap_local_folio(bh->b_folio, bh_offset(bh));
> +	addr = kmap_local_bh(bh);
>  	checksum = crc32_be(crc32_sum, addr, bh->b_size);
> -	kunmap_local(addr);
> +	kunmap_local_bh(bh, addr);
>  
>  	return checksum;
>  }
> @@ -357,10 +357,10 @@ static void jbd2_block_tag_csum_set(journal_t *j, journal_block_tag_t *tag,
>  		return;
>  
>  	seq = cpu_to_be32(sequence);
> -	addr = kmap_local_folio(bh->b_folio, bh_offset(bh));
> +	addr = kmap_local_bh(bh);
>  	csum32 = jbd2_chksum(j->j_csum_seed, (__u8 *)&seq, sizeof(seq));
>  	csum32 = jbd2_chksum(csum32, addr, bh->b_size);
> -	kunmap_local(addr);
> +	kunmap_local_bh(bh, addr);
>  
>  	if (jbd2_has_feature_csum3(j))
>  		tag3->t_checksum = cpu_to_be32(csum32);
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 09efa337649e..6e05dc47e20a 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -327,8 +327,6 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  {
>  	int do_escape = 0;
>  	struct buffer_head *new_bh;
> -	struct folio *new_folio;
> -	unsigned int new_offset;
>  	struct buffer_head *bh_in = jh2bh(jh_in);
>  	journal_t *journal = transaction->t_journal;
>  
> @@ -348,24 +346,31 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  	/* keep subsequent assertions sane */
>  	atomic_set(&new_bh->b_count, 1);
>  
> +	/*
> +	 * b_frozen_data is slab memory, not page cache, so when we use it the
> +	 * shadow buffer gets no folio at all: b_folio stays NULL from the
> +	 * allocation and b_data points straight at the copy.  Pointing it at
> +	 * the slab folio instead would hand its overloaded ->mapping to
> +	 * anything that goes looking for an address_space.
> +	 */
> +
>  	spin_lock(&jh_in->b_state_lock);
>  	/*
>  	 * If a new transaction has already done a buffer copy-out, then
>  	 * we use that version of the data for the commit.
>  	 */
>  	if (jh_in->b_frozen_data) {
> -		new_folio = virt_to_folio(jh_in->b_frozen_data);
> -		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
>  		do_escape = jbd2_data_needs_escaping(jh_in->b_frozen_data);
>  		if (do_escape)
>  			jbd2_data_do_escape(jh_in->b_frozen_data);
> +		new_bh->b_data = jh_in->b_frozen_data;
>  	} else {
> +		struct folio *folio = bh_in->b_folio;
> +		unsigned int offset = offset_in_folio(folio, bh_in->b_data);
>  		char *tmp;
>  		char *mapped_data;
>  
> -		new_folio = bh_in->b_folio;
> -		new_offset = offset_in_folio(new_folio, bh_in->b_data);
> -		mapped_data = kmap_local_folio(new_folio, new_offset);
> +		mapped_data = kmap_local_folio(folio, offset);
>  		/*
>  		 * Fire data frozen trigger if data already wasn't frozen. Do
>  		 * this before checking for escaping, as the trigger may modify
> @@ -379,8 +384,10 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  		/*
>  		 * Do we need to do a data copy?
>  		 */
> -		if (!do_escape)
> +		if (!do_escape) {
> +			folio_set_bh(new_bh, folio, offset);
>  			goto escape_done;
> +		}
>  
>  		spin_unlock(&jh_in->b_state_lock);
>  		tmp = kmalloc(bh_in->b_size, GFP_NOFS | __GFP_NOFAIL);
> @@ -391,7 +398,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  		}
>  
>  		jh_in->b_frozen_data = tmp;
> -		memcpy_from_folio(tmp, new_folio, new_offset, bh_in->b_size);
> +		memcpy_from_folio(tmp, folio, offset, bh_in->b_size);
>  		/*
>  		 * This isn't strictly necessary, as we're using frozen
>  		 * data for the escaping, but it keeps consistency with
> @@ -400,13 +407,11 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  		jh_in->b_frozen_triggers = jh_in->b_triggers;
>  
>  copy_done:
> -		new_folio = virt_to_folio(jh_in->b_frozen_data);
> -		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
>  		jbd2_data_do_escape(jh_in->b_frozen_data);
> +		new_bh->b_data = jh_in->b_frozen_data;
>  	}
>  
>  escape_done:
> -	folio_set_bh(new_bh, new_folio, new_offset);
>  	new_bh->b_size = bh_in->b_size;
>  	new_bh->b_bdev = journal->j_dev;
>  	new_bh->b_blocknr = blocknr;
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index 699970b4bbf2..20b8fca1abfa 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -172,6 +172,35 @@ static inline unsigned long bh_offset(const struct buffer_head *bh)
>  	return (unsigned long)(bh)->b_data & (folio_size(bh->b_folio) - 1);
>  }
>  
> +/**
> + * kmap_local_bh - Map the data of a buffer.
> + * @bh: The buffer.
> + *
> + * Buffers usually live in the page cache, but a few are built over memory
> + * which is not.  Those carry no folio and b_data is already a kernel address
> + * which is always mapped, so there is nothing to do for them.  Pair with
> + * kunmap_local_bh().
> + *
> + * Return: A pointer to the buffer's data.
> + */
> +static inline void *kmap_local_bh(const struct buffer_head *bh)
> +{
> +	if (!bh->b_folio)
> +		return bh->b_data;
> +	return kmap_local_folio(bh->b_folio, bh_offset(bh));
> +}
> +
> +/**
> + * kunmap_local_bh - Unmap the data of a buffer.
> + * @bh: The buffer.
> + * @addr: The address returned by kmap_local_bh().
> + */
> +static inline void kunmap_local_bh(const struct buffer_head *bh, void *addr)
> +{
> +	if (bh->b_folio)
> +		kunmap_local(addr);
> +}
> +
>  /* If we *know* page->private refers to buffer_heads */
>  #define page_buffers(page)					\
>  	({							\

When tested ocfs2 on next-20260831, I've encountered the following NULL
pointer dereference:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  RIP: 0010:__bh_submit.constprop.0+0x87/0x120
  Call Trace:
    jbd2_journal_commit_transaction+0x932/0x1b10
    kjournald2+0xb2/0x250

Commit a2c924c240e7 ("buffer: set BIO_COMPLETE_IN_TASK for dropbehind
writeback") added an unconditional folio_test_dropbehind(bh->b_folio) in
__bh_submit(). But jbd2 shadow buffers have a NULL b_folio since commit
5febcba29792 ("jbd2: point the shadow buffer at the frozen data
directly") made them point b_data at the kmalloced frozen data rather
than a folio. So submitting such a buffer during journal commit oopses.

A simple fix:

diff --git a/fs/buffer.c b/fs/buffer.c
index 427d8a817cd5..f46fa6413032 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1106,7 +1106,8 @@ static void __bh_submit(struct buffer_head *bh, blk_opf_t opf,
 
 	bio = bio_alloc(bh->b_bdev, 1, opf, GFP_NOIO);
 
-	if (folio_test_dropbehind(bh->b_folio) && op_is_write(opf))
+	if (bh->b_folio && folio_test_dropbehind(bh->b_folio) &&
+	    op_is_write(opf))
 		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
 
 	if (IS_ENABLED(CONFIG_FS_ENCRYPTION))

Thanks,
Joseph

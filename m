Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60FB1F7071
	for <gfs2@lists.linux.dev>; Tue,  3 Dec 2024 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238169; cv=none; b=rQB3YEosZS5d/2jckPOe5WEDo59RbmPcbbyZolCIL/Ihbpsh10pKOjwN+VfpNaGPUrn3xV80ENEP81gyokN+zc3Fd3L/mndcF9eNhUQTuDWG3jE/LGWtY+BpD7aj6NdpOTSixKkuSG5z7OlfFXX53Dd9RFNm1Hv6Q6XB2m3IV8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238169; c=relaxed/simple;
	bh=ShaZpfsVuba+wtb/lxe3PH06vr4NJGBf4eM6tEyRIgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opxnaVzwCKNJjOunXhN4KPq90aDa4FS22BDc98zokkc/Zz5Wv+KswrcUSaBr/6Vnr1uYad7aSLJVJotwOMNppITPj17qs5BU1bF/74WlFdHHS7VHlRx2D3eMnIGhNOlIFVw/sbxMhqVVGPv8qol8F+u1zGvl3lxtd+OslOiKZRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PN2mBYLd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eD+hWmAP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qy7NIDGU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TQu7Ppb4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PN2mBYLd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eD+hWmAP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qy7NIDGU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TQu7Ppb4"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C648F1F445;
	Tue,  3 Dec 2024 15:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733238166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MUkusswEBb3CfTEuLbr6LUUXTNX8FstdWIkxUOrGnWI=;
	b=PN2mBYLdikjMZe2J56vaJy1ACOsvBwQ9WmfLxmj0Ch6A5IMDU3SCkyKWCupk+AABySuS78
	gmYuYlu5GDmwbhcbJrcEi093zM9lrmWyDt8lDmsd63dmMfyWyA4X+fpHCR5EXIffsBaXnd
	xk4L61tJAfwWAy8Uxu++kIWF0FNrSlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733238166;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MUkusswEBb3CfTEuLbr6LUUXTNX8FstdWIkxUOrGnWI=;
	b=eD+hWmAP2lNYgWfnIiU+pWep4vWf8Vb9Au3V039hXnlc3eG1RziLu9AMijOEhbuH0uNF+O
	VvzgpYHCRz0BsODQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733238164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MUkusswEBb3CfTEuLbr6LUUXTNX8FstdWIkxUOrGnWI=;
	b=Qy7NIDGUl0s3M0VaRSQHGcCKwTee+zuJcb8XYEoX4R4YvGyv7YF40X8BOSYYRDs8/ZIxe8
	4vHil2wjQQHrIhVCaKXn9HRLB/cNv1mccLQUPfyD9ztETeINfyM+IiEOyt9RqNwDTlpztO
	zaWTtUJ8QI3MpVXPlgrbRX1xblTF3Pg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733238164;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MUkusswEBb3CfTEuLbr6LUUXTNX8FstdWIkxUOrGnWI=;
	b=TQu7Ppb407sBuJ4A+Klhr8YSDKcs5la5Tf2ayXsHIyrRZw/A3UvxtYi31BISvoTBUipTe3
	cPuYHLAuItwwt2AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99237139C2;
	Tue,  3 Dec 2024 15:02:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q7FYJZQdT2cjPwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Dec 2024 15:02:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CFFBCA08FB; Tue,  3 Dec 2024 16:02:39 +0100 (CET)
Date: Tue, 3 Dec 2024 16:02:39 +0100
From: Jan Kara <jack@suse.cz>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Tejun Heo <tj@kernel.org>, Andreas Gruenbacher <agruenba@redhat.com>,
	syzbot+e14d6cd6ec241f507ba7@syzkaller.appspotmail.com,
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
	Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
	Wu Fengguang <fengguang.wu@intel.com>,
	Greg Thelen <gthelen@google.com>, gfs2@lists.linux.dev
Subject: Re: WARNING in __folio_mark_dirty (2)
Message-ID: <20241203150239.6ibpyziqapxbeenm@quack3>
References: <CABOYnLwGoNXXzvvn+YmCcjLu6ttAJGGTaN8+O_tNdPqcjHnfUA@mail.gmail.com>
 <20231213-drehen-einquartieren-56bbdda1177e@brauner>
 <CAHc6FU7R+mb3Eh11oOfvDVNg-Zsb-zE9CLEhr4yDKJKU5+ABHA@mail.gmail.com>
 <ebfe4024-f908-458d-9979-6ff2931c460d@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebfe4024-f908-458d-9979-6ff2931c460d@I-love.SAKURA.ne.jp>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[e14d6cd6ec241f507ba7];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.30
X-Spam-Flag: NO

Hello,

On Tue 03-12-24 23:44:39, Tetsuo Handa wrote:
> syzbot is hitting WARN_ON_ONCE() introduced by commit aaa2cacf8184 ("writeback:
> add lockdep annotation to inode_to_wb()"). Since this warning can be triggered
> without using crafted/corrupted filesystem image, I assume that either that
> commit has missed something or gfs2 filesystem is doing something unusual.
> 
> Steps to reproduce this warning is shown below.
> 
>   # truncate -s 1G testfile.img
>   # mkfs.gfs2 -p lock_nolock -t syz:syz testfile.img
>   # mount -o loop testfile.img /mnt/
>   # echo test > /mnt/file
>   # sync
> 
> This warning goes away if I add "struct address_space *mapping" argument
> to inode_to_wb() and change the lockdep annotation to check
> mapping->i_pages.xa_lock instead of inode->i_mapping->i_pages.xa_lock .
> 
> Also, when this warning happens, inode->i_mapping != mapping is true and
> it seems that inode->i_mapping points to the same address.
> 
> Question to start for Tejun is, how did you come to an expectation that
> we should check inode->i_mapping rather than mapping ?

Well, mapping->host->i_mapping should better be equal to mapping, or weird
things happen...  like this one :) But I do have a vague recollection that
gfs2 breaks this assumption of VFS/MM layers and we've been already
discussing that in the past. Andreas?

									Honza

> 
> ----------
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index fcd4c1439cb9..d990a65f3253 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2721,6 +2721,19 @@ bool noop_dirty_folio(struct address_space *mapping, struct folio *folio)
>  }
>  EXPORT_SYMBOL(noop_dirty_folio);
>  
> +static inline struct bdi_writeback *inode_to_wb2(const struct inode *inode, struct address_space *mapping)
> +{
> +#ifdef CONFIG_LOCKDEP
> +	if (inode->i_mapping != mapping)
> +		printk("inode=%px inode->i_mapping=%px mapping=%px\n", inode, inode->i_mapping, mapping);
> +	WARN_ON(debug_locks &&
> +		(!lockdep_is_held(&inode->i_lock) &&
> +		 !lockdep_is_held(&mapping->i_pages.xa_lock) && // <= replaced
> +		 !lockdep_is_held(&inode->i_wb->list_lock)));
> +#endif
> +	return inode->i_wb;
> +}
> +
>  /*
>   * Helper function for set_page_dirty family.
>   *
> @@ -2740,7 +2753,7 @@ static void folio_account_dirtied(struct folio *folio,
>  		long nr = folio_nr_pages(folio);
>  
>  		inode_attach_wb(inode, folio);
> -		wb = inode_to_wb(inode);
> +		wb = inode_to_wb2(inode, mapping);
>  
>  		__lruvec_stat_mod_folio(folio, NR_FILE_DIRTY, nr);
>  		__zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, nr);
> @@ -3085,7 +3098,7 @@ bool __folio_end_writeback(struct folio *folio)
>  		__xa_clear_mark(&mapping->i_pages, folio_index(folio),
>  					PAGECACHE_TAG_WRITEBACK);
>  		if (bdi->capabilities & BDI_CAP_WRITEBACK_ACCT) {
> -			struct bdi_writeback *wb = inode_to_wb(inode);
> +			struct bdi_writeback *wb = inode_to_wb2(inode, mapping);
>  
>  			wb_stat_mod(wb, WB_WRITEBACK, -nr);
>  			__wb_writeout_add(wb, nr);
> @@ -3134,7 +3147,7 @@ void __folio_start_writeback(struct folio *folio, bool keep_write)
>  
>  		xas_set_mark(&xas, PAGECACHE_TAG_WRITEBACK);
>  		if (bdi->capabilities & BDI_CAP_WRITEBACK_ACCT) {
> -			struct bdi_writeback *wb = inode_to_wb(inode);
> +			struct bdi_writeback *wb = inode_to_wb2(inode, mapping);
>  
>  			wb_stat_mod(wb, WB_WRITEBACK, nr);
>  			if (!on_wblist)
> 
> [   85.160317] inode=ffff9f508f3d8668 inode->i_mapping=ffff9f508f3d8888 mapping=ffff9f50ad73abc0
> [   85.161923] inode=ffff9f508f3d8668 inode->i_mapping=ffff9f508f3d8888 mapping=ffff9f5090621ab0
> [   85.162644] inode=ffff9f508f3d8668 inode->i_mapping=ffff9f508f3d8888 mapping=ffff9f5090621f80
> [   85.163512] inode=ffff9f508f3d8668 inode->i_mapping=ffff9f508f3d8888 mapping=ffff9f50b12c7af0
> [   85.164439] inode=ffff9f508f3d8668 inode->i_mapping=ffff9f508f3d8888 mapping=ffff9f5090621f80
> [   85.167314] inode=ffff9f508f3d8668 inode->i_mapping=ffff9f508f3d8888 mapping=ffff9f5090621f80
> [   85.168533] inode=ffff9f508f3d8668 inode->i_mapping=ffff9f508f3d8888 mapping=ffff9f50b12c7af0
> [   85.169780] inode=ffff9f508f3d8668 inode->i_mapping=ffff9f508f3d8888 mapping=ffff9f50b12c7af0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

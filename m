Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783981BF33F
	for <gfs2@lists.linux.dev>; Mon, 13 Jan 2025 11:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736769178; cv=none; b=bkWKP5wRDIeXBcfET0yqwhdxxsRK6Qr3PC9Ek1QRniR0yKHX0NyJWwB1TwaDu3qO6NimXe7mSmvo3oo1XAqONGonyKIijW+rmTfcLoE8M5iJjMJN4fnyrcmfYkJ6WWjTQn0iOuOiuG/qfuWQeoqO6GeMNBcz3E3YPpOVopgCdiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736769178; c=relaxed/simple;
	bh=moN1oqIzV2RfQytoXjnqEEI1M+48mJpOpaJX3vo4GjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gd4hmjGge7AfFPbcSx6X+HIC4W32RCJ6w8D3/Dcyq5TPNIB8rXutuVnpQdtqNxxduWabrR+beNTLT8OX0uiNp5NI1BhrpZXNSak2WGaKEXGqTdKgFml/huLUGlp0T5pBj0mrZ9nYi3Cev3JmG0cdSiQ2+9hRKAd6VApELL+N9C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NRtmyGbd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uxdyA7Gi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NRtmyGbd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uxdyA7Gi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NRtmyGbd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uxdyA7Gi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NRtmyGbd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uxdyA7Gi"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 64477210FA;
	Mon, 13 Jan 2025 11:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736769173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C2sQZVCmCXQGt+5NS9bk2LJyTi8g+XPncU+k5GDb+0Y=;
	b=NRtmyGbd4Ljs2a4LWhcqiCOO1zcoCncaE9XMZGrkYqilOWLET/NnVAXM8Hs4meGOHQMaGO
	FTR1btKUJODL/ObFLx+YD3CYCWgrXZmDi0AM4wtMn5Ylt+dXgCWloTPhkIgKxJQmZKbR2y
	X0BD3X1wd2nXnrH7uVtWURAhGhFGuh8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736769173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C2sQZVCmCXQGt+5NS9bk2LJyTi8g+XPncU+k5GDb+0Y=;
	b=uxdyA7GiKUSjodTGWXGxrvfdJy8H+rAEfiUsWmjLtvx3bENqJzWRZ++ZVkonzcpc94MSFk
	+28YUgWhcYtJpcBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=NRtmyGbd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uxdyA7Gi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736769173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C2sQZVCmCXQGt+5NS9bk2LJyTi8g+XPncU+k5GDb+0Y=;
	b=NRtmyGbd4Ljs2a4LWhcqiCOO1zcoCncaE9XMZGrkYqilOWLET/NnVAXM8Hs4meGOHQMaGO
	FTR1btKUJODL/ObFLx+YD3CYCWgrXZmDi0AM4wtMn5Ylt+dXgCWloTPhkIgKxJQmZKbR2y
	X0BD3X1wd2nXnrH7uVtWURAhGhFGuh8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736769173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C2sQZVCmCXQGt+5NS9bk2LJyTi8g+XPncU+k5GDb+0Y=;
	b=uxdyA7GiKUSjodTGWXGxrvfdJy8H+rAEfiUsWmjLtvx3bENqJzWRZ++ZVkonzcpc94MSFk
	+28YUgWhcYtJpcBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5228813310;
	Mon, 13 Jan 2025 11:52:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pHwKFJX+hGdpBgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 Jan 2025 11:52:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EB12AA08E0; Mon, 13 Jan 2025 12:52:44 +0100 (CET)
Date: Mon, 13 Jan 2025 12:52:44 +0100
From: Jan Kara <jack@suse.cz>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>, 
	Andreas Gruenbacher <agruenba@redhat.com>, syzbot+e14d6cd6ec241f507ba7@syzkaller.appspotmail.com, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Jens Axboe <axboe@kernel.dk>, 
	Wu Fengguang <fengguang.wu@intel.com>, Greg Thelen <gthelen@google.com>, gfs2@lists.linux.dev
Subject: Re: WARNING in __folio_mark_dirty (2)
Message-ID: <b3eojhlvvva7jhs5uv2ddf7cltx5ao4aay7p3p6uacdz7kt6ti@pup2xblqsd73>
References: <CABOYnLwGoNXXzvvn+YmCcjLu6ttAJGGTaN8+O_tNdPqcjHnfUA@mail.gmail.com>
 <20231213-drehen-einquartieren-56bbdda1177e@brauner>
 <CAHc6FU7R+mb3Eh11oOfvDVNg-Zsb-zE9CLEhr4yDKJKU5+ABHA@mail.gmail.com>
 <ebfe4024-f908-458d-9979-6ff2931c460d@I-love.SAKURA.ne.jp>
 <20241203150239.6ibpyziqapxbeenm@quack3>
 <e346d089-7526-47ea-a64a-b75a578d2362@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e346d089-7526-47ea-a64a-b75a578d2362@I-love.SAKURA.ne.jp>
X-Rspamd-Queue-Id: 64477210FA
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[e14d6cd6ec241f507ba7];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 13-01-25 18:35:02, Tetsuo Handa wrote:
> While no response from Andreas yet, I found that
> 
> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> index 8e7af9a03b41..90038ec2cfa2 100644
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -249,6 +249,7 @@ static inline struct bdi_writeback *inode_to_wb(const struct inode *inode)
>  {
>  #ifdef CONFIG_LOCKDEP
>  	WARN_ON_ONCE(debug_locks &&
> +		     !sb_is_blkdev_sb(inode->i_sb) &&
>  		     (!lockdep_is_held(&inode->i_lock) &&
>  		      !lockdep_is_held(&inode->i_mapping->i_pages.xa_lock) &&
>  		      !lockdep_is_held(&inode->i_wb->list_lock)));
> 
> fixes this problem.
> 
> It seems to me that commit 692ebd17c290 ("bdi: Fix warnings in __mark_inode_dirty
> for /dev/zero and friends") started special handling for inode_to_bdi(). Thus, I
> still suspect that we need some special handling for inode_to_wb() as well. Who is
> familiar with differences between normal filesystems and bdev filesystem?

So I have refreshed my memory regarding the hacks gfs2 does with struct
address_space. It has struct gfs2_glock_aspace which contains struct
address_space which is attached to a glock (filesystem cluster lock). This
address_space is setup in gfs2_glock_get() like:

                mapping->a_ops = &gfs2_meta_aops;
                mapping->host = s->s_bdev->bd_mapping->host;
                mapping->flags = 0;
                mapping_set_gfp_mask(mapping, GFP_NOFS);
                mapping->i_private_data = NULL;
                mapping->writeback_index = 0;

Hence mapping->host->i_mapping != mapping as you've observed in your first
email and this is what confuses writeback code. This also explains why your
sb_is_blkdev_sb(inode->i_sb) check works because gfs2 uses bdev inode as a
"stub" mapping host.

Anyway, your suggestion brought me to an idea how this warning could be
improved without having to mess with gfs2. Can you try modifying the WARN
as:

 #ifdef CONFIG_LOCKDEP
- 	WARN_ON_ONCE(debug_locks &&
+	WARN_ON_ONCE(debug_locks && inode_cgwb_enabled(inode) &&
 		     (!lockdep_is_held(&inode->i_lock) &&
 		      !lockdep_is_held(&inode->i_mapping->i_pages.xa_lock) &&
 		      !lockdep_is_held(&inode->i_wb->list_lock)));

This should fix the warning and without cgroup writeback inode->i_wb should
be stable and there's no need for locking around it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

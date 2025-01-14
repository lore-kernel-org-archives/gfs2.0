Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3691ADC8E
	for <gfs2@lists.linux.dev>; Tue, 14 Jan 2025 10:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736849224; cv=none; b=q13QYhHRzdGoWfjHksT5DVQaxDQrFlFUeRWbcdnC7F0spMSwb7znIFkRJCSQONtC8rk1HMfSEj5xTUS9YNn1CC/zGS4AZ8lgmkmbQL6Hn+mWY+1uIAtzHSxcoSK76Acnn3CuvEfFNq8Si0Rp+edjfkxrB4ZgQcm9vaDfQGN5UeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736849224; c=relaxed/simple;
	bh=xFuZ+f+1IxFtKzyyrvsYGGe2whdFMQUnQNDU9ZfnJOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFTcRGgDtwEECZXnz0EpCBcX3ZcOZBfKgfjhEqLBna5FQFdYuTmSCQMVeL9xTp9yG21c9Wtylm4/ni3LWkNJyFbpW5fE6byuik2j19wL29kcEwjBSCfFtRYpF9XqS36Xdn+HMLDzOzB6gCq07wcufreyTiJgr61iHG2CvxxHR6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pYpd8ATR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9T1PiGjR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pYpd8ATR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9T1PiGjR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pYpd8ATR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9T1PiGjR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pYpd8ATR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9T1PiGjR"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9258421137;
	Tue, 14 Jan 2025 10:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736849220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k7wNQrZ0VxW3wn8ON/iq7R+kizMRw2L25k5kHmr/9/w=;
	b=pYpd8ATRm6/FTgMynv3RhvRdDpJ/1Vaj78rpQt2rJ9kuHH+CVE9LlN5A8NOFZWPjqEvB+f
	YFyQnIa7yT1HLXL889G87SKB7nByR/cAjKWXTrL6AJKqFlo4PLwpNZZf/q2STrAMC4DUsX
	h7+9fIn+QHdnPcpNXokcsU2okL16oNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736849220;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k7wNQrZ0VxW3wn8ON/iq7R+kizMRw2L25k5kHmr/9/w=;
	b=9T1PiGjRjDHgnnoeSTqU8oUPwvoxAKvtIB4BrD68E5HNo39Okmfs4Jb4HcSFkXzupKcniB
	UPsg7SIW9h8WBUCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pYpd8ATR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9T1PiGjR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736849220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k7wNQrZ0VxW3wn8ON/iq7R+kizMRw2L25k5kHmr/9/w=;
	b=pYpd8ATRm6/FTgMynv3RhvRdDpJ/1Vaj78rpQt2rJ9kuHH+CVE9LlN5A8NOFZWPjqEvB+f
	YFyQnIa7yT1HLXL889G87SKB7nByR/cAjKWXTrL6AJKqFlo4PLwpNZZf/q2STrAMC4DUsX
	h7+9fIn+QHdnPcpNXokcsU2okL16oNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736849220;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k7wNQrZ0VxW3wn8ON/iq7R+kizMRw2L25k5kHmr/9/w=;
	b=9T1PiGjRjDHgnnoeSTqU8oUPwvoxAKvtIB4BrD68E5HNo39Okmfs4Jb4HcSFkXzupKcniB
	UPsg7SIW9h8WBUCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76DD21384C;
	Tue, 14 Jan 2025 10:07:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iHMAHUQ3hmcqBgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 14 Jan 2025 10:07:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 256D2A08CD; Tue, 14 Jan 2025 11:06:56 +0100 (CET)
Date: Tue, 14 Jan 2025 11:06:56 +0100
From: Jan Kara <jack@suse.cz>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>, 
	Andreas Gruenbacher <agruenba@redhat.com>, syzbot+e14d6cd6ec241f507ba7@syzkaller.appspotmail.com, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Jens Axboe <axboe@kernel.dk>, 
	Wu Fengguang <fengguang.wu@intel.com>, Greg Thelen <gthelen@google.com>, gfs2@lists.linux.dev
Subject: Re: WARNING in __folio_mark_dirty (2)
Message-ID: <72dojflhsnr4abqgfyl2qzmqsifx4vcucaqlzkskspkmy76i76@cmk3em7ysnv3>
References: <CABOYnLwGoNXXzvvn+YmCcjLu6ttAJGGTaN8+O_tNdPqcjHnfUA@mail.gmail.com>
 <20231213-drehen-einquartieren-56bbdda1177e@brauner>
 <CAHc6FU7R+mb3Eh11oOfvDVNg-Zsb-zE9CLEhr4yDKJKU5+ABHA@mail.gmail.com>
 <ebfe4024-f908-458d-9979-6ff2931c460d@I-love.SAKURA.ne.jp>
 <20241203150239.6ibpyziqapxbeenm@quack3>
 <e346d089-7526-47ea-a64a-b75a578d2362@I-love.SAKURA.ne.jp>
 <b3eojhlvvva7jhs5uv2ddf7cltx5ao4aay7p3p6uacdz7kt6ti@pup2xblqsd73>
 <d34005db-9fe2-4b1e-acf6-54976e07d939@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d34005db-9fe2-4b1e-acf6-54976e07d939@I-love.SAKURA.ne.jp>
X-Rspamd-Queue-Id: 9258421137
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[e14d6cd6ec241f507ba7];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 13-01-25 22:06:22, Tetsuo Handa wrote:
> On 2025/01/13 20:52, Jan Kara wrote:
> > Anyway, your suggestion brought me to an idea how this warning could be
> > improved without having to mess with gfs2. Can you try modifying the WARN
> > as:
> > 
> >  #ifdef CONFIG_LOCKDEP
> > - 	WARN_ON_ONCE(debug_locks &&
> > +	WARN_ON_ONCE(debug_locks && inode_cgwb_enabled(inode) &&
> >  		     (!lockdep_is_held(&inode->i_lock) &&
> >  		      !lockdep_is_held(&inode->i_mapping->i_pages.xa_lock) &&
> >  		      !lockdep_is_held(&inode->i_wb->list_lock)));
> > 
> > This should fix the warning and without cgroup writeback inode->i_wb should
> > be stable and there's no need for locking around it.
> 
> Unfortunately, this change did not stop this warning.

Ah, right. bd_init_fs_context() sets SB_I_CGROUPWB on bdev superblock. But
that also means that the warning is actually triggering properly because
the bdev inode for the device under GFS2 filesystem can be moved between
cgroups (thus mapping->host->i_wb changes) and GFS2 is prone to
use-after-free issues for bdi_writeback structures (because different users
don't synchronize properly on mapping->i_pages.xa_lock due to multiple
mappings pointing to the same inode). So GFS2 really needs to be fixed and
silencing the warning is just silencing the messenger of possible
use-after-free issues.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108989;
	b=z0oNkPrVikQbN7JEIPjZ5OjpVFertKcHNjppKfQ3O8+IJ8ymy7DCaGITYM5fFsgGoAW0
	 Wp9cgBi7cLYk6umDIB3dXyrYVCGhWzCNEixJH7v8AGvQBtlq3AcjHjXups5lZhXmt4UMj
	 RABkK5QFdKkq9uhKEYyuYNmnYEFqvaN8zwSiHvK3c2HoFIWHpy8MHmOM+xzQykNbLT0dr
	 0gNP44PoVUwGB/cCxttu+6FlmMrb4cMQUhfBkSF3rCl1LwYzeJRagejhtac0Tb7k5j3QH
	 lCAwVG00TNHWdKpzIpxdVs6IELwZZYJ0mh8q68Lq7NXyZyqlFVU1jLsHTkDW5LttQ6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108989;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:
	 X-Spam-Score;
	bh=1Wm5iqQHUYdGAarP0mjCGKsz4+MXWHrAKw+70dxWMRE=;
	b=ycRQ9Wyd+ZLAwzmvPTLMVCevaEMCc/FwZXEjkgtKQs70mQxO5GT0uT4zBE2xdri5fKr2
	 nNd14mUIP0qiSNWoOeZGeRlbFGCvLz42E/x6WGzUebgefl/iH3HdwWLtXV6GXlFxOCmra
	 DeM31AAh7irgnPQ5SsN5LICHnZRhg1U5EL+i7hw+WE11KZC8B1lUp4jy30v6YxOZLajlc
	 8h85CqxHK/TW2/TsqiP4PXDm6YWNtN5SWUHEdAlCAZfXmtXMKJL8YE8+LAJiKJEEkMl4Z
	 SoAlPSC5mYwCnueh0EObvg8Fa/JtIlooD1T+nyWJj5GCm49PtRUoxT+HEdSS0HdynZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=PXBHlrgf;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="yVhMt1/s";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=PXBHlrgf;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="yVhMt1/s";
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BDD606A326;
	Thu, 19 Nov 2026 17:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7BDD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=PXBHlrgf;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=yVhMt1/s;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=PXBHlrgf;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=yVhMt1/s
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8B04C1FA9C;
	Thu, 19 Nov 2026 17:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795108986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Wm5iqQHUYdGAarP0mjCGKsz4+MXWHrAKw+70dxWMRE=;
	b=PXBHlrgfYbI+JJxF/v08s3dXWhH6f0vHnN071+GnPD2j/Z0/oc3h5Znz80fcGSsPXUHdk1
	yHfXtlZq8byVQl28gZTXLako5YAD9Z7x3xsZILPRY9UShnsDTZwGGXaB+7Wjz+3ADf4mdr
	SXnrYhmuei5E+law5M57gcVBPkSsUR0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795108986;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Wm5iqQHUYdGAarP0mjCGKsz4+MXWHrAKw+70dxWMRE=;
	b=yVhMt1/srNiWd/sYvbvRDSy0zo1vsKR4MVUFPz1M/UDm8JFTw7us4wWSehEblXVxAhiSYc
	x3F84/iSy8vH4/Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PXBHlrgf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="yVhMt1/s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795108986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Wm5iqQHUYdGAarP0mjCGKsz4+MXWHrAKw+70dxWMRE=;
	b=PXBHlrgfYbI+JJxF/v08s3dXWhH6f0vHnN071+GnPD2j/Z0/oc3h5Znz80fcGSsPXUHdk1
	yHfXtlZq8byVQl28gZTXLako5YAD9Z7x3xsZILPRY9UShnsDTZwGGXaB+7Wjz+3ADf4mdr
	SXnrYhmuei5E+law5M57gcVBPkSsUR0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795108986;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Wm5iqQHUYdGAarP0mjCGKsz4+MXWHrAKw+70dxWMRE=;
	b=yVhMt1/srNiWd/sYvbvRDSy0zo1vsKR4MVUFPz1M/UDm8JFTw7us4wWSehEblXVxAhiSYc
	x3F84/iSy8vH4/Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A1A41334C;
	Thu, 19 Nov 2026 17:23:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B6s1Dnow/2pTOQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 19 Nov 2026 17:23:06 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id D88B12529E; Thu, 19 Nov 2026 18:23:05 +0100 (CET)
Date: Thu, 19 Nov 2026 18:23:05 +0100
From: Jan Kara <jack@suse.cz>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev, Mike Marshall <hubcap@omnibond.com>, 
	Martin Brandenburg <martin@omnibond.com>, devel@lists.orangefs.org, Dave Kleikamp <shaggy@kernel.org>, 
	jfs-discussion@lists.sourceforge.net, Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	linux-afs@lists.infradead.org, Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev, 
	linux-block@vger.kernel.org, Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	linux-nfs@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH 06/13] gfs2: Avoid racy dirtiness check in gfs2_fsync()
Message-ID: <ntzwnqethzdzix45gbxpmajmjiu2pwp7hpelmcmim5i5qabrqq@ahxo7kpx65qh>
References: <20261116171044.6938-1-jack@suse.cz>
 <20261118145941.1063127-19-jack@suse.cz>
 <CAHc6FU7NoZua98SGP9Kuga58gAcco6X__u=kOPfsUqbefAKLFQ@mail.gmail.com>
 <wo5723b7wrmu35q5qffzs7zzqwnojk3ireel2jkit2kxgv6bra@yd3gbigdmmdk>
 <CAHc6FU5HY9x5ntTOz_xk36T0XTzjNc8R4jy2zzpQKo=19HNMog@mail.gmail.com>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHc6FU5HY9x5ntTOz_xk36T0XTzjNc8R4jy2zzpQKo=19HNMog@mail.gmail.com>
X-Rspamd-Queue-Id: 8B04C1FA9C
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.01

On Thu 19-11-26 13:17:57, Andreas Gruenbacher wrote:
> On Thu, Nov 19, 2026 at 1:05 PM Jan Kara <jack@suse.cz> wrote:
> > On Thu 19-11-26 00:35:42, Andreas Gruenbacher wrote:
> > > On Wed, Nov 18, 2026 at 4:00 PM Jan Kara <jack@suse.cz> wrote:
> > > > Check for I_DIRTY_PAGES state in gfs2_fsync() is racy because
> > > > __writeback_single_inode() unconditionally clears the flag and
> > > > reinstates it only later based on PAGECACHE_TAG_DIRTY tag. If
> > > > gfs2_fsync() unlocked read of i_state hits in between, it will not see
> > > > I_DIRTY_PAGES although there may be dirty folios in the mapping. Check
> > > > for PAGECACHE_TAG_DIRTY instead and use inode_is_dirty() helper for
> > > > inode metadata dirtiness check.
> > > >
> > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > ...
> > > > @@ -760,12 +760,8 @@ static int gfs2_fsync(struct file *file, loff_t start, loff_t end,
> > > >                         return ret1;
> > > >         }
> > > >
> > > > -       if (!gfs2_is_jdata(ip))
> > > > -               sync_state &= ~I_DIRTY_PAGES;
> > > > -       if (datasync)
> > > > -               sync_state &= ~I_DIRTY_SYNC;
> > > > -
> > > > -       if (sync_state) {
> > > > +       if (inode_is_dirty(inode, datasync) ||
> > > > +           (gfs2_is_jdata(ip) && dirty_data)) {
> > >
> > > this adds back the I_DIRTY_TIME check explicitly removed in commit:
> > >
> > > 3aac630b5ce1 ("gfs2: don't worry about I_DIRTY_TIME in gfs2_fsync()")
> > >
> > > Could you please clarify what's going on?
> >
> > I wonder how you remember this after five years :). Anyway, the truth is I
> > forgot fsync path is calling sync_lazytime() as well before calling into
> > ->fsync and even if I remembered that, then it would be fragile for the
> > helper to rely on that (and there are already users of inode_is_dirty() and
> > inode_or_mapping_dirty() which want it). So to summarize you are correct
> > that the added I_DIRTY_TIME check is unnecessary for gfs2_fsync() as it
> > should never trigger just for that but it is also harmless and the helper
> > is more robust that way.
> 
> Alright. Could you please include that in the commit message?
> 
> Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

Sure added this to the changelog. Thanks for review!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

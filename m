Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559665;
	b=krLlAWKhZE4aHsO3N0QdeqpQ66WO3tsOaFmjOZUQNMA1Rd0W8LIPxORu6j526uJGuUYC
	 5/K34ZP8owBBr+QuZbw6awfpszIIhZBe8ZLRcUbM9EKlHE95+S/ULUKFPI+ykxJ2EBSka
	 B13dQLeFATIJOyHQJH20MxWrDneDzVyoFEdk9VTSoO+2gox5f4ucl5i0AZcvKgESQTZ0s
	 7t/q/m7DUxHGuLIL1YScI5ipNRo1Vj4Bf+iWNIEFbT6omYZlR3060NyK6BUmcNfMV9oBh
	 z8p+NI3mDgv5dIz0eYTuLlZjdwrCIFVPifx160rJDCd+zZuBDbFkRcX7YVwHDa/qG4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559665;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:X-Spamd-Result:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=nGeHe+mI9Q7ycrHaJd87rGohbSyEy4qk3YCafC0UMsw=;
	b=EEXmR2y4S2rgwL/W9C0Zh+HoHay80vH7IgFuJzICA2JL8TOrNWwDfzsLAPW/wunJ6sJw
	 O/j0KUeGtfYmusgprYk0d02njTrlNQLh2gsBJ4GyN6W/JuVgASgrxAMQIUSLwAwjGXA0w
	 HaXXC4ibCDZAVMC0U/B2YSjAeMRkPrWjwYV9E284Qc4eIMjbat6Rf2/3/3z3YjdmO7GLJ
	 Wt0pinzLVDGmwTA9qzpO7hFCuCGVUA2eEZACbBLRazFvhEC/KHLpvA8xH+8LRvoHsNjEo
	 eASKHVME+OBD0UN3DVw/g+kLMxdJYO/Uenk6IamSb4IW5Y0q9nafbwlwaZXVj9Rh4AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=2Tyyma5A;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wgycN+0s;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=2Tyyma5A;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wgycN+0s;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF055606B352;
	Fri, 13 Nov 2026 08:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF055606B352
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=2Tyyma5A;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wgycN+0s;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=2Tyyma5A;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wgycN+0s
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B178522227;
	Fri, 13 Nov 2026 08:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794559662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nGeHe+mI9Q7ycrHaJd87rGohbSyEy4qk3YCafC0UMsw=;
	b=2Tyyma5ATsHQ0dTZqFeGHpRSMLOo0IJ4FCrS0RncTR0OV6QF1puWwBCIcT6CBnxpW9XgWk
	D5CdF2mIe6OjnBEG3EN/46vyxDaE66fMtCii2FQxwa3qZRFBT4ceiIs7l+BnLnOhnXyZwL
	m17G3yOIFuFFy96Oai3iR1E/HARNnyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794559662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nGeHe+mI9Q7ycrHaJd87rGohbSyEy4qk3YCafC0UMsw=;
	b=wgycN+0sWGOhaozOnOrP2unoEkXCxqvBGP5lOwLoasS1JgWLAn/3U0Nt85jNd5Q1ZD8jMZ
	tzySRFDTD1N2CSDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2Tyyma5A;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wgycN+0s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794559662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nGeHe+mI9Q7ycrHaJd87rGohbSyEy4qk3YCafC0UMsw=;
	b=2Tyyma5ATsHQ0dTZqFeGHpRSMLOo0IJ4FCrS0RncTR0OV6QF1puWwBCIcT6CBnxpW9XgWk
	D5CdF2mIe6OjnBEG3EN/46vyxDaE66fMtCii2FQxwa3qZRFBT4ceiIs7l+BnLnOhnXyZwL
	m17G3yOIFuFFy96Oai3iR1E/HARNnyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794559662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nGeHe+mI9Q7ycrHaJd87rGohbSyEy4qk3YCafC0UMsw=;
	b=wgycN+0sWGOhaozOnOrP2unoEkXCxqvBGP5lOwLoasS1JgWLAn/3U0Nt85jNd5Q1ZD8jMZ
	tzySRFDTD1N2CSDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86AE9134C3;
	Fri, 13 Nov 2026 08:47:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z2q5GK7O9mqFFwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 13 Nov 2026 08:47:42 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 15E5522C28; Fri, 13 Nov 2026 09:47:42 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev,
	Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	devel@lists.orangefs.org,
	Dave Kleikamp <shaggy@kernel.org>,
	jfs-discussion@lists.sourceforge.net,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	fuse-devel@lists.linux.dev,
	<linux-block@vger.kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-fscrypt@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 0/13] fs: Various I_DIRTY_* state handling fixes
Date: Fri, 13 Nov 2026 09:47:00 +0100
Message-ID: <20261113083336.15152-1-jack@suse.cz>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=630; i=jack@suse.cz; h=from:subject:message-id; bh=10Y+BiLFDGs0KEydVV1xWNtJFXh3aRrLC/ijNwIkedA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBq9s6DQEyUONiKqxHRM/nzO8LKaL2bLvkT4nL/s ChSx806LAqJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCavbOgwAKCRCcnaoHP2RA 2XtQCADe+a4QK9Jx1Wkr3D58wRqbp/UeulNDDWtq9NXeCQTCKHKRK29KwdIUt8+Yd1Gj3qlRiac gxrNJgJZyk8ndc2/nzSJTH++q2rTgHgGgqleMT97EhbBiqLwFMoaYQEpkQECJwfGwvtV1/ZRCp2 v7GW/RDAsod+y1hsjiLZHBTJ5+XU8qYEln1cFixGGUqLeh6qLwqpb2BW5n4PfCYjU1YWCRWR+fQ QwtAl0N8MAHEO3Jv4Q7Yv+e0Hl3LpjJ8HtoTr+HLPraas9YbXcT7sM986iYWRIZQFxURYFaQq05 ey3TUiAOE+ajYriUrORHtPGksEwQdqM8fryBuqzYoF4DRrNU
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-12.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RL51pwup9t9rrf6fhpcri3z6a5)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -12.01
X-Spam-Level: 
X-Rspamd-Queue-Id: B178522227

Hello,

this series is a result of my audit of I_DIRTY_* state handling fixes. Over the
years some pointless code or code with smaller or larger bugs has accumulated
in filesystems around handling of inode dirty state. In particular testing
for I_DIRTY_PAGES is very subtle (and racy without holding i_lock), some places
forget that I_DIRTY_TIME also means inode has dirty metadata etc. So this
patch set removes direct checks of dirtiness state from filesystems and either
change them to directly testing PAGECACHE_TAG_DIRTY or to a helper function
which performs appropriate dirtiness check reliably.

								Honza

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795424460;
	b=pJ5qQdpXgeFKwyo6WJ3/86JM3VhoDboiP2Y6g+bS+oVYRvUJnuVXu8ygzRlT2mn00VUD
	 JZwcxmjcOnpBOPuyvIE2pU47q8+xGVDIzGGjpTKxhWJGlGTRA7G6rUPOECGtxvaz7NuDX
	 6H4G3zXs/FLWPE0wnnqWy0FA9W8RMJePZWUriZ5ouL6pX3dWZtpa9RvLF4midHygjXeyr
	 yp8Flv045S4eBkSqXvISUE8SJQu8t7XM7XlPy5xB9/qh4wNKqwfLIrS7ongZ6qsi5D6Gr
	 omNLVGnx5IvZvyah6JucGryC2dwKpr2lFvTSnyHmp4Jc2l7DeK5mWiXKeldQZmBg9kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795424460;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:X-Spam-Flag:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Score;
	bh=BuDmII5TOrso/ENvtME2Jf5yTRwZG3tITsSw5qPzJK0=;
	b=zGXa5iE+eHEyPhfjINoPxUg3ekcTSSJo6wpukFqwsRLivF7fyZm3CYa8wfFblKYT5pzl
	 rMsN2nPvjNxn6SwBLQiZWu354nUUyk626bqF7m/y2l+QXLRXQWIAhY3QcDADyocuklM+9
	 0Fp0bTB/7XySG5FSdKmtagJcdkZf39UpIT9PgRE4v+Pll7Cu2XozgxNRh+pMAkD9gjT43
	 IpsBzEQ+LCgVChq1Javwgbd3O0758RfmhCRFhFRAFVBHlWFAaAjUatRmPG0q5NmsSvIgZ
	 ATEdjCgzu4ircOr7Nkz1iNIbI8EecrUK4NPibXdXb/KbXUIe7BMzfo8nE+dubw3JT3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=oMGn6+O4;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1lY++HRB;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=oMGn6+O4;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1lY++HRB;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C372606A327;
	Mon, 23 Nov 2026 09:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C372606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=oMGn6+O4;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1lY++HRB;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=oMGn6+O4;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1lY++HRB
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DAF6F21F6F;
	Mon, 23 Nov 2026 09:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795424457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BuDmII5TOrso/ENvtME2Jf5yTRwZG3tITsSw5qPzJK0=;
	b=oMGn6+O43DNcwmRYX04ugynBJARPVNaGhNSXHzG69dBmQ/lMoD+HzsLuRPgiVo0sHj47h0
	r8oTeUz/Fm8ZxPzsG2pG9BxYzMjoKS1QiHd8sxwL/kMtjcDI5QVtU4juFUX6gTYmKruxK6
	2pZ00ATH5vhfdSmTXwax8GUnhXJ8cVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795424457;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BuDmII5TOrso/ENvtME2Jf5yTRwZG3tITsSw5qPzJK0=;
	b=1lY++HRB2235qS5UdZWfek6EcNg6pXDkJf4Whje1Hcbd0X+hmsME5Y/4HBaiEc1ajk1h7Z
	SmEoFLFxVzWUvcAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795424457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BuDmII5TOrso/ENvtME2Jf5yTRwZG3tITsSw5qPzJK0=;
	b=oMGn6+O43DNcwmRYX04ugynBJARPVNaGhNSXHzG69dBmQ/lMoD+HzsLuRPgiVo0sHj47h0
	r8oTeUz/Fm8ZxPzsG2pG9BxYzMjoKS1QiHd8sxwL/kMtjcDI5QVtU4juFUX6gTYmKruxK6
	2pZ00ATH5vhfdSmTXwax8GUnhXJ8cVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795424457;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BuDmII5TOrso/ENvtME2Jf5yTRwZG3tITsSw5qPzJK0=;
	b=1lY++HRB2235qS5UdZWfek6EcNg6pXDkJf4Whje1Hcbd0X+hmsME5Y/4HBaiEc1ajk1h7Z
	SmEoFLFxVzWUvcAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B87891352B;
	Mon, 23 Nov 2026 09:00:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UfLLJskABGveBgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Nov 2026 09:00:57 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 5165C275F8; Mon, 23 Nov 2026 10:00:57 +0100 (CET)
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
Subject: [PATCH v3 0/13] fs: Various I_DIRTY_* state handling fixes
Date: Mon, 23 Nov 2026 10:00:35 +0100
Message-ID: <20261123085601.21199-1-jack@suse.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121; i=jack@suse.cz; h=from:subject:message-id; bh=X92Jfp6rWCSgNzypZULrF4tMMzKRur9VUEC25jhEmFI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBrBACyqY7kE0mXTV5bSFk4t8B3JKtGOo1wAStpg WJhaFhhP9iJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCawQAsgAKCRCcnaoHP2RA 2XPaB/0QRyDmELEFAgZCBZJVl/kQc6Pt/EPVaPZisc74mHb0QZxypJ6PLzyGKAjQ6RmkFOz0ygf mG8SijUQwJzvN5v0iDeNWUD+Wr9vccJak4JOPgV7dGXn+rXffHDdVR7tYwjMWU0L2XLVm/XarP8 Q31S89/7yiiTOgaWcfAUIZhgHDUbuYaJ+OylTZnCgnIRuZ0ZeqlrLv/DUOPO24I0RO+s5xrZmYX E+QMOoRvgFJtWD9kfgCYRnnTSEwSTOq7eNrnXiAyvIgv66YQsAdTOiWoAEMs5VPLVaAXbhusL+2 CoLZJyw2u21DLm4MmWAz6S9eU0z/sd8Jyk7TiBCZSkFWMZEb
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-11.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -11.80

Hello,

this series is a result of my audit of I_DIRTY_* state handling fixes. Over the
years some pointless code or code with smaller or larger bugs has accumulated
in filesystems around handling of inode dirty state. In particular testing
for I_DIRTY_PAGES is very subtle (and racy without holding i_lock), some places
forget that I_DIRTY_TIME also means inode has dirty metadata etc. So this
patch set removes direct checks of dirtiness state from filesystems and either
change them to directly testing PAGECACHE_TAG_DIRTY or to a helper function
which performs appropriate dirtiness check reliably. I think this has gathered
enough feedback to enter VFS tree now.

Changes since v2:
* Added Reviewed-by tags
* Improved commit messages

Changes since v1:
* Fixed orangefs checking of inode dirtiness
* Added Reviewed-by & Acked-by tags
* Added Fixes tags
* Made gfs2_fsync() conversion more bug-to-bug compatible


								Honza
Previous versions:
Link: http://lore.kernel.org/r/20261113083336.15152-1-jack@suse.cz # v1
Link: http://lore.kernel.org/r/20261116171044.6938-1-jack@suse.cz # v2

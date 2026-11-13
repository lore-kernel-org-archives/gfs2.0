Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559665;
	b=ReKLlwI8pjULFoCpNG9+W+4bfgVek//F8ftOWLeKHEKbDrLDqEwyZTIUltg8oP5Pehn+
	 QybIXAFqwZRwZtZMwlByv747jYvO4SJXMsjLiS83VrTUZ2lqJ1wkpuO976C4klDtsrymf
	 AzL493C1dLiGuUob36kQkvSbCUhuq/m+ar7eUXdaAMfE2IMcRSZX4dAhtBiOg7UxoJn9K
	 lv8/Kx/Z73jshFGIVqFDlO2wLdGD3y8iBFfRtA4kMIFCppSqlU487r83OCmlXUcRBwQqs
	 EjrZm46/pFJFkW3stVkhnT9iYCrBhLUHJbFX4FL2MmXONFQmnyy0657+oA1/IPGmBxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559665;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
	 X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=+lM7rrM1R/XvKFJcc9D+ndKl/G6mdrWcbu/Y3hUJBMs=;
	b=pnVSwlS3okapdgJuxJEyy/qJu6haQlXu2Vgpa44/fOSlLsZq6HiiH5e9DrO+AtMafeFS
	 cVr+O4/jOsrU29bjIPt3Kl+S0Ich2bYLUiQV+arJEptTZPnufGKpHdspAKmHYDhroNxGL
	 TfG5tLFCgFN1Thz8bUdFrQDjpJ/Rpc415h8zAK2ArfVNcyyZr0/ra42JtTt6yrw7krGc0
	 pG02sqkxmPzTBZgAa9Og1B4mMPEnP8Nw7f+R211WZMGqMIqXa7VkdLvMevyBLfxGxpE/3
	 mcI6d3YozSazfgPGGw0l1GEf+udv6/FlrwCu+jpO2tRfHn9NgHYl2Rm6OVzN9Derqrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=gpvhgKrq;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1uY+pfd2;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=gpvhgKrq;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1uY+pfd2;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69C0606C1A7;
	Fri, 13 Nov 2026 08:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E69C0606C1A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=gpvhgKrq;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1uY+pfd2;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=gpvhgKrq;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1uY+pfd2
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 652092222A;
	Fri, 13 Nov 2026 08:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794559663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+lM7rrM1R/XvKFJcc9D+ndKl/G6mdrWcbu/Y3hUJBMs=;
	b=gpvhgKrqNrBu+JD3fmPGm3ytmSurqtkMrKNkKWgK67Y8/Qypd5SL00RzJnWNIan+aku20w
	HSU0ImeLsZ9kseR2QfJoTRFT8ig15sZtEURzPQiJrGGcX5XMcBiiouItTX9TMpcBtX1xFj
	PmXHXkmd0INhaMejTWI9zD7nuoKlgdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794559663;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+lM7rrM1R/XvKFJcc9D+ndKl/G6mdrWcbu/Y3hUJBMs=;
	b=1uY+pfd2H28c/zMcNWsIjvYXjgV2fBMohlgNiUF3ORv7DzWzUL/F7teNl8E2NVlsVIDTe0
	5KeS82OZZMbAXZDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794559663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+lM7rrM1R/XvKFJcc9D+ndKl/G6mdrWcbu/Y3hUJBMs=;
	b=gpvhgKrqNrBu+JD3fmPGm3ytmSurqtkMrKNkKWgK67Y8/Qypd5SL00RzJnWNIan+aku20w
	HSU0ImeLsZ9kseR2QfJoTRFT8ig15sZtEURzPQiJrGGcX5XMcBiiouItTX9TMpcBtX1xFj
	PmXHXkmd0INhaMejTWI9zD7nuoKlgdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794559663;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+lM7rrM1R/XvKFJcc9D+ndKl/G6mdrWcbu/Y3hUJBMs=;
	b=1uY+pfd2H28c/zMcNWsIjvYXjgV2fBMohlgNiUF3ORv7DzWzUL/F7teNl8E2NVlsVIDTe0
	5KeS82OZZMbAXZDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06A8113693;
	Fri, 13 Nov 2026 08:47:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gkmXNa7O9mqSFwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 13 Nov 2026 08:47:43 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 3464A22C32; Fri, 13 Nov 2026 09:47:42 +0100 (CET)
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
Subject: [PATCH 05/13] jfs: Use inode_is_dirty() in jfs_fsync()
Date: Fri, 13 Nov 2026 09:47:05 +0100
Message-ID: <20261113084700.739002-18-jack@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113083336.15152-1-jack@suse.cz>
References: <20261113083336.15152-1-jack@suse.cz>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1029; i=jack@suse.cz; h=from:subject; bh=G2KZ3si9+GMJBvBvY3QFhsaBCqg7CNyaNYSowoLqcTk=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBq9s6HPt2KsTzOSKxicLDBJbWZv/HZqcbPOuDxg 6lnphZYGpiJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCavbOhwAKCRCcnaoHP2RA 2UO9B/4r/Kfs5N4qeEj/He7a8m7WqdNg2QFS0WEo1iH2OTBRf6gVixF8Fy47CHHVHmc2Uhl7D+d iJ53uawYeaE+UG+DGF4bbW5twGAhLNWuT13hsmMyB7b1WTrqypbqu6YdV51+5OWk5/QxaJzM3ci 0VAYMDa7BrXrGzjaSMd/f+YromsegjJzqqx8yoymki4VO3G2+neaTdjsIZmA2F5qMGxnKFtt7Vp 4UwMXsq9sauhOLumoyz08v2wdVR8z14UlN7OEyKB8gHCHbneuIsoffSIwWQxR6cp/ghpbuElYdu mXJfM9GFR28F/cq8jhcqMh/mFsA9tik/MpKOnlhKI0DSeL0/
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLyaw51ggmke6bkcxeyajg5whq)];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Score: -11.80

Use inode_is_dirty() helper in jfs_fsync() instead of explicit i_state
check. This slightly changes behavior in that we no longer trigger inode
commit if the inode is clean except it still has I_DIRTY_PAGES set after
data writeout but that is actually a desirable behavior because commit
is pointless if only folios are dirty.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/jfs/file.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/jfs/file.c b/fs/jfs/file.c
index 2f5bb79c0591..90001d3d90fc 100644
--- a/fs/jfs/file.c
+++ b/fs/jfs/file.c
@@ -27,8 +27,7 @@ int jfs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 		return rc;
 
 	inode_lock(inode);
-	if (!(inode_state_read_once(inode) & I_DIRTY_ALL) ||
-	    (datasync && !(inode_state_read_once(inode) & I_DIRTY_DATASYNC))) {
+	if (!inode_is_dirty(inode, datasync)) {
 		/* Make sure committed changes hit the disk */
 		jfs_flush_journal(JFS_SBI(inode->i_sb)->log, 1);
 		inode_unlock(inode);
-- 
2.53.0


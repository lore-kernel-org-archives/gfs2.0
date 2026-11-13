Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559666;
	b=r88xMO3pNwHR+Ep0NikXRnTlIlIjXMK0/t4hC51CS/n8ma8IabFwNr28Hzye5fWTVQGg
	 9TIEmBsjiXWZU6RvsjbEeRK9uiXJt4EtrBVAWsvn3E/JA7BuabR05O3/DEshrWZXLg8XZ
	 Q4/wABCHNCvdp6exK24A1VQGkJukM38w7WHJ7jNur/XKrZOLcPUuJXfDGDDnF2EggCZfs
	 woKrJ3RnIukuxSh5MzCX9PudO2IGsJ8HiwpIvGwQZaXnyrroPgGkWKkIk+G/d3evXZdNj
	 hjgin20oiQlw4mjxwJ/bFZK7lYGhC1wxgW12bPIj0WprONdoBeo4warLUjgf0DrXP7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559666;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
	 X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=sJOcjt+fA3f0gmiULrSdno2cFCxjWnvJ5BbzkQtHN60=;
	b=KFNpbqnQi74vo2h83+irIGTxmUYncGYjbrXC620Mr3CvUe8ad1iubkgtjPwBpqTwc5WF
	 3OB0voHrAXvZlPvlmiDV0bCD4DcXzWJTXZ60Pep6RuAqp3P+oYkoWfAUzzlvprECzb25S
	 f2y5NM2M3oXT9pHsAtVFWWia7PUgD3raYhhFzTZkyADsbpfXxrUYfyL92F/GQFcJ7UDQw
	 xGPNtGM0N5R4uGsi1YfI2y8C37Pwt/C2dCAKaBW7YG6mJzBy92RvPlXBL4+9nMXUJn7EU
	 v9JsXlzRkwgHC+DX8fmKiicpVmsLd/di/lXzEdTIw+CVKLtWTpIlcxADIAmwoFFrWmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="hLtT7/XF";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="f/XjJDcO";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="hLtT7/XF";
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="f/XjJDcO";
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F335606B366;
	Fri, 13 Nov 2026 08:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F335606B366
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=hLtT7/XF;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=f/XjJDcO;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=hLtT7/XF;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=f/XjJDcO
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 877281F867;
	Fri, 13 Nov 2026 08:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794559663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJOcjt+fA3f0gmiULrSdno2cFCxjWnvJ5BbzkQtHN60=;
	b=hLtT7/XF98r78L5r7f3aisLepraKlILIXq134qifFdvCsiqAWF7+oH4Eeh4AO2WIimwct5
	VMujfC1W1Q3ZvUNrfWgW5Y/F8Nv1ZlMmOrdP2h8ipn4NBVFKAcGtPRyQq8qJTin0nUrEN8
	mklQtarsfU+8x9u14x6BzTGtycjmgqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794559663;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJOcjt+fA3f0gmiULrSdno2cFCxjWnvJ5BbzkQtHN60=;
	b=f/XjJDcORr+mSeEhqQnZ+oT7M8aMGt61YY/7jhGBCkt75KmE8KZA9cLtF9ITYr016G+1hT
	g5GvamWa4VGlvUDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="hLtT7/XF";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="f/XjJDcO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794559663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJOcjt+fA3f0gmiULrSdno2cFCxjWnvJ5BbzkQtHN60=;
	b=hLtT7/XF98r78L5r7f3aisLepraKlILIXq134qifFdvCsiqAWF7+oH4Eeh4AO2WIimwct5
	VMujfC1W1Q3ZvUNrfWgW5Y/F8Nv1ZlMmOrdP2h8ipn4NBVFKAcGtPRyQq8qJTin0nUrEN8
	mklQtarsfU+8x9u14x6BzTGtycjmgqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794559663;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJOcjt+fA3f0gmiULrSdno2cFCxjWnvJ5BbzkQtHN60=;
	b=f/XjJDcORr+mSeEhqQnZ+oT7M8aMGt61YY/7jhGBCkt75KmE8KZA9cLtF9ITYr016G+1hT
	g5GvamWa4VGlvUDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24533136B2;
	Fri, 13 Nov 2026 08:47:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TrcFO67O9mqXFwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 13 Nov 2026 08:47:43 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 40DA922C36; Fri, 13 Nov 2026 09:47:42 +0100 (CET)
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
Subject: [PATCH 07/13] fuse: Use inode_is_dirty() check in fuse_evict_inode()
Date: Fri, 13 Nov 2026 09:47:07 +0100
Message-ID: <20261113084700.739002-20-jack@suse.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=825; i=jack@suse.cz; h=from:subject; bh=/+R2RM/eaN1B9yo0gEWxhhBzGp/HXlo+uc2oxzvZkfA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBq9s6JwUXPrwJb6wqOYNJVZc3QJF0vToQ0BOAqp KD6ESMyUjSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCavbOiQAKCRCcnaoHP2RA 2egwCACf3v7861pm6ttPHjBJtHKljk2oROnZGme/rwkLGSpiomGvMFeun/9SSFixIlbuiPjlHMX NaJl6nM35FinilQyOfFzGY0E8EiDjUIp0ufvnUDAi4/FyY05mZMMTqTBvBNC4dR/dXbtorTAsyc kLbfoTEgWpa2NOoWS7zV/Kmq0Gay51p6muzMq041G1kVBT7b7m9faE7/oELSGzpflS78rPEd2UC Zkqm9JtDJwiLL5GRXld1XhcC40Nw7iqpObWUX50qGAMz3Q9lvgHSSJXHbK4GPt7ecPt3pgRvt4y Jd9NXw9VdpjPxFJbr2Ym+1LLZ39b+2yBuT6pRNB+0yH8sUV0
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-12.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	R_RATELIMIT(0.00)[to_ip_from(RL51pwup9t9rrf6fhpcri3z6a5)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -12.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 877281F867

Use inode_is_dirty() helper instead of explicit i_state check. This will
result in additionally warning if we have unwritten timestamp updates
when lazytime is enabled but that is actually desirable.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fuse/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 1341b681d0ed..ef88ba7bf682 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -143,7 +143,7 @@ static void fuse_evict_inode(struct inode *inode)
 	struct fuse_inode *fi = get_fuse_inode(inode);
 
 	/* Will write inode on close/munmap and in all other dirtiers */
-	WARN_ON(inode_state_read_once(inode) & I_DIRTY_INODE);
+	WARN_ON(inode_is_dirty(inode, false));
 
 	if (IS_DAX(inode))
 		dax_break_layout_final(inode);
-- 
2.53.0


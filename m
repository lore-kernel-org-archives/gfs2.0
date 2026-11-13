Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559668;
	b=BDQSftT17+gKuckrtXZkAQJ2VH6G1FGjqM8Pp650PzPU8QVvdYORezQYPkiK0ZWFvR28
	 iB8TCuUWl6tWwkhkNxuLabaJ2E1sMrFYPXb++7O6p+S5aoTiw5AfP2CINgf3srxUqOLzy
	 ndsIl7BphQT5+jF+7sLPogFipW+eDK8TKIjHjpcg0lRUgysmLawi3V13YagDXX2W4Kyk0
	 G3z8WrQ8GFyDG3/E//5c63j98D+B9XGgH5mM0GRWrpJfE4au5WtjPT1zQPErpdNVvwOed
	 zz2wbvESxmqOIAg/rxpZdbrbVoHri2lNhB38ErHgURqX/CAeIf1pC1oCfXS+SzLXpjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559668;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
	 X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=bmtgyvlcoco63cjpiS7pBzWifacKy+9MGY1FIRs7ge8=;
	b=a0Yojy7kbiqVmbrlXZ8j6ojqWvCewojnRum6ihVNzcrmMPsMQ8yiHsXDAtoNohmMBAmh
	 X6EtzTNb7xbpYASxM77w0faKSWo8fk7JoddXGd1Kxmyaf6uyKfElP69iYhkdsZ9SbbiSu
	 6O2yP2XYHKp3Y/fdzGKFN6cqcYdK+OPOyAtWp3UKb9xCwkbAQAevzhtEjii9S7XrkFpyH
	 miRCbY0Su2YwUeRiRmRvnODxP0hb1w+hMQRtHSLlYG9whBba/G62Lno7wfz5pMyqs5XmF
	 H9h8fqNh3rXJZ4XL3j6sytnl67lpwBov1cWgCpJgDuuJYbgOgY5d9Djj18PNKUVuOWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=FLMbTlbA;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=EWH57LAm;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=FLMbTlbA;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=EWH57LAm;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B45606C1B0;
	Fri, 13 Nov 2026 08:47:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46B45606C1B0
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=FLMbTlbA;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=EWH57LAm;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=FLMbTlbA;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=EWH57LAm
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C150A1FA93;
	Fri, 13 Nov 2026 08:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794559663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bmtgyvlcoco63cjpiS7pBzWifacKy+9MGY1FIRs7ge8=;
	b=FLMbTlbAZM64rvUCBeDklnhGr91Q+V71SnBuszNiG4xaldLAkX9KrwCfeSQKkZFy+VPdLr
	cLjs7UH0lgVookppjekbfZC0qh2x3U8jWCyheWPmT3Q9GmzGEg+M+hamOWeDg07wkU+Hsx
	9TqBRLDSlxJ9Jujxw2V0VzGUv4DUu1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794559663;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bmtgyvlcoco63cjpiS7pBzWifacKy+9MGY1FIRs7ge8=;
	b=EWH57LAmtFMNhyWpPMtq0t9GDzfXQ9WVqF+czhP/pB5Cwo7X8DU9ByoHHexjOcT/NHle0t
	3MkkSAUsPr8BqFDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FLMbTlbA;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EWH57LAm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794559663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bmtgyvlcoco63cjpiS7pBzWifacKy+9MGY1FIRs7ge8=;
	b=FLMbTlbAZM64rvUCBeDklnhGr91Q+V71SnBuszNiG4xaldLAkX9KrwCfeSQKkZFy+VPdLr
	cLjs7UH0lgVookppjekbfZC0qh2x3U8jWCyheWPmT3Q9GmzGEg+M+hamOWeDg07wkU+Hsx
	9TqBRLDSlxJ9Jujxw2V0VzGUv4DUu1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794559663;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bmtgyvlcoco63cjpiS7pBzWifacKy+9MGY1FIRs7ge8=;
	b=EWH57LAmtFMNhyWpPMtq0t9GDzfXQ9WVqF+czhP/pB5Cwo7X8DU9ByoHHexjOcT/NHle0t
	3MkkSAUsPr8BqFDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 758FF13516;
	Fri, 13 Nov 2026 08:47:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qyj4Da/O9mqkFwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 13 Nov 2026 08:47:43 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 607AA22C40; Fri, 13 Nov 2026 09:47:42 +0100 (CET)
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
Subject: [PATCH 12/13] fscrypt: Use inode_or_folios_dirty() instead of explicit state check
Date: Fri, 13 Nov 2026 09:47:12 +0100
Message-ID: <20261113084700.739002-25-jack@suse.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=719; i=jack@suse.cz; h=from:subject; bh=FMLwmEIo3Jn+kxzPFnZc8LhNnipFkY3Bc7bC/iC2Ncw=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBq9s6NeJphD0clnEX4nMNjKhoUbG1H4Fuqr/Knz VDsqwpscFqJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCavbOjQAKCRCcnaoHP2RA 2UYRCACX5dDfgajzlFON403Vln7l6gKeB+f3iWfiRcpY4pFuhFKaTNt+d/uoRYVt/d1LTlqMtCt MprrkjxH/gND+ru68arrZ2UMOLcgVv8e26Tr8gHcCZjIpRa87xDMXe2sknO1xCN3uWrwqKMn5ls piGX/I+IdD5s2luS33aUIY3VaotHof7rSWo9zjLsE5PRdSMuHF9GxAqTwsFkBkGliv1fMp+PPKA TZyZu5ZsjXWaPN+uDwPTpCzaY2PTi/cb9V1VxFCQMRhGzwEoR7pU7cuFBm37pn5LHukUrQFH9pQ 5r5skZ1yuEMINNy8+26WzTupqWSiu180+/8BvUmELgpwbzb8
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -12.01
X-Spam-Level: 
X-Rspamd-Queue-Id: C150A1FA93

Use inode_or_folios_dirty() helper instead of explicit inode state
check. No functional change.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/crypto/keysetup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index a77b889d7578..1cd40663b251 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -839,7 +839,7 @@ int fscrypt_drop_inode(struct inode *inode)
 	 * userspace is still using the files, inodes can be dirtied between
 	 * then and now.  We mustn't lose any writes, so skip dirty inodes here.
 	 */
-	if (inode_state_read(inode) & I_DIRTY_ALL)
+	if (inode_or_folios_dirty(inode))
 		return 0;
 
 	/*
-- 
2.53.0


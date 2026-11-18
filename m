Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795014001;
	b=EMQjkEHh36Aset1MF0Qx4j8nopSmbjmav9a4j6/YzG8y6SFKbyPFgE9oEk98eHrMFMxt
	 prfYjXmoFODsJriciqIBuUOGb3lbV+dVF6fQlx0plw5dP7Iif1N9ThHgBut7b57/R/ifs
	 vsSND8HfkJKzo9YXL6eXHpO/m0qns9McVMyo07waXfYMZvPMwDI9+Qa2wyDphBBZw6iH9
	 Qwi8SfoY9X3M0eb83Boe10+XKXkC9S0h7iXPNB/BY5Ffm7EsL3wxJp0uYISXK4Yf1jpQj
	 lpNzhQBP/5hPDySsGKS2fraNLozlOiW6unXN33ja8jz5KP1W8Ga0AzjFnSCgdsVyF0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795014001;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
	 X-Rspamd-Pre-Result:X-Rspamd-Queue-Id:X-Rspamd-Pre-Result:
	 X-Rspamd-Action:X-Rspamd-Server:X-Spam-Level:X-Spamd-Result:
	 X-Spam-Flag:X-Spam-Score;
	bh=Jp8Bf6/C7qzSRkDIS67w9/8cYQC1IS1l8hdUpK+q58U=;
	b=hDCRFWxvZDdSGs740XLVKbTdHNBiWNooI9L8yn5ehFGV4MMEYFGxQs0hvDVUi5IMD5r8
	 AhHMF/QRTGmp8YAtg7lCTSqrvpwLGqQMcu4unBSAIqlpvh4R/IiCvRn9RRWF1yUKNaU1B
	 kHxnqjAsk2De3gqmiOLGV+Dl3fHlaBxjhsr1ZIfOF+zNLpFz0XM+vZACwKL2oC/LpGcsq
	 nSIc/oDyxzNGetFQ4ZVzepv0NEAb9AjFO61dMBSBOt4aWxiFcjvRMDQ6MTqqilL2L33l7
	 Utoe5HNHCmk82o1vCxraV/QNMCPGsnLf/IBf8EQvaqxL29EXCAIVr3xuZkTJlnNmg6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C329460A260C;
	Wed, 18 Nov 2026 15:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C329460A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 504EC1FAAF;
	Wed, 18 Nov 2026 14:59:59 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2635C13678;
	Wed, 18 Nov 2026 14:59:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sYyMAW+9/WqvXwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 18 Nov 2026 14:59:59 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 1E113250A7; Wed, 18 Nov 2026 15:59:54 +0100 (CET)
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
Subject: [PATCH 13/13] fs: Use inode_or_folios_dirty() in __inode_lru_list_add()
Date: Wed, 18 Nov 2026 15:59:47 +0100
Message-ID: <20261118145941.1063127-26-jack@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116171044.6938-1-jack@suse.cz>
References: <20261116171044.6938-1-jack@suse.cz>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=755; i=jack@suse.cz; h=from:subject; bh=8YjGys7j0AZPC+xTuLBhes4R3hdR8y5UBwcvGhQGyuM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBq/b1nw36xnBrH5xG73VlTHqBQWHyHrFmP8Rknh e7OYuEfA7uJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCav29ZwAKCRCcnaoHP2RA 2dWcCACCDb1dX94BM8PwF7HQDWZ6OthMVNJa+uMC8v1kUE0YbRMOQjulcohVBR3fGMJENZN+rw/ 207mme0JcLzhc7IUiSe03z5H0d/5fY1imA60avX8+tEm4O5W5RpPRY3z6zJLvmhMto4GdbZfY0c F2Ne2vRnsdeleDd81vshYVh3s5DMIT4mLNlhwzUeLuz/PagY1FzUQA6GBnRMGihZGn+DkXkd/ZE ScuYmQ06GMMgbE3s4GQH9tpehBRs4oOlLhgi0qItxr8DSeP3vIM+wOTt07S5cuPX3p/GdBEpM9/ 3rmDrKeTuwhBRcajhk5AVUWPFWfwbcrBVpaNOEU3jhMlzcbr
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 504EC1FAAF
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

Use inode_or_folios_dirty() helper instead of explicit i_state check in
__inode_lru_list_add(). No functional change.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index f63535ee3629..73afa57fe385 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -552,7 +552,9 @@ static void __inode_lru_list_add(struct inode *inode, bool rotate)
 {
 	lockdep_assert_held(&inode->i_lock);
 
-	if (inode_state_read(inode) & (I_DIRTY_ALL | I_SYNC | I_FREEING | I_WILL_FREE))
+	if (inode_state_read(inode) & (I_SYNC | I_FREEING | I_WILL_FREE))
+		return;
+	if (inode_or_folios_dirty(inode))
 		return;
 	if (icount_read(inode))
 		return;
-- 
2.53.0


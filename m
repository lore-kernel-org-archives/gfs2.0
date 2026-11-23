Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795424462;
	b=O1Q4fYziIympWU/c+BdcsfBj/e6QBzfnb6yUgm7rE8Acbhg+C07ST/e5p13AZTzpxgXt
	 z3IAlMPSzvDUWNG4HjAEW8+EfGWVwStSO7yOlYy6A6a5EOHblcgDNY4oQ9pHLxWForRTq
	 JG/J1y9L1yf/5hRQYgITGPpjYSfQ3bv61UukUuWkX3J0k2DLlsGMGp2YiWDyfE+WKqmCM
	 Nv3inL4kWGvJDayEgPKUvopI3rfhAAHiKp2DgqPNHN66djXrpA4cTymmQrPF+bcvuzjrb
	 FNnBz4RiCo1cLF3p5NTt38V2egiO5EDECbiqfi08wURVeuWhCgF70QdlJ78UzwTqb/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795424462;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
	 X-Rspamd-Pre-Result:X-Rspamd-Queue-Id:X-Rspamd-Pre-Result:
	 X-Rspamd-Action:X-Rspamd-Server:X-Spam-Level:X-Spamd-Result:
	 X-Spam-Flag:X-Spam-Score;
	bh=gC+WTNqo3zddo1hQ6r2uM40CkmOnnZwNP+h9kAciQTI=;
	b=2oMKbhXQjAyfAY4N/jTfCr/ascCwrQGBzxkdmxJy+8iyjyfv8J8LWsI4aLOe5B8npi/B
	 9ZVpx/QsrfKx8KUIamlUGZZ4/Qd3t9ZKZFZBM/z4168chgmfQ6+ekej7LQjt0H3pJRfTQ
	 N4m7DR4mJIK/LNMgXThiVoT5ZMqiFG8zfEqWNYvYHZmC25gRcIRf0cJQUfl23XGoykgd7
	 mMk5akmkfsfbLWVLIn9C/Kgj6amQakqWm8S1jQ2KiiQW1RbgE8z/Rg1YvUkji8ewaNmtx
	 ovBdSKp154nfkMViU13eUQPz2UcpL9FqU7rCeooR7aOfPYQVO19vEh1KhrYP/LHM1qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32DD60A381B;
	Mon, 23 Nov 2026 09:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E32DD60A381B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AF90C1F822;
	Mon, 23 Nov 2026 09:00:58 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7948E139BB;
	Mon, 23 Nov 2026 09:00:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q6SBEMoABGv8BgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Nov 2026 09:00:58 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 8649D2760C; Mon, 23 Nov 2026 10:00:57 +0100 (CET)
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
Subject: [PATCH v3 10/13] afs: Use inode_or_folios_dirty() in afs_evict_inode()
Date: Mon, 23 Nov 2026 10:00:45 +0100
Message-ID: <20261123090040.19006-23-jack@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123085601.21199-1-jack@suse.cz>
References: <20261123085601.21199-1-jack@suse.cz>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1012; i=jack@suse.cz; h=from:subject; bh=A3fwFrLxq2sLtsoLLFywsEZVT5HTyxLWIrwzaeggONU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBrBADA37ZIR6z9fsTw8rPMt+C+UFIW26BkL5FQl qYWaDW7412JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCawQAwAAKCRCcnaoHP2RA 2eXAB/kBSzZc1arCzSy/V/HGQX22qB+L8/5GCSLtD64ztzgZTEefTwp544fhici5YrMj4EZxNda tT/K3r1j4Nh+Y5I8KqK+Dk04ArSjCBIiNL0uzXzRJCdCcO8a7nY3fdDL5dmN0he8qEIytPthVUr IuCg28iB5to2zjzPPDRIysWC4j11eEmt7T7e9/beKJ0gEeRkQC7hjO3k4UOnkZU9CmFTJyukIlW 7qjnP05Oq92T7Kf63Qf8bq8eqtzGMuQ64PVeaNlLZGX/lk3r/RlqECJKywTlBhkxa9Ma7L/DjZQ ZU+OGjfV/eHT0XTc2BKAkHX7Zu+9H99dkMzK1WgdXH3GVtmh
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: AF90C1F822
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

Use the helper instead of direct inode I_DIRTY check to abstract details
of inode dirtiness handling. This also properly triggers when only
timestamps are dirty and lazytime is enabled (although I'm not sure if
it really matters for this particular case in AFS).

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/afs/inode.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 0733abff77a5..69982e7d7020 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -667,10 +667,8 @@ void afs_evict_inode(struct inode *inode)
 
 	ASSERTCMP(inode->i_ino, ==, vnode->fid.vnode);
 
-	if ((S_ISDIR(inode->i_mode) ||
-	     S_ISLNK(inode->i_mode)) &&
-	    (inode_state_read_once(inode) & I_DIRTY) &&
-	    !sbi->dyn_root) {
+	if ((S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode)) &&
+	    inode_or_folios_dirty(inode) && !sbi->dyn_root) {
 		struct writeback_control wbc = {
 			.sync_mode = WB_SYNC_ALL,
 			.for_sync = true,
-- 
2.53.0


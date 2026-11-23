Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795424460;
	b=DAOU2UqKpu7VEBW8r69lpuZN5mwGql3Zw0BmMagSADfJemX9TOkN+yz7XE5B4vGIWDU7
	 vVIP0MJ+kL0ILh1lZD1wzuiAqgVFB7UzX7IXPoi2l7iv2PYSmm40HE8OgMH3ZaWQ8Ssf/
	 xchuOBtCbgEZ0q2O8c3OuL+vsoxW6CqUM3MUOaV7rTs52Zle5ZQUmaIlKE9hJlTg62Js4
	 qmMGZ4wOVjVcpIw0sOS9c27DNmsBXPrb1+p6ZlxsLPIFfjxorkyxTA/DPbK6l6I0m9Qow
	 PHfyo/s+5ANhWQdRnCLwkqODIv1pIqIZywtubS6bTJI/03s28MnrqIhb46k1+XG/cow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795424460;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
	 X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=9PufyaWrVxeOz4NAkti43XXJxPZUVkn8LHkFwQ+8mbE=;
	b=AxcmAaT/noF17Qw9xbJ9f2Yf6ycpLd51BudC4pYpXtO4HwVUvCbrZMrgNtbcAlJ+QNTS
	 frpO9wETGLOssHo7nl5B+l24UC2mithB0/2ueg809lWkPL2Psqjc0dUHP5iozmpATFktv
	 xbr8HL1/XF9EgdH7XYT8Ul3E9+hnxlX+Sp6naPYSxm83zec23xYWdXSbjJA1HTw8rzPUT
	 ECs560yfqYNiXADRqcoZ1Jn8dFNJOY/NPjpngyov+wMj2Wuv99FkdsNv6BGV4TUW/NwuZ
	 ARqKSj4LUWaiSKuP5v2wdputx60l0Z0wVRi4ABqbQPgHCjGsJH866l0s0exUS6WtNBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=N9x48zZM;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+SN6xvbz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=N9x48zZM;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+SN6xvbz;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E0A606A32D;
	Mon, 23 Nov 2026 09:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2E0A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=N9x48zZM;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+SN6xvbz;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=N9x48zZM;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+SN6xvbz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 35FD91F803;
	Mon, 23 Nov 2026 09:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795424458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9PufyaWrVxeOz4NAkti43XXJxPZUVkn8LHkFwQ+8mbE=;
	b=N9x48zZMUvEYjB2TPPSeVzsghK90NXT01tGYperZLAu7rvkxyeQIh9oMgHYLPAI8Is+1Zk
	+21vocUgFs9TaXLzo8j3cJ0yZ5bIJZwWDgTeqRXdz6fT7ANhCPzpsMjTYiwlMX4/db4RhT
	Nl2I1Qb4POnFOH2KfneMtiI/2RUS04Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795424458;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9PufyaWrVxeOz4NAkti43XXJxPZUVkn8LHkFwQ+8mbE=;
	b=+SN6xvbziH0yIp91A4Ajw3yzOcLLlrZPrZgfF2ma32yBsAfv8I71oDIlxEx5+N5YkeJu/N
	Bx+7yRoZsk2zwJCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795424458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9PufyaWrVxeOz4NAkti43XXJxPZUVkn8LHkFwQ+8mbE=;
	b=N9x48zZMUvEYjB2TPPSeVzsghK90NXT01tGYperZLAu7rvkxyeQIh9oMgHYLPAI8Is+1Zk
	+21vocUgFs9TaXLzo8j3cJ0yZ5bIJZwWDgTeqRXdz6fT7ANhCPzpsMjTYiwlMX4/db4RhT
	Nl2I1Qb4POnFOH2KfneMtiI/2RUS04Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795424458;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9PufyaWrVxeOz4NAkti43XXJxPZUVkn8LHkFwQ+8mbE=;
	b=+SN6xvbziH0yIp91A4Ajw3yzOcLLlrZPrZgfF2ma32yBsAfv8I71oDIlxEx5+N5YkeJu/N
	Bx+7yRoZsk2zwJCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DE011352B;
	Mon, 23 Nov 2026 09:00:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hY3HN8kABGvlBgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Nov 2026 09:00:58 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 6016C275FE; Mon, 23 Nov 2026 10:00:57 +0100 (CET)
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
Subject: [PATCH v3 03/13] orangefs: Check PAGECACHE_TAG_DIRTY instead of I_DIRTY_PAGES inode state
Date: Mon, 23 Nov 2026 10:00:38 +0100
Message-ID: <20261123090040.19006-16-jack@suse.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3189; i=jack@suse.cz; h=from:subject; bh=qOt0w8EOsDa7j7GP1xhYD0AcvF7QiI85DGoAYBCrs7k=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBrBAC61aRsAVN8lnD44xY0otIjcS7frf9DOm+qj 5JeeuPtQJmJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCawQAugAKCRCcnaoHP2RA 2cXYB/9YSdTSWDYZF8pufTyYbLjxWnKqiE5C3wKy+OCspvWWnhi/5/iOYFfUdkNBNHAAqMG8KMi CmFpg/4UJQ9cYKegQ3fSGdCu0leoUz5i9URIAlvNORlOQ6FIaw166E8oRXLc/FafKJ6cSt9rSb5 bxuCjU9itrz4jOl2u9zT9PxXg65k2foekFE/PXZGFpl89cdRfchfWF/mc8/4G+GpfBXo4hGYJou r/bdRwbPrOvc3leK4iCkyGkziOjIR6hvNd7GALzmKQMaBUrFqMXeFpBczBxoQm4kg1rE+Goc6J6 RDjj5lQlSggBfUoS3iaXP8j8KnabtA8dcChB90Iwor48rHwc
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-15.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLyaw51ggmke6bkcxeyajg5whq)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Score: -15.80

PAGECACHE_TAG_DIRTY is the authoritative source of dirty folios present
in the mapping. Use that instead of looking at I_DIRTY_PAGES inode state
which can get stale for example when folios are written directly with
filemap_fdatawrite(), which is how orangefs_flush() and orangefs_fsync()
write the mapping. So a getattr keeps serving the cached inode after the folios are clean.

The dirty tag alone is not enough. folio_start_writeback() clears it
and sets PAGECACHE_TAG_WRITEBACK before wait_for_direct_io() sends the
write. OrangeFS writepages does not return until that call finishes, so
I_DIRTY_PAGES still covers the round trip today. A getattr that looks
only at the dirty tag stores the server's old size while the write is
in flight. orangefs_writepage_locked() then reads that size and shortens
the write.

Hold the cached attributes while either tag is set.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/orangefs/orangefs-utils.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/orangefs/orangefs-utils.c b/fs/orangefs/orangefs-utils.c
index 9ab1119ebd28..241b10858b31 100644
--- a/fs/orangefs/orangefs-utils.c
+++ b/fs/orangefs/orangefs-utils.c
@@ -233,6 +233,20 @@ static int orangefs_inode_is_stale(struct inode *inode,
 	return 0;
 }
 
+/*
+ * Dirty and writeback tags, not I_DIRTY_PAGES. filemap_fdatawrite()
+ * leaves that flag set after the folios are clean. folio_start_writeback()
+ * clears the dirty tag before wait_for_direct_io() returns, so the
+ * writeback tag is what covers the server write.
+ */
+static bool orangefs_writeback_pending(struct inode *inode)
+{
+	struct address_space *mapping = inode->i_mapping;
+
+	return mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) ||
+		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
+}
+
 int orangefs_inode_getattr(struct inode *inode, int flags)
 {
 	struct orangefs_inode_s *orangefs_inode = ORANGEFS_I(inode);
@@ -247,7 +261,7 @@ int orangefs_inode_getattr(struct inode *inode, int flags)
 	spin_lock(&inode->i_lock);
 	/* Must have all the attributes in the mask and be within cache time. */
 	if ((!flags && time_before(jiffies, orangefs_inode->getattr_time)) ||
-	    orangefs_inode->attr_valid || inode_state_read(inode) & I_DIRTY_PAGES) {
+	    orangefs_inode->attr_valid || orangefs_writeback_pending(inode)) {
 		if (orangefs_inode->attr_valid) {
 			spin_unlock(&inode->i_lock);
 			write_inode_now(inode, 1);
@@ -281,13 +295,13 @@ int orangefs_inode_getattr(struct inode *inode, int flags)
 	spin_lock(&inode->i_lock);
 	/* Must have all the attributes in the mask and be within cache time. */
 	if ((!flags && time_before(jiffies, orangefs_inode->getattr_time)) ||
-	    orangefs_inode->attr_valid || inode_state_read(inode) & I_DIRTY_PAGES) {
+	    orangefs_inode->attr_valid || orangefs_writeback_pending(inode)) {
 		if (orangefs_inode->attr_valid) {
 			spin_unlock(&inode->i_lock);
 			write_inode_now(inode, 1);
 			goto again2;
 		}
-		if (inode_state_read(inode) & I_DIRTY_PAGES) {
+		if (orangefs_writeback_pending(inode)) {
 			ret = 0;
 			goto out_unlock;
 		}
-- 
2.53.0


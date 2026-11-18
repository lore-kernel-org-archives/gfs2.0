Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013996;
	b=nZYMF7shmWgPhEqBLPWhp44Hojy5XP3ubOi2D0tMvYusvsl4UuogcT3OPoJKMiJF4nRJ
	 o1bHj8E0ZUir+7NmcjoJOaQEKNE9mkSuieNeBvAQPaULcE+AU0DJTuSIYHkq3dgmN1TAS
	 y3HYHuSoYEnUeP/OOCxEjvDD2INb/vzQV8b/7RHe609G6ZaIJxd14iPSwLLjvSnL/PNS4
	 1clcwqenKo1AZ0glCx9CNKQOCEXJQYvIMOm3bb9esFuE/6he7hxv4SQXV/ROE44iSEeUE
	 m0v6wO3Mlo4N6z6oVhv0vgaUQz5uLpwRdFDom9VsrvTjdC4KPaIqB3KpZlPabg0lHrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013996;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
	 X-Rspamd-Pre-Result:X-Rspamd-Queue-Id:X-Rspamd-Pre-Result:
	 X-Rspamd-Action:X-Rspamd-Server:X-Spam-Level:X-Spamd-Result:
	 X-Spam-Flag:X-Spam-Score;
	bh=VQb+bKWhxu6T8I0319SZX3JCOfe5xe2J2p1rpusenNw=;
	b=bVPhDHTR7uWm8QGUzUX1CzbS6jKySYtuPvh2/OkFKRIRTjD0zMTOIIdQlpgrVVYDpwcT
	 Ajt27cv31joZMRRyiYfrm3fQaYTAigwfsoiIHbrfNKepj/96w/LT/qHM6Zr7NIgttmC5S
	 /YFYyVvDuwpxWCV5gGmjxcrND0Q0qSL9dosjSPRU1syy9SQ7lnDLyVBOK2UJE9JI8hGei
	 vaHw13rZeyj1YeQlbh2HUw/ENTgaw4XZuY4/fz7NvvFu1XNacP9B/BcTU78vL8Me6fPVI
	 uSkF28E/smHRKiBew8didxEuXiESsncuBTWgjJqd85nVt65N4o94sCaY6uUGLp+uDNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D255606A331;
	Wed, 18 Nov 2026 14:59:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D255606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8C73C221AC;
	Wed, 18 Nov 2026 14:59:54 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58747134F6;
	Wed, 18 Nov 2026 14:59:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gMXSDWq9/WqIXwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 18 Nov 2026 14:59:54 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id C35E32508F; Wed, 18 Nov 2026 15:59:53 +0100 (CET)
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
Subject: [PATCH 01/13] bdev: Drop pointless loop from blkdev_flush_mapping()
Date: Wed, 18 Nov 2026 15:59:35 +0100
Message-ID: <20261118145941.1063127-14-jack@suse.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1685; i=jack@suse.cz; h=from:subject; bh=z1JyqCsZ1lnse9oZn1LwdYUSEld1ft2x2CnQBKoqPus=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBq/b1dYcoAlm2vX4tK6XDG212WFtG10TkQz/+FW 9G3zmi8FbKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCav29XQAKCRCcnaoHP2RA 2RoiCACpP7sTwiHcRf/fSD2O9uYci8jFkLC/UilDQbiImo9IZbfBJh7PxLI/pcSWHRguMecGq44 1kCjlaPlpRm0ebnDuSGvxe4zo27aAMjlygNick1y8OCZkLS+Ln481KwHosRfyz1HdgW1Z7rb3D2 VXM05fMYrjyezK0jm8hXsnhgIV/J18iXp1yBQ/2iOts3IlCBKnofUpN8QyAT4mWom/9fnfbWeFp EgFrmZ/FXrtdybnV3JwagFu20pD0fvtOGnN5ikYpsOvVxIh8ErV5rkhJqS4QaqsHAKua000EKx1 siXdOGZeXsv/WDF3uTSs1X3RGQfNabZ8q2vKBOyf8hwXq1Z6
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 8C73C221AC
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

bdev_write_inode() is really odd loop calling write_inode_now(). The
bdev doesn't have any pages by now and if there are any dirty bits in
the inode state, they are stale. Just call write_inode_now() once to
clear them.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bdev.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index f20f91b3176e..9fa72df4f47a 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -60,24 +60,6 @@ struct block_device *file_bdev(struct file *bdev_file)
 }
 EXPORT_SYMBOL(file_bdev);
 
-static void bdev_write_inode(struct block_device *bdev)
-{
-	struct inode *inode = BD_INODE(bdev);
-	int ret;
-
-	spin_lock(&inode->i_lock);
-	while (inode_state_read(inode) & I_DIRTY) {
-		spin_unlock(&inode->i_lock);
-		ret = write_inode_now(inode, true);
-		if (ret)
-			pr_warn_ratelimited(
-	"VFS: Dirty inode writeback failed for block device %pg (err=%d).\n",
-				bdev, ret);
-		spin_lock(&inode->i_lock);
-	}
-	spin_unlock(&inode->i_lock);
-}
-
 /* Kill _all_ buffers and pagecache , dirty or not.. */
 static void kill_bdev(struct block_device *bdev)
 {
@@ -755,7 +737,12 @@ static void blkdev_flush_mapping(struct block_device *bdev)
 	WARN_ON_ONCE(bdev->bd_holders);
 	sync_blockdev(bdev);
 	kill_bdev(bdev);
-	bdev_write_inode(bdev);
+	/*
+	 * All data is written out and evicted but inode can have some stale
+	 * I_DIRTY bits set. Call write_inode_now() to get rid of them so that
+	 * the inode can be evicted.
+	 */
+	write_inode_now(BD_INODE(bdev), 1);
 }
 
 static void blkdev_put_whole(struct block_device *bdev)
-- 
2.53.0


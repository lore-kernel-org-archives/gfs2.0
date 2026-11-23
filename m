Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795424460;
	b=VKRfd1ZT9OVBPIUY93G17BBuNSXkIM4Zm82EkpzkdDjnA67mwd+X7+gf9p9RnbRs/Bo3
	 G/AH2D8VLIjzw0Mm4jrhc69E81HOLrU6JcYzSI7jRE4VBIgPvf6GUzskDwUUlJoRZjtGc
	 6EEP+dEAL4wx3bo0t9+p36LDome+lUtMd8Uv79nnnqQtYStx/yGYUJEdLVhh7d9tOWEy7
	 MgDrvXcXJLGFLxBSnMySQgHWbDQUvdmmjG5PSlgffJHvWiyu10Zm1vVXPootP7qaI5axC
	 kN7EJfJvbOPU9RonkKwsHb8EO6skvPfH2MrNWzyKbI82+xV5aSCmKdZo8ltg814tFPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795424460;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
	 X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=Z98a10fHzT++6ngZEHshG/H2z2HCNkc0ofB6cf23iao=;
	b=ZdKxagMrmy2G6TOEG71U79rVsuvHeSFnga2QR8RjMT99C+HGHGULaHySvvH0vYWNiLYH
	 ++OJx7PyNRYodnMm3OwfNOE3sLCfG0j2gvZWA0PJ/o00K6uIBYnsnZv0uDjOBo87T0ran
	 r5FNdiIV1wDHhgJlBhY+zj2daQDi31SNYjy3S0ycTmXIh65xsjEJJL5p23axHksDamVlq
	 QqKx4F0hyOC4cxOYkzWoMAUxBBXIsh+QbAKn6UODltsK/y7OKLU/Rsk6sCSi1GpOLHrx7
	 dI1NY3xTKem9cUhNAPojtRGoFZkMsm3mkEF5O9vshjhQCgyBf4m1y0i+Hkf+Rhbvqwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=RRmVL8NP;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PYdPxLmu;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=RRmVL8NP;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PYdPxLmu;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FAC606A33E;
	Mon, 23 Nov 2026 09:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39FAC606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=RRmVL8NP;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PYdPxLmu;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=RRmVL8NP;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PYdPxLmu
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5519D1F809;
	Mon, 23 Nov 2026 09:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795424458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z98a10fHzT++6ngZEHshG/H2z2HCNkc0ofB6cf23iao=;
	b=RRmVL8NPTNA1sPIX/gpC2YX2DA0P2UnAHq0DQoYEXDFwVkdqszb9sX9Py4Nj3s49mbo+FO
	rJV2kp1fS/w49JmaffydVeX2LMeUecVIT1cT+nEUB5ovIo9NR7XYtdFjOJVwwi3mXbe61h
	/5voiO2DEX3GhzjTDLTYAF9m84mcotQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795424458;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z98a10fHzT++6ngZEHshG/H2z2HCNkc0ofB6cf23iao=;
	b=PYdPxLmu+NYTlNhn+c3UuxVeuE9K/EfJUQKp0h1WHDSmVfVRRBnWn9r7teHIjXn8LU18Pc
	UT2PrTJ2RCWpamCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795424458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z98a10fHzT++6ngZEHshG/H2z2HCNkc0ofB6cf23iao=;
	b=RRmVL8NPTNA1sPIX/gpC2YX2DA0P2UnAHq0DQoYEXDFwVkdqszb9sX9Py4Nj3s49mbo+FO
	rJV2kp1fS/w49JmaffydVeX2LMeUecVIT1cT+nEUB5ovIo9NR7XYtdFjOJVwwi3mXbe61h
	/5voiO2DEX3GhzjTDLTYAF9m84mcotQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795424458;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z98a10fHzT++6ngZEHshG/H2z2HCNkc0ofB6cf23iao=;
	b=PYdPxLmu+NYTlNhn+c3UuxVeuE9K/EfJUQKp0h1WHDSmVfVRRBnWn9r7teHIjXn8LU18Pc
	UT2PrTJ2RCWpamCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E9CD13532;
	Mon, 23 Nov 2026 09:00:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AkgSO8kABGvpBgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Nov 2026 09:00:58 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 654E227600; Mon, 23 Nov 2026 10:00:57 +0100 (CET)
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
Subject: [PATCH v3 04/13] fs: Provide inode_is_dirty() helper
Date: Mon, 23 Nov 2026 10:00:39 +0100
Message-ID: <20261123090040.19006-17-jack@suse.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=953; i=jack@suse.cz; h=from:subject; bh=xOmo84WJOisQVAhQnOPGQkdou8zuAdb6TcwawJJufqw=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBrBAC7f2G0M3LorDLP5OvjOgq4WAHvSsH554SUA qj6hLx64miJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCawQAuwAKCRCcnaoHP2RA 2VfZB/9nkv0b/uq8W83ZqONmeZ2CIDdE8JWL3MNGKvWF/MlT+9/AFYE6GxbgqYpOjVkMKmLFzWH IB6b/Jv8Kay54/R0ltDWvPNm2XLZC372rNl6L/eIl+noEFmr3t1GB2+ZqwcWw+tXPn8eaD+eHTM iL29WH2A2n9HaM8jEBDuWQ1VbHkLLrDJ0JrsgGoXPkISGDAWzTE0NwGL8+xwByGkw1VbFFtU78/ 9gEZt+Vsf9g/kfj8Sjr0Bm9aBDffAFfi2DtPHcLO1whk/f/4B0H20yI9Dt2ShyxEmxQxAoR4/+D avdBS26UGbo1IL7ztYYZN2s0E6YQgtoTVcnSfAO7ZdxSdt/t
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-15.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLyaw51ggmke6bkcxeyajg5whq)];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Score: -15.80
X-Spam-Level: 
X-Spam-Flag: NO

Provide inode_is_dirty() helper for use by filesystems (mostly fsync
methods).

Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/fs.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 99caef43ff3c..025f5d890689 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2217,6 +2217,17 @@ static inline void mark_inode_dirty_sync(struct inode *inode)
 	__mark_inode_dirty(inode, I_DIRTY_SYNC);
 }
 
+/*
+ * Check whether inode itself needs to be written out either at all or for
+ * the purposes of datasync if @datasync is set.
+ */
+static inline bool inode_is_dirty(struct inode *inode, bool datasync)
+{
+	int mask = datasync ? I_DIRTY_DATASYNC : (I_DIRTY_INODE | I_DIRTY_TIME);
+
+	return inode_state_read_once(inode) & mask;
+}
+
 static inline void set_inode_metadata_writeback(struct inode *inode)
 {
 	spin_lock(&inode->i_lock);
-- 
2.53.0


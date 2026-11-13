Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559665;
	b=zcxyoh9KipkTrV0yoTgO+MbphdaCk1l6Ymxtr9no8XWxuS2vg606MZIPZEiYN1KRsKgb
	 BIiKG0GLpfs0ATYsK0POZZ7xpSBKHN+y+f6+C27vqxYYqC54yLz0eqGRwiI2L4d+6te7y
	 cYUoIrtzMH21B5bHO+Wuo/XRwFa4LWcCLcYXuYGWs1N1vyrrt49v3G2sAxgBI2IMHAxbE
	 bt/6yvmHAM8OXKRIyGnuUsJUU3qtyH6bMgpFGIW2wWY0oHUpGgYtLuBd40+8e83o3Bz9Y
	 tewupjO6cBh+yyuuh0TqwwkteoTfO5C8y0tev1kPZMCd5lBsgJN1I1+2F8N20LV1Zsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559665;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
	 X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=w+ktB+hADhROOqbNYDbHN6MpOpSVGoOsMK/z+CWJ584=;
	b=FxO3zRWFYYo+62I4dM3g44pk6NvhWEHs7X9I5fFyDpLp5T1bP4jFY3h1Uld96qfCl++J
	 ggazyNUeQ+khf7xhOdZCSiSqo9izp9Zo+xaLS0JON+XYsuSdjSrAhXr4Y7BzrDvyrD9yz
	 5pc3dXhm3L0oT/q51RDGJX903X3MUyAZ5mDfrQNnSVsPNfsz8wdsitNQ1rUBY/HFkFUzM
	 NbF3kvpkDVd8rMJjVrWFF0+Ig9GzHN1Yk82znz3w9Lxzqva43cLN1bkcF0xoRG3iYoDEo
	 sTDV5gQaerLHkfAOHM+Au+ZBn/oNqQRHwS9twalUtJ3SoHVdk1eMCvaMom74wlqt7JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=WyS8A6lK;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Ngsc1Lw6;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=WyS8A6lK;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Ngsc1Lw6;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF03C606A887;
	Fri, 13 Nov 2026 08:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF03C606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=WyS8A6lK;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Ngsc1Lw6;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=WyS8A6lK;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Ngsc1Lw6
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1E9E122228;
	Fri, 13 Nov 2026 08:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794559663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w+ktB+hADhROOqbNYDbHN6MpOpSVGoOsMK/z+CWJ584=;
	b=WyS8A6lKYDdbz89N3qMxf/31pGdpicKJ66XjiPgkC9i8K/Zqsy1xvy/sza/eo1uuGhD3W1
	B9gRvqMSGJMnIcPVrhhjXVJm3jmStFPMIN9LIbu71HGUbGKEs8w2RJP4TNF3W5RCFQYrWm
	QZUCCmrSWs2y5RIDhe9y88qGVWETf9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794559663;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w+ktB+hADhROOqbNYDbHN6MpOpSVGoOsMK/z+CWJ584=;
	b=Ngsc1Lw69xHdzJA0+kHhTkYF5RzV0VJ0O+z8WRrAuvwrbYlcdLBV0wiZuB33Z2P73JIVPj
	3ypx8JXCx2CCAIDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794559663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w+ktB+hADhROOqbNYDbHN6MpOpSVGoOsMK/z+CWJ584=;
	b=WyS8A6lKYDdbz89N3qMxf/31pGdpicKJ66XjiPgkC9i8K/Zqsy1xvy/sza/eo1uuGhD3W1
	B9gRvqMSGJMnIcPVrhhjXVJm3jmStFPMIN9LIbu71HGUbGKEs8w2RJP4TNF3W5RCFQYrWm
	QZUCCmrSWs2y5RIDhe9y88qGVWETf9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794559663;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w+ktB+hADhROOqbNYDbHN6MpOpSVGoOsMK/z+CWJ584=;
	b=Ngsc1Lw69xHdzJA0+kHhTkYF5RzV0VJ0O+z8WRrAuvwrbYlcdLBV0wiZuB33Z2P73JIVPj
	3ypx8JXCx2CCAIDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BAEBE13511;
	Fri, 13 Nov 2026 08:47:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MM9DJq7O9mqKFwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 13 Nov 2026 08:47:42 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 20EAC22C2C; Fri, 13 Nov 2026 09:47:42 +0100 (CET)
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
Subject: [PATCH 02/13] xfs: Drop pointless I_DIRTY_PAGES check in xfs_can_free_cowblocks()
Date: Fri, 13 Nov 2026 09:47:02 +0100
Message-ID: <20261113084700.739002-15-jack@suse.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=975; i=jack@suse.cz; h=from:subject; bh=5RenASwVKd959UrmSOrmHs2XXrW5Hmjd58TCtiB7f0U=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBq9s6FBOBsMoEoHviuMlRGWy9S5tVBf7sM9OMC6 okG7D1ZtreJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCavbOhQAKCRCcnaoHP2RA 2bIYCAC42jWLMaCtPbV7k84Uoa7NDayeEbNFrwzjl951meMVp5MWnbiOvWmUSoIMXgOMCl8lL8Y +izSqLPrARtsfomUMzFNRfHVq6rCzoHrLKnXO1LIQyOYvpXosX4l2ltV7XH0fvUIyr4kpZM7prV UrMqXOCuNHM4NbMCCYYAEQeKCJs2RPFpMNJNi1ti9//PfqQXh0vdyqyZVwXBr3ny1CCLrrM0qCp 80MbwT5nuLi1odoITHcEYx8jJRs0Glso1ohkPCMYh3kFxE2sXcC8e1pTxfNphU71VJtJHEkT+zo UmJ6GPJdioymeuu0Gjm9MS056wFu3KIJG0uGD+pBGx3BdZGT
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
	NEURAL_HAM_SHORT(-0.20)[-0.985];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -11.80

PAGECACHE_TAG_DIRTY is the authoritative source of information about any
folio being dirty in the mapping. I_DIRTY_PAGES is just an approximation
used by writeback code that can get stale under certain situations. So
just rely on the authoritative check.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/xfs/xfs_reflink.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index 683c1841e640..1310cc9fe829 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -17,8 +17,7 @@ xfs_can_free_cowblocks(struct xfs_inode *ip)
 {
 	struct inode *inode = VFS_I(ip);
 
-	if ((inode_state_read_once(inode) & I_DIRTY_PAGES) ||
-	    mapping_tagged(inode->i_mapping, PAGECACHE_TAG_DIRTY) ||
+	if (mapping_tagged(inode->i_mapping, PAGECACHE_TAG_DIRTY) ||
 	    mapping_tagged(inode->i_mapping, PAGECACHE_TAG_WRITEBACK) ||
 	    atomic_read(&inode->i_dio_count))
 		return false;
-- 
2.53.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559667;
	b=Vk375A3kniVkWkVRr1QRMAGMflzTsFto4WywJ8EgHggGSXWCizw1TK/T2hBEVyOswfLX
	 cV7idw41R0E5QjCEkBOqQw1dHg9QsdzSziR+8s7faWsttT1Zliu3yqTCRTrx9HMT1c9II
	 g7depRVW2/49rU9DqPUduwOfBUXny6VbkEOoywdAlhdBaRmvqTSJ12nSeNcofHIlM7O8t
	 wGNHtpjYq89zHrzTJiO6BTHO4tt3OoGNzWPYWdY/8+TX0mZ9eOcL85un5IAmUnSF8h+rX
	 +kk6SRJWlsFNXNyRZzsKEUXGOXsk7tQVnMRotb5f1kRoREKqlsnVuPHsJrOs4t/wPqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559667;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=Jp8Bf6/C7qzSRkDIS67w9/8cYQC1IS1l8hdUpK+q58U=;
	b=sjJyoAoSHQGnSgv2jYwPUBZ7S6UfL6S9LxABprHE3/40TWKvsWow/7ZTPykd6RCCCYtm
	 CuHIeKDV8jFxcVtoHhtG1iq8HAOC4R+/tbSsupLiS1OTGCbgiAfHyS4nSIWYmgtYZohzm
	 W6RiiutagyDgyiTYOL5grfGIZF2ati5jYIPtkhhRqzr/RBvN34iGRFlo/+iLgD/hfJlsZ
	 QsUiuo8J+WRyH2OxgWcv6e28iCL97yEovylnejy7/QLiVAvxgfsxccmlsr9zeeYO6vzJR
	 u8wIEyGOd3Lp1m/dXKJP49NOdCiOwswa9Agii6xqLIJ1fFPe6SPKocih+iLWj5EF0bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=psx6sHXW;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=rtJVNDY4;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=psx6sHXW;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=rtJVNDY4;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D4060A5BFD;
	Fri, 13 Nov 2026 08:47:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32D4060A5BFD
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=psx6sHXW;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=rtJVNDY4;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=psx6sHXW;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=rtJVNDY4
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C714A1FAB7;
	Fri, 13 Nov 2026 08:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794559663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jp8Bf6/C7qzSRkDIS67w9/8cYQC1IS1l8hdUpK+q58U=;
	b=psx6sHXW33bXpiX5vtiluotBQx8z4D2FtzWPK21c2eABnypysJyjUXeWbFcFal/WjiMBT9
	KQsS6zyLIhDW3kSPdXEuS1lXDK/kMQGJwToyGY38h/KajaeMYpraQkk3wbYUDxl+o5Ej9a
	hfc3R9c8Dk1n0Ry8260ThEu3Q9w7wdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794559663;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jp8Bf6/C7qzSRkDIS67w9/8cYQC1IS1l8hdUpK+q58U=;
	b=rtJVNDY4Yy9prh2hoZoy6sptInbf9+z5txCvsfkkFL8JeUBS8M9sCfsM3kSQejex6VlanK
	8l1wwJE0MvbXTVBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=psx6sHXW;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rtJVNDY4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794559663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jp8Bf6/C7qzSRkDIS67w9/8cYQC1IS1l8hdUpK+q58U=;
	b=psx6sHXW33bXpiX5vtiluotBQx8z4D2FtzWPK21c2eABnypysJyjUXeWbFcFal/WjiMBT9
	KQsS6zyLIhDW3kSPdXEuS1lXDK/kMQGJwToyGY38h/KajaeMYpraQkk3wbYUDxl+o5Ej9a
	hfc3R9c8Dk1n0Ry8260ThEu3Q9w7wdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794559663;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jp8Bf6/C7qzSRkDIS67w9/8cYQC1IS1l8hdUpK+q58U=;
	b=rtJVNDY4Yy9prh2hoZoy6sptInbf9+z5txCvsfkkFL8JeUBS8M9sCfsM3kSQejex6VlanK
	8l1wwJE0MvbXTVBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C9981368B;
	Fri, 13 Nov 2026 08:47:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dEcbEq/O9mqnFwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 13 Nov 2026 08:47:43 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 6785022C42; Fri, 13 Nov 2026 09:47:42 +0100 (CET)
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
Date: Fri, 13 Nov 2026 09:47:13 +0100
Message-ID: <20261113084700.739002-26-jack@suse.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=755; i=jack@suse.cz; h=from:subject; bh=8YjGys7j0AZPC+xTuLBhes4R3hdR8y5UBwcvGhQGyuM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBq9s6Ow36xnBrH5xG73VlTHqBQWHyHrFmP8Rknh e7OYuEfA7uJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCavbOjgAKCRCcnaoHP2RA 2Z1FB/9cTq8WY84iITTzQ5jxBg6sqwjB/ugvgvJ7QYXLBgIDGh2XYVxQi03EGY6QMIOy57eMBox Jr4sFnfzovBIIvoXVh7iAL78W/h8oKUIXIzXU9vjmJ8Na8MMy1IEJ2I4jmJw/VL4txtf8aGbeq+ 3Iq1NCqRvsfn8yWG3/IIQYJB00cc/qgNgX4Z5HELTkS73OYEYQpOUsBOkBQ1B13QUmciiJD4F6s WLGvFtFFCf6oOTNmapB8ffKpk7bbxLMCMkCnQTxPGB7F1ZvL8ym+agnc+imrtBOVgQfo8ucR2ty Rup7bFNingNJ7FFkmCBmapU7abr2/9i+3k0Vfj6HZGc9VqLh
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C714A1FAB7
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -12.01

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


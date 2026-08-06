Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3DD3AAF6F
	for <gfs2@lists.linux.dev>; Thu,  6 Aug 2026 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035555; cv=none; b=KEwaPPRUFLnV4HySWRFlayRK3IePlMHG4bAWgmcN/v1SOOSZglYpI1airz/bIl45PncCai8dywlMawkhOchKh+KfiofrrEYlBEM/XjdyxKMTMKnm8iediYEj+P1dHaG4aJNFkNf7jqE02nrNQmZgWCM5YMujtq9yCe999oe4g2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035555; c=relaxed/simple;
	bh=nXfjVTs2WwI7r48njT1474MNwTWULNnJflHmHfHsQpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V40DKJE6BPFPk22qAc2wsD0Fo1nQMM0iyjxMNFzXoJL35koDZbmSV7iKJ7EjkSataVZFTFhNyGdpc/E2utJ1TqD0aUCpY45CmH2q9fGCywSzDeky9MrS/ovHNM3Cv1y68yvwjtIOjJIqEv0Lw9kSEw131BZk+W5Bb25+K159v10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCRvVQMZ; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCRvVQMZ"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-966eabad303so593306241.1
        for <gfs2@lists.linux.dev>; Thu, 06 Aug 2026 09:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786035551; x=1786640351; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/lKy66WaG7+TnlzmHpXjsimPtvzEbNlkmMtBXzg/7M8=;
        b=fCRvVQMZr9I2CMTg3SFoKEhw2GUV+Mz8+YvukLUjETqYV4teu9VJG2jYVQE4U7jxXi
         28uf/xzfVxDnHPnwLIN3dVwOGQPI38pYZOxGaXi+DEsQ82fG0AT+c+vsbV7SG+jEU+Se
         Uw4YOfuotVt8IPke7iL0TSIF7KYJfcWbpVHIYT4ByWXEiF9GIRet4NqnwY2pJAUtWmPm
         Win1tOC46+8HoRst8YuEQGkmdbFYONl9H5v8uMMT5CEZnLYZr61ZWD81VFsS81P7xEou
         1AaWVzniUixpPJ1vXWZEQEvcqBIJxQsbwvVTiAeN1YzbTMS97mkHKev1Y9binyTvmvpm
         s0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786035551; x=1786640351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/lKy66WaG7+TnlzmHpXjsimPtvzEbNlkmMtBXzg/7M8=;
        b=jaPnoyiRBRXWeGp3Z4Aj5g00/W4S5JwnsHpp7BCDh040Y5OkodG6ME2b/gUAWXboad
         BINvIoZxHx2wvqXELdwFXOxiKeeLSmzA8wUBc4tXkR/0hkE84/AUu+Bq/TAEYZjUtjzc
         V36ey1VigHRZuCeXszRpJrh5ScNfiMlTT0tKDTvZ8KG4nECYlnwGQHQcRPPSOI3W2ESB
         VlWRIMKexfGlZll76iw4UkNt/NbYPz4jdD4V4o0yiNUSI60eJ9oSZOAsxW91YfReedjm
         ZQNVC1WZh2M7qQQNGMvRhoWsF7rWXx8lze0UR/lPkigb4cEENi7SzR34rLLU6/gU9T9+
         en6A==
X-Forwarded-Encrypted: i=1; AHgh+Rr81lRcwvv969hk8kPuZN+sUjj6ZCSowXsZWAhFgWkiH7gqedBtodnve+1hGAWoUrF8mYeG@lists.linux.dev
X-Gm-Message-State: AOJu0Ywtsd+0jj2S4EqkZcY5M84jTaQH7RI6hk+1dCjZlgiFbNmad+8+
	i0jchRi6j/PoeM3VLYH1hZuv1RigxFrjFS97mshvUlxVG8G8d4ltqz7z
X-Gm-Gg: AR+sD13eTCR2U2a4QWGdLq16nXahV2vmdvbws/y4vc6bg/bl2TbK8fLHhFqY8zsYSyO
	UNNHCBbGJgirhUPiesLyvT7BclUE534/ydSbtqu8Pd9jSNAjItlaGalC5Wu17AzPQrmZoen0oDs
	G5j1oolvmGsWLI1hE2abJRAYNwovHyPFL59NxN8GzJa8CrAX7NQR2fVsSW7ikMZCPgXocHh1tal
	kX4RHh9W/Ucb4uQWlbW7h/oUfGv5HhmaNe7ggZBt/Uc9c8g0BHl76kmVUc+H8l0E18tppt6kfUe
	+8oaHU49a0mRT3SmFJe3FFIjWiWI2xT/h6uS6nc3xU0nZSAd7mCxm56cyTT3KPt2KAqYBLwO3Wn
	LEwKdHCekUd+KTKPQeuFJyTRnq/7nuoZxBrxa9nIc9KTsUWKpbVzSmdBN417DNAp4YKcDVwRJPy
	J9oEge3pA/5/lLJa0vLqUURHVdFJNQWoo8m/aJzjVUoLeY7uf7Q58gENYrmr8ZQFtj6P2qWFTmB
	13oF2E=
X-Received: by 2002:a05:6102:f09:b0:6f0:3ba3:7d84 with SMTP id ada2fe7eead31-760e77f0ff5mr4020392137.5.1786035551228;
        Thu, 06 Aug 2026 09:59:11 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c3d05c594fsm3706321e0c.8.2026.08.06.09.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 09:59:10 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Bob Copeland <me@bobcopeland.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-ext4@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chao Shi <coshi036@gmail.com>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: [PATCH v2 04/21] buffer: read the folio's mapping directly in buffer_set_crypto_ctx()
Date: Thu,  6 Aug 2026 12:58:27 -0400
Message-ID: <3fe72ec37bf8491a69031db5f3ba1319da935b97.1785951556.git.coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785951556.git.coshi036@gmail.com>
References: <cover.1785951556.git.coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

folio_mapping() was doing two jobs here.  One was to turn a slab folio into
NULL, which is what made this safe for jbd2's shadow buffers; the previous
patch removed the need for that by giving those buffers no folio at all.

The other is a hazard.  folio_mapping() maps a folio in the swap cache to
its swap_address_space, so if a buffer_head were ever attached to such a
folio this would hand fscrypt a swap mapping and dereference ->host on it.
There is no reason to want that here: this path wants the file's mapping or
nothing.

Read ->mapping directly.  Buffers with no folio are already handled above.

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Weidong Zhu <weizhu@fiu.edu>
Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 fs/buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 04fcc34e4fa6..2851830995d8 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1108,7 +1108,7 @@ static void buffer_set_crypto_ctx(struct bio *bio, const struct buffer_head *bh,
 	 */
 	if (!bh->b_folio)
 		return;
-	mapping = folio_mapping(bh->b_folio);
+	mapping = bh->b_folio->mapping;
 	if (!mapping)
 		return;
 	fscrypt_set_bio_crypt_ctx(bio, mapping->host,
-- 
2.43.0


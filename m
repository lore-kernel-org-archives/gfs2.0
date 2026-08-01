Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0FC331ED2
	for <gfs2@lists.linux.dev>; Sat,  1 Aug 2026 22:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785621671; cv=none; b=k1YvSdEczQGrihKR3AxnwATToL7NAn+6FbEcRIzu6q4iS9T5nc5fsFWVXSdxjP/jGFXPMRLGmDVdkU3FjqeQwN+WyMVCPCD6abwGgZX1CFLmvc8GmQz7DvAk7suIBJcrY15cpop4Fu8ZaSET1FMctGERsx8A3p9xCEmiA7gW6qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785621671; c=relaxed/simple;
	bh=fQPgfXMhlq+1VG0MRuQEzdSC7q5vWTQFKVnCNqnuFvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sur+xfrFKYP0Mm0zrmuXXDZ/A/t7QjXa8GvTbgk0YO63BgvIgo5Z90NBz1qx3afv0/lX2JuBai6D/FgVi5QB+WGIgwaWpmWTSZ7qGOuduE0YzIYcgMZdKhi6yEZ3JnX4QDxsjXHOxkCeZTJ/Jtn7LylGmCxYjp/uSEIJM1mpYeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtM0Lwpi; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtM0Lwpi"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81e9d8f3289so31561637b3.1
        for <gfs2@lists.linux.dev>; Sat, 01 Aug 2026 15:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785621669; x=1786226469; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=boTJ4NLnnkEUxDYA6Ii16la58dxC2XdEwOIDbV8GTAs=;
        b=QtM0LwpiL4jag1qhtcfhZNmuolHSvtcWHqg+5ZWoNHgYTymr9dxiQvrKfo4eO4Hnpo
         LlpNNkUWwmzgSNVN0ELXRAu54WxGUSgHY8i6uKNPS9ylRd6gb8XOHUCFuA0fhDBAlnOS
         /2Q5p4Oxc0g+xRzQze4ETQvConyoRHBXeuVSLqSRlbHDVrYhmlRxNAo+qyyu6sH79QpP
         jlbydJSZBRHjjNElZDC038ndt1gBCONFsIEVps8BJF3J246EeZwu76l5VdLnqLZ9eOPV
         SUkX6jgzt3A+NkNaFgHgFOEjX5zxDYRNFJaRPi9Oqn+jXwvWCkYMXFPFIoBkS/PXy0nK
         DQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785621669; x=1786226469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=boTJ4NLnnkEUxDYA6Ii16la58dxC2XdEwOIDbV8GTAs=;
        b=KUTXhOJU2v7EKT57IOW5dYlgdNxt/aHmviy5zpIJr1M943WT4OwKa6MF1DfeRwhF4j
         mV3f9ZYuM95v7khP50+9d1pcpr2f9t7xyC2jYtyAs0ndg4J8+3+CzLf+W0Mr5f/iW3oO
         yWENDAkNwpmSPhaWMII1HF9hyS3HV1tNvD+Xpp9/cz3yTkyYyvbiBYGMdRoEp9NAR4Ww
         gfgCmxkh5REJ66R1FZ9N3Brm8gMhV343sGThfeBgtxi2KdECuXVkJmxgZFKpBBBl346Z
         R8Wk+JaHosZhHQ91nBSS2QL1gmsFNZ1eXHnFZNBPDxP1onIppo7BUKcwPuPaWyEO5+Tf
         tPng==
X-Forwarded-Encrypted: i=1; AHgh+RoBFe3VYB4CgcSBKrPzUgMZ1rNuN1aLShKcQbyjgb0IZXCXZBOfqccT0P5mam4KKo93PMQ5@lists.linux.dev
X-Gm-Message-State: AOJu0Yyafzt7SAmqNqo7qRjg8XgpKcH5kUhPW+TPaPbKuSfhQLP26Jyr
	iDIhFy3rwRwzDBiEinJDMoqXxDedv2FZrZCVNVUXBS8VSHu+0vB1s/4E
X-Gm-Gg: AR+sD10RCsX3xNV9C3GWebT78oG0U+fgow2xY4+GBvk7hAYI2yUKaNrmTrcE9EFQ662
	FNZIVcqMFDtTshKoSIByqAOQe0C1lue5PcDdXfNPqrp6dj6QJ03Drzr8rWw7Zy9Vwd+KwbM+C9Z
	F7vPgh5dXVTGtsiIhKHamzhyz0JO67JmXeusFtekhz2uLPkIWTcPPoMeCRhSJSdFzWDZxA7NpJo
	xDTg69f5EmRu1nH5ZJmEXS5Gjz2fyF9dWeGaB48M1w2Fmz6bvScMFLnlAeNfbCxvchAQou0/KFX
	PgJU6IS1uq6V2fZWRbgStgJpqes6DkK6PhMzU3ZwBuZz4zMvaog2wiEA7SCj94/BNkYCjyRixVm
	v2Ik0+uaQoUjQbPORfXQHMp8ZJm6oP6p73gJcRaLJhf8Rb06xPxB1DseVuBny7NfS8mlLL1nEdI
	ok3fqMfTk58xudzUv48IKJ7FvvMMoBF5jXyMGZjxhNS04g/zlshr0q9BP1VX52V/TFp5ztRs38z
	Jcam4E=
X-Received: by 2002:a05:690c:688e:b0:81e:c998:9c9a with SMTP id 00721157ae682-81fd4bce906mr71495667b3.17.1785621668857;
        Sat, 01 Aug 2026 15:01:08 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd0d6fbbsm29903767b3.25.2026.08.01.15.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 15:01:07 -0700 (PDT)
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
	linux-karma-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Shi <coshi036@gmail.com>
Subject: [PATCH 01/19] buffer_head: Remove b_page
Date: Sat,  1 Aug 2026 18:00:45 -0400
Message-ID: <e0780ecfda9137d5755b4ac3e227152bf4c7983c.1785621505.git.coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785621505.git.coshi036@gmail.com>
References: <cover.1785621505.git.coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

All users except bh_offset() have been converted to use b_folio instead.
Convert bh_offset() and remove b_page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 include/linux/buffer_head.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index fd2c7115c054..699970b4bbf2 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -59,10 +59,7 @@ struct address_space;
 struct buffer_head {
 	unsigned long b_state;		/* buffer state bitmap (see above) */
 	struct buffer_head *b_this_page;/* circular list of page's buffers */
-	union {
-		struct page *b_page;	/* the page this bh is mapped to */
-		struct folio *b_folio;	/* the folio this bh is mapped to */
-	};
+	struct folio *b_folio;		/* the folio this bh is mapped to */
 
 	sector_t b_blocknr;		/* start block number */
 	size_t b_size;			/* size of mapping */
@@ -172,7 +169,7 @@ static __always_inline int buffer_uptodate(const struct buffer_head *bh)
 
 static inline unsigned long bh_offset(const struct buffer_head *bh)
 {
-	return (unsigned long)(bh)->b_data & (page_size(bh->b_page) - 1);
+	return (unsigned long)(bh)->b_data & (folio_size(bh->b_folio) - 1);
 }
 
 /* If we *know* page->private refers to buffer_heads */
-- 
2.43.0


Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722D921A436
	for <gfs2@lists.linux.dev>; Tue, 24 Jun 2025 02:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731799; cv=none; b=UbeB8YVdX4sV5QikOcnXp15IqjYgI7Kvkoc+Bd47TH7c2mNWyI0ipsvIPmn3EZkMyrWwM6YNppKOco5s8lxOq/3w8ntK2z+E6LGEA6DSw6kNpf41PlTSy8bCQheJqpnmx34NnCQFFP9PBpgFmR+NCsNTNeJzwzJz/5goozRyYEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731799; c=relaxed/simple;
	bh=MmTF11Eh53lyUsKigZr6Fn3JQ/uNC689oDShC9TGW7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RijX+F7sbpRz7lvDwOuLSkejdIBwTdPwFl5u/QUDHG7YqqGdE36be0xixZ6Sk96j89IQUN7ep0NqRYOuWvIJ3+u9PWcKyvs62neL3r3Hj/7Dei72Wymjy0gCLKBkNP4gTykSb41c8B+V4CRncyF50X6K4MrM5V8usHCQgr0vKTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9djJOE8; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9djJOE8"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b31d489a76dso4192711a12.1
        for <gfs2@lists.linux.dev>; Mon, 23 Jun 2025 19:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750731798; x=1751336598; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uC/d4QEJK/ybiLqfNK3ZCfjMshm+NbPOWFShLOrM9I=;
        b=k9djJOE8BlrsyqvlR/20GvzGB6iosf3y0P5zDJVQn5csoy7NC3uis+lFgdA7mdl3h1
         cWKiw49CqUadDbojZtL00orJmVwQlk1n6Nzaz1G2zSg1f5/ts6OlVYO2alJRzrZGwVU+
         DlngoP441oUSO9tk4lF9MRQPNulg4PqynK3jUOwUANSolwVqhvk+UZrgUCrML/LYECFm
         QfFq7QWn502f6xDUrWKWZT82guHwy292z8qC/Fk7gr/osK3PMc9hOsSehBuWfdUKBYLv
         7McQXxWgFH5J8goxYWZxako2CPhQV7iUPtHEsJylMiRlVGM4KooSH2sfP8gWPsDmFquq
         3QCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750731798; x=1751336598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8uC/d4QEJK/ybiLqfNK3ZCfjMshm+NbPOWFShLOrM9I=;
        b=mk23X9zq/lSM5PYG8bBQJSse3XZPtIzt/9wS0mHVLudZwpkW8MyVQmUbv4TZUtO8Xl
         ijMEs+sb5p77Gb3ffWvmsdrZDt/NlGlOjfXkrjnU9G5yDo7aUdTvyRhrJHl8gZBl/6xo
         y4swAXxGekc4xom+62nA0rjGQWQ5ACtzzZujmz5SPpUXYsqiDSG9mYy9LlXiGQdF4nJ3
         8BAdt3bOlGF58T3s4VcC8XiigSvtwRj/38OVTISG/Su20kVlLINJ4KcSwliz0Grgs2yN
         3G/3neiUxxPlbQYiFo3CKTxtbuuEslczoa28MybR7tB0gUBAaJU2YyVkuYrK9SgVtCFe
         dTcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU66/WPVaaw5g6rIdArx0rmZvw8cGr12UpROOMp+9jZK0VU2Mta1DWnWAuCyle07WBfdZyx@lists.linux.dev
X-Gm-Message-State: AOJu0YxR+ebB3PmrZMLl9KLmMgxnjrBUikxYggB1ziQrjFIA5N1NgYUX
	gJggAKknt4lxskljGbMRuddpTC/3RZRZN/3EgAWnAYBVXeStEwRVV9jZ
X-Gm-Gg: ASbGnctGact2bIzqVHQHgfUAhUzrc4F+ycd4s0FIoYUPS74mBFoc6OMXgcwKVZibPWh
	AfKJzmKWipRGZiRMVE425pax7WT3jmcCGKG8Boz0jIn787INKOOef3weD393uCzI0basz79lfTu
	3P11RMoa9iVEOaExxKCoHTZ0YxDcVD2ST7vbY1alDKctZALvkg2o6gW16ucnuHTeP80DCqOywhH
	iJUGKulF5JzTBvQRAx4fC6A+sRJqzgzZCzGfktbwEqxQ5FWvH54BYG0BSXL2ZWo+RC/aPzzLAt0
	Qhd0h7m31vExZdl6AVPZHrE+QCkqWlIt2bs7utTccl+MNmq52mRueUiW
X-Google-Smtp-Source: AGHT+IE5q/BmXMe/ZkM4s7fJps6P7YPv0Tca4e+BXB9TjXlzT9WwpbxPPeo9qsYqSSWrVdQBTyG4Eg==
X-Received: by 2002:a17:90b:2c8d:b0:312:ffdc:42b2 with SMTP id 98e67ed59e1d1-3159d8d5910mr17771191a91.23.1750731797715;
        Mon, 23 Jun 2025 19:23:17 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d860b8c9sm93534445ad.131.2025.06.23.19.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:23:17 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@lst.de,
	miklos@szeredi.hu,
	brauner@kernel.org,
	djwong@kernel.org,
	anuj20.g@samsung.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	kernel-team@meta.com
Subject: [PATCH v3 14/16] fuse: use iomap for folio laundering
Date: Mon, 23 Jun 2025 19:21:33 -0700
Message-ID: <20250624022135.832899-15-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250624022135.832899-1-joannelkoong@gmail.com>
References: <20250624022135.832899-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use iomap for folio laundering, which will do granular dirty
writeback when laundering a large folio.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 52 ++++++++++++--------------------------------------
 1 file changed, 12 insertions(+), 40 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 2b4b950eaeed..35ecc03c0c48 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2062,45 +2062,6 @@ static struct fuse_writepage_args *fuse_writepage_args_setup(struct folio *folio
 	return wpa;
 }
 
-static int fuse_writepage_locked(struct folio *folio)
-{
-	struct address_space *mapping = folio->mapping;
-	struct inode *inode = mapping->host;
-	struct fuse_inode *fi = get_fuse_inode(inode);
-	struct fuse_writepage_args *wpa;
-	struct fuse_args_pages *ap;
-	struct fuse_file *ff;
-	int error = -EIO;
-
-	ff = fuse_write_file_get(fi);
-	if (!ff)
-		goto err;
-
-	wpa = fuse_writepage_args_setup(folio, 0, ff);
-	error = -ENOMEM;
-	if (!wpa)
-		goto err_writepage_args;
-
-	ap = &wpa->ia.ap;
-	ap->num_folios = 1;
-
-	folio_start_writeback(folio);
-	fuse_writepage_args_page_fill(wpa, folio, 0, 0, folio_size(folio));
-
-	spin_lock(&fi->lock);
-	list_add_tail(&wpa->queue_entry, &fi->queued_writes);
-	fuse_flush_writepages(inode);
-	spin_unlock(&fi->lock);
-
-	return 0;
-
-err_writepage_args:
-	fuse_file_put(ff, false);
-err:
-	mapping_set_error(folio->mapping, error);
-	return error;
-}
-
 struct fuse_fill_wb_data {
 	struct fuse_writepage_args *wpa;
 	struct fuse_file *ff;
@@ -2281,8 +2242,19 @@ static int fuse_writepages(struct address_space *mapping,
 static int fuse_launder_folio(struct folio *folio)
 {
 	int err = 0;
+	struct fuse_fill_wb_data data = {
+		.inode = folio->mapping->host,
+	};
+	struct iomap_writepage_ctx wpc = {
+		.inode = folio->mapping->host,
+		.iomap.type = IOMAP_MAPPED,
+		.ops = &fuse_writeback_ops,
+		.wb_ctx	= &data,
+	};
+
 	if (folio_clear_dirty_for_io(folio)) {
-		err = fuse_writepage_locked(folio);
+		err = iomap_writeback_folio(&wpc, folio);
+		err = fuse_iomap_writeback_submit(&wpc, err);
 		if (!err)
 			folio_wait_writeback(folio);
 	}
-- 
2.47.1


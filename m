Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A54F23BCF0
	for <gfs2@lists.linux.dev>; Tue, 24 Jun 2025 02:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731792; cv=none; b=ITVJXkCdirZnIz7jYOUsGlsCbms3RGa29oNnEeC+Z2gCa3JGQvK6Tyu5Pf/NYHpMb1Gx/pbHdepCabzik9qTvkTqC/Mx5ac6owSctz/a7qTudHicrdfda+/L/z9O3nIkTgDJdJMFR3hDyR00NGdhK+24TfftlEIfSHHfhOL0XPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731792; c=relaxed/simple;
	bh=1omTk1Ch+v0J61SN5PsUTdcgoiWHtCmb4QEydnVokh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4HFwFl0EJHU6z3Pk8wo+1TVn3Lpm1TQx64sY4t2xwDFhZ738ixco6EPxfJWnEO0tFJRMDntVg6wh5CKo3qtgC8jGpBPTjnYTowrcxRUyEE1WN0TlDwZ4zL+8LevJNvE7RRsH2kazNDa3QPh1r8KWogdrPRTKQ9V9QCEl2t9aMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8YoN5Ue; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8YoN5Ue"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-235f9e87f78so51442945ad.2
        for <gfs2@lists.linux.dev>; Mon, 23 Jun 2025 19:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750731790; x=1751336590; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tox0Qswx9v0l5ZOogOjVwIDqVz0HHeeI62d4g2LDVOc=;
        b=i8YoN5UeglTx/cfVOtnbkihJd+Hk3hGdkigQhQ2S2U2yWZGM6fF/c593s1toXm9Y5r
         XkVJosZafLweak9uSPcW3qk9Fw9tKeBsJ9kuEg5qhONgR6AsVL0BtLKlHAbZhlwyb/6h
         5OOe2NF35SZ79v/DUQGiBNhl9gnpBA5h2QKWTMvM8WQFRoyWNYVL2ErtO7mcXOrjVea2
         3ipdECEKtzLYZJXjTHRq+xu/rICjg0mxfvvIzx97I5WrOHMyyWzekxsK4lHZCG5g9NBO
         o4uJvZev3Boar/SbRvnNHtsBnmXUjHprFSMWKSUgM6d6l5z4VBVpWcqpnjKLNY2BE/q5
         2u7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750731790; x=1751336590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tox0Qswx9v0l5ZOogOjVwIDqVz0HHeeI62d4g2LDVOc=;
        b=PWAE0KgrnrFjbZ87MkCI1zJ8HrYSr9xpR3wwa4Cjqx+DpgGVJnTWbMr+yuRXRFM0Hg
         2DBqmlqj59sSjNV1fomYY4+tpvCvLTIZz9kAT+ug5s6n934JQBLS1zf0t9XAK9OqjcHt
         hZf4lOZRReMbU68MEuoruKAEpxv6gD6e5JERWXApmkOumBnjJ2JdKP9+mS38aDJMtBEv
         eBhzwCE9ZAisSmPaUvTvKzfnZSDgNv0FyC4b8mkMM0LjwsrL3Kpes7RKaVE37XKFuCTa
         N8FvY82xkD+r1Fn1nlrqoma46HZSv1H/RthKrlMwYH7HP3bDlPxD6GWcqPXz3J1IgiNH
         sRRg==
X-Forwarded-Encrypted: i=1; AJvYcCVCyoTC+SuYOkhH5UI5DcwKr5Dh8q4XjILJBBuPffeEym1CCjQpf/pG42v7X2MFzJ7F6Zqu@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8yCzjaeD0BQh+krM+y/Qcy13SojYojSF59cJ4FmEGaSbGvXRC
	SR1McpyN3LehrqUIyVES5sjfIThSoUNc3TOpG26e8FC3wQPIoZsuBTZl
X-Gm-Gg: ASbGncvH1BgBkVTTcIvxsB41LoApgIcXI1uZBLo4PcrAzIXzTKkOtGASEi7lwazCB8j
	amq8ZvVc2wGArA6wMHnRdwEoP0vG7Qa8RisMrXabgYazxpHeCWwv58NkTMWKGQ7ZhTIsjS/yPon
	54w9flgk0KVFvsPdfTT/g/C4ke/LuLbpaXgpGFe7gPeSDZKh3imTWWYaliSsOWeik66FocjPXp/
	XOoeNBNalLtSgdIk9Sn0bGExShCy0X4P8NIJvOJVMhOMF8JovUPzLYMqx3UKwtAKSerW7E3WmXT
	4mZEfjTFYEBd80my6JfOMZUZLVssibXtwDodoe2y1L8m5xOzWRZJyRLM
X-Google-Smtp-Source: AGHT+IH5CRqWFclGp4+pjO3Krc9w8Dlmdz6YsBo5B17VXk21dqxgX65WgOovZM324PVjmcp/pfeQBw==
X-Received: by 2002:a17:902:d543:b0:234:a139:120b with SMTP id d9443c01a7336-237d980d666mr220447735ad.11.1750731790587;
        Mon, 23 Jun 2025 19:23:10 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:a::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f11a20c8sm9120603a12.27.2025.06.23.19.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:23:10 -0700 (PDT)
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
Subject: [PATCH v3 09/16] iomap: export iomap_writeback_folio
Date: Mon, 23 Jun 2025 19:21:28 -0700
Message-ID: <20250624022135.832899-10-joannelkoong@gmail.com>
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

From: Christoph Hellwig <hch@lst.de>

Allow fuse to use iomap_writeback_folio for folio laundering.  Note
that the caller needs to manually submit the pending writeback context.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 4 ++--
 include/linux/iomap.h  | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 2973fced2a52..d7fa885b1a0c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1638,8 +1638,7 @@ static bool iomap_writeback_handle_eof(struct folio *folio, struct inode *inode,
 	return true;
 }
 
-static int iomap_writeback_folio(struct iomap_writepage_ctx *wpc,
-		struct folio *folio)
+int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 {
 	struct iomap_folio_state *ifs = folio->private;
 	struct inode *inode = wpc->inode;
@@ -1721,6 +1720,7 @@ static int iomap_writeback_folio(struct iomap_writepage_ctx *wpc,
 	mapping_set_error(inode->i_mapping, error);
 	return error;
 }
+EXPORT_SYMBOL_GPL(iomap_writeback_folio);
 
 int
 iomap_writepages(struct iomap_writepage_ctx *wpc)
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index bfd178fb7cfc..7e06b3a392f8 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -465,6 +465,7 @@ void iomap_start_folio_write(struct inode *inode, struct folio *folio,
 		size_t len);
 void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 		size_t len);
+int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio);
 int iomap_writepages(struct iomap_writepage_ctx *wpc);
 
 /*
-- 
2.47.1


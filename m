Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7909C2B2DA
	for <gfs2@lists.linux.dev>; Fri, 26 Sep 2025 00:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758846566; cv=none; b=mVR8mZvdC5FtNCjiu4Vefc2euzSRWF3sHTZhD0KjCEAU/qehGPNk1VI2MKyFJQUpZ0KEEYHBrb8u/oGuZEvYzFGHtmPIplnkqDdDTxs6UPhpRDu6j8YYv7xcO4sqAu7GzcL7kGyyILgL0YX92Z/sVj4m1sDMOONe4jEJyHzHix0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758846566; c=relaxed/simple;
	bh=0W/7hs78HuUmwTCQkUj3WBChFwPbbkB8GVUDQwx06qI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rA6i+16DdNGxDr0SfXt0SpzB6JRwx9SWlKy81oo4lHH+787TlWkLsOPWg1SrsJNho0R5iaSsLGXu6CCtXVCNWCqTWNLDc/IbR2JGJmPQvHUBMARRiBoTsb6roWVdmcSlUSqbagQ1P4VcmKP0RffKRiv4vdTPir0YWBU3Y0Jpi1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSsuUCtX; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSsuUCtX"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-27c369f8986so16066155ad.3
        for <gfs2@lists.linux.dev>; Thu, 25 Sep 2025 17:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758846564; x=1759451364; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HMJD9Q3ddlq5CyOM+oz055Su9+4BhIKjGA1980+1kzg=;
        b=kSsuUCtX5ULxfZR/yEogCPSMSpTHoQnCR1QKnvVPlpwS1UMpUOyOysG1v3X5f6ZNFW
         5GLCn82RdhTD6CruEJPRCb6ejxyLsM4dXraOhOT4sCrJnZa0Pcv/lmZmGuorCuc31+Bi
         f8YyJjYKIYTo4jx6KILY5+nVwZ0hEo8cy64TNJswEagnQ/Lz9yp5X+3RRn7cVuzR8AnW
         MXY6epW3ViMvlAZ1+8bC3iG1A7rCGH7AIpU91mIlPyN/flbaB4n+sI7i+8gM0UqXxH3p
         FloFyM29w7Sj8dgdYdldXZ8IwvcSMJWT6kWbh923OoNObKvujrVkFxyp9ZhJTiey0bgk
         +trw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758846564; x=1759451364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HMJD9Q3ddlq5CyOM+oz055Su9+4BhIKjGA1980+1kzg=;
        b=B39Gi+NB1JD9/aE4ZyegEatShMfB6PrypLYLlsuRW8+/kk3lZsU6005cUz00mY4rqW
         VqtPA0PkMrVVKlXVTvs1okByGB1pIrfrdXzjezwHkDhKjN2uHXGswe3NR+N2F729GVU/
         9JKwtgE6dnvTmZzGCRmdo50gbrua8GsjXSPUqJLkild+axTfrB19CmNhaATgH9UwFfV7
         aCW67raW9s4OMRABtjW5FESIog+R+WKC0Nv8g0H5a3UF5TqAZzszwQ8Kbh5A9KLa2VuB
         EbFYqbTG8/aCDSanK5TJhKG2FFd6I5TkSZk3j230OWHowpcqw8QscLurHIHXOBknf/Jr
         7WJw==
X-Forwarded-Encrypted: i=1; AJvYcCXsMEpx4S7srt60HkKH04+k7JhJFphZbsoZHn5h7pC0x8WUybKCJ6pZBqhjOCCPENELlIjM@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7e0Cyu/9MwfHZlvDMMVq+NVxlsi+V2Ookq8Oa+2ufNiHxAt3Z
	0qAeffJlLMhrquO4hjd7BotxoN3Qdu2/PrLksQVqxVZy1ckZn0EaUKkM
X-Gm-Gg: ASbGnctwVT3YOCja2zj/l76xWuB9QPC/DwRqicF2Pkor8ifK2Z1ONvCaHPS1oNXCAH4
	e6wmqu6MkVJzCDRfRc9/EWS71EkgjHWdwuE5zDTMPmUHZNHGW6Jwy/u7l6ekp2VDJoVi/KkCRFi
	IX3wCoe4so+GzSppqMhwd9NmwgZnLZ5fxtRJR3RD5yd8ipmTQyFvoI2J9gHQqbmvD/8G3tiCkAh
	jXjYpQm4ldLiHyZW9JPkbY0yJAeZOBBtCU1yJtjNNerpVLnuseZxns811+GcEMdi/OOi9vqT7U1
	FN642eQNCyEdpfZb6gSmWBh5RfIlXhqVdTSJUt1ijF19DyMxfHq/ufLV/hjUo/Y+aul3ZLMVAU1
	amQlI5Qa3tj/rcRQXNM2QAFLpJyptskYZrxn0ew1BLtyRbUDk
X-Google-Smtp-Source: AGHT+IFBOC7sSbj5IFvRNx7Jv4sa7XYTGAtKLXSj+8uiMY+K39fFGvNnEV8ul9fibW4RMGLttUsXrQ==
X-Received: by 2002:a17:903:1209:b0:267:44e6:11d3 with SMTP id d9443c01a7336-27ed49d2bf5mr60472315ad.21.1758846563773;
        Thu, 25 Sep 2025 17:29:23 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671d8a2sm36696485ad.55.2025.09.25.17.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 17:29:23 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: djwong@kernel.org,
	hch@infradead.org,
	hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v5 00/14] fuse: use iomap for buffered reads + readahead
Date: Thu, 25 Sep 2025 17:25:55 -0700
Message-ID: <20250926002609.1302233-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds fuse iomap support for buffered reads and readahead.
This is needed so that granular uptodate tracking can be used in fuse when
large folios are enabled so that only the non-uptodate portions of the folio
need to be read in instead of having to read in the entire folio. It also is
needed in order to turn on large folios for servers that use the writeback
cache since otherwise there is a race condition that may lead to data
corruption if there is a partial write, then a read and the read happens
before the write has undergone writeback, since otherwise the folio will not
be marked uptodate from the partial write so the read will read in the entire
folio from disk, which will overwrite the partial write.

This is on top of two locally-patched iomap patches [1] [2] patched on top of
commit f1c864be6e88 ("Merge branch 'vfs-6.18.async' into vfs.all") in
Christian's vfs.all tree.

This series was run through fstests on fuse passthrough_hp with an
out-of kernel patch enabling fuse large folios.

This patchset does not enable large folios on fuse yet. That will be part
of a different patchset.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20250919214250.4144807-1-joannelkoong@gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/20250922180042.1775241-1-joannelkoong@gmail.com/

Changelog
---------
v4: 
https://lore.kernel.org/linux-fsdevel/20250923002353.2961514-1-joannelkoong@gmail.com/
v4 -> v5:
* Add commit for tracking pending read bytes more optimally (patch 7), which
  was suggested by Darrick and improves both the performance and the interface
* Merged "track read/readahead folio ownership internally" patch into patch 7
* Split iomap iter pos change into its own commit (Darrick) (patch 8)

v3:
https://lore.kernel.org/linux-fsdevel/20250916234425.1274735-1-joannelkoong@gmail.com/
v3 -> v4:
* Rebase this on top of patches [1] and [2]
* Fix readahead logic back to checking offset == 0 (patch 4)
* Bias needs to be before/after iomap_iter() (patch 10)
* Rename cur_folio_owned to folio_owned for read_folio (patch 7) (Darrick)

v2:
https://lore.kernel.org/linux-fsdevel/20250908185122.3199171-1-joannelkoong@gmail.com/
v2 -> v3:
* Incorporate Christoph's feedback
- Change naming to iomap_bio_* instead of iomap_xxx_bio
- Take his patch for moving bio logic into its own file (patch 11)
- Make ->read_folio_range interface not need pos arg (patch 9)
- Make ->submit_read return void (patch 9)
- Merge cur_folio_in_bio rename w/ tracking folio_owned internally (patch 7)
- Drop patch propagating error and replace with void return (patch 12)
- Make bias code better to read (patch 10)
* Add WARN_ON_ONCE check in iteration refactoring (patch 4)
* Rename ->read_submit to ->submit_read (patch 9)

v1:
https://lore.kernel.org/linux-fsdevel/20250829235627.4053234-1-joannelkoong@gmail.com/
v1 -> v2:
* Don't pass in caller-provided arg through iter->private, pass it through
  ctx->private instead (Darrick & Christoph)
* Separate 'bias' for ifs->read_bytes_pending into separate patch (Christoph)
* Rework read/readahead interface to take in struct iomap_read_folio_ctx
  (Christoph)
* Add patch for removing fuse fc->blkbits workaround, now that Miklos's tree
  has been merged into Christian's

Joanne Koong (14):
  iomap: move bio read logic into helper function
  iomap: move read/readahead bio submission logic into helper function
  iomap: store read/readahead bio generically
  iomap: iterate over folio mapping in iomap_readpage_iter()
  iomap: rename iomap_readpage_iter() to iomap_read_folio_iter()
  iomap: rename iomap_readpage_ctx struct to iomap_read_folio_ctx
  iomap: track pending read bytes more optimally
  iomap: set accurate iter->pos when reading folio ranges
  iomap: add caller-provided callbacks for read and readahead
  iomap: move buffered io bio logic into new file
  iomap: make iomap_read_folio() a void return
  fuse: use iomap for read_folio
  fuse: use iomap for readahead
  fuse: remove fc->blkbits workaround for partial writes

 .../filesystems/iomap/operations.rst          |  44 +++
 block/fops.c                                  |   5 +-
 fs/erofs/data.c                               |   5 +-
 fs/fuse/dir.c                                 |   2 +-
 fs/fuse/file.c                                | 288 +++++++++++-------
 fs/fuse/fuse_i.h                              |   8 -
 fs/fuse/inode.c                               |  13 +-
 fs/gfs2/aops.c                                |   6 +-
 fs/iomap/Makefile                             |   3 +-
 fs/iomap/bio.c                                |  88 ++++++
 fs/iomap/buffered-io.c                        | 246 +++++++--------
 fs/iomap/internal.h                           |  12 +
 fs/xfs/xfs_aops.c                             |   5 +-
 fs/zonefs/file.c                              |   5 +-
 include/linux/iomap.h                         |  63 +++-
 15 files changed, 505 insertions(+), 288 deletions(-)
 create mode 100644 fs/iomap/bio.c

-- 
2.47.3


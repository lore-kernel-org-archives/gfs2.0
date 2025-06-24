Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB15D256D
	for <gfs2@lists.linux.dev>; Tue, 24 Jun 2025 02:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731779; cv=none; b=pEu+GoRcmvJZvhgct2aw2dZf9YvqlO3HXl/NBxm/dkDCn78yky/gJI8aqW2qLodwgURnAyj7q2I/0nfypC90jvYfAzW0raSG5ZAQzChfHB944Z6zgwr7QD2frLwXZC7guTJv2Eia4RfNyw+zFjzSXNFR4G06ETl7oM98/yZfkX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731779; c=relaxed/simple;
	bh=Zkxit9aDe3QDjV0avyWQyXjfEcdh3Izbfk6AaNlXSzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G+i4svQaLXGBS5w0sp6AVcgHaruykNvxkfx4VVMURa8WiVHIajSguZl4V4ff6F7rLbC5e0/oNtatiyWNkUsLMXuCj8kEitOb4NW4/wLHeMA1gGj/DUANFB+a8v48Yj5F8LGNN4KmLnH2bt4gBJCU6+GmGL6coaRYCrTVlR16M90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mhp7NiuH; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mhp7NiuH"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23649faf69fso48684675ad.0
        for <gfs2@lists.linux.dev>; Mon, 23 Jun 2025 19:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750731777; x=1751336577; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8jUzS6DowcSpgl/rd8s76ozHCEh2xL61ewFyP0TWqmU=;
        b=Mhp7NiuHyKMBFJr6SvcD9TJOjrSU4q1RP3Mf4R5ocgrr3HZVyK7rwBwYNY7cBsdcyu
         q0b1+fKnjHiEUJ/vCyo0umW9JTHnrBZrn4cF1yFMjMl77P93XxUlWnIOnVk/tnD0EMQD
         kOtaSl5UQNx2kohBQoaIj33zRAr2kngLfmA3+pelDdUT4o0UiCQcOyG0b0C6pvWkvUEP
         DG6Tw9wLahj8/NHMi1hq2mZfEB+674JuVe6Vlrbx7V3rC+A4R1aQcURC7tNIRJ80RSeN
         R/cuAMBrqg1bu7TGQrLxPzjEYwv6A8b7dllLm2gtpYQHVWoQohsKYsGTrN3R1eXQ+8cl
         T4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750731777; x=1751336577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8jUzS6DowcSpgl/rd8s76ozHCEh2xL61ewFyP0TWqmU=;
        b=P/PDcmxDWyqPk/slFceF3+5mcjYi2oGGYvf+UXU9HAzdrv1qd5ELNppZypbtKiiXQi
         s2lZw38rlxxBQO5ijD5NJWTJGX5hgGk8hpxlqP40YywM/80pUZmf5RiE9qMXiH0bsRWj
         qqJJfHMHOkwYrxQZAtB8vyy/getBBWYpRcXgAuvQX/JwNE65xre4lSSqkEUJmrRwXGsJ
         dLnvMHfbDRHbFE3vaYHW5axlsVgVr5QOiTXCbhLrU14s9rOiV8iVPeAz8wmijXEO93Q0
         1/LBG9FxBdtxIEanPKMD7QuX8HlWuo6fUidbT/NB9iM45n8TFLfhUE3GGmyqNbiSro4U
         IF6w==
X-Forwarded-Encrypted: i=1; AJvYcCVwII7ZICcUPey9bLR8sZt8Y40CEaZJFuesMDv+ewdzfciCpUQoghzSynGpi6aRq4gGDTkz@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/xzuM9txVKvPrZp9uGKjBXUbQWHeAHz1RauUzAgoRBbnERMYk
	pewLci1R2yGKfNijsFf8UPCu1e4tfuzX1tdAs4aq2cTdYqy69R/inlX5
X-Gm-Gg: ASbGncvZHMgJ4K/gYGsUg0h74DeXXPBBLlO8NV+kHd6s0DXx171D246KdEY3JEw5pgP
	/DKiea8XjJxAEi5N7FKBHjqfiJhb/t8KZ1yhVH0mtQUzLF/28VNnhB12/pcRiFdgc716CVNgPoW
	6EjDSiCi2U3GPCpeq1YAJRTgIgwJ7hCrJbnWfUMwPITRJ5xS748DNlxOFcd+Mdwx4qj28JGabqZ
	01EOvFkbfn/2PZOJocRezG8JV1i7kBPocy0rgWUf2/VLJCjiZHG+zsFEq/QHDakqBUqUIyfFx8N
	WhnDT9EYoON144nQObLWf1nCv7RV3vjmD2oBkwx/gG1yMJBN5Kt0Gb4M
X-Google-Smtp-Source: AGHT+IHvoU587O1IfrDZ3oGsbMtevcv2Y/aQl7ISv9kHOlRxcRFEcp7DGfGYSrvCNryQwn+oKSH7Sg==
X-Received: by 2002:a17:902:ebc1:b0:234:8c64:7885 with SMTP id d9443c01a7336-237d9baeb72mr230304865ad.53.1750731777286;
        Mon, 23 Jun 2025 19:22:57 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8695195sm97070855ad.187.2025.06.23.19.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:22:57 -0700 (PDT)
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
Subject: [PATCH v3 00/16] fuse: use iomap for buffered writes + writeback
Date: Mon, 23 Jun 2025 19:21:19 -0700
Message-ID: <20250624022135.832899-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds fuse iomap support for buffered writes and dirty folio
writeback. This is needed so that granular uptodate and dirty tracking can
be used in fuse when large folios are enabled. This has two big advantages.
For writes, instead of the entire folio needing to be read into the page
cache, only the relevant portions need to be. For writeback, only the
dirty portions need to be written back instead of the entire folio.

This patchset is composed of two parts:
a) Christoph's iomap changes (patches 1 to 11) which are taken verbatim
   from [1]
b) fuse changes to use iomap (patches 12 to 16)

Please note the following:
* this patchset version temporarily drops the CONFIG_BLOCK iomap refactoring
  patches that will be needed to merge in the series. As of now, this breaks
  compilation for environments where CONFIG_BLOCK is not set, but the
  CONFIG_BLOCK iomap changes will be re-added back in once the core changes
  in this patchset are ready to go.
* this patchset does not enable large folios yet. That will be sent out in a
  separate future patchset.

This series is on top of commit 86731a2a6 ("Linux 6.16-rc3") in the linux
tree.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20250617105514.3393938-1-hch@lst.de/


Changeset
-------
v2 -> v3:
* Fix up fuse patches to use iomap APIs from Christoph's patches
* Drop CONFIG_BLOCK patches
* Add patch to use iomap for invalidation and partial uptodateness check
* Add patch for refactoring fuse writeback to use iomap_writepage_ctx inode
v2: https://lore.kernel.org/linux-fsdevel/20250613214642.2903225-1-joannelkoong@gmail.com/

v1 -> v2:
* Drop IOMAP_IN_MEM type and just use IOMAP_MAPPED for fuse
* Separate out new helper functions added to iomap into separate commits
* Update iomap documentation
* Clean up iomap_writeback_dirty_folio() locking logic w/ christoph's
  recommendation 
* Refactor ->map_blocks() to generic ->writeback_folio()
* Refactor ->submit_ioend() to generic ->writeback_complete()
* Add patch for changing 'count' to 'async_writeback'
* Rebase commits onto linux branch instead of fuse branch
v1: https://lore.kernel.org/linux-fsdevel/20250606233803.1421259-1-joannelkoong@gmail.com/


Christoph Hellwig (7):
  iomap: pass more arguments using struct iomap_writepage_ctx
  iomap: refactor the writeback interface
  iomap: hide ioends from the generic writeback code
  iomap: move all ioend handling to ioend.c
  iomap: rename iomap_writepage_map to iomap_writeback_folio
  iomap: export iomap_writeback_folio
  iomap: replace iomap_folio_ops with iomap_write_ops

Joanne Koong (9):
  iomap: cleanup the pending writeback tracking in
    iomap_writepage_map_blocks
  iomap: add public helpers for uptodate state manipulation
  iomap: move folio_unlock out of iomap_writeback_folio
  iomap: add read_folio_range() handler for buffered writes
  fuse: use iomap for buffered writes
  fuse: use iomap for writeback
  fuse: use iomap for folio laundering
  fuse: hook into iomap for invalidating and checking partial
    uptodateness
  fuse: refactor writeback to use iomap_writepage_ctx inode

 Documentation/filesystems/iomap/design.rst    |   3 -
 .../filesystems/iomap/operations.rst          |  51 +-
 block/fops.c                                  |  37 +-
 fs/fuse/Kconfig                               |   1 +
 fs/fuse/file.c                                | 327 ++++++-------
 fs/gfs2/aops.c                                |   8 +-
 fs/gfs2/bmap.c                                |  48 +-
 fs/gfs2/bmap.h                                |   1 +
 fs/gfs2/file.c                                |   3 +-
 fs/iomap/buffered-io.c                        | 438 +++++-------------
 fs/iomap/internal.h                           |   1 -
 fs/iomap/ioend.c                              | 220 ++++++++-
 fs/iomap/trace.h                              |   2 +-
 fs/xfs/xfs_aops.c                             | 238 ++++++----
 fs/xfs/xfs_file.c                             |   6 +-
 fs/xfs/xfs_iomap.c                            |  12 +-
 fs/xfs/xfs_iomap.h                            |   1 +
 fs/xfs/xfs_reflink.c                          |   3 +-
 fs/zonefs/file.c                              |  40 +-
 include/linux/iomap.h                         |  81 ++--
 20 files changed, 775 insertions(+), 746 deletions(-)

-- 
2.47.1


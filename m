Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB60E1799F
	for <gfs2@lists.linux.dev>; Mon,  8 Sep 2025 18:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357537; cv=none; b=NOHLaHlB4OMzwyvgCfmKy0NT6Lfjh3RvD0J5ZYppINUiOa2gzkMYo0uqDdnO40UtGMqxeNYz7dgujd063NkwBamyFEDH4d80RtaXYVyKcf/ebWG01mvIbkCjR6Io49XcBH8JtZWEezVwbVfGWH+QFMOfBMyRjYbKeyLITdUku+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357537; c=relaxed/simple;
	bh=gCN5SxT5vP1NX+CbbCHkHf478+/hzyRd7OEKpfS6fDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hyrmoYhVfJrxvbqYDyzwk3sYV82kWL8vGxJUiAbA3nsjhG9/CXF6kj7Ad9Ufc5skxH1irZY7Mem96nFGH1Jiq4+N39pWG9C8F/ukHWH25oaNK6qBDLpPAPO0TdC1qpxBWmaMcd9NuQyM9GS+GErkOyonn/uRpE3ScnR+RZTF7JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/Ek1Z2F; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/Ek1Z2F"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-772301f8a4cso6591927b3a.3
        for <gfs2@lists.linux.dev>; Mon, 08 Sep 2025 11:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357535; x=1757962335; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lm3Imf0pgBjvWBHNU/XQYZEiSLH4qTMAkyxrgY5m5W0=;
        b=W/Ek1Z2F0AzSI0olCAZL16/ld1KZorc+DQcAd3JmScrwYWH7xs0JpDhQuk0KpuVFxr
         qMqSwInOMw5B9EzqXq8TmcYxk4u2KuaXBIYZXvMaY9Nou0xB3/Gv1wNekik+1aUAQJe3
         CyTd9Ni2BB8GwNchARHl0gOFPTLQ/MpeRq1gUKj/h2HVkkETMvcw4W40Bo/8qiGNm6Cj
         /MjDlKgQbdjJQL5mTZhAO8oe/0mabl5tOibzSJ+WXz53/i7MvAA6ol6d86Lq46RtarGE
         mftFS2cW1Y1n4RI4hSpk+yvDOAhNVFQJZawzUeQEX5pAy4Gt6DCIU8nARexwaV79PXTa
         0eLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357535; x=1757962335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lm3Imf0pgBjvWBHNU/XQYZEiSLH4qTMAkyxrgY5m5W0=;
        b=xG6ckTaCMSthXLvReNfuDy6c5oJ6yFUsgVSTkSHSA1fgmxHGMhvU+yTvNNc0P9ruYw
         CwDy7+Dv+IA04t3v8Y9B9OBIntOnU3uqzJoHwVndCdumU1f5/ieTnyyU4gtqlVKd0oke
         tOdEoaA4hpQsmuSI1Z8dfvQqiRDiRP+wRt7VyDm42qr4XdK0QjENjVJbH/gpvqZ7iOBv
         hdxhqLegMeziGjXoWkTxdD5s5zoXpP9lCz3aLZ/8LJ8elVSQgR2YGjVZ5fbVXo+lBkLE
         I4MG+vJOnUj8FXJy25K9vFqXO9RFNwt3psLQ8JDxLEHMh3fvWX+E/UapZ6ASJshOn2TH
         Teug==
X-Forwarded-Encrypted: i=1; AJvYcCUasEF10CSvjwPqM0CmXUFHnpWL9PK0graRMh1iup+pvhcO/HPHIv/J6UqViaC97bJ5j8ht@lists.linux.dev
X-Gm-Message-State: AOJu0YyxkEYv3Hd/ylpl1R72DhM+AQO8kabhcDee7xwwRUuZPMrBv2wL
	iELWjq/QE2iLwqS4ZII49xJUPH5iRI7gq5WcyYis5tfytsgIOaJfHFjXA4ybug==
X-Gm-Gg: ASbGncuXQdMc4ZMQddKbY1ftDWG/ln8OwJIfbUH+yytkwxDn/SnHqVofu/iuoscUYuT
	jKBDM7f7ZYyzoXS0lyzjzWHOad3IgWDFOepOnY8eABpmK07eKINAmDK1DeJcqtuYuFEOPSuSd9e
	jKB76MpNLLiUadXwkxrM71qopjBCyCfpGFFB1dTL5Dl5DFKZRhAyydFmq2us/jqZ1txMnWHNU6L
	qJ4rICQs5GSReml78bFy20C5Lgrf/XZxjixWWejlxZ7z4lS3uf/jcW9guKOx2d/uVSgZg67S0Z/
	DlVVZrUIfaRs1neacU1Vqn6FuUJcCe5aZ5KFPorq232+VEBk60QFdvhuUOelw/HiCso6PHl33y8
	EX0DtSGEC0Up9rs/PhiUXAsB+MCem
X-Google-Smtp-Source: AGHT+IHt7wUFngbPJ1fb9lzSML52MmUa09gdmnjs+gYzwN3cD9RrhRVdwNduOqUtB5yJFavDHOvpJw==
X-Received: by 2002:a05:6a00:4f8b:b0:772:3b9d:70f0 with SMTP id d2e1a72fcca58-7742dd64e08mr11340077b3a.2.1757357535099;
        Mon, 08 Sep 2025 11:52:15 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4a::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2d97acsm30230068b3a.41.2025.09.08.11.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:52:14 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: hch@infradead.org,
	djwong@kernel.org,
	hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 00/16] fuse: use iomap for buffered reads + readahead 
Date: Mon,  8 Sep 2025 11:51:06 -0700
Message-ID: <20250908185122.3199171-1-joannelkoong@gmail.com>
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

This is on top of commit d02ae3528998 ("Merge branch 'kernel-6.18.clone3'
into vfs.all") in Christian's vfs tree.

This series was run through fstests on fuse passthrough_hp with an
out-of kernel patch enabling fuse large folios.

This patchset does not enable large folios on fuse yet. That will be part
of a different patchset.

Thanks,
Joanne

Changelog
---------
v1: https://lore.kernel.org/linux-fsdevel/20250829235627.4053234-1-joannelkoong@gmail.com/
v1 -> v2:
* Don't pass in caller-provided arg through iter->private, pass it through
  ctx->private instead (Darrick & Christoph)
* Separate 'bias' for ifs->read_bytes_pending into separate patch (Christoph)
* Rework read/readahead interface to take in struct iomap_read_folio_ctx
  (Christoph)
* Add patch for removing fuse fc->blkbits workaround, now that Miklos's tree
  has been merged into Christian's

Joanne Koong (16):
  iomap: move async bio read logic into helper function
  iomap: move read/readahead bio submission logic into helper function
  iomap: rename cur_folio_in_bio to folio_owned
  iomap: store read/readahead bio generically
  iomap: propagate iomap_read_folio() error to caller
  iomap: iterate over entire folio in iomap_readpage_iter()
  iomap: rename iomap_readpage_iter() to iomap_read_folio_iter()
  iomap: rename iomap_readpage_ctx struct to iomap_read_folio_ctx
  iomap: add public start/finish folio read helpers
  iomap: make iomap_read_folio_ctx->folio_owned internal
  iomap: add caller-provided callbacks for read and readahead
  iomap: add bias for async read requests
  iomap: move read/readahead logic out of CONFIG_BLOCK guard
  fuse: use iomap for read_folio
  fuse: use iomap for readahead
  fuse: remove fc->blkbits workaround for partial writes

 .../filesystems/iomap/operations.rst          |  42 +++
 block/fops.c                                  |  14 +-
 fs/erofs/data.c                               |  14 +-
 fs/fuse/dir.c                                 |   2 +-
 fs/fuse/file.c                                | 291 ++++++++++-------
 fs/fuse/fuse_i.h                              |   8 -
 fs/fuse/inode.c                               |  13 +-
 fs/gfs2/aops.c                                |  21 +-
 fs/iomap/buffered-io.c                        | 307 ++++++++++--------
 fs/xfs/xfs_aops.c                             |  14 +-
 fs/zonefs/file.c                              |  14 +-
 include/linux/iomap.h                         |  45 ++-
 12 files changed, 509 insertions(+), 276 deletions(-)

-- 
2.47.3


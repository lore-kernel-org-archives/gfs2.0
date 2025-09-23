Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA1E156F20
	for <gfs2@lists.linux.dev>; Tue, 23 Sep 2025 00:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758587635; cv=none; b=qfXDyx/bRqA1s+MnGqWLC5P8pkRMYKrcRQ7iC+fVGob1l5o8daa5ukZmXKHqJTZciD8CDfzVgVHDLLjAimFv5I5hqlPAlo2BeA9YHwKnuEcTzFj8CM+U3TKDVbWzgTzHBf6kreC+f5tqEe2xH4EV/VHpYC57D7Oy/kBL3pmnD+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758587635; c=relaxed/simple;
	bh=YgKyI+7nvFJd7hF9+aOKln99TqNiUDSyfSYZ4a5+f8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KIeBOnfFnCtz5wiplNx1jUVARB4PdCOfCBOPkgZRxv48BKxNX7G0ai6rFmJxx70peDKNQXG+2O/3/TAOG6o6efBhQo2Np+eA+B3gCh7cHcx78eXzAbaGsWBctozQXlFXG6205kzzJb3XFYuDHCVqohTI6K63iwleqhmU4+TGDMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebfAZu+l; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebfAZu+l"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77f2a62e44dso2730529b3a.1
        for <gfs2@lists.linux.dev>; Mon, 22 Sep 2025 17:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758587632; x=1759192432; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Va/XHzY7dGCYy7r7QsvJz2VUIfq4Rs/aAgdBGRW34/8=;
        b=ebfAZu+lSmPTF+V9YlZ+zTqVsP4skIqhvf9LekKQFMKc9XW/msGQiYJNg/bGQbEhAG
         r8UD9ViLKriI/7ykTAQN4tLOlO4IQpb7s8IRdEGjx/m+1ciCkdbolmFhxpv3wZGaCdCy
         XBRW6fh6cVSTx1gq1+mR0QQ9d5wmgxBTF2hnfUrYsHc6F0FwTjixlIqVuQj1OxiEYole
         2D2SJB6KGr8v04Z++3zb+P3zVHMnpz3IQEqTkYk+2GHkFCdBIaZ3tIZ96mJIeQlfsKe4
         r94t3JI9PCUlqvesRE9UhO5+c2Wd1pHqF2QD4sN6+urbPBwYSeI0a5//FUOv3sGGphwy
         6WGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758587632; x=1759192432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Va/XHzY7dGCYy7r7QsvJz2VUIfq4Rs/aAgdBGRW34/8=;
        b=U8x28na0varqMrnDO4hBl3I6pU6phunr1TqIyXoBi5JidziuNNwhAyxdsaNYNqFTHj
         yAgVn8jEmlVWcgpNI7zJO9IJ57HZyJKSUPjv2ExsqTkb7bOkjiUkxza4jaCANmcSrqsF
         RCSP3rRX++llvchTG8u1SSqi0fKJDE6oDf5TJZy2IZ+OQ4gOTpJnQqByCeOfWU1hMkC6
         i1WSGdSyYR9zoXjjTM6xS3qI7jMPmDyh+m7MyUlpnk3UsOaM3t1oc6dMehOagw2v68Pn
         jRCpaM4+3770t1HNcWZcp0ny/e35bgk8PmpHR/hu4OEYOWIKuZbR38PeuY1wHlAMnItR
         FUhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVRtDAtyoMsIUzp0jJSrSWnudUUb6Q8y6oc8Rm9quvv/91u+6St/9W34urwFxK0xhWu31f@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2WZj7DPbXiDk0nbeMsKGzLNwtg734JWajJDw9ax3IXxorivMg
	NIQbNyulbypQmjRVeARHsB0vYhlP5j8JxP+FmbvOOJE6GbP4IGPuNfzCYl1n8A==
X-Gm-Gg: ASbGncuGd2uJMGK1qOVXwzgiYNt4ODhxPeIU9dSUM/85rnU2VyerG/9rn6VQc2RFqTI
	gg1dw/pb2sQIDjZ/kNhxMDroMBuJXtzmvKRmOx18FE73/u1PzewfriBhj1/5zxTeqxzUmbMXBVY
	Fmw5DE70wSrh9mSmm66w3H9lGouQumz2XlGQ1EydcBniHkRdFogIZd/klsRj/In6djCMjG/Z/Zk
	WbPwJ0z3FEMUr52/VpyIEuEpjXRg2/eQpYeATdK1oWXiXXyDMO5zGxxcHdfZyImiYGQTeXdihNJ
	LMYK7x4gFJrf5PqjFTKu+wymXlnTSlL/AoTuIAPM4TzQr4LPb07VARXkyEsjA7hcH4Mo9dffk3X
	hswNHoodRB/O8YMCpu35FryHoZaMaL95FgBAuz4nUBniMdwxM
X-Google-Smtp-Source: AGHT+IHlZzmKAgOiJJH7iK2X2/0Mv1ZhYzEaMZg9FO5iReuXqZG+EqKn8QCxkD922bYIKmzkhhTsog==
X-Received: by 2002:a05:6a21:3086:b0:2cc:3e8:87f9 with SMTP id adf61e73a8af0-2d02084f104mr1034082637.59.1758587632427;
        Mon, 22 Sep 2025 17:33:52 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f188dd4a8sm8187594b3a.39.2025.09.22.17.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 17:33:52 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: djwong@kernel.org,
	hch@infradead.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	hsiangkao@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v4 00/15] fuse: use iomap for buffered reads + readahead
Date: Mon, 22 Sep 2025 17:23:38 -0700
Message-ID: <20250923002353.2961514-1-joannelkoong@gmail.com>
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
commit 8a606bb102db ("Merge branch 'vfs-6.18.writeback' into vfs.all") in
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
v3: https://lore.kernel.org/linux-fsdevel/20250916234425.1274735-1-joannelkoong@gmail.com/
v3 -> v4:
* Rebase this on top of patches [1] and [2]
* Fix readahead logic back to checking offset == 0 (patch 4)
* Bias needs to be before/after iomap_iter() (patch 10)
* Rename cur_folio_owned to folio_owned for read_folio (patch 7) (Darrick)

v2: https://lore.kernel.org/linux-fsdevel/20250908185122.3199171-1-joannelkoong@gmail.com/
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

v1: https://lore.kernel.org/linux-fsdevel/20250829235627.4053234-1-joannelkoong@gmail.com/
v1 -> v2:
* Don't pass in caller-provided arg through iter->private, pass it through
  ctx->private instead (Darrick & Christoph)
* Separate 'bias' for ifs->read_bytes_pending into separate patch (Christoph)
* Rework read/readahead interface to take in struct iomap_read_folio_ctx
  (Christoph)
* Add patch for removing fuse fc->blkbits workaround, now that Miklos's tree
  has been merged into Christian's

Joanne Koong (15):
  iomap: move bio read logic into helper function
  iomap: move read/readahead bio submission logic into helper function
  iomap: store read/readahead bio generically
  iomap: iterate over folio mapping in iomap_readpage_iter()
  iomap: rename iomap_readpage_iter() to iomap_read_folio_iter()
  iomap: rename iomap_readpage_ctx struct to iomap_read_folio_ctx
  iomap: track read/readahead folio ownership internally
  iomap: add public start/finish folio read helpers
  iomap: add caller-provided callbacks for read and readahead
  iomap: add bias for async read requests
  iomap: move buffered io bio logic into new file
  iomap: make iomap_read_folio() a void return
  fuse: use iomap for read_folio
  fuse: use iomap for readahead
  fuse: remove fc->blkbits workaround for partial writes

 .../filesystems/iomap/operations.rst          |  45 +++
 block/fops.c                                  |   5 +-
 fs/erofs/data.c                               |   5 +-
 fs/fuse/dir.c                                 |   2 +-
 fs/fuse/file.c                                | 289 +++++++++++-------
 fs/fuse/fuse_i.h                              |   8 -
 fs/fuse/inode.c                               |  13 +-
 fs/gfs2/aops.c                                |   6 +-
 fs/iomap/Makefile                             |   3 +-
 fs/iomap/bio.c                                |  90 ++++++
 fs/iomap/buffered-io.c                        | 259 ++++++++--------
 fs/iomap/internal.h                           |  12 +
 fs/xfs/xfs_aops.c                             |   5 +-
 fs/zonefs/file.c                              |   5 +-
 include/linux/iomap.h                         |  65 +++-
 15 files changed, 524 insertions(+), 288 deletions(-)
 create mode 100644 fs/iomap/bio.c

-- 
2.47.3


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307FD15E80
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LChuvxwT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698857179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i/lcw/cB3MzIzN67ggY7YbhQDoINXblfP5dPYKa32rA=;
	b=LChuvxwTDt0CKtAQjCXg+C7sRIxH6iRfqjWrjNCsugmNYZkia+X2SNkqXGdVQNPlwV1d/e
	20Jy0pXb8eDR1PQxj5uSwvCmG3Khuh7E7wSBgs+plNLq8m92wcJp9b9ui8yc/Fc3aWt86s
	O3D8aEANEZ944ugtJkxdq5QqtwtQBR8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-BPWQWbqgMDaIfHJN_SbcjQ-1; Wed, 01 Nov 2023 12:46:17 -0400
X-MC-Unique: BPWQWbqgMDaIfHJN_SbcjQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 30F7985A58A
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:17 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A054740C6EBF;
	Wed,  1 Nov 2023 16:46:16 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 00/25] gfs2 patches on for-next
Date: Wed,  1 Nov 2023 17:45:50 +0100
Message-ID: <20231101164615.1138692-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Hello,

this is the set of patches I've queued up for the current merge window.
It's the usual mix of fixes, small improvements, and cleanups.  Please
let me know about any concerns or ideas you have about those patches.

I'm glad about the various contributors we've had this time.  Thank you
very much!

Andreas

Al Viro (1):
  gfs2: fix an oops in gfs2_permission

Amir Goldstein (1):
  gfs2: fs: derive f_fsid from s_uuid

Andreas Gruenbacher (21):
  gfs2: Simplify function gfs2_upgrade_iopen_glock
  gfs2: Remove freeze_go_demote_ok
  gfs2: Remove unused gfs2_extent_length argument
  gfs2: Get rid of the gfs2_glock_is_held_* helpers
  gfs2: Don't update inode timestamps for direct writes
  gfs2: setattr_chown: Add missing initialization
  gfs2: Stop using GFS2_BASIC_BLOCK and GFS2_BASIC_BLOCK_SHIFT
  gfs2: Two quota=account mode fixes
  gfs2: Clean up gfs2_alloc_parms initializers
  gfs2: Clean up quota.c:print_message
  gfs2: Add metapath_dibh helper
  gfs2: Initialize metapaths outside of __gfs2_iomap_get
  gfs2: Get rid of repeated call to __gfs2_iomap_get
  gfs2: Remove unnecessary gfs2_iomap_begin_write parameters
  gfs2: Get rid of gfs2_alloc_blocks generation parameter
  gfs2: Minor gfs2_write_jdata_batch PAGE_SIZE cleanup
  gfs2: Convert stuffed_readpage to folios
  gfs2: Convert gfs2_internal_read to folios
  gfs2: Rename gfs2_lookup_{ simple => meta }
  gfs2: No longer use 'extern' in function declarations
  gfs2: Silence "suspicious RCU usage in gfs2_permission" warning

Bob Peterson (1):
  gfs2: ignore negated quota changes

Juntong Deng (1):
  fs/gfs2: Fix slab-use-after-free in gfs2_qd_dealloc

 fs/gfs2/acl.h        |   8 +--
 fs/gfs2/aops.c       |  72 ++++++++++++-------------
 fs/gfs2/aops.h       |   6 +--
 fs/gfs2/bmap.c       | 125 ++++++++++++++++++++++++++-----------------
 fs/gfs2/bmap.h       |  38 ++++++-------
 fs/gfs2/dir.c        |   2 +-
 fs/gfs2/dir.h        |  38 ++++++-------
 fs/gfs2/file.c       |  18 ++++---
 fs/gfs2/glock.h      | 113 +++++++++++++++++---------------------
 fs/gfs2/glops.c      |  13 -----
 fs/gfs2/glops.h      |   4 +-
 fs/gfs2/incore.h     |   2 +-
 fs/gfs2/inode.c      |  33 +++++++-----
 fs/gfs2/inode.h      |  60 ++++++++++-----------
 fs/gfs2/log.h        |  46 ++++++++--------
 fs/gfs2/lops.h       |  22 ++++----
 fs/gfs2/meta_io.h    |  20 +++----
 fs/gfs2/ops_fstype.c |  24 ++++-----
 fs/gfs2/quota.c      |  31 +++++++----
 fs/gfs2/quota.h      |  35 ++++++------
 fs/gfs2/recovery.h   |  18 +++----
 fs/gfs2/rgrp.c       |  12 +++--
 fs/gfs2/rgrp.h       |  85 ++++++++++++++---------------
 fs/gfs2/super.c      |  29 ++++------
 fs/gfs2/super.h      |  50 ++++++++---------
 fs/gfs2/trans.h      |  24 ++++-----
 fs/gfs2/util.h       |   8 +--
 fs/gfs2/xattr.c      |   6 +--
 fs/gfs2/xattr.h      |  12 ++---
 29 files changed, 485 insertions(+), 469 deletions(-)

-- 
2.41.0


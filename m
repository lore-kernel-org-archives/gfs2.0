Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775A920DE3
	for <gfs2@lists.linux.dev>; Tue, 14 Apr 2026 12:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776169158; cv=none; b=LGHunqUF8GFNR8VJGUy2dp1bwL20DnwGN6BH5q9jWNdnG6bQcbVd3Id6Q9Ezc3r1SeRjTH9VgMCJLGHVnjX3FBns9U+jdF0sqrS13jVtbEoD9TbydW6reVP6g57s04bDaImWeTg8NojQcN3ysJYUjVvvcID8O+tC8tV/iPzbirc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776169158; c=relaxed/simple;
	bh=1KMJqZksukzqQEegYW9JvMi9mZEMSeZNE8SlW/+kpjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=ghOi8B5Hlj05GJMhUvdck1lEV/eUX5ShuoXb0gs8RnUJ2bhW6KSNSCkRDTGe1WytV6yWQnu4eidy+EX73UyGsVJuxdwYWHSsxw0i0o2tKr3qBdI8uA7+UYuU8694HC6igN3Jv58/Abi+3it6iMsvUiozPwcy1AMLPxvIogujjxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GbDczfqi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GbDczfqi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776169155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SfI95Bj0wxIcLrrxrZZcaZ9WcJgjv7rRguSOPCYOv5k=;
	b=GbDczfqi2KSmbGIZnRprqqDwZSNLH8LXe5taGXLuVs2VZiQe6SxOTclJyb7mYzn4149x8z
	ZywJe/vDJn7YQermy+fRZqyu7AkbGVwhcoFhToERL8lgl6Xoo0HaL73p5cJc9lFm1CNpfn
	ttgBDwwCYnjWYe/9MgqV1Wzbe9bWSlQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-HmgELi4HOT60XWm7DeRb0A-1; Tue,
 14 Apr 2026 08:19:12 -0400
X-MC-Unique: HmgELi4HOT60XWm7DeRb0A-1
X-Mimecast-MFC-AGG-ID: HmgELi4HOT60XWm7DeRb0A_1776169151
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70E80195609F;
	Tue, 14 Apr 2026 12:19:11 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.156])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C2EEC18002A6;
	Tue, 14 Apr 2026 12:19:09 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 changes for 7.1
Date: Tue, 14 Apr 2026 14:19:07 +0200
Message-ID: <20260414121908.887366-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: YKHA_UaR_oluMdErk-nWvVF-B9tIRAsbGjwm44FqcFE_1776169151
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Dear Linus,

please consider pulling the following gfs2 changes for 7.1.

Thanks,
Andreas

The following changes since commit 7141433fbed290f4dd42008d3102db2363275035:

  Merge tag 'gfs2-for-7.0' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2 (2026-02-09 16:29:57 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-7.1

for you to fetch changes up to 74b4dbb946060a3233604d91859a9abd3708141d:

  gfs2: prevent NULL pointer dereference during unmount (2026-04-07 22:20:00 +0200)

----------------------------------------------------------------
gfs2 changes

- Fix possible data loss during inode evict.

- Fix a race during bufdata allocation.

- More careful cleaning up during a withdraw.

- Prevent excessive log flushing under memory pressure.

- Various other minor fixes and cleanups.

----------------------------------------------------------------
Andreas Gruenbacher (18):
      gfs2: Call unlock_new_inode before d_instantiate
      gfs2: Remove unnecessary check in gfs2_evict_inode
      gfs2: Avoid unnecessary transactions in evict_linked_inode
      gfs2: minor evict_[un]linked_inode cleanup
      gfs2: Fix data loss during inode evict
      gfs2: less aggressive low-memory log flushing
      gfs2: Get rid of gfs2_log_[un]lock helpers
      gfs2: Move gfs2_remove_from_journal to log.c
      gfs2: Remove trans_drain code duplication
      gfs2: bufdata allocation race
      gfs2: drain ail under sd_log_flush_lock
      gfs2: fix address space truncation during withdraw
      gfs2: add some missing log locking
      gfs2: gfs2_log_flush withdraw fixes
      gfs2: inode directory consistency checks
      gfs2: wait for withdraw earlier during unmount
      gfs2: hide error messages after withdraw
      gfs2: prevent NULL pointer dereference during unmount

 fs/gfs2/aops.c    |  15 ++++---
 fs/gfs2/bmap.c    |   2 +-
 fs/gfs2/glops.c   |  13 ++++--
 fs/gfs2/inode.c   |   3 +-
 fs/gfs2/log.c     | 127 +++++++++++++++++++++++++++++++++++++++---------------
 fs/gfs2/log.h     |  26 +----------
 fs/gfs2/lops.c    |  16 +++----
 fs/gfs2/meta_io.c |  43 ++----------------
 fs/gfs2/meta_io.h |   1 -
 fs/gfs2/rgrp.c    |   2 +-
 fs/gfs2/super.c   | 111 ++++++++++++++++++++++++++++++++++++-----------
 fs/gfs2/trans.c   |  45 ++++++++++---------
 fs/gfs2/util.c    |   3 +-
 13 files changed, 237 insertions(+), 170 deletions(-)


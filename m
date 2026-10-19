Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA924FB9B3
	for <gfs2@lists.linux.dev>; Mon, 19 Oct 2026 13:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417311; cv=none; b=Tuni6aVmOwZn3afWT7BTOaE9jPkUo8BejKdTD9MhgVNMRvck5G7lAj+Uf51KqNj8/x7uhUluaMggAJHpnOC22RtvWayX8gV7wbT9yjEGDJfOwXbKSyTGz4DPzYc2zAybMoivHS76FJK4garj7qv+gSGpGVgTdK3dwc8I9c1bSYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417311; c=relaxed/simple;
	bh=AzLamgGVmmJPRgvKr7nXInNdlFCbe22YDx441GDcVKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=LNZQnCrIBZalTxBE4g+U0U3/l+DKrlJC9SV0ujk/QeAI27fllHnnGWnlmPK3FPkFSGDNFRrl7pcIVRhcrTRL1H+xbhY7AuQvUvyugn9AEf39u2uauoLt1DeRclNxuCZTRUIOUuYvKxD1Pl5qZFEoFILaoh4b/N3a9KzwI8TEdlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NiKJxCd4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NiKJxCd4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792417309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uebIKduZuZflGYrsljiBjDZz5D/SVnu3Yv+vPeBb8eE=;
	b=NiKJxCd4jFN5VwyPBiuGZuOqHkr6f27ATrZXMFwdTKQIVdeBqozxQsUc9gxWzXNkJSq9cq
	T9ZjPz3MFA4jZrYwlW4pc1vBmB2wGEN/8fZcWGoBp+b7qJIRYXSH5RlNxKBqXIFsR6tDCX
	a8C34BnzPVtZdQ9NhJfpKhUdz3WZ8Ws=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-Y6REqA9zNtaa-7hQwt8ISQ-1; Mon,
 19 Oct 2026 13:41:45 +0000
X-MC-Unique: Y6REqA9zNtaa-7hQwt8ISQ-1
X-Mimecast-MFC-AGG-ID: Y6REqA9zNtaa-7hQwt8ISQ_1792417305
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9DE9F1955E7D;
	Mon, 19 Oct 2026 13:41:44 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.44.32.82])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1EED518004D2;
	Mon, 19 Oct 2026 13:41:42 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 changes for 7.4
Date: Mon, 19 Oct 2026 15:41:37 +0200
Message-ID: <20261019134141.194437-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: -oKAzHHIUnPUu_Voikyypgg674qxQYfE7COC45O25Lw_1792417305
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Hello Linus,

please consider pulling the following gfs2 changes for 7.4.

Thanks,
Andreas

The following changes since commit 4bb187d6f379c5490e3034b153fe476127308519:

  Merge tag 'gfs2-for-7.3' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2 (2026-08-17 17:03:34 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-7.4

for you to fetch changes up to 2f9efb1efe4e026e44b7693e67f54344ae022deb:

  gfs2: remove unnecessary check in gfs2_freeze_lock_shared (2026-10-16 02:27:54 +0200)

----------------------------------------------------------------
gfs2 changes

- Two journaled data inode fixes (fix journaled truncate range end
  offset, fix the escaped block copy in gfs2_before_commit).

- When reading a new resource group from disk, validate its boundaries.

- To eliminate lock contention, get rid of the per-filesystem
  sd_async_glock_wait queue and wait for the individual glock locking
  events instead.

- Shut up sparse RCU warnings by marking ip->i_gl as __rcu.  Accessing
  it through gfs2_inode_glock() -> rcu_dereference_protected() where we
  know that the pointer cannot change.

- Some more minor fixes and cleanups.

----------------------------------------------------------------
Andreas Gruenbacher (12):
      gfs2: Avoid ip->i_gl dereferences in gfs2_inode_lookup and gfs2_create_inode
      gfs2: Get to super block from inode in tracepoints
      gfs2: Add inode variables
      gfs2: Introduce gfs2_inode_glock
      gfs2: annotate i_gl with __rcu
      gfs2: Silence sparse signedness warning
      gfs2: Improve resource group validation and error handling
      gfs2: No quotas for meta inodes
      gfs2: Get rid of sd_async_glock_wait
      gfs2: missing whitespace in error message
      gfs2: gfs2_create_inode excl cleanup
      gfs2: remove unnecessary check in gfs2_freeze_lock_shared

Hemanth Selam (1):
      gfs2: fix typos in comments

Hongling Zeng (1):
      gfs2: move brelse() after buffer head accesses

Jan Kara (1):
      gfs2: Fix journaled truncate range end offset

Jiaming Zhang (1):
      gfs2: reject invalid inode sizes

Karl Mehltretter (1):
      gfs2: Fix the return value in gfs2_get_link() kernel-doc

Tal Zussman (1):
      gfs2: fix the escaped block copy in gfs2_before_commit()

ThangNN99 (1):
      gfs2: fix NULL deref in gfs2_quota_lock() for meta inodes

 fs/gfs2/acl.c        |  11 +++--
 fs/gfs2/aops.c       |  17 +++----
 fs/gfs2/bmap.c       |  93 ++++++++++++++++++++----------------
 fs/gfs2/dentry.c     |   6 +--
 fs/gfs2/dir.c        |  61 +++++++++++++++---------
 fs/gfs2/export.c     |   7 +--
 fs/gfs2/file.c       |  72 ++++++++++++++++------------
 fs/gfs2/glock.c      |  60 +++++++++++++++--------
 fs/gfs2/glops.c      |  13 +++--
 fs/gfs2/incore.h     |   8 ++--
 fs/gfs2/inode.c      | 132 ++++++++++++++++++++++++++++-----------------------
 fs/gfs2/lock_dlm.c   |   4 +-
 fs/gfs2/log.c        |   3 +-
 fs/gfs2/lops.c       |  22 ++++-----
 fs/gfs2/meta_io.c    |   7 +--
 fs/gfs2/ops_fstype.c |  26 +++++-----
 fs/gfs2/quota.c      |  57 ++++++++++++----------
 fs/gfs2/recovery.c   |  19 ++++----
 fs/gfs2/rgrp.c       | 127 ++++++++++++++++++++++++++-----------------------
 fs/gfs2/super.c      |  98 +++++++++++++++++++++++---------------
 fs/gfs2/trace_gfs2.h |   6 +--
 fs/gfs2/util.c       |  10 ++--
 fs/gfs2/xattr.c      |  69 ++++++++++++++++-----------
 23 files changed, 531 insertions(+), 397 deletions(-)


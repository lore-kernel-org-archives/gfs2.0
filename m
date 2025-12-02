Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2CC24886E
	for <gfs2@lists.linux.dev>; Tue,  2 Dec 2025 21:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764711131; cv=none; b=WypvsW+c2cv97NRcthjgYgEiH8VwgCt6TkqVPUB7I5FoflGJrWAEbdf6MADuhex0kQbcZ9SnZhxWoRVzhC9eC2aNeM7Oq4o/YDkIvGJtao06JCU65eHUnLmPZTq5oDyDaIK2lfovjmbphAnzaWBhWCnnyISPKXUi62w6jmsU89E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764711131; c=relaxed/simple;
	bh=Q3K2Rp/jOR4e1HNgo/x4LxWa83FSyecw+sJzFsNPOPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SB/t+BH8wP7PDEJoFg3+wtRSLm2y8HuLBDCoPMUf4xiCnRz9Dos641ocNEw5fkTonXjAetSqFiIjMSFIYiQJ9JZkQzxY45HcjP9p3c0axvZ6zRfjDL8Zgb5t0j1b2wFX6yPNJ6YdpTtT9jxZhN2ujuLQguePxfOrlU71ZyAMLdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O9+qOfHy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O9+qOfHy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764711128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mnLZqwLPewwV9/EqlwhA+SRxCSS/Hj75yWIZLamCeWs=;
	b=O9+qOfHyeBSzp0NXwSzQyJoYD3yx85UoHvHor0uoIPWt+347oAqvUH2iFx5cicGhninBzf
	Wfm8vAQg6fVqAJTEXAYxlE67ympau1ONEQ7s5HmFEgCe3PCqZWnMsPXt4pXcjlhbQ2m3jN
	gvbHEffgqowd/7Eq0iHvMpkl8p3fXjI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-bs01ewixO0GMUP4-qCpGlw-1; Tue,
 02 Dec 2025 16:32:05 -0500
X-MC-Unique: bs01ewixO0GMUP4-qCpGlw-1
X-Mimecast-MFC-AGG-ID: bs01ewixO0GMUP4-qCpGlw_1764711124
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 425FD1956050;
	Tue,  2 Dec 2025 21:32:04 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 73D7819560A7;
	Tue,  2 Dec 2025 21:32:02 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 changes for 6.19
Date: Tue,  2 Dec 2025 21:31:59 +0000
Message-ID: <20251202213200.4170687-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Dear Linus,

please consider pulling the following gfs2 changes for 6.19.

Note that commit 8a157e0a0aa51 ("gfs2: Fix use of bio_chain") has only been
added three days ago.  It's a fairly obvious bug fix, and I'd rather like to
have it in sooner than later if you don't mind.

Thanks,
Andreas

The following changes since commit dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa:

  Linux 6.18-rc3 (2025-10-26 15:59:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-6.19

for you to fetch changes up to 8a157e0a0aa5143b5d94201508c0ca1bb8cfb941:

  gfs2: Fix use of bio_chain (2025-12-02 16:44:54 +0000)

----------------------------------------------------------------
gfs2 changes

- Major withdraw / error handling overhaul based on dlm's new
  DLM_RELEASE_RECOVER feature: this allows gfs to treat withdraws like
  node failures.  Make withdraws asynchronous.

- Fix a bug in commit e4a8b5481c59a that caused 'df' to remain out of
  sync.  ('df' is still allowed to go slightly out of sync for short
  periods of time.)

- Prevent recusive memory reclaim in gfs2_unstuff_dinode().

- Clean up SDF_JOURNAL_LIVE flag handling.

- Fix remote evict for read-only filesystems.

- Fix a misuse of bio_chain().

- Various other minor cleanups.

----------------------------------------------------------------
Alexey Velichayshiy (1):
      gfs2: fix freeze error handling

Andreas Gruenbacher (30):
      gfs2: Prevent recursive memory reclaim
      gfs2: fix remote evict for read-only filesystems
      gfs2: Minor cosmetic remote delete cleanups
      gfs2: Fix "gfs2: Switch to wait_event in gfs2_quotad"
      gfs2: Clean up quotad timeout handling
      gfs2: Add clean argument to lm_unmount hook
      gfs2: Asynchronous withdraw
      gfs2: Get rid of delayed withdraws
      gfs2: Rename gfs2_{withdrawing_or_ => }withdrawn
      gfs2: Withdraw immediately on log write errors
      gfs2: Kill gfs2_io_error_bh_wd
      gfs2: Rename LM_FLAG_{NOEXP -> RECOVER}
      Revert "gfs2: don't stop reads while withdraw in progress"
      Revert "gfs2: Force withdraw to replay journals and wait for it to finish" (1/6)
      Revert "gfs2: Force withdraw to replay journals and wait for it to finish" (2/6)
      Revert "gfs2: Force withdraw to replay journals and wait for it to finish" (3/6)
      Revert "gfs2: Force withdraw to replay journals and wait for it to finish" (4/6)
      Revert "gfs2: Force withdraw to replay journals and wait for it to finish" (5/6)
      Revert "gfs2: Force withdraw to replay journals and wait for it to finish" (6/6)
      Revert "gfs2: fix a deadlock on withdraw-during-mount"
      Revert "gfs2: Check for log write errors before telling dlm to unlock"
      Revert "gfs2: Allow some glocks to be used during withdraw"
      Revert "gfs2: fix infinite loop when checking ail item count before go_inval"
      gfs2: Rename gfs2_{gl_dq_holders => withdraw_glocks}
      gfs2: Clean up properly during a withdraw
      gfs2: New gfs2_withdraw_helper
      gfs2: Withdraw immediately in gfs2_trans_add_meta
      gfs2: No longer thaw filesystems during a withdraw
      gfs2: Clean up SDF_JOURNAL_LIVE flag handling
      gfs2: Fix use of bio_chain

Bagas Sanjaya (1):
      Documentation: gfs2: Consolidate GFS2 docs into its own subdirectory

Matthew Wilcox (Oracle) (1):
      gfs2: Use bio_add_folio_nofail()

Sukrut Heroorkar (1):
      gfs2: document ip in __gfs2_holder_init kernel-doc comment

Utkarsh Singh (1):
      gfs2/sysfs: Replace sprintf/snprintf with sysfs_emit

 .../{gfs2-glocks.rst => gfs2/glocks.rst}           |   0
 .../filesystems/{gfs2.rst => gfs2/index.rst}       |  12 +
 .../{gfs2-uevents.rst => gfs2/uevents.rst}         |   0
 Documentation/filesystems/index.rst                |   4 +-
 MAINTAINERS                                        |   2 +-
 fs/gfs2/aops.c                                     |   2 +-
 fs/gfs2/file.c                                     |   2 +-
 fs/gfs2/glock.c                                    | 227 +++++---------
 fs/gfs2/glock.h                                    |  12 +-
 fs/gfs2/glops.c                                    |  98 +-----
 fs/gfs2/incore.h                                   |  22 +-
 fs/gfs2/inode.c                                    |  15 +
 fs/gfs2/inode.h                                    |   1 +
 fs/gfs2/lock_dlm.c                                 |  57 +---
 fs/gfs2/log.c                                      |  59 +---
 fs/gfs2/lops.c                                     |  12 +-
 fs/gfs2/meta_io.c                                  |  13 +-
 fs/gfs2/ops_fstype.c                               |  37 ++-
 fs/gfs2/quota.c                                    |  66 ++---
 fs/gfs2/recovery.c                                 |   8 +-
 fs/gfs2/super.c                                    |  35 +--
 fs/gfs2/super.h                                    |   1 -
 fs/gfs2/sys.c                                      |  64 ++--
 fs/gfs2/trace_gfs2.h                               |   1 -
 fs/gfs2/trans.c                                    |  30 +-
 fs/gfs2/util.c                                     | 328 +++++++--------------
 fs/gfs2/util.h                                     |  56 +---
 27 files changed, 396 insertions(+), 768 deletions(-)
 rename Documentation/filesystems/{gfs2-glocks.rst => gfs2/glocks.rst} (100%)
 rename Documentation/filesystems/{gfs2.rst => gfs2/index.rst} (94%)
 rename Documentation/filesystems/{gfs2-uevents.rst => gfs2/uevents.rst} (100%)


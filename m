Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F8D41C62
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761956561; cv=none; b=UmNlXEcBYxNRZIBwxnMEJq8n2ptXl9qda0nJEzcyqJtOPbC8UkCzVnNXl+1n6OBcBvYzB6zcVqRGDCJbHoOoDf3btMqf/uK140eCJt4TPT+cJZRpKVnVojhe6qjx3RKhMV8Rz7K2Xcxa/Eoy9ORUwvhb/lwUVON0fE1vAyFMp3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761956561; c=relaxed/simple;
	bh=DLj6YPBtmNsjfu7qz1vJNKAs3ZPDA7/0FM1G2Qp6aQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=CqBl4Lk8TAP1Gy4LN79R5+Gm5EbRE6lD+9gOaHneuzBrczWCcwKh8qf6MtxhfUlE7RGiDDqtDnKrv9tSO5xFaB//O5nNg8WksGbnhvmJTDy0oPlzxp/z1SI1pTqCloh+H2lE2fOB4AuG7xjgUskthEhmo4REMdThgxa1mVK0LNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bQCJB8u9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQCJB8u9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761956558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LNI8z5JpN+ZtZmxrnmEwy+JNbvzOmHDZ9tEZ+ZlgL3o=;
	b=bQCJB8u9xmb7tjLh74qSHwNX2plpFZaCviDgz34bKA2wOJZsDPhoA6ofKAaENpM3N0Fw5T
	dKTn+QYZfprs/5JKHE2njlwhOG+3xm6mFM8B20GPpHxeJHF/7hmE3p+YnDOPtJM5mqw4OV
	4jVfErqOcS135387wlZ2a8mEsHXe1cI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-gnn3UKVsPKiufkg2GCSuMw-1; Fri,
 31 Oct 2025 20:22:37 -0400
X-MC-Unique: gnn3UKVsPKiufkg2GCSuMw-1
X-Mimecast-MFC-AGG-ID: gnn3UKVsPKiufkg2GCSuMw_1761956556
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 952D61956050
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:22:36 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8969F180035A;
	Sat,  1 Nov 2025 00:22:35 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 00/24] gfs2 filesystem withdrawal rework
Date: Sat,  1 Nov 2025 00:22:09 +0000
Message-ID: <20251101002234.1286383-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ofdtBI0k5DoZyp8IRuasaeQai90wH61mFlR8ZTWt7jc_1761956556
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When an unrecoverable filesystem error occurs, the "errors" mount option
determines whether the filesystem should trigger a kernel panic or
withdraw the filesystem.  In a production environment, triggering a
kernel panic is usually recommended as that should lead to eventual node
recovery.  Filesystem withdrawal will disable the failed filesystem but
leave the rest of the node running; this can be useful for debugging.

Conceptually, the "errors" setting should make no difference for the
rest of the cluster and in either case, the remaining nodes should
recover the journal of the failed node before resuming operation.

Up until recently, dlm didn't have a way of leaving a lockspace in an
inconsistent state and triggering recovery, though.  The withdrawing
node had to carefully release just the dlm locks needed for recovery,
wait for the other nodes to perform recovery, and only then could it
release the remaining dlm locks.  We ended up with two implementations
of the same concept, and the filesystem withdrawal code was causing
various problems all over the place.

Since dlm merge a769648f464c in v6.18-rc1, gfs2 can indicate that
recovery is needed when leaving a lockspace.  This allows the existing
filesystem withdrawal code to be removed almost entirely.  We can now
trigger withdrawal in any context and complete it asynchronously.

Thanks,
Andreas

Andreas Gruenbacher (24):
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

 fs/gfs2/aops.c       |   2 +-
 fs/gfs2/file.c       |   2 +-
 fs/gfs2/glock.c      | 204 ++++++++-------------------
 fs/gfs2/glock.h      |  12 +-
 fs/gfs2/glops.c      |  95 ++-----------
 fs/gfs2/incore.h     |  22 +--
 fs/gfs2/lock_dlm.c   |  57 +++-----
 fs/gfs2/log.c        |  59 +++-----
 fs/gfs2/lops.c       |   7 +-
 fs/gfs2/meta_io.c    |  13 +-
 fs/gfs2/ops_fstype.c |  35 +++--
 fs/gfs2/quota.c      |   8 +-
 fs/gfs2/recovery.c   |   8 +-
 fs/gfs2/super.c      |  31 ++--
 fs/gfs2/super.h      |   1 -
 fs/gfs2/sys.c        |  34 ++---
 fs/gfs2/trace_gfs2.h |   1 -
 fs/gfs2/trans.c      |  30 ++--
 fs/gfs2/util.c       | 328 +++++++++++++++----------------------------
 fs/gfs2/util.h       |  56 ++------
 20 files changed, 302 insertions(+), 703 deletions(-)

-- 
2.51.0


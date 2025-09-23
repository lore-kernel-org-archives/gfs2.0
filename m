Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AAD2F0C52
	for <gfs2@lists.linux.dev>; Tue, 23 Sep 2025 09:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758618363; cv=none; b=Ni/F3N591AfHaCoaSsFLtC/sXUduOV5MuP4pVSc2fs1NSpRwsAJgNVzYDPoeawYG0Kx9jodfVQRt/XUsJm6+o3ed209gC1cCp62h27wvcZQdbe7VIsDRYl20XmDJyNOieEVxmr1/DJW4MP5I21deS9Kw0VcW4z4tcgpItxS9Z7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758618363; c=relaxed/simple;
	bh=kT8s6gwf+wXNuvXsB0EF8P6HrX6Z/rG6zIPdauh44tA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FAPEdpIX3TGWf4Sk6ORdvm1gCiYkWkVCdI5mHCEccmEhapWQG9b5UCAPFmH0gauP1dFMdT86WSdOJX/1ORUIYnoA+HBs/I2jT2wW9Na/+Jcg/J8yIYxi54woRXBO30tZXZU8UYreAG/SF8VqvnyxGFblrFw6Q5NN8Ra4rtgeeAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LHs9JRoe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHs9JRoe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758618359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XSxea5WDZPWuPXjp4CBCf/5w+mxqGo42GVbb5YJof8E=;
	b=LHs9JRoexExsTK+0+NyPlxAJK1NvzmrdBgsgM/Zj60X7EvJhNj61tHu1UoYv5NEOkjuqLI
	M2SjQ3DF3SAGwkCyF6wdTElzzCppyprp28MD3AUB6P0BMvd4w6b7C2FfUf4fQ/ZHsIoM3z
	716pBQcFaZIw/VwSRr39uvphbp6APhc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-_GOzLQJ3MriZnBBsk0ejjA-1; Tue,
 23 Sep 2025 05:05:55 -0400
X-MC-Unique: _GOzLQJ3MriZnBBsk0ejjA-1
X-Mimecast-MFC-AGG-ID: _GOzLQJ3MriZnBBsk0ejjA_1758618353
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBB4519560BB;
	Tue, 23 Sep 2025 09:05:52 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.17])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3BE571800451;
	Tue, 23 Sep 2025 09:05:50 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 changes for 6.18
Date: Tue, 23 Sep 2025 11:05:42 +0200
Message-ID: <20250923090549.31521-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Dear Linus,

please consider pulling the following gfs2 changes for 6.18.

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-6.18

for you to fetch changes up to 28c4d9bc0708956c1a736a9e49fee71b65deee81:

  gfs2: Fix unlikely race in gdlm_put_lock (2025-09-12 12:03:01 +0200)

----------------------------------------------------------------
gfs2 changes

- Partially revert "gfs2: do_xmote fixes" to ignore dlm_lock() errors
  during withdraw; passing on those errors doesn't help.

- Change the LM_FLAG_TRY and LM_FLAG_TRY_1CB logic in add_to_queue() to
  check if the holder would actually block.

- Move some more dlm specific code from glock.c to lock_dlm.c.

- Remove the unused dlm alternate locking mode code.

- Add proper locking to make sure that dlm lockspaces are never used
  after being released.

- Various other cleanups.

----------------------------------------------------------------
Andreas Gruenbacher (19):
      gfs2: Remove unused GIF_FREE_VFS_INODE flag
      gfs2: Remove unused sd_withdraw_wait field
      gfs2: do_xmote cleanup
      gfs2: Simplify refcounting in do_xmote
      gfs2: Partially revert "gfs2: do_xmote fixes"
      gfs2: Turn gfs2_withdraw into a void function
      gfs2: Sanitize gfs2_meta_check, gfs2_metatype_check, gfs2_io_error
      gfs2: Do not use atomic operations unnecessarily
      gfs2: Further sanitize lock_dlm.c
      gfs2: Remove DLM_LKF_ALTCW / DLM_LKF_ALTPR code
      gfs2: Fix LM_FLAG_TRY* logic in add_to_queue
      gfs2: Remove duplicate check in do_xmote
      gfs2: Fix GLF_INVALIDATE_IN_PROGRESS flag clearing in do_xmote
      gfs2: Get rid of GLF_INVALIDATE_IN_PROGRESS
      gfs2: Simplify do_promote
      gfs2: run_queue cleanup
      gfs2: Minor run_queue fixes
      gfs2: Add proper lockspace locking
      gfs2: Fix unlikely race in gdlm_put_lock

Colin Ian King (1):
      gfs2: Remove space before newline

 fs/gfs2/file.c       |  23 ++++---
 fs/gfs2/glock.c      | 185 +++++++++++++++++++++++----------------------------
 fs/gfs2/glock.h      |   4 ++
 fs/gfs2/incore.h     |   5 +-
 fs/gfs2/lock_dlm.c   | 100 +++++++++++++++++-----------
 fs/gfs2/trace_gfs2.h |   1 -
 fs/gfs2/util.c       |  38 ++++-------
 fs/gfs2/util.h       |  36 +++++-----
 8 files changed, 199 insertions(+), 193 deletions(-)


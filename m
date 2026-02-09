Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C8C37A487
	for <gfs2@lists.linux.dev>; Mon,  9 Feb 2026 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770645568; cv=none; b=DFL+zz76u8dUUO/GgiOh2rKG2JOHHsG7teG/lOljBfmdAxA8HZF1Sl83DZAkrN+5FwP5VW0yvzO3xrGUDWbWhdRBew5PqJMPIB1zSYEXKN1pYhXJ5CGv3yITnXs76h8E9QRowrxqDJ/p+CuHaJlZbfv6IZWCAl/rymuazpBiqrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770645568; c=relaxed/simple;
	bh=LoXzuHjfuOGaaoISgTDRberrHZSuaxvxop3k5Mwo5nI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=OSZuSTkA5cEhDGpD78f6cdfSIdG9K5n2oSiouhrWIZabzit4kwgOkDN0aEJ5oQhB1KFyV08tb62nBQ2yPBnFC4T9TA5HVjc2ypxyjxNgNYoxVwTfweDZw4aryR4C2mUn3ovtZrNHpLpmLlzGMmcYgION91yppTYwmmvKTDHf/1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kkk5xION; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kkk5xION"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770645567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8RGRjX8NXThZFEyWIiCFcY1cFNIxf3fR00Obcga1zWo=;
	b=Kkk5xIONy7JLUrW4MBOqQMZn5p0QplpX4FWuoc4ifFF0nos70ff+BTnxXdWuCTjGuB71VK
	/9BT3nR9IudriNqJlpBq/0HvAhkAq9sQ5afbcDDdm0bWpO6t9bc8MJqps/MyO2bjPrSBlJ
	z3RezuSf7JmUfceeDlVsrvb3SxK6/k0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-eHN-QDZqP42Hicu00G_VCw-1; Mon,
 09 Feb 2026 08:59:24 -0500
X-MC-Unique: eHN-QDZqP42Hicu00G_VCw-1
X-Mimecast-MFC-AGG-ID: eHN-QDZqP42Hicu00G_VCw_1770645563
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D325519560B2;
	Mon,  9 Feb 2026 13:59:22 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.226.163])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 33D7B19560BA;
	Mon,  9 Feb 2026 13:59:20 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 changes for 7.0
Date: Mon,  9 Feb 2026 14:59:18 +0100
Message-ID: <20260209135919.1827410-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: 3efpSv97RLFUdpv0rNSYE-I5sBz39tfpNoICoXnTNEM_1770645563
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Dear Linus,

please consider pulling the following gfs2 changes for 7.0.

Thanks,
Andreas

The following changes since commit b54345928fa1dbde534e32ecaa138678fd5d2135:

  Merge tag 'gfs2-for-6.19-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2 (2026-01-13 10:04:34 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-7.0

for you to fetch changes up to e411d74cc5ba290f85d0dd5e4d1df8f1d6d975d2:

  gfs2: fiemap page fault fix (2026-02-05 18:00:45 +0100)

----------------------------------------------------------------
gfs2 changes

- Prevent rename() from failing with -ESTALE when there are locking
  conflicts and retry the operation instead.

- Don't fail when fiemap triggers a page fault (xfstest generic/742).

- Fix another locking request cancellation bug.

- Minor other fixes and cleanups.

----------------------------------------------------------------
Andreas Gruenbacher (13):
      gfs2: glock cancelation flag fix
      gfs2: Retries missing in gfs2_{rename,exchange}
      gfs2: run_queue cleanup
      gfs2: Do not cancel internal demote requests
      gfs2: Rename gfs2_log_submit_{bio -> write}
      gfs2: Initialize bio->bi_opf early
      gfs2: gfs2_chain_bio start sector fix
      gfs2: Fix gfs2_log_get_bio argument type
      gfs: Use fixed GL_GLOCK_MIN_HOLD time
      gfs2: gfs2_glock_hold cleanup
      gfs2: Introduce glock_{type,number,sbd} helpers
      gfs2: Fix slab-use-after-free in qd_put
      gfs2: fiemap page fault fix

Deepanshu Kartikey (2):
      gfs2: Fix use-after-free in iomap inline data write path
      gfs2: fix memory leaks in gfs2_fill_super error path

 fs/gfs2/bmap.c       |  13 +++-
 fs/gfs2/glock.c      | 190 ++++++++++++++++++++++++++++++---------------------
 fs/gfs2/glock.h      |   9 +--
 fs/gfs2/glops.c      |  34 ++++-----
 fs/gfs2/incore.h     |  18 ++++-
 fs/gfs2/inode.c      |  34 +++++++--
 fs/gfs2/lock_dlm.c   |  28 ++++----
 fs/gfs2/log.c        |   7 +-
 fs/gfs2/lops.c       |  51 +++++++-------
 fs/gfs2/lops.h       |   4 +-
 fs/gfs2/meta_io.c    |   6 +-
 fs/gfs2/meta_io.h    |   2 +-
 fs/gfs2/ops_fstype.c |   2 +-
 fs/gfs2/quota.c      |   5 +-
 fs/gfs2/rgrp.c       |   2 +-
 fs/gfs2/super.c      |   4 +-
 fs/gfs2/trace_gfs2.h |  50 +++++++-------
 fs/gfs2/trans.c      |   4 +-
 18 files changed, 277 insertions(+), 186 deletions(-)


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2757916419
	for <gfs2@lists.linux.dev>; Mon, 23 Sep 2024 18:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727114680; cv=none; b=BRFevmSPEldK3PVBjeEHaXzadGFdGfUK4u+urD3H9NKYuu6TzLHfl4WJzNzVgfqKw8dNxNAcOUnKi4HCQCXd8lUitksYusGi7CQFfuqVXjOcgX19jT8lwasaP3CNklSg4L1ETgON2iCSgqDwZko55NaUl+4nnF3fJKIcwFW/BwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727114680; c=relaxed/simple;
	bh=EZHCrKzxbPNEXtJuwznFWUbHe1GuS0ZswjOMle0CaFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DoT55u12xj5C7frB/0ZdXs0TnYkwZ7jWwLy6VNFGdRZKoCs5KqNnF9R0IEF2kGSaiWwtoB+oLrMV5YpusflCFQm0iD+WpplkpFjbLtOP8V4yVVbUhxCyP30zTy4tRSr8nTXSyAMoftNm4GPya17XVNRrBKEqC8hoUkljpIHeiMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LVKpdzI2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LVKpdzI2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727114678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4zk2H1hCENikiPreGuVpe9tmODe6t3h9N4bM5aN33PM=;
	b=LVKpdzI2rf01THFZYxGezsWDGC46RoV4OJkRLFgqfHPVSvOxjHz0OsvIlPUJMl/mgpKv9o
	Ff3hjm+LDqX9w6/yMtYCndAbWUEH7yGR1Y/lvVWwuS3+7cO77ZK2JoA8o8Vlhqhsrxo640
	j9UDyb9TtzV3e8XizlChStGmEhCuNHc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-swlbcMiON5ef1CIK3F8CtA-1; Mon,
 23 Sep 2024 14:04:36 -0400
X-MC-Unique: swlbcMiON5ef1CIK3F8CtA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF4EF1911B0E;
	Mon, 23 Sep 2024 18:04:35 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.77])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 33C9919560A3;
	Mon, 23 Sep 2024 18:04:33 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 changes
Date: Mon, 23 Sep 2024 20:04:30 +0200
Message-ID: <20240923180432.270779-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Dear Linus,

please consider pulling the following gfs2 changes.

Thank you very much,
Andreas


The following changes since commit 6706415bf9f3dcb425f4b60a08a3a6f1d94ec0e0:

  Merge tag 'gfs2-v6.10-rc1-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2 (2024-07-17 12:23:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.10-fixes

for you to fetch changes up to 6888c1e85f5db129e6ddcff879bb127bbfdb5c64:

  gfs2: Remove gfs2_aspace_writepage() (2024-09-02 14:46:37 +0200)

----------------------------------------------------------------
gfs2 changes

- Eliminate the writepage address space operation (by Matthew Wilcox).

- A syzkaller fix (by Julian Sun) and a minor cleanup (by Andreas
  Gruenbacher).

----------------------------------------------------------------
Andreas Gruenbacher (1):
      gfs2: Minor gfs2_glock_cb cleanup

Julian Sun (1):
      gfs2: fix double destroy_workqueue error

Matthew Wilcox (Oracle) (4):
      gfs2: Add gfs2_aspace_writepages()
      gfs2: Remove __gfs2_writepage()
      gfs2: Remove gfs2_jdata_writepage()
      gfs2: Remove gfs2_aspace_writepage()

 fs/gfs2/aops.c       | 30 ------------------------------
 fs/gfs2/glock.c      |  9 ++++++---
 fs/gfs2/log.c        | 12 ++----------
 fs/gfs2/meta_io.c    | 24 +++++++++++++++++-------
 fs/gfs2/ops_fstype.c |  3 ++-
 5 files changed, 27 insertions(+), 51 deletions(-)


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A193FBEAB
	for <gfs2@lists.linux.dev>; Mon, 17 Aug 2026 11:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786966017; cv=none; b=T86f8yAYivpfkTXEJL4qcEdTP80cswekPW34bmG1Gtqr5OVf7jancWH+vJgc1p4iq2qgvvZ0tig6Zkax+CbwNmz8rrKASyS6eZhV+9eosm4uWZ6n/EsrnSlBQYdaEM3kVmdw1qOWa9bSih2ZBjD1K76+wPm/M7niBthvgqa7eMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786966017; c=relaxed/simple;
	bh=vIyw3+wXOKgDp5YCmQYBHm30A95xmQLbzc4VAoSfjPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=RHAcICgewSxdj7ogYMshsUFGDOJsUDOskDFTsH7+TKx2qQmPVG9RRrpm5LNsb4jCvDxsxkUNxpC3iqE4byafYqwhLQNVwYxtg4YbSZtRdlgnE1CKu0vYlPZ18HU9Y5eUr22g6uaBLFrtLRtKYf9GHiNuAdNeL9LGOFn7ScradGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LvEHbavQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LvEHbavQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786966015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FK3dyt/Fp1cvbvQHq11Y10z156s6LKGJ0IrHsXBKCJY=;
	b=LvEHbavQK4Bb/3CRaBLGowQBO6uO73bdGTsbGTmkjizhAx8UtQ28lusSxF9P/y1WbOEJz5
	cMOoqp7gl6UqMQX7zXp435VVDkBKbWyOjUi9IMrtXpPIgWLW1K4goavzyRMSxUfC3hYjbK
	Ow1ASutkhN3ET0C5l9bAlt3ihNMjyTk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-8PmlvE1tO_GtxJF_97M9Lw-1; Mon,
 17 Aug 2026 07:26:51 -0400
X-MC-Unique: 8PmlvE1tO_GtxJF_97M9Lw-1
X-Mimecast-MFC-AGG-ID: 8PmlvE1tO_GtxJF_97M9Lw_1786966011
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD3ED195608B;
	Mon, 17 Aug 2026 11:26:50 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.44.33.178])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2012D3000223;
	Mon, 17 Aug 2026 11:26:48 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 changes for 7.3
Date: Mon, 17 Aug 2026 13:26:46 +0200
Message-ID: <20260817112647.1203264-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: otXRhgEuf0OoBuetKWdBkhNNtCznygiU4f3V0TjQSV0_1786966011
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Dear Linus,

please consider pulling the following gfs2 changes for 7.3.

Thanks,
Andreas


The following changes since commit a13c140cc289c0b7b3770bce5b3ad42ab35074aa:

  Linux 7.2-rc3 (2026-07-12 14:16:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-7.3

for you to fetch changes up to 657e5af4fe0b9696a6c7232da1727a9f37eaa04d:

  gfs2: harden gfs2_glock_hold (2026-08-12 20:22:51 +0200)

----------------------------------------------------------------
gfs2 changes

- Don't cache unreferenced glocks: when a glock is no longer referenced (for
  example, because the inode it protects is evicted), it is now released as
  soon as possible instead of leaving it around until memory pressure or an
  unmount forces it out.  For some workloads, this saves a lot of memory and
  speeds up unmounts significantly.

- Harden gfs2_glock_hold() by making sure the caller holds a reference and
  fix a related race in checking for the liveliness of glocks between
  gdlm_bast() and gfs2_glock_cb().

----------------------------------------------------------------
Andreas Gruenbacher (5):
      gfs2: Enable automatic glock hash table shrinking
      gfs2: Don't cache unreferenced glocks
      gfs2: Skip dlm unlocks earlier
      gfs2: Remove the glock lru list and shrinker
      gfs2: harden gfs2_glock_hold

 fs/gfs2/glock.c      | 231 ++++++---------------------------------------------
 fs/gfs2/glock.h      |   2 +-
 fs/gfs2/incore.h     |   7 +-
 fs/gfs2/lock_dlm.c   |   5 +-
 fs/gfs2/main.c       |   1 -
 fs/gfs2/ops_fstype.c |   5 +-
 fs/gfs2/super.c      |   2 +-
 fs/gfs2/sys.c        |   2 -
 fs/gfs2/trace_gfs2.h |   1 -
 9 files changed, 35 insertions(+), 221 deletions(-)


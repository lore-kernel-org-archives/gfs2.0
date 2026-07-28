Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FC1381B10
	for <gfs2@lists.linux.dev>; Tue, 28 Jul 2026 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785256897; cv=none; b=FJRl+li1Z5V4L0tr+cBlqqh7yRQx3keBEF1ZtHD2hy61GTJN3tIAqlSLOZQwTvmzAdc/BjxOYGWixrK32Wk54NrZUhhvPFv09gfTGQ/zUMNz0aUwi9ARJFFCc246+koTg/KChbLeeLe+o1l8XcRNRG0rr5Z5tFNIRt3TiSfuZaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785256897; c=relaxed/simple;
	bh=CampQiekPv8MTRywI569wCO1xZfLa2HIwG1eAqVm56U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=GYDs65g3Nb8nfmJwgTx/yJzelQSAs00ByGewo8XhFOnYyJXJoqdZlE/uNkDehamHqNpgZlu16ujqrXXHDza7w0qqHFMuG85ExLoUkUe3TN1nsitclJsoFl/gE76g6cbb9c3jkC2+xJwIhXB3ZIjgKWHwS6tMV6WHQSccLKVU3IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mfrm+8tU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mfrm+8tU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785256895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qjQH9A+cHuCgjcujp6WaVGLXzpWkXLmO9614IrMbGMA=;
	b=Mfrm+8tUR6ecjvtZgIYViWuiU+n3xdI2QvISS+NhvLCr/rll5zZG0Z/AMHV2eixom07JTO
	pM7Ltbf0wf6vP09btRK+CE44uSeV3e/4ss226qcGPUfRancIPiMObOnK/Ym8LycRqn72DM
	/r1X+EPa9DAVZE4EhtITWcfgIKpIpro=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-i5i9ZkLPM76R530H4SUCBg-1; Tue,
 28 Jul 2026 12:41:31 -0400
X-MC-Unique: i5i9ZkLPM76R530H4SUCBg-1
X-Mimecast-MFC-AGG-ID: i5i9ZkLPM76R530H4SUCBg_1785256890
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 48716195608F
	for <gfs2@lists.linux.dev>; Tue, 28 Jul 2026 16:41:30 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.44.48.20])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5BA62300019F;
	Tue, 28 Jul 2026 16:41:28 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 0/4] Don't cache unused glocks
Date: Tue, 28 Jul 2026 18:41:20 +0200
Message-ID: <20260728164127.791843-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: M9jaSi_pNLqPRn1tEiUwfSUAIYu6zCAEv3KC28u9JxA_1785256890
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This patch series changes gfs2 to drop glocks as soon as possible after
their corresponding inodes are evicted (by being deleted or being forced
out due to memory pressure).  This causes the corresponding DLM locks to
be unlocked much sooner, which smooths out DLM unlocking load spikes
at unmount time.

Before this patch set, the glocks were only forced out in response to
memory pressure, as well as at filesystem unmount time.  Unlocking the
corresponding DLM locks is somewhat slow though, so depending on the
workload, a lot of memory could get tied up unnecessarily.  In addition,
some workloads could cause filesystem unmount time to skyrocket.

By not caching unused glocks, we can also get rid of the glocks LRU
list.

Andreas Gruenbacher (4):
  gfs2: Enable automatic glock hash table shrinking
  gfs2: Don't cache unreferenced glocks
  gfs2: Skip dlm unlocks earlier
  gfs2: Remove the glock lru list and shrinker

 fs/gfs2/glock.c      | 225 ++++---------------------------------------
 fs/gfs2/glock.h      |   2 +-
 fs/gfs2/incore.h     |   7 +-
 fs/gfs2/lock_dlm.c   |   2 +-
 fs/gfs2/main.c       |   1 -
 fs/gfs2/ops_fstype.c |   5 +-
 fs/gfs2/super.c      |   2 +-
 fs/gfs2/sys.c        |   2 -
 fs/gfs2/trace_gfs2.h |   1 -
 9 files changed, 31 insertions(+), 216 deletions(-)

-- 
2.55.0


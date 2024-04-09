Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02B112FB38
	for <gfs2@lists.linux.dev>; Tue,  9 Apr 2024 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712681154; cv=none; b=liFtY8i8CcAZrDGZVMh6dbOSECdVK1XMrb8ejxUDDAi+pQba6qW+QdDRGmGGlyfGvocpDV+c8UMnxJRJcywgMvpGtwAAlGKjKTczewxnZWGeXGSNAKpRlsb1hL5kSmJpCyoWiuT15WwQIYTSqA3W+mM9Ry6jU76BcPesJQuMK4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712681154; c=relaxed/simple;
	bh=hLE3RSwY4vSMjbzhm2OTVMy19jPsej+ApM7fVBcPtKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qle6gdFcdNOC8nzbmZ2vWh1FHLiBfMuZzOfeHuIF3YbQz1ZbZHvRaRY/CCGNd5jC1uYyJARLwasPBIOHtkPdHBfpA03s4tSMRDNCyOQ+rdgAo2FCu3xoo+DKAuJAUAbbDabEhzx9MaiXtkil6Ec8lJpMRJHyF+efDICb8xMDh1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OMVQkKqc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OMVQkKqc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712681146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9mvK5ZpRX5ly3z/JgyaCM+kBKAGpiwJt46oEFeLLXD8=;
	b=OMVQkKqcSEU2psNwHbbt+IS132dQ/3yqWEi8T3D70Qbpv9vwA5CZEOFdQFst1cjmPECftd
	AcpAi5uByz4EKAF9qVsUBbEpNho5cVsTOEKly/mbII0WucYlVCUIUMlM/oDnoJtieRL/CY
	LWmThc2t7pBK8ubXwDjBSvacJoTs0lQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-C4k2qAMKOjiKNqecy2iqkA-1; Tue, 09 Apr 2024 12:45:21 -0400
X-MC-Unique: C4k2qAMKOjiKNqecy2iqkA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D8F2C188ACA2
	for <gfs2@lists.linux.dev>; Tue,  9 Apr 2024 16:45:13 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.28])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5A641C0157E;
	Tue,  9 Apr 2024 16:45:13 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 00/15] gfs2 cleanups and fixes
Date: Tue,  9 Apr 2024 18:44:50 +0200
Message-ID: <20240409164508.79570-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The following gfs2 cleanups and fixes have accumulated recently.  I've
queued them up for the next merge window; see the for-next branch at:

  https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/

Thanks,
Andreas

Andreas Gruenbacher (15):
  gfs2: Get rid of newlines in log messages
  gfs2: Remove unnecessary gfs2_meta_check_ii argument
  gfs2: Follow-up to flag rename in sysfs status file
  gfs2: Use [NO_]CREATE consistently for gfs2_glock_get
  gfs2: Don't forget to complete delayed withdraw
  gfs2: Fix NULL pointer dereference in gfs2_log_flush
  gfs2: Get rid of gfs2_glock_queue_put in signal_our_withdraw
  gfs2: Replace gfs2_glock_queue_put with gfs2_glock_put_async
  gfs2: Don't set GLF_LOCK in gfs2_dispose_glock_lru
  gfs2: Get rid of unnecessary test_and_set_bit
  gfs2: Fix "ignore unlock failures after withdraw"
  Revert "gfs2: fix glock shrinker ref issues"
  gfs2: Fix "Make glock lru list scanning safer"
  gfs2: Get rid of demote_ok checks
  gfs2: Fix lru_count accounting

 Documentation/filesystems/gfs2-glocks.rst |   3 -
 fs/gfs2/bmap.c                            |   2 +-
 fs/gfs2/glock.c                           | 101 ++++++++++------------
 fs/gfs2/glock.h                           |   2 +-
 fs/gfs2/glops.c                           |  21 +----
 fs/gfs2/incore.h                          |   1 -
 fs/gfs2/log.c                             |   5 +-
 fs/gfs2/rgrp.c                            |  10 +--
 fs/gfs2/super.c                           |   8 +-
 fs/gfs2/sys.c                             |   4 +-
 fs/gfs2/util.c                            |  57 ++++++------
 fs/gfs2/util.h                            |   4 +-
 12 files changed, 96 insertions(+), 122 deletions(-)

-- 
2.44.0


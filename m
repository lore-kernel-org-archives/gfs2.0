Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB5F3C0621
	for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 14:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776091939; cv=none; b=oEhTHmeomKmPluzPkuFfRkeDg5W5wNUG9vQ+RVVKS+EtnB1fBBmRegEI27ydVwv1ZlrP0FyxflqMJVdLMTQqzT8kM9V1EoL8LRlNwZt9lzPPf6LCDxthGFSGah8Idd3jg+xQjbeqSij5F0n36QnmUKGPWKjKJnCcUIcs0SwHnao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776091939; c=relaxed/simple;
	bh=hvAODFv0RSKpGQ4NGbvw+d7YLcrkb82llVIyYI+A5y8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=Aj1jzw73GC5bwSp2LMYC4P2oC7BQX76MXM77ezjFCsmfEXnAQl9np6ea40TUUaWqHMuq86YuXYOLnaAQeXODBQNNBhjC8aXwbmVFFEPuzfX4Vwr/VfuyO9wxiRcmGAIW0jRxnDuWX1vffGnBismibhX5J17jR68Z0zKaJ0tobY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MKglTHH3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKglTHH3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776091937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8MYMQnHrhlXyni0cHMn+y12IuJ5HwqOKpLfogzoVMCo=;
	b=MKglTHH3wFrUFLGKauP69sYj9XP8ZKGHE5Xf4PMAocaqvEMWed5bH1F73BrBuDaICgO5kU
	rp/akcGDQZy++9g27w0mA+2eIYpBxbRJUte4RyFToJwOe7tAtMhBkUcIHRSB/wHScrbx7P
	iO7cnkbsvsQ4Iyg3HYYfatrb0eqCi90=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-FkuGIKXWOKu1YXnDg8teAQ-1; Mon,
 13 Apr 2026 10:52:15 -0400
X-MC-Unique: FkuGIKXWOKu1YXnDg8teAQ-1
X-Mimecast-MFC-AGG-ID: FkuGIKXWOKu1YXnDg8teAQ_1776091934
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3AD401800619
	for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 14:52:14 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.156])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 46F9519560AB;
	Mon, 13 Apr 2026 14:52:12 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 00/18] gfs2 patches on for-next
Date: Mon, 13 Apr 2026 16:51:53 +0200
Message-ID: <20260413145211.881752-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ps5u5uLmM52FCAtP4fbBjLzEMi7NZnDDUPI9FYF3IYo_1776091934
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Hello,

we currently have the following patches on for-next, to be submitted for
upstream inclusion in the current merge window.  These mainly address
the following problems:

* When inodes got evicted, changes in the page cache were sometimes
  discarded instead of being written back do disk (as exhibited by
  xfstest generic/211).

* Systems under heavy memory pressure were issuing too many log flushes,
  leading to a degradation in performance.

* An occasional leak of bufdata objects.

* Some minor improvements to the handling of withdraws.

Thanks,
Andreas

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

 fs/gfs2/aops.c    |  15 +++---
 fs/gfs2/bmap.c    |   2 +-
 fs/gfs2/glops.c   |  13 +++--
 fs/gfs2/inode.c   |   3 +-
 fs/gfs2/log.c     | 127 +++++++++++++++++++++++++++++++++-------------
 fs/gfs2/log.h     |  26 +---------
 fs/gfs2/lops.c    |  16 +++---
 fs/gfs2/meta_io.c |  43 ++--------------
 fs/gfs2/meta_io.h |   1 -
 fs/gfs2/rgrp.c    |   2 +-
 fs/gfs2/super.c   | 111 +++++++++++++++++++++++++++++++---------
 fs/gfs2/trans.c   |  45 ++++++++--------
 fs/gfs2/util.c    |   3 +-
 13 files changed, 237 insertions(+), 170 deletions(-)

-- 
2.53.0


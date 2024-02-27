Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC725125B9
	for <gfs2@lists.linux.dev>; Tue, 27 Feb 2024 01:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998567; cv=none; b=IUcvU05FcSkYgCs78WT7s+2xyAERNrZP8jbUzqLJlB5AdHS2ARAv79gyjGJc1h+UPj3Y//6TgbrJDPdHC9cuY0ao6vnUNXc8RHmTqJWfur3KylW9zv5MRu+v4+V1djMZjwWkenMVLxpK2vDjBASAqu/3WghFjSez+Ile7Ii5z8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998567; c=relaxed/simple;
	bh=deHYuu/m1GwPCwF81FOpOhy8jDICxFjj1Nh89u58S5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oSUg5RglhwvtSvFD9vEnL1AkAkxTQc7X/uZOEWwa8w7l8sDDvmh1zzbSFyHV4WNhMGh839l06DIgnhXs4XHOMRkv+PFPbpFGQZCFftjh2qmjBXx7hPHCF6zLK3bAEMCpmPMrVdr6kJNpR5EIfxy6b6CFsZU0L1EZXY58jT4H0as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BUMiuGwJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUMiuGwJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708998564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xzjUryMDFtflUqRNZWDXUVwZGvHhVIhjo2UaTY6zYjg=;
	b=BUMiuGwJ4uXq0ChdcIPcsTElRlfm54QILriEFc6J+/zoMVo0EOz5Z1FK82UEpWfzWjMKy1
	oXhmlBTTClG4Hc5Xzx1d2xz1q1x7dcE+u10RrtKqGxQdpfM1E42F7u8vFPF36raNBoEPL3
	5krLnlfiSGq85rio091rnrkIZdTxDHM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-3UNtRifSN6GdJnxepN495g-1; Mon,
 26 Feb 2024 20:49:19 -0500
X-MC-Unique: 3UNtRifSN6GdJnxepN495g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E905B28237C5
	for <gfs2@lists.linux.dev>; Tue, 27 Feb 2024 01:49:18 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.fast.eng.rdu2.dc.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E0D1A2166B33;
	Tue, 27 Feb 2024 01:49:18 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv3 v6.8-rc6 00/18] dlm: bring message parsing to softirq context
Date: Mon, 26 Feb 2024 20:48:51 -0500
Message-ID: <20240227014909.93945-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Hi,

this is version 3 of my attempt to bring dlm message parsing to softirq
context. This will "minimal" improve the dlm message parsing that is
still message after message parsing. There is still a context switch
involed that is the dlm callback workqueue. This patch mostly have the
effect that we call "queue_work()" more often. In future we will get
rid of the dlm callback workqueue and call the DLM user callback
directly in the dlm message processing softirq context. However this
requires that DLM users adapt the changes and signal this capability
over a new lockspace flag.

- Alex

changes since v3:
 - add patches that got meanwhile on the mailinglist to resend them.
 - add "remove schedule in dlm receive path" to remove a schedule()
   in the dlm msg processing path.
 - change commit message of "dlm: do dlm message processing in softirq
   context" to mention the 

changes since v2:

I changed in v2 that we split the root_list to root_list and a per
lockspace masters list. The root_list can be used as a stack list
variable in ls_recover() as it's only used for recovery handling. The
masters list is somehow special because it is being used for other dlm
nodes to dump the nodes master rsbs. The current implementation
guarantees that this happens in a very special part of the recovery
handling by using a kind of distributed cluster barriers. I added more
sanity checks for this handling and a more per node based recovery log
mechanism. There is also a TODO that describes we should keep track of
all masters rsb while lockspace locking handling and not create them
while recovery handling which I think should improve the handling to
maybe get rid of those barriers.

Alexander Aring (16):
  dlm: fix off-by-one waiters refcount handling
  dlm: put lkbs instead of force free
  dlm: remove allocation parameter in msg allocation
  dlm: switch to GFP_ATOMIC in dlm allocations
  dlm: move root_list functionality to recover.c
  dlm: move master dir dump to own list
  dlm: move root_list to ls_recover() stack
  dlm: implement directory dump context
  dlm: drop holding waiters mutex in waiters recovery
  dlm: convert ls_waiters_mutex to spinlock
  dlm: convert res_lock to spinlock
  dlm: make requestqueue handling non sleepable
  dlm: ls_recv_active semaphore to rwlock
  dlm: remove schedule in dlm receive path
  dlm: convert message parsing locks to disable bh
  dlm: do dlm message processing in softirq context

Kunwu Chan (2):
  fs: dlm: Simplify the allocation of slab caches in
    dlm_midcomms_cache_create
  fs: dlm: Simplify the allocation of slab caches in
    dlm_lowcomms_msg_cache_create

 fs/dlm/ast.c          |  28 ++---
 fs/dlm/debug_fs.c     |  36 +++---
 fs/dlm/dir.c          | 147 ++++++++++++++++++----
 fs/dlm/dir.h          |   3 +-
 fs/dlm/dlm_internal.h |  20 +--
 fs/dlm/lock.c         | 277 +++++++++++++++++++++++-------------------
 fs/dlm/lock.h         |   8 +-
 fs/dlm/lockspace.c    |  96 ++++++++-------
 fs/dlm/lowcomms.c     |  68 +++++------
 fs/dlm/lowcomms.h     |   5 +-
 fs/dlm/member.c       |  23 ++--
 fs/dlm/memory.c       |  14 +--
 fs/dlm/memory.h       |   4 +-
 fs/dlm/midcomms.c     |  67 +++++-----
 fs/dlm/midcomms.h     |   3 +-
 fs/dlm/rcom.c         |  33 +++--
 fs/dlm/recover.c      | 126 ++++++-------------
 fs/dlm/recover.h      |  10 +-
 fs/dlm/recoverd.c     | 125 ++++++++++++++++---
 fs/dlm/requestqueue.c |  43 ++-----
 fs/dlm/user.c         |  34 +++---
 21 files changed, 657 insertions(+), 513 deletions(-)

-- 
2.43.0


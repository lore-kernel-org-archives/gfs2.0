Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0D31427B
	for <gfs2@lists.linux.dev>; Sun, 19 Nov 2023 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cTtuIjkR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700411906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sAV8v8bTl0g7zZUxg8DeADm5hYJj4oDMQQj61yhkU4A=;
	b=cTtuIjkRv2wbRr7FgwessKtCprlbg36M7qNNZP/o7WL8SXaz0Ojbz0xLfpUeT/KI/KB2Ve
	QrlmAW4GQSC/W6ToypOTNk2weB9TnMxgQMksceihTXzwCd9wr/xQwUGewk51rluYZzEPwn
	26epGaQF7viX50+CPvFS9VRqXTMV0HY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-FY8ekXA1MeOUoPW7SuuVgQ-1; Sun, 19 Nov 2023 11:38:23 -0500
X-MC-Unique: FY8ekXA1MeOUoPW7SuuVgQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 784F88007B3
	for <gfs2@lists.linux.dev>; Sun, 19 Nov 2023 16:38:23 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fast.rdu2.eng.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6FCD540C6EB9;
	Sun, 19 Nov 2023 16:38:23 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv2 dlm/next 00/13] dlm: bring message parsing to softirq context
Date: Sun, 19 Nov 2023 11:38:04 -0500
Message-Id: <20231119163817.751872-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Hi,

this is version 2 of my attempt to bring dlm message parsing to softirq
context. This will "minimal" improve the dlm message parsing that is
still message after message parsing. This patch will move the dlm
message parsing into a softirq context where we probably can easily
trigger parallel message processing and take advantage that the message
processing runs on a per cpu basis.

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

- Alex

Alexander Aring (13):
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
  dlm: convert message parsing locks to disable bh
  dlm: do dlm message processing in softirq context

 fs/dlm/ast.c          |  28 ++---
 fs/dlm/debug_fs.c     |  36 ++++---
 fs/dlm/dir.c          | 147 ++++++++++++++++++++++----
 fs/dlm/dir.h          |   3 +-
 fs/dlm/dlm_internal.h |  20 ++--
 fs/dlm/lock.c         | 236 ++++++++++++++++++++++--------------------
 fs/dlm/lock.h         |   7 +-
 fs/dlm/lockspace.c    |  65 ++++++------
 fs/dlm/lowcomms.c     |  66 +++++-------
 fs/dlm/lowcomms.h     |   5 +-
 fs/dlm/member.c       |  23 ++--
 fs/dlm/memory.c       |  14 +--
 fs/dlm/memory.h       |   4 +-
 fs/dlm/midcomms.c     |  64 ++++++------
 fs/dlm/midcomms.h     |   3 +-
 fs/dlm/rcom.c         |  33 +++---
 fs/dlm/recover.c      | 126 +++++++---------------
 fs/dlm/recover.h      |  10 +-
 fs/dlm/recoverd.c     | 125 ++++++++++++++++++----
 fs/dlm/requestqueue.c |  43 ++------
 fs/dlm/user.c         |  34 +++---
 21 files changed, 603 insertions(+), 489 deletions(-)

-- 
2.39.3


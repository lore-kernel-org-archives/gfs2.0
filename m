Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F3215B966
	for <gfs2@lists.linux.dev>; Tue,  2 Apr 2024 19:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712085505; cv=none; b=Kv7H39GjToeuzamaXecOACa8YrRkNRKwV1YQ4FVgAHZh7wZoDC7IRiIW90OOEABOCGhtbfHoahXnNRQ1BND5ecmSQVpToIu/HJ/TD7eIvYlDtJ0SvGSOTpiBi4c2yKJmziY49E8HdOjaFLl5ekVpDBaeyMhKZu//RV05e764M38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712085505; c=relaxed/simple;
	bh=8peWKTSk39fFLBd9R9yhtsdAcuPiOGDFHKpKOZ7E20o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nuk98HXLTBSgTgzi8CoB4vsc5ZsmiFIdj9WEX1rWBxGQSrHaM6UdLohxKcxm+YqpNfWSSJoP2w1p90q+CKOac/KeIWYfnlpzRF72wjcImf5MC5SV04G/BgdTuuilMo+PtCdsreEwu/+mvORweFLz7CjkeftAu3Zs2OfIYG5g1ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YATaceAT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YATaceAT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712085502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+3TnyeoUs/q96ftZoJMrXHbUU+IbsqYU7oLOX4cS5RY=;
	b=YATaceATp/24K1wkdHVuAiWEv0vn2VuRLIPdKgZsJmRBRWw7LKplPzquXbeD7Petfo//CC
	QDKFYkwVkeWRaTPBJXrf02jQOvDe320LNQfAtb4ajFZ5PCn8tv9MQGQTr93K/IV2CN91dv
	KlQV+xx1qMkqK7aU1eD0A06bEU3NCaE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-nh6JWSpBPxO0V-drAnkYyA-1; Tue, 02 Apr 2024 15:18:18 -0400
X-MC-Unique: nh6JWSpBPxO0V-drAnkYyA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57D01185A788
	for <gfs2@lists.linux.dev>; Tue,  2 Apr 2024 19:18:18 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4F75740C6DAE;
	Tue,  2 Apr 2024 19:18:18 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv4 dlm/next 00/15] dlm: bring message parsing to softirq context
Date: Tue,  2 Apr 2024 15:17:55 -0400
Message-ID: <20240402191810.1932939-1-aahringo@redhat.com>
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

this is version 4 of my attempt to bring dlm message parsing to softirq
context. This will "minimal" improve the dlm message parsing that is
still message after message parsing. There is still a context switch
involed that is the dlm callback workqueue. This patch mostly have the
effect that we call "queue_work()" more often. In future we will get
rid of the dlm callback workqueue and call the DLM user callback
directly in the dlm message processing softirq context. However this
requires that DLM users adapt the changes and signal this capability
over a new lockspace flag.

- Alex

changes since v4:
 - add still "dlm: Simplify the allocation of slab caches in
   dlm_lowcomms_msg_cache_create" that was forgotten in the last
   patch series.
 - update commit message to hopefully more clear
 - use new WQ_BH instead of tasklets
 - use trylock and return -EAGAIN if debugfs cannot access waiters
   due recovery is going on
 - move clear of root_list in its own goto label instead doing it
   when its already cleared
 - introduce dlm_refcount_dec_and_lock_bh() that hopefully can
   be later moved into refcount code instead of
   local_bh_disable/enable all the time

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

Alexander Aring (14):
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

Kunwu Chan (1):
  dlm: Simplify the allocation of slab caches in
    dlm_lowcomms_msg_cache_create

 fs/dlm/ast.c          |  12 +-
 fs/dlm/debug_fs.c     |  41 ++++---
 fs/dlm/dir.c          | 147 +++++++++++++++++++----
 fs/dlm/dir.h          |   3 +-
 fs/dlm/dlm_internal.h |  20 ++--
 fs/dlm/lock.c         | 271 +++++++++++++++++++++++-------------------
 fs/dlm/lock.h         |   7 +-
 fs/dlm/lockspace.c    |  65 +++++-----
 fs/dlm/lowcomms.c     |  62 ++++++----
 fs/dlm/lowcomms.h     |   5 +-
 fs/dlm/member.c       |  23 ++--
 fs/dlm/memory.c       |  14 +--
 fs/dlm/memory.h       |   4 +-
 fs/dlm/midcomms.c     |  64 +++++-----
 fs/dlm/midcomms.h     |   3 +-
 fs/dlm/rcom.c         |  33 +++--
 fs/dlm/recover.c      | 126 ++++++--------------
 fs/dlm/recover.h      |  10 +-
 fs/dlm/recoverd.c     | 142 ++++++++++++++++++----
 fs/dlm/requestqueue.c |  43 ++-----
 fs/dlm/user.c         |  32 ++---
 21 files changed, 647 insertions(+), 480 deletions(-)

-- 
2.43.0


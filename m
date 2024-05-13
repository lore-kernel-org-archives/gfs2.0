Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D9E7489
	for <gfs2@lists.linux.dev>; Mon, 13 May 2024 20:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715631428; cv=none; b=Atz6O7Bwf6SEHRUXPZBnVVsIpNUvJh9DerBDfXk4jWuEBB1G9X7lZqslxJp/ZdFlTi1VZlIgEPovzZH44/QsMY72Fk8V6ev1YTaSz/c+sLjh50Vff7m5rZMk7wuPwAmiw/ByAbG1j1mQM3Rq1n2d8rmgyZCtVZk3NBYO1Gdqg1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715631428; c=relaxed/simple;
	bh=tBSYnu5biyde4hqLVYn3ls3kd9uKB5Ztz4K0820Afa4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H0cn6spJ8iVmJAsvEoW7R90J1GdfFEAwqxafFJ/7NhsUjJ9MQ7yBIRd5BnH1gjSYUCuQAkGEqayFqma2c7d17VukU/8ySK8bZQtkW+8gM1SdmNra4JVyuBsLcLcV8PeGI6he8KUQXgUirjZqQwDSbc92krPcZBj1hTmACv7Lc30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BMGjICpt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMGjICpt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715631425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=zazRLk250icH6gao5umBljLSGbvI08NgBOyVu2Bgi7M=;
	b=BMGjICpt/DA4f1pifu2aay+NSwiF5fWw7+/8DQSC98SWxXDImT8/nzzvg3UPdMoMju2DAy
	8K+UyUGPtWRCVwk39Rsz/ihX29nCdFUCBTtYuxCiB1QOhHVu68YAbxM0ErJ+Inv8nc6FSp
	tAb6umPE1igU5wbytFwROiI+LtEk2Yc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-eCfgjyoWMsWAI1KVm28ZjQ-1; Mon,
 13 May 2024 16:17:04 -0400
X-MC-Unique: eCfgjyoWMsWAI1KVm28ZjQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A53213C025D3;
	Mon, 13 May 2024 20:17:03 +0000 (UTC)
Received: from redhat.com (unknown [10.22.32.125])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 62AD5C15BB9;
	Mon, 13 May 2024 20:17:03 +0000 (UTC)
Date: Mon, 13 May 2024 15:17:01 -0500
From: David Teigland <teigland@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Subject: [GIT PULL] dlm updates for 6.10
Message-ID: <ZkJ1PTW7V25ePbLF@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Hi Linus,

Please pull dlm updates from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.10

This set includes some small fixes, and some big internal changes:

- Fix a long standing race between the unlock callback for the last lkb
struct, and removing the rsb that became unused after the final unlock.
This could lead different nodes to inconsistent info about the rsb master
node.

- Remove unnecessary refcounting on callback structs, returning to the way
things were done in the past.

- Do message processing in softirq context.  This allows dlm messages to
be cleared more quickly and efficiently, reducing long lists of incomplete
requests.  A future change to run callbacks directly from this context
will make this more effective.

- The softirq message processing involved a number of patches changing
mutexes to spinlocks and rwlocks, and a fair amount of code re-org in
preparation.

- Use an rhashtable for rsb structs, rather than our old internal hash
table implementation.  This also required some re-org of lists and locks
preparation for the change.

- Drop the dlm_scand kthread, and use timers to clear unused rsb structs.
Scanning all rsb's periodically was a lot of wasted work.

- Fix recent regression in logic for copying LVB data in user space lock
requests.

Thanks,
Dave


Alexander Aring (32):
      dlm: fix user space lock decision to copy lvb
      dlm: remove lkb from callback tracepoints
      dlm: remove callback queue debugfs functionality
      dlm: save callback debug info earlier
      dlm: combine switch case fail and default statements
      dlm: fix race between final callback and remove
      dlm: remove callback reference counting
      dlm: remove allocation parameter in msg allocation
      dlm: switch to GFP_ATOMIC in dlm allocations
      dlm: move root_list functionality to recover.c
      dlm: use a new list for recovery of master rsb names
      dlm: move rsb root_list to ls_recover() stack
      dlm: add new struct to save position in dlm_copy_master_names
      dlm: drop mutex use in waiters recovery
      dlm: convert ls_waiters_mutex to spinlock
      dlm: convert res_lock to spinlock
      dlm: avoid blocking receive at the end of recovery
      dlm: convert ls_recv_active from rw_semaphore to rwlock
      dlm: remove schedule in receive path
      dlm: use spin_lock_bh for message processing
      dlm: do message processing in softirq context
      dlm: increment ls_count for dlm_scand
      dlm: change to single hashtable lock
      dlm: merge toss and keep hash table lists into one list
      dlm: add rsb lists for iteration
      dlm: switch to use rhashtable for rsbs
      dlm: do not use ref counts for rsb in the toss state
      dlm: drop dlm_scand kthread and use timers
      dlm: use rwlock for rsb hash table
      dlm: use rwlock for lkbidr
      dlm: fix sleep in atomic context
      dlm: return -ENOMEM if ls_recover_buf fails

Kunwu Chan (2):
      dlm: Simplify the allocation of slab caches in dlm_midcomms_cache_create
      dlm: Simplify the allocation of slab caches in dlm_lowcomms_msg_cache_create


 fs/dlm/ast.c               |  216 ++++-----
 fs/dlm/ast.h               |   13 +-
 fs/dlm/config.c            |    8 +
 fs/dlm/config.h            |    2 +
 fs/dlm/debug_fs.c          |  323 +++-----------
 fs/dlm/dir.c               |  157 +++++--
 fs/dlm/dir.h               |    3 +-
 fs/dlm/dlm_internal.h      |  129 +++---
 fs/dlm/lock.c              | 1068 +++++++++++++++++++++++++-------------------
 fs/dlm/lock.h              |   12 +-
 fs/dlm/lockspace.c         |  212 +++------
 fs/dlm/lowcomms.c          |   62 +--
 fs/dlm/lowcomms.h          |    5 +-
 fs/dlm/member.c            |   25 +-
 fs/dlm/memory.c            |   18 +-
 fs/dlm/memory.h            |    4 +-
 fs/dlm/midcomms.c          |   67 ++-
 fs/dlm/midcomms.h          |    3 +-
 fs/dlm/rcom.c              |   33 +-
 fs/dlm/recover.c           |  149 ++----
 fs/dlm/recover.h           |   10 +-
 fs/dlm/recoverd.c          |  142 ++++--
 fs/dlm/requestqueue.c      |   43 +-
 fs/dlm/user.c              |  135 ++----
 include/trace/events/dlm.h |   46 +-
 25 files changed, 1379 insertions(+), 1506 deletions(-)


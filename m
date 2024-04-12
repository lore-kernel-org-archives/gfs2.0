Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECFD1DFD9
	for <gfs2@lists.linux.dev>; Fri, 12 Apr 2024 13:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929407; cv=none; b=CgApCJ6wMIG7BQsz61rm2qiDhKMw0GKXNuuPyDCEhNHVAbo/Q8QJfoyM9rtwcZ7iCGx/FGdWLUw14kNaFfw74353YskXivU+R46w5Qnh5F8VsuVyYfHYTskhNtbfdc2/0e9fwBL1eEJdYMeBJ/BynYi0QUTm8bWne1NEsZqFEwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929407; c=relaxed/simple;
	bh=lXPkYaEftiYFyypcpO1aNqXyWswTeC5T5Rbf/wIdQG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IhAGFz/MNY7V0HlInilCqPAJ/SrzGP2EZFxYBN1nd2e7naNkRVvQUB+GZoSYw9iplvJ7diMJRYgrGjDs5c4O3s+Cr3nRVqZzS57DoG29p0G0yWAcpzt65uKE8lEtDmRPS/xCNakIJJtsMf5ogHhQbn62mpUGnR2bMJavhNIQdfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YaG6R4wm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YaG6R4wm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712929404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Hf216IyDgJiUM1znjTFAxCdQnGZoqVGj15QiBnuq4X4=;
	b=YaG6R4wmQvmu0We5aPJ7zcy/lF2pwKtzW7UDVFhTq/eaRzlqHYc7pAsoLTjTDMMHlXWm3y
	fMoydRGyJDEvtao8xfOqNtWVUtn8JYa5E551Dg2aG9t3RhvrufVhXustAP4omEkhannf9R
	Ax1v4zprCz671z9ix6VaNe8e75ISL6o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-8icFsq46MmWs1LTaVa9rMA-1; Fri, 12 Apr 2024 09:43:23 -0400
X-MC-Unique: 8icFsq46MmWs1LTaVa9rMA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B046881E62
	for <gfs2@lists.linux.dev>; Fri, 12 Apr 2024 13:43:23 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 438C92166B31;
	Fri, 12 Apr 2024 13:43:23 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next 0/9] dlm: sand fix, rhashtable, timers and lookup hotpath speedup
Date: Fri, 12 Apr 2024 09:43:05 -0400
Message-ID: <20240412134314.173067-1-aahringo@redhat.com>
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

this is a patch series for an immense change in DLM rsb hashtable logic.
It removes the double lookup functionality for rsb hashtables, convert to
rhashtable instead of own bucket hlist hash implementation.

At first there is a fix for scand that I detected while I was
implementing this patch series. It could be that remove messages are
still send when the lockspace is releasing the resource that could occur
into a use after free.

There is a conversion to use lists (keep/toss lists) instead of
iterating over the hash bucket. As we do a transition to rhashtable,
they don't like to being iterated regarding to their own bucket sizing
implementation that is sitting in the rhashtable implementation. We just
introduce the lists to do the iteration, as advantage we have a huge
reduce of code in the debugfs dump functionality as we use the dump list
helpers of debugfs. There is also a potential refcount bug when holding
rsb references of rsbs in toss state as receive remove message requires
no rsb references being hold. Another issue is also holding rsb in keep
state as they are not going into toss state when they required to.

It is now forbidden to hold references of rsbs in toss state. The
refcounter must be only functional in rsb keep state. That hopefully
will show is more invalid usage of the rsb refcounter if the rsb is in
toss state.

The scand was being fixed but now also it's removed. The scand process
was holding the hashtable/hash bucket lock for a longer timer because it
iterated over the whole hash. We use timers now to reduce the held time
of the hashtable lock. We introduce a per lockspace toss queue with tossed
timer rsb and the first item is the earliest rsb that will be expired by
the timer vice versa the last item. This makes it easy to change the
timer expiration to the next one in the queue.

The last two patches we move very likely lookup hotpath to read lock
mostly. This should for sure avoid contention in the most cases. Unlikely
path need to still hold the write lock and do some extra relookup and check
if the state of an rsb changed. However I think we hit over 90% the likely
path that we only need to hold the read lock and avoid contention between
processing DLM messages and the user triggers new DLM requests.

- Alex

changes since v2:
 - hold the write_lock in find_rsb_dir/nodir when hitting the do_toss
   path and then do the lookup and check on the do_toss rsb fields
 - move from a per rsb timer to a per lockspace timer and introduce
   a per rsb toss queue.

Alexander Aring (9):
  dlm: increment ls_count on find_ls_to_scan()
  dlm: change to non per bucket hashtable lock
  dlm: merge toss and keep hash into one
  dlm: fix avoid rsb hold during debugfs dump
  dlm: switch to use rhashtable for rsbs
  dlm: remove refcounting if rsb is on toss
  dlm: drop scand kthread and use timers
  dlm: likely read lock path for rsb lookup
  dlm: convert lkbidr to rwlock

 fs/dlm/config.c       |   8 +
 fs/dlm/config.h       |   2 +
 fs/dlm/debug_fs.c     | 212 ++---------
 fs/dlm/dir.c          |  14 +-
 fs/dlm/dlm_internal.h |  40 +-
 fs/dlm/lock.c         | 836 +++++++++++++++++++++++-------------------
 fs/dlm/lock.h         |   4 +-
 fs/dlm/lockspace.c    | 151 ++------
 fs/dlm/member.c       |   2 +
 fs/dlm/recover.c      |  29 +-
 fs/dlm/recoverd.c     |  54 +--
 11 files changed, 615 insertions(+), 737 deletions(-)

-- 
2.43.0


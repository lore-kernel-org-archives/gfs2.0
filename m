Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE131649D3
	for <gfs2@lists.linux.dev>; Wed, 10 Apr 2024 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756953; cv=none; b=GjOAhQFKYpS+MB2QOsQI0AIf85JwS2IjOKCUVpGstfSPzQ0B9QHkeGEeM7KjLfPhAD2kfLbcGmtWUXtTM3d4ly1jfX/llrMHC/36NlZqQEJToD4LdPQfbw7Y7wfyvz007ryxrG2Me9UHDBs/wCopCd5v3o2KI7375d7qXrgIK0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756953; c=relaxed/simple;
	bh=XyhyMiTz/V7bK49AbI9BpDgfGt4mhk+RXt/NRVtSKX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KfXMVnBBJ3HE7QIIxOAbdz74U4Vk8YxM+S3t3mw0eUvY6l64H6hgvYcM+7o1vc9AY9O3c7tjuga5Er9FFEOAbjTjznVZEH/lQnJq6/E7H8MMKouwPycyID2Nj4CgVSvcEwwQP3EjeeV/QzSCzBIYo54/eqintT1sl1z9lpVfsvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BKXCuvdD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKXCuvdD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712756950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=natD32SMD1SxmfoiGToxoiKoETqLjYl+hL/lBdNbapQ=;
	b=BKXCuvdDffUXLy+IPaYYf7mM8N+rM5pL4wmoevpdqbz7S26mX/F5RBD+iRKjpadvp8UpRx
	ESUkada5aMkO2LUikxp/lR/EpqtnW9SHTJebRLD0O90wO3KAZfMS0hxG1o63Gff2QxBeql
	v7Q+wZEhTZPw2qLtvr9NrX3YvnVP8vI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-Hgb8vosfPkWL8FdeaNMvDw-1; Wed, 10 Apr 2024 09:49:08 -0400
X-MC-Unique: Hgb8vosfPkWL8FdeaNMvDw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8224B1049BD3
	for <gfs2@lists.linux.dev>; Wed, 10 Apr 2024 13:49:08 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7685AC0157E;
	Wed, 10 Apr 2024 13:49:08 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [RFC dlm/next 0/9] dlm: sand fix, rhashtable, timers and lookup hotpath speedup
Date: Wed, 10 Apr 2024 09:48:49 -0400
Message-ID: <20240410134858.3295266-1-aahringo@redhat.com>
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

Hi,

this is a RFC for an immense change in DLM rsb hashtable logic. It
removes the double lookup functionality for rsb hashtables, convert to
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
of the hashtable lock. We take here the advantage of the timers
data structure that the rsb timer will delete the rsb itself from the
hash. No lookup required as this is part of the timer subsystem.

As end we move very likely lookup hotpath to read lock mostly. This
should for sure avoid contention in the most cases. Unlikely path need
to still hold the write lock and do some extra relookup and check if the
state of an rsb changed. However I think we hit over 90% the likely path
that we only need to hold the read lock and avoid contention between
processing DLM messages and the user triggers new DLM requests.

- Alex

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
 fs/dlm/debug_fs.c     | 212 ++----------
 fs/dlm/dir.c          |  14 +-
 fs/dlm/dlm_internal.h |  39 +--
 fs/dlm/lock.c         | 774 ++++++++++++++++++++++--------------------
 fs/dlm/lock.h         |   3 +-
 fs/dlm/lockspace.c    | 151 ++------
 fs/dlm/recover.c      |  38 ++-
 fs/dlm/recoverd.c     |  40 +--
 10 files changed, 541 insertions(+), 740 deletions(-)

-- 
2.43.0


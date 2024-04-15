Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F7141C66
	for <gfs2@lists.linux.dev>; Mon, 15 Apr 2024 18:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713206389; cv=none; b=l1j7MRjgodQooHPw4VZ4gg3JIAvBBSdzZB+Ec1qgkogTHzaLubjb0ViNOyOulCqT8AajO2VoT9ChXmCdwPwvff7PIXEnxdnNnUaxT3Y/+61F5nIFYRGdZ3FVNVEBc3WOhLQXRBtdsPqfCy7gdth//GhsVDVtUCuy05EvFypkrps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713206389; c=relaxed/simple;
	bh=azu3eQksBJ0VstAtYL5eLhwB8EPPigJl0tIh+Il9u8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OIgcZo846WPjW6vpJIzv2l9REUxqlyss4LXUJQnnAxaCeUoStNnUrNoAiF+ncAhBKMGSvLKUc6fkAIPPu2jcDLcQFgM3QnkzquaKwiPybpGhkZ82Q/Qq8x9Fr8age7K5+P9CxzlhKyM7j3xPpN3iswR7Uunkvg0bMUwGYUiGSg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Osyux82y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Osyux82y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713206386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LZWoCwaJ6VOvY5+V+G6Z4P5pFYwFp3M2UQDWRi9nHAk=;
	b=Osyux82y3epM4BK7y5pjiMJ2OTlRRg14PsMvKy/KH4QddpP2VniktCyq3TxP62mGlGg+mx
	B5ovtRf1YOmvjCHz8dbIpMU2e7mKlXdhw2IN5v3Ch9HbSTw990yyhSaknZlmGk8rDX8d4M
	VF0SKCGqf95blVM3zSoXPAxNnjMXmk8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-sUNBYF5nPUOkrPYBrDUZZg-1; Mon,
 15 Apr 2024 14:39:45 -0400
X-MC-Unique: sUNBYF5nPUOkrPYBrDUZZg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF4BF3C02183
	for <gfs2@lists.linux.dev>; Mon, 15 Apr 2024 18:39:44 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A85CEC01594;
	Mon, 15 Apr 2024 18:39:44 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv2 dlm/next 0/9] dlm: sand fix, rhashtable, timers and lookup hotpath speedup
Date: Mon, 15 Apr 2024 14:39:34 -0400
Message-ID: <20240415183943.645497-1-aahringo@redhat.com>
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

this is a patch series for an immense change in DLM rsb hashtable logic.
It removes the double lookup functionality for rsb hashtables, convert
to rhashtable instead of own bucket hlist hash implementation.

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
of the hashtable lock. We introduce a per lockspace toss queue with
tossed timer rsb and the first item is the earliest rsb that will be
expired by the timer vice versa the last item. This makes it easy to
change the timer expiration to the next one in the queue.

The last two patches we move very likely lookup hotpath to read lock
mostly. This should for sure avoid contention in the most cases.
Unlikely path need to still hold the write lock and do some extra
relookup and check if the state of an rsb changed. However I think we
hit over 90% the likely path that we only need to hold the read lock
and avoid contention between processing DLM messages and the user
triggers new DLM requests.

- Alex

changes since v2:
 - introduce dlm_timer_resume() and call it in between LSFL_RUNNING
   and ls_in_recovery lock. Comment this function and some rare cases
   that it is only a "try" resume.
 - comment more why holding ls_rsbtbl_lock lock in timer and correct
   the retry comment in case of timer hit contention. It is only a
   "try" as well, as others can set new timer expirations.

changes since RFC:
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
 fs/dlm/lock.c         | 867 ++++++++++++++++++++++++------------------
 fs/dlm/lock.h         |   5 +-
 fs/dlm/lockspace.c    | 151 ++------
 fs/dlm/member.c       |   2 +
 fs/dlm/recover.c      |  29 +-
 fs/dlm/recoverd.c     |  50 +--
 11 files changed, 643 insertions(+), 737 deletions(-)

-- 
2.43.0


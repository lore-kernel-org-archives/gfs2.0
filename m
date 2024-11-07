Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B18194C92
	for <gfs2@lists.linux.dev>; Thu,  7 Nov 2024 20:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731012386; cv=none; b=pEkNc570vBYDv1QQCFT3X4BbNzkmGm6rf+EXB/MZRnN3/rbN2H2786PrbmPvwHETPY21ABcBg55xZqOBRHEGSPTGodDr4CKyn3C8ud1rMyfpusS8ZnXjGOhujY0UBt1IC3R5FAdZUQzgHaQ+F11cD+MzCwww8BlnMoOnOuR076w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731012386; c=relaxed/simple;
	bh=SSFcvEdD4WJkyJ8iSkV6hIJqVWyfs1YlUIw1ozkv7F8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=feK4eBSN/EHSD6nK1A4uemfJqI3g1kOKaZFotRe1kE0xOxL0+xX+VjdU8TiAeivK4QJZqpDCtySpDbdAFoc92XJxvsz3DihQWcVE53dV8tjScLiuaNs7Cq9AJh/z7T3bB9IwE35cImYIsg4vBwVP9IKAmPAoBZHTgnxSEIcPg2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KrWRx980; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KrWRx980"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731012383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JIcG7PDhrutlw7oRhvJBeM7HY+XJqJL8oFhKaY2FeNk=;
	b=KrWRx980+HGbGZwqh4C/HCi+8V3gnvB6Wlr/E+V9cLkPCmzYPkiFj4cmYDJdGpSOlw5Jm4
	9U9WA+22OXvfjU9tqc8LNvqG54zfRkfNN7/Kvxi/yfVdOfSaBWS8QYlLISHmUUkPiVq6ey
	E4ouDMNP/5l7ZIcvrjgg/6tpD6XvPY8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-QZwd1fyLMwyOWZA6sbQhxA-1; Thu,
 07 Nov 2024 15:46:22 -0500
X-MC-Unique: QZwd1fyLMwyOWZA6sbQhxA-1
X-Mimecast-MFC-AGG-ID: QZwd1fyLMwyOWZA6sbQhxA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 519B71956077
	for <gfs2@lists.linux.dev>; Thu,  7 Nov 2024 20:46:21 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9AEF030001A0;
	Thu,  7 Nov 2024 20:46:20 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [RFC dlm/next 00/11] dlm: approach for new lkb reference counting
Date: Thu,  7 Nov 2024 15:46:06 -0500
Message-ID: <20241107204617.147842-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3bQW8Ack96wQ8ITZMsN7LxRr9zyWn_YhSjIYMv3YnwA_1731012381
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Hi,

this is a new approach to change the lkb refcounting model. The current
handling requires to assume that certain return values happen or not,
especially for _request_lock() function. However we do it and sometimes
don't do it (which requires that certain return values cannot happen).
That makes a big headache because we also need to consider recovery
handling and state changes inbetween.

The new approach is very tight to the ast handling and in my opinion
more robust to not fail, because we would notice earlier if a ast
callback will not happen. The lkb lifetime has different states request,
convert and unlock. Each of them has different meanings according the
ast callback result value and the current lkb lifetime state, e.g. a
-EAGAIN on a request will end the lkb lifetime but not on a convert.

Now we require that even master copy call queue_cast() but don't
schedule a callback for the user as they are not operating on DLM API
user requests. We can now even drop a lot of return value for DLM lock
requests that are also called for internal lock request by e.g. recovery
as we don't need to evaluate the return value for a potential put(),
this is now done on queue_cast().

We also can now check on sanity that requests, converts, cancel/unlock
happens on the right lkb lifetime state, e.g. a request cannot happen
after a convert or a convert cannot happen after an unlock.

- Alex

Alexander Aring (11):
  dlm: remove set_master() negative return check
  dlm: use move_lkb() instead del/add lkb
  dlm: use hold_lkb() instead kref_get()
  dlm: don't track references on move_lkb()
  dlm: drop lkb hold for waiter conversion handling
  dlm: track reference for lkb_rsb_lookup
  dlm: call queue_cast() on master copy as well
  dlm: make send dlm message as non-failure
  dlm: introduce new lkb refcount model
  dlm: void convert, cancel and unlock requests
  dlm: return void for _request_lock function

 fs/dlm/dlm_internal.h |  13 ++
 fs/dlm/lock.c         | 522 ++++++++++++++++++++++--------------------
 fs/dlm/lock.h         |   4 +-
 fs/dlm/user.c         |   5 +-
 4 files changed, 290 insertions(+), 254 deletions(-)

-- 
2.43.0


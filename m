Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E0F4085D
	for <gfs2@lists.linux.dev>; Fri,  8 Mar 2024 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709914708; cv=none; b=p/Hg1CxRCI9JnNfQVNXtcO2tqJf4uloYdSM63Rf3tTzIJ5502TkIyFvWc6chvxlVRYeRllv20ZfHXjsG8hDfBSJIJ9OR/V7n62NEGpYUhdit8swgLdNmFT+2RhWalEFwkXXUmTkfxJ40HBZIPSve94HwwwXj4Oa4nESODXOd9Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709914708; c=relaxed/simple;
	bh=1MYVTJCpGiDWM4LyECR2oPaO2/A251l43BBhYvKI8NU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gpoYJ3MBMsWF53xqBcs+iyYUh/nPxGGqF78fhkLqBPYFO8bY8R9P5cJsM06XyQZIAfCVHVUjasTF4C/1kIbGXX0lgfxbG9yKSpYl0OU+50QRD1qMkwowLQPuD7z0YkibXZbcSp+GfvFD7iLi+qD6mnwLgOEuzvk45ErLXLja/JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bFuN6F+X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFuN6F+X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709914704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BEcVUTWWMXcLRMCvRWTiiWQKTxOP31koHafGqo2YNuk=;
	b=bFuN6F+XMLfEwSMGKLW5oPM8EbJKwEdS5bN6EfXXrFhh4belhJkYUrDNoDAeElWouCk5xO
	PdTsERE83DlJK5nxrZ3KgUmMZHsSJKwNy420AsPLWHtpwTcsvNy8HkgvNKkJiUm15J8IfK
	nAsEL+QoxIVJVi1uWpGAv0kUXuKq70k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-eW1qKSRNOb60AIS58GrYBA-1; Fri, 08 Mar 2024 11:18:23 -0500
X-MC-Unique: eW1qKSRNOb60AIS58GrYBA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D24128007AF
	for <gfs2@lists.linux.dev>; Fri,  8 Mar 2024 16:18:22 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.fast.eng.rdu2.dc.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C96DB492BD5;
	Fri,  8 Mar 2024 16:18:22 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [RFC v6.8-rc6 0/7] dlm: fix race between callback and remove message
Date: Fri,  8 Mar 2024 11:18:11 -0500
Message-ID: <20240308161818.2388451-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Hi,

this patch fixes some race I hit between the last callback from a lkb
and a potential remove message if this callback was not delivered yet.
The issue has something todo that we held in some situation the lkb
reference which we should not. There are also some other places affected
(e.g. debugfs dump) that I am also working on to solve them. I tried to
split my work in several patches to reduce the amount of changes in the
fix of patch "dlm: fix race between final callback and remove".

I also found a issue with the lvb copy for user space locks I introduced
that should be fixed, see "dlm: fix user space lock decision to copy
lvb".

- Alex

Alexander Aring (7):
  dlm: fix user space lock decision to copy lvb
  dlm: remove lkb from ast bast tracepoints
  dlm: remove callback queue debugfs functionality
  dlm: move lkb debug information out of callback
  dlm: combine switch case fail and default statements
  dlm: fix race between final callback and remove
  dlm: remove callback reference counting

 fs/dlm/ast.c               | 203 +++++++++++++++----------------------
 fs/dlm/ast.h               |  13 +--
 fs/dlm/debug_fs.c          |  98 +-----------------
 fs/dlm/dlm_internal.h      |  66 +++++++-----
 fs/dlm/lock.c              |  24 ++---
 fs/dlm/memory.c            |   4 -
 fs/dlm/user.c              | 107 +++++--------------
 include/trace/events/dlm.h |  46 ++++-----
 8 files changed, 182 insertions(+), 379 deletions(-)

-- 
2.43.0


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6870313C8F3
	for <gfs2@lists.linux.dev>; Mon,  3 Jun 2024 21:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717451775; cv=none; b=K7rt3bciBwl72FwhFFkb51JouX73B43zKMLrXC0qVTRp3ey9saQ5qTN8L/Y9/BdT9niBjLArZZ4TDfn2QVjmZpDqyNcYo7ZaS5YfWhx8SGWOKWaTR3w8dq7nNx3sE7WAjOTqVTgM3/Dp8j7wTiNaWABAnNoLQ630R1FrEkdegbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717451775; c=relaxed/simple;
	bh=esCrcK1hL/w/ZiludLoyUUUfautnucmQqQN+Usu1e00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vDtdvQfzqmSamdeQ6jy7NkDGEGJaRSKxb9Oe9GGgDM/aJpurJfJEu4GnIqzuVArAsD69U4X8D4BWq4IgQfGEC4cougf576FM3XSiOoN9u+xC1nE2QALnUIOgUusU/RVPLsTDOTo4DVkm3zGBrQItMr/6DL51Jq3PpV6T3oAcnbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BFMSLs8M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BFMSLs8M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717451772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8JDzwe/yCUGojkan1XT5FIDGF0tkQFafvqD1IvJ0UmI=;
	b=BFMSLs8MCNtaLvkldACT+fd9PeQBq1bqp8IstRSKV6RUUQ7Hs+nmEONO/6vdsPxf1xko2T
	QUeA3XTumh/r47jtXuSBZWpCRp0HPd0pBnvdQxdggxYag7RnvvWm/rHYDjRLCkbgZgQVEW
	ZYJ9JG8uriVibUl9DBJro5Ny/K53B54=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-Pj6O3KEhO8entYKk8qn7EA-1; Mon,
 03 Jun 2024 17:56:08 -0400
X-MC-Unique: Pj6O3KEhO8entYKk8qn7EA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9139929AA382;
	Mon,  3 Jun 2024 21:56:08 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3993A200E4A1;
	Mon,  3 Jun 2024 21:56:08 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	song@kernel.org,
	yukuai3@huawei.com,
	linux-raid@vger.kernel.org,
	aahringo@redhat.com
Subject: [PATCH dlm/next 0/8] dlm: md: introduce DLM_LSFL_SOFTIRQ_SAFE
Date: Mon,  3 Jun 2024 17:55:50 -0400
Message-ID: <20240603215558.2722969-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Hi,

the first three patches are resend with an updated commit message and
additional comment e.g. to explain the rcu_read_lock() handling to
avoid a lookup twice.

The main part are the rest of the patches introducing the
DLM_LSFL_SOFTIRQ_SAFE flag to signal that ast/bast callbacks can be
handled in softirq context. md-cluster is the first user here to take
advantage about this flag as their callback handling is simple enough
and looks okay to be called from softirq context. To be honest, I also
just need a upstream user for the new flag. Other users, e.g. gfs2 can
take also advantage of it.

I also gave it a try with a debug kernel and used md-cluster with 2 block
devices and level mirrored. I used gfs2 on top of it and it seems to run
without any problems.

This patch series is based on:

https://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git/log/?h=next

in case of md-cluster people want to try it out.

Thanks.

- Alex

Alexander Aring (8):
  dlm: using rcu to avoid rsb lookup again
  dlm: remove struct field with the same meaning
  dlm: use is_master() on checks if we are the master
  dlm: use LSFL_FS to check if it's a kernel lockspace
  dlm: introduce DLM_LSFL_SOFTIRQ_SAFE
  dlm: implement LSFL_SOFTIRQ_SAFE
  dlm: convert ls_cb_lock to rwlock
  md-cluster: use DLM_LSFL_SOFTIRQ for dlm_new_lockspace()

 drivers/md/md-cluster.c  |   2 +-
 fs/dlm/ast.c             | 185 ++++++++++++++++++---------
 fs/dlm/ast.h             |  11 +-
 fs/dlm/debug_fs.c        |  33 ++---
 fs/dlm/dlm_internal.h    |  40 +++++-
 fs/dlm/lock.c            | 268 +++++++++++++++++++++++----------------
 fs/dlm/lock.h            |   5 +-
 fs/dlm/lockspace.c       |  23 ++--
 fs/dlm/memory.c          |  15 ++-
 fs/dlm/rcom.c            |   4 +-
 fs/dlm/recover.c         |  20 +--
 fs/dlm/recoverd.c        |   2 +-
 fs/dlm/user.c            |  38 +++---
 include/linux/dlm.h      |  17 ++-
 include/uapi/linux/dlm.h |   2 +
 15 files changed, 413 insertions(+), 252 deletions(-)

-- 
2.43.0


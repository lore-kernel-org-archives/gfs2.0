Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39107181BA1
	for <gfs2@lists.linux.dev>; Wed, 10 Apr 2024 21:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712784504; cv=none; b=tRDGGZ6kOsDuYFO1gfE4gJM1yPNunaiuGKKIlTktDfsctP0N4WXAEPL9YRx9tlHIJct4sJtbQLd6ZJFkhPCj9Sm8MI10VCUil8uwiUi8rmEGJUDsGP/hnHVgeCfRYHfoiluavxVCcRVE6ghY44L1XgEylDWbH8AvI3TVecmYJ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712784504; c=relaxed/simple;
	bh=+IFVBcjS4CYV8HygziDUhjTYHZ/j9uX/lE6WvzviaVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H5thDGasatibV2HrXNpW9T1cdRHn7gtY21/tm1ns20t5UOWsRGQoOKKXVQ9G8vsCdUzCaxhCZsodglvnH7AFqgtWBF0BMk829UqTKVsWC+9FhiRqhAGr5Q9q3PlCi3XDcjRwRqAA3OiHJ2qCZg63uF/lKZD8ukFQCkM6HZgJZ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gkogssqy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gkogssqy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712784501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KpWxCXD6uNPMd0xFj6PxHhvNnQhPcqjfETLVz/YKrrk=;
	b=GkogssqyvbYTv82aBVp5JZ3RFm1+tALTqFTZGCIwo4ZG4M8eXhCMtHN1mZ6qbscPQ0f0Bs
	JtRubtEaiv1v7D0ukt1tD+kLe8u7MaPX0q6SyhZZqbMQx6KOBv+WtZrBxyiMI0yxkbdjhm
	SY5MzHCONUmEFNZ1oNLnno2UbGok4MM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-Fyaf8xOBO6eks1g87GcQ_g-1; Wed, 10 Apr 2024 17:28:19 -0400
X-MC-Unique: Fyaf8xOBO6eks1g87GcQ_g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6DFF018047B8
	for <gfs2@lists.linux.dev>; Wed, 10 Apr 2024 21:28:19 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.28])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E8A1E444FE6;
	Wed, 10 Apr 2024 21:28:18 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 0/3] gfs2: Fix potential glock use-after-free on unmount
Date: Wed, 10 Apr 2024 23:28:10 +0200
Message-ID: <20240410212814.204819-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

On top of what we already have on for-next, here are three more patches.

gfs2: Remove ill-placed consistency check

  Removes a consistency check that isn't needed anymore and only
  gets in the way of the next patch.

gfs2: Fix potential glock use-after-free on unmount

  Prevent DLM bast callbacks from accessing glock objects after they
  have been freed.

gfs2: Unlock fewer glocks on unmount

  We can be a little more aggressive in avoiding to unlock DLM
  locks immediately before the lockspace is released.

Thanks,
Andreas

Andreas Gruenbacher (3):
  gfs2: Remove ill-placed consistency check
  gfs2: Fix potential glock use-after-free on unmount
  gfs2: Unlock fewer glocks on unmount

 fs/gfs2/glock.c      | 32 ++++++++++++++++++++++++++++----
 fs/gfs2/glock.h      |  2 ++
 fs/gfs2/incore.h     |  1 +
 fs/gfs2/lock_dlm.c   | 40 +++++++++++++++++++++++++++++-----------
 fs/gfs2/ops_fstype.c |  1 +
 fs/gfs2/super.c      |  1 +
 6 files changed, 62 insertions(+), 15 deletions(-)

-- 
2.44.0


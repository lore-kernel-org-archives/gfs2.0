Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252F51D5AD5
	for <gfs2@lists.linux.dev>; Wed, 25 Sep 2024 22:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727301818; cv=none; b=dOPlat6Qg6EC2j/CuUYgbntSXS56aaR5TF9oUk7gKDpn9iEomoEKPaCbDBfHMisZUl2FDEc876SSakddXixIDmNrLBTpEhE5A8qm9SLpM2CCIp8/hPeqfu3pWMmLZUbEsG7BcHLO2lHK4vYBPiifv1+h851Iwva33XiQaGkah/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727301818; c=relaxed/simple;
	bh=nnbbktvuKErj+3xy+97nAIZMSc81uhBC24lW+xKuoG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RHrmCkKC0BB036x3A/E60+baCzsiZ0Y9oDIeiHiXHRu9kuSCXPNxjfZ4bv3m66I+qKCbHq+SqmAnWWEReVE2HzVj5YYt/CorwQjhCp/RJlqurWSai8viczeZMxz2/ZpxJIGWMwJoUYpNp4OTXWvsKdObsmUYXp9a34DGN198Tqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DuzN5+0o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DuzN5+0o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727301816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GGdkG7lseYARJ/IdrO2yEYYL8C8o4kmVIRGdAnLurrs=;
	b=DuzN5+0oWR2Jn6wSTR9dwJ6Jmt1HQ/t2xoNf7FqEJTdLCcyiUH6Y/pwQ6CRUNHMI64azqp
	B0tjHhJ54yYQGR/9rqpj0HHJyoQfE7QVoHm3vWpigWqD3bBbUj5gzQIl2vXs4Fs8gkdr46
	Y5nAnMhrBGja+iZVn2AUhGvN5GtTVoA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-32-EtvfgpIfPBu1zZlVb23-Og-1; Wed,
 25 Sep 2024 18:03:35 -0400
X-MC-Unique: EtvfgpIfPBu1zZlVb23-Og-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 37B9F1933E97
	for <gfs2@lists.linux.dev>; Wed, 25 Sep 2024 22:03:34 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.77])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3D3F019560AA;
	Wed, 25 Sep 2024 22:03:32 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 00/16] gfs2: unlinked inodes
Date: Thu, 26 Sep 2024 00:03:10 +0200
Message-ID: <20240925220331.417856-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

We have recently run into cases where unlinked inodes end up
accumulating.  This should only happen as a result of cluster node
failures, and those unlinked inodes should be cleaned up during
allocations.  Sometimes, for some reason, neiter happened.

In turns out that this is mainly due to a bug in commit f0e56edc2ec7
("gfs2: Split the two kinds of glock "delete" work"); see patch "gfs2:
Fix unlinked inode cleanup".

While going through the relevant parts of the code, I noticed a number
of additional minor problems which this patch set addresses as well.

Any thoughts?

Thanks,
Andreas

Andreas Gruenbacher (16):
  gfs2: Rename GLF_VERIFY_EVICT to GLF_VERIFY_DELETE
  gfs2: Initialize gl_no_formal_ino earlier
  gfs2: Allow immediate GLF_VERIFY_DELETE work
  gfs2: Fix unlinked inode cleanup
  gfs2: Faster gfs2_upgrade_iopen_glock wakeups
  gfs2: Rename GIF_{DEFERRED -> DEFER}_DELETE
  gfs2: Rename dinode_demise to evict_behavior
  gfs2: Return enum evict_behavior from gfs2_upgrade_iopen_glock
  gfs2: Minor delete_work_func cleanup
  gfs2: Clean up delete work processing
  gfs2: Call gfs2_queue_verify_delete from gfs2_evict_inode
  gfs2: Update to the evict / remote delete documentation
  gfs2: Use mod_delayed_work in gfs2_queue_try_to_evict
  gfs2: Randomize GLF_VERIFY_DELETE work delay
  gfs2: Use get_random_u32 in gfs2_orlov_skip
  gfs2: Make gfs2_inode_refresh static

 fs/gfs2/glock.c  | 100 ++++++++++++++++-------------------------------
 fs/gfs2/glock.h  |   7 ++++
 fs/gfs2/glops.c  |  11 +++++-
 fs/gfs2/incore.h |   4 +-
 fs/gfs2/inode.c  |   1 +
 fs/gfs2/inode.h  |   2 -
 fs/gfs2/rgrp.c   |   6 +--
 fs/gfs2/super.c  |  76 +++++++++++++++++++++--------------
 8 files changed, 101 insertions(+), 106 deletions(-)

-- 
2.46.0


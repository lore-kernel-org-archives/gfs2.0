Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610FE35290
	for <gfs2@lists.linux.dev>; Fri,  5 Jan 2024 18:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0d1Kj8t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704478523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=QvHu1WxRZCom7MmmCTV+UE5PhDDVfgSfK+5FzpCH9x0=;
	b=b0d1Kj8tVAdCoHl3G6VBPt51R4Q+A0hN8KYYCFY6Bipa8DlikgniveBVd/5WLLG/TjVdrB
	PrnGW6BagD/CpVNdrhVldrh4qsKi72eqoJtqPjw8G8GV0EutyJDDkm7lJB6y4cbLXsC1CJ
	3pBmx1JLb0+Suv4/Yu8N1PyPJet2vv4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-byPHD80sNZSlcgJBGzKmvQ-1; Fri,
 05 Jan 2024 13:15:22 -0500
X-MC-Unique: byPHD80sNZSlcgJBGzKmvQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 986621C05148;
	Fri,  5 Jan 2024 18:15:21 +0000 (UTC)
Received: from redhat.com (unknown [10.22.32.151])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 58F3D492BE6;
	Fri,  5 Jan 2024 18:15:21 +0000 (UTC)
Date: Fri, 5 Jan 2024 12:15:19 -0600
From: David Teigland <teigland@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: gfs2@lists.linux.dev
Subject: [GIT PULL] dlm updates for 6.8
Message-ID: <ZZhHN6iFihBSlsZ7@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull dlm updates from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.8

This set cleans up the interface between nfs lockd and dlm, which
is handling nfs file locking for gfs2 and ocfs2. Very basic lockd
functionality is fixed, in which the fl owner was using the lockd
pid instead of the owner value from nfs.

Thanks,
Dave


Alexander Aring (5):
      dlm: use fl_owner from lockd
      dlm: use FL_SLEEP to determine blocking vs non-blocking
      dlm: implement EXPORT_OP_ASYNC_LOCK
      dlm: fix format seq ops type 4
      dlm: update format header reflect current format

Jordan Rife (1):
      dlm: use kernel_connect() and kernel_bind()


 fs/dlm/debug_fs.c |  6 +++---
 fs/dlm/lowcomms.c | 14 +++++++-------
 fs/dlm/plock.c    | 20 +++++---------------
 fs/gfs2/export.c  |  1 +
 fs/ocfs2/export.c |  1 +
 5 files changed, 17 insertions(+), 25 deletions(-)


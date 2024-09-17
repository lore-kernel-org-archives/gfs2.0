Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1041517BEB4
	for <gfs2@lists.linux.dev>; Tue, 17 Sep 2024 17:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726592763; cv=none; b=R2sjWYQ2tRemR2bseqxTdV14Dblvj4iNbMnfnCu2RqaYCQXBYUe6+n1vB7tOiDDHutroKKaB4bUZqE4mx1HHTiq9mIZfSVe2CkwlnZGnLGGGXfP1M7ezezS+CZkeOJfZ2tlrGuDYxpQg35ckLMtff4zWACL6aYm0VVIZ1AP1MEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726592763; c=relaxed/simple;
	bh=yofaqTlpDkZ3rM8UqrkeWaXbUIPcYHKzv6DpVeMdtJw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NPPllnjlFVYAXw6N4Di0otWY4NTuk+CgbiYUZuYhPN2j00oaZS8ZpNAEHP/B8DUE7jdlLIEuzxya0XOfYJmjADx/PZpO1eCPkKtGiJ7KOSCHOKyCKHltVfcXRu6RtoQose7FfN1OL9ocBHD5bMxigWELOSOXHObZgTqesqVvhSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RN/MOw5w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RN/MOw5w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726592761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=GcaVjrRqk5FeRsN7VHgUJ2H6ojvGJU2nwJ6HohGK7ao=;
	b=RN/MOw5wnPNHBg6yc8dxi4LqvOmLibfnlZqXSI/hBn7bQ6kO/4ycQM5nD8DnXhnq+wJuOG
	Emwv/7aBGnUGFun6/s8WbZ+n0kgvsOsUJyYBe0PcYDHsq4j5li8GQ6kYOEJ6BeWZVvI1wa
	5D62w5z/14RQbaKCjp9DJkK5ieILNWs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-Zco_hSZBNKiFAW6Zfmncpw-1; Tue,
 17 Sep 2024 13:05:57 -0400
X-MC-Unique: Zco_hSZBNKiFAW6Zfmncpw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 298E51955F45;
	Tue, 17 Sep 2024 17:05:55 +0000 (UTC)
Received: from redhat.com (unknown [10.22.9.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ACBF719560AA;
	Tue, 17 Sep 2024 17:05:53 +0000 (UTC)
Date: Tue, 17 Sep 2024 12:05:50 -0500
From: David Teigland <teigland@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Subject: [GIT PULL] dlm updates for 6.12
Message-ID: <Zum2QP7hS1mDzqBT@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Linus,

Please pull dlm updates from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.12

Summary:

- Remove some unnecesary hold/unhold rsb refcounting
  in cases where an existing refcount is known to exist.
- Remove some unnecessary checking for zero nodeids, which
  should never exist, and add some warning if they do.
- Make the slow freeing of structs in release_lockspace()
  async, run from a workqueue.
- Prior rcu freeing allows some further struct lookups to
  run without a lock.
- Use blocking kernel_connect on sockets to avoid EINPROGRESS.

Thanks,
Dave


Alexander Aring (11):
      dlm: cleanup memory allocation helpers
      dlm: remove unnecessary refcounts
      dlm: never return invalid nodeid by dlm_our_nodeid()
      dlm: warn about invalid nodeid comparsions
      dlm: drop kobject release callback handling
      dlm: async freeing of lockspace resources
      dlm: use RSB_HASHED to avoid lookup twice
      dlm: move dlm_search_rsb_tree() out of lock
      dlm: move lkb xarray lookup out of lock
      dlm: do synchronized socket connect call
      dlm: add missing -ENOMEM if alloc_workqueue() fails


 fs/dlm/config.c       |   2 +-
 fs/dlm/dlm_internal.h |   5 ++
 fs/dlm/lock.c         | 134 +++++++++++++++++++++++++++-----------------------
 fs/dlm/lock.h         |   2 +
 fs/dlm/lockspace.c    |  97 ++++++++++++++++++------------------
 fs/dlm/lowcomms.c     |  36 +-------------
 fs/dlm/main.c         |  12 +++++
 fs/dlm/member.c       |   2 +
 fs/dlm/memory.c       |  28 +++++------
 fs/dlm/memory.h       |   4 +-
 fs/dlm/recover.c      |   9 ++--
 11 files changed, 164 insertions(+), 167 deletions(-)


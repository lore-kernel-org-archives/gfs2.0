Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E01A3921E3
	for <gfs2@lists.linux.dev>; Tue, 13 Jan 2026 13:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312293; cv=none; b=lgB3bCh7Gg1RTiuTTwzjyH3ogT/tbnQKLukQIF6NqC8IkS1s4vqvpPXKtXEILI4DP7m5soIZAvzegC0ktvlKGdYa3kgjVI5k+GKNG3W2PBG9qFL16PqXAHU6o9HKjomkSbnVXVjkC+axwSQ5TrMVJr0ABdHV9G6YGt/WLZiyUjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312293; c=relaxed/simple;
	bh=DF2PlcSwUbdqr4rEzvqYDSjDo2WlCVqQlaLK4Ivdm9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PJPSPXfuMDFgNJNgxEdHadx1BzWfJOuR5QjpWu80Ph33DrdeCZPKvAxCryR+UZgWlbX0hD60DofgpNEBw0OAyBzR4wRCG6NrjaOtdzelHmQknk5hRTrYAqo6wVoSrS4mTsgIJp+D29N+jCftpDvH87dow0538m6UG0mWDsOmdeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hqGcJw2Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hqGcJw2Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768312290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u20qw0X+uwjkj6nu8N7LO9JrXSGlXKViHZoJcloq74E=;
	b=hqGcJw2ZHgY0AUZwrjq/5Ux8oSeq3aqrZof5ihsrk4XCjIGKDpoZqe+WOEr2nqrdnm+Uzu
	dR58VJaiGZLoSad2tjKus0VxAe+2rlrFjE8ZIJLAZ/PHuHSHNIaSunIwhsSGcSQAbDAUm7
	B9pSoZwTvrnvNR4R92gAKEEy59o93nE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-0Dei3ylZNEiouwsTyh9biw-1; Tue,
 13 Jan 2026 08:51:28 -0500
X-MC-Unique: 0Dei3ylZNEiouwsTyh9biw-1
X-Mimecast-MFC-AGG-ID: 0Dei3ylZNEiouwsTyh9biw_1768312286
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 30FE2195609F;
	Tue, 13 Jan 2026 13:51:26 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.227])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 741BD180049F;
	Tue, 13 Jan 2026 13:51:24 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [GIT PULL] gfs2 revert for 6.19-rc6
Date: Tue, 13 Jan 2026 14:51:22 +0100
Message-ID: <20260113135123.282418-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Dear Linus,

please consider pulling the following gfs2 revert for 6.19-rc6.

I was originally assuming that there must be a bug in gfs2 because gfs2 chains
bios in the opposite direction of what bio_chain_and_submit() expects.  It
turns out that the bio chains are set up in "reverse direction" intentionally
so that the first bio's bi_end_io callback is invoked rather than the last
bio's callback.

We want the first bio's callback invoked for the following reason: The initial
bio starts page aligned and covers one or more pages.  When it terminates at a
non-page-aligned offset, subsequent bios are added to handle the remaining
portion of the final page.  Upon completion of the bio chain, all affected
pages need to be be marked as read, and only the first bio references all of
these pages.

Thanks,
Andreas

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-6.19-rc6

for you to fetch changes up to 469d71512d135907bf5ea0972dfab8c420f57848:

  Revert "gfs2: Fix use of bio_chain" (2026-01-12 14:58:32 +0100)

----------------------------------------------------------------
gfs2 revert

- Revert bad commit "gfs2: Fix use of bio_chain"

----------------------------------------------------------------
Andreas Gruenbacher (1):
      Revert "gfs2: Fix use of bio_chain"

 fs/gfs2/lops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


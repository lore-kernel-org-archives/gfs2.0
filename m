Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06E2364D6
	for <gfs2@lists.linux.dev>; Mon, 20 Jan 2025 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737395577; cv=none; b=I3lguXO+QO2ofJsvfMPcuSzO4/MF+Zo2QDuyM3PYR5Wbu2PXudmXkQGOC4enWO/W4Yz5Klqf1MBMFvZMO2kLAmS1wGCTd7GY4G5sdVJwV4f8Lk8lv2qqzeCJ3q7vmm8iktfHZ+qN474UUDeQQdoAwG6OfE4ELumDDrqM2jBBRZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737395577; c=relaxed/simple;
	bh=de4yHsj4fXnu/7g5hWvnD0m1YAz2+bF3fXGD7ItDdsY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qvd/i3tXvTAakV2PB23NCmoTpwIsuDzUaJzLoARQODauA+QFMYxXzKwHeSHDyPT3c0SaVRzLAwBhs5SA2qrqmXbG2ofqV59sxim+mjRTY2nwLYxIFgtn08AhrH7JjAFQnRF9gejcdRJb8aRomJImqieorRb1m55dHaAg0ZZ4mqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BshEQttI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BshEQttI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737395574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=lWOz4O6HEiD1SLC18Ey/Q/KBQnNiYnEtKJWaXrDaq+c=;
	b=BshEQttIKSAMu4V+nyQsjII1Ei0c5TU5737B+aTWJPl1FTDWqeEMCRy5XG/i4suiZxmNNB
	7zJP6eZB2JwkEtvsPPM0FZlW0+QeOsbmturAAqD2gx3UTvM6p7bjO9+jWfO/r29Q2HPb+T
	l2fWz9cc2jGW4xNnaGnjeO1S9ZgWSdE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-Ii8A1n-EMB-dZpFdMIQrCQ-1; Mon,
 20 Jan 2025 12:52:53 -0500
X-MC-Unique: Ii8A1n-EMB-dZpFdMIQrCQ-1
X-Mimecast-MFC-AGG-ID: Ii8A1n-EMB-dZpFdMIQrCQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 050B319560AF;
	Mon, 20 Jan 2025 17:52:52 +0000 (UTC)
Received: from redhat.com (unknown [10.22.88.9])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 37EFB19560A3;
	Mon, 20 Jan 2025 17:52:50 +0000 (UTC)
Date: Mon, 20 Jan 2025 11:52:48 -0600
From: David Teigland <teigland@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Subject: [GIT PULL] dlm updates for 6.14
Message-ID: <Z46NcGZHZAfkgKF2@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Linus,

Please pull dlm updates from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.14

A small set of patches this time:
- Fix a case where the new scanning code missed removing an unused rsb.
- Fix the error when removing a configfs entry for an invalid node id.

Thanks,
Dave


Alexander Aring (3):
      dlm: fix removal of rsb struct that is master and dir record
      dlm: fix srcu_read_lock() return type to int
      dlm: return -ENOENT if no comm was found


 fs/dlm/config.c   |  2 +-
 fs/dlm/lock.c     | 46 ++++++++++++++++++++++++++++++----------------
 fs/dlm/lowcomms.c |  3 ++-
 3 files changed, 33 insertions(+), 18 deletions(-)


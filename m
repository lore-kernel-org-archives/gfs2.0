Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB54A1E0DFE
	for <gfs2@lists.linux.dev>; Mon, 20 Jan 2025 14:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737382436; cv=none; b=NNlLxkY4lsH+0vCTuR34jhny8JVhwzvhp1zS+DcheMGOcR5tTDilAVx0MRlHFnQ6Ad7nfZBiRbJ25KJVdPSo941tL/Uc4ktUmN7zBiq9DISMNCPtdKwWa2HSOBEhBWE5qHt5Hrg8fK+7z98CJt76W/VfH9cCpmS1hSBCSCqPe7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737382436; c=relaxed/simple;
	bh=uh0Dm/o4ptleFn9IluNcD5fGaECKzi24GrmnJC6trI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aKUCD+JFdYRQ/JxaTU3eMrYqQm4wuZkQ/H5xIHBdGwwXypGDY7qLyTWMKz9X3S8qCTlphPnZe6EOljvdNdz9+ISkMoHD0oFpaLDRXl586HkK5mpA6PwLaJZe1XX/GekRCT+BfxtZciud44dR0BZQZY+5f3pvIOyVJtKLx+8UP4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ToTyjRZE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ToTyjRZE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737382433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/vGVrsEp92iFzoxMVjNfOcndPVhAzET1D6bxkf1x60g=;
	b=ToTyjRZE6Iz00opsI0EvhWQ5dQk7PwVMzcv67L4F0P7gFshJOVxjH3+OEA8dJF63Q9woU4
	8A1VUBt2TSQIXAN6CDesx2sXZiM/2ccN0FPxrwYBA1Mgm7ILUv+La5hZiht/5tsJg5Rffo
	NhN7ZSV/E+uPkDBrwmvDYDmPj/9KTyc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-b-A2NXaYP0iOYIdrcFvgeg-1; Mon,
 20 Jan 2025 09:13:50 -0500
X-MC-Unique: b-A2NXaYP0iOYIdrcFvgeg-1
X-Mimecast-MFC-AGG-ID: b-A2NXaYP0iOYIdrcFvgeg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2D621955D5E;
	Mon, 20 Jan 2025 14:13:47 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.39.192.60])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 13BB23003E7F;
	Mon, 20 Jan 2025 14:13:45 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 changes for 6.14
Date: Mon, 20 Jan 2025 15:13:43 +0100
Message-ID: <20250120141344.2017385-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Dear Linus,

please consider pulling the following gfs2 changes.

Thanks,
Andreas

The following changes since commit ff2a7a064a69069554564f52b6a84fc8a8c7d688:

  Merge tag 'gfs2-for-6.13' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2 (2024-11-26 12:34:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-6.14

for you to fetch changes up to 7c9d9223802fbed4dee1ae301661bf346964c9d2:

  gfs2: Truncate address space when flipping GFS2_DIF_JDATA flag (2025-01-14 18:54:08 +0100)

----------------------------------------------------------------
gfs2 changes

- In the quota code, to avoid spurious audit messages, don't call
  capable() when quotas are off.

- When changing the 'j' flag of an inode, truncate the inode address
  space to avoid mixing "buffer head" and "iomap" pages.

----------------------------------------------------------------
Andreas Gruenbacher (1):
      gfs2: Truncate address space when flipping GFS2_DIF_JDATA flag

Christian Göttsche (1):
      gfs2: reorder capability check last

 fs/gfs2/file.c  | 1 +
 fs/gfs2/quota.h | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)


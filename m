Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905D55475D
	for <gfs2@lists.linux.dev>; Mon, 25 Mar 2024 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711368632; cv=none; b=dVkusw131Npz5xZ1DPJ8WMdPoUVOGrElEt3i0zYMHPB6ZFupxmPB0/2/SEujsJG76KQz6HzYKHzg72n9VRr7HkUq7At9jnFTQkIclAu2ugz/LLh9Z7Z7Ir8e6KMdS80A2GNCP6A6TcbHU+g8x5UwGQIe8H6vAD875MQWVcd5JGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711368632; c=relaxed/simple;
	bh=K71KdlxYZsiIMFj5o/hNwVsIU+3ZrPbx4L7G25LkjLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q4xcT73gLTNDERKbQhqozGoqUdI3Nx1EOz0tI8ysy4ecdgTB4RMWpWiORGrYFGgjxumoH5qfZ4RvmDHtJipQmZNZOW8fh7zpPxWjDyNyCAvba8+pY8tQFrYLgHRlofjoWaIHCrsutFXc5+KOVlUDYWjVrK08VtGn/dbKomQ8pXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AgBlIYtW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AgBlIYtW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711368629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LN0ZWoyXU4SKqZ/oMmr2x3t+IqeauNxfkUGdiuWye84=;
	b=AgBlIYtW1cNvBqGU96+zAnfKPXa54gwvV+7+kqgUWNLpaogFawZ6/xlMnGd0nNjbjG8U57
	zGk5UcaV0/84zY9Z/TH3/P9y5OCajz5juLdLprWYAmGS4klY+ZmMLKTMlbSt4SJ5bWiOy5
	DkRLs+H2LBDRhXEyV11aSP1Prlms1JI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-1HWGQpVFOIWVJFIIuZ5MEQ-1; Mon,
 25 Mar 2024 08:10:26 -0400
X-MC-Unique: 1HWGQpVFOIWVJFIIuZ5MEQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C156A1C07F39;
	Mon, 25 Mar 2024 12:10:25 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.7])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 077E4492BF5;
	Mon, 25 Mar 2024 12:10:24 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 fix
Date: Mon, 25 Mar 2024 13:10:16 +0100
Message-ID: <20240325121020.337540-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Hello Linus,

please consider pulling the following gfs2 fix.

Thank you very much,
Andreas

The following changes since commit e8f897f4afef0031fe618a8e94127a0934896aba:

  Linux 6.8 (2024-03-10 13:38:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.8-fix

for you to fetch changes up to c95346ac918c5badf51b9a7ac58a26d3bd5bb224:

  gfs2: Fix invalid metadata access in punch_hole (2024-03-11 17:11:18 +0100)

----------------------------------------------------------------
gfs2 fix

- Fix boundary check in punch_hole

----------------------------------------------------------------
Andrew Price (1):
      gfs2: Fix invalid metadata access in punch_hole

 fs/gfs2/bmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


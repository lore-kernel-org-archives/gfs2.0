Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8342D8DD0
	for <gfs2@lists.linux.dev>; Fri, 26 Jun 2026 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782486046; cv=none; b=ZTJNCqxCXSGROPxqcRGU09A9UFp4aDCX0zrwL/TnvwB9AG7ve2Id2WcUCWsfM24xn+7lNoBjSBteRqNvqaHuvep9/xoBxZoC800nj/pDo4++qpLwxZUJqtDrLI4Gko6Hk02Uh6BYeddyaWqCcoNGswHqdBVouvtmnio37qEEjxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782486046; c=relaxed/simple;
	bh=30ajGh8sJdeuat3T6pCfGC28aHCbENL/AjFNaWiEVqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=dBvBFo1zIi52HgJcmuNeUWf8RQgQqvl1iH+VceG24O278epZYroAzNfeh2XCatLAr3Uk2JecM4cE9umJtPPRWpU8/lKh1sFoChKGvm7RgTzL7bLfC8zCvjnmg8QzDXxn9W9Otls3hYYLm2WxhHmRixwHkEmhGEh2DXlDopRvwfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bV7f2IXk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bV7f2IXk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782486040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VugLsd/tFF7En6hDoHh8TJUTrIBZ4z2xzimjx5j3+eY=;
	b=bV7f2IXkU60aMPIA6Or2Mnpk1ZlDPno3HFJ6RJ3M2gZ7kMFGLDJybd9Zf8ljvlbzTI+caL
	77eLCovPbGiqRvHz8oJtmfxCzcsxT+mFx28PARn4b58XWjrXXyGONEtiipJWLjRC30Krf6
	kn95hmGBYgbNrgzlMBC8T4pbpMDZlEs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-vMSEy5BnNkmWqCepZ0RfdQ-1; Fri,
 26 Jun 2026 11:00:37 -0400
X-MC-Unique: vMSEy5BnNkmWqCepZ0RfdQ-1
X-Mimecast-MFC-AGG-ID: vMSEy5BnNkmWqCepZ0RfdQ_1782486036
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 32CFF1800846;
	Fri, 26 Jun 2026 15:00:36 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.15])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A82C7180057F;
	Fri, 26 Jun 2026 15:00:34 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 changes for 7.2
Date: Fri, 26 Jun 2026 17:00:32 +0200
Message-ID: <20260626150033.568188-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: ptP93ec73RxSXqwOaFYZrRhm09kFdf2XoOVjyKInO2s_1782486036
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Dear Linus,

please consider pulling the following gfs2 fixes for 7.2.  And sorry for the
rather late request.

Thanks,
Andreas

The following changes since commit 4da0dd95be3b0321bf9687fb1a3c2fed3319c032:

  Merge tag 'gfs2-for-7.1' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2 (2026-04-15 19:12:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-7.2

for you to fetch changes up to 4982e58669b11c43644efb5fb7435975848b716e:

  gfs2: page poisoning fix (2026-05-29 11:11:40 +0200)

----------------------------------------------------------------
gfs2 fixes

- page poisoning not handled correctly when growing files.

- quota initialization / destroction fixes: sleeping under a bitlock in
  PREEMPT_RT, broken quota_init error recovery, missing RCU synchronization.

----------------------------------------------------------------
Andreas Gruenbacher (2):
      gfs2: Remove unused fallocate_chunk argument
      gfs2: page poisoning fix

Jie Wang (2):
      gfs2: fix quota init duplicate scan
      gfs2: move quota_init qc iterator increment

Tristan Madani (1):
      gfs2: fix use-after-free in gfs2_qd_dealloc

 fs/gfs2/bmap.c  | 19 +++++++++++++++++++
 fs/gfs2/bmap.h  |  1 +
 fs/gfs2/file.c  | 15 ++++++++++++---
 fs/gfs2/quota.c | 36 ++++++++++++++++++++++++------------
 fs/gfs2/super.c |  1 +
 5 files changed, 57 insertions(+), 15 deletions(-)


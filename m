Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169F3155A25
	for <gfs2@lists.linux.dev>; Mon, 29 Sep 2025 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759156879; cv=none; b=kKYSRnoeSsJEPYp4Ui5xYXPHOgEb3NTQdhTJXWOqUmfxjtBocMcxgOmXBskAOtU94ZEzt/tTOcOR94iUTGYZCWMsai+5DSE01O8buyoyR3itwXJy824LIqVjcgtxaHrqHgrBsPnJ8fBWGoB9O0kGEa/1wLrVnJOdZt6nEtpHLtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759156879; c=relaxed/simple;
	bh=pAnQQOOIXd2ZwElnUic41CLFzwzbOlUl4FANGhxifLY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q/pa/h3uYGk3YGLpry/K0ukelF3/UJU84KCIrlT6g3AQO6FGyBbtRD3TPn3hPqztjFg977Gzs6GwbePfkCOdopDFFgxUoVJ3NIUmeSTtva0BaFns64FSWNfwGi6WCLUB2ST9OcizItqcpofM/MnntTmNkUye9QdRtXi/Y+nw0CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MltLxlny; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MltLxlny"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759156877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=c04heTAl7RQxQsGulCNruMJ6K3Bkn34DaECM68w9sbM=;
	b=MltLxlnyKJCo4B5RBS590PpDKgRnOnjTdar6S51LPsjLEcJFOiSmEZQG4hCfzuKdk/oemf
	Mzvro6neKnhqYB+TJGddjENU0BMn9mJKnpBNZCdJpQhnkJm3+Qkl7dSN1BNw2aBkAjEcsD
	skXN0ODsCWpwPcJVTl6Zbcc54PbMhBY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-o79F5H0TN6u_LRapffCU2A-1; Mon,
 29 Sep 2025 10:41:12 -0400
X-MC-Unique: o79F5H0TN6u_LRapffCU2A-1
X-Mimecast-MFC-AGG-ID: o79F5H0TN6u_LRapffCU2A_1759156871
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5292318002C2;
	Mon, 29 Sep 2025 14:41:11 +0000 (UTC)
Received: from redhat.com (unknown [10.22.81.226])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D7531800576;
	Mon, 29 Sep 2025 14:41:10 +0000 (UTC)
Date: Mon, 29 Sep 2025 09:41:07 -0500
From: David Teigland <teigland@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Subject: [GIT PULL] dlm updates for 6.18
Message-ID: <aNqag0RIXLcG5BH3@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Linus,

Please pull dlm updates from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.18

This set of patches add a dlm_release_lockspace() flag to request that
node-failure recovery be performed for the node leaving the lockspace.
The implementation of this flag requires coordination with userland
clustering components.  It's been requested for use by GFS2.

Thanks,
Dave

Alexander Aring (9):
      dlm: check for defined force value in dlm_lockspace_release
      dlm: use defines for force values in dlm_release_lockspace
      dlm: add new RELEASE_RECOVER uevent attribute for release_lockspace
      dlm: add new configfs entry release_recover for lockspace members
      dlm: add new flag DLM_RELEASE_RECOVER for dlm_lockspace_release
      dlm: handle invalid lockspace member remove
      dlm: move to rinfo for all middle conversion cases
      dlm: handle release_option as unsigned
      dlm: check for undefined release_option values

 drivers/md/md-cluster.c |  4 ++--
 fs/dlm/config.c         | 64 +++++++++++++++++++++++++++++++++++++++++++++++--
 fs/dlm/config.h         |  2 ++
 fs/dlm/lock.c           |  2 +-
 fs/dlm/lockspace.c      | 46 +++++++++++++++++++----------------
 fs/dlm/member.c         | 27 ++++++++++++++++-----
 fs/dlm/recover.c        |  2 +-
 fs/dlm/user.c           |  6 ++---
 fs/gfs2/lock_dlm.c      |  4 ++--
 fs/ocfs2/stack_user.c   |  2 +-
 include/linux/dlm.h     | 33 ++++++++++++++++++++++++-
 11 files changed, 153 insertions(+), 39 deletions(-)


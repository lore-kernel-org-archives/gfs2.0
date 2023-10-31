Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB70E23A2
	for <gfs2@lists.linux.dev>; Tue, 31 Oct 2023 14:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KzS+p5lh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698763752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=9aEtKXQ2ieWW0wRcFfdhj4dIV7XtnWe7cnMjHfz2sxY=;
	b=KzS+p5lh0+Czb0sjZXBWhLLH63rA6hw3kQJpmUW2Pe9St7Hl1se4OEjIRaV05AROGEkpq/
	1oq/ailD/rEjAesZY21zB/3hTpsIJmG/QLOS2FxwMfSyIkAvFDjDc90IVPOl6oXLq3Hnww
	UFYn3pRCNAP1slR3yEE3Vl/w7yXxTa4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-aMrs5NGmPMaexpf5n0Fi8A-1; Tue, 31 Oct 2023 10:49:04 -0400
X-MC-Unique: aMrs5NGmPMaexpf5n0Fi8A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E633830966;
	Tue, 31 Oct 2023 14:49:02 +0000 (UTC)
Received: from redhat.com (unknown [10.22.17.253])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D4EA510F4C;
	Tue, 31 Oct 2023 14:49:01 +0000 (UTC)
Date: Tue, 31 Oct 2023 09:49:00 -0500
From: David Teigland <teigland@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Subject: [GIT PULL] dlm updates for 6.7
Message-ID: <ZUET3DN7wTih6rKm@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Hi Linus,

Please pull dlm updates from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.7

This set of patches has some minor fixes for message handling, some misc
cleanups, and updates the maintainers entry.

Thanks,
Dave


Alexander Aring (5):
      dlm: fix creating multiple node structures
      dlm: fix remove member after close call
      dlm: be sure we reset all nodes at forced shutdown
      dlm: fix no ack after final message
      dlm: slow down filling up processing queue

Christophe JAILLET (3):
      fs: dlm: Simplify buffer size computation in dlm_create_debug_file()
      fs: dlm: Fix the size of a buffer in dlm_create_debug_file()
      fs: dlm: Remove some useless memset()

David Teigland (1):
      MAINTAINERS: Update dlm maintainer and web page


 MAINTAINERS       |  4 ++--
 fs/dlm/debug_fs.c | 18 +++++++-----------
 fs/dlm/lowcomms.c | 12 ++++++++++++
 fs/dlm/midcomms.c | 39 ++++++++++++++++++++++++++++++++-------
 4 files changed, 53 insertions(+), 20 deletions(-)


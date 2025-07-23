Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF342F4334
	for <gfs2@lists.linux.dev>; Wed, 23 Jul 2025 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753284125; cv=none; b=bkzZQNNCkoSYzzlDD2Kb9Lb1WDeryuzdxR5edRltfPwunBL7EDrl6iKnfQoHYqc5N95lRR7joz4bfvb8gHd1GnEinnhRQL1+Lsj3kBoYkX6TalA4vQMr8odgRVxnrcxpZ0KNQZ+SgGsW72uGvsdGssO72XV31jmW3w/kQtnGD14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753284125; c=relaxed/simple;
	bh=HpkHYPtPNa7WlFRsjDdyAl/c/4PuMy+rXKm4Wpg7TeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=rdUO+GUybp5u0rWwtsddMsrCbJh6RqFJPk2IX3aD9/Cys9RR8JUeSiFeaO1kaL3i26IpKWuWmvdH3YFRnGSEkmipM4PJQmfQdRebXPj2DKurRP9uAbyZFg2E+xfyfJetHBcK79h1eQ01HR/BnWc0V6QRJjLjVYd2oKId/v61aE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Opnjn9fD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Opnjn9fD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753284122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j2eQz3qu0pfTcOnpcmigYWzNpFCN3e2jLC8Q4imXM+M=;
	b=Opnjn9fDjSONIyRzoUsPAi/maXsdC0ree6B/eg6suXKWiKph3p+17yRSAgGKJw4WCmUCkl
	rWmUoEIttqcrDcbkg7C2+fDqyNqm+8VfvSaJ3gCA8FYXQktE1Byy+C1nZW/Po8L19FhfF0
	u/d0cwGefrIhc/+UFyV/l62d9AEQZLE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-2wzKBpc3Mxe5_AgmXIzJlQ-1; Wed,
 23 Jul 2025 11:21:59 -0400
X-MC-Unique: 2wzKBpc3Mxe5_AgmXIzJlQ-1
X-Mimecast-MFC-AGG-ID: 2wzKBpc3Mxe5_AgmXIzJlQ_1753284119
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1689F195608E
	for <gfs2@lists.linux.dev>; Wed, 23 Jul 2025 15:21:59 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 23D28195608D;
	Wed, 23 Jul 2025 15:21:58 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: agruenba@redhat.com,
	gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH v6.16-rc7 0/5] dlm: dlm lockspace release option updates
Date: Wed, 23 Jul 2025 11:21:51 -0400
Message-ID: <20250723152156.2988833-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RRB67Ex8m8rXOR6fF8_CzJUeLKp5DL74JUwhabKxTvQ_1753284119
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Hi,

some cleanups for dlm_release_lockspace() updates to:
 - introduce defines for exisiting values
 - handle option for no event as 3 now to allow new values
 - add value 4 as request from gfs2 dlm user to handle nodes
   as their failing in case of a failing event that is DLM
   user specific in contrast to only handle them as the
   node failed in a DLM specific event which is node
   got fenced.

to forward the new DLM_RELEASE_RECOVER value to other nodes a
user space change is required which will be followed. Users should
be care that all cluster nodes can handle this in user space to
forward this value otherwise the feature does not work as intended.

Alexander Aring (5):
  dlm: check on unequal 3 to allow more values
  dlm: introduce release parameter defines
  dlm: add release recover attribute for leaving event
  dlm: add lockspace member configfs release_recover
  dlm: introduce DLM_RELEASE_RECOVER

 drivers/md/md-cluster.c |  4 +--
 fs/dlm/config.c         | 64 +++++++++++++++++++++++++++++++++++++++--
 fs/dlm/config.h         |  2 ++
 fs/dlm/lockspace.c      | 39 +++++++++++++------------
 fs/dlm/member.c         | 21 ++++++++++----
 fs/dlm/user.c           |  6 ++--
 fs/gfs2/lock_dlm.c      |  4 +--
 fs/ocfs2/stack_user.c   |  2 +-
 include/linux/dlm.h     | 31 +++++++++++++++++++-
 9 files changed, 138 insertions(+), 35 deletions(-)

-- 
2.43.0


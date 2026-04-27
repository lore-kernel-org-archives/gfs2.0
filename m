Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3663722A4FC
	for <gfs2@lists.linux.dev>; Mon, 27 Apr 2026 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777305586; cv=none; b=JCiIVLDRcqk0TePWCnYLu/mgNzdiIEZvHzXKOjrzVmoYRwlRLlpvyg9ZisHk1hFcC934pKIQeFMe/RymmLZuDiGPwJLvy04lmItyXPmNBP54M96iOpAg/91ro6qQpj75z48HCyiLIQVvD8quZybMkUD20kqIM7K6I95+Z7arkpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777305586; c=relaxed/simple;
	bh=YwXsMYDjBwBqS+PhBeDTqzfjgshPQ0qmYywqFSLsdRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=AXQWjXB/Vbq+OvNC4lRRjy9A4ldLcYXbVM2Xa4CVG4QfktlhjWgnMNAjGWFSv5DO+D5pmhnYTv+/TgfNNJ4ubj/GJCkPQ5xTRFKZ5Hzu88jm8STUYnK9SPiVT0ikyDzFqd99JNnYMzLZ5H/a8wTmfx2+RrVVPuGd1MIx2aVGGVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gio7awlA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gio7awlA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777305584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z0kVUmN4jVe+6ftwrEgsZeam8zv7oNL4IpsuZFAHPnY=;
	b=gio7awlASAXuglwA64Mv2UX71nF1G994erdqRdaDL2kFOtSDo9i6ml7EqGecCiBykg7hxX
	wqDpEFXJQPkEuP1nQiCA8P0wJYEWhIDOV+fENw+/ElUUTYj5cfW2htcKYIGCWatiFjPRMe
	oSNSSTymlTLoU8ms5cVf61CoIPErSlA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-eEI0T4YOM9y_NxEz3YGPxg-1; Mon,
 27 Apr 2026 11:59:42 -0400
X-MC-Unique: eEI0T4YOM9y_NxEz3YGPxg-1
X-Mimecast-MFC-AGG-ID: eEI0T4YOM9y_NxEz3YGPxg_1777305582
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E02B319560B5
	for <gfs2@lists.linux.dev>; Mon, 27 Apr 2026 15:59:41 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 623E7300070A;
	Mon, 27 Apr 2026 15:59:41 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH RESEND v7.1-rc1 0/4] dlm: pending DLM patches
Date: Mon, 27 Apr 2026 11:59:31 -0400
Message-ID: <20260427155935.2415989-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ov7xeg8QSx9deSolAf273u-c486yCpZxGvRuotXUMqk_1777305582
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Hi David,

here are the pending DLM patches for dlm/next.

- using srcu list iterations to be aligned with lockdep
- fixing an issue with hardened kernel and lvb bytearray
  in dlm_callback that is copied to user address space
- fixing an issue with concurrent DLM requests and the
  midcomms sendqueue is out of order that ends in ref
  counting issues
- cleanup midcomms node creation by moving debugfs
  assignment before adding it to the node hash to
  avoid issues that debugfs is not initialiazed if
  concurrent users iterate over the hash.

- Alex

Alexander Aring (2):
  dlm: fix add msg handle in send_queue ordered
  dlm: init per node debugfs before add to node hash

Li RongQing (1):
  dlm: use hlist_for_each_entry_srcu for SRCU protected lists

Ziyi Guo (1):
  dlm: add usercopy whitelist to dlm_cb cache

 fs/dlm/lowcomms.c | 12 ++++++++----
 fs/dlm/memory.c   |  4 +++-
 fs/dlm/midcomms.c | 21 +++++++++++++--------
 3 files changed, 24 insertions(+), 13 deletions(-)

-- 
2.43.0


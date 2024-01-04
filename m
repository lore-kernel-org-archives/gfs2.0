Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592491FB4
	for <gfs2@lists.linux.dev>; Thu,  4 Jan 2024 02:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6wpDEpx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704333964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wHPfjKFeq3//PcLAjMeBU6/MgmhXQu0OnKHIFZaf/z8=;
	b=a6wpDEpxDLyTXoKMCpAR4jdnurFeAAnK40GIlvr2ixW6GbAJsujf1odUnkHGQjQmYeVHgt
	6PLAYwSxIMoblomlKTXVf5bINDd0DmjKyKE5OvCdITU3RutRBNKgJ4BUZuVgIzGAOhnJC4
	oFdKYttT1V6rNwt+f7/OJSEAriQPKME=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-qijrFNWMO_i8yQxN6p_OBg-1; Wed, 03 Jan 2024 21:06:02 -0500
X-MC-Unique: qijrFNWMO_i8yQxN6p_OBg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D3D1101A551
	for <gfs2@lists.linux.dev>; Thu,  4 Jan 2024 02:06:02 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fast.eng.rdu2.dc.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 744DAC15968;
	Thu,  4 Jan 2024 02:06:02 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next 0/2] dlm: refcount fixes and improvements
Date: Wed,  3 Jan 2024 21:05:56 -0500
Message-Id: <20240104020558.2594636-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Hi,

those two patches contains a patch to fix a potential refcount issue in
DLM and improve the freeing of lkbs at lockspace release time. Now I can
use /proc/slabinfo to see if all lkbs, rsbs got freed up, before it was
not possible to do that because we was doing a "forced" free of all
datastructures and didn't respect the refcount programming logic.

I need to send v2 for the softirq patches, I will do that soon.

- Alex

Alexander Aring (2):
  dlm: fix off-by-one waiters refcount handling
  dlm: put lkbs instead of force free

 fs/dlm/lock.c      | 12 +++++++-----
 fs/dlm/lock.h      |  1 +
 fs/dlm/lockspace.c | 31 +++++++++++++++++++++----------
 3 files changed, 29 insertions(+), 15 deletions(-)

-- 
2.39.3


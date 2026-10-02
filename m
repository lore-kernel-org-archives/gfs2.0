Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D8E44F56B
	for <gfs2@lists.linux.dev>; Fri,  2 Oct 2026 21:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975500; cv=none; b=AgmP6X3o0VxwqR6H5lv3OXWSFQTeQh0ao/1+bWL4PDfzMoA9anAr7Rc5LB5Y6/00iMkqa1UfFCo+3oJzuVku6eZolRTGwhlNxZxmab3xvqh0gYiPxVLLaMP3APWYHTaaypzsBLKVUCL+6yxvEFKS7izFR4dU5G/U1QXli7hXPos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975500; c=relaxed/simple;
	bh=R6q9kOlWPmUneuBx+Ack+gwXP6llA4nSDat9pKzUAXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=kontFkp8f8oLwtAtpAKfP3wX7y3PpZZWMLP05GVhRa+J1A63L2EqxBh30vBz6z09C8tln32X76s6J2VXWsvkDRmFIhikfN9yMI9QX/LL8ZPqdt8bGajfsbX9eXexTiy2y8A/WD3wF0yClJHw8NWWbOdutVxfdeG+RUuBnsVGjCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YIV3YCCf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YIV3YCCf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790975495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DK1Jcg7nD1HDryhs5ROPvftO3GAmrhTUszOrrBMejBM=;
	b=YIV3YCCf6AIBSOxXePDccmw6ZxzfoEdQk/8wcUGY5csMJjv9SNINnnBy4ZtOFy2zPtLb+z
	62wkaD9bPTbFXHhKoyVxmvkMf2D3QNNQJycuGX90AmPsOFHNlzzkMdrfuxub2cv2Uw5P69
	HFPbytkyUKs2kgg37qOsDxQ/JXE4lqQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-eeWwkCFyOACMS0atJ7gxpA-1; Fri,
 02 Oct 2026 17:11:33 -0400
X-MC-Unique: eeWwkCFyOACMS0atJ7gxpA-1
X-Mimecast-MFC-AGG-ID: eeWwkCFyOACMS0atJ7gxpA_1790975493
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E91A218305F2
	for <gfs2@lists.linux.dev>; Fri,  2 Oct 2026 21:11:32 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6C8C21956042;
	Fri,  2 Oct 2026 21:11:32 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH RESEND dlm/next 0/3] dlm: pending patches
Date: Fri,  2 Oct 2026 17:11:27 -0400
Message-ID: <20261002211130.1573679-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hWkJPmrk1mvJDDqfpZ5n_xnpIfbF_c-LJNoO1vLoyZk_1790975493
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Hi David,

Those are the pending patches for DLM. More checks to caught an invalid
node weight calulcation for members array, fix typos and be more type
aligned with debugfs api and the return type of waiters_read().

- Alex

Dan Carpenter (1):
  dlm: clean up a type in waiters_read()

Hemanth Selam (1):
  dlm: fix typos in comments

Qing Ming (1):
  dlm: validate node weights before building member array

 fs/dlm/ast.c      |  2 +-
 fs/dlm/config.c   |  9 ++++++++-
 fs/dlm/debug_fs.c |  3 ++-
 fs/dlm/lock.c     |  2 +-
 fs/dlm/member.c   | 17 +++++++++++------
 5 files changed, 23 insertions(+), 10 deletions(-)

-- 
2.43.0


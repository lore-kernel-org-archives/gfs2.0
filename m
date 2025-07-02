Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2C32E03EC
	for <gfs2@lists.linux.dev>; Wed,  2 Jul 2025 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751469945; cv=none; b=my68lKh0y7BKFKv0j7Z8Y6lTRZwxRZwSPLMtDdkJkaLOCDQzzAUfX1cNVuZhhPSjdTzgZ3Kt3EjC76nWYXigXWvZtx/Qbg14KsqMZU+GcfqomSMSMI38toWBgveHP7F2vR/hBlAw+oItBQGoJy8TR+pYBXRfosBRpFIi5vGYhzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751469945; c=relaxed/simple;
	bh=C2IJao2Tnjg+i4piyln6L3mS9UHnN4VqKHjd8QXo6X8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=iwRkXEwNU1OKoup6B2Q72LELF/ifUbJTuYhdVA8Ul/3WuuXKdW72mDyfCwdwuV9OgAxH256q0ql+8sLBdBmpuDjxpuM7II1x7IC2nmoHu5Zvk7ahbvNFBlLLRlHOx0yNDhV6XvRgtPDvq68y0aVHNJcqJM2sAbiBhDVoy37soW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HCux4q4I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HCux4q4I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751469942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=05PXZoGBAaqtqYL5Wnzgl+dcn+PwX3dTBMMHvtZA7VM=;
	b=HCux4q4IKR9VhLO2S+ZOlNJ/Eelxxpq8pfiyl1kTAK+cKBy7C0PVFTGpC5dR9zyPi7c359
	oT19JUI+v0ZIzMqAUsR2QlT8Ulhm3BLfHv3v9Xv3JnJHAHAqtS8QtRCpiKJtR7myedN1BX
	9dF6Y/eTsi04ulvfZYzIrOdo909+3uA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-F3154nwoMWWlTooyWPJoxg-1; Wed,
 02 Jul 2025 11:25:41 -0400
X-MC-Unique: F3154nwoMWWlTooyWPJoxg-1
X-Mimecast-MFC-AGG-ID: F3154nwoMWWlTooyWPJoxg_1751469940
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 368101808993
	for <gfs2@lists.linux.dev>; Wed,  2 Jul 2025 15:25:40 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.210])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 243451956087;
	Wed,  2 Jul 2025 15:25:38 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 0/3] some minor glock improvements
Date: Wed,  2 Jul 2025 17:25:33 +0200
Message-ID: <20250702152537.21742-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0kROlKq-cDZ6O0DEiTE8weR_WERLEBxdQs9mZmDwgDc_1751469940
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Here are some minor glock improvements I came up with while trying to
figure out a customer problem in this area.  Please review.

Thanks,
Andreas

Andreas Gruenbacher (3):
  gfs2: sanitize the gdlm_ast -> finish_xmote interface
  gfs2: simplify finish_xmote
  gfs2: a minor finish_xmote cleanup

 fs/gfs2/glock.c    | 42 ++++++++++++++++++++----------------------
 fs/gfs2/glock.h    | 10 ++++++++++
 fs/gfs2/lock_dlm.c |  9 ++++++---
 3 files changed, 36 insertions(+), 25 deletions(-)

-- 
2.50.0


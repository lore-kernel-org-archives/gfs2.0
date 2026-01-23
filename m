Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9888821578D
	for <gfs2@lists.linux.dev>; Fri, 23 Jan 2026 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769182272; cv=none; b=Z7d2ijPaM1j2lhVDFE3uJpT7l02qxKW+C2A83Tvr5CIGw3WUWUKSO1yf1IFENG5OqQDF/s8yYstq5Mf4GGuZIqNNfIuynBKYz3DJBoGnRDkLO2ESf9cvO2sQ7rhPdR7wj3k0vgIyVeG7Ta+b3AQlX53zt8QsdY6Z3aGx6lcznQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769182272; c=relaxed/simple;
	bh=CmxaBJCcLZjd6Ff7jTP32f6W7DvZC0VDQ6ickrYG5Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SdD4olbzeA2JqI5HPumLXTXXVLImFXeN+M1fqnklIIezRq0EUNr9EpJbbr8v0n7dURCNgS46w7t32JKbglHe+0otnxRXX+ibx542Uzhh5jSJkuJsb5gdAOP9tajKXj9KwixLMt7/xiOTiEUjERp9Z6iydfINAxHKORnZcjnGGNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nuoe4Mb3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nuoe4Mb3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769182269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iVQ0dPLEA9eRguFB+Ejhs6Ckdi+gWVAv0iBcoLsc12Y=;
	b=Nuoe4Mb3O+qxOgGffh9OLZk/e8wBdP+7mGne4shYio291g0TeUEMRW4YjBRutQhCAsvXHq
	FbL2A7hr9b4KOpE62uTjeJGa//HAY6nBN1X+PjRP8p74mC0TAdHe2nA0QeTFpMy1UKyhel
	jWOgidFuXTPDXN8N+HRjmEVsEBuQBnI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-9sAoxMcEO0KSU8xdp9v27Q-1; Fri,
 23 Jan 2026 10:31:08 -0500
X-MC-Unique: 9sAoxMcEO0KSU8xdp9v27Q-1
X-Mimecast-MFC-AGG-ID: 9sAoxMcEO0KSU8xdp9v27Q_1769182267
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84CB919775AF
	for <gfs2@lists.linux.dev>; Fri, 23 Jan 2026 15:31:07 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.52])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9068530002D1;
	Fri, 23 Jan 2026 15:31:06 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 00/13] gfs2 patches on for-next
Date: Fri, 23 Jan 2026 16:30:50 +0100
Message-ID: <20260123153105.797382-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Nh8GVKzDRFrir1RL_jkmhErUIq9lj1nn8ZAmM3RgLTc_1769182267
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Dear all,

we currently have the following patches on for-next and queued up for
the next merge window.

Beyond that, I'm aware of the following patch from Guilherme Giácomo
Simões that still needs reviewing:

https://lore.kernel.org/all/20260120123339.70724-1-trintaeoitogc@gmail.com/

Thanks,
Andreas

Andreas Gruenbacher (13):
  gfs2: glock cancelation flag fix
  gfs2: Retries missing in gfs2_{rename,exchange}
  gfs2: run_queue cleanup
  gfs2: Do not cancel internal demote requests
  Revert "gfs2: Fix use of bio_chain"
  gfs2: Rename gfs2_log_submit_{bio -> write}
  gfs2: Initialize bio->bi_opf early
  gfs2: gfs2_chain_bio start sector fix
  gfs2: Fix gfs2_log_get_bio argument type
  gfs: Use fixed GL_GLOCK_MIN_HOLD time
  gfs2: gfs2_glock_hold cleanup
  gfs2: Introduce glock_{type,number,sbd} helpers
  gfs2: Fix slab-use-after-free in qd_put

 fs/gfs2/glock.c      | 190 +++++++++++++++++++++++++------------------
 fs/gfs2/glock.h      |   9 +-
 fs/gfs2/glops.c      |  34 ++++----
 fs/gfs2/incore.h     |  18 +++-
 fs/gfs2/inode.c      |  18 +++-
 fs/gfs2/lock_dlm.c   |  28 +++----
 fs/gfs2/log.c        |   7 +-
 fs/gfs2/lops.c       |  53 ++++++------
 fs/gfs2/lops.h       |   4 +-
 fs/gfs2/meta_io.c    |   6 +-
 fs/gfs2/meta_io.h    |   2 +-
 fs/gfs2/quota.c      |   5 +-
 fs/gfs2/rgrp.c       |   2 +-
 fs/gfs2/trace_gfs2.h |  50 ++++++------
 fs/gfs2/trans.c      |   4 +-
 15 files changed, 246 insertions(+), 184 deletions(-)

-- 
2.52.0


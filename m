Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4FF2550BB
	for <gfs2@lists.linux.dev>; Fri, 16 May 2025 21:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747432113; cv=none; b=F0DsdoqVcfdGb6dCT58wFUVDjEz/pyJcNKnnDm7sMx7DpZxd4NVETNycWsFafdxyprZn2ogkzgu6V0oPNpzPN3HH+9IOAMM7fKjEEJX3x02UFSe9MWGp/qu6nhhnQVViYzomY8EPibNg6VSWNJ1WDE8+k4FZ0fOnlbf48EjVkbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747432113; c=relaxed/simple;
	bh=ZlycO/wNywRhmAJnZLhhSmibiPmZLgE8QmuQYIJhrzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=n1k8XHoYfXdz84uhrMO7FyuJ3qEemLEsZyZNpC2puOEcBkdbcNoaqH5nLA534rJ/aOXjrcdV+iNwTny5tO353rf+iJuHaVGV4g/NKqKDSCWdub8wq35kzwe1ku6IJy72dif7ePyTHfqoHkofvyyWRymD47pQnFnWGPhyi4yj+bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hvhb7u/t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvhb7u/t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747432110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=60fl5t8T5/kO8AHbk8m4A1egApir73vA6OBnhvfq0Is=;
	b=hvhb7u/tmFNKnSed6Ze2EaqmP01+/gxZbmno8t16voduH4cPnEEmNn2iZaFpMXeCTM4Sdd
	v2oSPBAH+P69OiQYUhirLiCABR7SzzBUCEvleoV0zLQXu4T8soPh+Z83WYNYeu/f0v0tkP
	X7bq2dM0YdIfBDHidsDWfV9GEGskSOs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-opZkNNrINImrBjhJSlBsrg-1; Fri,
 16 May 2025 17:48:27 -0400
X-MC-Unique: opZkNNrINImrBjhJSlBsrg-1
X-Mimecast-MFC-AGG-ID: opZkNNrINImrBjhJSlBsrg_1747432106
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 386EE180035E;
	Fri, 16 May 2025 21:48:26 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.234])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7B398195608D;
	Fri, 16 May 2025 21:48:23 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 0/3] Don't start unnecessary transactions during log flush
Date: Fri, 16 May 2025 23:48:17 +0200
Message-ID: <20250516214822.905056-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QmjaZDuiVDSK0-kevAcvsingW65KQV-O3GLDhfqf3Uw_1747432106
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This patch set fixes a gfs2_logd lockup scenario during log flush which
was indroduced by commit 8d391972ae2d ("gfs2: Remove __gfs2_writepage()").

Thanks,
Andreas

Andreas Gruenbacher (3):
  gfs2: Rename jdata_dirty_folio to gfs2_jdata_dirty_folio
  gfs2: Move gfs2_trans_add_databufs
  gfs2: Don't start transactions during log flush

 fs/gfs2/aops.c  | 58 +++++++++++++++++++++++++++++--------------------
 fs/gfs2/aops.h  |  3 +--
 fs/gfs2/bmap.c  |  3 ++-
 fs/gfs2/log.c   |  7 +++++-
 fs/gfs2/trans.c | 21 ++++++++++++++++++
 fs/gfs2/trans.h |  2 ++
 6 files changed, 66 insertions(+), 28 deletions(-)

-- 
2.49.0


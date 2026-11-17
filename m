Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794882838;
	b=MepUCDy41L8suySr6aNBv651EtmE6grPhnzW/1oSsb1qj3MEx9WIrKn+oEowGUcxowHG
	 YVXVnifQ1IznE65LztSdf/xM8E9qbnTzC1sP4y3H7uDGczFU2HsA/BhhpbnZw14ysKwNl
	 pun6gnZPXiCrNxlNwsxezVQ/zGmJgBDoH6WSZkWDw4RvH0qKf0Ie+X1blQalpBy+MbqBI
	 3qgbKDfGb22peIiDswwXgYM38z82qvRriQgCeUFHg73DdZzZCu0t/NRO+0zEkNCA2Qyrk
	 EH5DBCbLGS6/OscexMej7DoYOL4jlDSx8rwuphF2gHNO+aLK9558KhSiT1vOs+1TogA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794882838;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:X-Scanned-By:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=HDIYk4s/n8VPMO/3+hLppUA/zXYHJavs8BKIDXYQz4E=;
	b=t8vmL7N6U7atkYjILNUM2QPzPQhda3PEEaZ31/8g+t9D9SPSrvLAMhD+YZ1iNISYKvm0
	 44jIG+1dJHoV29sM7U61sTGNWgMVjI1M6LeYKlmqimyCCJx27d1lqfhUKpj2Ky7l/p8pQ
	 vx5KVXcEzznB/LHY+esXbVwRsSdy2LCkfHdPH+6xIjNcz34+IZbw7Fduj2OnEcU+MdwBQ
	 DuByaE5MsxAFc8G0lDLiu1E96T2Zvsbw0lgeNIrIQgwcJmKblmQv1etaWxrQKVbe+X5DQ
	 1gbfaCGaAzG1S9hBvxSjVEcDLBMqAeUN73wMRcPEX0WdGcpRXH+zmQr9DjSXUaK9xDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="VVscQu/9";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1242606A33A
	for <gfs2@lists.linux.dev>; Tue, 17 Nov 2026 02:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1242606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VVscQu/9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794882835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HDIYk4s/n8VPMO/3+hLppUA/zXYHJavs8BKIDXYQz4E=;
	b=VVscQu/943AsHavwPtHHocJrrnVKv4UgMXDUjgSgh0gfkDX/F3dlOH6cO4rqy+G5MbWopC
	umljFR4XVsUBDpPMPyh/xydZKQSuncuOVwEUW9IFg9qC/pd3Uwv3D8cbCtlxVeU8Ej6OfR
	CCSQsBkSyNq84VOIini8Z/LO4SlGC18=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-xBPJb3WmOqmYDFZpfEEtaQ-1; Mon,
 16 Nov 2026 21:33:54 -0500
X-MC-Unique: xBPJb3WmOqmYDFZpfEEtaQ-1
X-Mimecast-MFC-AGG-ID: xBPJb3WmOqmYDFZpfEEtaQ_1794882833
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 507C3195D018
	for <gfs2@lists.linux.dev>; Tue, 17 Nov 2026 02:33:53 +0000 (UTC)
Received: from agruenba-thinkpadx1carbongen9.rmtat.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3C3C641F;
	Tue, 17 Nov 2026 02:33:51 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 0/4] gfs2: some cleanups
Date: Tue, 17 Nov 2026 03:33:45 +0100
Message-ID: <20261117023350.10180-1-agruenba@redhat.com>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IEzI4VeX2q8-VBN9jlR_FOvt2VKADjqOERT70o97Sq4_1794882833
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Here are some code cleanups.

Andreas Gruenbacher (4):
  gfs2: list_for_each_entry_safe conversion
  gfs2: Remove unnecessary list heads
  gfs2: gfs2_trans_remove_revoke cleanup
  gfs2: gfs2_glock_remove_revoke cleanup

 fs/gfs2/bmap.c     |  5 ++---
 fs/gfs2/glock.c    |  7 ++-----
 fs/gfs2/glops.c    |  3 +--
 fs/gfs2/log.c      | 35 +++++++++++++++--------------------
 fs/gfs2/log.h      |  2 +-
 fs/gfs2/lops.c     | 30 ++++++++----------------------
 fs/gfs2/quota.c    |  5 ++---
 fs/gfs2/recovery.c | 11 ++++-------
 fs/gfs2/super.c    | 10 ++++------
 fs/gfs2/trans.c    | 16 +++++++---------
 10 files changed, 46 insertions(+), 78 deletions(-)

-- 
2.56.1


Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF913AEF4C
	for <gfs2@lists.linux.dev>; Thu, 16 Jul 2026 07:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186526; cv=none; b=kq3nSBG/z6mzrCUTO/MGynwFTHDNT7HgZWuzDBtgPIRYRKfyfl/oi4p8fTx4sfV3XVHL90/iA1tAdRBGZBaEyintT4ziXqGPw2VdMBd0X2UfJGya/3VqEFfDx5rfCB2yeqnjQ3oqTgTYcMGoDWRr9PqcNnsvkYU4RFOjXXE7PEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186526; c=relaxed/simple;
	bh=qyRSmqiW90W1f8Ylh/XfpfedgrqVSrCMGva+vgPOBh0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UORi603/kAwKUCLgIm67GB1lNazBUM/jXmOV4VPFybnx8OoRG3g9m/DAfZFt6OQI96m/Id93M1IhPGCnVKirDb8dFDnb8Fep3JCfSK/Fr5j2lluXLrG6ssMXRUnbS9IA8H3JyICSSWAVgw5FnTfjCSUg6N1UaL8CIoQPDElYmlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 06b7ef9280e711f1aa26b74ffac11d73-20260716
X-CID-CACHE: Type:Local,Time:202607161511+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:ce179851-e0af-4e42-88c5-2cb5bd05fcc2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:ce0a91efb96771587ec5d3ef94d6435d,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 06b7ef9280e711f1aa26b74ffac11d73-20260716
X-User: lihaofeng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lihaofeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1591098151; Thu, 16 Jul 2026 15:21:56 +0800
From: Haofeng Li <lihaofeng@kylinos.cn>
To: aahringo@redhat.com,
	teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Haofeng Li <13266079573@163.com>,
	Haofeng Li <lihaofeng@kylinos.cn>
Subject: [PATCH 0/2] dlm: restrict userspace control devices to CAP_SYS_ADMIN
Date: Thu, 16 Jul 2026 15:21:50 +0800
Message-Id: <20260716072152.326803-1-lihaofeng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The DLM plock and monitor miscdevices are control interfaces intended
for privileged userspace daemons, but neither currently checks the
caller's capabilities when the device is opened.

devtmpfs creates both device nodes with mode 0600 by default.  Relying
only on that mode, however, leaves the interfaces unprotected if a node
is exposed through a changed udev rule, a container bind mount, or a
passed file descriptor.  An opener of dlm_plock can consume pending
requests and submit forged results.  An opener of dlm-monitor can alter
the global monitor reference count; the last close stops all local
lockspaces.

Require CAP_SYS_ADMIN in both open paths and explicitly set the device
mode to 0600.  The individual patches contain reproduction details for
each interface.

Haofeng Li (2):
  dlm: gate dlm_plock device on CAP_SYS_ADMIN
  dlm: require CAP_SYS_ADMIN for dlm-monitor device

 fs/dlm/plock.c | 14 +++++++++++++-
 fs/dlm/user.c  |  6 ++++++
 2 files changed, 19 insertions(+), 1 deletion(-)


base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
-- 
2.25.1

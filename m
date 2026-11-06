Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997642;
	b=n1tnoww+RJFH4LrLY+k71XyDhx9+87X67FcmWmMAFK74ISo26FosG1EC3c/FjAhBSzmE
	 Y3mYGhPEMsgaMZ1U4bHP2mJwNEeGQ93f6hWwjen0QZAFIgznoQQ+tGEMvn8U5ZuX4avVP
	 jetnc8nQJqMPMeerZO4CX2NWqDF+F/n/O6wnbU+asyPYGHywyUwbF4ug1MLcKCvgdwExq
	 5VgabMI52TuFpPzrico6oNI/+sDbEZLNcxwh89zAUrAuQz3JEa0zbksJ/nhkX6MGnVLun
	 G/ytbps5yu880Ga0GOOm0czY+s4E01x+xaLI+ouRB84s389kW06Zr6+qu9vKAeDJDNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997642;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:X-Scanned-By:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=6aCEdxO2GyAmp2yA2vdAUK4c5R6WVm0os9Eq06nYzDo=;
	b=tv1GG6G4QBPOZB4MCU6GHQGTiT+6RNQGVhsmWhVYK+q06kmxG9IEeJfhgoIdLsk/80wO
	 SohyIVNfheI8urIwmMiMDSE76YhDBDGjJHUUYZtvf84PfRsnzaeANFqb45AXxX7aGxnRc
	 ziFCznQkhGZZVByACbmmN2ilE3lyGohroOIuabhM6P8HdA+1tjTVBC5QuGSik181/6k8n
	 gb4wQTUXTrJ5H/sFzLs7QBonV5Zimv+agP49AQr/8Qiy92GmJMCUc3rleb8l7VCwRRcf9
	 6CAdkEvXTFvDW3fHrjLPTZsTWKEsbk/l0yu1rcpALb6/xjYeX/+CsKULyBJKSruS2bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S5LPlAGw;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2119D606A32E
	for <gfs2@lists.linux.dev>; Fri,  6 Nov 2026 20:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2119D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S5LPlAGw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793997641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6aCEdxO2GyAmp2yA2vdAUK4c5R6WVm0os9Eq06nYzDo=;
	b=S5LPlAGwBajwrEoAHWEauNBT7if/i82PIDfjid91NaCLe6IqX7QIVk5Ne6PqLB93tmLzY4
	YpAxIVhJ/rC+xJ+Ejeh0OuP5J4QaK8XUIITjyc2TgpUhOWkilH6wJpyPdttvrIhlltAAuE
	lFNf7zz6hsPcL0q6Uy+3sgYnZRyQ7P4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-Qu8m3c1TNtiaIt0IgUg6Jg-1; Fri,
 06 Nov 2026 15:40:39 -0500
X-MC-Unique: Qu8m3c1TNtiaIt0IgUg6Jg-1
X-Mimecast-MFC-AGG-ID: Qu8m3c1TNtiaIt0IgUg6Jg_1793997639
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D8A5E1955D7D
	for <gfs2@lists.linux.dev>; Fri,  6 Nov 2026 20:40:38 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 57B261956044;
	Fri,  6 Nov 2026 20:40:38 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH RESEND v7.4-rc1 0/4] dlm: various fixes
Date: Fri,  6 Nov 2026 15:40:31 -0500
Message-ID: <20261106204035.3794411-1-aahringo@redhat.com>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: z7C4HohYAqLVVFvE97cjugTmX5deSqLeaMWs2gxhUOs_1793997639
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi David,

This patch series contains mostly AI-assisted fixes and cleanups
across the DLM subsystem:

 - Add missing length checks for oversized inner DLM messages,
   this prevents potential buffer overruns or malformed packet
   handling.

 - Enforce RSB assignment before using LKBs, this ensures LKBs
   cannot exist in lkbxa without an associated RSB set. It
   resolves an issue with concurrent DLM user requests.

 - Prevent DLM_ASSERT() on canceled pending requests, this fixes an
   assertion failure triggered when a initial request is canceled and
   recovery is triggered during this state.

 - Fix lockspace node memory leak during release, this resolves a leak
   involving delayed member removal during active lockspace releasing
   members. Active releasing members will not run recovery so the delayed
   cleanup of removed of members will never occur.

Ensuring that LKBs always have an RSB assigned should also reduce the
likelihood of subtle bugs elsewhere in the codebase where an RSB presence
check might be missing.

Checkpatch threw a warning for the "Assisted-by:" tag. It seems checkpatch
can't recognize this yet?

There is a pending sysfs fix [0] that conflicts with [1]. The fix for
[1] does not go through the dlm tree so [0] is delayed until [1] is
available.

- Alex

[0] https://lore.kernel.org/gfs2/20261019184849.24422-1-sanan.hasanou@gmail.com/
[1] https://lore.kernel.org/gfs2/20261027223847.652884-6-irogers@google.com/

Alexander Aring (1):
  dlm: fix memory leak on active leaving member

Ameer Hamza (1):
  dlm: don't set RSB_MASTER_UNCERTAIN on rsb with no master

Jérémy Jean (1):
  dlm: reject wrapped messages with oversized inner lengths

Yogesh Gaur (1):
  dlm: don't publish a lkb in ls_lkbxa before it has an rsb

 fs/dlm/config.c   |  9 +++++
 fs/dlm/lock.c     | 98 ++++++++++++++++++++++++++++++++---------------
 fs/dlm/midcomms.c |  8 ++++
 3 files changed, 85 insertions(+), 30 deletions(-)

-- 
2.43.0


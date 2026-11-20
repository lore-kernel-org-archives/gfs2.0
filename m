Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795204851;
	b=S7DoXDrZjSOnmYDilbPrPbfKKZNTSfO2GAB2wNExmHwdcOk5rZAK4RTYoL95LNtdvqhV
	 G8easi0LptZQtxBj7fkblHGAjf9pUs5NuY/BqAcR/anb+Hjoclat98bZEN9Xuywo2LpJQ
	 XxVYorjW2N36sxawAi8B9xaqIosJeFdSW3t/JaZflGLpaFjmc+xtNvATen1dij3t6PnFD
	 AbZkIsLyNHcMiFlvk9oqWd7wquEKgmW6Gcc7WDlCOoBl5sGWsXDG76XnqeiSO2Vf3t8zS
	 BSiD3Vxi758lwwBCUvP82CD8G29q3nKYpzQDDifwur4jdsgWOZoUnMkiaJmJUBB7wgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795204851;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:X-Scanned-By:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=o0+WRxnX3wqcsEnXLa2Aw5ata3isb3HT8p3j6wpfkyE=;
	b=HrDXp3ZEZjvR6jLzoXGAPCTN08U97QmC6+Y4R6mXoSrQoV+g6Hq/txOZlyReaIlGqpAq
	 R9JPHFamhvooGulgcSQRs6tPAykgtT3iwT/GIYhhKY3W7XEJEh03H6M9JZVZJUNLiitAN
	 zmIAcusJerBYYio0yAV8wlUQSXNQmRt+Z0+ZZEYWl/kss90Guwq7dk7Ex+/t/gDpom9G0
	 lab9KvcLtr+tDuLepSFwgpx2/uYBQH5E4ghLY9RizsqVNzmFkaT/0OC68t5GBpL0M05rz
	 nJAxnEHFDBtp4CwKREQFQuLuY8TCCvc+iB1+dey/88vxUATyX+YGr1fzK3I3wfOk1ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X8BpBn97;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49565606A33D
	for <gfs2@lists.linux.dev>; Fri, 20 Nov 2026 20:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49565606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X8BpBn97
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795204846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o0+WRxnX3wqcsEnXLa2Aw5ata3isb3HT8p3j6wpfkyE=;
	b=X8BpBn97T7oH6WwxrB3F29pGnPO4EKvbYqkutk24kR0ZXe6N7V8RU1/p4yg20zCn/nbYOM
	AxDKMSEbzJKU7g4t9/zBBtcrW9DzpN02Zlv5EwYk0Ky7Ii4r89kAe9Ck+FhqS3XJyKSZgu
	dmlYhFlj2tRqNG3TieJWUDf1OHoPz3U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-NwDz_jGNOli24M5pbYjakg-1; Fri,
 20 Nov 2026 20:00:43 +0000
X-MC-Unique: NwDz_jGNOli24M5pbYjakg-1
X-Mimecast-MFC-AGG-ID: NwDz_jGNOli24M5pbYjakg_1795204843
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E566A1954B06
	for <gfs2@lists.linux.dev>; Fri, 20 Nov 2026 20:00:42 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 570FE588;
	Fri, 20 Nov 2026 20:00:42 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCHv2 RESEND v7.4-rc3 0/5] dlm: various fixes
Date: Fri, 20 Nov 2026 15:00:35 -0500
Message-ID: <20261120200040.257152-1-aahringo@redhat.com>
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
X-Mimecast-MFC-PROC-ID: jUVn6oNMw3KSvk09JNx3mo5SU4hP0xknPjHhN1gORi0_1795204843
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

 - Fixes a case where the reconnect mechanism gets stuck if a socket error
   occurs while the socket send buffer is full. This was found by the
   netdev-bot (sashik AI bot) [3]. I tested it with tcpkill again, and
   everything still seems to run fine. To test this specific case, I used
   netem to slow down networking so the socket buffer would fill up while
   running tcpkill to trigger socket errors.

Ensuring that LKBs always have an RSB assigned should also reduce the
likelihood of subtle bugs elsewhere in the codebase where an RSB presence
check might be missing.

There is a pending sysfs fix [0] that conflicts with [1]. The fix for
[1] does not go through the dlm tree so [0] is delayed until [1] is
available.

- Alex

[0] https://lore.kernel.org/gfs2/20261019184849.24422-1-sanan.hasanou@gmail.com/
[1] https://lore.kernel.org/gfs2/20261027223847.652884-6-irogers@google.com/
[2] https://lore.kernel.org/gfs2/179090395863.434549.3668493667259120759@kernel.org/

changes since v2:
 - add patch to fix the socket hang on send buffer limitation
 - drop the Assisted-by tags

Alexander Aring (2):
  dlm: fix socket hang on send buffer limitation with socket error
  dlm: fix memory leak on active leaving member

Ameer Hamza (1):
  dlm: don't set RSB_MASTER_UNCERTAIN on rsb with no master

Jérémy Jean (1):
  dlm: reject wrapped messages with oversized inner lengths

Yogesh Gaur (1):
  dlm: don't publish a lkb in ls_lkbxa before it has an rsb

 fs/dlm/config.c   |  9 +++++
 fs/dlm/lock.c     | 98 ++++++++++++++++++++++++++++++++---------------
 fs/dlm/lowcomms.c | 47 ++++++++++++++++-------
 fs/dlm/midcomms.c |  8 ++++
 4 files changed, 118 insertions(+), 44 deletions(-)

-- 
2.43.0


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD4F42BEAA
	for <gfs2@lists.linux.dev>; Tue,  1 Sep 2026 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284850; cv=none; b=QSj3P3Bhv3n8rWsWUExD4ZZGPl7dPYAm6lgxx1mxMcVt+abkjPepvG1WPMq1JuNBi00GGyXxGy2CLOfO4MswRPmMMzd/fBUjPjAwhllgJwEsealNjzQUhkB/Z/m7GVlhvVcxBQx4s7xI8Ypo1RXVUmdIMs/seWrpSy0tip4cUOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284850; c=relaxed/simple;
	bh=BG/3igafgv+eK6pkpxb7n+A15t77hQRNZ2SSL0jhuf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Wd8LmcExbTeBvzCRMAs/oU+18mx4Ddtz7w6x4yt1xTtZ3CxBiD/r6JNTsLE/4I2ojO5X3GrW1iAvxIAHZCUB8e80D0axL1XAD6HlIpFHPaBM8bxPKz3GfyGhyUbKQ+17lTdoKa/aAbDq8osjxIw5zWjwdjuwZrpExuKcqE7w4fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BE8F/Ei1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BE8F/Ei1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788284847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zfCgrqISFQCYmWI54gLtlAdwwJ4CYpEKyjNixCDSgaY=;
	b=BE8F/Ei1SQiVE0xhMQOL6haH8n8C7tB6hVYMdFrEY6R8yVYNdExFN0r+qF58CiHcrxvYeE
	ibD/uxzj4qzJiMP2UGetg2aW/Ik1Xjm9TDuocc/JkdUo8+zFV5beD5gGJ2dkETO1S4Pdyb
	WUs5WSITGttfIqv8g3oagUHfd7HmrBE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-yI1HGZFxM-qS6pS1kTS7mA-1; Tue,
 01 Sept 2026 13:47:26 -0400
X-MC-Unique: yI1HGZFxM-qS6pS1kTS7mA-1
X-Mimecast-MFC-AGG-ID: yI1HGZFxM-qS6pS1kTS7mA_1788284845
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5118D1802542
	for <gfs2@lists.linux.dev>; Tue,  1 Sep 2026 17:47:25 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B785918005BD;
	Tue,  1 Sep 2026 17:47:24 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH RESEND dlm/next 5/8] dlm: validate lock modes in recovery messages
Date: Tue,  1 Sep 2026 13:47:12 -0400
Message-ID: <20260901174715.3825582-6-aahringo@redhat.com>
In-Reply-To: <20260901174715.3825582-1-aahringo@redhat.com>
References: <20260901174715.3825582-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: H2iGncRyjN4aAqtZNWhOM40ENSNr6pPE7qK2ZasCfdo_1788284845
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Danila Chernetsov <listdansp@mail.ru>

The DLM recovery path restores lock state from rcom_lock messages
received from remote nodes. The lock modes in these messages are
copied directly into the local lkb state without validating that they
are within the valid DLM lock mode range.

The rest of the DLM code assumes that lkb_rqmode and lkb_grmode
contain valid lock modes. In particular, LVB callback handling in
dlm_may_skip_callback() uses lock modes as indexes into the
dlm_lvb_operations array:

    dlm_lvb_operations[prev_mode + 1][mode + 1]

An invalid lock mode received during recovery could therefore result in
an out-of-bounds read during subsequent LVB callback processing.

Validate rl_rqmode and rl_grmode before storing them into the local LKB
state. This preserves the lock mode invariant required by the rest of
the DLM code.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: e7fd41792fc0 ("[DLM] The core of the DLM for GFS2/CLVM")
Acked-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: Danila Chernetsov <listdansp@mail.ru>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 373abdb4354a7..99c7a8c4e6122 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -5531,6 +5531,10 @@ static int receive_rcom_lock_args(struct dlm_ls *ls, struct dlm_lkb *lkb,
 {
 	struct rcom_lock *rl = (struct rcom_lock *) rc->rc_buf;
 
+	if (rl->rl_rqmode < DLM_LOCK_IV || rl->rl_rqmode > DLM_LOCK_EX ||
+	    rl->rl_grmode < DLM_LOCK_IV || rl->rl_grmode > DLM_LOCK_EX)
+		return -EINVAL;
+
 	lkb->lkb_nodeid = le32_to_cpu(rc->rc_header.h_nodeid);
 	lkb->lkb_ownpid = le32_to_cpu(rl->rl_ownpid);
 	lkb->lkb_remid = le32_to_cpu(rl->rl_lkid);
-- 
2.43.0


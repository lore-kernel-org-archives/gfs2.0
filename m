Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547BF429805
	for <gfs2@lists.linux.dev>; Tue, 20 Jan 2026 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768926971; cv=none; b=NGjl62/RcoAp7phtRKUQ751JkYSD9M/EEt5SPYYnOoLHevruG5bjRAnL4NOA9PkYzhHJKAQ33nml+j6IUhY301IFivufhnJ+jI9B9LhGCWG2d6oSVuQqJw50R0MwxmxdmxuW0Q/OpCY59pKikXeH5iCK/esyWfi3qzF4JLvHKrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768926971; c=relaxed/simple;
	bh=zxiWYGEn+OZnxQdxA/jwYn6Mntqp4QZNgqLkn9iEdZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=Kyq5pwidcvn+S30qF9tSxWI1Ais8z2VAgslwnPD4oqRy/OkMod2Mt964B40cHU+tPIGeG60/ornt3HRwBnxztQofCPgq5xN58k1wlxtYnh4X15U9RNHDOTTRfgITLTz6QXXT+9JCsjFBPSInV5XW2Rpx1Z72NSgBK8xApYjPJlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HCMEfbtS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HCMEfbtS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768926968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oINKMBbJniuKRRYXV1wcR/8zShOJWH8slxTr96PCoT4=;
	b=HCMEfbtSQoMxN9o8/Ng8Mi6i2m77J4LY1Q5btv0bBUIZ512EC0BbCohYUwA9KKUuEF4wI0
	SJBicrn9CncCu3dCtm2tuxdmOwqBepPgqM7D+SYEbEb+Us3h9XfkxOLmANJn5vGoqLq80g
	v1B6Fp0oEhZsiB2D8GmyqUs/Cj1hPCQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-bI9QqB0QMaOB6ZNgC9whxA-1; Tue,
 20 Jan 2026 11:36:06 -0500
X-MC-Unique: bI9QqB0QMaOB6ZNgC9whxA-1
X-Mimecast-MFC-AGG-ID: bI9QqB0QMaOB6ZNgC9whxA_1768926965
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F025118002DD
	for <gfs2@lists.linux.dev>; Tue, 20 Jan 2026 16:36:04 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 60A4E18008FF;
	Tue, 20 Jan 2026 16:36:04 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH dlm/tool] dlm_controld: send plock operations without resource lookup
Date: Tue, 20 Jan 2026 11:35:55 -0500
Message-ID: <20260120163555.2344198-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9Tl2zGD__u-CEcidedguetZBSarsKDmxoKOFnRZrhq4_1768926965
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: David Teigland <teigland@redhat.com>

When plock_ownership mode is disabled, a plock operation read from
the kernel can be sent to all nodes immediately, without looking up
the local resource struct.  This is faster, and it avoids a bug in
cases where multiple threads in a process submit concurrent fcntl
lock ops on a file.

This bug occurs because create/free of the resource struct should
only be done in the context of ordered receive_plock cpg messages.
plock unlock results were being incorrectly returned based on the
non-existence of a struct resource checked in process_plocks (outside
of the ordered message context.)  In this case, the existence of the
resource struct was used to imply a lock state ("no locks"), which is
invalid to conclude outside of the message context.  The bug would
only appear in the unusual scenario where multiple threads in a
process are running concurrent fcntl lock operations on a file.

This fix does not address the problem when plock_ownership is enabled,
so warnings are added for the plock_ownership setting.
---
 dlm_controld/dlm_controld.8 | 2 ++
 dlm_controld/main.c         | 2 +-
 dlm_controld/plock.c        | 5 +++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/dlm_controld/dlm_controld.8 b/dlm_controld/dlm_controld.8
index d72ebb29..a607f73c 100644
--- a/dlm_controld/dlm_controld.8
+++ b/dlm_controld/dlm_controld.8
@@ -50,6 +50,8 @@ For default settings, see dlm_controld -h.
 .B --plock_ownership | -o
 0|1
         enable/disable plock ownership
+.br
+        (WARNING: do not enable if threads perform fcntl locking.)
 
 .B --drop_resources_time | -t
 .I int
diff --git a/dlm_controld/main.c b/dlm_controld/main.c
index a4beb312..d2dfe601 100644
--- a/dlm_controld/main.c
+++ b/dlm_controld/main.c
@@ -1860,7 +1860,7 @@ static void set_opt_defaults(void)
 	set_opt_default(plock_ownership_ind,
 			"plock_ownership", 'o', req_arg_bool,
 			0, NULL, 0, 0,
-			"enable/disable plock ownership");
+			"enable/disable plock ownership (do not enable if threads do fcntl locking)");
 
 	set_opt_default(drop_resources_time_ind,
 			"drop_resources_time", 't', req_arg_int,
diff --git a/dlm_controld/plock.c b/dlm_controld/plock.c
index 1944cd59..30cf61a5 100644
--- a/dlm_controld/plock.c
+++ b/dlm_controld/plock.c
@@ -1599,6 +1599,11 @@ void process_plocks(int ci)
 		plock_rate_delays = 0;
 	}
 
+	if (!opt(plock_ownership_ind)) {
+		send_plock(ls, NULL, &info);
+		return;
+	}
+
 	create = (info.optype == DLM_PLOCK_OP_UNLOCK) ? 0 : 1;
 
 	rv = find_resource(ls, info.number, create, &r);
-- 
2.43.0


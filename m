Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F931AA785
	for <gfs2@lists.linux.dev>; Fri,  4 Oct 2024 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728054837; cv=none; b=gpXG3z1BexfmLwCCS68Wz5yQL9CE8sCwNUFvQvU26Espj7k0+JIyqklkkyJL2bbAPfB5FooVVzVeQ0fcUETwFrLepFvQSLcEamnDw9BJZey4SJSxUTyeqKMlm+t0U6EN7MYYdh15WJB5K+RHu0Ip8DQV0T5brU/hi8/Y/ydg2j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728054837; c=relaxed/simple;
	bh=E0SrYPJ+fRqnC7FXR/hYXWFLYON5d7tGWxd6pSEODlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rZGJTPgKqG7tNseG5PcMh5de+dGGRumCIHPn6yE6kpSZOX1SxG9yErbdmBqr1xr8vx+EQvHfWaRz5ZQ7ErwAmEO5NnhANR4J2zCdEuJSFTMFRyjcEiLWfVSPegCbCuvFXiLu5oj2qS0jHe6djAa+VDhvLJ2WuHDos4qdJrQCFls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eX/DqwH8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eX/DqwH8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728054834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9hsdDKwqAtISuTXRJDMDMPOj3KjFM7cN/s9SqhNZdkc=;
	b=eX/DqwH8p1KX+DvsHlCmKuAxi7tb8QGMDrClcMH3R3eDo6d8ik/IiXoiMVxF3T8ewf66LU
	03rqpT5KovIzxuxydoX7OXAXFnbTojvL9KI9FDLI2c2dMphjbud6W8/OGyqrbPtEa+rY7M
	kV4klTkculeBzWXT9hCbvecwTIHnWII=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-6AgQQ_tEPO2DtH8NfpNDxQ-1; Fri,
 04 Oct 2024 11:13:53 -0400
X-MC-Unique: 6AgQQ_tEPO2DtH8NfpNDxQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1AD351956057
	for <gfs2@lists.linux.dev>; Fri,  4 Oct 2024 15:13:52 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 28DF219560AE;
	Fri,  4 Oct 2024 15:13:51 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH v6.12-rc1 6/7] dlm: dlm_config_info config fields to unsigned int
Date: Fri,  4 Oct 2024 11:13:42 -0400
Message-ID: <20241004151343.3952937-7-aahringo@redhat.com>
In-Reply-To: <20241004151343.3952937-1-aahringo@redhat.com>
References: <20241004151343.3952937-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

We are using kstrtouint() to parse common integer fields. This patch
will switch to use unsigned int instead of int as we are parsing
unsigned integer values.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/config.c |  3 ++-
 fs/dlm/config.h | 22 +++++++++++-----------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/dlm/config.c b/fs/dlm/config.c
index ff18c7ace611..b2f21aa00719 100644
--- a/fs/dlm/config.c
+++ b/fs/dlm/config.c
@@ -153,7 +153,8 @@ static ssize_t cluster_tcp_port_store(struct config_item *item,
 
 CONFIGFS_ATTR(cluster_, tcp_port);
 
-static ssize_t cluster_set(int *info_field, int (*check_cb)(unsigned int x),
+static ssize_t cluster_set(unsigned int *info_field,
+			   int (*check_cb)(unsigned int x),
 			   const char *buf, size_t len)
 {
 	unsigned int x;
diff --git a/fs/dlm/config.h b/fs/dlm/config.h
index 2c5dcf5eaef1..e48c4f9686d3 100644
--- a/fs/dlm/config.h
+++ b/fs/dlm/config.h
@@ -30,17 +30,17 @@ extern const struct rhashtable_params dlm_rhash_rsb_params;
 
 struct dlm_config_info {
 	__be16 ci_tcp_port;
-	int ci_buffer_size;
-	int ci_rsbtbl_size;
-	int ci_recover_timer;
-	int ci_toss_secs;
-	int ci_scan_secs;
-	int ci_log_debug;
-	int ci_log_info;
-	int ci_protocol;
-	int ci_mark;
-	int ci_new_rsb_count;
-	int ci_recover_callbacks;
+	unsigned int ci_buffer_size;
+	unsigned int ci_rsbtbl_size;
+	unsigned int ci_recover_timer;
+	unsigned int ci_toss_secs;
+	unsigned int ci_scan_secs;
+	unsigned int ci_log_debug;
+	unsigned int ci_log_info;
+	unsigned int ci_protocol;
+	unsigned int ci_mark;
+	unsigned int ci_new_rsb_count;
+	unsigned int ci_recover_callbacks;
 	char ci_cluster_name[DLM_LOCKSPACE_LEN];
 };
 
-- 
2.43.0


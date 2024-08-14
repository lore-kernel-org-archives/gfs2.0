Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E5518C910
	for <gfs2@lists.linux.dev>; Wed, 14 Aug 2024 14:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723646088; cv=none; b=oAc3OqBUaVumoRd0d6qxUPJez0WMINJQ61jvNKblT8WW1N2wC6EWYfa3U4TPeulvGehxI+0bci/UmuGlW2BgpYSOzwCkVdoXkttXjv26pOGXGdlR3FcYgdHDuNqjh8ILgPdBxhypAjgZMo203aIOW+H04kfjFkqIAIkAG2z48lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723646088; c=relaxed/simple;
	bh=U0nOA7Z1A1/Dy25L8IFvcBZsOwg8CiDXCZ/aPn74aWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0BVGizMtIM/yR/39CACGPjpIxrpak7vA6gREzsimoiEz64YVqLrR8NfbNhGyVQsM0yCbhGajhEIqUuJnlfgMb9ZFDyRqlrNfJUQvzL6JGPNjeo0VhQY8zqW6PVuDAQM41Hl0uookrwStjm23cvX8pVvN0GtemTW6niDxbHE/y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hBIqkno0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hBIqkno0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723646085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gRLptKCiXpp4gNIkR9o/h84xalWa/aBGlKLc9592qnI=;
	b=hBIqkno0P2Lj3wWXNkPTgKn4Rlbr3i/q5QUbBFKcNTeDldW7Iyc7H0JcFg6VQvuynBieaL
	WCF+UUdYso7/JQKCixtGNWWb2K3DNU0uVQRp4LBlgb7rSND2dwGxkvaWS/qxz/H4GQJ7O5
	AuWeuQvGiehqqWvU+GbI2Ohn2CxarDA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-lioQxatQODqY5_mNC0l4pQ-1; Wed,
 14 Aug 2024 10:34:40 -0400
X-MC-Unique: lioQxatQODqY5_mNC0l4pQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38489195420C;
	Wed, 14 Aug 2024 14:34:38 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 84ED33001FE5;
	Wed, 14 Aug 2024 14:34:35 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	song@kernel.org,
	yukuai3@huawei.com,
	agruenba@redhat.com,
	mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	lucien.xin@gmail.com,
	aahringo@redhat.com
Subject: [RFC dlm/next 06/12] dlm: dlm_config_info config fields to unsigned int
Date: Wed, 14 Aug 2024 10:34:08 -0400
Message-ID: <20240814143414.1877505-7-aahringo@redhat.com>
In-Reply-To: <20240814143414.1877505-1-aahringo@redhat.com>
References: <20240814143414.1877505-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

We are using kstrtouint() to parse common integer fields. This patch
will switch to use unsigned int instead of int as we are parsing
unsigned integer values.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/config.c |  3 ++-
 fs/dlm/config.h | 22 +++++++++++-----------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/dlm/config.c b/fs/dlm/config.c
index d9cde614ddd4..a98f0e746e9e 100644
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
index 9cb4300cce7c..9abe71453c5e 100644
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


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F05B48C8A3
	for <gfs2@lists.linux.dev>; Tue,  1 Sep 2026 17:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284853; cv=none; b=mBSptReNFr1xnFFBf0dISx+ngMGRNuMRVRZv/k54tMRPbyv3eXf9PyoJK9l69PZc1sKBWi47ziAFrKffcI1RmojEJxRbp8/IqkI3gBxo+QCtWq5quiYbpjGOWkdLF7cN96l80UxexHDPNHCcOsKIHaetpRg2cshFtXFrRCX76ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284853; c=relaxed/simple;
	bh=poZj2vS5t78mgcLh09V0sVThl5FWVeOwOQVTwEDNBEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=G1/hwtzrbYVWkHRw0xuk/SWFjqgJZp7X9ZEct7B7X+YqMmPA6+VtcsuAFIqMvlH4/xZU0cTuWJVbjXLd4LClromj37PMcxbpH5ZvK0UhtVe5txc+OExM5XceXH7G3c/X/jkG3HRxMSvdfijiaGRKjb8y9gAmvkPlaRldZoe/IuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q4lo36/A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q4lo36/A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788284849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4O2K+iDTmNzYDuZZjYN9GUe3hW8G9+1opzLpXvj5EOU=;
	b=Q4lo36/Aev6fM0GSXu8RaXtLBiyrali5OrPRJYxVSfvhQotUEtwc7lykzg9SaAf3W7VdmI
	Zuq+C6kbugvTdAFDFI7nP6amzvcg/bnaYM0msu2tJvvu4Fhe5pwu+Msq8siV9ypYMJyUO1
	Dz8XmJPsc39CBP/Q5BUP1DM7zTcaMWI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-EykERIwvMF-30d5MjbOLTQ-1; Tue,
 01 Sept 2026 13:47:28 -0400
X-MC-Unique: EykERIwvMF-30d5MjbOLTQ-1
X-Mimecast-MFC-AGG-ID: EykERIwvMF-30d5MjbOLTQ_1788284847
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F5DE1802161
	for <gfs2@lists.linux.dev>; Tue,  1 Sep 2026 17:47:27 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B271A18005BD;
	Tue,  1 Sep 2026 17:47:26 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH RESEND dlm/next 8/8] dlm: fix variable key length lookup
Date: Tue,  1 Sep 2026 13:47:15 -0400
Message-ID: <20260901174715.3825582-9-aahringo@redhat.com>
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
X-Mimecast-MFC-PROC-ID: QzAQeDsB4RngUEGVUhDLS9Rc_LVlwz2cSWNeb7NeCxs_1788284847
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Before commit 6c648035cbe7 ("dlm: switch to use rhashtable for rsbs")
the rsb hashtable was dynamic key length. Accidentally it was changed to
switch to static key length which can end in different results. We
fixing this back to the original behaviour by adding the necessary
functionality to rhashtable to handle the objects and lookups as dynamic
key lengths.

Fixes: 6c648035cbe7 ("dlm: switch to use rhashtable for rsbs")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/config.c       | 30 ++++++++++++++++++++++++++++--
 fs/dlm/dlm_internal.h |  5 +++++
 fs/dlm/lock.c         |  6 ++++--
 3 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/fs/dlm/config.c b/fs/dlm/config.c
index 53cd332930423..6c5c3f049b33a 100644
--- a/fs/dlm/config.c
+++ b/fs/dlm/config.c
@@ -64,11 +64,37 @@ static void release_node(struct config_item *);
 static struct configfs_attribute *comm_attrs[];
 static struct configfs_attribute *node_attrs[];
 
+static u32 rsb_hashfn(const void *data, u32 len, u32 seed)
+{
+	const struct dlm_rsb_key *key = data;
+
+	return jhash(key->name, key->len, 0);
+}
+
+static u32 rsb_obj_hashfn(const void *data, u32 len, u32 seed)
+{
+	const struct dlm_rsb *r = data;
+
+	return r->res_hash;
+}
+
+static int rsb_obj_cmpfn(struct rhashtable_compare_arg *arg, const void *obj)
+{
+	const struct dlm_rsb_key *key = arg->key;
+	const struct dlm_rsb *r = obj;
+
+	if (key->len != r->res_length)
+		return -1;
+
+	return memcmp(&r->res_name, key->name, key->len);
+}
+
 const struct rhashtable_params dlm_rhash_rsb_params = {
 	.nelem_hint = 3, /* start small */
-	.key_len = DLM_RESNAME_MAXLEN,
-	.key_offset = offsetof(struct dlm_rsb, res_name),
 	.head_offset = offsetof(struct dlm_rsb, res_node),
+	.hashfn = rsb_hashfn,
+	.obj_hashfn = rsb_obj_hashfn,
+	.obj_cmpfn = rsb_obj_cmpfn,
 	.automatic_shrinking = true,
 };
 
diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index 9df842421ae06..74c2e77d1b553 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -340,6 +340,11 @@ struct dlm_rsb {
 	char			res_name[DLM_RESNAME_MAXLEN+1];
 };
 
+struct dlm_rsb_key {
+	char name[DLM_RESNAME_MAXLEN];
+	size_t len;
+};
+
 /* dlm_master_lookup() flags */
 
 #define DLM_LU_RECOVER_DIR	1
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index d73c4aed1f8ac..2609e4fdeba84 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -625,12 +625,14 @@ static int get_rsb_struct(struct dlm_ls *ls, const void *name, int len,
 int dlm_search_rsb_tree(struct rhashtable *rhash, const void *name,
 			unsigned int len, struct dlm_rsb **r_ret)
 {
-	char key[DLM_RESNAME_MAXLEN] = {};
+	struct dlm_rsb_key key = {
+		.len = len,
+	};
 
 	if (len > DLM_RESNAME_MAXLEN)
 		return -EINVAL;
 
-	memcpy(key, name, len);
+	memcpy(key.name, name, len);
 	*r_ret = rhashtable_lookup_fast(rhash, &key, dlm_rhash_rsb_params);
 	if (*r_ret)
 		return 0;
-- 
2.43.0


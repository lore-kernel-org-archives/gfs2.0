Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB6B17B410
	for <gfs2@lists.linux.dev>; Tue, 28 May 2024 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716930771; cv=none; b=Pc1Rc1ECtpPkXUdFl1LeoBhSxsMhdfx4cpMkdIvBt8ir5c9itY0NZSHcq1Rof+UOSEjWoSj1OVgaLSsdCekExYc5df3CpTO+M90rYz26wGa4EfovEkN3DsYjiySZzGASh1VH9Ah/RLf9Lz9NEWp07QkUcMdKGUYP5JRuk3WzCK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716930771; c=relaxed/simple;
	bh=AwrXBwl0vEPb3MuBGQiuMklu+KxxWvGUAlQHGRHkfek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JIreT4xSbBdmpsV/xzjxuqyKIgYwYcckDW7OgPEE6ZPGT46rzvtNY21cSYrK0/qEl9l5whOiNaFspN1oi2NGIZRvOlQeKphJwIK4WwJZAq1djFQhu6bQHxPzrHsE7KcS6FToVSmMUZZs2+GhmAerUeUtIZP9YD10Gbbrwj6TxB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SHADE2lZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHADE2lZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716930768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SACX7EjJqFSMK3QXur0aoU0qcLvs7hRT/J8chlo+GNQ=;
	b=SHADE2lZqt8D7iec9Sqs5alSG0BgFp5so1v/WoHsTjcZ9d3SRp/W9FwNAM1C7nvaImopTi
	kCk+t8D1y4jJY4Iyh2KOihg2WK3e0F7mFtJAbcCg442TGdVkAJSNFzjUSPFiOTLdZsDtXX
	/5mZxjhXFn9xjNSG73N8b5xu/TGwOqA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-Ne0BAW4jOaeILmia8hxNgA-1; Tue,
 28 May 2024 17:12:47 -0400
X-MC-Unique: Ne0BAW4jOaeILmia8hxNgA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E75041C0512D
	for <gfs2@lists.linux.dev>; Tue, 28 May 2024 21:12:46 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DEF30200A610;
	Tue, 28 May 2024 21:12:46 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH v6.10-rc1 03/11] dlm: remove unused parameter in dlm_midcomms_addr
Date: Tue, 28 May 2024 17:12:33 -0400
Message-ID: <20240528211241.2140441-3-aahringo@redhat.com>
In-Reply-To: <20240528211241.2140441-1-aahringo@redhat.com>
References: <20240528211241.2140441-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This patch removes an parameter which is currently not used by
dlm_midcomms_addr().

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/config.c   | 2 +-
 fs/dlm/lowcomms.c | 2 +-
 fs/dlm/lowcomms.h | 2 +-
 fs/dlm/midcomms.c | 4 ++--
 fs/dlm/midcomms.h | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/dlm/config.c b/fs/dlm/config.c
index 517fa975dc5a..99952234799e 100644
--- a/fs/dlm/config.c
+++ b/fs/dlm/config.c
@@ -672,7 +672,7 @@ static ssize_t comm_addr_store(struct config_item *item, const char *buf,
 
 	memcpy(addr, buf, len);
 
-	rv = dlm_midcomms_addr(cm->nodeid, addr, len);
+	rv = dlm_midcomms_addr(cm->nodeid, addr);
 	if (rv) {
 		kfree(addr);
 		return rv;
diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 6b8078085e56..591385701c7d 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -461,7 +461,7 @@ static bool dlm_lowcomms_con_has_addr(const struct connection *con,
 	return false;
 }
 
-int dlm_lowcomms_addr(int nodeid, struct sockaddr_storage *addr, int len)
+int dlm_lowcomms_addr(int nodeid, struct sockaddr_storage *addr)
 {
 	struct connection *con;
 	bool ret, idx;
diff --git a/fs/dlm/lowcomms.h b/fs/dlm/lowcomms.h
index 8deb16f8f620..fd0df604eb93 100644
--- a/fs/dlm/lowcomms.h
+++ b/fs/dlm/lowcomms.h
@@ -46,7 +46,7 @@ void dlm_lowcomms_put_msg(struct dlm_msg *msg);
 int dlm_lowcomms_resend_msg(struct dlm_msg *msg);
 int dlm_lowcomms_connect_node(int nodeid);
 int dlm_lowcomms_nodes_set_mark(int nodeid, unsigned int mark);
-int dlm_lowcomms_addr(int nodeid, struct sockaddr_storage *addr, int len);
+int dlm_lowcomms_addr(int nodeid, struct sockaddr_storage *addr);
 void dlm_midcomms_receive_done(int nodeid);
 struct kmem_cache *dlm_lowcomms_writequeue_cache_create(void);
 struct kmem_cache *dlm_lowcomms_msg_cache_create(void);
diff --git a/fs/dlm/midcomms.c b/fs/dlm/midcomms.c
index c34f38e9ee5c..2c101bbe261a 100644
--- a/fs/dlm/midcomms.c
+++ b/fs/dlm/midcomms.c
@@ -334,12 +334,12 @@ static struct midcomms_node *nodeid2node(int nodeid)
 	return __find_node(nodeid, nodeid_hash(nodeid));
 }
 
-int dlm_midcomms_addr(int nodeid, struct sockaddr_storage *addr, int len)
+int dlm_midcomms_addr(int nodeid, struct sockaddr_storage *addr)
 {
 	int ret, idx, r = nodeid_hash(nodeid);
 	struct midcomms_node *node;
 
-	ret = dlm_lowcomms_addr(nodeid, addr, len);
+	ret = dlm_lowcomms_addr(nodeid, addr);
 	if (ret)
 		return ret;
 
diff --git a/fs/dlm/midcomms.h b/fs/dlm/midcomms.h
index 278d26fdeb2c..7fad1d170bba 100644
--- a/fs/dlm/midcomms.h
+++ b/fs/dlm/midcomms.h
@@ -19,7 +19,7 @@ int dlm_process_incoming_buffer(int nodeid, unsigned char *buf, int buflen);
 struct dlm_mhandle *dlm_midcomms_get_mhandle(int nodeid, int len, char **ppc);
 void dlm_midcomms_commit_mhandle(struct dlm_mhandle *mh, const void *name,
 				 int namelen);
-int dlm_midcomms_addr(int nodeid, struct sockaddr_storage *addr, int len);
+int dlm_midcomms_addr(int nodeid, struct sockaddr_storage *addr);
 void dlm_midcomms_version_wait(void);
 int dlm_midcomms_close(int nodeid);
 int dlm_midcomms_start(void);
-- 
2.43.0


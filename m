Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDF131ED9F
	for <gfs2@lists.linux.dev>; Tue, 20 Jan 2026 15:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768923328; cv=none; b=PW+66zZ6dD/CdKaRzZ8wa9FQOB8o7HAbPZOd5bFeZZ5KPgg/Ut712Hn9y57qGO5B8HCFhJqCEz6B03KVX9MbaZi0yVecmfPUUUXN8eGVilKULcYRO7oP+UiB37TOrIiXsZjPBPeuLreEk8w/YsgqOqqKmIkZADEvJkOBryK5dmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768923328; c=relaxed/simple;
	bh=HByIx3OTkYje0OgjKpMXkIH0j5hwQTekP86RLlPkGQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=YrmTTXuPUz39X1F3AyfEG6/GKAcyM9ymkl7QXPYMeAHQ2jUFhdppjPy3eGNGVLjWhDfg53ygAp9E9cdE/3jJV97iIbnsH+og9ha7jIXIB0JD8q89+FgZGl+OgJvjqSP16/+kj4lo6NbpW9GZJkS0uFw0XCbCvYYe5kn67xTC7oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aXQdVeUs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aXQdVeUs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768923325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pI71NuF3wL+FKGs0IUVvsUHF+ZcBb6iC2ob41MiCCHg=;
	b=aXQdVeUsuAllwUCncN1meRPGtwi60SIqxPPgNBmRUuMtjfGH2cxFtXktNwIWHCD/LOpP8h
	Jy54R1wWXJM/8MpxJ8/cDr2HyfljHGpxgnG+zJAgQkf3Bks8aQ6m1a+PrlWgbb3h08DZQD
	r9bIbbxLqJjo+OFvF2S59lzZER4GqRY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-5fOnYNjNNbO7wvfBMiFnjQ-1; Tue,
 20 Jan 2026 10:35:24 -0500
X-MC-Unique: 5fOnYNjNNbO7wvfBMiFnjQ-1
X-Mimecast-MFC-AGG-ID: 5fOnYNjNNbO7wvfBMiFnjQ_1768923322
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 783EB1955DE3
	for <gfs2@lists.linux.dev>; Tue, 20 Jan 2026 15:35:21 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E855718004D8;
	Tue, 20 Jan 2026 15:35:20 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH vv6.19-rc6 4/7] dlm: Constify struct configfs_item_operations and configfs_group_operations
Date: Tue, 20 Jan 2026 10:35:08 -0500
Message-ID: <20260120153511.2201392-4-aahringo@redhat.com>
In-Reply-To: <20260120153511.2201392-1-aahringo@redhat.com>
References: <20260120153511.2201392-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vm3SPY4bu8CzC5vwEZd4hGwuAQglh2ahfeGFH2GXqeI_1768923322
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

'struct configfs_item_operations' and 'configfs_group_operations' are not
modified in this driver.

Constifying these structures moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  29436	  12952	    384	  42772	   a714	fs/dlm/config.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  30076	  12312	    384	  42772	   a714	fs/dlm/config.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/config.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/dlm/config.c b/fs/dlm/config.c
index a0d75b5c83c63..82cc3215663f6 100644
--- a/fs/dlm/config.c
+++ b/fs/dlm/config.c
@@ -324,39 +324,39 @@ struct dlm_member_gone {
 	struct list_head list; /* space->members_gone */
 };
 
-static struct configfs_group_operations clusters_ops = {
+static const struct configfs_group_operations clusters_ops = {
 	.make_group = make_cluster,
 	.drop_item = drop_cluster,
 };
 
-static struct configfs_item_operations cluster_ops = {
+static const struct configfs_item_operations cluster_ops = {
 	.release = release_cluster,
 };
 
-static struct configfs_group_operations spaces_ops = {
+static const struct configfs_group_operations spaces_ops = {
 	.make_group = make_space,
 	.drop_item = drop_space,
 };
 
-static struct configfs_item_operations space_ops = {
+static const struct configfs_item_operations space_ops = {
 	.release = release_space,
 };
 
-static struct configfs_group_operations comms_ops = {
+static const struct configfs_group_operations comms_ops = {
 	.make_item = make_comm,
 	.drop_item = drop_comm,
 };
 
-static struct configfs_item_operations comm_ops = {
+static const struct configfs_item_operations comm_ops = {
 	.release = release_comm,
 };
 
-static struct configfs_group_operations nodes_ops = {
+static const struct configfs_group_operations nodes_ops = {
 	.make_item = make_node,
 	.drop_item = drop_node,
 };
 
-static struct configfs_item_operations node_ops = {
+static const struct configfs_item_operations node_ops = {
 	.release = release_node,
 };
 
-- 
2.43.0


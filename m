Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B543B1A072B
	for <gfs2@lists.linux.dev>; Thu,  3 Oct 2024 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968501; cv=none; b=XamvqIC1/0IczUMfxtxb3UKD0T5V/3FbOGcuaRwW30gPi3K2/y926iVH4mvkcVTOMS5Vd8FnpVbPUQYf+RY/1xS6BjSUbwS5RX8Bdlt6+jSyG77VyO75XwO9v6wPeDlkcIw/GUOJ+LSPRDEsAK9hGEmOzTzkI0+mcLWcDUmgAsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968501; c=relaxed/simple;
	bh=08J95sym7EbUZ5ed1aHKrIi1SAvmbhccq003fACym88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTN9DuRC61MZ+40VX/7ubfMEbDOLckBpvQcB8Aq0H6Bp1nQOyn2BVHX5/jJRBpRQwHtD85D7XKR8mNlLAcq3w8YNZYp+Sq3IvLKcmVJbhczXRWOYJ5GSsE4qSdY0PkqOm2uLhbmOuJ4hlO0lw1E2D6d4SvIuBmvDhhPgLFOYcJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V+y/n/no; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+y/n/no"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727968498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wvSMEY8HtROR8gklRwCjr4mxN3nmXaS9GGq94vmCN2k=;
	b=V+y/n/noDpsw7Chjt43M6ME40tgsjqusd+8bAbXYIP6+fiP1ObEoyMfd8QZjPkpEVgjdjk
	9hXZ/P22LCQqvbU5vQyptdcbxngwuO/6bkPzEJh4sErFfKPdK5nKAdyf9hwNtfcA2KtQfP
	F2Ozf583TlO9DM85QZZRv5IKJjytwP4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-b9oxfTZsPkqb320o_NbS0Q-1; Thu,
 03 Oct 2024 11:14:57 -0400
X-MC-Unique: b9oxfTZsPkqb320o_NbS0Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B01D71955E84;
	Thu,  3 Oct 2024 15:14:55 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 35C351955E8F;
	Thu,  3 Oct 2024 15:14:54 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: trondmy@kernel.org
Cc: anna@kernel.org,
	bcodding@redhat.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	akpm@linux-foundation.org,
	linux-nfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] nfs: sysfs: use kset_type_create_and_add()
Date: Thu,  3 Oct 2024 11:14:34 -0400
Message-ID: <20241003151435.3753959-4-aahringo@redhat.com>
In-Reply-To: <20241003151435.3753959-1-aahringo@redhat.com>
References: <20241003151435.3753959-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Since we have the new udev helper kset_type_create_and_add() helper we
can use it as it allows to have an own kobj_type ktype that is necessary
for nfs for the nfs_netns_object_child_ns_type() kset type callback.

We lose some errno information related to kset_register() in probably
non-existing cases. We return always -ENOMEM as other uses of
kset_create_and_add() does.

The nfs_kset_release() can be replaced by the default udev helper
kset_release() as it does the same functionality.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/nfs/sysfs.c | 29 +++--------------------------
 1 file changed, 3 insertions(+), 26 deletions(-)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index bf378ecd5d9f..a6584203b7ff 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -20,12 +20,6 @@
 
 static struct kset *nfs_kset;
 
-static void nfs_kset_release(struct kobject *kobj)
-{
-	struct kset *kset = container_of(kobj, struct kset, kobj);
-	kfree(kset);
-}
-
 static const struct kobj_ns_type_operations *nfs_netns_object_child_ns_type(
 		const struct kobject *kobj)
 {
@@ -33,35 +27,18 @@ static const struct kobj_ns_type_operations *nfs_netns_object_child_ns_type(
 }
 
 static struct kobj_type nfs_kset_type = {
-	.release = nfs_kset_release,
+	.release = kset_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.child_ns_type = nfs_netns_object_child_ns_type,
 };
 
 int nfs_sysfs_init(void)
 {
-	int ret;
-
-	nfs_kset = kzalloc(sizeof(*nfs_kset), GFP_KERNEL);
+	nfs_kset = kset_type_create_and_add("nfs", NULL, fs_kobj,
+					    &nfs_kset_type);
 	if (!nfs_kset)
 		return -ENOMEM;
 
-	ret = kobject_set_name(&nfs_kset->kobj, "nfs");
-	if (ret) {
-		kfree(nfs_kset);
-		return ret;
-	}
-
-	nfs_kset->kobj.parent = fs_kobj;
-	nfs_kset->kobj.ktype = &nfs_kset_type;
-	nfs_kset->kobj.kset = NULL;
-
-	ret = kset_register(nfs_kset);
-	if (ret) {
-		kfree(nfs_kset);
-		return ret;
-	}
-
 	return 0;
 }
 
-- 
2.43.0


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E87B1A08A9
	for <gfs2@lists.linux.dev>; Thu,  3 Oct 2024 15:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968502; cv=none; b=mDkTqDdSEdM6Dk2PpIUO46OzgQQhi180BKluuOG4SIuMEghFvHzt+VbeKnA0t5MaJrmG/8HZGJWL7jzj+BNUDOyvPTNr9P7z7nNGaHbnE28q+vFBAxcRzfIPZ9vxfNm5d3lUFC32klNJRJdYsaecpEDKN4Jrew6GQ3lcfy1Pxow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968502; c=relaxed/simple;
	bh=2b/wY0DFbQYWHlbG0ppoXS9Fnj2qbZ+0XQWT2jrk4Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njeOH+xR+eH9rzpuTxHJ07DWYbt+/hpNS+ht+9VzJuTaVrP7MTBxQS/w5FkZZ5fLqjq6h51CyOip7Sz9lVhVuqsfZX+omW0gtbhYEYgnGfVUKH5oIzKw6UYUR4GwFWxgcL7RC8uK0+DT3Wsf1iAbhAiQIB8m+mvmMc/8Qoz0X7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MoEByp0k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MoEByp0k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727968500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IlSbepF9atKbQ6z8jk2+CU+FBFUKIVhtlEKWxO1tf0E=;
	b=MoEByp0kGiLcKpj1cMJHplsEjRDj0UsbAgSocmRx7YePToQAhXfYKMZeVL3lsSa4e4u943
	hFDOF2mfHA/Ne/4PRuMK4L4hrsVMBKkuuNEPdX8B24LDnzmJioqSNrzRHcv5d3jzr+l8wZ
	wm1akfGsXAQSXH5A9iyuD+mHXA7Kmzs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-uzO0Hg9iPcOcbyQfpjYwJw-1; Thu,
 03 Oct 2024 11:14:58 -0400
X-MC-Unique: uzO0Hg9iPcOcbyQfpjYwJw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0CFCB19560BC;
	Thu,  3 Oct 2024 15:14:57 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C337B19560A3;
	Thu,  3 Oct 2024 15:14:55 +0000 (UTC)
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
Subject: [PATCH 4/4] nfs: sysfs: use default get_ownership() callback
Date: Thu,  3 Oct 2024 11:14:35 -0400
Message-ID: <20241003151435.3753959-5-aahringo@redhat.com>
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

Since commit 5f81880d5204 ("sysfs, kobject: allow creating kobject
belonging to arbitrary users") it seems that there could be cases for
kobjects belonging to arbitrary users. This callback is set by default
when using kset_create_and_add() to allow creating kobjects with
different ownerships according to its parent.

This patch will assign the default callback now for nfs kobjects for
cases when the parent has different ownership than the default one.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/nfs/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index a6584203b7ff..b5737464b892 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -27,6 +27,7 @@ static const struct kobj_ns_type_operations *nfs_netns_object_child_ns_type(
 }
 
 static struct kobj_type nfs_kset_type = {
+	.get_ownership = kset_get_ownership,
 	.release = kset_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.child_ns_type = nfs_netns_object_child_ns_type,
-- 
2.43.0


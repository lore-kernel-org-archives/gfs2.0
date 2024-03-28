Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96550130A54
	for <gfs2@lists.linux.dev>; Thu, 28 Mar 2024 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640929; cv=none; b=lIzyYp51c8JT5Z4frtuD/0fnspedqUy/8OTvIYz1Xl6+wOs8Kp2Sdge1rxVyFZRqzlOysZ20Na0+laMEmTBZVKW+I0XMBZB53ySoF7K06bhcFvAHiolpVj77P5dEa29LCgrOF40m1qwVq+Y5u7p8twqpzDGmi0TkFbI2NftRe4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640929; c=relaxed/simple;
	bh=Zi2YzVE5fxnJpt63eMJ/mw9EROkjVX+Qb08q/uvOmqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Md/nk7D38ipM0ZOUKWUNlAAAyeovE8NtI7Ga5w+uScKNnJ7Fi9iu0cLI2N7usD5ySYe+CDNmc4cpWV/2uD+iLqdX89zgUZN2FafzeMh1LzTMhlcFbbBIbU2isT+EcVl+NxZgdR29ea1G1/L/hT5MB2ZeYhg9E62QrWE45EZ0I30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iW3t6mY+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iW3t6mY+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711640926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5xRQT39sXZ8HP0IHSLo1H9wILH+lVpbBsOXOhwLiKV4=;
	b=iW3t6mY+38VAbkL2bwahhFGKWgkuvLLQ6CnSv/DR8azPos9+DT9/GI9/UA3qaXoXwF4ptS
	MMj6ojm62yBAyx2FlP7DOiIbRbLBZvQBnOxlvRUbKW2KVPNrlkzmgW+ABv7m/t5wyivrhl
	O+MG8k1023FZHh/TqU6fTqXU+xkxio8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362--gBK-na8MaaT47BxrVlygQ-1; Thu, 28 Mar 2024 11:48:45 -0400
X-MC-Unique: -gBK-na8MaaT47BxrVlygQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D24AC87A9F1
	for <gfs2@lists.linux.dev>; Thu, 28 Mar 2024 15:48:43 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CBD1EC04127;
	Thu, 28 Mar 2024 15:48:43 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev
Subject: [PATCH v6.9-rc1 08/10] dlm: combine switch case fail and default statements
Date: Thu, 28 Mar 2024 11:48:40 -0400
Message-ID: <20240328154842.1099288-8-aahringo@redhat.com>
In-Reply-To: <20240328154842.1099288-1-aahringo@redhat.com>
References: <20240328154842.1099288-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This patch combines the failure and default cases for enqueue and
dequeue a callback to the lkb callback queue that should end in both
cases as it should never happen.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/ast.c  | 5 ++---
 fs/dlm/user.c | 9 ++++-----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/dlm/ast.c b/fs/dlm/ast.c
index cadbcbe0786b..5ea0b62f276b 100644
--- a/fs/dlm/ast.c
+++ b/fs/dlm/ast.c
@@ -160,11 +160,10 @@ void dlm_add_cb(struct dlm_lkb *lkb, uint32_t flags, int mode, int status,
 		}
 		spin_unlock(&ls->ls_cb_lock);
 		break;
-	case DLM_ENQUEUE_CALLBACK_FAILURE:
-		WARN_ON_ONCE(1);
-		break;
 	case DLM_ENQUEUE_CALLBACK_SUCCESS:
 		break;
+	case DLM_ENQUEUE_CALLBACK_FAILURE:
+		fallthrough;
 	default:
 		WARN_ON_ONCE(1);
 		break;
diff --git a/fs/dlm/user.c b/fs/dlm/user.c
index 6f99bbeeac9b..fa99b6074e5c 100644
--- a/fs/dlm/user.c
+++ b/fs/dlm/user.c
@@ -231,10 +231,6 @@ void dlm_user_add_ast(struct dlm_lkb *lkb, uint32_t flags, int mode,
 
 	rv = dlm_enqueue_lkb_callback(lkb, flags, mode, status, sbflags);
 	switch (rv) {
-	case DLM_ENQUEUE_CALLBACK_FAILURE:
-		spin_unlock(&proc->asts_spin);
-		WARN_ON_ONCE(1);
-		goto out;
 	case DLM_ENQUEUE_CALLBACK_NEED_SCHED:
 		kref_get(&lkb->lkb_ref);
 		list_add_tail(&lkb->lkb_cb_list, &proc->asts);
@@ -242,9 +238,12 @@ void dlm_user_add_ast(struct dlm_lkb *lkb, uint32_t flags, int mode,
 		break;
 	case DLM_ENQUEUE_CALLBACK_SUCCESS:
 		break;
+	case DLM_ENQUEUE_CALLBACK_FAILURE:
+		fallthrough;
 	default:
+		spin_unlock(&proc->asts_spin);
 		WARN_ON_ONCE(1);
-		break;
+		goto out;
 	}
 	spin_unlock(&proc->asts_spin);
 
-- 
2.43.0


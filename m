Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBF332BF49
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599062; cv=none; b=PxeqGQjrj25bqVFvMLsBgA0WWxW9Lf5JCJPiGR5qlp0eKVNK9z07K4bANHs/GdJ/5nwOh77DyHMtApxcopcSFAxFIP6azuJLcOjwELk3owh4Qq5DqR8Gkz0reAedqJDZPyAibzUSaeQ4PH71s83/ZQO0BtjY03Zw2yqsdoLnGxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599062; c=relaxed/simple;
	bh=/rfB6Nukt40qoW8Qu43xl3lhx4pmw8cZl4zv7ixbzOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=IrS7Vc5zA36g1789H8hWEIyvBCYBazTub9OLbv+U2B6B/oFpGFnk6K0yCqkBNiYOR6PADJGVdUG1LEGLB2EWtHv4AFpbHRR09SIMm+NIt+F7iH19drGQdnpzcq8aojNrOuV6EyDpm8WhYefXKUZeg8ybd/a6Fkn9fbBJCLoF57Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PTF0TrAc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PTF0TrAc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757599060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5mzi/856M58ZMeT6g2d7Cwt6rxecIsHfA9US4VGmL7A=;
	b=PTF0TrAcjDqsI13re5DlUguaF18nbpg20C/sWieOZPHfOzFNZQm6cOlBeqEwDTdDBYlJfR
	5sFJFtKZf8Ze0WiuydD4n2bUadhQBYGmKXd9tKeHiCBcGtOxYpYERA2MExmmREnHN+8Wut
	5ztYEEGJIiD34ZFuAso0hBOCVDilq8Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-212-rHGqWMiCPNydF-Yv7W35-A-1; Thu,
 11 Sep 2025 09:57:39 -0400
X-MC-Unique: rHGqWMiCPNydF-Yv7W35-A-1
X-Mimecast-MFC-AGG-ID: rHGqWMiCPNydF-Yv7W35-A_1757599058
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 450971953947
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:57:38 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.31])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0792719560BD;
	Thu, 11 Sep 2025 13:57:36 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 05/20] gfs2: Simplify refcounting in do_xmote
Date: Thu, 11 Sep 2025 15:57:10 +0200
Message-ID: <20250911135726.657575-6-agruenba@redhat.com>
In-Reply-To: <20250911135726.657575-1-agruenba@redhat.com>
References: <20250911135726.657575-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8_5pYb0sZ49_vkSwpFbKQnriEguMj9oFf6Bgo-Mm6L8_1757599058
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

In do_xmote(), take the additional glock references close to where those
references are needed.  This will simplify the next commit.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index f1383e9445be..8a7f947883cd 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -760,7 +760,6 @@ __acquires(&gl->gl_lockref.lock)
 	spin_lock(&gl->gl_lockref.lock);
 
 skip_inval:
-	gl->gl_lockref.count++;
 	/*
 	 * Check for an error encountered since we called go_sync and go_inval.
 	 * If so, we can't withdraw from the glock code because the withdraw
@@ -803,6 +802,7 @@ __acquires(&gl->gl_lockref.lock)
 			if (!test_bit(GLF_CANCELING, &gl->gl_flags))
 				clear_bit(GLF_LOCK, &gl->gl_flags);
 			clear_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags);
+			gl->gl_lockref.count++;
 			gfs2_glock_queue_work(gl, GL_GLOCK_DFT_HOLD);
 			return;
 		} else {
@@ -818,6 +818,7 @@ __acquires(&gl->gl_lockref.lock)
 
 		if (!ret) {
 			/* The operation will be completed asynchronously. */
+			gl->gl_lockref.count++;
 			return;
 		}
 		clear_bit(GLF_PENDING_REPLY, &gl->gl_flags);
@@ -837,6 +838,7 @@ __acquires(&gl->gl_lockref.lock)
 
 	/* Complete the operation now. */
 	finish_xmote(gl, target);
+	gl->gl_lockref.count++;
 	gfs2_glock_queue_work(gl, 0);
 }
 
-- 
2.51.0


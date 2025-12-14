Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCF72652BD
	for <gfs2@lists.linux.dev>; Sun, 14 Dec 2025 22:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765752490; cv=none; b=tQdmnSSbmbS6oNZo+vXAZbtWrRVycTIufIqWYG1hqrB6OYkjmJVSM+JCZJK75G6wiFeF3qFue9sVzTHt3zJpmjCDl/S6ME1LPs1g2vcfMgDKgE5scjEu2jv8cyCBXTQSQPFLDL8pSxK9SyNyLLituDOQexaRXQGQLf3gQRq5uIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765752490; c=relaxed/simple;
	bh=oThqMAQE6oXAUrT3f+mJGQ6Kvt/tEVEHiR9UBl3ZtpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nt3W+Cr7GxG4EFVkUkPTtUnyXLWHp089Jo852KTxB54atwai2CwmJ7VestLFv3FFZ/aPhV9ySuqZO0POLJZztIBRKDOpjge8fRCkMmgJv8QUebREIPb6RKfAcUR9tm2ZjEtGnYdkX2iIbW0I6U/nVxulIx8whMb+FD0XwyjztuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WQAAUvht; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQAAUvht"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765752487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=swBe7Ht9/vr+Ziv//T4WHLVkeO4fVKsQfXOXXH7Ug8o=;
	b=WQAAUvhtbfmFPoWODzecmci1REF+kpJccbAHclofkxtlWLWdxu1wonsVNHoIijPkwLC9Q8
	M1dPs9cYZAdbNI+osPV3otFDsANHM/WeiUnGxbAfAWpyT7X2oPZ+XXwXi79YjfBAIhjKiL
	IXRoUbd25aqZ6r9UFYPFd/6QkriNtKE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-2hQOANd4MKa3wlCixhIgvQ-1; Sun,
 14 Dec 2025 17:48:03 -0500
X-MC-Unique: 2hQOANd4MKa3wlCixhIgvQ-1
X-Mimecast-MFC-AGG-ID: 2hQOANd4MKa3wlCixhIgvQ_1765752483
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA0FB19560A5;
	Sun, 14 Dec 2025 22:48:02 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.34.3])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B0DF6180045B;
	Sun, 14 Dec 2025 22:48:00 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+046b605f01802054bff0@syzkaller.appspotmail.com
Subject: Re: [PATCH] gfs2: Fix slab-use-after-free in gfs2_qd_dispose
Date: Sun, 14 Dec 2025 22:47:58 +0000
Message-ID: <20251214224759.2324369-1-agruenba@redhat.com>
In-Reply-To: <20251213064304.148987-1-kartikey406@gmail.com>
References: <20251213064304.148987-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hello,

> In gfs2_qd_dispose(), the quota data (qd) is removed from qd_list and
> qd_hlist, but not removed from the LRU list before call_rcu() is
> invoked to free the object.
> 
> This can lead to a use-after-free when the shrinker (gfs2_qd_shrink_scan)
> runs concurrently with filesystem unmount. The shrinker attempts to walk
> the LRU list via list_lru_shrink_walk(), accessing quota data that has
> already been freed by the RCU callback (gfs2_qd_dealloc).
> 
> Fix this by calling list_lru_del_obj() to remove the quota data from
> the LRU list before scheduling the RCU callback.
> 
> Fixes: faada74a90563 ("gfs2: Factor out duplicate quota data disposal code")
> Reported-by: syzbot+046b605f01802054bff0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=046b605f01802054bff0
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
> Note: Only compile-tested. No reproducer available from syzbot.
> ---
>  fs/gfs2/quota.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> index b1692f12a602..85b0b5105b4b 100644
> --- a/fs/gfs2/quota.c
> +++ b/fs/gfs2/quota.c
> @@ -125,6 +125,8 @@ static void gfs2_qd_dispose(struct gfs2_quota_data *qd)
>       hlist_bl_del_rcu(&qd->qd_hlist);
>       spin_unlock_bucket(qd->qd_hash);
>  
> +     list_lru_del_obj(&gfs2_qd_lru, &qd->qd_lru);
> +

thanks for the suggestion, but this will call list_lru_del_obj() a
second time on the gfs2_qd_shrink_scan() -> gfs2_qd_list_dispose() ->
gfs2_qd_dispose() code path.  The bug also isn't introduced by the
commit you've identified.

The below fix should be better.

Andreas

--

Subject: gfs2: Fix slab-use-after-free in qd_put

Commit a475c5dd16e5 ("gfs2: Free quota data objects synchronously")
started freeing quota data objects during filesystem shutdown instead of
putting them back onto the LRU list, but it failed to remove these
objects from the LRU list, causing LRU list corruption.  This caused
use-after-free when the shrinker (gfs2_qd_shrink_scan) tried to access
already-freed objects on the LRU list.

Fix this by removing qd objects from the LRU list before freeing them in
qd_put().

Initial fix from Deepanshu Kartikey <kartikey406@gmail.com>.

Fixes: a475c5dd16e5 ("gfs2: Free quota data objects synchronously")
Reported-by: syzbot+046b605f01802054bff0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=046b605f01802054bff0
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/quota.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 21dfe1e48da6..1c3455093ae8 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -334,6 +334,7 @@ static void qd_put(struct gfs2_quota_data *qd)
 		lockref_mark_dead(&qd->qd_lockref);
 		spin_unlock(&qd->qd_lockref.lock);
 
+		list_lru_del_obj(&gfs2_qd_lru, &qd->qd_lru);
 		gfs2_qd_dispose(qd);
 		return;
 	}
-- 
2.51.0


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E796F15359B
	for <gfs2@lists.linux.dev>; Tue,  9 Apr 2024 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712681129; cv=none; b=pIA5yKdfgZmemqpJZOOHA0ECH5M6CESfttwLRbZOHDi30iyvDOCjo4FIGPqj8k0YkPq84HqMGL9pQhsvGi5r6QlX9c+tYUvdRL+Om0LpuoTargDYDhpsU82YfwyhcZ8XQOINrxjiovwyzrbXq2avMi/Css/fX3DhYdcze7lscEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712681129; c=relaxed/simple;
	bh=DnyLLWsmgzckf3NtKHkYXRsWVTAYpAP6uyhS/npCwtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MzDK6KbU+lTR2pC5oN43O00dhAdwx36gpnt0zY6hFjZR7Lv7qSpAdYGZYeZhlwnIQCUKb+B/YSx4cRmg1eH2AkQWKR3wAs7utxzFqkpzUVpjOuG6y0BASimvKDSqK2CE7iiE+h2dE7imtE5+YILnfu62ByqOJbDSB6xXINYhsCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RaYAhFG5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RaYAhFG5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712681126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Au2krm/ObURL1BF3arpeSQyg8twGcsG3Y5z7E2HgE7I=;
	b=RaYAhFG5WSEoSTXax9mZX5ELpyVWKVHiWNg9kVU94n9BV/Zesp2IpIbAU0EQGumpxJebOS
	n9mD1LrPaorjcma5mRAuKNgytg1gnpTmV0LLf/AhIEDK92sqKbYLDb9GttMDy81l1PQdfP
	sajRMDxwP181UUiwlc0CxCChTcFaEv4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-mIauiymwMP6Gvv3QT3cKng-1; Tue, 09 Apr 2024 12:45:25 -0400
X-MC-Unique: mIauiymwMP6Gvv3QT3cKng-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 362041049BC6
	for <gfs2@lists.linux.dev>; Tue,  9 Apr 2024 16:45:25 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.28])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AB910C09A05;
	Tue,  9 Apr 2024 16:45:24 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 15/15] gfs2: Fix lru_count accounting
Date: Tue,  9 Apr 2024 18:45:05 +0200
Message-ID: <20240409164508.79570-16-agruenba@redhat.com>
In-Reply-To: <20240409164508.79570-1-agruenba@redhat.com>
References: <20240409164508.79570-1-agruenba@redhat.com>
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

Currently, gfs2_scan_glock_lru() decrements lru_count when a glock is
moved onto the dispose list.  When such a glock is then stolen from the
dispose list while gfs2_dispose_glock_lru() doesn't hold the lru_lock,
lru_count will be decremented again, so the counter will eventually go
negative.

This bug has existed in one form or another since at least commit
97cc1025b1a91 ("GFS2: Kill two daemons with one patch").

Fix this by only decrementing lru_count when we actually remove a glock
and schedule for it to be unlocked and dropped.  We also don't need to
remove and then re-add glocks when we can just as well move them back
onto the lru_list when necessary.

In addition, return the number of glocks freed as we should, not the
number of glocks moved onto the dispose list.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 5b2fd5994cfc..4be140ab53e4 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1988,29 +1988,30 @@ static bool can_free_glock(struct gfs2_glock *gl)
  * private)
  */
 
-static void gfs2_dispose_glock_lru(struct list_head *list)
+static long gfs2_dispose_glock_lru(struct list_head *list)
 __releases(&lru_lock)
 __acquires(&lru_lock)
 {
 	struct gfs2_glock *gl;
+	long freed = 0;
 
 	list_sort(NULL, list, glock_cmp);
 
 	while(!list_empty(list)) {
 		gl = list_first_entry(list, struct gfs2_glock, gl_lru);
-		list_del_init(&gl->gl_lru);
-		clear_bit(GLF_LRU, &gl->gl_flags);
 		if (!spin_trylock(&gl->gl_lockref.lock)) {
 add_back_to_lru:
-			list_add(&gl->gl_lru, &lru_list);
-			set_bit(GLF_LRU, &gl->gl_flags);
-			atomic_inc(&lru_count);
+			list_move(&gl->gl_lru, &lru_list);
 			continue;
 		}
 		if (!can_free_glock(gl)) {
 			spin_unlock(&gl->gl_lockref.lock);
 			goto add_back_to_lru;
 		}
+		list_del_init(&gl->gl_lru);
+		atomic_dec(&lru_count);
+		clear_bit(GLF_LRU, &gl->gl_flags);
+		freed++;
 		gl->gl_lockref.count++;
 		if (gl->gl_state != LM_ST_UNLOCKED)
 			handle_callback(gl, LM_ST_UNLOCKED, 0, false);
@@ -2018,6 +2019,7 @@ __acquires(&lru_lock)
 		spin_unlock(&gl->gl_lockref.lock);
 		cond_resched_lock(&lru_lock);
 	}
+	return freed;
 }
 
 /**
@@ -2039,14 +2041,11 @@ static long gfs2_scan_glock_lru(int nr)
 	list_for_each_entry_safe(gl, next, &lru_list, gl_lru) {
 		if (nr-- <= 0)
 			break;
-		if (can_free_glock(gl)) {
+		if (can_free_glock(gl))
 			list_move(&gl->gl_lru, &dispose);
-			atomic_dec(&lru_count);
-			freed++;
-		}
 	}
 	if (!list_empty(&dispose))
-		gfs2_dispose_glock_lru(&dispose);
+		freed = gfs2_dispose_glock_lru(&dispose);
 	spin_unlock(&lru_lock);
 
 	return freed;
-- 
2.44.0


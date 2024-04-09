Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C174152DE2
	for <gfs2@lists.linux.dev>; Tue,  9 Apr 2024 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712681127; cv=none; b=SR8LkjTmE+Bgwkz3lmeLb5ajWtlc62HehVIkY4Bqe9N1qJXX+qLo1sTf/vFrH7pPuTxdcyauc8YYZTWRaWwIWeTxUwSqtSiexGaPtT1f6YGfgq7iJI/s/ph+VhlTX5hXirTIL1hgL4GImJoJr1M0blnki/XL1rUvC2o23oQwNlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712681127; c=relaxed/simple;
	bh=eFENms8ozOuPCBh+AlMy1+Dw3Qo6mX7TqBjzuybzsA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kt2khMegBMqk6UwWOc7wIADlR1qSc85IOdzKrsxK7Lh58QZoCuBncUS4dZsrGayDx8KX8dbG6DcfmdYAVvsAtdAzZJQKX5uEOpXxN7qGX1Jp/ySczqcttExqVJSrkMdH9OOD30YIKibXCkwXBC/3/pmg/lO9/QpDIoM0F2zpYnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4AZx2Dd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4AZx2Dd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712681125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a8TqokGbH8s5Wk/qQp7Fbg4N3nBlOg5BqanfbtHUKKk=;
	b=E4AZx2DdvTZyThH2ULqukXtBVD4rwPHlUUVtvYJdZ0VfvTjq3mrcLslf9okRzfn8Am4XH6
	QZb6odtOVsZqsdEZyDoUwwO594QtE3Ro8fCK/+UAKRoDauhDH4CQdJo+7F6fmsufGmXyek
	GcuamRjhYygoHpXZKO0ga2pTy2Cw4DU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-ZON2tfQHOGa_ZVZ2_4SANg-1; Tue, 09 Apr 2024 12:45:23 -0400
X-MC-Unique: ZON2tfQHOGa_ZVZ2_4SANg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC4DD80B3E0
	for <gfs2@lists.linux.dev>; Tue,  9 Apr 2024 16:45:23 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.28])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2DE45C0157E;
	Tue,  9 Apr 2024 16:45:23 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 13/15] gfs2: Fix "Make glock lru list scanning safer"
Date: Tue,  9 Apr 2024 18:45:03 +0200
Message-ID: <20240409164508.79570-14-agruenba@redhat.com>
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

Commit 228804a35caa tried to add a refcount check to
gfs2_scan_glock_lru() to make sure that glocks that are still referenced
cannot be freed.  It failed to account for the bias state_change() adds
to the refcount for held glocks, so held glocks are no longer removed
from the glock cache, which can lead to out-of-memory problems.  Fix
that.  (The inodes those glocks are associated with do get shrunk and do
get pushed out of memory.)

In addition, use the same eligibility check in gfs2_scan_glock_lru() and
gfs2_dispose_glock_lru().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 2882a42e88aa..04e0a8ac61d7 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1987,6 +1987,14 @@ static int glock_cmp(void *priv, const struct list_head *a,
 	return 0;
 }
 
+static bool can_free_glock(struct gfs2_glock *gl)
+{
+	bool held = gl->gl_state != LM_ST_UNLOCKED;
+
+	return !test_bit(GLF_LOCK, &gl->gl_flags) &&
+	       gl->gl_lockref.count == held;
+}
+
 /**
  * gfs2_dispose_glock_lru - Demote a list of glocks
  * @list: The list to dispose of
@@ -2020,7 +2028,7 @@ __acquires(&lru_lock)
 			atomic_inc(&lru_count);
 			continue;
 		}
-		if (test_bit(GLF_LOCK, &gl->gl_flags)) {
+		if (!can_free_glock(gl)) {
 			spin_unlock(&gl->gl_lockref.lock);
 			goto add_back_to_lru;
 		}
@@ -2052,16 +2060,10 @@ static long gfs2_scan_glock_lru(int nr)
 	list_for_each_entry_safe(gl, next, &lru_list, gl_lru) {
 		if (nr-- <= 0)
 			break;
-		/* Test for being demotable */
-		if (!test_bit(GLF_LOCK, &gl->gl_flags)) {
-			if (!spin_trylock(&gl->gl_lockref.lock))
-				continue;
-			if (!gl->gl_lockref.count) {
-				list_move(&gl->gl_lru, &dispose);
-				atomic_dec(&lru_count);
-				freed++;
-			}
-			spin_unlock(&gl->gl_lockref.lock);
+		if (can_free_glock(gl)) {
+			list_move(&gl->gl_lru, &dispose);
+			atomic_dec(&lru_count);
+			freed++;
 		}
 	}
 	if (!list_empty(&dispose))
-- 
2.44.0


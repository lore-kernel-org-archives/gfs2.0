Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836311A08A4
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599083; cv=none; b=IPXMGbXwluM5sV0lRE8SUCrmZPTMq2JfqHhzE19w6er9h6ANkH3FuwF3cqHp3Twe2PU+b6ojzz+plHb6c+V+6Lax9HbSh8zU9HBpndJOv3wZSrJsQxg70Im7zAGQ8NDsY9Pp/7EHMLLo88BqNdXv53m/CzjfqSFIp0FWFuXkq1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599083; c=relaxed/simple;
	bh=KsE6dFTomCzus9rkARwCfYrUTx+EepT4sj/ZpYgysj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=IcyFT//uyGdwXRD2dd7OmXehVNln1cnkcluNiO8p4r3eTF8usgby0uOwuqNP/dD/cjOyvsTs1HZ+KjHEMeFmT6G25dUkLAuMa4kMXP901q2nDRKcD/FVZ/uCEOBgXK0HHU/scUwILhsNATddWXkp+iETdXRaZPNJue2Foh38W0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gredFWFQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gredFWFQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757599080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G9xuMDiWNHA0wMVOgsICtDyUjvBXctnaE4oKpbyA9m0=;
	b=gredFWFQYZv7+F6+c+ZEmNt39Mmf5HzjQQgC8x+Cs4FiuLAvGqOxxqGW5TTJMW/m2hXqcU
	9QwGS4P9eCnTK/OxxDDYgtznejKlbA80ssohA+3dsAhwLMsaf2aFn4GgXVz3jWoWWS1SO/
	gFws4Yp11lx5wRuqheKIhQQVd3W6xG4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-nMs4By4MOwCM20wku9ptnw-1; Thu,
 11 Sep 2025 09:57:59 -0400
X-MC-Unique: nMs4By4MOwCM20wku9ptnw-1
X-Mimecast-MFC-AGG-ID: nMs4By4MOwCM20wku9ptnw_1757599078
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5656C19774FA
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:57:58 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.31])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1894319560B1;
	Thu, 11 Sep 2025 13:57:56 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 16/20] gfs2: Simplify do_promote
Date: Thu, 11 Sep 2025 15:57:21 +0200
Message-ID: <20250911135726.657575-17-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 26_rgqj1t0L-DhD5xs1eipkVO443xcAklnOvQ-3Q8ho_1757599078
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

While not immediately obvious, do_promote() returns whether or not there
are any active holders in the queue.  But the function description is
confusing, and this information is easy to come by for callers anyway,
so turn do_promote() into a void function.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index e8b630a58da8..38f320e13a36 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -481,11 +481,9 @@ int gfs2_instantiate(struct gfs2_holder *gh)
 /**
  * do_promote - promote as many requests as possible on the current queue
  * @gl: The glock
- * 
- * Returns true on success (i.e., progress was made or there are no waiters).
  */
 
-static bool do_promote(struct gfs2_glock *gl)
+static void do_promote(struct gfs2_glock *gl)
 {
 	struct gfs2_holder *gh, *current_gh;
 
@@ -496,13 +494,10 @@ static bool do_promote(struct gfs2_glock *gl)
 		if (!may_grant(gl, current_gh, gh)) {
 			/*
 			 * If we get here, it means we may not grant this
-			 * holder for some reason. If this holder is at the
-			 * head of the list, it means we have a blocked holder
-			 * at the head, so return false.
+			 * holder for some reason.
 			 */
-			if (list_is_first(&gh->gh_list, &gl->gl_holders))
-				return false;
-			do_error(gl, 0); /* Fail queued try locks */
+			if (current_gh)
+				do_error(gl, 0); /* Fail queued try locks */
 			break;
 		}
 		set_bit(HIF_HOLDER, &gh->gh_iflags);
@@ -511,7 +506,6 @@ static bool do_promote(struct gfs2_glock *gl)
 		if (!current_gh)
 			current_gh = gh;
 	}
-	return true;
 }
 
 /**
@@ -855,7 +849,8 @@ __acquires(&gl->gl_lockref.lock)
 	} else {
 		if (test_bit(GLF_DEMOTE, &gl->gl_flags))
 			gfs2_demote_wake(gl);
-		if (do_promote(gl))
+		do_promote(gl);
+		if (find_first_holder(gl))
 			goto out_unlock;
 		gh = find_first_waiter(gl);
 		if (!gh)
-- 
2.51.0


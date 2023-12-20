Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D40487A8
	for <gfs2@lists.linux.dev>; Wed, 20 Dec 2023 20:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVTVm7Zx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703103147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h6pUMIAIvx5UN3g7RX4VNKxe1PqOQK0ZgjaKJXAP3BA=;
	b=GVTVm7Zxl6ZiXt1Cc5YdD84F/pRt9W7ccfh/n/yYAKOCTD/8WVNBAWI7eaPijv4Uj7wZR7
	Kta6SMeCXbe9WoP/ru71U4/cOhr+WrdNFrOx+lGYvzIkd20eYeHWM1ZpAvZrv3YyjbwR0Y
	hvQYoG8LwzrU1k3H7oqqqNjRfY/8QuY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-otO8JuwZPgi2WBtx2Myb-A-1; Wed, 20 Dec 2023 15:12:25 -0500
X-MC-Unique: otO8JuwZPgi2WBtx2Myb-A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC1D0101A551
	for <gfs2@lists.linux.dev>; Wed, 20 Dec 2023 20:12:25 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.39])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 33C42492BE6;
	Wed, 20 Dec 2023 20:12:25 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 4/4] gfs2: Lift withdraw check out of gfs2_ail1_empty
Date: Wed, 20 Dec 2023 21:12:22 +0100
Message-ID: <20231220201222.1581061-4-agruenba@redhat.com>
In-Reply-To: <20231220201222.1581061-1-agruenba@redhat.com>
References: <20231220201222.1581061-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Lift the check for the SDF_WITHDRAWING flag out of gfs2_ail1_empty() and
into its callers.  This is needed so that gfs2_flush_revokes() can drop
the sd_log_lock spinlock before triggering a withdraw if necessary.

Instead of checking for the SDF_WITHDRAWING flag, use
gfs2_withdrawing().  Also, the low-level code triggering the delayed
withdraw reports when there is a problem, so there is no need to report
that again.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/log.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 8691839104b7..fdef6bc77c54 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -373,11 +373,6 @@ static bool gfs2_ail1_empty(struct gfs2_sbd *sdp, int max_revokes)
 	empty = list_empty(&sdp->sd_ail1_list);
 	spin_unlock(&sdp->sd_ail_lock);
 
-	if (test_bit(SDF_WITHDRAWING, &sdp->sd_flags)) {
-		gfs2_lm(sdp, "fatal: I/O error(s)\n");
-		gfs2_withdraw(sdp);
-	}
-
 	return empty;
 }
 
@@ -815,6 +810,9 @@ void gfs2_flush_revokes(struct gfs2_sbd *sdp)
 	gfs2_log_lock(sdp);
 	gfs2_ail1_empty(sdp, max_revokes);
 	gfs2_log_unlock(sdp);
+
+	if (gfs2_withdrawing(sdp))
+		gfs2_withdraw(sdp);
 }
 
 /**
@@ -987,7 +985,13 @@ static void empty_ail1_list(struct gfs2_sbd *sdp)
 		gfs2_ail1_start(sdp);
 		gfs2_ail1_wait(sdp);
 		empty = gfs2_ail1_empty(sdp, 0);
+
+		if (gfs2_withdrawing_or_withdrawn(sdp))
+			break;
 	}
+
+	if (gfs2_withdrawing(sdp))
+		gfs2_withdraw(sdp);
 }
 
 /**
@@ -1344,6 +1348,9 @@ int gfs2_logd(void *data)
 				t);
 	}
 
+	if (gfs2_withdrawing(sdp))
+		gfs2_withdraw(sdp);
+
 	return 0;
 }
 
-- 
2.43.0


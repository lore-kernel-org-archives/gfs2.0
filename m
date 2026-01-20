Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A739028980F
	for <gfs2@lists.linux.dev>; Tue, 20 Jan 2026 15:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768923328; cv=none; b=U+KM6ykPPYpTGntma44eLa4GNvwcoOgG/TOYRvo7iUmSl6XFs6JBcpOtr81yCfFkypfI+s/0OOzrQAx4ZZOKxnVsjsdSJ8UEmWU8yKhigxIS3fEskTApxLqj1x6WBneyjhtWzXO30V6QID9LwWJPrLofHnnheC5bOfaB9lpekOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768923328; c=relaxed/simple;
	bh=37ZHSe7ZmJn5kG0SoOtvQHoO6d/vod1Mw04ms53CObk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=D51r/qqmIxOZ8yW91thlEb1Y2e5L4HJKvRhflmseMDLiuPDgV5p6JHFrhYNLNQtali4rZr0aIOlhaKJ/TSB6r5DVTivTHrRNLrUsYCNw6OWJE8gB5uDX2DdlxX6f4m1BcnpqIt1NjplkfFnghAIuzv3yuCUJ+1oOHgnTMEKYcJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=apqsj1Cj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="apqsj1Cj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768923325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i5QF0GbEgnyW/VO7jxJvfmlF0/HguQOr2b/OChKtiSY=;
	b=apqsj1CjBYdJZSwzuxxLMmEIc0IoTySrD4hwg7BZ6ZRtDxJK8PzWD7du8oSRGnmJfwce5H
	w67fClz0hb0uFDiMbuOPdyDEoR2B0Kd05k+Y0v71uS9pM7dE7tNjrU2JeoKTJS7CMbhRga
	p2sLucPdttuKTCDgrANyCxRbBB3+ne0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-u0XR7FUgM6m6oGb61_0NAQ-1; Tue,
 20 Jan 2026 10:35:24 -0500
X-MC-Unique: u0XR7FUgM6m6oGb61_0NAQ-1
X-Mimecast-MFC-AGG-ID: u0XR7FUgM6m6oGb61_0NAQ_1768923323
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5DD881956078
	for <gfs2@lists.linux.dev>; Tue, 20 Jan 2026 15:35:22 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9F88618004D8;
	Tue, 20 Jan 2026 15:35:21 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH vv6.19-rc6 5/7] fs/dlm/dir: remove unuse variable count_match
Date: Tue, 20 Jan 2026 10:35:09 -0500
Message-ID: <20260120153511.2201392-5-aahringo@redhat.com>
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
X-Mimecast-MFC-PROC-ID: m5LBx1ThVPPV031HPyov5baAYLnUJVYSjr330C1zB_Y_1768923323
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Alex Shi <alexs@kernel.org>

The variable was never used after introduced. Better to comment it if we
want to keep the info.

fs/dlm/dir.c:65:26: error: variable 'count_match' set but not used [-Werror,-Wunused-but-set-variable]
   65 |         unsigned int count = 0, count_match = 0, count_bad = 0, count_add = 0;
      |                                 ^
1 error generated.

Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: gfs2@lists.linux.dev
Cc: Alexander Aring <aahringo@redhat.com>
Cc: David Teigland <teigland@redhat.com>
Acked-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/dlm/dir.c b/fs/dlm/dir.c
index b1ab0adbd9d02..01c292379f5b2 100644
--- a/fs/dlm/dir.c
+++ b/fs/dlm/dir.c
@@ -62,7 +62,7 @@ int dlm_recover_directory(struct dlm_ls *ls, uint64_t seq)
 	char *b, *last_name = NULL;
 	int error = -ENOMEM, last_len, nodeid, result;
 	uint16_t namelen;
-	unsigned int count = 0, count_match = 0, count_bad = 0, count_add = 0;
+	unsigned int count = 0, count_bad = 0, count_add = 0;
 
 	log_rinfo(ls, "dlm_recover_directory");
 
@@ -157,12 +157,12 @@ int dlm_recover_directory(struct dlm_ls *ls, uint64_t seq)
 				}
 
 				/* The name was found in rsbtbl, and the
-				 * master nodeid matches memb->nodeid. */
+				 * master nodeid matches memb->nodeid.
 
 				if (result == DLM_LU_MATCH &&
 				    nodeid == memb->nodeid) {
 					count_match++;
-				}
+				}*/
 
 				/* The name was not found in rsbtbl and was
 				 * added with memb->nodeid as the master. */
-- 
2.43.0


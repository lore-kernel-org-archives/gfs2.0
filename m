Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE24A1D5AD5
	for <gfs2@lists.linux.dev>; Wed, 25 Sep 2024 22:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727301848; cv=none; b=LbJyCWPXZzsAtZzaDctvuUz1/exo3nSIpEEHfmaHZ1i0y3HNu9v26w8Hb/j1lATRTGIUFTVNYbe8y85StG9ZPWauJNubdPAIks3KNvoySFDb8Jy6SDbJ/rxDhPeNzvKK11mahBOZ3n3HbO+FIUWsN6N17lwV5ZWWZ8nzOIblJWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727301848; c=relaxed/simple;
	bh=ooWafLelNLccswAOFAiVerm0/NaZKXVyiZGy2QzZeyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OY/kIkiut0I7/1QyOhLmva7miLYykd1KyLc39E5n2SvuFpUglsZKXN/n8VAZwLBdisVaTMKPDJrllp4TmdvjWqP+ZDTTqx8dsz/nR0GefA7YSYm6OysWGAeaiw8A62ODGD3yndPiR4wkCyUh5zB3RSH2rs9pJVea4xACa/cIk1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IkGo7u45; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IkGo7u45"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727301838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pkQ/Nahp3AmJlPgX75pjJ+QkIKD+GoTGtZARrD3lvF0=;
	b=IkGo7u452lCNwROCR1144A3l1hdg2YntbqfMQfdiigz/IqcXL5DkzzRju39IIDIInvtKZW
	QwDwORlNgoi4kVem+xcOj8sH/DR11OdZdwrEpjtqxYd0YFhieH1cgnEIW4uYoPtkWO8iuf
	DErse2WscxBw0qHv4W65Aucm3cdV784=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-DD619sT1NLC5KL_2mIur5w-1; Wed,
 25 Sep 2024 18:03:54 -0400
X-MC-Unique: DD619sT1NLC5KL_2mIur5w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 792CD19344FB
	for <gfs2@lists.linux.dev>; Wed, 25 Sep 2024 22:03:53 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.77])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 60E9519560AA;
	Wed, 25 Sep 2024 22:03:52 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 11/16] gfs2: Call gfs2_queue_verify_delete from gfs2_evict_inode
Date: Thu, 26 Sep 2024 00:03:21 +0200
Message-ID: <20240925220331.417856-12-agruenba@redhat.com>
In-Reply-To: <20240925220331.417856-1-agruenba@redhat.com>
References: <20240925220331.417856-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Move calls to gfs2_queue_verify_delete() into gfs2_evict_inode().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 13 ++-----------
 fs/gfs2/super.c |  9 ++++++++-
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 95f082f13a8c..3736e7f3b381 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -959,10 +959,9 @@ static void gfs2_glock_poke(struct gfs2_glock *gl)
 	gfs2_holder_uninit(&gh);
 }
 
-static bool gfs2_try_evict(struct gfs2_glock *gl)
+static void gfs2_try_evict(struct gfs2_glock *gl)
 {
 	struct gfs2_inode *ip;
-	bool evicted = false;
 
 	/*
 	 * If there is contention on the iopen glock and we have an inode, try
@@ -997,9 +996,7 @@ static bool gfs2_try_evict(struct gfs2_glock *gl)
 			gfs2_glock_poke(ip->i_gl);
 			iput(&ip->i_inode);
 		}
-		evicted = !ip;
 	}
-	return evicted;
 }
 
 bool gfs2_queue_try_to_evict(struct gfs2_glock *gl)
@@ -1048,13 +1045,7 @@ static void delete_work_func(struct work_struct *work)
 		 * care about compatibility with such nodes, we can skip this
 		 * step entirely.
 		 */
-		if (gfs2_try_evict(gl)) {
-			if (!test_bit(SDF_KILL, &sdp->sd_flags)) {
-				gfs2_glock_hold(gl);
-				if (!gfs2_queue_verify_delete(gl, true))
-					gfs2_glock_put(gl);
-			}
-		}
+		gfs2_try_evict(gl);
 	}
 
 	if (verify_delete) {
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 55cbe672d42e..90cdc9212f12 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1499,8 +1499,15 @@ static void gfs2_evict_inode(struct inode *inode)
 
 	gfs2_holder_mark_uninitialized(&gh);
 	behavior = evict_should_delete(inode, &gh);
-	if (behavior == EVICT_SHOULD_DEFER_DELETE)
+	if (behavior == EVICT_SHOULD_DEFER_DELETE &&
+	    !test_bit(SDF_KILL, &sdp->sd_flags)) {
+		struct gfs2_glock *io_gl = ip->i_iopen_gh.gh_gl;
+
+		gfs2_glock_hold(io_gl);
+		if (!gfs2_queue_verify_delete(io_gl, true))
+			gfs2_glock_put(io_gl);
 		goto out;
+	}
 	if (behavior == EVICT_SHOULD_DELETE)
 		ret = evict_unlinked_inode(inode);
 	else
-- 
2.46.0


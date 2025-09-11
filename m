Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7139309EFF
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599086; cv=none; b=r164fz9lmxftOqwHhSpECkf4nD4iZGrU/OIynTQ6gb0/N43oea5BoAH1p/gI8ltWEAqiVcnESjjpAIFtwL12TRQ7nadVX8IHbrW8B10SUzU7DLwgZF++SpnOFtjQ9i/AlZMkWKicfUDvPtAAnL33LXat1zbgnxG7mC0qYDiSvL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599086; c=relaxed/simple;
	bh=jdkBxZDSuMOPtmhH9ozwFwiS6HSjgP+kQEJevOpoRJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=jTxVqI2PWmYrDdWoyqoJl53+jIJOCUd1pUfZ3JGOaOHGwaklmoj/MacF5YEtfSTNLVZOJC7Ik6t8izs1gH1FFCEQ7gWgyLVG1Hp6gonwBg2gWMNxBGYVEFH8QTU0K5Hq91HEPgrJkDreWK6uunTMTB9x5gmQUFUslJc4038dQNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IaX3uUDs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IaX3uUDs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757599084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y6DWAyOKGyOR7Y1dqDFMW1KcMwLWzRNekpn2XzPrpS8=;
	b=IaX3uUDsoadC/ooYufbz7caGbD1IRVwrguMsn0TLyINhTIG8QSM/ayWHyGdkhty7gN1bn3
	Na3FVF3Ll+peLOG9QX7L5dYFkLxTgQmnWJOilDa6zAQnR2HRrHgUME+tgarsYGFZXVIF1/
	9jnSkqB9sP1lOVWx/DrfOhEVJGvCqx0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-g7tRu4MDPySIm_KqvBTxTg-1; Thu,
 11 Sep 2025 09:58:02 -0400
X-MC-Unique: g7tRu4MDPySIm_KqvBTxTg-1
X-Mimecast-MFC-AGG-ID: g7tRu4MDPySIm_KqvBTxTg_1757599082
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 238111800578
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:58:02 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.31])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D984A19560B1;
	Thu, 11 Sep 2025 13:58:00 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 18/20] gfs2: Minor run_queue fixes
Date: Thu, 11 Sep 2025 15:57:23 +0200
Message-ID: <20250911135726.657575-19-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: PZ6pRhPeYQ4NqHH9rtN2QUBH_-KwMJZgly2PESgHEuE_1757599082
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Provide a better description of why the GLF_DEMOTE_IN_PROGRESS flag
cannot be set.

Function do_xmote() may block, so make sure it isn't called when
nonblock is true.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 1eba27bb5f3c..747ee7ca44e2 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -832,7 +832,12 @@ __acquires(&gl->gl_lockref.lock)
 		return;
 	set_bit(GLF_LOCK, &gl->gl_flags);
 
-	/* While a demote is in progress, the GLF_LOCK flag must be set. */
+	/*
+	 * The GLF_DEMOTE_IN_PROGRESS flag is only set intermittently during
+	 * locking operations.  We have just started a locking operation by
+	 * setting the GLF_LOCK flag, so the GLF_DEMOTE_IN_PROGRESS flag must
+	 * be cleared.
+	 */
 	GLOCK_BUG_ON(gl, test_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags));
 
 	if (test_bit(GLF_DEMOTE, &gl->gl_flags)) {
@@ -859,6 +864,8 @@ __acquires(&gl->gl_lockref.lock)
 	gh = find_first_waiter(gl);
 	if (!gh)
 		goto out_unlock;
+	if (nonblock)
+		goto out_sched;
 	gl->gl_target = gh->gh_state;
 	if (!(gh->gh_flags & (LM_FLAG_TRY | LM_FLAG_TRY_1CB)))
 		do_error(gl, 0); /* Fail queued try locks */
-- 
2.51.0


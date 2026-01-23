Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664E41FFC59
	for <gfs2@lists.linux.dev>; Fri, 23 Jan 2026 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769182273; cv=none; b=IYD83nYtVEtUQyVH01dB5taDIrWwheX8k07RJPxmct4xwDsUPe+sOOuPQDuUVoGoO3qb584/GRIsv7XhlvO2C1R5xvLfNRM5Z0xXSS60Y5rlsqqPPyhUGmYp3qet2MAYYA2T5XxYd7s8J8UnLjLsdIfzDXvhai1nzmZB4E/IeV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769182273; c=relaxed/simple;
	bh=XJiWUhoy1YguL/rO3tG7+iFUhgkUcJbSmAR7n4TS2VY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=j3g4XYsE7V5U932FcLbZ9CDPXNEVM4wkuBFjqCsrswNZJWzr1hF+7BVw9qiiD8U2NMsX8bC0tTjwfb90M7DF7FR6hx5vEIYfSwtOKH+DQvrC6l7lAts3RZiw+qeKmWOmkQLoctgC4t+n97Qo6znFpoY9rwz1BcSwylSxCu2hElc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eb5X35gZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eb5X35gZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769182271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uuNNJA+q+Tz2RtDNJgNXhyMBAQ3EIf4GhFeyEzQGSag=;
	b=eb5X35gZny2djjTQHu3XZE3M8KJQYxW/f/Cxsf4NAD03S53cV/H+DeuQsGxPopuSfPMdAs
	SxsiDKgKjpb1+1A4fIqb1h7sp6NRetiuvN3CjwRfjLRMTaJNtp3H8IBYS594iI3T0lKYiG
	Td9YgLV7kL8ybef/JZpGoC8W/YqLjFs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-JYBVrGXNPE6W8wBxV0OIWQ-1; Fri,
 23 Jan 2026 10:31:09 -0500
X-MC-Unique: JYBVrGXNPE6W8wBxV0OIWQ-1
X-Mimecast-MFC-AGG-ID: JYBVrGXNPE6W8wBxV0OIWQ_1769182269
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E2421800612
	for <gfs2@lists.linux.dev>; Fri, 23 Jan 2026 15:31:09 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.52])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0968530002D1;
	Fri, 23 Jan 2026 15:31:07 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 01/13] gfs2: glock cancelation flag fix
Date: Fri, 23 Jan 2026 16:30:51 +0100
Message-ID: <20260123153105.797382-2-agruenba@redhat.com>
In-Reply-To: <20260123153105.797382-1-agruenba@redhat.com>
References: <20260123153105.797382-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: scgIZjMICoDzCYMQVJUjA47nvYhEusj57LsKCbSbo50_1769182269
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When an asynchronous glock holder is dequeued that hasn't been granted
yet (HIF_HOLDER not set) and no dlm operation is in progress on behalf
of that holder (GLF_LOCK not set), the dequeuing takes place in
__gfs2_glock_dq().  There, we are not clearing the HIF_WAIT flag and
waking up waiters.  Fix that.

This bug prevents the same holder from being enqueued later (gfs2_glock_nq())
without first reinitializing it (gfs2_holder_reinit()).  The code
doesn't currently use this pattern, but this will change in the next
commit.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 92e029104d8a..47e8809575d5 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1545,6 +1545,8 @@ static void __gfs2_glock_dq(struct gfs2_holder *gh)
 	list_del_init(&gh->gh_list);
 	clear_bit(HIF_HOLDER, &gh->gh_iflags);
 	trace_gfs2_glock_queue(gh, 0);
+	if (test_bit(HIF_WAIT, &gh->gh_iflags))
+		gfs2_holder_wake(gh);
 
 	/*
 	 * If there hasn't been a demote request we are done.
-- 
2.52.0


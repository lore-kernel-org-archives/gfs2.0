Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CDB215C43
	for <gfs2@lists.linux.dev>; Thu,  7 Nov 2024 20:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731012388; cv=none; b=JOY2Q3JR2EmL5y5enbPYDBSDa+Y4xGqjAVefHKjicni6nniEJJ8zxVySi4DSkLyIKlH1MJWp0SuiHNcXlTVIasgMKl1M/HEcO5iqZnCTEOomj2ReJWRNAS6mdfuuFvJjCvWmaidOKQOfyhujJ7ZC5KmImtvmhMYw8vrMeMDXFfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731012388; c=relaxed/simple;
	bh=Jd8Ti1Xo1CrKonFojtFRx0nS5zl1oYA6XbP6KC5snck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=meV/srEeOxcGx41INIyWw9X14Pps1sCBvbNcmA3mLZYVLXlzTkopO5oY7NhJRoY/NiM89hFYCw3hTHxJncNqkSc7ZCu9sPJftto1H3X+q8tAgwZE3bDS4ZvXKpOpVT+dY1KR1/LVI5VfXijUxXeGrAQApjguI6kKl04SjC2o0ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KTD7NpXs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTD7NpXs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731012385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q+6Ae2NABLHgCGO4Bl8IG2dqfzYv4BXuQQaDUnH5cuE=;
	b=KTD7NpXsa39g7hcGOd+BEOWP2KTlxG1vosVPFVWzi8/XgQJUpHHg6Hy0ZvpSdgPV5hKC2P
	J53wwdkQBrotVQzngmgEFg6Emq/zM+6jNNkfWKDflwOW1DucAx7Bjvl3Q5qxYKa2e3DLpJ
	CdMd8jJ4D4jywy5eb+ecX7BI4v2fXos=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-eG2M6UqCOai8bGOJJOoCjQ-1; Thu,
 07 Nov 2024 15:46:23 -0500
X-MC-Unique: eG2M6UqCOai8bGOJJOoCjQ-1
X-Mimecast-MFC-AGG-ID: eG2M6UqCOai8bGOJJOoCjQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25017195604F
	for <gfs2@lists.linux.dev>; Thu,  7 Nov 2024 20:46:23 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6B424300019E;
	Thu,  7 Nov 2024 20:46:22 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [RFC dlm/next 02/11] dlm: use move_lkb() instead del/add lkb
Date: Thu,  7 Nov 2024 15:46:08 -0500
Message-ID: <20241107204617.147842-3-aahringo@redhat.com>
In-Reply-To: <20241107204617.147842-1-aahringo@redhat.com>
References: <20241107204617.147842-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cNchVoi-6zGfie1JYkmmLWPbqgPMs2GPHr0jaqvFpjQ_1731012383
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Do a move_lkb() when we do a del and add of lkb that indicates a move to
a different statequeue.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index cee32aa6b218..32fdee78e7f5 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -3097,8 +3097,7 @@ static int do_convert(struct dlm_rsb *r, struct dlm_lkb *lkb)
 
 	if (can_be_queued(lkb)) {
 		error = -EINPROGRESS;
-		del_lkb(r, lkb);
-		add_lkb(r, lkb, DLM_LKSTS_CONVERT);
+		move_lkb(r, lkb, DLM_LKSTS_CONVERT);
 		goto out;
 	}
 
@@ -4512,8 +4511,7 @@ static void __receive_convert_reply(struct dlm_rsb *r, struct dlm_lkb *lkb,
 		receive_flags_reply(lkb, ms, local);
 		if (is_demoted(lkb))
 			munge_demoted(lkb);
-		del_lkb(r, lkb);
-		add_lkb(r, lkb, DLM_LKSTS_CONVERT);
+		move_lkb(r, lkb, DLM_LKSTS_CONVERT);
 		break;
 
 	case 0:
-- 
2.43.0


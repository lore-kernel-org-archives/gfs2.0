Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002C31096F
	for <gfs2@lists.linux.dev>; Tue, 27 Feb 2024 01:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998563; cv=none; b=hzf0FnUetJ/IV3MWA8WtsdraboZjcSHu9Xl2t1ndTCi+uUxyyizPwEm1ORfE5EfRTScF2bY/UZtFqZFfVRbr/LPvthwiRXNeWzlFyBrnCPXpkQdgR3PcmGKIlpRgojT2CxtkuJrUi/aGWZMerDq6s6fSx1YTTAclgCHd3mG47TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998563; c=relaxed/simple;
	bh=QNuDQcpxwNvraWcI143MrXg5MXjk/2CEpcWz3ZcC9ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EU4FfwYFZjn3U9/xkhL45jVjad0JK7QXO+0euD0pU3+etlmXIpXSvsjjDwtH7MDB9QQNYE55031D9p7K4ipL0vOLkuadxBTwsdtTL9/VajGkj5YnqJX9VLaLqqx87YbLuIWpatV0CVNp2GYq2+9JHTxrZCjjd88GNgQWLh5VYvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jpl2D67T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jpl2D67T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708998561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HEY58v62t6+T21F4PAEmHGUKpYABrTbj56FkYwzw27I=;
	b=Jpl2D67T1k7wR3SXdSY1rUL2n0SY5viRDk9xbjWBELWEZzkQckbENPNJj3HoqPyqyV0sII
	kJXy0x3Y2lDwTAJTGOSWM9pY8NWqPp0tsdb53xQlKRKnFKAUEOOYcd+j9cafccN1iNhYV2
	CX5ASKYaRBN2Df8m5d5eWup3+2ZdSKE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-5NJpo665N-6TsK8TqR1hTg-1; Mon, 26 Feb 2024 20:49:19 -0500
X-MC-Unique: 5NJpo665N-6TsK8TqR1hTg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A409185A78A
	for <gfs2@lists.linux.dev>; Tue, 27 Feb 2024 01:49:19 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.fast.eng.rdu2.dc.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 732AE2166AF6;
	Tue, 27 Feb 2024 01:49:19 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv3 v6.8-rc6 16/18] dlm: remove schedule in dlm receive path
Date: Mon, 26 Feb 2024 20:49:07 -0500
Message-ID: <20240227014909.93945-17-aahringo@redhat.com>
In-Reply-To: <20240227014909.93945-1-aahringo@redhat.com>
References: <20240227014909.93945-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This patch removes an explicit schedule() call in the receive path of
dlm message processing. The goal in DLM is to not trigger any additional
scheduling while processing DLM messages. This schedule() is directly
called inside the dlm message processing path. As soon we handle the dlm
messaging processing in softirq context we cannot call schedule() in
this context anymore. This patch prepares for this transition by simple
removing this schedule() call.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 73bf81eb88d9..a733dff09ac4 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -2540,7 +2540,6 @@ static void process_lookup_list(struct dlm_rsb *r)
 	list_for_each_entry_safe(lkb, safe, &r->res_lookup, lkb_rsb_lookup) {
 		list_del_init(&lkb->lkb_rsb_lookup);
 		_request_lock(r, lkb);
-		schedule();
 	}
 }
 
-- 
2.43.0


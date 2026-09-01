Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E15381E86
	for <gfs2@lists.linux.dev>; Tue,  1 Sep 2026 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284850; cv=none; b=YQ+erhaDWU3lWJlBlkDQp/zOb7quGJiEoULMfnEayb53DjoDATOb1ik/1glIeI1m1Vobv6sInr6i4cieLCM9J9ibDeKrILE1s/2G5+7oPCP0Fr4Ft8PTPExBmOoN+uzxK5YuIyztVdfpdgFmiBujEHdai7JwQn/1OI6C+dTCONQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284850; c=relaxed/simple;
	bh=y+BBXnhU+odEm4fG42tD+AV4GdCm3iQFMqBuINWO/b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=WNiHd0q4mG+rQEdiZGAD6iix8z1kUgRCH7bD+FJXy2hZeBIIl8acaJDSZsZ+EICJepcJx88d1FwAyZlwf+P/5NhDWmi5Bn6i/4cAYs4CkvoNNpYnLkpIPDEaYmQLJJl89RBRBJ0qctsAKWWnlPobDniJk6/JqYnwHjpQqSlxDT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BGlhhTeV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BGlhhTeV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788284848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/3Vle4bTlV8siX/St8DrGGWLzhp/ihMXdUz1YKR2MXU=;
	b=BGlhhTeVIwi4w06M/hctCykOIKM/D4cAn/D4jNmj3FhyBSTvr06s52/snQWVOkojwUxQlE
	n1hLfR2eYPAAKxdH58inLOUjGZQRZTIlJp0Aq3V5UXvCN2aOLwRQbGXMaPafwSzbBlc+vH
	B69PM+R7gxGrS83m+sFs7SDkUOjHBp4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-VMxFnKRLMFuwVLhR8Bs5kQ-1; Tue,
 01 Sept 2026 13:47:26 -0400
X-MC-Unique: VMxFnKRLMFuwVLhR8Bs5kQ-1
X-Mimecast-MFC-AGG-ID: VMxFnKRLMFuwVLhR8Bs5kQ_1788284846
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5F1818052FE
	for <gfs2@lists.linux.dev>; Tue,  1 Sep 2026 17:47:25 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7442718005BD;
	Tue,  1 Sep 2026 17:47:25 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH RESEND dlm/next 6/8] dlm: fix NULL pointer dereference in dlm_dump_rsb_name()
Date: Tue,  1 Sep 2026 13:47:13 -0400
Message-ID: <20260901174715.3825582-7-aahringo@redhat.com>
In-Reply-To: <20260901174715.3825582-1-aahringo@redhat.com>
References: <20260901174715.3825582-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PZMQFY5WsiZhHeqOZTEEt2lcYwkDVoKOLxfLE7tuc0g_1788284846
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Danila Chernetsov <listdansp@mail.ru>

The function dlm_dump_rsb_name() is called from receive_rcom_lookup()
when a debug dump is requested via a special RCOM_LOOKUP message with
rc_id == 0xFFFFFFFF.

The resource name passed to dlm_dump_rsb_name() comes from the received
message. There is no guarantee that an RSB with this name exists in the
local hash table.

dlm_search_rsb_tree() returns 0 when the RSB is found and stores a valid
pointer in r. When the lookup fails, it returns -EBADR and leaves r
NULL.

The current error handling is inverted:

    if (!error)
            goto out;

As a result, dlm_dump_rsb() is called only when the lookup fails and r
is NULL, resulting in a NULL pointer dereference.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 2d90354027ad ("dlm: merge toss and keep hash table lists into one list")
Acked-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: Danila Chernetsov <listdansp@mail.ru>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 99c7a8c4e6122..d73c4aed1f8ac 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1423,7 +1423,7 @@ void dlm_dump_rsb_name(struct dlm_ls *ls, const char *name, int len)
 
 	rcu_read_lock();
 	error = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
-	if (!error)
+	if (error)
 		goto out;
 
 	dlm_dump_rsb(r);
-- 
2.43.0


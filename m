Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92EF85947
	for <gfs2@lists.linux.dev>; Mon, 29 Jul 2024 19:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722281808; cv=none; b=I68BUtqQoUU6zXEdys/q1gBkcKDyEQpmC3CQ+0DAGmNd6wLUxLykCGzLIVegSyUsZ8X/Ma3jp911GKV7//q5a2/9Nly0GAEHEDqsNCAMQDsMlVU2FZnVTchsq5o9o1o8NsQoXElUEpbSNZ7vFW7lEm1fA8fHX36XRBM0ge7TErM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722281808; c=relaxed/simple;
	bh=QGOWaq4o+LvXmp1/IUBrFOz86isyyzvyRxF/lKl4beg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q9V4BqomH1Vs9AcWu78+BrqNi9CiIaip4a+Jffp2kjShUQj8EiF7fBXJYhVph5t747wcsUvrO3Yo1Bp8KSX+P6LvTbZ+tJMyknxHp8y3xtO6HTMXPlYnG76HyLDNMsVPga55ndNlBubynKUhFWNsBUFzHShmPC2ohWpnfLIqnls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YB01MbR9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YB01MbR9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722281805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TZxk18mLVZ8zXXzj92oUMg/2382FWD03yZoS612NBIg=;
	b=YB01MbR9AjoK1xYt6IduzbylT3TiIIdB5X8RN1fUlHEvQF5zLjrahFe4B+Gh1HHtb8YDxI
	Qq0zNUv9gS3qw21rZzl10PsQgYj9QNznnFeqJSzVri5tJlqCl29jk8tSGhwnCOQmfVVR4q
	JsdzXE9vowOxyhEBb/CcUjkcjQ845e0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-whsKbtPzOhSorH6nc9BsBw-1; Mon,
 29 Jul 2024 15:36:43 -0400
X-MC-Unique: whsKbtPzOhSorH6nc9BsBw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07A231955F45
	for <gfs2@lists.linux.dev>; Mon, 29 Jul 2024 19:36:43 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2165F1955D42;
	Mon, 29 Jul 2024 19:36:42 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH v6.11-rc1 07/10] dlm: use RSB_HASHED to avoid lookup twice
Date: Mon, 29 Jul 2024 15:36:27 -0400
Message-ID: <20240729193630.3344082-7-aahringo@redhat.com>
In-Reply-To: <20240729193630.3344082-1-aahringo@redhat.com>
References: <20240729193630.3344082-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Since commit 01fdeca1cc2d ("dlm: use rcu to avoid an extra rsb struct
lookup") _dlm_master_lookup() is called under rcu lock that prevents
that the rsb structure is being freed. There was a missing change to
avoid an additional lookup and just check that the rsb is still part of
the ls_rsbtbl structure. This patch is doing such check instead of
lookup the rsb structure again.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 30aec123a483..8bf3654f4827 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1308,11 +1308,11 @@ static int _dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *na
 	}
 
  do_inactive:
-	/* unlikely path - relookup under write */
+	/* unlikely path - check if still part of ls_rsbtbl */
 	write_lock_bh(&ls->ls_rsbtbl_lock);
 
-	error = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
-	if (!error) {
+	/* see comment in find_rsb_dir */
+	if (rsb_flag(r, RSB_HASHED)) {
 		if (!rsb_flag(r, RSB_INACTIVE)) {
 			write_unlock_bh(&ls->ls_rsbtbl_lock);
 			/* something as changed, very unlikely but
-- 
2.43.0


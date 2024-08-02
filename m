Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4988D136327
	for <gfs2@lists.linux.dev>; Fri,  2 Aug 2024 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619635; cv=none; b=lEBVCuZjHLkxYQoPbs2audQS+21h4vfFDObzEaobEnXj6dFXlE8VJrkqGr7vBSHuAEnpKMoxuBfj8pNXh1hhqJ8ifzPYwlxB+zKTF/5ZAPE+XNxQ3BI07/4o8WpTxnRS+Y47/CodM9YiXFaRJVWy9wiJlC+ouHqk8BD3F/NvmdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619635; c=relaxed/simple;
	bh=QGOWaq4o+LvXmp1/IUBrFOz86isyyzvyRxF/lKl4beg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aAAAKF37rPo+vCbXhVJiIltXE4DSYXA3mAbKYPAq6e/wqGwY52nsW33BK9LW6nob7ma8TWoU126S6/0xEFQueCQhKu1EhK9tWqZ68VvZEZVF86F2p2dk3zS9E42PZs17FNXAuuoqrPbmC5GAr68gQO07DHuBZNMyqMnVegrxNYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aw7CbVie; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aw7CbVie"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722619633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TZxk18mLVZ8zXXzj92oUMg/2382FWD03yZoS612NBIg=;
	b=Aw7CbVie10G/pegLL4sMJkrcWh6Doa5inrihr6aqhnuR46o7xSUlADANvGkOyf5gnjVwKP
	vO2e+in+DmkMPqlHWAJRRZmXsoSC/d6P7MTSowODI9IFPUeCVEAm0v8btvvOyVTEudMtTC
	qb8QW0i2z3Z327UmJv0NaoZZWvuHK48=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-xIKDMrviOoqUFsNlJXVW-g-1; Fri,
 02 Aug 2024 13:27:10 -0400
X-MC-Unique: xIKDMrviOoqUFsNlJXVW-g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 257921956095
	for <gfs2@lists.linux.dev>; Fri,  2 Aug 2024 17:27:10 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5D5F919560AE;
	Fri,  2 Aug 2024 17:27:09 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv2 v6.11-rc1 07/10] dlm: use RSB_HASHED to avoid lookup twice
Date: Fri,  2 Aug 2024 13:26:44 -0400
Message-ID: <20240802172647.582745-7-aahringo@redhat.com>
In-Reply-To: <20240802172647.582745-1-aahringo@redhat.com>
References: <20240802172647.582745-1-aahringo@redhat.com>
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


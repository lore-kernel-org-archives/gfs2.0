Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3515D1AA785
	for <gfs2@lists.linux.dev>; Fri,  4 Oct 2024 15:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728054833; cv=none; b=DorA4ptCK/47TUmg+pweoan63MT+K0Es4UNX7Df1BAkIb1MED+f5AguWNrnc1WectFYON5m4j1qm9sY1Rg/n/6SpOB8O1qAKiO2FL7QV2npnepXHF1rU60beI4owswkGnw9aYAMjT+NcCfxMLUn6v8tc94HMHjeztSKiPmuJplA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728054833; c=relaxed/simple;
	bh=FF9mY4DOg2BPKdXJQ5eiGZaB0qoS+e9hXmMBLwt7B7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NQqhOus6mL7xyGbBHLl/pjwYYNg8hchWQeZNgK6TS1nirodRNmCmap7wZFxp3+vovX/BHCYSop26iY6otw3TX6VdIxl/zyMTjfBv35Tx96BuP7IVtA3uHMz3zxUxOZkN0kU2Vof89uARMJcSWcur+xtIYBuHt2D/5C/K3nwR8ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KIscyFNs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KIscyFNs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728054830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NzGuFcOvuGGjMxt0Vp2I5r88XrXxRE/WxxnSQWtNRbA=;
	b=KIscyFNsQ+6PEjBAoPyVHVP64bdXW4/WoyYAhDaoQSKI6MZ9nvyNp0P29NAXWtO9ha5M5M
	rJUHkC/gme/W9RpHAXmU2RTviJ2PneujdeseXDt7TX9wraNVxbPq3yD3ibwWEbc29ruSgi
	mh+4bNoMeRk3SKfk9LRICw1L2CgBl3A=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-hrbc6Wv-OraebGwNNXkdtg-1; Fri,
 04 Oct 2024 11:13:48 -0400
X-MC-Unique: hrbc6Wv-OraebGwNNXkdtg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61E9B1955EE9
	for <gfs2@lists.linux.dev>; Fri,  4 Oct 2024 15:13:47 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B2EE219560AE;
	Fri,  4 Oct 2024 15:13:46 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH v6.12-rc1 1/7] dlm: fix swapped args sb_flags vs sb_status
Date: Fri,  4 Oct 2024 11:13:37 -0400
Message-ID: <20241004151343.3952937-2-aahringo@redhat.com>
In-Reply-To: <20241004151343.3952937-1-aahringo@redhat.com>
References: <20241004151343.3952937-1-aahringo@redhat.com>
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

The arguments got swapped by commit 986ae3c2a8df ("dlm: fix race between
final callback and remove") fixing this now.

Fixes: 986ae3c2a8df ("dlm: fix race between final callback and remove")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/ast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/ast.c b/fs/dlm/ast.c
index 742b30b61c19..0fe8d80ce5e8 100644
--- a/fs/dlm/ast.c
+++ b/fs/dlm/ast.c
@@ -30,7 +30,7 @@ static void dlm_run_callback(uint32_t ls_id, uint32_t lkb_id, int8_t mode,
 		trace_dlm_bast(ls_id, lkb_id, mode, res_name, res_length);
 		bastfn(astparam, mode);
 	} else if (flags & DLM_CB_CAST) {
-		trace_dlm_ast(ls_id, lkb_id, sb_status, sb_flags, res_name,
+		trace_dlm_ast(ls_id, lkb_id, sb_flags, sb_status, res_name,
 			      res_length);
 		lksb->sb_status = sb_status;
 		lksb->sb_flags = sb_flags;
-- 
2.43.0


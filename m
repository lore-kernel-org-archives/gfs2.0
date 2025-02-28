Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72791CACF3
	for <gfs2@lists.linux.dev>; Fri, 28 Feb 2025 22:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740782940; cv=none; b=t1cytOC6ubsIHOtG5P7xtdXi63l+6nEJbCWG5VtSeHSXW2aDNHucT8iFwtHQLVviq6X6uAdPSh8o/rwb8C0TKUnGKkMFPs4hXxGFx79ZBZYzF+jMN5iTISLKzHhlKR4fy/LFNNfRHKetOJYXxD+1Xm6RTo5tkeeZPXpiSNzKKbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740782940; c=relaxed/simple;
	bh=72ZwdZvQsIkCuua/Mv9fSv1JCKUq34c8y4GHGoEC8qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCqS0s79MyAgSOuHCkxdhQC079MButri60dP1PLpEiUDp2KJZ5dFn73o4IfeuQL0Hx8nTPBxKjfRWCgRjfSt5DTnMTVCtV3iqqgaubHT1hg4WizY8d5u/2CdLXriWLg4IAkYMUKs83CP7qC6PivqdvLM1VmLHNCWIhlt/fIeM68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IP/NX5R3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IP/NX5R3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740782937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wd0Gf1kz2NzoiwlbijbTr+huOwwGbqwTJ6g0bBZpj/0=;
	b=IP/NX5R3tt5rVlNNaodR+BasXolEGMBTLt2QTSTVWVZx2iBBZRx9x8/90mWm94WdfCi3n9
	gTyxGrY+TBUXX55ZKSx/rB/m8jbkXXf4Xizuz+wegVu8ntVBCHiuK00l3EyW/w9Cy708Wm
	VsN0mvVM+PStsibuKdqY9ycwkNm793M=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-p-hCOkotPJa888iBkhcyGA-1; Fri,
 28 Feb 2025 17:48:55 -0500
X-MC-Unique: p-hCOkotPJa888iBkhcyGA-1
X-Mimecast-MFC-AGG-ID: p-hCOkotPJa888iBkhcyGA_1740782935
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 14FB219373D7;
	Fri, 28 Feb 2025 22:48:55 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 40D9F1800357;
	Fri, 28 Feb 2025 22:48:54 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: stable@vger.kernel.org,
	gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next 2/2] dlm: fix error if active rsb is not hashed
Date: Fri, 28 Feb 2025 17:48:51 -0500
Message-ID: <20250228224851.1283094-2-aahringo@redhat.com>
In-Reply-To: <20250228224851.1283094-1-aahringo@redhat.com>
References: <20250228224851.1283094-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

If an active rsb is not hashed anymore and this could occur because we
releases and acquired locks we need to signal the followed code that
the lookup failed. Since the lookup was successful, but it isn't part of
the rsb hash anymore we need to signal it by setting error to -EBADR as
dlm_search_rsb_tree() does it.

Cc: stable@vger.kernel.org
Fixes: 5be323b0c64d ("dlm: move dlm_search_rsb_tree() out of lock")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 499fa999ae83..e01d5f29f4d2 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -741,6 +741,7 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 	read_lock_bh(&ls->ls_rsbtbl_lock);
 	if (!rsb_flag(r, RSB_HASHED)) {
 		read_unlock_bh(&ls->ls_rsbtbl_lock);
+		error = -EBADR;
 		goto do_new;
 	}
 	
-- 
2.43.0


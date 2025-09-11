Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAF732C316
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599090; cv=none; b=RwfMe3grEKGESWU9qb3zhkMHd95/UxioRH+gkArYfjMm1w/JwdABQLtw3DS4pr02NsQFtGPf94h6tet95leTYbUjohjNxKcfRw3EHzvwTbqQB6f6emvNj1OY6HIJ24eKBGXpaGRFFXYHIDVXJGrtRVtO9ZX9NGVAK9JamSh6Jww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599090; c=relaxed/simple;
	bh=5IzzfWa8NULoUHjE+FzvXfaGdEALXUlfPELcYR8Pv/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Ax1nH2RqQ/p9ySXB/f0vb1aNKBFfkBRe/hY4WtcsfCgPLBzat+0K0Q+7JxHLotXIbK12bvdrdzkZqZZGEva53mgi1UbFp/8Mp4hln7ccmbWHuTk0iN/VSuSRJ6WQ7yzb/0GxtyIB3itrbdbJM+MnNWufsAdbvF6yJ+j0eM5rK7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V990T7o3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V990T7o3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757599088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=57GSXtrncA2n+NjL/gklBNV8OOp9SsrxBM5gQ30xMU4=;
	b=V990T7o3oTcNr87xGBHGHDumbWdpdZFeNPiv9do8UQi2zwEVbDDtLbnXisSop8nEQQg6q5
	W9DUySkTc8Y6GQhEJICKcaAgMAM+PQWTuW5XacsPK75iQtFDZkURt/ubB+XMHa5lOgg7E/
	eqP8Oi/fW82/ItWe7tejYVy87Sg3uZc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-6Ay4lIwfPK-e8iYKSTvqmg-1; Thu,
 11 Sep 2025 09:58:06 -0400
X-MC-Unique: 6Ay4lIwfPK-e8iYKSTvqmg-1
X-Mimecast-MFC-AGG-ID: 6Ay4lIwfPK-e8iYKSTvqmg_1757599086
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E3E331800343
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:58:05 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.31])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A5C9619560B1;
	Thu, 11 Sep 2025 13:58:04 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 20/20] gfs2: Fix unlikely race in gdlm_put_lock
Date: Thu, 11 Sep 2025 15:57:25 +0200
Message-ID: <20250911135726.657575-21-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: zqcDTN-wtvuiNVde_onxHdptT-Um5_ugfUW4sGtuwc4_1757599086
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

In gdlm_put_lock(), there is a small window of time in which the
DFL_UNMOUNT flag has been set but the lockspace hasn't been released,
yet.  In that window, dlm may still call gdlm_ast() and gdlm_bast().
To prevent it from dereferencing freed glock objects, only free the
glock if the lockspace has actually been released.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/lock_dlm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index 3c7db20ce564..ae058b1f9435 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -344,12 +344,6 @@ static void gdlm_put_lock(struct gfs2_glock *gl)
 	gfs2_sbstats_inc(gl, GFS2_LKS_DCOUNT);
 	gfs2_update_request_times(gl);
 
-	/* don't want to call dlm if we've unmounted the lock protocol */
-	if (test_bit(DFL_UNMOUNT, &ls->ls_recover_flags)) {
-		gfs2_glock_free(gl);
-		return;
-	}
-
 	/*
 	 * When the lockspace is released, all remaining glocks will be
 	 * unlocked automatically.  This is more efficient than unlocking them
@@ -379,6 +373,11 @@ static void gdlm_put_lock(struct gfs2_glock *gl)
 		goto again;
 	}
 
+	if (error == -ENODEV) {
+		gfs2_glock_free(gl);
+		return;
+	}
+
 	if (error) {
 		fs_err(sdp, "gdlm_unlock %x,%llx err=%d\n",
 		       gl->gl_name.ln_type,
-- 
2.51.0


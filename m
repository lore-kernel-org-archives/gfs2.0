Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7E51836CE
	for <gfs2@lists.linux.dev>; Wed, 10 Apr 2024 21:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712784506; cv=none; b=DeHhXSM2V1Qf20rjHjW++txzzVgdfPQCNV38kB8Gx19VrWer0+lm+NIvVidkS5Ll7kMoNUoNW8E8+ChxSUud3LcorLcvSe6HQ2ElcfHXuJlLozEGg0dyqjWgBkXzs6zQrpCjPSknIMTaZ/DmHx1aqDZgylyGxkkXFlOGzgq1d1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712784506; c=relaxed/simple;
	bh=WEZxgDEZkK619+O7uRFQ/2aap53DHGCFnwldJWo6xo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ucz0XUwtPG7w8xnYXomacxRJTgCFNOSqDkwMa9V0xKtsr7hYG9IuctAgXQirDx/aA+rE9OjIxIhQYXzx6IO22C5LryOUg/d3XcD2roAEmDPhzGJlw6Ud7c1TdqCldd1+TicuZn+QnqqVQLknThjYWzK8RpREUA8DCIWj1EeG62Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cc2d1XQ1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cc2d1XQ1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712784503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mY2ENUSY+3+tNxKdnADMFxS+GF/+4dHrWfX7j3SIO0w=;
	b=cc2d1XQ1WU6uZhCF1djfCvcYATvCmPnWuNuke4JAEY7avktS2qcZFzNFkK7wtqim0gm4t7
	GvOXlyRQkOY4wLN+CFLQiPDe0vTWfXZLSh7liFbC8MuFH+3uskHru9/q6EOq2RlVRKyJoM
	zzXiCdWaNU1pSNVtXucO4mn50pElZTI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-WEaOzAe2OYeXeRmx_xO4Og-1; Wed, 10 Apr 2024 17:28:22 -0400
X-MC-Unique: WEaOzAe2OYeXeRmx_xO4Og-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DBFDC8026B9
	for <gfs2@lists.linux.dev>; Wed, 10 Apr 2024 21:28:21 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.28])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4410D444FE2;
	Wed, 10 Apr 2024 21:28:21 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	David Teigland <teigland@redhat.com>
Subject: [PATCH 3/3] gfs2: Unlock fewer glocks on unmount
Date: Wed, 10 Apr 2024 23:28:13 +0200
Message-ID: <20240410212814.204819-4-agruenba@redhat.com>
In-Reply-To: <20240410212814.204819-1-agruenba@redhat.com>
References: <20240410212814.204819-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

At unmount time, we would generally like to explicitly unlock as few
glocks as possible for efficiency.  We are already skipping glocks that
don't have a lock value block (LVB), but we can also skip glocks which
are not held in DLM_LOCK_EX or DLM_LOCK_PW mode (of which gfs2 only uses
DLM_LOCK_EX under the name LM_ST_EXCLUSIVE).

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Cc: David Teigland <teigland@redhat.com>
---
 fs/gfs2/lock_dlm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index e028e55e67d9..49059274a528 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -316,10 +316,16 @@ static void gdlm_put_lock(struct gfs2_glock *gl)
 		gfs2_glock_free(gl);
 		return;
 	}
-	/* don't want to skip dlm_unlock writing the lvb when lock has one */
+
+	/*
+	 * When the lockspace is released, all remaining glocks will be
+	 * unlocked automatically.  This is more efficient than unlocking them
+	 * individually, but when the lock is held in DLM_LOCK_EX or
+	 * DLM_LOCK_PW mode, the lock value block (LVB) will be lost.
+	 */
 
 	if (test_bit(SDF_SKIP_DLM_UNLOCK, &sdp->sd_flags) &&
-	    !gl->gl_lksb.sb_lvbptr) {
+	    (!gl->gl_lksb.sb_lvbptr || gl->gl_state != LM_ST_EXCLUSIVE)) {
 		gfs2_glock_free_later(gl);
 		return;
 	}
-- 
2.44.0


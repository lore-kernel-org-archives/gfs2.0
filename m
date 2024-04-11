Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819C014D449
	for <gfs2@lists.linux.dev>; Thu, 11 Apr 2024 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712843572; cv=none; b=M/TrfK+LtoGlkvr9ZpHhFfHQhJJlo8jpLeHVfqysqvnGYWzFdA/BkveDwQTB4z7nt+53M7N/r4ja9sc0Vo2SpMNJpKQ0m7d1K11/QgOcRJox56vapc5DO4/NzwuoWvM4SsywEfFq7tgUyQQBYpCedgayiGM9hWcO9N6GKjt3wg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712843572; c=relaxed/simple;
	bh=iWirWZRLHHpnUehQ1KzpBYD+N0Mn196EmRBR/E8ANW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r/NgfuF00dnZAQv1ZfuRDKDfTzxzr9E1Ne5c/AWECWKwUlGgBZPDVs2v38kfpLS4Sw3fQ0PAeXBwJw3FWceuM2yHnvZl+rJcMGDp4ygEJO9PpFpvPOR2nvyikfeA324GItX/y+MBUzpFVXl8JxXncL7CDHdPKW2IlcF2Lq/EpAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CkiiTM4l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkiiTM4l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712843570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uzQtUyvoE0abMRUn0oDdXhHzITguQSYWnI6P/aN1c6w=;
	b=CkiiTM4lsia8yYcl8pABDGpHxO4BdicIZ0lOzzD7e14X+rtEe4Qva678IWP3EEncorCTcf
	KH73FaoCAlQ0n6/LrVYepQcf2EGqnPam4WMPYMnF1nwdaCc1y/br4aHfJOcnrqNkIlg1Qh
	E4jFxC+jtX5iJI2WKXEXwD2SorXjsIo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-Hdagfj_SPwW7mfrGoXdVUA-1; Thu,
 11 Apr 2024 09:52:49 -0400
X-MC-Unique: Hdagfj_SPwW7mfrGoXdVUA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA3613C3D0E4
	for <gfs2@lists.linux.dev>; Thu, 11 Apr 2024 13:52:48 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.28])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6E82C1C060D0;
	Thu, 11 Apr 2024 13:52:48 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] gfs2: Fix do_xmote locking error
Date: Thu, 11 Apr 2024 15:52:43 +0200
Message-ID: <20240411135243.260020-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Commit 86934198eefa added a 'goto' statement from the beginning of
do_xmote() to further below where the glock spinlock must no longer be
held.  I don't fully understand what's going on here, and apparently
this case isn't covered by our testing.  In any case though, we must
drop the glock spinlock before this 'goto' or else we won't be able to
retake the lock at the end of do_xmote().

Fixes: 86934198eefa ("gfs2: Clear flags when withdraw prevents xmote")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index ce62937d85b5..2c9fdc3f7d76 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -705,8 +705,10 @@ __acquires(&gl->gl_lockref.lock)
 	int ret;
 
 	if (target != LM_ST_UNLOCKED && glock_blocked_by_withdraw(gl) &&
-	    gh && !(gh->gh_flags & LM_FLAG_NOEXP))
+	    gh && !(gh->gh_flags & LM_FLAG_NOEXP)) {
+		spin_unlock(&gl->gl_lockref.lock);
 		goto skip_inval;
+	}
 
 	lck_flags &= (LM_FLAG_TRY | LM_FLAG_TRY_1CB | LM_FLAG_NOEXP);
 	GLOCK_BUG_ON(gl, gl->gl_state == target);
-- 
2.44.0


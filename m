Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE10152DEB
	for <gfs2@lists.linux.dev>; Tue,  9 Apr 2024 16:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712681125; cv=none; b=aVaWJKEOp7+yPaxlrjMV0m96yW+IfHGF8pAYrucxQ4t6c3Cn6Mz8N30QWduqZpRO8RDtU3w8HG1XBDU85zg5EjgxkZHuAfEIdXeSF0dPmCZdUIyjW7mjDTlfIGwBkV2WiEPEMngzBPkhDrTcoP6Ft+TQi7iK2xJ2IoMzAlLcEEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712681125; c=relaxed/simple;
	bh=Iur/nHx0HCG8+AFj9N+LF0TIw/1LqarmxmN1HE89haY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ttC1fYnMJhb8oqTJcSk99LsRzjuFVoloaL/gHetxXYYAGfUGxRyBKuXSpVNXAmBrBwTYDOsVQRealMLiSsEtwXBp//w4Q7AMj8lnGFS57MyqkosPGGF5Sh4lAV3HYA1rdVOy8EUy3deHwbRLauGoekVaAzEMslvAXGd0/Jv2Q5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GR4aQ+El; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GR4aQ+El"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712681122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Tn2Z56nAMUrGzd3phjURNHGlpklYusC5+MPcLq/seI=;
	b=GR4aQ+ElmdL9MTABB2MJnU++g/mmDIoEXPH/uR1BE2LbEhD1PGfwlKUlHp69EG/HY2eHBH
	lyGcX4r7GAkDthRwy9AJu9vypKa1cyZxMvoyZZ60ccqQjAWrFkSOzg3yiQeQ3eLwiWKUaa
	oOrfCRAeX0EWT0XTK7x5ZJCnJgV88ac=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-YGfC0cOgN12ytLo944xi3w-1; Tue, 09 Apr 2024 12:45:21 -0400
X-MC-Unique: YGfC0cOgN12ytLo944xi3w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9F6E830E75
	for <gfs2@lists.linux.dev>; Tue,  9 Apr 2024 16:45:20 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.28])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 284E2C0157E;
	Tue,  9 Apr 2024 16:45:20 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 09/15] gfs2: Don't set GLF_LOCK in gfs2_dispose_glock_lru
Date: Tue,  9 Apr 2024 18:44:59 +0200
Message-ID: <20240409164508.79570-10-agruenba@redhat.com>
In-Reply-To: <20240409164508.79570-1-agruenba@redhat.com>
References: <20240409164508.79570-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

In gfs2_dispose_glock_lru(), we want to skip glocks which are in the
process of transitioning state (as indicated by the set GLF_LOCK flag),
but we we don't need to set that flag for requesting a state transition.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index ed90033b9c72..a700e424f790 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2017,14 +2017,13 @@ __acquires(&lru_lock)
 			atomic_inc(&lru_count);
 			continue;
 		}
-		if (test_and_set_bit(GLF_LOCK, &gl->gl_flags)) {
+		if (test_bit(GLF_LOCK, &gl->gl_flags)) {
 			spin_unlock(&gl->gl_lockref.lock);
 			goto add_back_to_lru;
 		}
 		gl->gl_lockref.count++;
 		if (demote_ok(gl))
 			handle_callback(gl, LM_ST_UNLOCKED, 0, false);
-		WARN_ON(!test_and_clear_bit(GLF_LOCK, &gl->gl_flags));
 		__gfs2_glock_queue_work(gl, 0);
 		spin_unlock(&gl->gl_lockref.lock);
 		cond_resched_lock(&lru_lock);
-- 
2.44.0


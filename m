Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18C214F12C
	for <gfs2@lists.linux.dev>; Tue,  9 Apr 2024 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712681122; cv=none; b=llyuty6jeBDnQzsnwiWaqxj+ZAvra3RMzKgCvqUIhTUr0bhwgIoPPma165wdbsQRg3scsPLYQoay42wXOpFSyF9SZuGVNU+33OFzjrPEQ7MbsCsoKvNS7xIv11F1F4t9DYLiBYy+j/+E28GfGkoYqh9xgij2lboiDPkElKnmM+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712681122; c=relaxed/simple;
	bh=yu9o+szDULRQwj0UjzzMcGlMPBu+V4jNHscopEQ2Pk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=amwThdDMlPQW210kLRcFJ4+fhiRXfqj+cdJUhkfvtgkyBrek/Wf3RTxxgYa9nBD5UOUVu/Hb9gwxpekyQ3YFKGWa+ohBCKqMhiCSxE/etyBy6jnqTWPXwZQtPX+pQOo098SFgWv27tqMUM7vUuATfX6WwWMC/MGkBrbnmeCfaFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RgaF0ngB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RgaF0ngB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712681119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cv2aIgr1mK5Qh6f6AahXo5j7Sock4eulCOPNmiAHuJc=;
	b=RgaF0ngB9H0rdSiS5BHNyNM2JldvzQl0OuOb8Ki1eJ1GK9hWjEPjZpr+LLkynBBfoU//h4
	xRpq+RQy7QJbrJtjiZ1gu82gRV+S/CuHXyIwzaf4U2p5WKEJT3xuY4IHQ1NZ3Hkt7lz6WU
	HZy7gnkFFgm1sdsIZKvu9jw1fDut1lQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-U8dKUDwLMJyBb7djhfrilg-1; Tue,
 09 Apr 2024 12:45:17 -0400
X-MC-Unique: U8dKUDwLMJyBb7djhfrilg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4DE71C0C642
	for <gfs2@lists.linux.dev>; Tue,  9 Apr 2024 16:45:17 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.28])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 25840C0157E;
	Tue,  9 Apr 2024 16:45:17 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 05/15] gfs2: Don't forget to complete delayed withdraw
Date: Tue,  9 Apr 2024 18:44:55 +0200
Message-ID: <20240409164508.79570-6-agruenba@redhat.com>
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

Commit fffe9bee14b0 ("gfs2: Delay withdraw from atomic context")
switched from gfs2_withdraw() to gfs2_withdraw_delayed() in
gfs2_ail_error(), but failed to then check if a delayed withdraw had
occurred.  Fix that by adding the missing check in __gfs2_ail_flush(),
where the spin locks are already dropped and a withdraw is possible.

Fixes: fffe9bee14b0 ("gfs2: Delay withdraw from atomic context")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glops.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index ae8d4731907d..68677fb69a73 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -82,6 +82,9 @@ static void __gfs2_ail_flush(struct gfs2_glock *gl, bool fsync,
 	GLOCK_BUG_ON(gl, !fsync && atomic_read(&gl->gl_ail_count));
 	spin_unlock(&sdp->sd_ail_lock);
 	gfs2_log_unlock(sdp);
+
+	if (gfs2_withdrawing(sdp))
+		gfs2_withdraw(sdp);
 }
 
 
-- 
2.44.0


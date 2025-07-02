Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FD02EF29F
	for <gfs2@lists.linux.dev>; Wed,  2 Jul 2025 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751469950; cv=none; b=n1taGdKoGnUMqhouXI+bWe8AjT5nx2PBnebNhSSvBJfFCbALuPnfuBe/4lMAHv5yqB01zBCrBoF2R44g19hvYSsp9OiU2+Pj0IUlvGyypyOWG9OC/DcfMbRxHN3q8lQZW+nPVnC+3+Y/Y2DNBvyTE8eGR8lC9icYO1tvmMH8GHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751469950; c=relaxed/simple;
	bh=QKvich8lG10V9ylU/AMjwWCZtQqPdlsztSbdkOdBbuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=QJfTrO8q12brL2cCZBWFHvESmCyceHRZ/N9ZhkW4eBL2dWH/lMEEP6trP2ewfyqiF5OPCA6cNWOnnp/6u6LuUDPBbHaQdM58khJkpc+ruvaVdxOm5d7zj/gW7H2XBi+eexOaMDt/kwXbqG9IwzufxALnB8Z7DE4xKuBFXJjyqas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WuZ4w0FZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WuZ4w0FZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751469947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N8eyJ68dw3v/MU6fC8JNRoJLnrrA0D1Z6EI33xP8dq0=;
	b=WuZ4w0FZtRJKaREO9kfAci2oe1KOCIjK+UBhjUH8CaTPQQdBIt6SDZObbGU6/CCXhcW83I
	m0nNRCoSuLDX0ndxB8nGoKcBzIDWQHP02sxoX5PNya6fdCkcqIqWPNhG8/Df1a10yaIhKK
	fV3q/wyPUN/qJMvhgCOnnDah4iwqsiM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-suV5N7qqMxGSW9z_qubbdQ-1; Wed,
 02 Jul 2025 11:25:46 -0400
X-MC-Unique: suV5N7qqMxGSW9z_qubbdQ-1
X-Mimecast-MFC-AGG-ID: suV5N7qqMxGSW9z_qubbdQ_1751469945
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE9011955F3E
	for <gfs2@lists.linux.dev>; Wed,  2 Jul 2025 15:25:45 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.210])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6D1D619560AE;
	Wed,  2 Jul 2025 15:25:44 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Andrew Price <anprice@redhat.com>
Subject: [PATCH 3/3] gfs2: a minor finish_xmote cleanup
Date: Wed,  2 Jul 2025 17:25:36 +0200
Message-ID: <20250702152537.21742-4-agruenba@redhat.com>
In-Reply-To: <20250702152537.21742-1-agruenba@redhat.com>
References: <20250702152537.21742-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Wopvn2QHNEuG0g77d5l7LK5uqxFlEB7PaIGM3uR0vkI_1751469945
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

As a minor clean-up to commit 1fc05c8d8426 ("gfs2: cancel timed-out
glock requests"), when a demote request is in progress in
finish_xmote(), there is no point in waking up the glock holder at the
head of the queue because the reply from dlm cannot be on behalf of that
glock holder.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Reviewed-by: Andrew Price <anprice@redhat.com>
---
 fs/gfs2/glock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index debdade97240..828585a6574f 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -609,12 +609,11 @@ static void finish_xmote(struct gfs2_glock *gl, unsigned int ret)
 	if (unlikely(gl->gl_state != gl->gl_target)) {
 		struct gfs2_holder *gh = find_first_waiter(gl);
 
-		if (gh && (ret & LM_OUT_CANCELED))
-			gfs2_holder_wake(gh);
 		if (gh && !test_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags)) {
 			if (ret & LM_OUT_CANCELED) {
 				list_del_init(&gh->gh_list);
 				trace_gfs2_glock_queue(gh, 0);
+				gfs2_holder_wake(gh);
 				gl->gl_target = gl->gl_state;
 				goto out;
 			}
-- 
2.50.0


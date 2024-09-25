Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39125141987
	for <gfs2@lists.linux.dev>; Wed, 25 Sep 2024 22:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727301842; cv=none; b=PoeJbTO0ekp5MOX3qQrKbq10CpaD1eybL3ePGfIIJFIL3LhU7XhPyji8CzypSrpCsRFt8NDKyRilTxp6eE1hkFZqsM7w4Bm0Y7PgduBWL9pYR1XdKoCA34G9KcKC9ElOQNS+DOPSD4G/XWPn8Jx7QFLSDrlJ57Sg/SVeu2mYOT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727301842; c=relaxed/simple;
	bh=zeURBNe64GLbSXdKgMvCw4KKl3UNcCiqOuzr9v0m17M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a2PdA3UTG4bMblQPN12cfcIXd7Y9Vj+re7K74IcUy7SsBgPBVwzydDaJ4HeogN4Yinr7fnkHoddMt2CcsZx30SmRr+de/fx63t+UDlDUBLDW4pbjuwTuqRc/smi86GFEzl3slIPEHxLzEONRT3XIv3Ge62t7W1HvF52tj6YxR/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PV5nfEHw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PV5nfEHw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727301840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r4Zws2d9CAepPchc4+h8ujW9bG2itHnV55MsX0iqEMI=;
	b=PV5nfEHwazYng1haHKqE7kIu+n1Lt0TI/psWl0bB4HPdusk7xi+CtgICCQsvdgRVoHU26i
	M0JdrYBWNbP2Q5Aaft442Z5VxBB8ql65sDZNpg4MTfYbNk0an5A+5y75Vvccw+nzDpw8JT
	7rMrNfaf4VOQkmfWDp7GJyXXljkyCss=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-ccPIm1HZOCGopqXvJloPRQ-1; Wed,
 25 Sep 2024 18:03:57 -0400
X-MC-Unique: ccPIm1HZOCGopqXvJloPRQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6F6819344FB
	for <gfs2@lists.linux.dev>; Wed, 25 Sep 2024 22:03:56 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.77])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7D0F719560AA;
	Wed, 25 Sep 2024 22:03:55 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 13/16] gfs2: Use mod_delayed_work in gfs2_queue_try_to_evict
Date: Thu, 26 Sep 2024 00:03:23 +0200
Message-ID: <20240925220331.417856-14-agruenba@redhat.com>
In-Reply-To: <20240925220331.417856-1-agruenba@redhat.com>
References: <20240925220331.417856-1-agruenba@redhat.com>
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

In the unlikely case that we're trying to queue GLF_TRY_TO_EVICT work
for an inode that already has GLF_VERIFY_DELETE work queued, we want to
make sure that the GLF_TRY_TO_EVICT work gets scheduled immediately
instead of waiting for the delayed work timer to expire.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 8fff36846145..5455f4dd14a3 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1008,8 +1008,7 @@ bool gfs2_queue_try_to_evict(struct gfs2_glock *gl)
 
 	if (test_and_set_bit(GLF_TRY_TO_EVICT, &gl->gl_flags))
 		return false;
-	return queue_delayed_work(sdp->sd_delete_wq,
-				  &gl->gl_delete, 0);
+	return !mod_delayed_work(sdp->sd_delete_wq, &gl->gl_delete, 0);
 }
 
 bool gfs2_queue_verify_delete(struct gfs2_glock *gl, bool later)
-- 
2.46.0


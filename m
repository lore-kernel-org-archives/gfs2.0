Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E323CAE6E
	for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 14:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776091950; cv=none; b=BUYi+cNVwDf0sGN0OHw2OnU/bOLsi8vucEX6nMvnJqnmfG2mW0e2CozVEWra0hdzNmlNuZ3afUlQkQR6SuHWqRNKzxkdG+d+CqniYxVIbtltNyps8DWCQYNaf8Q6w2kDlFXyEblMuWxwO0MfmjqXXAUYkR/E+RqSJY+u5PkN2S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776091950; c=relaxed/simple;
	bh=lMqJxqbEmOeuTqWWaP3tE9j4FGuao1Nw+R+zqTSKiIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=qas7/Smlx5ZgzG2MELMWBiOSbWv2a6CYK15m2LUSucGfXN5lTSmgI/TyxA8RYFRuW2NWvQIiDcauM4SiLgtjWnKVyTGtUFQYIqn0XvHICdV2dGpfzdb5SbchEoZQCXYnaZ67l486H5z8rPlWt948kZY22P1JZJjbewRR9Du9uZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h+mbzB+v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h+mbzB+v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776091948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ftb+JobgZ9X34TkKyWJhJbwUxhjkA136V0IhILeDf3s=;
	b=h+mbzB+vlk0FpMC3yXVJbQQdzMXeM2+qCukavmoEKmcHw30/h51rr40WR5b1uo33EsZlMV
	vMyC3ymN+zY8SRI+frFq0kuPsr2R8Ly3GLSJip/1LWanjvOodIKqggOKm0Ftf8tlAlV9LL
	EWiTKOzldgK7NGsAy1zgBv0rJiHcAbQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-oezy4TSmOsSaL-ViTQ_jRA-1; Mon,
 13 Apr 2026 10:52:24 -0400
X-MC-Unique: oezy4TSmOsSaL-ViTQ_jRA-1
X-Mimecast-MFC-AGG-ID: oezy4TSmOsSaL-ViTQ_jRA_1776091943
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B557D19560AA
	for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 14:52:23 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.156])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A64B919560B1;
	Mon, 13 Apr 2026 14:52:22 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 06/18] gfs2: less aggressive low-memory log flushing
Date: Mon, 13 Apr 2026 16:51:59 +0200
Message-ID: <20260413145211.881752-7-agruenba@redhat.com>
In-Reply-To: <20260413145211.881752-1-agruenba@redhat.com>
References: <20260413145211.881752-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ah5QRT5uhWeGHt4WmyB74VFn8FVaSItKpxJbPKJCiGI_1776091943
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

It turns out that for some workloads, the fix in commit b74cd55aa9a9d
("gfs2: low-memory forced flush fixes") causes the number of forced log
flushes to increase to a degree that the overall filesystem performance
drops significantly.  Address that by forcing a log flush only when
gfs2_writepages cannot make any progress rather than when it cannot make
"enough" progress.

Fixes: b74cd55aa9a9d ("gfs2: low-memory forced flush fixes")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/aops.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index e79ad087512a..6a6ded7a61d2 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -158,6 +158,7 @@ static int gfs2_writepages(struct address_space *mapping,
 			   struct writeback_control *wbc)
 {
 	struct gfs2_sbd *sdp = gfs2_mapping2sbd(mapping);
+	long initial_nr_to_write = wbc->nr_to_write;
 	struct iomap_writepage_ctx wpc = {
 		.inode		= mapping->host,
 		.wbc		= wbc,
@@ -166,13 +167,13 @@ static int gfs2_writepages(struct address_space *mapping,
 	int ret;
 
 	/*
-	 * Even if we didn't write enough pages here, we might still be holding
+	 * Even if we didn't write any pages here, we might still be holding
 	 * dirty pages in the ail. We forcibly flush the ail because we don't
 	 * want balance_dirty_pages() to loop indefinitely trying to write out
 	 * pages held in the ail that it can't find.
 	 */
 	ret = iomap_writepages(&wpc);
-	if (ret == 0 && wbc->nr_to_write > 0)
+	if (ret == 0 && wbc->nr_to_write == initial_nr_to_write)
 		set_bit(SDF_FORCE_AIL_FLUSH, &sdp->sd_flags);
 	return ret;
 }
-- 
2.53.0


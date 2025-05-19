Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C000D2749C8
	for <gfs2@lists.linux.dev>; Mon, 19 May 2025 11:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747653555; cv=none; b=MTkH3yfev7hS57JBuyXwdiVxHxyv9lu7OmF0x4IDC9+AaIlstt5qPjLGFxN1+xPb+eIqssBesytaDXysT7IbSgarkTIOws8MvNkHeRmc/yRlmXHuXw5S+ax2uUKU5ryR11SbMq2pRW3/UfZUsjcRFF9l7sajK2XdMO9OlIjJWyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747653555; c=relaxed/simple;
	bh=u20vkUe3ng0SYDMetGWKgsw9yzhxFlsc6VsDscw6rFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=oIwDnfsfiiUT7WF18/BGugxQH/zOWw73HDJcGOK2D3Kd+TZAYl/2uIbVc5LfMXH+J2wzJubxKPZRniB5dXJV5sGrOgfvY2tPAmhmJuZMzmNC6lr/jgoQNo0fozuT9ExJHeXCzOMYG70Jg2/Pl/CEYnWrb758ei7V8J04f49rt0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JsJ8SKB2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JsJ8SKB2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747653552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MpnG1S8lo0Gyu8DYBJ3Jip6gIl9yYU31r0rpJMQ2fII=;
	b=JsJ8SKB20+mxzT8s7RIuklUQYiaJHjWRisaLmdLMyArcwUsG4BiQpReD4rlKESn9kYLwK8
	c7In5KXA15wloOBrEChT26aCw6UxpdMVW4XMtBgTK8xmJdtjvojY58N7EC84DbmVqZJkdA
	kmkQt2bU/+pMYJX7fY5opfTKHJdMX/4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-EDYymbwqPWuGwMaiidcoPg-1; Mon,
 19 May 2025 07:19:11 -0400
X-MC-Unique: EDYymbwqPWuGwMaiidcoPg-1
X-Mimecast-MFC-AGG-ID: EDYymbwqPWuGwMaiidcoPg_1747653550
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A615F180034E
	for <gfs2@lists.linux.dev>; Mon, 19 May 2025 11:19:10 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.234])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9FEB11800570;
	Mon, 19 May 2025 11:19:09 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 1/6] gfs2: Minor comments fix
Date: Mon, 19 May 2025 13:19:00 +0200
Message-ID: <20250519111906.1503215-2-agruenba@redhat.com>
In-Reply-To: <20250519111906.1503215-1-agruenba@redhat.com>
References: <20250519111906.1503215-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SXFv2sX2KWiN4Gkgh0dogAqy6SS0VcovnQ0i_niM4sA_1747653550
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Commit 40829760096df ("gfs2: Convert gfs2_find_jhead() to use a folio")
replaced grab_cache_page() by filemap_grab_folio(), but the comments
were still referring to grab_cache_page().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/lops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index a1022635abc9..ba97e97d3eee 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -451,7 +451,7 @@ static bool gfs2_jhead_folio_search(struct gfs2_jdesc *jd,
  * Find the folio with 'index' in the journal's mapping. Search the folio for
  * the journal head if requested (cleanup == false). Release refs on the
  * folio so the page cache can reclaim it. We grabbed a
- * reference on this folio twice, first when we did a grab_cache_page()
+ * reference on this folio twice, first when we did a filemap_grab_folio()
  * to obtain the folio to add it to the bio and second when we do a
  * filemap_get_folio() here to get the folio to wait on while I/O on it is being
  * completed.
@@ -476,7 +476,7 @@ static void gfs2_jhead_process_page(struct gfs2_jdesc *jd, unsigned long index,
 	if (!*done)
 		*done = gfs2_jhead_folio_search(jd, head, folio);
 
-	/* filemap_get_folio() and the earlier grab_cache_page() */
+	/* filemap_get_folio() and the earlier filemap_grab_folio() */
 	folio_put_refs(folio, 2);
 }
 
-- 
2.49.0


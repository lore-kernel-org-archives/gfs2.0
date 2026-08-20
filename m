Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421F43451DA
	for <gfs2@lists.linux.dev>; Thu, 20 Aug 2026 14:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235704; cv=none; b=L4nbSIdaWHXTWgjwmagZamNmo2CwlOPYV9e8slCaOzhrfFmQRlLMgm0bB8ewT5ylhaAkbwct54Xc5C7Yh+MCQ7bV/bFbLpq2AbcTNijLJJBEdJdPRf8NudzQ23KrnpEJ6GIplKR9fbpaVkdu0WBQG0x4mW7oyj/VZ3LFSZvQMJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235704; c=relaxed/simple;
	bh=qm8H0dCEV2jE6irzIkR3bNCS2j2r4kdnrIR4rEpu+cY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=l9Q0WEOZsqp92FONFPsMe0hk0h7qXFwpKco6AvEcRYjNvmnXJeRKKcDL8I74sdU34oJL74JpuUz3a8r8mWT59xygAkaE1bv8fq983RLXnyAc5Jf3vtyabYgMP8SegPgHWkwtZ8emuJ6G2qkxTy4xWB2mywD1vBtd7Zcnh4tWjg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VhxJXJKm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VhxJXJKm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787235700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IIVpv0Wn6R0dQBzNR54UmeTwp69Q7hUylAhJa0c4gvg=;
	b=VhxJXJKmlib0euBwctvNwQI/8Jvp3F9SbLzJsdtymcR/n+LJXu9KArhWuANhvusVxOP+ze
	ZWCXxvfh2AQzEudMoIqFUhZ+aDHG93krpt/e6gkFbl9SQ+DXKjb5WqP4SvcaBuyI/arnBu
	5NJFeC0Z2btf/JeDmjiiPxS1DchKapQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-aRzq-eGgMuKBlII8AeNPQQ-1; Thu,
 20 Aug 2026 10:21:36 -0400
X-MC-Unique: aRzq-eGgMuKBlII8AeNPQQ-1
X-Mimecast-MFC-AGG-ID: aRzq-eGgMuKBlII8AeNPQQ_1787235696
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B8A2B19560B2;
	Thu, 20 Aug 2026 14:21:35 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.44.48.197])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8FACD3001DAF;
	Thu, 20 Aug 2026 14:21:34 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Adrian Garcia Casado <adriangarciacasado42@gmail.com>
Subject: [PATCH 2/6] gfs2: Get to super block from inode in tracepoints
Date: Thu, 20 Aug 2026 16:21:23 +0200
Message-ID: <20260820142129.1327413-3-agruenba@redhat.com>
In-Reply-To: <20260820142129.1327413-1-agruenba@redhat.com>
References: <20260820142129.1327413-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: huWyg3QgBjNkG0AeFp-KFYzEGJDTqlHnbo8cKI7zN-E_1787235696
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When we have a gfs2 inode, use that to get to the super block instead of
going via the glock.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/trace_gfs2.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/trace_gfs2.h b/fs/gfs2/trace_gfs2.h
index bc40320ef239..0c60d755ba76 100644
--- a/fs/gfs2/trace_gfs2.h
+++ b/fs/gfs2/trace_gfs2.h
@@ -457,7 +457,7 @@ TRACE_EVENT(gfs2_bmap,
 	),
 
 	TP_fast_assign(
-		__entry->dev            = glock_sbd(ip->i_gl)->sd_vfs->s_dev;
+		__entry->dev            = ip->i_inode.i_sb->s_dev;
 		__entry->lblock		= lblock;
 		__entry->pblock		= buffer_mapped(bh) ?  bh->b_blocknr : 0;
 		__entry->inum		= ip->i_no_addr;
@@ -493,7 +493,7 @@ TRACE_EVENT(gfs2_iomap_start,
 	),
 
 	TP_fast_assign(
-		__entry->dev            = glock_sbd(ip->i_gl)->sd_vfs->s_dev;
+		__entry->dev            = ip->i_inode.i_sb->s_dev;
 		__entry->inum		= ip->i_no_addr;
 		__entry->pos		= pos;
 		__entry->length		= length;
@@ -525,7 +525,7 @@ TRACE_EVENT(gfs2_iomap_end,
 	),
 
 	TP_fast_assign(
-		__entry->dev            = glock_sbd(ip->i_gl)->sd_vfs->s_dev;
+		__entry->dev            = ip->i_inode.i_sb->s_dev;
 		__entry->inum		= ip->i_no_addr;
 		__entry->offset		= iomap->offset;
 		__entry->length		= iomap->length;
-- 
2.55.0


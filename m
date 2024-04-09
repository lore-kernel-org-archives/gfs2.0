Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B08E1534E2
	for <gfs2@lists.linux.dev>; Tue,  9 Apr 2024 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712681119; cv=none; b=eHVbDcBnjhkUU5W8r57wg79WRLZzGlH1tn5RRppA5JWHHRn0vcldvUhTUCJxoiN7HyAwiPZub+b6tdIh7OvYPT6vYNGycA3F4UE5/bpuWbJ3jOZ4zkn3txrf4Wh+KEkd/6MF5foZ+czlWfAdqVAGGIKsmpabBPLhkvWuERwRcYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712681119; c=relaxed/simple;
	bh=gFTfmVy7sDVASBgx4XRAcZhCIik3oJVlPnYTrnB3tvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H3DpSUkZjrTnZWQaqLeeT4IpO8lhGoyv9MQ46ZsP2BuPFKWR9ozpsVmEsGedNU8yr8m9gzlh5VrtwuAyULjsD70WwSdNF6lDP8zvjOD6shpA3IDAZBXo7+lEQ57t39nNPrAVzSVW1W36KGMbcyTpSDX2PetafzdzSyS2oMwKlQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VSKThEno; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VSKThEno"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712681117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CzaPCffcq09nSdySDB/utowvnbGBMGBEU1/ZdMbQC10=;
	b=VSKThEnowXEB9VcHximcnz0TR2YKYvzeiDmhIYkB9n+cEFep4mLtZTLzsccVMkK76VVLgv
	2GFVTAYcVb7OEHOg3ohG1vZvOIgtc2e+4P1jEWsw+YDFWBS6vlr47PwNdT9L7HSPRecYlz
	gkbmQv+7yxHxW6k7ZHdUJsL+SVmtW3A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-wNjXtM_RO8WsKGFcBlQg0g-1; Tue,
 09 Apr 2024 12:45:15 -0400
X-MC-Unique: wNjXtM_RO8WsKGFcBlQg0g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 642D43C13A81
	for <gfs2@lists.linux.dev>; Tue,  9 Apr 2024 16:45:15 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.28])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D8A5BC0157E;
	Tue,  9 Apr 2024 16:45:14 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 02/15] gfs2: Remove unnecessary gfs2_meta_check_ii argument
Date: Tue,  9 Apr 2024 18:44:52 +0200
Message-ID: <20240409164508.79570-3-agruenba@redhat.com>
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

The type argument of gfs2_meta_check_ii() is always set to "magic
number", so remove that argument and hardcode the string in
gfs2_meta_check_ii().  Change the string to "bad magic number" to
emphasize that the problem is the incorrect magic number.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/util.c | 6 +++---
 fs/gfs2/util.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index fd65a2e34102..963d77c4ca21 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -488,16 +488,16 @@ void gfs2_consist_rgrpd_i(struct gfs2_rgrpd *rgd,
  */
 
 int gfs2_meta_check_ii(struct gfs2_sbd *sdp, struct buffer_head *bh,
-		       const char *type, const char *function, char *file,
+		       const char *function, char *file,
 		       unsigned int line)
 {
 	int me;
 
 	gfs2_lm(sdp,
 		"fatal: invalid metadata block - "
-		"bh = %llu (%s), "
+		"bh = %llu (bad magic number), "
 		"function = %s, file = %s, line = %u\n",
-		(unsigned long long)bh->b_blocknr, type,
+		(unsigned long long)bh->b_blocknr,
 		function, file, line);
 	me = gfs2_withdraw(sdp);
 	return (me) ? -1 : -2;
diff --git a/fs/gfs2/util.h b/fs/gfs2/util.h
index ba071998461f..d8d62bf0424d 100644
--- a/fs/gfs2/util.h
+++ b/fs/gfs2/util.h
@@ -92,7 +92,7 @@ gfs2_consist_rgrpd_i((rgd), __func__, __FILE__, __LINE__)
 
 
 int gfs2_meta_check_ii(struct gfs2_sbd *sdp, struct buffer_head *bh,
-		       const char *type, const char *function,
+		       const char *function,
 		       char *file, unsigned int line);
 
 static inline int gfs2_meta_check(struct gfs2_sbd *sdp,
@@ -123,7 +123,7 @@ static inline int gfs2_metatype_check_i(struct gfs2_sbd *sdp,
 	u32 magic = be32_to_cpu(mh->mh_magic);
 	u16 t = be32_to_cpu(mh->mh_type);
 	if (unlikely(magic != GFS2_MAGIC))
-		return gfs2_meta_check_ii(sdp, bh, "magic number", function,
+		return gfs2_meta_check_ii(sdp, bh, function,
 					  file, line);
         if (unlikely(t != type))
 		return gfs2_metatype_check_ii(sdp, bh, type, t, function,
-- 
2.44.0


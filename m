Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1320F15359E
	for <gfs2@lists.linux.dev>; Tue,  9 Apr 2024 16:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712681125; cv=none; b=QAiLkgdZMwnawhko1sTcM26sc1tIN/COMR613mgRdTcToSmpxL/AbNeyybqFBy4sKx9OSkYt9Ts3nLpZQk0wDXPLtx5GT0Ftcdt+v/J93z/df0h+95IfswGL1hgI4QxicRdf29wM8VCNEcvsEb9sznQqW9A12OWBEdOfu4+0E9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712681125; c=relaxed/simple;
	bh=bR4jLuPRdB9itQT+S9iz6f4k2MNydWTnZRtMPJ3C8Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kGUpjdqIlBoXUnigrM3W/9zfM7EMDOdo2MXE5kCtSWyDmCBErn9uDDIHQEyyWPKjXQ6g+n0lkSZxtpkIcb17uRjiTrO4UP4WADfNeQGWkg46ouPrUxCSg+4K++BWw2zfbVh/C7yhBbLxcHVzl+/e/sJr+kjOpIZz4DnwBDvRD2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RzmSDPC2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RzmSDPC2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712681123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PBo+Jvt1Oz0gEx0PdlC91T+IEAont208+qVs05q/13Y=;
	b=RzmSDPC2GnlnfQ+npX6whoXXrrNhPZhQsgf7/7z1waCjFCtEbnxbenF+fG5Kwmnx0UkwBd
	IcaEWJcOJBn6DEEL8UXkoH2VHD6NNXqpbBnPgRj9C1+Vp0KlE7pOziWH9yOrqtgmXVpCi9
	Uva3LOSp/SgDl+wCQ8/t5M0t1PuqDYo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-ON5vRLgqOt2glL_IiWNt-g-1; Tue, 09 Apr 2024 12:45:21 -0400
X-MC-Unique: ON5vRLgqOt2glL_IiWNt-g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6DC0E1049BC7
	for <gfs2@lists.linux.dev>; Tue,  9 Apr 2024 16:45:21 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.28])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E3033C09A05;
	Tue,  9 Apr 2024 16:45:20 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 10/15] gfs2: Get rid of unnecessary test_and_set_bit
Date: Tue,  9 Apr 2024 18:45:00 +0200
Message-ID: <20240409164508.79570-11-agruenba@redhat.com>
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

The GLF_LOCK flag is protected by the gl->gl_lockref.lock spin lock
which is held when entering run_queue(), so we can use test_bit() and
set_bit() here.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index a700e424f790..fa047331ea3c 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -842,8 +842,9 @@ __acquires(&gl->gl_lockref.lock)
 {
 	struct gfs2_holder *gh = NULL;
 
-	if (test_and_set_bit(GLF_LOCK, &gl->gl_flags))
+	if (test_bit(GLF_LOCK, &gl->gl_flags))
 		return;
+	set_bit(GLF_LOCK, &gl->gl_flags);
 
 	GLOCK_BUG_ON(gl, test_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags));
 
-- 
2.44.0


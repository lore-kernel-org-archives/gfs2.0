Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E95C1DF98D
	for <gfs2@lists.linux.dev>; Wed, 28 May 2025 15:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748444581; cv=none; b=HhPtGsjAtaAMuudiptKKaxK7dHfxAdi+SIJnYdDy+sz2yWtyzqw6geAxh+q2zjb71OaE40kk32SEhDj18/tRhl6fIZpq8O9Dlu1ptfyVldb2loM/0vunkTgEuybYHjSl4s+QdsFUnm94TVoJFrGq71Yf1ZtmEMkVWy+OMdrxGfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748444581; c=relaxed/simple;
	bh=qd5ZX/hFHETFi3jGJ1BQSrCE/hNdRzNe+2trcRmgFu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=lNsGIrwmg02pz0hXbeNTClMohkYCRooB+4PGreXQepphKwybr1iCBzKAZj1ssWAQAYb/DuYP3jxmodQX6zlFey0Mus5usCOElltYEs6MoRjVZ/I9+lVuYDEUCZIIxks0dRuGI8UZQaK3LO0CZZYQaq2f7Dl4MDaQWLJYtOlSplw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bE9Y9dj8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bE9Y9dj8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748444578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=02NqfXW2kgyLkaTwdxisZkKyZxXUXRZKu9jpN9jfhQw=;
	b=bE9Y9dj8+XR0SSb1Ct3nFTLxOHA5a5vHjr8E7ClvKMS5c8Zy41uJ26ppcWMkEmEIixMp2P
	LBloKEK/7Dd0PmRiZo2VIbHD+MzT9fxqh8Z9qb93u4D/FHf/YYsV4Tp4aaVWVQ2BrsGJ/g
	tTE3fY85FKHFjDYClob3DFdcopHEp6s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-dzdwvwmiM_WEMlGMb8aLHg-1; Wed,
 28 May 2025 11:02:56 -0400
X-MC-Unique: dzdwvwmiM_WEMlGMb8aLHg-1
X-Mimecast-MFC-AGG-ID: dzdwvwmiM_WEMlGMb8aLHg_1748444575
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 679741944F0D;
	Wed, 28 May 2025 15:02:55 +0000 (UTC)
Received: from b.redhat.com (unknown [10.42.28.183])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F5DB1955F1B;
	Wed, 28 May 2025 15:02:52 +0000 (UTC)
From: Andrew Price <anprice@redhat.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	syzbot+b12826218502df019f9d@syzkaller.appspotmail.com
Subject: [PATCH] gfs2: Don't clear sb->s_fs_info in gfs2_sys_fs_add()
Date: Wed, 28 May 2025 16:02:37 +0100
Message-ID: <20250528150237.171254-1-anprice@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rKhjzm5aHb9qxTyY1NDdntgH4LuVL_COigkM90e3SmQ_1748444575
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When gfs2_sys_fs_add() fails it sets sb->s_fs_info to NULL which results
in a NULL pointer deref in gfs2_drop_inode() when iput(sdp->sd_inode) is
called in the gfs2_fill_super() error path. Remove the NULL assignment
from gfs2_sys_fs_add() and let gfs2_fill_super() deal with it instead,
after the iput().

Fixes: ae9f3bd8259a ("gfs2: replace sd_aspace with sd_inode")
Reported-by: syzbot+b12826218502df019f9d@syzkaller.appspotmail.com
Signed-off-by: Andrew Price <anprice@redhat.com>
---
 fs/gfs2/sys.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index 748125653d6c..c3c8842920d2 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -764,7 +764,6 @@ int gfs2_sys_fs_add(struct gfs2_sbd *sdp)
 	fs_err(sdp, "error %d adding sysfs files\n", error);
 	kobject_put(&sdp->sd_kobj);
 	wait_for_completion(&sdp->sd_kobj_unregister);
-	sb->s_fs_info = NULL;
 	return error;
 }
 
-- 
2.49.0


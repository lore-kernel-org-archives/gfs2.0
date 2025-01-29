Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F401D63CE
	for <gfs2@lists.linux.dev>; Wed, 29 Jan 2025 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738161248; cv=none; b=kiJHlffyW5MWNxym8tI/ucwXZBdljR+M6giIQinqEmm7BuTH8hOLdp8baGll8m7SzQJKyGTCbU10GlcLF8Y50WG/NBcXPN5K0BMiVJ2REERd/NMPUX6Nf0C9EQMEFaDLL0TDZkMTQp60+ieDJS0QR1bLUY7peqmuqtjh9MXTtAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738161248; c=relaxed/simple;
	bh=4t+5unmGv52HY7nsPdUt+YPnFklMQEdDwWh34rLapjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IgsdsU3Fh3fnQ+0yRfmH/2l/7VZ3mW2MDaE6UnaPyQ3x0ySPRW2Par14yVrXGRr83H/9Yf964sxT2kJsJYa9fY4w09P5slaYBwCo9ZWGePiy+M1PoK6+OpVyo+46o/aY/ak1X3uMlh4c4XXu5KXzbn/DM0l53GUkGsE4tk9bMRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YTYj2K+P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YTYj2K+P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738161246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rWQmcBfn6LxROs0Geum4JpiJkxmd4QKKpQmGmi4WG/c=;
	b=YTYj2K+PFlO80vgicSUP8cXtgxieVF7GibTJlaMC+diSth4pGkfRZkG6mOYc1F/NiVg7tT
	ppALPmYICfsJSl0i34+4FZZu0OMRrkU41IY/hILaCB1RH5rESceDzFABvs3li1Qa3Ey76E
	MStC4LH1YUWFobyfib8LtFX/6BjIHYA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-AW3pbO1ZPR224uRpqvyw6A-1; Wed,
 29 Jan 2025 09:34:01 -0500
X-MC-Unique: AW3pbO1ZPR224uRpqvyw6A-1
X-Mimecast-MFC-AGG-ID: AW3pbO1ZPR224uRpqvyw6A
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76B551800374;
	Wed, 29 Jan 2025 14:34:00 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.234])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 167A51800955;
	Wed, 29 Jan 2025 14:33:57 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] gfs2: use lockref_init for gl_lockref
Date: Wed, 29 Jan 2025 15:33:50 +0100
Message-ID: <20250129143353.1892423-2-agruenba@redhat.com>
In-Reply-To: <20250129143353.1892423-1-agruenba@redhat.com>
References: <20250129143353.1892423-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Move the initialization of gl_lockref from gfs2_init_glock_once() to
gfs2_glock_get().  This allows to use lockref_init() there.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 2 +-
 fs/gfs2/main.c  | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 8c4c1f871a88..b29eb71e3e29 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1201,8 +1201,8 @@ int gfs2_glock_get(struct gfs2_sbd *sdp, u64 number,
 	if (glops->go_instantiate)
 		gl->gl_flags |= BIT(GLF_INSTANTIATE_NEEDED);
 	gl->gl_name = name;
+	lockref_init(&gl->gl_lockref, 1);
 	lockdep_set_subclass(&gl->gl_lockref.lock, glops->go_subclass);
-	gl->gl_lockref.count = 1;
 	gl->gl_state = LM_ST_UNLOCKED;
 	gl->gl_target = LM_ST_UNLOCKED;
 	gl->gl_demote_state = LM_ST_EXCLUSIVE;
diff --git a/fs/gfs2/main.c b/fs/gfs2/main.c
index 04cadc02e5a6..0727f60ad028 100644
--- a/fs/gfs2/main.c
+++ b/fs/gfs2/main.c
@@ -51,7 +51,6 @@ static void gfs2_init_glock_once(void *foo)
 {
 	struct gfs2_glock *gl = foo;
 
-	spin_lock_init(&gl->gl_lockref.lock);
 	INIT_LIST_HEAD(&gl->gl_holders);
 	INIT_LIST_HEAD(&gl->gl_lru);
 	INIT_LIST_HEAD(&gl->gl_ail_list);
-- 
2.48.1


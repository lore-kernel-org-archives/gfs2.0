Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A2815E98
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OoEzAOUJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698857189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AWZd/yHGP/aTwPsbpgSQlpn2KzueBb8wkNjRsZM6/30=;
	b=OoEzAOUJ+ZREe8xnKmxJ/NcRlOs8sLPCR6VPdft1EbtwMnH1QSP06Az8i2lenIvNJSkYDf
	dNs+m6UctrLWaG6AxWqjAasHlfFK2FBEyFEi22Gwn7F0fvshr+elkIR6UKwo3Jnd4Yk9As
	ipmmX4OtVpbqSME7M0jWq1w51dp8YBg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-4Sm9a9NGPO6rXmevBWVavQ-1; Wed, 01 Nov 2023 12:46:25 -0400
X-MC-Unique: 4Sm9a9NGPO6rXmevBWVavQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F83D847729
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:25 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C397A40C6EBC;
	Wed,  1 Nov 2023 16:46:24 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 10/25] gfs2: Two quota=account mode fixes
Date: Wed,  1 Nov 2023 17:46:00 +0100
Message-ID: <20231101164615.1138692-11-agruenba@redhat.com>
In-Reply-To: <20231101164615.1138692-1-agruenba@redhat.com>
References: <20231101164615.1138692-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Make sure we don't skip accounting for quota changes with the
quota=account mount option.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/quota.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 41d0232532a0..d0d01d485621 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -1083,8 +1083,7 @@ int gfs2_quota_lock(struct gfs2_inode *ip, kuid_t uid, kgid_t gid)
 	u32 x;
 	int error;
 
-	if (sdp->sd_args.ar_quota != GFS2_QUOTA_ON &&
-	    sdp->sd_args.ar_quota != GFS2_QUOTA_QUIET)
+	if (sdp->sd_args.ar_quota == GFS2_QUOTA_OFF)
 		return 0;
 
 	error = gfs2_quota_hold(ip, uid, gid);
@@ -1285,8 +1284,7 @@ void gfs2_quota_change(struct gfs2_inode *ip, s64 change,
 	u32 x;
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
 
-	if ((sdp->sd_args.ar_quota != GFS2_QUOTA_ON &&
-	    sdp->sd_args.ar_quota != GFS2_QUOTA_QUIET) ||
+	if (sdp->sd_args.ar_quota == GFS2_QUOTA_OFF ||
 	    gfs2_assert_warn(sdp, change))
 		return;
 	if (ip->i_diskflags & GFS2_DIF_SYSTEM)
-- 
2.41.0


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA12B15E8A
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MImZuAzt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698857193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p6CSHAExyd+gTrAL7mn3Mj9Ct1qK2hSZIMS+WZSIXcs=;
	b=MImZuAztyKx4DBfLHtjtcNkEXgU2n+cshLrQnxnU63atFFNvWzqLxOdAW/o/IwjFwsDOwm
	SrbJ4lECNpqsVDVIcP4258FLlGRcXXIVORczrfmJ6duHs6c0cQydAGDOsDCrHRxHaQugzL
	wriixH3iypDQAt4lZa4uTwXvvMiDVm4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-DW3WPULVPQCB2sQ9vsysYg-1; Wed, 01 Nov 2023 12:46:27 -0400
X-MC-Unique: DW3WPULVPQCB2sQ9vsysYg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C89061064BEA
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:26 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4AA4E40C6EBC;
	Wed,  1 Nov 2023 16:46:26 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 12/25] gfs2: Clean up quota.c:print_message
Date: Wed,  1 Nov 2023 17:46:02 +0100
Message-ID: <20231101164615.1138692-13-agruenba@redhat.com>
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

Function print_message() in quota.c doesn't return a meaningful return
value.  Turn it into a void function and stop abusing it for setting
variable error to 0 in gfs2_quota_check().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/quota.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 27f14ef4d346..e72b5864a63a 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -1190,17 +1190,16 @@ void gfs2_quota_unlock(struct gfs2_inode *ip)
 
 #define MAX_LINE 256
 
-static int print_message(struct gfs2_quota_data *qd, char *type)
+static void print_message(struct gfs2_quota_data *qd, char *type)
 {
 	struct gfs2_sbd *sdp = qd->qd_sbd;
 
-	if (sdp->sd_args.ar_quota != GFS2_QUOTA_QUIET)
+	if (sdp->sd_args.ar_quota != GFS2_QUOTA_QUIET) {
 		fs_info(sdp, "quota %s for %s %u\n",
 			type,
 			(qd->qd_id.type == USRQUOTA) ? "user" : "group",
 			from_kqid(&init_user_ns, qd->qd_id));
-
-	return 0;
+	}
 }
 
 /**
@@ -1270,7 +1269,8 @@ int gfs2_quota_check(struct gfs2_inode *ip, kuid_t uid, kgid_t gid,
 					 * HZ)) {
 			quota_send_warning(qd->qd_id,
 					   sdp->sd_vfs->s_dev, QUOTA_NL_BSOFTWARN);
-			error = print_message(qd, "warning");
+			print_message(qd, "warning");
+			error = 0;
 			qd->qd_last_warn = jiffies;
 		}
 	}
-- 
2.41.0


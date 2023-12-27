Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240BC2B9BF
	for <gfs2@lists.linux.dev>; Wed, 27 Dec 2023 12:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MOeU4MVc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703680227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FHxarPNMxrmFGeXaXqIRmiXQR+iQEp+Br1a6z1ZqGmc=;
	b=MOeU4MVckD6t06I7qn5UfDrtVSFIztur3i1o2R0PnVaxyMhWbzi4pxQJ9Z31tJupawEJs9
	HkbGNK4/m2TA4qHJfITcaw8UDhnHUn1cTH2gv+ZOXnAm0Vt/4f9skXlWR2xmvkvUcUtZ3G
	LhnObpbWuXJ5F0BSgXdgCJE/710ysj8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-CqaYbOE-MyuWJpFuoIBILg-1; Wed, 27 Dec 2023 07:30:25 -0500
X-MC-Unique: CqaYbOE-MyuWJpFuoIBILg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A1CD803918
	for <gfs2@lists.linux.dev>; Wed, 27 Dec 2023 12:30:25 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.39])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C3365492BC6;
	Wed, 27 Dec 2023 12:30:24 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 1/3] gfs2: Minor gfs2_{freeze,thaw}_super cleanup
Date: Wed, 27 Dec 2023 13:30:22 +0100
Message-ID: <20231227123024.2698471-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This minor cleanup to gfs2_freeze_super() and gfs2_thaw_super() prepares
for the following refcounting fix.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/super.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index cf3431486fd4..6b45b7866212 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -759,9 +759,10 @@ static int gfs2_freeze_super(struct super_block *sb, enum freeze_holder who)
 
 	if (!mutex_trylock(&sdp->sd_freeze_mutex))
 		return -EBUSY;
-	error = -EBUSY;
-	if (test_bit(SDF_FROZEN, &sdp->sd_flags))
-		goto out;
+	if (test_bit(SDF_FROZEN, &sdp->sd_flags)) {
+		mutex_unlock(&sdp->sd_freeze_mutex);
+		return -EBUSY;
+	}
 
 	for (;;) {
 		error = gfs2_freeze_locally(sdp);
@@ -772,8 +773,11 @@ static int gfs2_freeze_super(struct super_block *sb, enum freeze_holder who)
 		}
 
 		error = gfs2_lock_fs_check_clean(sdp);
-		if (!error)
-			break;  /* success */
+		if (!error) {
+			set_bit(SDF_FREEZE_INITIATOR, &sdp->sd_flags);
+			set_bit(SDF_FROZEN, &sdp->sd_flags);
+			break;
+		}
 
 		error = gfs2_do_thaw(sdp);
 		if (error)
@@ -793,10 +797,6 @@ static int gfs2_freeze_super(struct super_block *sb, enum freeze_holder who)
 	}
 
 out:
-	if (!error) {
-		set_bit(SDF_FREEZE_INITIATOR, &sdp->sd_flags);
-		set_bit(SDF_FROZEN, &sdp->sd_flags);
-	}
 	mutex_unlock(&sdp->sd_freeze_mutex);
 	return error;
 }
@@ -814,9 +814,10 @@ static int gfs2_thaw_super(struct super_block *sb, enum freeze_holder who)
 
 	if (!mutex_trylock(&sdp->sd_freeze_mutex))
 		return -EBUSY;
-	error = -EINVAL;
-	if (!test_bit(SDF_FREEZE_INITIATOR, &sdp->sd_flags))
-		goto out;
+	if (!test_bit(SDF_FREEZE_INITIATOR, &sdp->sd_flags)) {
+		mutex_unlock(&sdp->sd_freeze_mutex);
+		return -EINVAL;
+	}
 
 	gfs2_freeze_unlock(&sdp->sd_freeze_gh);
 
@@ -826,7 +827,6 @@ static int gfs2_thaw_super(struct super_block *sb, enum freeze_holder who)
 		clear_bit(SDF_FREEZE_INITIATOR, &sdp->sd_flags);
 		clear_bit(SDF_FROZEN, &sdp->sd_flags);
 	}
-out:
 	mutex_unlock(&sdp->sd_freeze_mutex);
 	return error;
 }
-- 
2.43.0


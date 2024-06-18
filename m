Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE4D208A0
	for <gfs2@lists.linux.dev>; Tue, 18 Jun 2024 16:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726738; cv=none; b=Ls425tqiwyo6ghJX9WiQtEXXuOqdcE1OKSGfF1c39MGEk0laVLeeszDwvdZ6sj7sEtR2YzwHmsQ5XXVNdWScBkHM2e3d6fm51LbXYLGSAocQyxoD7sBsb5jxBevXT7u5JUGdPV70lbUkBTaGpsGrDCTTjR/kKxSH/9PVqhTc+5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726738; c=relaxed/simple;
	bh=+rVUuMVo69zSJrJHTRw7w6PXuURJnS63PMwIhO9ZHrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SUJS5ko8lpj3XnQj31Z4GDq9XsSs4IPzO+ejx8DpkgrofgjS/o+wYF/vElN9ct9knVTcPEr751o5EbewxFfKhC+XnTeL7wajcTCayGtczofPnHxlnqeY5lFWzjbhxHuc+TB+07rjRDvLswH5Sup04I4h8W0R8ndJUgaQcqboBxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZORhXZgC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZORhXZgC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718726736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fQ8aledkgs53UOZ2bNejWBd/IvGZ8xGBbfS1fEQCzho=;
	b=ZORhXZgCZ0oD//sv0nLYNJ1qn/hTbIg6p4jXivvd5IN1pIL8Tl5tDtBXMGcHaM4gdWgbQf
	2uvGfCIeVv4bD5NkSadWuavrWmkDhT3pIQHrjkzoZN7rTbfDoyleNRcVhA4dTpxqsY87UF
	eFK8SK/RO46TIw1P74JprD6ISCITVXM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-CPS-EyeePtSVH-OF7do-_g-1; Tue,
 18 Jun 2024 12:05:34 -0400
X-MC-Unique: CPS-EyeePtSVH-OF7do-_g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3BEC19560BE
	for <gfs2@lists.linux.dev>; Tue, 18 Jun 2024 16:05:33 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8DC9C19560AE;
	Tue, 18 Jun 2024 16:05:32 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 09/13] gfs2: Fold qd_fish into gfs2_quota_sync
Date: Tue, 18 Jun 2024 18:05:13 +0200
Message-ID: <20240618160517.901589-10-agruenba@redhat.com>
In-Reply-To: <20240618160517.901589-1-agruenba@redhat.com>
References: <20240618160517.901589-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The split between qd_fish() and gfs2_quota_sync() is rather unfortunate
as qd_fish() is repeatedly called to scan sdp->sd_quota_list only to
find the next object to that needs syncing; if there are multiple
objects on the list that need syncing, it makes more sense to grab them
all in one go.  This is relatively easy to do when qd_fish() is folded
into gfs2_quota_sync().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/quota.c | 77 +++++++++++++++++++------------------------------
 1 file changed, 29 insertions(+), 48 deletions(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 11bd16d8f81c..ae02403407aa 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -484,40 +484,6 @@ static void qd_ungrab_sync(struct gfs2_quota_data *qd)
 	qd_put(qd);
 }
 
-static int qd_fish(struct gfs2_sbd *sdp, struct gfs2_quota_data **qdp)
-{
-	struct gfs2_quota_data *qd = NULL, *iter;
-	int error;
-
-	*qdp = NULL;
-
-	if (sb_rdonly(sdp->sd_vfs))
-		return 0;
-
-	spin_lock(&qd_lock);
-
-	list_for_each_entry(iter, &sdp->sd_quota_list, qd_list) {
-		if (qd_grab_sync(sdp, iter, sdp->sd_quota_sync_gen)) {
-			qd = iter;
-			break;
-		}
-	}
-
-	spin_unlock(&qd_lock);
-
-	if (qd) {
-		error = bh_get(qd);
-		if (error) {
-			qd_ungrab_sync(qd);
-			return error;
-		}
-	}
-
-	*qdp = qd;
-
-	return 0;
-}
-
 static void qdsb_put(struct gfs2_quota_data *qd)
 {
 	bh_put(qd);
@@ -1332,10 +1298,10 @@ int gfs2_quota_sync(struct super_block *sb, int type)
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 	struct gfs2_quota_data **qda;
 	unsigned int max_qd = PAGE_SIZE / sizeof(struct gfs2_holder);
-	unsigned int num_qd;
-	unsigned int x;
 	int error = 0;
 
+	if (sb_rdonly(sdp->sd_vfs))
+		return 0;
 	if (!qd_changed(sdp))
 		return 0;
 
@@ -1347,24 +1313,39 @@ int gfs2_quota_sync(struct super_block *sb, int type)
 	sdp->sd_quota_sync_gen++;
 
 	do {
-		num_qd = 0;
+		struct gfs2_quota_data *iter;
+		unsigned int num_qd = 0;
+		unsigned int x;
 
-		for (;;) {
-			error = qd_fish(sdp, qda + num_qd);
-			if (error || !qda[num_qd])
-				break;
-			if (++num_qd == max_qd)
-				break;
+		spin_lock(&qd_lock);
+		list_for_each_entry(iter, &sdp->sd_quota_list, qd_list) {
+			if (qd_grab_sync(sdp, iter, sdp->sd_quota_sync_gen)) {
+				qda[num_qd++] = iter;
+				if (num_qd == max_qd)
+					break;
+			}
 		}
+		spin_unlock(&qd_lock);
 
-		if (num_qd) {
+		if (!num_qd)
+			break;
+
+		for (x = 0; x < num_qd; x++) {
+			error = bh_get(qda[x]);
 			if (!error)
-				error = do_sync(num_qd, qda);
+				continue;
 
-			for (x = 0; x < num_qd; x++)
-				qd_unlock(qda[x]);
+			while (x < num_qd)
+				qd_ungrab_sync(qda[--num_qd]);
+			break;
 		}
-	} while (!error && num_qd == max_qd);
+
+		if (!error)
+			error = do_sync(num_qd, qda);
+
+		for (x = 0; x < num_qd; x++)
+			qd_unlock(qda[x]);
+	} while (!error);
 
 	mutex_unlock(&sdp->sd_quota_sync_mutex);
 	kfree(qda);
-- 
2.45.1


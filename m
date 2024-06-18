Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47F74778B
	for <gfs2@lists.linux.dev>; Tue, 18 Jun 2024 16:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726742; cv=none; b=VrRaukXsr96XXA8H2IrXJdVYdnpnXyY0tuwD2RXYEtQ7qA4BdUiSB8CcJWhZqlYKZIrF6mj7/3OISgN2oglO/kFEx7SUHxxKGg7V016+htdKUpftA+CHU2VQjoGc43joibUPY2bDZrZ/GD7OLEAT+rWZVkALXmFiiImdiGic89g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726742; c=relaxed/simple;
	bh=q7Ogofper+bQGUz/h2Ep1vAVkEcF2HgwhW6AsLE5QHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oWienwbYQB96JXCDGZd4Zg1SpjnYiUhiGwRLeLoxTJQ9gNsu4ccr9p3msQ1uBz3/GUhxdN1Yjhx+m5qpadoV5VS15YxmBh8BAlZmwj7YSNYMOSoudyHPaRj0vmziVpmwNGGZYt41K7/7HSgp+YeajPflqJn7OZnPaytrEIXJox4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UNKm12bt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNKm12bt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718726740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ecAYwsmON3ORf+WkaUi/lcpCmglLqQPvIgUZOSnC8cY=;
	b=UNKm12btDvInze1el7c4vdgrXCeh6QmMxoMky/46G2JjThTbX9qk7ZGtr9EQxl6V1oJVO+
	aWl1pWAnZUe0nZwrzy/9SYp8vlGHBu3ZDSHiI+i1B+mJnqCWPjAaOvqZicgBh1AzB3/6yh
	XOCRGW9rWfb03O9YWaLwBUytADRT88U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-RwQ51i4xOkC7y4WnpXfWcQ-1; Tue,
 18 Jun 2024 12:05:38 -0400
X-MC-Unique: RwQ51i4xOkC7y4WnpXfWcQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E90701956094
	for <gfs2@lists.linux.dev>; Tue, 18 Jun 2024 16:05:37 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B57C419560AE;
	Tue, 18 Jun 2024 16:05:36 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 12/13] gfs2: Be more careful with the quota sync generation
Date: Tue, 18 Jun 2024 18:05:16 +0200
Message-ID: <20240618160517.901589-13-agruenba@redhat.com>
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

The quota sync generation is only ever updated under sd_quota_sync_mutex
by gfs2_quota_sync(), but its current value is fetched ouside of that
mutex, so use WRITE_ONCE() and READ_ONCE() when accessing it without
holding that mutex.

Pass the current sync generation to do_sync() from its callers to ensure
that we're not recording the wrong generation when the syncing is
done.  Also, make sure that qd->qd_sync_gen only ever moves forward.

In gfs2_quota_sync(), only write the new sync generation when we know
that there are changes.  This eliminates the need for function
sd_changed(), which we will remove in the next commit.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/quota.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 2490117afb96..e27fceee9c63 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -893,7 +893,8 @@ static int gfs2_adjust_quota(struct gfs2_sbd *sdp, loff_t loc,
 	return err;
 }
 
-static int do_sync(unsigned int num_qd, struct gfs2_quota_data **qda)
+static int do_sync(unsigned int num_qd, struct gfs2_quota_data **qda,
+		   u64 sync_gen)
 {
 	struct gfs2_sbd *sdp = (*qda)->qd_sbd;
 	struct gfs2_inode *ip = GFS2_I(sdp->sd_quota_inode);
@@ -984,8 +985,13 @@ static int do_sync(unsigned int num_qd, struct gfs2_quota_data **qda)
 	gfs2_log_flush(ip->i_gl->gl_name.ln_sbd, ip->i_gl,
 		       GFS2_LOG_HEAD_FLUSH_NORMAL | GFS2_LFC_DO_SYNC);
 	if (!error) {
-		for (x = 0; x < num_qd; x++)
-			qda[x]->qd_sync_gen = sdp->sd_quota_sync_gen;
+		for (x = 0; x < num_qd; x++) {
+			qd = qda[x];
+			spin_lock(&qd->qd_lockref.lock);
+			if (qd->qd_sync_gen < sync_gen)
+				qd->qd_sync_gen = sync_gen;
+			spin_unlock(&qd->qd_lockref.lock);
+		}
 	}
 	return error;
 }
@@ -1179,7 +1185,9 @@ void gfs2_quota_unlock(struct gfs2_inode *ip)
 	}
 
 	if (count) {
-		do_sync(count, qda);
+		u64 sync_gen = READ_ONCE(sdp->sd_quota_sync_gen);
+
+		do_sync(count, qda, sync_gen);
 		for (x = 0; x < count; x++)
 			qd_unlock(qda[x]);
 	}
@@ -1325,6 +1333,7 @@ int gfs2_quota_sync(struct super_block *sb, int type)
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 	struct gfs2_quota_data **qda;
 	unsigned int max_qd = PAGE_SIZE / sizeof(struct gfs2_holder);
+	u64 sync_gen;
 	int error = 0;
 
 	if (sb_rdonly(sdp->sd_vfs))
@@ -1337,7 +1346,7 @@ int gfs2_quota_sync(struct super_block *sb, int type)
 		return -ENOMEM;
 
 	mutex_lock(&sdp->sd_quota_sync_mutex);
-	sdp->sd_quota_sync_gen++;
+	sync_gen = sdp->sd_quota_sync_gen + 1;
 
 	do {
 		struct gfs2_quota_data *iter;
@@ -1346,7 +1355,7 @@ int gfs2_quota_sync(struct super_block *sb, int type)
 
 		spin_lock(&qd_lock);
 		list_for_each_entry(iter, &sdp->sd_quota_list, qd_list) {
-			if (qd_grab_sync(sdp, iter, sdp->sd_quota_sync_gen)) {
+			if (qd_grab_sync(sdp, iter, sync_gen)) {
 				qda[num_qd++] = iter;
 				if (num_qd == max_qd)
 					break;
@@ -1367,8 +1376,10 @@ int gfs2_quota_sync(struct super_block *sb, int type)
 			break;
 		}
 
-		if (!error)
-			error = do_sync(num_qd, qda);
+		if (!error) {
+			WRITE_ONCE(sdp->sd_quota_sync_gen, sync_gen);
+			error = do_sync(num_qd, qda, sync_gen);
+		}
 
 		for (x = 0; x < num_qd; x++)
 			qd_unlock(qda[x]);
-- 
2.45.1


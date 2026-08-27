Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6114252D9
	for <gfs2@lists.linux.dev>; Thu, 27 Aug 2026 19:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787858183; cv=none; b=fZQsPvUl7Dc10k660LGxSLeuoTqEcvMOzRVIyBBZHhT1xPfDheHSRO9Mq8v3eUNHlCB3NAUyjJzrZlu/vz3A5TAIKvH2o1Tg8pNZbpigT+bMoOlZghoBKxlFK4cxFCBkK1z54haB34YhE037tB5Aktw5/qjuJOmCM6trTSkjz3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787858183; c=relaxed/simple;
	bh=GjdOIGYWp4HEVuHhPCx+5H5n9C6gsK95CVbktczjjYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mQDKMoBIl1ZNKLxEou0EBsc/8P82IlUqAVpb2D6gHZxS151Chptrke/SJja5HpSCOA139oqiKVQ+mKxo32+AlSEbVawvU9wXDP+wx7ETediVMhbcMVIqrY+tAhPuw3gh/p/bzm3puAUR/69dPljOplgAMbNLkyp5tNGwwbRU8h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dIMM/foW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dIMM/foW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787858178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dDs39916KY8yMr535HS+jAAi0uFdmvYbtN+CYHR40MA=;
	b=dIMM/foWoiFwtJuQCCZLLvymsQ/G/9bVLbTi0lpVF9Tcwc8N5kxUO0bOf7xPy48wOavf3f
	lK1UDrKyW5r5M3Vv9T+Kss3Cyl67elUKf87aXSS/ow+L9qcpT9cgRPSQWDbxtRfEUnb1es
	VLgcHR0R/2SMm4hlCO3faPDLZqqnvYI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-TdHVXDHgPMCgKYeqjbe9SA-1; Thu,
 27 Aug 2026 15:16:15 -0400
X-MC-Unique: TdHVXDHgPMCgKYeqjbe9SA-1
X-Mimecast-MFC-AGG-ID: TdHVXDHgPMCgKYeqjbe9SA_1787858174
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88BB2185BEB8;
	Thu, 27 Aug 2026 19:16:14 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.44.32.182])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D7AB91800640;
	Thu, 27 Aug 2026 19:16:12 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Jiacheng Xu <stitch@zju.edu.cn>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] gfs2: protect sysfs callbacks from superblock teardown
Date: Thu, 27 Aug 2026 21:16:08 +0200
Message-ID: <20260827191611.687345-1-agruenba@redhat.com>
In-Reply-To: <6a91508.162bd.1a0228251e8.Coremail.stitch@zju.edu.cn>
References: <6a91508.162bd.1a0228251e8.Coremail.stitch@zju.edu.cn> <dae9f1e.152f1.1a018d2dd73.Coremail.stitch@zju.edu.cn>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: fBVj-2TyZ2xx6pXBJEw6I2fsMO_-zoXwKzgmql1NW4I_1787858174
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

On Fri, Aug 21, 2026 at 6:09 AM Jiacheng Xu <stitch@zju.edu.cn> wrote:
> The GFS2 sysfs files become visible before fill_super() completes and
> remain present until after filesystem resources have been released.
> Consequently, callbacks that access quota, statfs, glock or journal
> state can race with mount failure rollback or unmount teardown.
>
> The quota refresh fix was originally sent as a standalone [PATCH]. This
> version folds it into a complete series and adds the corresponding
> lifetime protection for the other affected sysfs callbacks.
>
> All callbacks use down_read_trylock() on s_umount and verify SB_ACTIVE.
> Returning -EAGAIN avoids deadlock when mount failure or unmount holds
> the write side of s_umount while removing the sysfs files.

thanks for these patches, they look useful.  I would like to suggest
some changes; please see the below patch.  Could you please apply those
to the individual patches and repost?

> Changes in v2:
> - Folded the original quota refresh fix into a five-patch series.
> - Added statfs_sync, quota_sync, demote_rq and status fixes.
>
> Jiacheng Xu (5):
>   gfs2: protect quota refresh from superblock teardown
>   gfs2: protect statfs sync sysfs callback
>   gfs2: protect quota sync sysfs callback
>   gfs2: protect demote requests during superblock teardown
>   gfs2: protect status sysfs reads during teardown

With the patch I've just posted to the gfs2 mailing list [*], dumping
the status file shouldn't require any additional locking, so the last
patch in qour queue can be dropped.

[*] https://lore.kernel.org/gfs2/20260827190632.686583-1-agruenba@redhat.com/T/#u

Thanks,
Andreas

--

 fs/gfs2/quota.c | 19 +-------------
 fs/gfs2/sys.c   | 70 ++++++++++++++++++++++++++-----------------------
 2 files changed, 38 insertions(+), 51 deletions(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index b1fb60b4cd10..dbfc21693dd5 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -1387,36 +1387,19 @@ int gfs2_quota_sync(struct super_block *sb, int type)
 
 int gfs2_quota_refresh(struct gfs2_sbd *sdp, struct kqid qid)
 {
-	struct super_block *sb = sdp->sd_vfs;
 	struct gfs2_quota_data *qd;
 	struct gfs2_holder q_gh;
 	int error;
 
-	/*
-	 * The sysfs files are created before fill_super completes. Avoid
-	 * blocking on s_umount because the mount failure path removes the
-	 * sysfs files while holding it for writing.
-	 */
-	if (!down_read_trylock(&sb->s_umount))
-		return -EAGAIN;
-
-	if (!(sb->s_flags & SB_ACTIVE)) {
-		error = -EAGAIN;
-		goto out_unlock;
-	}
-
 	error = qd_get(sdp, qid, &qd);
 	if (error)
-		goto out_unlock;
+		return error;
 
 	error = do_glock(qd, FORCE, &q_gh);
 	if (!error)
 		gfs2_glock_dq_uninit(&q_gh);
 
 	qd_put(qd);
-
-out_unlock:
-	up_read(&sb->s_umount);
 	return error;
 }
 
diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index 345d0527675f..ff90ec2eb798 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -63,20 +63,30 @@ static ssize_t id_show(struct gfs2_sbd *sdp, char *buf)
 			MAJOR(sdp->sd_vfs->s_dev), MINOR(sdp->sd_vfs->s_dev));
 }
 
+static bool super_trylock_shared_active(struct super_block *sb)
+{
+	if (!down_read_trylock(&sb->s_umount))
+		return false;
+	if (sb->s_flags & SB_ACTIVE)
+		return true;
+	up_read(&sb->s_umount);
+	return false;
+}
+
+static void super_unlock_active(struct super_block *sb)
+{
+	up_read(&sb->s_umount);
+}
+
 static ssize_t status_show(struct gfs2_sbd *sdp, char *buf)
 {
 	struct super_block *sb = sdp->sd_vfs;
 	unsigned long f;
 	ssize_t s;
 
-	if (!down_read_trylock(&sb->s_umount))
+	if (!super_trylock_shared_active(sb))
 		return -EAGAIN;
 
-	if (!(sb->s_flags & SB_ACTIVE)) {
-		s = -EAGAIN;
-		goto out_unlock;
-	}
-
 	f = sdp->sd_flags;
 	s = sysfs_emit(buf,
 		     "Journal Checked:          %d\n"
@@ -136,8 +146,7 @@ static ssize_t status_show(struct gfs2_sbd *sdp, char *buf)
 		     atomic_read(&sdp->sd_log_thresh1),
 		     atomic_read(&sdp->sd_log_thresh2));
 
-out_unlock:
-	up_read(&sb->s_umount);
+	super_unlock_active(sb);
 	return s;
 }
 
@@ -236,19 +245,13 @@ static ssize_t statfs_sync_store(struct gfs2_sbd *sdp, const char *buf,
 	if (val != 1)
 		return -EINVAL;
 
-	if (!down_read_trylock(&sb->s_umount))
+	if (!super_trylock_shared_active(sb))
 		return -EAGAIN;
 
-	if (!(sb->s_flags & SB_ACTIVE)) {
-		error = -EAGAIN;
-		goto out_unlock;
-	}
-
 	gfs2_statfs_sync(sb, 0);
 
-out_unlock:
-	up_read(&sb->s_umount);
-	return error ? error : len;
+	super_unlock_active(sb);
+	return len;
 }
 
 static ssize_t quota_sync_store(struct gfs2_sbd *sdp, const char *buf,
@@ -267,24 +270,19 @@ static ssize_t quota_sync_store(struct gfs2_sbd *sdp, const char *buf,
 	if (val != 1)
 		return -EINVAL;
 
-	if (!down_read_trylock(&sb->s_umount))
+	if (!super_trylock_shared_active(sb))
 		return -EAGAIN;
 
-	if (!(sb->s_flags & SB_ACTIVE)) {
-		error = -EAGAIN;
-		goto out_unlock;
-	}
-
 	gfs2_quota_sync(sb, 0);
 
-out_unlock:
-	up_read(&sb->s_umount);
-	return error ? error : len;
+	super_unlock_active(sb);
+	return len;
 }
 
 static ssize_t quota_refresh_user_store(struct gfs2_sbd *sdp, const char *buf,
 					size_t len)
 {
+	struct super_block *sb = sdp->sd_vfs;
 	struct kqid qid;
 	int error;
 	u32 id;
@@ -300,13 +298,19 @@ static ssize_t quota_refresh_user_store(struct gfs2_sbd *sdp, const char *buf,
 	if (!qid_valid(qid))
 		return -EINVAL;
 
+	if (!super_trylock_shared_active(sb))
+		return -EAGAIN;
+
 	error = gfs2_quota_refresh(sdp, qid);
+
+	super_unlock_active(sb);
 	return error ? error : len;
 }
 
 static ssize_t quota_refresh_group_store(struct gfs2_sbd *sdp, const char *buf,
 					 size_t len)
 {
+	struct super_block *sb = sdp->sd_vfs;
 	struct kqid qid;
 	int error;
 	u32 id;
@@ -322,7 +326,12 @@ static ssize_t quota_refresh_group_store(struct gfs2_sbd *sdp, const char *buf,
 	if (!qid_valid(qid))
 		return -EINVAL;
 
+	if (!super_trylock_shared_active(sb))
+		return -EAGAIN;
+
 	error = gfs2_quota_refresh(sdp, qid);
+
+	super_unlock_active(sb);
 	return error ? error : len;
 }
 
@@ -363,14 +372,9 @@ static ssize_t demote_rq_store(struct gfs2_sbd *sdp, const char *buf, size_t len
 	if (glops == NULL)
 		return -EINVAL;
 
-	if (!down_read_trylock(&sb->s_umount))
+	if (!super_trylock_shared_active(sb))
 		return -EAGAIN;
 
-	if (!(sb->s_flags & SB_ACTIVE)) {
-		rv = -EAGAIN;
-		goto out_unlock;
-	}
-
 	if (!test_and_set_bit(SDF_DEMOTE, &sdp->sd_flags))
 		fs_info(sdp, "demote interface used\n");
 	rv = gfs2_glock_get(sdp, glnum, glops, NO_CREATE, &gl);
@@ -381,7 +385,7 @@ static ssize_t demote_rq_store(struct gfs2_sbd *sdp, const char *buf, size_t len
 	rv = 0;
 
 out_unlock:
-	up_read(&sb->s_umount);
+	super_unlock_active(sb);
 	return rv ? rv : len;
 }
 
-- 
2.55.0


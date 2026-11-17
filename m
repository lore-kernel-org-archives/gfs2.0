Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794882843;
	b=p9YPr/7HKQUnQsVLQ5IPY3OkXo0UupZFCk5M9il6kEPZ1sfA4NQ8Hjh3Otzt9WT+a1OC
	 aUb6ffJsxnDG/Q5WP5kOn9YHesjSYnw1wOUsUYVCao6gNSoCbYHFVz23J5BFhzFNzotYw
	 iGSqH/kZFD1hh4PfxNV2inUC0cjV9dHFb57UuWQ4U8CrO8T3+IUtKYMwu2XVlt2BjW+n7
	 3U/rcv8NaX/WitJ9SzVHhcLEp/7nXiBEQCFy6a5KthS9hKrKmyMqfGpxXXFxtwtkBFW4w
	 gLUtVgi29xgwZe+Dv8onhlerOoo0RMms+LR2YIeIpwrna1xG9+qJ3hdMdL31VY0TxXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794882843;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=mZrLc6LX2nCuJ/EXtdkUHzIdiN2mi9ORIPdBoX0fHCk=;
	b=lb/CBS1oiXNj6e59XpTgLwzSnLKDo+SOL08M1cfWvJC2fBM5wWTSBHVV+ze+GqOvgp6n
	 IZguFW3T1equazvD1SHivx6najZBUl/CLSOVqXGfQaXvswcK8bgb3KjbPFzUumA4cbQVy
	 BY9F08khPI7MLyoxE3LdWfe2MhqT/aMi1WLV0zagE7MXMs0rrS0QNleExV5rAe1+oLzes
	 +pepURS854VFlyemfo42BjQZqf3SxDKaLVtoWWKpD2eYkAkRSuM5tORMK14udd61yvvG4
	 fQzvvjkktfwT2qocKYHX3rPXoZNEQuDYRxIGLHpk8uPnZ/LW6VDPAcyzqqgLZjz4aTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dBawnTpL;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C797B606A880
	for <gfs2@lists.linux.dev>; Tue, 17 Nov 2026 02:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C797B606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dBawnTpL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794882840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZrLc6LX2nCuJ/EXtdkUHzIdiN2mi9ORIPdBoX0fHCk=;
	b=dBawnTpLApxdA1T5X1TDkT4WvIqlOg4SRjJ9ckDsmmXqVF2QR4lH96LdMRXmdM019H11iT
	pjFHU3T5i1fBFpo1qyw0hFXl3LV0f51h9EeskmYdGwzShOaK48WWB6ChQfe63mV+JwDOuf
	sokLk6XEBPw7XmZcsYYCRSylkPTzLb4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-k4B62iWvPsSuRbXcq0JVCA-1; Mon,
 16 Nov 2026 21:33:59 -0500
X-MC-Unique: k4B62iWvPsSuRbXcq0JVCA-1
X-Mimecast-MFC-AGG-ID: k4B62iWvPsSuRbXcq0JVCA_1794882838
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AFAE5195D035
	for <gfs2@lists.linux.dev>; Tue, 17 Nov 2026 02:33:58 +0000 (UTC)
Received: from agruenba-thinkpadx1carbongen9.rmtat.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C030644D;
	Tue, 17 Nov 2026 02:33:57 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 4/4] gfs2: gfs2_glock_remove_revoke cleanup
Date: Tue, 17 Nov 2026 03:33:49 +0100
Message-ID: <20261117023350.10180-5-agruenba@redhat.com>
In-Reply-To: <20261117023350.10180-1-agruenba@redhat.com>
References: <20261117023350.10180-1-agruenba@redhat.com>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: R3uozgymJBodLWfQNLizLgICHBGspHIMukUhZvvaONo_1794882838
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Pass a bufdata pointer to gfs2_glock_remove_revoke() instead of a glock.
Unlink and free the bufdata object inside of gfs2_glock_remove_revoke().

In gfs2_trans_remove_revoke(), bd->bd_gl is guaranteed to be properly
initialized and there is no need for double checking.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/log.c   | 6 +++++-
 fs/gfs2/log.h   | 2 +-
 fs/gfs2/lops.c  | 9 ++-------
 fs/gfs2/trans.c | 5 +----
 4 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 3161c728b60b..a89346c93f16 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -775,12 +775,16 @@ void gfs2_add_revoke(struct gfs2_sbd *sdp, struct gfs2_bufdata *bd)
 	list_add(&bd->bd_list, &sdp->sd_log_revokes);
 }
 
-void gfs2_glock_remove_revoke(struct gfs2_glock *gl)
+void gfs2_glock_remove_revoke(struct gfs2_bufdata *bd)
 {
+	struct gfs2_glock *gl = bd->bd_gl;
+
+	list_del_init(&bd->bd_list);
 	if (atomic_dec_and_test(&gl->gl_revokes)) {
 		clear_bit(GLF_LFLUSH, &gl->gl_flags);
 		gfs2_glock_put_async(gl);
 	}
+	kmem_cache_free(gfs2_bufdata_cachep, bd);
 }
 
 /**
diff --git a/fs/gfs2/log.h b/fs/gfs2/log.h
index 10beda62427c..b4eeb04d2f2a 100644
--- a/fs/gfs2/log.h
+++ b/fs/gfs2/log.h
@@ -56,7 +56,7 @@ void log_flush_wait(struct gfs2_sbd *sdp);
 
 int gfs2_logd(void *data);
 void gfs2_add_revoke(struct gfs2_sbd *sdp, struct gfs2_bufdata *bd);
-void gfs2_glock_remove_revoke(struct gfs2_glock *gl);
+void gfs2_glock_remove_revoke(struct gfs2_bufdata *bd);
 void gfs2_flush_revokes(struct gfs2_sbd *sdp);
 void gfs2_ail_drain(struct gfs2_sbd *sdp);
 
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 849cdcc1baa6..204b2fb76575 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -886,14 +886,9 @@ static void revoke_lo_before_commit(struct gfs2_sbd *sdp, struct gfs2_trans *tr)
 void gfs2_drain_revokes(struct gfs2_sbd *sdp)
 {
 	struct gfs2_bufdata *bd, *tmp;
-	struct gfs2_glock *gl;
 
-	list_for_each_entry_safe(bd, tmp, &sdp->sd_log_revokes, bd_list) {
-		list_del_init(&bd->bd_list);
-		gl = bd->bd_gl;
-		gfs2_glock_remove_revoke(gl);
-		kmem_cache_free(gfs2_bufdata_cachep, bd);
-	}
+	list_for_each_entry_safe(bd, tmp, &sdp->sd_log_revokes, bd_list)
+		gfs2_glock_remove_revoke(bd);
 }
 
 static void revoke_lo_after_commit(struct gfs2_sbd *sdp, struct gfs2_trans *tr)
diff --git a/fs/gfs2/trans.c b/fs/gfs2/trans.c
index a6e6dca8d431..9cb167ac6ef8 100644
--- a/fs/gfs2/trans.c
+++ b/fs/gfs2/trans.c
@@ -335,10 +335,7 @@ void gfs2_trans_remove_revoke(struct gfs2_sbd *sdp, u64 blkno, unsigned int len)
 	spin_lock(&sdp->sd_log_lock);
 	list_for_each_entry_safe(bd, tmp, &sdp->sd_log_revokes, bd_list) {
 		if ((bd->bd_blkno >= blkno) && (bd->bd_blkno < (blkno + len))) {
-			list_del_init(&bd->bd_list);
-			if (bd->bd_gl)
-				gfs2_glock_remove_revoke(bd->bd_gl);
-			kmem_cache_free(gfs2_bufdata_cachep, bd);
+			gfs2_glock_remove_revoke(bd);
 			revokes++;
 			if (revokes == len)
 				break;
-- 
2.56.1


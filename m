Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4267141987
	for <gfs2@lists.linux.dev>; Wed, 25 Sep 2024 22:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727301820; cv=none; b=nJbE5vSmtkVWmgytq5nq/1xvu1KZA+4oZyeH55Dpa5yM4fkw7OEnpKYk/xrp4PEwbqYYcHZzkT2p7s4gyILpj7mPyotVse+KRuIHaOZlOHg6X9QX4OHCK/B6D2NWi1hAFLSqATm0HZHvSkUtELl8NAO52zHOFu5S7jHo+f+7IF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727301820; c=relaxed/simple;
	bh=ekBVOLXaYvtnVZnNjGTiv/1nXTBNi8zwk9GABqPHXNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=egPuEO0FkWo9CRncXHXBj6vzaJJQRxQPjZwkP4ElXelEgagOKMSuRmnsbylV8BgTvpVRdcLtLX0FrBXj01J0/sNcDQdUnHyXL4bf2Osic1lmArFtpL1gJHqgBdebauBp2rCrLvUBQ4PAng18Ssvta5SoVw24x8zRlhYZMZCteC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ew3K6sdj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ew3K6sdj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727301817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gZr3t1ygxnBejNyB0TmenthqADrbJgSu/i9ynJAGOj4=;
	b=ew3K6sdj5Y42qWnTEn3Iy+w+TMCz3vAmRsAdh45/jg/W1quLZghCR1lkWdFPgIAthAeqeV
	feKV4YpUcX7C3FA6k1dozwrUfczIf7aVXq51o5mSppPQ8dchKK9OJIIdhu2x/or7eT3S6D
	0h72hCENl7CDgBW6mwdDkhfiutqp9G4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-vbp_2kECOeW1VQCP1B8ZDg-1; Wed,
 25 Sep 2024 18:03:36 -0400
X-MC-Unique: vbp_2kECOeW1VQCP1B8ZDg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8E9F18E68F7
	for <gfs2@lists.linux.dev>; Wed, 25 Sep 2024 22:03:35 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.77])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AA69A19560AA;
	Wed, 25 Sep 2024 22:03:34 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 01/16] gfs2: Rename GLF_VERIFY_EVICT to GLF_VERIFY_DELETE
Date: Thu, 26 Sep 2024 00:03:11 +0200
Message-ID: <20240925220331.417856-2-agruenba@redhat.com>
In-Reply-To: <20240925220331.417856-1-agruenba@redhat.com>
References: <20240925220331.417856-1-agruenba@redhat.com>
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

Rename the GLF_VERIFY_EVICT flag to GLF_VERIFY_DELETE: that flag
indicates that we want to delete an inode / verify that it has been
deleted.

To match, rename gfs2_queue_verify_evict() to
gfs2_queue_verify_delete().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c  | 14 +++++++-------
 fs/gfs2/incore.h |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 269c3bc7fced..5addf4ebf33b 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1013,11 +1013,11 @@ bool gfs2_queue_try_to_evict(struct gfs2_glock *gl)
 				  &gl->gl_delete, 0);
 }
 
-static bool gfs2_queue_verify_evict(struct gfs2_glock *gl)
+static bool gfs2_queue_verify_delete(struct gfs2_glock *gl)
 {
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
 
-	if (test_and_set_bit(GLF_VERIFY_EVICT, &gl->gl_flags))
+	if (test_and_set_bit(GLF_VERIFY_DELETE, &gl->gl_flags))
 		return false;
 	return queue_delayed_work(sdp->sd_delete_wq,
 				  &gl->gl_delete, 5 * HZ);
@@ -1052,19 +1052,19 @@ static void delete_work_func(struct work_struct *work)
 		if (gfs2_try_evict(gl)) {
 			if (test_bit(SDF_KILL, &sdp->sd_flags))
 				goto out;
-			if (gfs2_queue_verify_evict(gl))
+			if (gfs2_queue_verify_delete(gl))
 				return;
 		}
 		goto out;
 	}
 
-	if (test_and_clear_bit(GLF_VERIFY_EVICT, &gl->gl_flags)) {
+	if (test_and_clear_bit(GLF_VERIFY_DELETE, &gl->gl_flags)) {
 		inode = gfs2_lookup_by_inum(sdp, no_addr, gl->gl_no_formal_ino,
 					    GFS2_BLKST_UNLINKED);
 		if (IS_ERR(inode)) {
 			if (PTR_ERR(inode) == -EAGAIN &&
 			    !test_bit(SDF_KILL, &sdp->sd_flags) &&
-			    gfs2_queue_verify_evict(gl))
+			    gfs2_queue_verify_delete(gl))
 				return;
 		} else {
 			d_prune_aliases(inode);
@@ -2118,7 +2118,7 @@ static void glock_hash_walk(glock_examiner examiner, const struct gfs2_sbd *sdp)
 void gfs2_cancel_delete_work(struct gfs2_glock *gl)
 {
 	clear_bit(GLF_TRY_TO_EVICT, &gl->gl_flags);
-	clear_bit(GLF_VERIFY_EVICT, &gl->gl_flags);
+	clear_bit(GLF_VERIFY_DELETE, &gl->gl_flags);
 	if (cancel_delayed_work(&gl->gl_delete))
 		gfs2_glock_put(gl);
 }
@@ -2371,7 +2371,7 @@ static const char *gflags2str(char *buf, const struct gfs2_glock *gl)
 		*p++ = 'N';
 	if (test_bit(GLF_TRY_TO_EVICT, gflags))
 		*p++ = 'e';
-	if (test_bit(GLF_VERIFY_EVICT, gflags))
+	if (test_bit(GLF_VERIFY_DELETE, gflags))
 		*p++ = 'E';
 	*p = 0;
 	return buf;
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index aa4ef67a34e0..bd1348bff90e 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -329,7 +329,7 @@ enum {
 	GLF_BLOCKING			= 15,
 	GLF_UNLOCKED			= 16, /* Wait for glock to be unlocked */
 	GLF_TRY_TO_EVICT		= 17, /* iopen glocks only */
-	GLF_VERIFY_EVICT		= 18, /* iopen glocks only */
+	GLF_VERIFY_DELETE		= 18, /* iopen glocks only */
 };
 
 struct gfs2_glock {
-- 
2.46.0


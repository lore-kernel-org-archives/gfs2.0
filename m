Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793282462;
	b=4/BIUo2tg5NNsMxaSJO2B4r5IQKVr/KbbyHR5PKsC2aHCwVjl8/HdG+xTNN7RHyc0lH4
	 5WCg1ZU4ht5aIE6Z661Z1/ByOr/SyeKIddfV8dfAD2iBN7G8W6GFvRJqaC8sN6mgZ6VsJ
	 OpKj7T3T9s2YWwr0UA/S7fDQ6DWucOdDc+FMY0YwXeLZLeexoorhvx21+2OXIpW1Nby7k
	 0Y8II/Zzl8hdT8rJzpzMMpTXdwLIehw8WxS4TISCaXIe+eETgOFFFGROqVZoWcZefh0Yz
	 SBCqDVIfW8LnpdMgbNBwoS6dMN1Mhz37aypT98Ius9cK5Jxa9zgfthA6i4nqlRqAuDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793282462;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:X-Scanned-By:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=DObbbGL6x4KtiTSNC2FTX2q/4no4dx+wX0IlLG1jz6o=;
	b=Ze/FC/0r9oF+buuocLd9vTvBxu4sXblmQHyYm0qWbCGBiRDtPRdDCT0J+aKwRivtENhk
	 xC4DXg6NnJ4ikGJWTGZNMM6pboMKn5DTf7Ld8W+4pSdMx1iyu3zqFEG1dYRscfT/IEXEJ
	 w+TgzdsomqO7yl6iCJp5sbspFuAd1VVe4m8kBGNYojJfCmoSzegO3JPz+4LpXVQX+8PzK
	 sWnbLNHISpFi3g5iCT6SL29+SEqnK9d7HUGhf+s3UZBj1vbqKcf3eBZB5iVhbqnqo+x+8
	 fG3VTjgop0KqsnVcYhbmZoOJZeqNZY/uL9hUjNCrsp9fOmDV0Gx7Oh1T9FcifiNSPBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dj5SEbRG;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE560606A326
	for <gfs2@lists.linux.dev>; Thu, 29 Oct 2026 14:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE560606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dj5SEbRG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793282461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DObbbGL6x4KtiTSNC2FTX2q/4no4dx+wX0IlLG1jz6o=;
	b=dj5SEbRGjSQE/YgMKJQoF/nITz2Kq9wVPflOeQZfU4BlQohq7Q6gwTsiTqqOuSDD5I8s8H
	r8q6GO3hqM+/nP66+kde2w2iZOpOJazugv+Bb0QRKA3ilAjBIQ7l791gG53asY/HyCxkBu
	5wUjb8HlwntN/np3oNprdnkAYlsQyEs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-7O-zk0yfMqePgM-Q4XwuPA-1; Thu,
 29 Oct 2026 10:00:51 -0400
X-MC-Unique: 7O-zk0yfMqePgM-Q4XwuPA-1
X-Mimecast-MFC-AGG-ID: 7O-zk0yfMqePgM-Q4XwuPA_1793282450
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E0791955F6D;
	Thu, 29 Oct 2026 14:00:50 +0000 (UTC)
Received: from agruenba-thinkpadx1carbongen9.rmtat.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1A6F8433;
	Thu, 29 Oct 2026 14:00:48 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Eduard Zateev <hackerowskiy@gmail.com>,
	syzbot+ab91b239b20ae188b9cb@syzkaller.appspotmail.com
Subject: [PATCH] gfs2: keep glocks alive while AIL entries exist
Date: Thu, 29 Oct 2026 15:00:47 +0100
Message-ID: <20261029140047.352689-1-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 3OXpt8JvKNDUH_qgWkBb626TTxgvXkjr4BArNbhyaCQ_1793282450
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Before this patch, gfs2_add_revoke() took an extra glock reference for
the first revoke of a glock, and gfs2_glock_remove_revoke() released
that reference when the last revoke of a glock was removed.  This
ensures that the glock stays alive while the sd_log_revokes list
contains revokes for this glock, but it only helps if the glock is still
alive when gfs2_add_revoke() is called.

Commit 657e5af4fe0b ("gfs2: harden gfs2_glock_hold") has revealed that
there are cases in which this is not the case.  In addition, commit
864174f97647 ("gfs2: Don't cache unreferenced glocks") started freeing
glocks more aggressively, so an actual use-after-free is now a lot more
likely.

To fix that, take an additional glock reference when the first bufdata
object for a glock is moved onto the AIL, and drop that reference when
the last bufdata object of a glock is removed from the AIL.

In gfs2_add_revoke(), gl_revokes is incremented before gl_ail_count is
decremented, which this guarantees that the glock will stay referenced
when a bufdata object is moved from the AIL onto the revokes list.

In gfs2_glock_remove_revoke(), switch from 'atomic_dec_return() == 0' to
the equivalent atomic_dec_and_test() to use the same code as in
gfs2_remove_from_ail().

Except for the patch decription, this patch is basically identical to
the one proposed by Eduard Zateev.

Suggested-by: Eduard Zateev <hackerowskiy@gmail.com>
Fixes: 864174f97647 ("gfs2: Don't cache unreferenced glocks")
Reported-by: syzbot+ab91b239b20ae188b9cb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ab91b239b20ae188b9cb
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index b55daf1e6381..7a391b50d13b 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -74,10 +74,13 @@ unsigned int gfs2_struct2blk(struct gfs2_sbd *sdp, unsigned int nstruct)
 
 static void gfs2_remove_from_ail(struct gfs2_bufdata *bd)
 {
+	struct gfs2_glock *gl = bd->bd_gl;
+
 	bd->bd_tr = NULL;
 	list_del_init(&bd->bd_ail_st_list);
 	list_del_init(&bd->bd_ail_gl_list);
-	atomic_dec(&bd->bd_gl->gl_ail_count);
+	if (atomic_dec_and_test(&gl->gl_ail_count))
+		gfs2_glock_put_async(gl);
 	brelse(bd->bd_bh);
 }
 
@@ -778,7 +781,7 @@ void gfs2_add_revoke(struct gfs2_sbd *sdp, struct gfs2_bufdata *bd)
 
 void gfs2_glock_remove_revoke(struct gfs2_glock *gl)
 {
-	if (atomic_dec_return(&gl->gl_revokes) == 0) {
+	if (atomic_dec_and_test(&gl->gl_revokes)) {
 		clear_bit(GLF_LFLUSH, &gl->gl_flags);
 		gfs2_glock_put_async(gl);
 	}
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 341f5bb844bb..13d8aa1dfea1 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -121,7 +121,8 @@ static void gfs2_unpin(struct gfs2_sbd *sdp, struct buffer_head *bh,
 	} else {
 		struct gfs2_glock *gl = bd->bd_gl;
 		list_add(&bd->bd_ail_gl_list, &gl->gl_ail_list);
-		atomic_inc(&gl->gl_ail_count);
+		if (atomic_inc_return(&gl->gl_ail_count) == 1)
+			gfs2_glock_hold(gl);
 	}
 	bd->bd_tr = tr;
 	list_add(&bd->bd_ail_st_list, &tr->tr_ail1_list);


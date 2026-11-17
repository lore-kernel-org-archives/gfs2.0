Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794882844;
	b=qbzJ/zZzWm/c03BYu8kOgo1iJMx+Z84PZVNL276yhG2pUqnavrPz3WyCJ9YaAfJAgrX+
	 PTa46g7n1CmBY9qBapJ6WfMQ3PP+o1q51+fO2XMO3Oe7CA3gDXWqSHG9X41XE37aSG63D
	 1zLFA+4bOyhsv7unkY4ZkEnXKS0GpthlbzH8JioXIOVkoN2tIlGMC7ZFJtnsvMl/idUq1
	 0m9/v0mKHBlvpxrB8IhQWHX91dCuRNFphf8uG2MpAmPMxj2VxUp0iUOJ93ywuUT3EDAPj
	 fnEQD4CT9Vwrm+noq6WV3foGYPw0tridWni9u7i9n9EhxwrkXtNiVzUoBTmCoTUft1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794882844;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=GimuZB6ETQMf5EQJrIsaJf/tKBSZkz919+6ehd3RECg=;
	b=N0pXMiakgdqeTZaDania/NT7UJoI9Vt28zyKbqSeb4d/TpY8wnbcKPxV+tP3/1Srz1+S
	 ta3OapTTJG5IWub405eN2Dj28SLBfUGdj4uebvZURxlvUfse1RfducF8uUDaL+A4EdEF/
	 XiUZ9oLE1aHE0ehkZClxLYdnFW7DZhCTymcMwi9yLh0r/NaE60MYFcLaZNqRq4HYSdtH1
	 2hTTxstjR9Sb2ak1dIGd8KHR5ioWVgcCJlq86aAwahRDznMeroJkyhELERWu9ZVlzVfSC
	 G1ClP5hPnksSb3TMQQL9dGdj54VMWY61S58r1cNswJC+K+uGWNxzNrVLhJQDOlPM4gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L5XxPWGB;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C09606A32A
	for <gfs2@lists.linux.dev>; Tue, 17 Nov 2026 02:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94C09606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L5XxPWGB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794882839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GimuZB6ETQMf5EQJrIsaJf/tKBSZkz919+6ehd3RECg=;
	b=L5XxPWGBVOMfRDyjDQcPhnJWDxR1j4mNrY2c59/pzWAZgB/SXHl7Api0k5QjHBC9ZCuzEk
	mpxR9ZKta+wEr7MbVqDz40oxdQ5a1ZNKrI4V3+OF/8ZfryMGQbOb5Y2buu8dKabdhlzkgo
	7zoRdv2OMLXCMzW3Z69tseGfLvbG7sc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-mgktJscKNq-0kVfqYnzTTA-1; Mon,
 16 Nov 2026 21:33:58 -0500
X-MC-Unique: mgktJscKNq-0kVfqYnzTTA-1
X-Mimecast-MFC-AGG-ID: mgktJscKNq-0kVfqYnzTTA_1794882837
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E5FA195D023
	for <gfs2@lists.linux.dev>; Tue, 17 Nov 2026 02:33:57 +0000 (UTC)
Received: from agruenba-thinkpadx1carbongen9.rmtat.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6C34844D;
	Tue, 17 Nov 2026 02:33:56 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 3/4] gfs2: gfs2_trans_remove_revoke cleanup
Date: Tue, 17 Nov 2026 03:33:48 +0100
Message-ID: <20261117023350.10180-4-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: lZuyYrXxloD8VLUlgZgvMWZ-UF_t3riF5busB68K7b8_1794882837
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Count the number of revokes removed and update the counters outside of
the revokes loop.

Use the revokes count to eliminate 'n'.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/trans.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/gfs2/trans.c b/fs/gfs2/trans.c
index 65cbe06e301a..a6e6dca8d431 100644
--- a/fs/gfs2/trans.c
+++ b/fs/gfs2/trans.c
@@ -330,22 +330,23 @@ void gfs2_trans_add_revoke(struct gfs2_sbd *sdp, struct gfs2_bufdata *bd)
 void gfs2_trans_remove_revoke(struct gfs2_sbd *sdp, u64 blkno, unsigned int len)
 {
 	struct gfs2_bufdata *bd, *tmp;
-	unsigned int n = len;
+	unsigned int revokes = 0;
 
 	spin_lock(&sdp->sd_log_lock);
 	list_for_each_entry_safe(bd, tmp, &sdp->sd_log_revokes, bd_list) {
 		if ((bd->bd_blkno >= blkno) && (bd->bd_blkno < (blkno + len))) {
 			list_del_init(&bd->bd_list);
-			gfs2_assert_withdraw(sdp, sdp->sd_log_num_revoke);
-			sdp->sd_log_num_revoke--;
 			if (bd->bd_gl)
 				gfs2_glock_remove_revoke(bd->bd_gl);
 			kmem_cache_free(gfs2_bufdata_cachep, bd);
-			gfs2_log_release_revokes(sdp, 1);
-			if (--n == 0)
+			revokes++;
+			if (revokes == len)
 				break;
 		}
 	}
+	gfs2_assert_withdraw(sdp, sdp->sd_log_num_revoke >= revokes);
+	sdp->sd_log_num_revoke -= revokes;
+	gfs2_log_release_revokes(sdp, revokes);
 	spin_unlock(&sdp->sd_log_lock);
 }
 
-- 
2.56.1


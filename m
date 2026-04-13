Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8873C0621
	for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 14:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776091945; cv=none; b=t+IpKGzzbCBlOlnX9gMI8fV+Nhn+b8JtPkSHDYbYkh6fUjecx2gteSuWFNxNOe2X34mzsRJ706ev2H9vzNUgw0KlinbAIedCLCe9qRD2jO9XOjL0toh5fUNfwLQGxB6wCBogBJkK81YG0IkaUT2rzxWwG9eVUYSpHxNatmtYx5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776091945; c=relaxed/simple;
	bh=kkS+CqcPMD3flMq5Q47Pw1zqmpZ0aLzmcmbNZsjrqB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=H2MCHEMZ7WhgrM/Js42aBQLdwYJPdxRsOBiy9/W9JytoW2ksZQwyzRxP1wehvDnirobHytXwv8ooXy+Sf5xxp8vFTvSZx+DQ0BwUUubahyCoFpA3ImtxdESgXuqu2jk+20N60hxdodtibhdIIFPe3oKD9dnSEHYrFdSzsV7SEOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dxvV236/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dxvV236/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776091943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KKMqMsxKa4iPdfVt0UlIG3If3tXgbjYxDYOekS56mjQ=;
	b=dxvV236/GjllGe5vUTfPt9UbF9aqLHVXoXiHE/RPkZ15fN/1ZLwwQYOompDGwoUM7QF7TV
	flkwyvvv5ue6uwbcbUbsHukdbR8F15hAigAIgcYyDTjb62pJFft2+VHw6/51f2zPbvMi1a
	0FSIKd6L18AzVkfHed1ynt2cjtH0K7M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-tFb6FblyNOS-Xi8wg2Icxg-1; Mon,
 13 Apr 2026 10:52:19 -0400
X-MC-Unique: tFb6FblyNOS-Xi8wg2Icxg-1
X-Mimecast-MFC-AGG-ID: tFb6FblyNOS-Xi8wg2Icxg_1776091939
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 40BF1180120E
	for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 14:52:19 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.156])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4D6FC19560B1;
	Mon, 13 Apr 2026 14:52:18 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 03/18] gfs2: Avoid unnecessary transactions in evict_linked_inode
Date: Mon, 13 Apr 2026 16:51:56 +0200
Message-ID: <20260413145211.881752-4-agruenba@redhat.com>
In-Reply-To: <20260413145211.881752-1-agruenba@redhat.com>
References: <20260413145211.881752-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IjzMACXpAUTB4TAc_jRkIatiujpOwFgOq69teOHcL0o_1776091939
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

In evict_linked_inode(), the truncate_inode_pages() calls are carried
out inside a transaction.  This code was added to what was then function
gfs2_delete_inode() in commit 16615be18cadf ("[GFS2] Clean up journaled
data writing").

These transactions are only used for creating revokes for the jdata
buffers in the journal, so don't create such transactions when we know
that the address space doesn't contain any jdata buffers for this inode
and truncate the metadata address space outside of the transaction.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/super.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index fd8eb9e15719..9149fa375ef3 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1324,6 +1324,35 @@ static int evict_unlinked_inode(struct inode *inode)
 	return ret;
 }
 
+static int gfs2_truncate_inode_pages(struct inode *inode)
+{
+	struct gfs2_inode *ip = GFS2_I(inode);
+	struct gfs2_sbd *sdp = GFS2_SB(inode);
+	struct address_space *mapping = &inode->i_data;
+	bool need_trans = gfs2_is_jdata(ip) && mapping->nrpages;
+	int ret;
+
+	/*
+	 * Truncating a jdata inode address space may create revokes in
+	 * truncate_inode_pages() -> gfs2_invalidate_folio() -> ... ->
+	 * gfs2_remove_from_journal(), so we need a transaction here.
+	 *
+	 * FIXME: During a withdraw, no new transactions can be created.
+	 * In that case, we skip the truncate, but that doesn't help because
+	 * truncate_inode_pages_final() will then call gfs2_invalidate_folio()
+	 * again, and outside of a transaction.
+	 */
+	if (need_trans) {
+		ret = gfs2_trans_begin(sdp, 0, sdp->sd_jdesc->jd_blocks);
+		if (ret)
+			return ret;
+	}
+	truncate_inode_pages(mapping, 0);
+	if (need_trans)
+		gfs2_trans_end(sdp);
+	return 0;
+}
+
 /*
  * evict_linked_inode - evict an inode whose dinode has not been unlinked
  * @inode: The inode to evict
@@ -1346,14 +1375,10 @@ static int evict_linked_inode(struct inode *inode)
 	write_inode_now(inode, 1);
 	gfs2_ail_flush(ip->i_gl, 0);
 
-	ret = gfs2_trans_begin(sdp, 0, sdp->sd_jdesc->jd_blocks);
+	ret = gfs2_truncate_inode_pages(inode);
 	if (ret)
 		return ret;
-
-	/* Needs to be done before glock release & also in a transaction */
-	truncate_inode_pages(&inode->i_data, 0);
 	truncate_inode_pages(metamapping, 0);
-	gfs2_trans_end(sdp);
 	return 0;
 }
 
-- 
2.53.0


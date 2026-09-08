Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C2544CF52;
	Tue,  8 Sep 2026 21:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788902150; cv=none; b=RCt3A/q3aD27RMbDPP2Wjqwk79Vzgo6hyHu1FyUst3NGVv2z7DXTs7oYeGRS1XyPfm1LHoJHob/R6AVkwUc1mbvf3MGYYyzxGb9JP+hJwnryLA6hLRTvCEHazG2unYBhAlHHOWhpwbU/gak5oA1wY7xLqBuBh0/pa9H9qzNqgvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788902150; c=relaxed/simple;
	bh=5MDXUumeScR8/sobsnhrXNvNHeuF6zeNbOWojP43an0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dc+dGifLZlHJ2UZ1K/XVT7glzxIgqohtEV6xErS/2BKq9KEJVKQV+QXiX8chlw473oAr5cdEW0crP53HW+ZtnywqUhBPYmEF+fFA1EfMNo8hrZXbzbjZG47FzORj6b36Dld7BYmgHTqqjxW+HOrmzVOAhMWdLUHeUlxjlqfVTmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Wiaxj24Y; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Wiaxj24Y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=8aF6d5QbYLGDY2om4GTfaI0qkd0ggpTM0UzyIZrbAms=; b=Wiaxj24YEIRGGfe38XEeFU7Gwl
	BvU3mFRKZXxYcMBJZ7dj/gnvQT2Ctr+atQJWn43PA4o/RS2QJXrjshhXAN97tQxlE0cqMculLW/aa
	V+2IFHaOEHg/nZWFFVRxObeYf8uuTL14ZDT8q9Fvm+vHE1i7slz/lVYofxfEEEmS56J4HjW3YvAq1
	nnELI1kbjtPDv4sF6WKoEI4Hfh5/pSyfKghClR+tBco8uxDzMHmvFeiVrkq12oW1RwC4iuYX4pGpM
	H5UJQjBUWikiESgH3D9uaBDtg9By2oG/ot2FR0ae+qH9EJMjHjYwfcgATjYwKjSHx9tbUeg2GvgJz
	7KAew0Mg==;
Received: from 186-249-150-254.shared.desktop.com.br ([186.249.150.254] helo=[127.0.1.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1x43AP-00GhZP-HE; Tue, 08 Sep 2026 23:15:45 +0200
From: Mauricio Faria de Oliveira <mfo@igalia.com>
Date: Tue, 08 Sep 2026 18:16:16 -0300
Subject: [PATCH 5/5] gfs2: check for errors from filemap_get_folio() in
 gfs2_jhead_process_page()
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-gfs2_getbuf-error-checks-v1-5-7c59698f178f@igalia.com>
References: <20260908-gfs2_getbuf-error-checks-v1-0-7c59698f178f@igalia.com>
In-Reply-To: <20260908-gfs2_getbuf-error-checks-v1-0-7c59698f178f@igalia.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: kernel-dev@igalia.com, gfs2@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Mauricio Faria de Oliveira <mfo@igalia.com>
X-Mailer: b4 0.14.2

Let's check for a not-found folio pointer error, that is, ERR_PTR(-ENOENT),
just in case, even though it is not expected (due to a previously acquired
reference on the folio, per the function comment).

If filemap_get_folio() returns an error, log it and return -EIO. The only
caller is gfs2_chain_bio() (same file), twice, which can currently return
errors, thus propagate the error.

Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>
---
 fs/gfs2/lops.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 192e71e630dce062361cc754f2ba878fa23c0a7f..78cadde990182223978ddbde2be25cfe963beabe 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -459,14 +459,21 @@ static bool gfs2_jhead_folio_search(struct gfs2_jdesc *jd,
  * our references to the folio.
  */
 
-static void gfs2_jhead_process_page(struct gfs2_jdesc *jd, unsigned long index,
-				    struct gfs2_log_header_host *head,
-				    bool *done)
+static int gfs2_jhead_process_page(struct gfs2_jdesc *jd, unsigned long index,
+				   struct gfs2_log_header_host *head,
+				   bool *done)
 {
+	struct gfs2_sbd *sdp = GFS2_SB(jd->jd_inode);
 	struct folio *folio;
 
 	folio = filemap_get_folio(jd->jd_inode->i_mapping, index);
 
+	/* This should not happen (see comment above), but check just in case */
+	if (IS_ERR(folio)) {
+		fs_err(sdp, "Error %ld getting folio.\n", PTR_ERR(folio));
+		return -EIO;
+	}
+
 	folio_wait_locked(folio);
 	if (!folio_test_uptodate(folio))
 		*done = true;
@@ -476,6 +483,7 @@ static void gfs2_jhead_process_page(struct gfs2_jdesc *jd, unsigned long index,
 
 	/* filemap_get_folio() and the earlier filemap_grab_folio() */
 	folio_put_refs(folio, 2);
+	return 0;
 }
 
 static struct bio *gfs2_chain_bio(struct bio *prev, unsigned int nr_iovecs,
@@ -572,7 +580,9 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs2_log_header_host *head)
 				continue;
 			}
 
-			gfs2_jhead_process_page(jd, blocks_read >> shift, head, &done);
+			ret = gfs2_jhead_process_page(jd, blocks_read >> shift, head, &done);
+			if (ret)
+				goto error;
 			blocks_read += PAGE_SIZE >> bsize_shift;
 			if (done)
 				goto out;  /* found */
@@ -583,7 +593,9 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs2_log_header_host *head)
 	if (bio)
 		submit_bio(bio);
 	while (blocks_read < block) {
-		gfs2_jhead_process_page(jd, blocks_read >> shift, head, &done);
+		ret = gfs2_jhead_process_page(jd, blocks_read >> shift, head, &done);
+		if (ret)
+			goto error;
 		blocks_read += PAGE_SIZE >> bsize_shift;
 	}
 
@@ -592,6 +604,7 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs2_log_header_host *head)
 
 	truncate_inode_pages(mapping, 0);
 
+error:
 	return ret;
 }
 

-- 
2.47.3


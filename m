Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAA247F5B
	for <gfs2@lists.linux.dev>; Wed,  6 Dec 2023 19:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fb3X+JvJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=qFHj2SF5KVjAIzNS6NPxpj90netkKzTkNHBhbOoeojk=; b=Fb3X+JvJeymV+rtJ3rW0dMLDAq
	yf12OW6ZV1d+lHxk0c9yQhLMkW/MYk/zvjaOJON4GlytIliQvPXwlroTrX9544hmkpAKNX3gAxlFu
	OYngUV9d8Vk/+iZRIRW2wfPKn0EnDg1SuaqxMMADfL/JfyZoLTcnDWw5qgSsXFCTugwKzHG0zq1Pw
	L/c8VtWKsEwiGhola6XdJ7P1L8yYbqORapohm8FsQ0ptLcknZgQ5jFfaWyoR2JF/DUIpim4ihlDOF
	fYpMP57+pRNoRdI6bA+USd6LYomACvUC7y+yyxHlHlyoCObhP9CjhkLnklE1bWlfPqEL0yVDDlAeH
	Ryp4XtSg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rAy24-003CqM-DQ; Wed, 06 Dec 2023 19:58:08 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] gfs2: Remove use of error flag in journal reads
Date: Wed,  6 Dec 2023 19:58:06 +0000
Message-Id: <20231206195807.764344-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conventionally we use the uptodate bit to signal whether a read
encountered an error or not.  Use folio_end_read() to set the uptodate
bit on success.  Also use filemap_set_wb_err() to communicate the errno
instead of the more heavy-weight mapping_set_error().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/gfs2/lops.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 483f69807062..314ec2a70167 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -391,22 +391,15 @@ static void gfs2_log_write_page(struct gfs2_sbd *sdp, struct page *page)
  * Simply unlock the pages in the bio. The main thread will wait on them and
  * process them in order as necessary.
  */
-
 static void gfs2_end_log_read(struct bio *bio)
 {
-	struct page *page;
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
+	int error = blk_status_to_errno(bio->bi_status);
+	struct folio_iter fi;
 
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		page = bvec->bv_page;
-		if (bio->bi_status) {
-			int err = blk_status_to_errno(bio->bi_status);
-
-			SetPageError(page);
-			mapping_set_error(page->mapping, err);
-		}
-		unlock_page(page);
+	bio_for_each_folio_all(fi, bio) {
+		/* We're abusing wb_err to get the error to gfs2_find_jhead */
+		filemap_set_wb_err(fi.folio->mapping, error);
+		folio_end_read(fi.folio, !error);
 	}
 
 	bio_put(bio);
@@ -475,7 +468,7 @@ static void gfs2_jhead_process_page(struct gfs2_jdesc *jd, unsigned long index,
 	folio = filemap_get_folio(jd->jd_inode->i_mapping, index);
 
 	folio_wait_locked(folio);
-	if (folio_test_error(folio))
+	if (!folio_test_uptodate(folio))
 		*done = true;
 
 	if (!*done)
-- 
2.42.0


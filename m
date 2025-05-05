Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2783383A2
	for <gfs2@lists.linux.dev>; Mon,  5 May 2025 09:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746436714; cv=none; b=lAXu0P5XOTSZBcAlIJs57yFdyWb81AGt3cupWOjXHXtgN2J5uXzO3zJjGyDWhrCh0tMJN558Ixdnkd5j8Ot0g/Qr0eNCDG5wK7p/dYY5blrUGYwAEzx1ucc9fpmk1L9qmKOCsxVlTyirG9h2cYmfFYXVEY/UwJ1eLkmbG4tqVao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746436714; c=relaxed/simple;
	bh=bNZi13Bizl3kyS8UD4yWusSsnthalJSam6MPgwpiq8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jLAFTZGh9CZkbkHrUdCUs2sSVxNnSyqZ1pCvpQlKhpfQbKy8kzgnpmz+VQaQV/X9NzF+DK1tQC8Qd86GznaSfHvl/ioXvex5hjG5ksxEfnMWsaRB1r7EAUa07WESxoHKHP5z+pbkInEhI+De5NTpueIPBHFzjKLQXdmVktIdbL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y++j6JjO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y++j6JjO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=SHaCTJS6UDmpJbA6+CH2M5ELUocSSNxE6CT+e7lENt0=; b=Y++j6JjOf3APQgj2P6PkT9XCHf
	vWPnaRCzFelW88IHIIUm0V9fVgVAtkA76UvJ/hHPnJYNbPY5iq41j/Uf21wAjEVDqya4XquW16eIx
	lzWDXtrl3FcUyxvNfOlqRuymEKP6o/R6YB56kflTvLCoS4J+2Ir9otsvLPBhNFUwnrfKdL8x+hfWC
	fnDw7oEfQsqR8tmM2o+UqPi8Xp/edp7H4oceZvfbYo4JMqCJJG9vSmL/Y2cylVM8X7UsPo1e6oe2d
	Yx06N7BIz+djjo9opxWbXtsB0WmpOdu7wCnj3a4odcLPMQiU3GOObt1shV8/dnmM6cNzYFAuu6ICM
	sX4sljDQ==;
Received: from 2a02-8389-2341-5b80-c9f7-77ec-522e-47ca.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:c9f7:77ec:522e:47ca] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBry3-00000006tcF-3Ivz;
	Mon, 05 May 2025 09:18:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev
Subject: [PATCH] gfs: don't check for AOP_WRITEPAGE_ACTIVATE in gfs2_write_jdata_batch
Date: Mon,  5 May 2025 11:18:28 +0200
Message-ID: <20250505091828.3450317-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

__gfs2_jdata_write_folio can't return AOP_WRITEPAGE_ACTIVATE, so don't
check for it in gfs2_write_jdata_batch.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/gfs2/aops.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 68fc8af14700..5be99d87bcdc 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -228,24 +228,16 @@ static int gfs2_write_jdata_batch(struct address_space *mapping,
 
 		ret = __gfs2_jdata_write_folio(folio, wbc);
 		if (unlikely(ret)) {
-			if (ret == AOP_WRITEPAGE_ACTIVATE) {
-				folio_unlock(folio);
-				ret = 0;
-			} else {
-
-				/*
-				 * done_index is set past this page,
-				 * so media errors will not choke
-				 * background writeout for the entire
-				 * file. This has consequences for
-				 * range_cyclic semantics (ie. it may
-				 * not be suitable for data integrity
-				 * writeout).
-				 */
-				*done_index = folio_next_index(folio);
-				ret = 1;
-				break;
-			}
+			/*
+			 * done_index is set past this page, so media errors
+			 * will not choke background writeout for the entire
+			 * file. This has consequences for range_cyclic
+			 * semantics (ie. it may not be suitable for data
+			 * integrity writeout).
+			 */
+			*done_index = folio_next_index(folio);
+			ret = 1;
+			break;
 		}
 
 		/*
-- 
2.47.2


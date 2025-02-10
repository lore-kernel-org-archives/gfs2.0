Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D01225A25;
	Mon, 10 Feb 2025 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194497; cv=none; b=IkvxVQgBR+lPGV/TYrb5bwOvFLhxhH7lldH69o1SxxZqTrWVmaQDf8lJsbxnjaTv4lZlvVEZgYvbC0hBCnYAu3RsOE0QBexoE+O6YslfF1odMz6QkhvgTZ7xkTQnAE2e7pbMHg6MvQCrPSkBSfTPRxXhUAVCRPfOXzAXLnrt834=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194497; c=relaxed/simple;
	bh=ZPv/E2kQ5rsDl5eC30qVzIl7hp98x7UfyNieyYQNjwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dlGc/qM6adj0x1Q4+y5CC8FDZMwLeO6zvBjF5ndXZfZzlacZeJNoGUHf8zhk33H48zKRMRj2U4DjPD2Oxqi9BMI7NkMIC13uuz0+9lSOxhNjRXPMM5BWoIrM0UpIlpnH+A0R8Esjk/KajuX5nV+SEJg6RVe7Nm+9TEK1aviWRco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mfkG3AFE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mfkG3AFE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=PoNpukNrLHKByBh0E4RE3AdFZaWRSwZfgI3hxGdDr8c=; b=mfkG3AFE7dLUQ8IUbtufhzuDpY
	17tgZFSb3NBFnE2IMsPqEGBelT+oiKxrz3zC+hRG9KGrpwatjeiz9NOJgVkr7BYhQAMvPUGLqhkaF
	SOD5/6Dd/f0U3PbMkQMKqrCnp/n2buCoOeMNfWHd8b4dMHOTWqmsYvdMuOwfnLaNp8hQddggyjH+b
	TPcnjnc7+HsqnT7AVgFV6OO9FKcXjyYrHFBokAFoO+RrvksqRmUmM8TLPGuCAbG8DfKZBRhytAUAh
	KE0Ib4amHJ070fCaOQnSH+lbQcnKflIbQFtiZPKTL+STh0HT3/GxE+2E45xADVBkI+ICPp9zPLIHt
	issW4EEw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1thTw5-0000000FvZm-2jN7;
	Mon, 10 Feb 2025 13:34:53 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/8] More GFS2 folio conversions
Date: Mon, 10 Feb 2025 13:34:38 +0000
Message-ID: <20250210133448.3796209-1-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I think this may be the last batch of patches to gfs2 for folio
conversions.  The only remaining references to struct page that I see are
for filesystem metadata that isn't stored in the page cache, so those are
fine to continue using struct page.  The only mild improvement would be if
we could have different bio completion handlers for gfs2_end_log_write()
when it's using mempool pages vs folio pages, but that may not even be
feasible and I like the current solution well enough.

This all seems fairly straightforward to me, but as usual only
compile-tested.  I don't anticipate the change to buffer_head.h to have
any conflicts; removing the last user of page_buffers() is not on the
cards for the next merge window.

Matthew Wilcox (Oracle) (8):
  gfs2: Use b_folio in gfs2_log_write_bh()
  gfs2: Use b_folio in gfs2_trans_add_meta()
  gfs2: Use b_folio in gfs2_submit_bhs()
  gfs2: Use b_folio in gfs2_check_magic()
  gfs2: Convert gfs2_jhead_pg_srch() to gfs2_jhead_folio_srch()
  gfs2: Convert gfs2_find_jhead() to use a folio
  gfs2: Convert gfs2_end_log_write_bh() to work on a folio
  gfs2: Convert gfs2_meta_read_endio() to use a folio

 fs/gfs2/lops.c              | 69 ++++++++++++++++++-------------------
 fs/gfs2/meta_io.c           | 15 ++++----
 fs/gfs2/trans.c             |  4 +--
 include/linux/buffer_head.h |  1 -
 4 files changed, 43 insertions(+), 46 deletions(-)

-- 
2.47.2


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AC6152DEB
	for <gfs2@lists.linux.dev>; Tue,  9 Apr 2024 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712681119; cv=none; b=cYXCwimm298IWSYHRRmrCt+HFB5JFQIjLKnIxr6Kubd9hVSTY3nDA088X6K+Kj0lWc2L61BiUV0BBx0N9ktIkoVRhQbgxhEAANy369QkjsEmRk64ttg4BBaEwWQJ39mDaxcld5y4dhwbj/wBR6ozOU8spH4AZRmDMAwZwz9nAjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712681119; c=relaxed/simple;
	bh=AG1jJI7qF6A3K5c4JEJOWR7iAWD/NeN00d+61CE2T0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aw5yNsVdtoquHYDrORumIG6Isr+KfZavFvESxxDugTxZrDDNnZiNCRhJSZV/v4DsZ+/UU0idNZMwTPzHO7ctnco3UGOutCUAJX0QIbcWSltvprX0fXFS5sU7hm80ZHNi2QZ3qdamIjFpiRuFVQunAM+jz//omxrdxeD3uL+i5Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LADuOKc5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LADuOKc5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712681116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XkIph3MDt8SkDVJz/8j5R90TsjOx3u314B0hJF1xYBc=;
	b=LADuOKc5W68lq/+G2oCDwVZVhcZuV+stlzEqgFFFeqyN1bjtjtQJK4LEth2Ono8triHZ0X
	gI69qM9Q3h8juHmSGXhsrjGANb85kITcRZ5P69HWP7zQ0RWtVG7+wWPEYdLM/qxQNZpNY/
	MPZ1pW3cIz9NsCAdgQBV1Sw7AushPMo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-sxE4nQCCMByQNUiuNBT9Ww-1; Tue, 09 Apr 2024 12:45:14 -0400
X-MC-Unique: sxE4nQCCMByQNUiuNBT9Ww-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9FEFA1049BC6
	for <gfs2@lists.linux.dev>; Tue,  9 Apr 2024 16:45:14 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.28])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1FEACC27EAA;
	Tue,  9 Apr 2024 16:45:14 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 01/15] gfs2: Get rid of newlines in log messages
Date: Tue,  9 Apr 2024 18:44:51 +0200
Message-ID: <20240409164508.79570-2-agruenba@redhat.com>
In-Reply-To: <20240409164508.79570-1-agruenba@redhat.com>
References: <20240409164508.79570-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Get rid of attempts to create multi-line syslog entries; this only makes
the messages harder to read.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/bmap.c |  2 +-
 fs/gfs2/rgrp.c | 10 +++++-----
 fs/gfs2/util.c | 50 ++++++++++++++++++++++++++------------------------
 3 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 643175498d1c..b8d64f2259d6 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1827,7 +1827,7 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 			gfs2_assert_withdraw(sdp, bh);
 			if (gfs2_assert_withdraw(sdp,
 						 prev_bnr != bh->b_blocknr)) {
-				fs_emerg(sdp, "inode %llu, block:%llu, i_h:%u,"
+				fs_emerg(sdp, "inode %llu, block:%llu, i_h:%u, "
 					 "s_h:%u, mp_h:%u\n",
 				       (unsigned long long)ip->i_no_addr,
 				       prev_bnr, ip->i_height, strip_h, mp_h);
diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index 26d6c1eea559..29c772816765 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -814,11 +814,11 @@ static int compute_bitstructs(struct gfs2_rgrpd *rgd)
 	bi = rgd->rd_bits + (length - 1);
 	if ((bi->bi_start + bi->bi_bytes) * GFS2_NBBY != rgd->rd_data) {
 		gfs2_lm(sdp,
-			"ri_addr = %llu\n"
-			"ri_length = %u\n"
-			"ri_data0 = %llu\n"
-			"ri_data = %u\n"
-			"ri_bitbytes = %u\n"
+			"ri_addr=%llu "
+			"ri_length=%u "
+			"ri_data0=%llu "
+			"ri_data=%u "
+			"ri_bitbytes=%u "
 			"start=%u len=%u offset=%u\n",
 			(unsigned long long)rgd->rd_addr,
 			rgd->rd_length,
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index f52141ce9485..fd65a2e34102 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -376,8 +376,8 @@ void gfs2_assert_withdraw_i(struct gfs2_sbd *sdp, char *assertion,
 		return;
 
 	fs_err(sdp,
-	       "fatal: assertion \"%s\" failed\n"
-	       "   function = %s, file = %s, line = %u\n",
+	       "fatal: assertion \"%s\" failed - "
+	       "function = %s, file = %s, line = %u\n",
 	       assertion, function, file, line);
 
 	/*
@@ -407,7 +407,8 @@ void gfs2_assert_warn_i(struct gfs2_sbd *sdp, char *assertion,
 		return;
 
 	if (sdp->sd_args.ar_errors == GFS2_ERRORS_WITHDRAW)
-		fs_warn(sdp, "warning: assertion \"%s\" failed at function = %s, file = %s, line = %u\n",
+		fs_warn(sdp, "warning: assertion \"%s\" failed - "
+			"function = %s, file = %s, line = %u\n",
 			assertion, function, file, line);
 
 	if (sdp->sd_args.ar_debug)
@@ -416,10 +417,10 @@ void gfs2_assert_warn_i(struct gfs2_sbd *sdp, char *assertion,
 		dump_stack();
 
 	if (sdp->sd_args.ar_errors == GFS2_ERRORS_PANIC)
-		panic("GFS2: fsid=%s: warning: assertion \"%s\" failed\n"
-		      "GFS2: fsid=%s:   function = %s, file = %s, line = %u\n",
+		panic("GFS2: fsid=%s: warning: assertion \"%s\" failed - "
+		      "function = %s, file = %s, line = %u\n",
 		      sdp->sd_fsname, assertion,
-		      sdp->sd_fsname, function, file, line);
+		      function, file, line);
 
 	sdp->sd_last_warning = jiffies;
 }
@@ -432,7 +433,8 @@ void gfs2_consist_i(struct gfs2_sbd *sdp, const char *function,
 		    char *file, unsigned int line)
 {
 	gfs2_lm(sdp,
-		"fatal: filesystem consistency error - function = %s, file = %s, line = %u\n",
+		"fatal: filesystem consistency error - "
+		"function = %s, file = %s, line = %u\n",
 		function, file, line);
 	gfs2_withdraw(sdp);
 }
@@ -447,9 +449,9 @@ void gfs2_consist_inode_i(struct gfs2_inode *ip,
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
 
 	gfs2_lm(sdp,
-		"fatal: filesystem consistency error\n"
-		"  inode = %llu %llu\n"
-		"  function = %s, file = %s, line = %u\n",
+		"fatal: filesystem consistency error - "
+		"inode = %llu %llu, "
+		"function = %s, file = %s, line = %u\n",
 		(unsigned long long)ip->i_no_formal_ino,
 		(unsigned long long)ip->i_no_addr,
 		function, file, line);
@@ -470,9 +472,9 @@ void gfs2_consist_rgrpd_i(struct gfs2_rgrpd *rgd,
 	sprintf(fs_id_buf, "fsid=%s: ", sdp->sd_fsname);
 	gfs2_rgrp_dump(NULL, rgd, fs_id_buf);
 	gfs2_lm(sdp,
-		"fatal: filesystem consistency error\n"
-		"  RG = %llu\n"
-		"  function = %s, file = %s, line = %u\n",
+		"fatal: filesystem consistency error - "
+		"RG = %llu, "
+		"function = %s, file = %s, line = %u\n",
 		(unsigned long long)rgd->rd_addr,
 		function, file, line);
 	gfs2_dump_glock(NULL, rgd->rd_gl, 1);
@@ -492,9 +494,9 @@ int gfs2_meta_check_ii(struct gfs2_sbd *sdp, struct buffer_head *bh,
 	int me;
 
 	gfs2_lm(sdp,
-		"fatal: invalid metadata block\n"
-		"  bh = %llu (%s)\n"
-		"  function = %s, file = %s, line = %u\n",
+		"fatal: invalid metadata block - "
+		"bh = %llu (%s), "
+		"function = %s, file = %s, line = %u\n",
 		(unsigned long long)bh->b_blocknr, type,
 		function, file, line);
 	me = gfs2_withdraw(sdp);
@@ -514,9 +516,9 @@ int gfs2_metatype_check_ii(struct gfs2_sbd *sdp, struct buffer_head *bh,
 	int me;
 
 	gfs2_lm(sdp,
-		"fatal: invalid metadata block\n"
-		"  bh = %llu (type: exp=%u, found=%u)\n"
-		"  function = %s, file = %s, line = %u\n",
+		"fatal: invalid metadata block - "
+		"bh = %llu (type: exp=%u, found=%u), "
+		"function = %s, file = %s, line = %u\n",
 		(unsigned long long)bh->b_blocknr, type, t,
 		function, file, line);
 	me = gfs2_withdraw(sdp);
@@ -533,8 +535,8 @@ int gfs2_io_error_i(struct gfs2_sbd *sdp, const char *function, char *file,
 		    unsigned int line)
 {
 	gfs2_lm(sdp,
-		"fatal: I/O error\n"
-		"  function = %s, file = %s, line = %u\n",
+		"fatal: I/O error - "
+		"function = %s, file = %s, line = %u\n",
 		function, file, line);
 	return gfs2_withdraw(sdp);
 }
@@ -551,9 +553,9 @@ void gfs2_io_error_bh_i(struct gfs2_sbd *sdp, struct buffer_head *bh,
 	if (gfs2_withdrawing_or_withdrawn(sdp))
 		return;
 
-	fs_err(sdp, "fatal: I/O error\n"
-	       "  block = %llu\n"
-	       "  function = %s, file = %s, line = %u\n",
+	fs_err(sdp, "fatal: I/O error - "
+	       "block = %llu, "
+	       "function = %s, file = %s, line = %u\n",
 	       (unsigned long long)bh->b_blocknr, function, file, line);
 	if (withdraw)
 		gfs2_withdraw(sdp);
-- 
2.44.0


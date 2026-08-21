Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E726E357CEA
	for <gfs2@lists.linux.dev>; Fri, 21 Aug 2026 12:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787316597; cv=none; b=KMUo26giXQ5Svu2l7MxxLHqngognbje2OMjGTFquRaxk1loBPatlebuOTdeeVoHbMa3/Un5OvUqX69XlHE+7d4ZZGY0pe0dyk2p4REjjv85lygy3RoBsZJvJH+TOFWicQ4VfB/Gav/sqmMAC4U1PKFgOAo9TY71+zGduVYdsj+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787316597; c=relaxed/simple;
	bh=ai7uJ/Bp3B7k7gqjdZG7kEQ3Rd98EsyvAnFZEz0/shU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PIYzqTFEKlaznJzy0SgvU+N80ovv9/3z193y9NKS75rd2OTh4JDqJUaczuhMFQ/X7GE8q6sJ6tOwXbXSoUjTVjfzFW0mjxYMi76GwT+vKCqcGbdkUoJPLpVjc74BwqsGgs+f6cKIvH2ZixfoiLDwIShpYmRril70yM7uXlB1DCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cz5pyGE7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cz5pyGE7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787316593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3wsLc+kCmVuiTNnIgEiiFPeO1wE1TwVCD2+t4+B/gEQ=;
	b=cz5pyGE7BnrrfDpKR8tCWWS5bSRqQx422vIa6c/C8uZCnJbyNnek2dvG0W3qF5cfI9obkA
	TOyxQvPHdJJr8AdT5a4Iawj6NyJxcZhRXJFJuh2j3aQ1FS8R9qOJMiynM0GIhmDOV9FdWw
	d0MHTUfqd4iQdNZzjdKSLq8wg5xb3f0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-3raF9grjPtShuaxpPSeESA-1; Fri,
 21 Aug 2026 08:49:49 -0400
X-MC-Unique: 3raF9grjPtShuaxpPSeESA-1
X-Mimecast-MFC-AGG-ID: 3raF9grjPtShuaxpPSeESA_1787316588
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C6DED1955F20;
	Fri, 21 Aug 2026 12:49:47 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.44.48.197])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E2D5D18005BB;
	Fri, 21 Aug 2026 12:49:45 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Edward Adam Davis <eadavis@qq.com>,
	gfs2@lists.linux.dev,
	syzbot <syzbot+9d20c3ad7d29227de28d@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [mm?] [gfs2?] WARNING in read_rindex_entry
Date: Fri, 21 Aug 2026 14:49:43 +0200
Message-ID: <20260821124944.1648686-1-agruenba@redhat.com>
In-Reply-To: <20260819171409.e30eed94c3f7eb44b38e5ec7@linux-foundation.org>
References: <20260819171409.e30eed94c3f7eb44b38e5ec7@linux-foundation.org> <6a863306.ae6ddae5.3da009.0013.GAE@google.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 1
X-Mimecast-MFC-PROC-ID: OHbXSN-_5YkhvZag90mDsf2DJ9YnaodjnRhV0Vlxr5Y_1787316588
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Aug 20, 2026 at 2:24 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> On Wed, 19 Aug 2026 15:49:42 -0700 syzbot <syzbot+9d20c3ad7d29227de28d@syzkaller.appspotmail.com> wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    15ef2f78c49d Merge tag 'input-for-v7.2-rc7' of git://git.k..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=10871279580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=a0fdc3b566746377
> > dashboard link: https://syzkaller.appspot.com/bug?extid=9d20c3ad7d29227de28d
> > compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14871279580000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=100d2a25580000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/c2a8c7d3a889/disk-15ef2f78.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/2da78afed345/vmlinux-15ef2f78.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/c4ffd97e4708/bzImage-15ef2f78.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/eaa4120812b6/mount_0.gz
> >   fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=17f52a25580000)
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+9d20c3ad7d29227de28d@syzkaller.appspotmail.com
>
> Thanks.  Mounting an intentionally corrupted fs image, I assume.
>
> It appears that GFS2 forgot to validate the `ri_length' which it read
> from disk.  That gets used in compute_bitstructs()->kzalloc_objs() and
> the memory allocator didn't like the excessively-sized allocation
> attempt.

Thanks for looking into this.  This commit (attached below) from the
for-later branch should prevent that from happening:

https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/merge_requests/8684#note_3716004816

Thanks,
Andreas

--

gfs2: Improve resource group validation and error handling

Validate the resource group boundaries, check against the device size, simplify
the initialization logic, and check for resource group overlaps.

Reported-by: syzbot+9d20c3ad7d29227de28d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9d20c3ad7d29227de28d
Tested-by: syzbot+9d20c3ad7d29227de28d@syzkaller.appspotmail.com
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/rgrp.c | 123 ++++++++++++++++++++++++++-----------------------
 1 file changed, 65 insertions(+), 58 deletions(-)

diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index f6048a73e5c3..3ac751eea055 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -745,6 +745,7 @@ void gfs2_clear_rgrpd(struct gfs2_sbd *sdp)
 
 /**
  * compute_bitstructs - Compute the bitmap sizes
+ * @sb: The superblock
  * @rgd: The resource group descriptor
  *
  * Calculates bitmap descriptors, one for each block that contains bitmap data
@@ -752,84 +753,74 @@ void gfs2_clear_rgrpd(struct gfs2_sbd *sdp)
  * Returns: errno
  */
 
-static int compute_bitstructs(struct gfs2_rgrpd *rgd)
+static int compute_bitstructs(struct super_block *sb, struct gfs2_rgrpd *rgd)
 {
 	struct gfs2_sbd *sdp = rgd->rd_sbd;
 	struct gfs2_bitmap *bi;
-	u32 length = rgd->rd_length; /* # blocks in hdr & bitmap */
+	u32 expected_length;
 	u32 bytes_left, bytes;
+	u64 data_end;
 	int x;
 
-	if (!length)
-		return -EINVAL;
+	/*
+	 * The first resource group block has a gfs2_rgrp header; the remaining
+	 * blocks have a gfs2_meta_header header.  The rest of each block is
+	 * filled with bitmap data.
+	 */
+
+	if (rgd->rd_addr <= (GFS2_SB_ADDR >> sdp->sd_fsb2bb_shift)) {
+		gfs2_consist_rgrpd(rgd);
+		return -EIO;
+	}
+	if (check_add_overflow(rgd->rd_data0, rgd->rd_data, &data_end) ||
+	    rgd->rd_data == 0 || data_end > sb_bdev_nr_blocks(sb)) {
+		gfs2_consist_rgrpd(rgd);
+		return -EIO;
+	}
+	if (rgd->rd_bitbytes != DIV_ROUND_UP(rgd->rd_data, GFS2_NBBY)) {
+		gfs2_consist_rgrpd(rgd);
+		return -EIO;
+	}
+	expected_length = DIV_ROUND_UP(rgd->rd_bitbytes +
+		sizeof(struct gfs2_rgrp) - sizeof(struct gfs2_meta_header),
+		sdp->sd_sb.sb_bsize - sizeof(struct gfs2_meta_header));
+	if (rgd->rd_length != expected_length) {
+		gfs2_consist_rgrpd(rgd);
+		return -EIO;
+	}
+	if (rgd->rd_data0 < rgd->rd_addr + rgd->rd_length) {
+		gfs2_consist_rgrpd(rgd);
+		return -EIO;
+	}
 
-	rgd->rd_bits = kzalloc_objs(struct gfs2_bitmap, length, GFP_NOFS);
+	rgd->rd_bits = kzalloc_objs(struct gfs2_bitmap, rgd->rd_length, GFP_NOFS);
 	if (!rgd->rd_bits)
 		return -ENOMEM;
 
 	bytes_left = rgd->rd_bitbytes;
 
-	for (x = 0; x < length; x++) {
+	for (x = 0; x < rgd->rd_length; x++) {
 		bi = rgd->rd_bits + x;
 
 		bi->bi_flags = 0;
-		/* small rgrp; bitmap stored completely in header block */
-		if (length == 1) {
-			bytes = bytes_left;
-			bi->bi_offset = sizeof(struct gfs2_rgrp);
+		if (x == 0) {
+			/* header block */
 			bi->bi_start = 0;
-			bi->bi_bytes = bytes;
-			bi->bi_blocks = bytes * GFS2_NBBY;
-		/* header block */
-		} else if (x == 0) {
-			bytes = sdp->sd_sb.sb_bsize - sizeof(struct gfs2_rgrp);
 			bi->bi_offset = sizeof(struct gfs2_rgrp);
-			bi->bi_start = 0;
-			bi->bi_bytes = bytes;
-			bi->bi_blocks = bytes * GFS2_NBBY;
-		/* last block */
-		} else if (x + 1 == length) {
-			bytes = bytes_left;
-			bi->bi_offset = sizeof(struct gfs2_meta_header);
-			bi->bi_start = rgd->rd_bitbytes - bytes_left;
-			bi->bi_bytes = bytes;
-			bi->bi_blocks = bytes * GFS2_NBBY;
-		/* other blocks */
 		} else {
-			bytes = sdp->sd_sb.sb_bsize -
-				sizeof(struct gfs2_meta_header);
+			/* bitmap-only block */
+			struct gfs2_bitmap *prev = bi - 1;
+
+			bi->bi_start = prev->bi_start + prev->bi_bytes;
 			bi->bi_offset = sizeof(struct gfs2_meta_header);
-			bi->bi_start = rgd->rd_bitbytes - bytes_left;
-			bi->bi_bytes = bytes;
-			bi->bi_blocks = bytes * GFS2_NBBY;
 		}
-
+		bytes = sdp->sd_sb.sb_bsize - bi->bi_offset;
+		if (bytes > bytes_left)
+			bytes = bytes_left;
+		bi->bi_bytes = bytes;
+		bi->bi_blocks = bytes * GFS2_NBBY;
 		bytes_left -= bytes;
 	}
-
-	if (bytes_left) {
-		gfs2_consist_rgrpd(rgd);
-		return -EIO;
-	}
-	bi = rgd->rd_bits + (length - 1);
-	if ((bi->bi_start + bi->bi_bytes) * GFS2_NBBY != rgd->rd_data) {
-		gfs2_lm(sdp,
-			"ri_addr=%llu "
-			"ri_length=%u "
-			"ri_data0=%llu "
-			"ri_data=%u "
-			"ri_bitbytes=%u "
-			"start=%u len=%u offset=%u\n",
-			(unsigned long long)rgd->rd_addr,
-			rgd->rd_length,
-			(unsigned long long)rgd->rd_data0,
-			rgd->rd_data,
-			rgd->rd_bitbytes,
-			bi->bi_start, bi->bi_bytes, bi->bi_offset);
-		gfs2_consist_rgrpd(rgd);
-		return -EIO;
-	}
-
 	return 0;
 }
 
@@ -864,6 +855,7 @@ static int rgd_insert(struct gfs2_rgrpd *rgd)
 {
 	struct gfs2_sbd *sdp = rgd->rd_sbd;
 	struct rb_node **newn = &sdp->sd_rindex_tree.rb_node, *parent = NULL;
+	struct rb_node *prevn;
 
 	/* Figure out where to put new node */
 	while (*newn) {
@@ -882,6 +874,19 @@ static int rgd_insert(struct gfs2_rgrpd *rgd)
 	rb_link_node(&rgd->rd_node, parent, newn);
 	rb_insert_color(&rgd->rd_node, &sdp->sd_rindex_tree);
 	sdp->sd_rgrps++;
+
+	prevn = rb_prev(&rgd->rd_node);
+	if (prevn) {
+		struct gfs2_rgrpd *prev =
+			rb_entry(prevn, struct gfs2_rgrpd, rd_node);
+
+		if (prev->rd_data0 + prev->rd_data > rgd->rd_addr) {
+			fs_err(sdp, "overlapping resource groups.\n");
+			rb_erase(&rgd->rd_node, &sdp->sd_rindex_tree);
+			return -ENOENT;
+		}
+	}
+
 	return 0;
 }
 
@@ -928,7 +933,7 @@ static int read_rindex_entry(struct gfs2_inode *ip)
 	if (error)
 		goto fail;
 
-	error = compute_bitstructs(rgd);
+	error = compute_bitstructs(sdp->sd_vfs, rgd);
 	if (error)
 		goto fail_glock;
 
@@ -944,7 +949,9 @@ static int read_rindex_entry(struct gfs2_inode *ip)
 		return 0;
 	}
 
-	error = 0; /* someone else read in the rgrp; free it and ignore it */
+	/* If someone else read in the rgrp, free it and ignore it. */
+	if (error == -EEXIST)
+		error = 0;
 fail_glock:
 	gfs2_glock_put(rgd->rd_gl);
 
-- 
2.55.0


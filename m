Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5291E1DE5
	for <gfs2@lists.linux.dev>; Fri, 29 May 2026 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780046414; cv=none; b=W9Ir1l6PZ2R1zxQC8W/qZ9asiJ0bVA8vabfjiCZpcP8KO1YcHQC/y9/0jizaR6h8CUTBYDOU7CB1FwbHfHblZkh5dmn/HK7M7fV1N+1FkReiDk265zXOWcM42sVSdqv1c36KiAmpF2kHljYlWZOwmRRr4laRhXZx6OOA5KWSddM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780046414; c=relaxed/simple;
	bh=Ej886h7SrfVyU41iuK6du1Gnrkqc40snjuKIOJwBu5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=K+33pqA6395NPOd6z4yIMgtRApfgaev10wlaAFYJNVMPOpnLiDbYVW8aV+78jngcGxtrfys29VLHz4UOwklZAg9FxX6iyTPWtlS9s0H/hYwn0XOtn3gg7EDe5AhFzZOptBVggg8Anf+7G7sEPStfiKTii2ssjTHTr8BeE8GOjog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AVMFSNsG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVMFSNsG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780046411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yAB5nmtneTsGjmwnCDrKdAnnn2/5ai5M+Q6OtpfT9y4=;
	b=AVMFSNsG1WmQIZM+/+vsrmz1b00tSbFRQZHhQAqM1NSVzz28eNv+7RRs+pukMo7ZpgFZHN
	pcyzuH3fn/gpjn23YEW1JBE1eJiI4PS9dslEQvbSIWsrS5K4gAI2LVLvCcTXj24AGR0tIw
	OZ3sxYBhqs/yy4juFVbzfd/Q/Czz0b8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-muY_VMKfMFmgIddktd6WqA-1; Fri,
 29 May 2026 05:20:10 -0400
X-MC-Unique: muY_VMKfMFmgIddktd6WqA-1
X-Mimecast-MFC-AGG-ID: muY_VMKfMFmgIddktd6WqA_1780046409
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 559131800359
	for <gfs2@lists.linux.dev>; Fri, 29 May 2026 09:20:09 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.48.35])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 65A21180056E;
	Fri, 29 May 2026 09:20:08 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 2/2] gfs2: page poisoning fix
Date: Fri, 29 May 2026 11:20:05 +0200
Message-ID: <20260529092005.954183-2-agruenba@redhat.com>
In-Reply-To: <20260529092005.954183-1-agruenba@redhat.com>
References: <20260529092005.954183-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MntQGluZD_0RReUPCnYg6QTM2onU5Uh6p-TUaScDNoo_1780046409
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Processes can write to the last page of a file using mmap, and when the file
size is not a multiple of the page size, this can be used to write beyond the
end of the file.  This is sometimes referred to as page poisoning, and it is
not a problem in itself because the data beyond eof will be ignored.  However,
we currently fail to clear out any space beyond the end of the file that we
skip over when the file size is increased, so that "poison" can end up getting
exposed.  Fix that.

Fixes xfstest generic/363.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/bmap.c | 19 +++++++++++++++++++
 fs/gfs2/bmap.h |  1 +
 fs/gfs2/file.c | 10 ++++++++++
 3 files changed, 30 insertions(+)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index b3d7fcd95f03..95a64819fe2c 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1321,6 +1321,19 @@ static int gfs2_block_zero_range(struct inode *inode, loff_t from, loff_t length
 			&gfs2_iomap_write_ops, NULL);
 }
 
+int gfs2_clear_beyond_eof(struct inode *inode, loff_t end)
+{
+	loff_t isize = i_size_read(inode);
+	unsigned int len = isize & ~PAGE_MASK;
+
+	if (!len || isize >= end)
+		return 0;
+	len = PAGE_SIZE - len;
+	if (end - isize < len)
+		len = end - isize;
+	return gfs2_block_zero_range(inode, isize, len);
+}
+
 #define GFS2_JTRUNC_REVOKES 8192
 
 /**
@@ -2096,6 +2109,12 @@ static int do_grow(struct inode *inode, u64 size)
 		unstuff = 1;
 	}
 
+	if (!unstuff) {
+		error = gfs2_clear_beyond_eof(inode, size);
+		if (error)
+			goto do_grow_qunlock;
+	}
+
 	error = gfs2_trans_begin(sdp, RES_DINODE + RES_STATFS + RES_RG_BIT +
 				 (unstuff &&
 				  gfs2_is_jdata(ip) ? RES_JDATA : 0) +
diff --git a/fs/gfs2/bmap.h b/fs/gfs2/bmap.h
index 6cdc72dd55a3..e3d6efdfd890 100644
--- a/fs/gfs2/bmap.h
+++ b/fs/gfs2/bmap.h
@@ -58,6 +58,7 @@ int gfs2_get_extent(struct inode *inode, u64 lblock, u64 *dblock,
 		    unsigned int *extlen);
 int gfs2_alloc_extent(struct inode *inode, u64 lblock, u64 *dblock,
 		      unsigned *extlen, bool *new);
+int gfs2_clear_beyond_eof(struct inode *inode, loff_t end);
 int gfs2_setattr_size(struct inode *inode, u64 size);
 int gfs2_truncatei_resume(struct gfs2_inode *ip);
 int gfs2_file_dealloc(struct gfs2_inode *ip);
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 48ebda5ba808..b8c10de113ba 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1057,6 +1057,10 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb,
 			goto out_unlock;
 	}
 
+	ret = gfs2_clear_beyond_eof(inode, iocb->ki_pos);
+	if (ret)
+		goto out_unlock;
+
 	pagefault_disable();
 	ret = iomap_file_buffered_write(iocb, from, &gfs2_iomap_ops,
 			&gfs2_iomap_write_ops, NULL);
@@ -1265,6 +1269,12 @@ static long __gfs2_fallocate(struct file *file, int mode, loff_t offset, loff_t
 
 	next = (next + 1) << sdp->sd_sb.sb_bsize_shift;
 
+	if (!(mode & FALLOC_FL_KEEP_SIZE)) {
+		error = gfs2_clear_beyond_eof(inode, offset + len);
+		if (error)
+			return error;
+	}
+
 	offset &= bsize_mask;
 
 	len = next - offset;
-- 
2.54.0


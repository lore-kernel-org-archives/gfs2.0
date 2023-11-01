Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8F315E87
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYBT4uwN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698857188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c/YGN1/SYbZrGY8Q6l0x6uxgAuD34zNBiMl4/zLqysA=;
	b=JYBT4uwNQM8+x07tnc/LPhwKXbUzo8SbkCNzGsW266Mak2lz3o63Cmtqx5WCOYJxhxRP6L
	a0wURmqXaIDrbV7kq6edOFCR57X85EBdPSXmJoFssnji4Kgb8AtTwipk/hhqCFL5Rz4IOw
	TdHHrZpyMeL71C9gcLmSj5hmS0Y7ix4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-jhXCcWrMPhaNB1edsr-Vcw-1; Wed, 01 Nov 2023 12:46:26 -0400
X-MC-Unique: jhXCcWrMPhaNB1edsr-Vcw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12C7F85A58A
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:26 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8B50740C6EBF;
	Wed,  1 Nov 2023 16:46:25 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 11/25] gfs2: Clean up gfs2_alloc_parms initializers
Date: Wed,  1 Nov 2023 17:46:01 +0100
Message-ID: <20231101164615.1138692-12-agruenba@redhat.com>
In-Reply-To: <20231101164615.1138692-1-agruenba@redhat.com>
References: <20231101164615.1138692-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

When intializing a struct, all fields that are not explicitly mentioned
are zeroed out already.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/file.c  | 4 ++--
 fs/gfs2/quota.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 5bc103b031e2..4b66efc1a82a 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -418,7 +418,7 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
-	struct gfs2_alloc_parms ap = { .aflags = 0, };
+	struct gfs2_alloc_parms ap = {};
 	u64 offset = page_offset(page);
 	unsigned int data_blocks, ind_blocks, rblocks;
 	vm_fault_t ret = VM_FAULT_LOCKED;
@@ -1251,7 +1251,7 @@ static long __gfs2_fallocate(struct file *file, int mode, loff_t offset, loff_t
 	struct inode *inode = file_inode(file);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	struct gfs2_inode *ip = GFS2_I(inode);
-	struct gfs2_alloc_parms ap = { .aflags = 0, };
+	struct gfs2_alloc_parms ap = {};
 	unsigned int data_blocks = 0, ind_blocks = 0, rblocks;
 	loff_t bytes, max_bytes, max_blks;
 	int error;
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index d0d01d485621..27f14ef4d346 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -909,7 +909,7 @@ static int do_sync(unsigned int num_qd, struct gfs2_quota_data **qda)
 {
 	struct gfs2_sbd *sdp = (*qda)->qd_sbd;
 	struct gfs2_inode *ip = GFS2_I(sdp->sd_quota_inode);
-	struct gfs2_alloc_parms ap = { .aflags = 0, };
+	struct gfs2_alloc_parms ap = {};
 	unsigned int data_blocks, ind_blocks;
 	struct gfs2_holder *ghs, i_gh;
 	unsigned int qx, x;
@@ -1741,7 +1741,7 @@ static int gfs2_set_dqblk(struct super_block *sb, struct kqid qid,
 	if (gfs2_is_stuffed(ip))
 		alloc_required = 1;
 	if (alloc_required) {
-		struct gfs2_alloc_parms ap = { .aflags = 0, };
+		struct gfs2_alloc_parms ap = {};
 		gfs2_write_calc_reserv(ip, sizeof(struct gfs2_quota),
 				       &data_blocks, &ind_blocks);
 		blocks = 1 + data_blocks + ind_blocks;
-- 
2.41.0


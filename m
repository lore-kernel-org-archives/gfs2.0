Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03240449B12;
	Tue,  8 Sep 2026 21:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788902143; cv=none; b=CYtYtozCxF59uC6vh7TXXxkhQR+U2dBd4VvDApwHXvT8HVVLY+61uVjBZTXnlag7Cidgx7wdatrzG37HM6ONcw3pCwkp0IKanLBg7+xBolV4SpjUBM5nfgHNNjlxWo2Oa5ceX2ah7YQHq3pr0Trw6imajPosd4Gu7p6R0K/rV28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788902143; c=relaxed/simple;
	bh=mV84SZIgrDuXEajOV+VaHC60jYs2VDmdGuj2ftoecqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ghpDVG0lGijLpgxKFqg9L/sFDA/aXRTaWpRbHNmzJQfzSjWuZwWXYYCC/tTRcl5xExl0BNeGZ4WOBAXlGjyMp6WQUS3yevjYFwitY2ySdx2FtpK38swhdLU+NLk0bXZfBU3P3cejAJnxnzSXQ7/zaA1yJ5jepgvEHdAQXr2fEpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=GG8krQ3w; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="GG8krQ3w"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=1kcvINLQe7zq/DuzGWNi2heCC/ji3ZC1gBagaEJ6Vj0=; b=GG8krQ3wUJTQoE/osSajGP5/oG
	cKK7QkWm2pAaPaJuGUJyg+Vo4T754kGd9iZyH1Q8qkL34FpOc4lwfz3cLXzGcTiUqDkLlWHH7eLpd
	oMdgIo0QM7wrfMLwGA6QOZiP0L3364xofinPwPRoU6oJRB2yODhjIXBriGPd4EPyhNEaLrjSliD4u
	k1k3atUawPiy27JT8LnsjAGH0plpQPaYXG3FxTza2TFmRmDJX7RrsDpDTXIxgWolxBdbHdwcayusi
	TGfdBi9sWO0kLheBGJTmHXZ1Zt+iUzpRJGdjgKQxEflC313HI4iWfODXxmq66fwLSSWgik/FjsDdp
	vx6WhvNA==;
Received: from 186-249-150-254.shared.desktop.com.br ([186.249.150.254] helo=[127.0.1.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1x43AI-00GhZP-IK; Tue, 08 Sep 2026 23:15:38 +0200
From: Mauricio Faria de Oliveira <mfo@igalia.com>
Date: Tue, 08 Sep 2026 18:16:12 -0300
Subject: [PATCH 1/5] gfs2: handle errors from __filemap_get_folio() with
 FGP_CREAT in gfs2_getbuf()
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-gfs2_getbuf-error-checks-v1-1-7c59698f178f@igalia.com>
References: <20260908-gfs2_getbuf-error-checks-v1-0-7c59698f178f@igalia.com>
In-Reply-To: <20260908-gfs2_getbuf-error-checks-v1-0-7c59698f178f@igalia.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: kernel-dev@igalia.com, gfs2@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Mauricio Faria de Oliveira <mfo@igalia.com>
X-Mailer: b4 0.14.2

Function __filemap_get_folio() with FGP_CREAT might fail, for example, with
ERR_PTR(-ENOMEM). This hits a kernel oops, as gfs2_getbuf() dereferences an
error pointer:

 gfs2: fsid=loop0: Trying to join cluster "lock_nolock", "loop0"
 gfs2: fsid=loop0: Now mounting FS (format 1802)...
 Oops: general protection fault, probably for non-canonical address
                      0xdffffc0000000003: 0000 [#1] SMP KASAN NOPTI
 KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
 ...
 RIP: 0010:gfs2_getbuf+0x492/0x5a0
 [  ...
 Call Trace:
  <TASK>
  gfs2_meta_read+0x106/0x7a0
  gfs2_meta_buffer+0x125/0x360
  inode_go_instantiate+0xde/0x1510
  gfs2_instantiate+0x102/0x1c0
  gfs2_glock_wait+0x19a/0x2c0
  gfs2_lookupi+0x2ba/0x570
  gfs2_lookup_meta+0xad/0x160
  init_inodes+0x350/0x20b0
  gfs2_fill_super+0x19b6/0x2730
  get_tree_bdev_flags+0x2f4/0x560
  gfs2_get_tree+0x48/0x230
  vfs_get_tree+0x87/0x2d0
  vfs_cmd_create+0xb2/0x240
  __do_sys_fsconfig+0x3d2/0x980
  do_syscall_64+0xce/0x450
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
 ...
  </TASK>

That is noted more clearly in convenience function filemap_grab_folio()
(snippet below) and checked by virtually all other callers in the kernel.

 ...
  * Return: A found or created folio. ERR_PTR(-ENOMEM) if no folio is found
  * and failed to create a folio.
 ...
 static inline struct folio *filemap_grab_folio(...)
 {
         return __filemap_get_folio(...,
                                    ... | FGP_CREAT,
                                    ...);
 }

Thus, if __filemap_get_folio() returns an error, log it (as it's lost) and
return NULL. Callers will be handled.

Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>
---
 fs/gfs2/meta_io.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index a87cfbf0df38706e6b7c63cc55f5251765d6b398..51b1a2e2bfadea6dabfac5ecba983c615a1a69fa 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -145,6 +145,10 @@ struct buffer_head *gfs2_getbuf(struct gfs2_glock *gl, u64 blkno, int create)
 		folio = __filemap_get_folio(mapping, index,
 				FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
 				mapping_gfp_mask(mapping) | __GFP_NOFAIL);
+		if (IS_ERR(folio)) {
+			fs_err(sdp, "Error %ld creating buffer\n", PTR_ERR(folio));
+			return NULL;
+		}
 		bh = folio_buffers(folio);
 		if (!bh)
 			bh = create_empty_buffers(folio,

-- 
2.47.3


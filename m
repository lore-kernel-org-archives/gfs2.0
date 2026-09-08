Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0319745198A;
	Tue,  8 Sep 2026 21:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788902145; cv=none; b=cOqCIih9GOwp7AG5y1tTe5pOHQuVJ0HVrBrQtZqC4KpsYZvm6kyuqm8AgBKqyAH/UL1CgpVE3gvDZq6jp9S+aZl/EbcKwLr0wXywqCAQnsSZTSTUojpiVV4e/HLK92lR6pYf+boDV81c1W29VrWOJhsTzyeTsib6Ug1p8TXaCG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788902145; c=relaxed/simple;
	bh=zDdrF9Sn8OKlpXaKIAkN+l5hQ2Z/AJVENwGhpKQlC/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oWikFx52SnoM7OUesLIhWo9niFhE1HuhNkvhwFbmvpDtAOUpZ2+LVplC4x+wC6VcCzG6cnfDG8bHF0KlVyTePPmkOqB8NoJYhHN2crUeLP/36Nlt5nKzoNwC6wDUPN8haSlVE/FM0HSJfm2qfdJdVg0pzSYbsanWdLS6TkukCno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=rMI2g1tN; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rMI2g1tN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=r91aiZES4W6lq6IQ4y2JAiOzuaqe05Gs5UjuSKcOaSU=; b=rMI2g1tNVACPOHrNVF44Uj4gVC
	nPCu9u3n2NmN/AVtV2h1Qkk1nXmvT9ULV2//OQKWx/xT+90v/zRELuRkESwaHjE2NYBWz2hPhSmY3
	aNc5w/Br1w3u2NwSyWroX2JGjv9rGibfin4WJwV6+g/lc4acRV3UbbpfJzHQZ8/vG9xa/MqXPM676
	ydMvQJaM/cyAwI9VSbw+uREWuZXhXTsyjlubqcZFZSyNXhLkmVLq3FXDG417D0pRwgNg+zSymPAqP
	JYNUP8qrBW/EjFAuf6V6C+1sO1qblCoDs4cmjMe8peS6YjkW8eauxctSA+HNZ25d5LHTZxchan7we
	e+McX4Tg==;
Received: from 186-249-150-254.shared.desktop.com.br ([186.249.150.254] helo=[127.0.1.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1x43AK-00GhZP-9v; Tue, 08 Sep 2026 23:15:40 +0200
From: Mauricio Faria de Oliveira <mfo@igalia.com>
Date: Tue, 08 Sep 2026 18:16:13 -0300
Subject: [PATCH 2/5] gfs2: handle NULL return value in callers of
 gfs2_getbuf() with CREATE
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-gfs2_getbuf-error-checks-v1-2-7c59698f178f@igalia.com>
References: <20260908-gfs2_getbuf-error-checks-v1-0-7c59698f178f@igalia.com>
In-Reply-To: <20260908-gfs2_getbuf-error-checks-v1-0-7c59698f178f@igalia.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: kernel-dev@igalia.com, gfs2@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Mauricio Faria de Oliveira <mfo@igalia.com>
X-Mailer: b4 0.14.2

Now that gfs2_getbuf() with CREATE can return NULL (instead of hit a kernel
oops), update its callers to handle it (and not hit another kernel oops).

If gfs2_getbuf() returns NULL:

- gfs2_metapath_ra()
- gfs2_dir_readahead()

  Skip the rest of the loop. This should be OK as it's currently done if
  !trylock_buffer() or buffer_uptodate(), anyway.
  We can skip put_bh() as gfs2_getbuf() doesn't do get_bh() in this case.

- gfs2_meta_new()

  Propagate NULL. Callers will be handled.

- gfs2_meta_read()

  For either a block or read-ahead, fail as currently done by other cases.
  (Factor out the error path used multiple times now.)

- gfs2_meta_ra()

  - For the first buffer:

    Popagate NULL. Callers will be handled.

  - For remaining buffers:

    Skip the rest of the loop. This should be OK as the condition to exit
    the loop is based on the first buffer (not remaining buffers), anyway.

Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>
---
 fs/gfs2/bmap.c    |  2 ++
 fs/gfs2/dir.c     |  2 ++
 fs/gfs2/meta_io.c | 26 +++++++++++++++++++-------
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 73c62697116390f0f5f09f0b8fd267cc0790e953..a766b5816634d360a4bbae89f8bcdd284071864a 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -302,6 +302,8 @@ static void gfs2_metapath_ra(struct gfs2_glock *gl, __be64 *start, __be64 *end)
 			continue;
 
 		rabh = gfs2_getbuf(gl, be64_to_cpu(*t), CREATE);
+		if (!rabh)
+			continue;
 		if (trylock_buffer(rabh)) {
 			if (!buffer_uptodate(rabh)) {
 				bh_submit(rabh,
diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index 0237b36b9eb16562ab3a3415b53547c43ab26f52..0d92f6c33dcb85dfa2a4b07f9f09575834e75e01 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -1502,6 +1502,8 @@ static void gfs2_dir_readahead(struct inode *inode, unsigned hsize, u32 index,
 			continue;
 
 		bh = gfs2_getbuf(gl, blocknr, 1);
+		if (!bh)
+			continue;
 		if (trylock_buffer(bh)) {
 			if (buffer_uptodate(bh)) {
 				unlock_buffer(bh);
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index 51b1a2e2bfadea6dabfac5ecba983c615a1a69fa..daa38fc7c825cdb70349caa7b55ef333b10af7c2 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -199,6 +199,8 @@ struct buffer_head *gfs2_meta_new(struct gfs2_glock *gl, u64 blkno)
 {
 	struct buffer_head *bh;
 	bh = gfs2_getbuf(gl, blkno, CREATE);
+	if (!bh)
+		return NULL;
 	meta_prep_new(bh);
 	return bh;
 }
@@ -268,12 +270,13 @@ int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
 	struct buffer_head *bh, *bhs[2];
 	int num = 0;
 
-	if (gfs2_withdrawn(sdp)) {
-		*bhp = NULL;
-		return -EIO;
-	}
+	if (gfs2_withdrawn(sdp))
+		goto error;
 
-	*bhp = bh = gfs2_getbuf(gl, blkno, CREATE);
+	bh = gfs2_getbuf(gl, blkno, CREATE);
+	if (!bh)
+		goto error;
+	*bhp = bh;
 
 	lock_buffer(bh);
 	if (buffer_uptodate(bh)) {
@@ -286,6 +289,8 @@ int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
 
 	if (rahead) {
 		bh = gfs2_getbuf(gl, blkno + 1, CREATE);
+		if (!bh)
+			goto error;
 
 		lock_buffer(bh);
 		if (buffer_uptodate(bh)) {
@@ -307,11 +312,14 @@ int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
 		if (tr && test_bit(TR_TOUCHED, &tr->tr_flags))
 			gfs2_io_error_bh(sdp, bh);
 		brelse(bh);
-		*bhp = NULL;
-		return -EIO;
+		goto error;
 	}
 
 	return 0;
+
+error:
+	*bhp = NULL;
+	return -EIO;
 }
 
 /**
@@ -494,6 +502,8 @@ struct buffer_head *gfs2_meta_ra(struct gfs2_glock *gl, u64 dblock, u32 extlen)
 		extlen = max_ra;
 
 	first_bh = gfs2_getbuf(gl, dblock, CREATE);
+	if (!first_bh)
+		return NULL;
 
 	if (buffer_uptodate(first_bh))
 		goto out;
@@ -504,6 +514,8 @@ struct buffer_head *gfs2_meta_ra(struct gfs2_glock *gl, u64 dblock, u32 extlen)
 
 	while (extlen) {
 		bh = gfs2_getbuf(gl, dblock, CREATE);
+		if (!bh)
+			continue;
 
 		bh_readahead(bh, REQ_RAHEAD | REQ_META | REQ_PRIO);
 		brelse(bh);

-- 
2.47.3


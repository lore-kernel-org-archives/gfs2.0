Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A88D46EF8F;
	Tue,  8 Sep 2026 21:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788902148; cv=none; b=DpAuTWZZMx8BTEr6kRcT70kevjRcubK40qIOyo6I6mKash2JzPkjJA8T460NUjht4V5zdi9lpmq91EgL+hyN4/N6sHMWN7s/G7qUXOKgzcCjriewUuD/KJRH+lzUt61+mMUNZ/MObbPY97OOJS7abBPmqZab3xJI7qRzwJ7QFsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788902148; c=relaxed/simple;
	bh=gnJdJFxyN9n/8EEEj3k1H2t58sMnyWyvkhrEjnCwA7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bDb/+WO+EOhbcrGciLF0GfAbIIgbMTZWeVWKW7c1TVRXWj71QnU8vZwGnJHrGCwYEipOE441quqJJtHb9LAv7f+qHVGDtImRkYXoHpN34+OEoZ9EWdyKcu4vdnLlZgWmH4SgWa73I/y1aJ8pjBTcZAtfl4PVFWCRTgP0qU7yHRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ipVJkxZI; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ipVJkxZI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=rit/GRM67RzziSsQPYEeLW9gGLmC6p1xfu05lnuNdlY=; b=ipVJkxZINpNR8yviLxtS7I/0Yn
	/F2Z2WcSlHWMkhvtcdCoRp/uDc4smXgDANOYP6IkPKz1vhNgDuYyYTPwwauKsOp85VIZcJjMDDJsT
	SXTqpSBcFUwvXxM7FIqDjnxW9A5T8H0UVwcMfAdJ1CCgY0qy8usnvcZy3MbXQKEFNg4Aqn6xqyeQ8
	VOIRaflGq9rc1Y5mhMzI8vfvz8FwlJggNzUro4xVnl4hqlSae87YOzb4KW24W3RV609O+YnXk4C7x
	841aA4sw5m9DMjE7+bZeCNC2P7uv+JLq28clcppKKE/acujksARoJ9z44fOX0xenxMfOuZQsCoHeN
	UmMnxYbw==;
Received: from 186-249-150-254.shared.desktop.com.br ([186.249.150.254] helo=[127.0.1.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1x43AN-00GhZP-PX; Tue, 08 Sep 2026 23:15:44 +0200
From: Mauricio Faria de Oliveira <mfo@igalia.com>
Date: Tue, 08 Sep 2026 18:16:15 -0300
Subject: [PATCH 4/5] gfs2: handle NULL return value in callers of
 gfs2_meta_ra()
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-gfs2_getbuf-error-checks-v1-4-7c59698f178f@igalia.com>
References: <20260908-gfs2_getbuf-error-checks-v1-0-7c59698f178f@igalia.com>
In-Reply-To: <20260908-gfs2_getbuf-error-checks-v1-0-7c59698f178f@igalia.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: kernel-dev@igalia.com, gfs2@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Mauricio Faria de Oliveira <mfo@igalia.com>
X-Mailer: b4 0.14.2

Now that gfs2_meta_ra() can return NULL (instead of hit a kernel oops),
update its callers to handle it (and not hit another kernel oops).

If gfs2_meta_ra() returns NULL:

- gfs2_quota_init()

  It currently checks for NULL and returns -EIO.

- gfs2_dir_read_data()

  Return -EIO. Fail as currently done in other cases.

- gfs2_replay_read_block()

  Return -EIO. It can currently return errors.

Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>
---
 fs/gfs2/dir.c      | 4 ++++
 fs/gfs2/recovery.c | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index d1dc1e94b6c432d2ede504b04cb71959285a945d..d9e0b6b19567c8aa8518b9245e9bdfd3ccf7c1a7 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -302,6 +302,10 @@ static int gfs2_dir_read_data(struct gfs2_inode *ip, __be64 *buf,
 				goto fail;
 			BUG_ON(extlen < 1);
 			bh = gfs2_meta_ra(ip->i_gl, dblock, extlen);
+			if (!bh) {
+				error = -EIO;
+				goto fail;
+			}
 		} else {
 			error = gfs2_meta_read(ip->i_gl, dblock, DIO_WAIT, 0, &bh);
 			if (error)
diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index 616c46aa3434ae6ad84d10d678ca3f6dbe9492f5..e39754e08f44d67b460a47744f4276cd168e356c 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -48,6 +48,8 @@ int gfs2_replay_read_block(struct gfs2_jdesc *jd, unsigned int blk,
 	}
 
 	*bh = gfs2_meta_ra(gl, dblock, extlen);
+	if (!*bh)
+		error = -EIO;
 
 	return error;
 }

-- 
2.47.3


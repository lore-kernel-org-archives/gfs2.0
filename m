Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7629C3BD63D;
	Tue,  8 Sep 2026 21:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788902142; cv=none; b=rmC5Y3Jwz/6BoMgBvBR+vemK7RHm+A5XxfiU/C9nNfnmvt9YNQpFBSGcNuq8n/Y7XnX3FjxSrSfT8AJHSN7nyc9XPMIfIJKmR4Ndzldhd+AmFFyCknbT337l3/PUxetsW83gbWn8bLLNTH4RuESvW6N3rlGwt7/atWA+2kmsAMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788902142; c=relaxed/simple;
	bh=vkhWUoBhWrW6zJlh/7xLTXWXKhiD2O9KWVbZSpBNu4U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oELkO6xMKndbEOGqrgnBS9EFuGlTg9L22qayLR7dPZIY5UeD5ja4Y62WgdbqX9anWaT+f1Pq10n3uYN18zloJJbk3c2K7dU9LN0CMambSrhD88Q7QHc2g6UKjiS/aPka8vKXmD6rK20CTndhI6YtmmqFuyBdAZiP7ul3HTpVng4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Iuv/jwGu; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Iuv/jwGu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:From:Reply-To;
	bh=Mo11TwzfI+J7GjZdxnyjFSrOK6Xwcxu5buC/Zzefqq4=; b=Iuv/jwGuNpj/vTge6iqs+FjM+e
	Fx1Sk17Yr9VcAaPPNzG5I+4jdZLuWi1EB5PCZAKSIhfdvbztlgSXYAh4FHW/IJVSo9P0Sd1QBiBZC
	kLEvIzmxLsBqqqb2gu5DN5r3I6r9XkLPpMMZMNvTmAj852hJnAup708hkLMt/H0+qG7oqBj9QMvUR
	FiLa6bFXvItK6kiBuy+gY205bjYbBZIP3YMOeLZKGeWqML+o6YqZWXy+tGN2Cyys/Sv+7AaKtqADr
	ckVDw9ljlrBnsFVID+DOOiauQSwcELmzz4YMABn8Iov47wfUhFJ1Y7YU9E2uU/xYB/LIPo8gWwZa+
	/wuyepxQ==;
Received: from 186-249-150-254.shared.desktop.com.br ([186.249.150.254] helo=[127.0.1.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1x43AG-00GhZP-Qa; Tue, 08 Sep 2026 23:15:37 +0200
From: Mauricio Faria de Oliveira <mfo@igalia.com>
Subject: [PATCH 0/5] gfs2: handle errors from __filemap_get_folio() with
 FGP_CREAT in gfs2_getbuf() and its caller chain
Date: Tue, 08 Sep 2026 18:16:11 -0300
Message-Id: <20260908-gfs2_getbuf-error-checks-v1-0-7c59698f178f@igalia.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABt7oGoC/x3MQQrCMBBG4auUWTuQBpHUq4hIHP+kg9CWGVuE0
 rsbXH6L93ZymMLp2u1k2NR1nhr6U0cy5qmC9dVMMcRLGELiWjw+Kj7PtTDMZmMZIW9npJKGHFI
 WOVPLF0PR7399ux/HDwaf21RqAAAA
X-Change-ID: 20260908-gfs2_getbuf-error-checks-e8f89a08acc4
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: kernel-dev@igalia.com, gfs2@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Mauricio Faria de Oliveira <mfo@igalia.com>
X-Mailer: b4 0.14.2

Currently, gfs2_getbuf() will hit a kernel oops for dereferencing an error
pointer if __filemap_get_folio() with FGP_CREAT fails, eg ERR_PTR(-ENOMEM),
as there is no error handling in this case.

The code and documentation in filemap.c and pagemap.h show that it indeed
may fail, and other callers in the kernel check for errors with FGP_CREAT.

This series adds such error handling in gfs2_getbuf() and its caller chain.

Tested with fstests on v7.3-rc1. It "Failed 51 out 788 tests" consistently,
plus one (different) flaky test on ~10 runs before and after this series.

Thanks,

Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>
---
Mauricio Faria de Oliveira (5):
      gfs2: handle errors from __filemap_get_folio() with FGP_CREAT in gfs2_getbuf()
      gfs2: handle NULL return value in callers of gfs2_getbuf() with CREATE
      gfs2: handle NULL return value in callers of gfs2_meta_new()
      gfs2: handle NULL return value in callers of gfs2_meta_ra()
      gfs2: check for errors from filemap_get_folio() in gfs2_jhead_process_page()

 fs/gfs2/bmap.c     | 27 +++++++++++++++++++--------
 fs/gfs2/dir.c      |  8 ++++++++
 fs/gfs2/inode.c    | 20 +++++++++++++++-----
 fs/gfs2/lops.c     | 31 ++++++++++++++++++++++++++-----
 fs/gfs2/meta_io.c  | 30 +++++++++++++++++++++++-------
 fs/gfs2/recovery.c |  2 ++
 fs/gfs2/xattr.c    |  6 ++++++
 7 files changed, 99 insertions(+), 25 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260908-gfs2_getbuf-error-checks-e8f89a08acc4

Best regards,
-- 
Mauricio Faria de Oliveira <mfo@igalia.com>


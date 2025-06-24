Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88E6257444
	for <gfs2@lists.linux.dev>; Tue, 24 Jun 2025 02:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731801; cv=none; b=qi419kxoeDlf5jjpfNahdYfwohIrxrvFVrIyb8IwUo7HlNMOn4KGfGCR/glQQr03eWZNkOVPV5uxgGFYo3zJkKDJIYiB7frVm04SHhlimyeL4i4UiBKmA2MVN2v4276P/Y7rZAVb1LfDju+KwuwwuhxwEDQZcX2+ihxxpYNwy1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731801; c=relaxed/simple;
	bh=NXvJXV7hV5VX1A3DbVPlfuB+DQXi7Ai0ttTfd/GgEBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRxtBFQohVi2rVn5ZksdzBpj+9K9hF5ZzYSlzHfIDLsem5PidB13H+DOQCx6iUyubHwDQmLfIm1dNk0j8iypYYkN0NIMeTSjh63spghSa190vq/Z6x6ScEiJKgjqYxFA/vnWN3CcvnYU2/GOFhohNnwEKV5xhg/s6YufW1ZHQJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3kSf8jw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3kSf8jw"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-236470b2dceso50332385ad.0
        for <gfs2@lists.linux.dev>; Mon, 23 Jun 2025 19:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750731799; x=1751336599; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vS9enxGE4scyhOnl0jCRmBaC3QtnFwkaoENIefu8KUc=;
        b=f3kSf8jwJ6zfJdbAFfVqYkh5psm9iIcjB4DlkPicyzbSVsNEC9jQ7s1WxEETbAsh5r
         54FbyDO8AnBKQSBd5i8fWF8wYtGimxiVoz3tQAoh3LzSgg1hLUBpv/wPVFeV568rtAF7
         r4O13znJwMyM/97Go3MQTxnv7kNV+EqhTYR47IsiUBINlT2y/socA/L/TLNbMok9TPJa
         OYLV8KquI9muYJSLMSOMZjW+Ow0CjmqCVFbfgR96QeXInBGnDQ3D+qyBF7REJY58ZYHm
         lx4JvybV59LTy+Z88G5HzaeA8UrUPeU4gfGJKdeIjrrlMemCXyxaEUsVCTxZoAUji4Qf
         hZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750731799; x=1751336599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vS9enxGE4scyhOnl0jCRmBaC3QtnFwkaoENIefu8KUc=;
        b=uQltg4Bv+6HzUbjXXpsOlEVlFHRtFfy/ybP6QxsQrr8BhykVdsWLdC0JnK79L3k8SA
         xUC0E9yd0RVEnZPr5Q4vCpSiQCkFav6nMpfq1om8h+HZ0Zlm2dqG+2PlFEwoUw047iUx
         guvtxEQsOBBljFANTXB9uk9tWRJgSiPZYDhdDcCmo07bi65ZoQ+2vEZfw7RvrxO60MvS
         gvgRtLhxfmeZG/CPHm/2vkVtBLWSu7NsD2+ZTU9Z8pNOBEsHe4zpdBVwiWdyvJxZSlvX
         OOqc5gUGasndGVkrsQQIq9e3juIumOAM1gyZCfQypdJk3UytSw3m0G+ApRCSkF1Jt4nK
         DxzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNV5uR5F+HcSWxWtk5Ih3oKEJi0Pn5Lqb2tKrT7szp71VUniTjY7W5FwqB5kqPYPyEiykm@lists.linux.dev
X-Gm-Message-State: AOJu0Ywqn5rhlmzFdCq7b+YFUfmvJjXWCcYzVmH2l02wIQEuRiOo/19W
	i47xeSWtdmd9BiE6Os6gNl2AKIMPwsif9YOpbffecFGqyUgrl8tX3m9P
X-Gm-Gg: ASbGncvNzDvIlMpnCMjQtDdleiya5qUVj7A1rqwfA7YVmfVV4ypp3nA0bdbL1Wve5ES
	5U/i4hAWJI9Xh9mn024RMTs5prlbfTN1kRczvdIDVOtETpFPecTgnMTWvw+JLaHeqPOB+T8WCA4
	4MCLLmoBPBdTuqtk7t0YF13NPJ4OmSCSaoXJVuqh0GrvkmoaHdmSOGiGIDN79tk45CRVVnICRSU
	9AVMYekRpwVc3w0Nr4qOE41hRDpSswboH1PiF8rkdBxtC7XYyjfFndp5dtr7hyjhoapDyDXZ+47
	SrzZL7c+O2mD/bXSe0VxIzv8GdMeEuDvt3c3RaFnxN4ND/QxMrywSR/D/A==
X-Google-Smtp-Source: AGHT+IHHN3NdI6A3Tl2/yAf+aHNuymc0kUa5+C9+HT99bCU5TJxjq+SW6ZDmi5lIXml65nLdWimKwQ==
X-Received: by 2002:a17:902:e544:b0:236:748f:541a with SMTP id d9443c01a7336-237d95a285amr209985895ad.0.1750731799044;
        Mon, 23 Jun 2025 19:23:19 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d867b438sm93975805ad.176.2025.06.23.19.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:23:18 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@lst.de,
	miklos@szeredi.hu,
	brauner@kernel.org,
	djwong@kernel.org,
	anuj20.g@samsung.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	kernel-team@meta.com
Subject: [PATCH v3 15/16] fuse: hook into iomap for invalidating and checking partial uptodateness
Date: Mon, 23 Jun 2025 19:21:34 -0700
Message-ID: <20250624022135.832899-16-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250624022135.832899-1-joannelkoong@gmail.com>
References: <20250624022135.832899-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hook into iomap_invalidate_folio() so that if the entire folio is being
invalidated during truncation, the dirty state is cleared and the folio
doesn't get written back. As well the folio's corresponding ifs struct
will get freed.

Hook into iomap_is_partially_uptodate() since iomap tracks uptodateness
granularly when it does buffered writes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 35ecc03c0c48..865d04b8ef31 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3109,6 +3109,8 @@ static const struct address_space_operations fuse_file_aops  = {
 	.launder_folio	= fuse_launder_folio,
 	.dirty_folio	= iomap_dirty_folio,
 	.release_folio	= iomap_release_folio,
+	.invalidate_folio = iomap_invalidate_folio,
+	.is_partially_uptodate = iomap_is_partially_uptodate,
 	.migrate_folio	= filemap_migrate_folio,
 	.bmap		= fuse_bmap,
 	.direct_IO	= fuse_direct_IO,
-- 
2.47.1


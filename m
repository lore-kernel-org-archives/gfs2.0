Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E2120C472
	for <gfs2@lists.linux.dev>; Wed, 12 Mar 2025 08:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741768389; cv=none; b=UbIkuJ6tv9bWzpLZ79SS2s9Sx2E+UF4zBjgHTsKjSLK93EMkSYkA+ONMLEnyyoXWhO43n9FMM8RSB143fR0UU/44gQPw7N50jGNxC/1IAZTtEHtmGokUedeL9KJoCV/TGteVfL8aTWxD59Cm6cTn7UR/b/i3UhSGjVX7kiQwySA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741768389; c=relaxed/simple;
	bh=pSo5vTjN3OF9dYBlqCsRbrqAPdXDHi9h8WPbDq3JzfU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QkYNghBwzAmg/yD8aOigqfstpMx5aJZXoLxzU5vOiuuFV8xGTHwoYjEaWYIuDASufs0I6PiemfcNnJ0X4BhxPg88YbGxcfEAAUgJTgzhW7MwogQHwCRxKJ4xCSRqypMZVWO18BtbqLtccd+RTY2rNj6ROrgo/e09lvpmt6bnyLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g6fK7tY/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g6fK7tY/"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-390f5f48eafso3112030f8f.0
        for <gfs2@lists.linux.dev>; Wed, 12 Mar 2025 01:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741768386; x=1742373186; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hk846ocqbbU4c/o0fjWpAAvlpyCOyvBrM2NRYSxeofk=;
        b=g6fK7tY/bMkhHoZVwAV4gPwAdFlxOaJO5o7t3GRV7OGryQNdNZmQOAuRhRX1ikLfz/
         DIMG1qJL5eqV8fx9rUjhfKBZbroc+d88BFtTOCLCPkolFYjPOkHqADLl9/ZFzqYLMhUD
         eyGBbjPWTiIR34wzBuFdrZSmLHR5RzMd4sWdpgtwuWC9fQIo06dw10aGmYs2YgB2HbVE
         1bmgflYrIJfvjKZ5klnVeodq0GpxQ3hQJeO0XKD++tldkkI1q3RcKhGT1wWXqmeR3dIx
         RIwDxv7Re6PS/YI824H0//QgVqFJptuRmDYQBM7iywbfjZpfPub7CbHwWmKD+eX9Ks/m
         hDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741768386; x=1742373186;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hk846ocqbbU4c/o0fjWpAAvlpyCOyvBrM2NRYSxeofk=;
        b=qLFIk8w8g2ytIF+IIN0yK8lUul3fn4znK5IbiZdbtMPqxno1jDqifayIO7pvyu3LNb
         o6i5F/RqZrwl5o3Cg62wC+j/C/feJOLITxh4H8BhktEJD0XSP3xIvK6iKk3EyVcVHPDg
         pVNatF4cPkNdqiUq4neukoZ/i17Fh+PXxaXB3TcgqKYm6ObnKiBgLMgvMLx3k0c5M0ib
         jw0Qoyb3uuEKYKaoJOnk5/FgF1APeRCjmgFUlyBlJJPZrxm2IdL2FoRO1nwAJiNl7nrv
         29mhEJMDr36Cs1R+99ub9r0rcO95QMrllklM8nOeO8u4MxlDVwhvO190Q851PXdGjm8n
         vupw==
X-Forwarded-Encrypted: i=1; AJvYcCWlr2Ajq66iIQ4NwSCyy3EMZpxGEMiL6BO31y5F3egSsbXYyf9xF7uc3CRt/X09JqCSDoXR@lists.linux.dev
X-Gm-Message-State: AOJu0YxPjMkPYMdrQfreZluelBpN7//7T2Et6C5fijvSrKyXKLsEbHzz
	Dh6C73MyxgzCA7XC7Brmsb8AtgxdQtaaLwr/q9RWB3oh1nfv8tIq7XOCtdiJkFY=
X-Gm-Gg: ASbGnctaj4ShXxOruVD7YLRZlMa+1AG0CB+bjaC4KUQ0i3KXkvClbZyyoqrQhjfTUCl
	DgBQr6VuisOAGWEBqBrniISqrn3fCrt8Tpg1e1w5Mpd0vBuvf3E3CSqlCYwFFCc1S3XDbSslBym
	qydYb3wMKi7ujj6LQwrvnVLZIJIN5h+YJqawRQJa3ZhdRxqhW5C5DA2sp0GjQs7UO3oipth/dkX
	7AULOwKAbFiIzwAjWnbMxHc9/L5rTqKYwHhhh1rtyc26x1lRexEOoJtGvGS4ijg5QcS7d+sq9bC
	+B1roMfC2shEQJje8oOykZ4N9BUoJCtuGNHsOmNnp+s1/tzG4g==
X-Google-Smtp-Source: AGHT+IH+soUGCO6EN3L3810VPuOet5YZmw+fbN4JVDjX2iJDlZI1jlgA7rGnGm4yrtxgN9st0ie6UQ==
X-Received: by 2002:a05:6000:156e:b0:391:3d97:bd33 with SMTP id ffacd0b85a97d-3913d97be31mr13299968f8f.13.1741768386394;
        Wed, 12 Mar 2025 01:33:06 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912bfdfde7sm20820827f8f.32.2025.03.12.01.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 01:33:05 -0700 (PDT)
Date: Wed, 12 Mar 2025 11:33:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] gfs2: Fix a NULL vs IS_ERR() bug in gfs2_find_jhead()
Message-ID: <ed5089eb-fb83-4c69-9835-dd64735b8a73@stanley.mountain>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The filemap_grab_folio() function doesn't return NULL, it returns error
pointers.  Fix the check to match.

Fixes: 40829760096d ("gfs2: Convert gfs2_find_jhead() to use a folio")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/gfs2/lops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 3853c422040b..0fd3b5ec7d8c 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -530,8 +530,8 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs2_log_header_host *head,
 			if (!folio) {
 				folio = filemap_grab_folio(mapping,
 						block >> shift);
-				if (!folio) {
-					ret = -ENOMEM;
+				if (IS_ERR(folio)) {
+					ret = PTR_ERR(folio);
 					done = true;
 					goto out;
 				}
-- 
2.47.2


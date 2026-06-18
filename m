Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351D32B9BA
	for <gfs2@lists.linux.dev>; Fri, 19 Jun 2026 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781875954; cv=none; b=bwNcRi39hwmwFmrzZXLPV/yCmwmtk6R05NmV24+Zm0wPXZChyTlf+DeWlwByluZ1ycDkOHXFJEjpuXo7r3uH3I/Qjpl8sO/Y2YhPYAbSXYY+ZBbE4n/13YCzhxkYOVMwW7myaXqLjFVqeCSA85ZTWbC/BxNpoR51m5Wc9IRV5QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781875954; c=relaxed/simple;
	bh=dLVjHyDNmpYHyBk+/j8+WzzxiA6EiAPBFqt1c0LoxmE=;
	h=Message-ID:From:Date:Subject:To:Cc; b=UyCnX3nndK//ARSDbccUWH1yTtFNSaVIibXTjCE/MVxQMe4r08d19MUdFKsTgBWZfb29WBDRV7n7VF5tZOcCqQzjXQX5DdpxDN7BEZesrAfzhxVltOMNBOV/xhNO3ON8munSoH7Ti3rl3oh0fRUpsJNSGt/JSYJaXxHj/dN1GyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rq3K0Wiy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rq3K0Wiy"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49222fb062bso20449725e9.1
        for <gfs2@lists.linux.dev>; Fri, 19 Jun 2026 06:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781875952; x=1782480752; darn=lists.linux.dev;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKk9cepu7FKId8ax6fXhL0fM1h4Cl6Axiwfpy9vr3cs=;
        b=Rq3K0WiyhHdpP+cTUZ+gb6RSV5dPeVPyqpwhxbOypVUg5L+Op5Io82LMvb7eCVIKuL
         tCfwjZI0EsxLbLrel4VV4PcQCFGM2pbwS4M592oSRGB3mrbIZHA6dJy93/E1fZbbblqO
         RCLXNNqXKc2MArQssUb3Ts0wzg/lso1EhDlYplg4iGtClU/hFJmxuX8Z+vqrwsZ/Ou/+
         6nIDs5a3wgvTyl9uuDX/KnYjYK/xvhXLkqaxpb+Cbh2tY/dIq0le0YqXiSBQQsNHRLou
         LorWrMVjqtt/AT5jjLjadVwYsXT8zrBXUNg3C9aSUumpZy1aPiEO57FaTO9SkzbtgoKg
         Oadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781875952; x=1782480752;
        h=cc:to:subject:date:from:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MKk9cepu7FKId8ax6fXhL0fM1h4Cl6Axiwfpy9vr3cs=;
        b=fXvzvFd0+483YDQ93ihbuhksMWqKrkQUwcK2rD5qZyBwu1K2nwLeE2PJk6ESCgIFr/
         bQ/a44Pj2LH8UlsF3vrPR54LS42qRFDKyc0eCe1+viEzbPG8W1Qy8sTjldRtdKtjCQ7l
         7ZERoxlETTI2/dN2OkJtfsrbp1deJniFf999lUkgEcT9qek89WM30mUx0KVIzz2UFySm
         qrx4Np0tGVir2vhnqEOcZjzn+FcmpMb2GqvD6OuSh8XngFsfbAnr4/qoScA0UMZbA6y8
         OCgtjJFy+Xk/9wGcPxDSVeLr5kOtzrX+HjGLgg5ttj7vlsiobKupUqZIaZUZ+V6BChko
         bhdA==
X-Gm-Message-State: AOJu0YwBjYkZWIYkJJJoyQaZ3pv7equQMddQznq3PswWXczvBOmbuUOm
	m/X7Al756Hr8/SCZ8JGeOEBQPxfwLBOgAA8Oq4TQwe54W0FJsHPiHOMwgmQsdYxr
X-Gm-Gg: AfdE7clCNb6gu9nLba+X9NHqVlSkBk3id91uPRx67ElzHeDu3MVyR0AvNopJbckwwEG
	zzGxo8BKovDqLoyi/qIzCCJYnWEkzMuqCKkBCXtHWlIqGhJw9gjAfDxfRF8bMiTgS8MxOzVz8TX
	dhwWI9K/0mQFF4PR4bV+eEEkg5OaF7mCwsjhCj477+63qH/9nhNMuk0+uZcOiBNiKRR1bEyHni5
	N4KSULcgniFNKxuMB92qnEZC/N4AqvSMYxiz304cV1JtRyDISUPyro4BPKiIY8amP7Vk+W4Drrc
	fJHRUgtT7IwDCUmMOGAYIfg2L1UFsyQI7YjQMY+xQ/f3BEd1oN8p3yaPdgkCyMRZDrG31tORMWo
	/aSDc4vhf+N/hpROTZFVhZn/60OxlXIJEkcU5iRZvmIopFsyamQR4awYvw4qmprCh7Ga5WEwxwz
	16z2iLbtu0cyJllAHrXuW4D9o+rzAX8pMTEHWNB4O5Iw==
X-Received: by 2002:a05:600c:8a8:b0:492:2100:aba2 with SMTP id 5b1f17b1804b1-49240e23c84mr37252575e9.4.1781875951384;
        Fri, 19 Jun 2026 06:32:31 -0700 (PDT)
Received: from parche_gfs2.eml ([171.22.87.68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fcd91b2sm75018995e9.3.2026.06.19.06.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 06:32:30 -0700 (PDT)
Message-ID: <6a3544ee.74ea883c.60ac1.8c70@mx.google.com>
From: Adrian <adriangarciacasado42@gmail.com>
Date: Thu, 18 Jun 2026 15:56:26 +0200
Subject: [PATCH] gfs2: add missing __rcu annotation to i_gl in incore.h
To: gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>

Signed-off-by: Adrian <adriangarciacasado42@gmail.com>
---
 fs/gfs2/incore.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index 614657778..16df75336 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -392,7 +392,7 @@ struct gfs2_inode {
 	u64 i_generation;
 	u64 i_eattr;
 	unsigned long i_flags;		/* GIF_... */
-	struct gfs2_glock *i_gl;
+	struct gfs2_glock __rcu *i_gl;
 	struct gfs2_holder i_iopen_gh;
 	struct gfs2_qadata *i_qadata; /* quota allocation data */
 	struct gfs2_holder i_rgd_gh;
-- 
2.47.3



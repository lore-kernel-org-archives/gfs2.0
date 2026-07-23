Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B4F339386
	for <gfs2@lists.linux.dev>; Thu, 23 Jul 2026 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828760; cv=none; b=cWuvtYv6+z/DdzjWTZPDhGIGzNgYDr5YChOdkPTKCDZeSTJNlQNFG37ZK5HqV93hm6M/mqyhYuLeNSeGYmJz6VJjMiuSh1Kns0IO5Qi4nx494QWrkth3uqebJnoj4NSj44BvwUwa5iHbEhW0AQFNhqJVCEdXc98i2CWdx/4m+FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828760; c=relaxed/simple;
	bh=fl/FOGqYobiKDUNccpI+Pf+dJvrY236pC8iJt+0oyS0=;
	h=Message-ID:From:Date:Subject:To:Cc; b=UMW2obCJDuSIAkbUmsLx7ccxZ/bjV9uJTJQifK66Yopc45lJMfMFUASngQAQumxgMEE8hoNC1yEReBnF2iEpsEePcx85xkJyVZB0xZ2XwsHw9zYRzakVRQt+tobzImxniXmnjZxc6SnUJCQYf2yOfQW4Y25QMlXiGjREw6sapOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfE8acb8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfE8acb8"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493f6de72faso6426765e9.0
        for <gfs2@lists.linux.dev>; Thu, 23 Jul 2026 10:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784828757; x=1785433557; darn=lists.linux.dev;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EoEf6SKJZR0m2wcWdEcK528rlss2au1PBz6HySzO+OY=;
        b=CfE8acb8Dwqkj2Bf7pFJWxK0D5nvm9CEzWVXXSu5YgwHcBMsPk7gQafMVNbUtStNnw
         7G/1jlOWMDTPJGJBC3ndqkpRrgFYC1jbdTiiANmTGCuoocWrRiBC2ATSc77YRAw3AGle
         QLbX90vua7TWIseZ1jhBmLhsOjf3Esnm+NFfjl2ZYRIeETXTN+/JBqBlINMdSMqsGTOT
         4I38ylqzJk5LrV0WOgJeLdoh8ccriKPbpPgzabV//eV6GnqURPac0qF5p9UWI2XBvZY9
         hw+nrW+gTMfNJ4BRNgsQgukr5rFodeFFtDe+fB8DBkjTbldd6Nyw+1S3xKGLwEURwUiJ
         L9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784828757; x=1785433557;
        h=cc:to:subject:date:from:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EoEf6SKJZR0m2wcWdEcK528rlss2au1PBz6HySzO+OY=;
        b=HlZGxkXCvryp4fHsBYdhoPteDiMzxjpKTMrO9wtf/OgAfwEzQC4tehQ4+APE5gfd2J
         67/i6IlzwozEBO6MwBwm2bvrXWxBr/9nOPo5F33Sg3h2E4ZH1ycyY+C0YB2HKVY0z5dY
         AvSGuDtvQdpYbrey82HtF2fGK3JUAbtdxojWKe2zxHx/bz8RBF2SUHD78sMwKIcTBgUR
         GL1ZqnPDaGwrWrc3I0eg+EmNH/edOO+TNxSZJvB2u8N6qzBrKbxdQPxRvyhXJW2gGXE0
         v7BHwxaHD3qE150oDSXKoYw07IM4UPHxLm6os/JjbnRIRceNJS4lc9Q9c3LEo4TWk8Cc
         K9nA==
X-Gm-Message-State: AOJu0Yw8/uSulFc6xQmQ56hTfllB6tEZGI7hexCqzU06Xv+nl9odpAyj
	fWFwbl/aVzT8bOJQEYv55/SYhgk2gQ6pMkgLW+Gqru2MWtDxUy7xxGOgXkhNQOpBtEQ=
X-Gm-Gg: AR+sD13/hBLRyBW58ik9hdKKKVLmxeBAFD4UPQhhOzZfUxf/rspyGYegoYLx+CIsS0j
	A/7baxQgj0RdHNt9JRylMKapW0vzTmfx2h0BMdMkiErAkQ04FZCt3hgcLh+bRukeo9/rjtaYWFZ
	7B3MYhRQJfvuJm1eAbmWArgTp3YkdI6vnr3+rDwht0uaHWh4N9QraFOahFNOkYgG46VsKREW9zf
	aLpwOo8z4GcHJCwKU9YIYdxrHLO9e2Qr7NvNIsP7XxMYXAQvaY+KRpLXcn1ODgbT0yzUJUbs+kS
	3ME4IbT1p/yCZM2yFu/XoYnQTMS8RCJ31AkhISL657ZmHU7/c0L60yME2euVPJAJcWdi94ha6MP
	nxbYvTNS4CzDMy776qBksR3EvVYOm4MRyW7Stu62uJAvkbX/ZGFYkJSFbvad0ZQaqPknHyUD3aN
	lrOTqujVFUfP/hBwnC8Bg=
X-Received: by 2002:a05:600c:3041:b0:495:501a:fcf8 with SMTP id 5b1f17b1804b1-4957459b978mr29089055e9.9.1784828757035;
        Thu, 23 Jul 2026 10:45:57 -0700 (PDT)
Received: from parche_gfs2.eml ([171.22.87.132])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957af16f72sm11435155e9.0.2026.07.23.10.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:45:56 -0700 (PDT)
Message-ID: <6a625354.5dfca4bd.1b689f.2446@mx.google.com>
From: Adrian Garcia Casado <adriangarciacasado42@gmail.com>
Date: Thu, 23 Jul 2026 19:44:47 +0200
Subject: [PATCH] gfs2: add missing __rcu annotation to i_gl in incore.h
To: gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
    agruenba@redhat.com
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>

Signed-off-by: Adrian Garcia Casado <adriangarciacasado42@gmail.com>
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



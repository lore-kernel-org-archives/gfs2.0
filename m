Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079B53644A3
	for <gfs2@lists.linux.dev>; Sat, 12 Sep 2026 06:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789194382; cv=none; b=aCwRQMvzIKiN/F3EF9Tq/IKeF0XjyQRHWDPzE+aL8+7d6s3nR2BRynE8qVTpvlxPRQfimm9qGCGg6k6hO/W0srGkkEmsth1iwJWTuoDBtoh6jhS9JUijIJeB1Rg0w26YyjEwGyRAwciKKeriH8duZiEY1aVr8g78+QWBx6UzjUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789194382; c=relaxed/simple;
	bh=4+N7cdDhN3844Z1q8z+zFikbwV4LBr5lVJ1YjHeeoFs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g+B5lNAGYGfqCCuoj58Cb++V0GJDzISylL2vveEmc/FbZ0SUqtkgjdDYvA3b3Ea+EzBBU/OFXpZpXeMpUDk5STUQfzQ/TncfrJEVFLHbebbxZ+0glamCP5eMJd+4ESlKmaIbiIlapfbJlPTTjxEp5RrHASd1FO8erGyWsz1D9fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMsDVhm3; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMsDVhm3"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso2499725e9.1
        for <gfs2@lists.linux.dev>; Fri, 11 Sep 2026 23:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789194379; x=1789799179; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ztIntik1xeW8jWQz7bcwpnWQ4yK2/dDMrcPOzey+VHE=;
        b=cMsDVhm3nH9K+Z4OvgEPInpEoT6ZZH2kkf3vj0SiWcJ/sQcXDigYn4iJqixpphvClz
         /tOrxOKxh6YXA+GXDFdYD6stqCalBemPDHVm0jC/VVa000zVCUTKXleD/LkS3OF4CoNz
         ysq87mGYLNxxw/icnMf1nMZz9ML/OzRaVNh07741wkxQTOo5UJ4GYMA2p88h9wp7ykMH
         0GI8zXNg5YpPDHTCVVlIYGrqC0vHNPgaAHiXcQ2CBAAfKM/kj5jgfr56Hf4MMX58Zg83
         Ma0cV2VhqqXBHuZcxWrRoc2bgWE/OLj9yPuuIpvDDKmdi0jJdtmFLVGuZGEtAaJZq2x4
         kbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789194379; x=1789799179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ztIntik1xeW8jWQz7bcwpnWQ4yK2/dDMrcPOzey+VHE=;
        b=GSujc+HR+jQDPDt8Q3prvJsnytQUyOsQLo9G2hMQ1G8LuE9mMBNHw6wIoOM9UJ6rUL
         pNFhn5AU8qncI0Ec6o2I9Ze3zoeioj5SKQy8ptyOTWPNE80GR00KwcjWHb09p8MLhk+/
         Q0RRjXNAzBtkoX/S6435Qi/S4ZgwCCvDuHacYY2/SyHRBX0Et5ZDzfEJ84N1JfKA6gOg
         vA/lVkuirOZuX1Ka64Cl1LZNzQaTtUzaGw5XA0xGcLyucuJ4bJke0LXNMPDpkOaalsqN
         jRAQoKKFdXQ0BHHLxUc44u0RcfnCFR1yPBMyOcuvBc9M99PJyUkXo2avZUVjTvXzl4mC
         Drig==
X-Forwarded-Encrypted: i=1; AKwUvBwzJP+j94tCc2Kaqt6M6KZgcvKngowQkoNGcmLu0nz/MhQJZnptmGDhvIeAQnHEzVfVefXC@lists.linux.dev
X-Gm-Message-State: AFuF++ltqlXR2VbNNnw0yc5kMCngd78qbpWAmX9RoIWW8pCR9XxeCb/r
	uQzuD9q6WGv9Qe4IkLzgp2VrJiv4bVcWEPWrdSdzSNIKMMjOSjlzwQ6o
X-Gm-Gg: AYBFou2XdlXLVSCv/0RnhTRBzwo7A0V7KiI8zxUIc3jsmKr2+mFJ+ugCiBTjsCeOjt/
	6SRAiMqKK7graEZ8S9hjV37BKK/Hx5ViEEBYgUlLcUd0BTr+Dwnhxj1UIE9mzpfqf/y018SeG5V
	dU4uBLI9LFI+NPxNei57/wriqX7iDT5GP4mJD4V1VThumhM2z5VWMLGIV6/knajJEQjTmKVanMd
	0xgYLGWz2e/YlHocIHTNEj/Fb27WATEpVdxjMshxc4CxU5tmzo9GLhgfGi2OXVDIInAmey6YBjs
	O/Ax47JlrI/XfFjEWkcIg+D38T9KQpvzKRAEJMzUkmiIF8vyR6dEbpw1yIcRqNXQ3h4IQl443K0
	YDJKKGaYKLn22DqW8X4NuFJY03hhAo3jMnW2aqI6nJngpZt20FY2IHLrcZKlhdwJXW+8p52dsE0
	SO3uuTsV0EfTUBcygGqHXMrbCo4pWZhIzjXWxrV91Xg7JmgucuVLVLmR0XvYpzNzkFcU0OInRqf
	4loA2ObIpsEIdoGe74W7YKeBvJxY8QOnlJnj/kb4rBNA1qnmdL7mAQlqJtJMmUYQGseWyrW4x62
	Z63UTkuedy3jIe8xrdAhkj1K7QGg391Hj+9gFp0Z/Z7ptpD5KiQytJU/L9PDvhxunHsmTZd2OTG
	56g==
X-Received: by 2002:a05:600c:190b:b0:49c:dada:30b7 with SMTP id 5b1f17b1804b1-49e6caa6f6bmr12779215e9.2.1789194379075;
        Fri, 11 Sep 2026 23:26:19 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b260-f201-9983-e8c4-aff5-7a36.310.pool.telefonica.de. [2a02:3100:b260:f201:9983:e8c4:aff5:7a36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60adaeefsm130212965e9.12.2026.09.11.23.26.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 11 Sep 2026 23:26:18 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] gfs2: Fix the return value in gfs2_get_link() kernel-doc
Date: Sat, 12 Sep 2026 08:26:14 +0200
Message-Id: <20260912062614.42899-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gfs2_get_link() returns the link target or an error pointer, but its
kernel-doc still describes an integer status. The mismatch dates back to
the change in its predecessor's follow_link calling convention.

Describe the returned pointer and error value.

Fixes: 680baacbca69 ("new ->follow_link() and ->put_link() calling conventions")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 fs/gfs2/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index f361876c5583353a1196ed35be1c95af33a90c02..d5e03ec89127254654dceaff56322ed617a3400a 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1900,7 +1900,7 @@ static int gfs2_rename2(struct mnt_idmap *idmap, struct inode *odir,
  *
  * This can handle symlinks of any size.
  *
- * Returns: 0 on success or error code
+ * Returns: the link target on success, an ERR_PTR() on failure
  */
 
 static const char *gfs2_get_link(struct dentry *dentry,
-- 
2.39.5 (Apple Git-154)


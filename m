Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B64B41F34C
	for <gfs2@lists.linux.dev>; Sun,  6 Sep 2026 08:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788682110; cv=none; b=BQG5BrnqYh9RqwvUoiwrvIxRjpX0XX+Umx1rk0bxhiVvH/APx/V87/KcAeKdccNMqePONeGf1mlI7tf8Roe8YsGkH1No/ryJTCLlROYKaa/1RmW6fOYFPXrT+++GwcwOQYXQw87TJ1czu8UX3fzu254225G75XCzT+DSTpmPaiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788682110; c=relaxed/simple;
	bh=NGzEwkpI7KGONMiDBGgzyRVO0pyFXtozl5zfOCBSjdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E3zz709NTCZu/aX3lE5bWNqgXR6YyQc0XBpIECqSBXddTUhJwezK5FIeQI6LfKXCizhMlVHqOpIhTTiyUlm02/tK631q8rWIqjZlLNhmWG0tW2yQNBqQ0zqUAh92sTftqzUtTwAQvMAyquIblnyIk2rtrFYp5GF//pQvpM6GTFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rasJDIri; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rasJDIri"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d91ff7d9acso20688075ad.3
        for <gfs2@lists.linux.dev>; Sun, 06 Sep 2026 01:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788682109; x=1789286909; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WqSPCtWUh7C6nv6WkXebRXj9+vzaBfle2tuzZHkfoh4=;
        b=rasJDIriEeGCgzVsx51OOR8UzltDr78p9F/TCknQvLiojeW2SfVuBwraiu4/J2yw4q
         WdskiunzEM99Zs3SC+nB3heJm5GroJAjSfTLG/L0Uxxvs/vMDDzqI7EB+oO+jd1ZtVJL
         HjTb7QAdyI2fZ6Yaa3ZNhSLn82hC3vtpYrFThXat48/9gpuIzJJrSRj3j+Jenv3RhbP7
         uf2nFm7O3njnoXr8kcid0o4rVfs0r++FuFceQ1yolbfPAci7Wh6bUKmGZl7/gpKySefz
         xqLzAZyRnoTFbuW0yw9hBPOIZmOH5WY+1YksGVz3uyICl8bwUu+RJifrfPg8HJ27u2yV
         VJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788682109; x=1789286909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WqSPCtWUh7C6nv6WkXebRXj9+vzaBfle2tuzZHkfoh4=;
        b=qOCeiUafoEqfZP8PdYP0eXweVo68NV0Ov+S3GeKgRb017D1dPWq7+LoA0JRq2NA6L8
         o6ydnuZZKAh8Chcb3lDA+9Cu4Mum6HjNAxzZK1+76iiWnyCNQTOuySr/toy52ONCtmo+
         3sCnshUXVrW/8DiWfE9wI2h9bi14pxpsp+IU0ONO1a1bcxW0pRt4iIl9mMMDmDQ9PCc3
         QCsJ+9ESj9+pdrrGyk7Hf1+62MHL9HOEa1omggJmF0bJQ5Ywbrz+ljjyIK836qDRSZnZ
         YsdNHi9Cj8DeYclMU7fIJ7oy4vJitlUbuclJXo/uXI6ylknW97GlVd+DwlssseUsSUxV
         OCJA==
X-Gm-Message-State: AFuF++kV6TawQgXufPj9ow+JATGnD+Orct6rCWNcN9Ua7VTXd2CNk9KC
	31cMQ3IMsJjITASCt/ZgIoVLQCDVLqthW0c28pX6fkpugokeDiDCVDVo
X-Gm-Gg: AYBFou3UBgkHcmKReB98bnTZQEjIVJ3o96+fKqEKAPCx6YXAdKpj1AdPCUutuV0yYFX
	5TMg5iBLSrpzoF9rEhsZO+n41QCFk99IzIC40c4wbmFhxVTrLUWVn+DzBkVVe9DIa17EwTHtCcR
	SbnYjkYWVP8yiN96UDSjOKyZZ2JPPUUJTrk9httWg7yNKhd1R3zBZ18lotyonPmRxCKsvUG7vlR
	sT5Qqpq4EJwebhXgupSoTEa3bZK7tZHw5HU4nFZQtQmuUemAEmIA84TSv6wQVYpzFXaakbqRbVK
	xItrkwYMME0WPZPLgUCM4uds9GUYLojeGJEfXeq2s2hfoptxsgRecwjI8Yv1mh/PJ6SnMNsm5Iy
	39cpn2rHAaaNWYGTJam7dMx6Gj5XrYUKQEKW/IQqyu1pA5PxwN8KumzkrLs/kwccebeqRI0XkmS
	Y2xplj1jIans4OyDLd/0IubO2M9LBUhbMzOYlJutHZlkssoPnXICaiMNrD/XOD4hgAraDzMr/yh
	vw1fb9dOmBuHYFNSVo=
X-Received: by 2002:a17:90b:3b52:b0:38f:18f9:785 with SMTP id 98e67ed59e1d1-39b26101d25mr24779812a91.8.1788682108610;
        Sun, 06 Sep 2026 01:08:28 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d38:5c70:7bb9:b8bf:8aa8:fb0d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08cacbb0sm20207422a91.13.2026.09.06.01.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 01:08:28 -0700 (PDT)
From: ThangNN99 <ngocthang2710.1999@gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev,
	ThangNN99 <ngocthang2710.1999@gmail.com>,
	syzbot+d84e35a320d14f8c270a@syzkaller.appspotmail.com
Subject: [PATCH] gfs2: fix NULL deref in gfs2_quota_lock() for meta inodes
Date: Sun,  6 Sep 2026 15:08:21 +0700
Message-ID: <20260906080821.24403-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gfs2_quota_hold() now treats a meta/system inode's NULL i_qadata as
success, but gfs2_quota_lock() still dereferences it unconditionally
afterwards. Bail out early when there is nothing to lock.

Reported-by: syzbot+d84e35a320d14f8c270a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d84e35a320d14f8c270a
Fixes: 0025112796287599dc79c822ed37124582a0d68a ("gfs2: No quotas for meta inodes")
Signed-off-by: ThangNN99 <ngocthang2710.1999@gmail.com>
---
 fs/gfs2/quota.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 3bbe5c78c793..0c7ea7375f6c 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -1100,6 +1100,9 @@ int gfs2_quota_lock(struct gfs2_inode *ip, kuid_t uid, kgid_t gid)
 	error = gfs2_quota_hold(ip, uid, gid);
 	if (error)
 		return error;
+	/* Meta inodes never get quota data (see gfs2_qa_get()); nothing to lock. */
+	if (!ip->i_qadata)
+		return 0;

 	sort(ip->i_qadata->qa_qd, ip->i_qadata->qa_qd_num,
 	     sizeof(struct gfs2_quota_data *), sort_qd, NULL);
--
2.43.0

Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3403C063F
	for <gfs2@lists.linux.dev>; Tue, 30 Jun 2026 09:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782813595; cv=none; b=NHRDl4YDHg1Ko11jhSvgnsuz0lMLiZ2lmGL9V5baPJu7Fy8+pRH1//MDIJv3Fzl8YTIPGXqDveUW0xfqi7+w+arbkfQLi5IYs0lELMqgIJTP3CwmLBPWYbSL+kcYHfm9+LwKP4FIkBMNi0xDeNacJ+AQyY5206wyyDZjkFkHPh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782813595; c=relaxed/simple;
	bh=4UErpMtU6C50B+8xUMZwa9JPIAFrrvY9Ovb6uuXTv10=;
	h=Message-ID:From:To:Cc:Subject:Date; b=aeNSI6MGUFO2chjil+WZxB+ZpBGhhwppqH/iLnW1l2jbSOVnhrTSY79CoxXfIVZyXuI0Ts30+1eh+Y/hRWe/yFnX+9KmKpphqgbX2PxEvlXx7K56zgmvc2ahd/iWFJhBua0Vc1mX8UuRmyL7qjs3ojRBJHcGsSNmCNgd4XjrIK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Buq+V70H; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Buq+V70H"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-46ed4f66256so3423006f8f.3
        for <gfs2@lists.linux.dev>; Tue, 30 Jun 2026 02:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782813592; x=1783418392; darn=lists.linux.dev;
        h=date:subject:cc:to:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rwbt4sA20/2rfBe59aV1e6bH46u3U8Si3wH+ZxMQUl0=;
        b=Buq+V70HoKMR6lFaTyuHxX6iE18OY6yvyRernOqD92iZ8b8i28RMx17nRBvCaFxLxc
         lENWoqJgxIjXq31lqCJXumo/xALqh0uKaaBw6Z3MgUNRzf/I+yRKJLL96IaE476ruPIC
         yqO2OdmWMGW9YwwfHBaE/jodBEGbnhjwUNzKGtX24olxFNf8IsRfUHx/L3re9Uk7b2Gq
         lignya+c6x85e9Jed2nXOPM96Z68PQP3o/kVRwn1LgVhdH+4dLdyGqCelws8K/3sQAZw
         5yhSYrW0Mk5BQG3OAxrG5oZN3OusiWbFBUUQvIle1UnP1G8hycOMeTHLf/iQ2du5u2Kg
         SjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782813592; x=1783418392;
        h=date:subject:cc:to:from:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rwbt4sA20/2rfBe59aV1e6bH46u3U8Si3wH+ZxMQUl0=;
        b=TD5V0WWdmNVwZIAr7lHkUhMKnSUwNtZ4Vj8CyQ7YHxHJbUl7V5MFioy0LPTYND6dPV
         zB9pzk5T9KSmSE8JeFPj0J6n1OITmXoxzKfmdR+bqGzNCyDdKxML0r+CFepNEH+eXdz2
         Z5mq7gH6OTlhtoHsnOm7MAdJZawbZNqLRRK5eN2Ukj5N2hVehVUgnEsFtg837RhxGbZt
         3sIoChrFn4msNsXR77kzUkdJ2mime2Z9SdRzZ1ewdb/VCwKeYcektSaw9yrIrfBuLogb
         cJqMFmmfK9SSvWQ5h22o6eFR2ZqNqud6i9tqxNGVoBobVut8YyqbAzrUYwLP3owesQn9
         /Ofw==
X-Gm-Message-State: AOJu0Ywv/S9o9R3ElykPFOUy8nHs5V5dt0V+7yY5Fbnutah9fXMeRET2
	Dt1PBcdAetvIwY0rp8vUv668W2ifiG2O4ObUjkfFpL303udYr/0snsheO5+UVSm4nMc=
X-Gm-Gg: AfdE7cnCkNjL9hjZR+ZgUKEqueVswRnrDAmzlQOTOFuyYJ1wo4MB4llO80zIWQYRoDW
	7+j1UNQbBequCmsXxjxEuqEgMou+7IJ5/yT48dGaKsVFHgFIoJquwywlKAl58sEIbuM+5LzAEnh
	0G4lptRFX+qukVxdRfPUkuWIn1MutsJEpAlNK8fDlHBvNfrcu2a9GlBjT00Wqcq2ZaJGlLyvvnc
	b2VfQOTz85haHN3eOpwOgccLep61UnzbjyqYkLHDVq/BXnh65msASCT8KGQo61y6MRgsjnIeoIY
	z4cZ7lQixPxAglMK4/zXJcJ2s7XPQZd0PsdjVWLUT2cPkr0Lf3jX+DyOnn9MgsyGHBe6OpfeLXA
	3RMUqAxoNPTbnVqybXzG0MYXi1y4/wYjaFnfTqgdV+BlyUfm98yGou1QFJTZouR5WuOBE17pyjI
	PB0yW7acPCip5lGLj8iLw+KQ3G6Igb1g==
X-Received: by 2002:a05:6000:469b:b0:46f:f12b:e44b with SMTP id ffacd0b85a97d-475530281b5mr3048385f8f.31.1782813592287;
        Tue, 30 Jun 2026 02:59:52 -0700 (PDT)
Received: from gfs2_rcu.patch ([171.22.87.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4659sm6577230f8f.12.2026.06.30.02.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 02:59:51 -0700 (PDT)
Message-ID: <6a439397.39c9bec7.125ac1.2db8@mx.google.com>
From: Adrian Garcia Casado <adriangarciacasado42@gmail.com>
To: gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, rpeterso@redhat.com, agruenba@redhat.com
Subject: [PATCH] gfs2: add missing __rcu annotation to i_gl in incore.h
Date: Tue, 30 Jun 2026 11:55:00 +0200
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>

In gfs2_inode_lookup() and other parts of the GFS2 filesystem,
ip->i_gl is accessed and dereferenced via RCU helpers like
rcu_dereference_check() and rcu_access_pointer(). However, the
actual i_gl pointer in struct gfs2_inode was never annotated
with __rcu in incore.h.

This missing annotation causes Sparse to throw multiple
"incompatible types in comparison expression (different address spaces)"
warnings and compilation-blocking errors under strict static analysis builds.

Fix this by adding the __rcu annotation to i_gl in struct gfs2_inode.

Signed-off-by: Adrian Garcia Casado <adriangarciacasado42@gmail.com>
Tested-by: Adrian Garcia Casado <adriangarciacasado42@gmail.com>
---

diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index 6146577..16df753 100644
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


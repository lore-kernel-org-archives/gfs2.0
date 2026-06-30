Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF98291C10
	for <gfs2@lists.linux.dev>; Tue, 30 Jun 2026 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782813817; cv=none; b=Y1dlorefeSuipO92Xqq68IpwBnxCnbczC3Gkx/qRFcDJekYTkEtCu/Fyeg6hJizDHbXtfnHzLY7G8aG92Pm4tYXwh4+WiFdhzOeYverr5RR3m1e5TcoMg+GmjB6KwJlpZWCumrhH1y67K7fdXvIUsz5lRvXQ8xxXvT1AO9KKZ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782813817; c=relaxed/simple;
	bh=4UErpMtU6C50B+8xUMZwa9JPIAFrrvY9Ovb6uuXTv10=;
	h=Message-ID:From:To:Cc:Subject:Date; b=XOHlqR6rTlG9Ua0LvhhxhyWXDAV5XQ+pZcS8CK/t3t0Vh+mvNVRTZDBfAR9p+MJ1uTosdYvJT8sq4p8B/RUG44276zsqWr3mKVTrvS4O2s/WjrL7AojMECHtwmjwkKc0Ppw3d/zOh3UnhwlV0xd32jdlNZc3rjtdRT97qtjTWOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlnNM9hy; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlnNM9hy"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-475cb71a4ebso368209f8f.0
        for <gfs2@lists.linux.dev>; Tue, 30 Jun 2026 03:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782813813; x=1783418613; darn=lists.linux.dev;
        h=date:subject:cc:to:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rwbt4sA20/2rfBe59aV1e6bH46u3U8Si3wH+ZxMQUl0=;
        b=mlnNM9hyxa6j35+WFK8haRGp2qY/brD3J56YCydN45DOen8ycp9B5+/y333TffqZSI
         NV6jvvXZltq/PORgbOJsUug8enAq1uPTdeykwqyrP2i6xQQHijTat34DhZxqNvJ0xHK7
         CEeVwIWeiC5Vuio1Vtsdga10nDtiXLDsE7XxLAgoH/c+yDlxqIwi4lXEsabosQ3wD6Od
         s5GTM4ZDTc2Q/U/nU4rDSMCrq75T2HcTCOkJcVMTLtE5zh8tMlJyuBOhq0Vfd7B6XwnV
         npDn+yGhvUzMkUNBlsMxVwni8UMdUHMynBRn+44PP85K3H06yPYl1T7ImY6FuYMlW4uD
         Lmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782813813; x=1783418613;
        h=date:subject:cc:to:from:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rwbt4sA20/2rfBe59aV1e6bH46u3U8Si3wH+ZxMQUl0=;
        b=hIrZoSw5hKVzK8ioBuEeoAXDX4xPEi8A9RAd+V2rhnf/khOV6U7W0G5pp6wwf52EgL
         FcXFVa20T8bKpfdQNjgN3PZ0Xf/1t1wDw69Ja0ZINusKatyFHQHJuZwujavGt486vTVN
         kx6tiyedzYfX6xvegKMAz25q8dYtCb5Qc5AuQPWZyh7DT3rlVVQUIBdNn4YDpbZxRtiS
         972Ezm0Z/28smrvhX2FZwGzL7GkXl/UF2zuE6i4GZ+th2mRCXLOoJuqpVTOiIcu+xZTB
         Z/azrh+cFd3TsseGY1P0MxIkh/j7nFfkTcIF+6ZZo1ujy8bBkWDyODc4sWykiFHH2QhB
         2Fow==
X-Gm-Message-State: AOJu0YygTzF5bvzKxNmjvLp4gFMtC2apDeasena4LTwPlq3kKsAv9wM1
	bPlL/Or28vjC/PCSkw1I+dI4PmDfUhEofoSow6ha3p3XLNDCfKeAaeGXQA7gTu24x0k=
X-Gm-Gg: AfdE7cmD4OfqoZeKCC84xoGxj4TOzJ/pO8Eul10GlAG1zHoZ6QNAxS4BZGXyWhiuJ+8
	+Qcp0Y+5escKON4OIDQnu8ID8zWLQZkychJsAUliOw5DTRiW/Qsmk5op6o1kTlYbJuY/y48NnUl
	6j14bI8NgWNfXDNjTTJRj2D5mAhCisSl7nlfOGL6kzugGWgoG7Z68kkvd1pv4jixk9QkBco7Wcb
	hDD5mqtTsZE/VY03b4xRyHFFDTHn7VrF0x6C1Y4i9j8hOO6HbZZi1/AgJGySjNxamnzX3gN2XUE
	Fs3hKm2cDCv8YauEmYtvn4BrDELOVy4KEVJMjv63Y71812wMgY2z7wHRr/SCOuVkuel22kafBeU
	1nxcZowkcgLRkBcCWVAxyK/zMFuuePfRCgAwQbryrFl24TvQ28LUS91uD/+uJsYGDlVXNbyea09
	+WTNdJRRUOR7WobHFWarM+uc8vRwRyzw==
X-Received: by 2002:a05:6000:2990:20b0:472:fe1a:1ee9 with SMTP id ffacd0b85a97d-475507deee8mr2932337f8f.20.1782813812959;
        Tue, 30 Jun 2026 03:03:32 -0700 (PDT)
Received: from gfs2_rcu.patch ([171.22.87.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47567979eafsm6152888f8f.34.2026.06.30.03.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 03:03:32 -0700 (PDT)
Message-ID: <6a439474.4d70c427.9c655.9b2d@mx.google.com>
From: Adrian Garcia Casado <adriangarciacasado42@gmail.com>
To: gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, agruenba@redhat.com
Subject: [PATCH] gfs2: add missing __rcu annotation to i_gl in incore.h
Date: Tue, 30 Jun 2026 12:02:00 +0200
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


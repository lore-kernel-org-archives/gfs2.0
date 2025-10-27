Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31A4224B0D
	for <gfs2@lists.linux.dev>; Mon, 27 Oct 2025 11:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761562870; cv=none; b=rgCuIgeJlaL5zA8FAk8aMgserSRqS4qYZlk4JCe0doXLnQ4BFGCY3HwafifIzx1k+bnQB5SqVMv2E7QCj7HeIVLhXs3OL1lUVZO+Cjco08DYpEtxrv32jYTQysglw0a1r1Le9RziTBF2Sor6JA9xAlMaKph+l2glnI2UGLLWmHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761562870; c=relaxed/simple;
	bh=fNSzNH2cea0S6vu+yLc0ygMmMw+DbuZTdNE+lEpxMBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BJf15aduwcfQWiQwQl7T94YHuT4n90ARLNxP2v4IQc/Oo8g6cTBGdyqD1TrV22iDcy/Y6SAY29pfkrDawKshRYS1ZKBn0LThj5fKfoHGioOrURMukhEdnvsBfAhRMrxak8+PgaT+G9ugCO4rIVjO9OLzHsYd69PwFRYdUDtTLUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEl8eeFF; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEl8eeFF"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b6cf1a95273so3285391a12.1
        for <gfs2@lists.linux.dev>; Mon, 27 Oct 2025 04:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761562867; x=1762167667; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6YCUXrqBln9X0KLH2R8ZL8iELcmm08jEAaIpjSJG/28=;
        b=MEl8eeFFPxJOnx90wN7uFrYVE0ktz/7x8xmwoy9WqED/YBI0QVUPhuKyErx1Bo0pwa
         rv6We/KURv0poAEiN6MDr7aGAG/EFlsFcHBAPX2Udfrj8L/pii7/PLOUxvn04SwM6mc0
         4OsGjJXGRaN68F8+3QXVWDA9JM2cCmtF960ouv5LAcpmlnyOgU6DHB5BBemflUJZzQUd
         nM1COa0dQy8XO45R0VwpdZAtyUrI+LIY/fyDTkbg3OScUs0/w/uGt3FS13BWEZZGt2Es
         wswu3pr6ecoti1sMY3fot4PcTFAMQzwz4ksGTAeN8Tlv+ThyhQg5RplKuHfhGw3eYA/Y
         7dTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761562867; x=1762167667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6YCUXrqBln9X0KLH2R8ZL8iELcmm08jEAaIpjSJG/28=;
        b=sm0HXNwTY/CLlswy3lGf1dgMwei2g4LdwcklpjfQNLTb5qXffNHdtu0GGtO26M5kGh
         rToqQDli1RF9W4vAEsIoD7rWp3QyjPRZy+ZPrxQiJea8Ei9i2oBzYM63u8ETrvf5/oMh
         +heCPMI+4AZ6FP3f+p9Tj3oLP4g4j0MgjLkOCOJnPuNSKXKLukF3pdQuERu/pjdboCDk
         +UjzhdLe3mCW8ndffUrlgBdOBJcKPkEq2JGFm8aQ8YguLgEEhEodJeP5TbKa0lU/pHH0
         f3fudEuES9SssQ2nifkJf5Gq6Zk0JtBLKXa6/XttRcP83TLQALXOe0WL2KbyXIaQUarE
         MyFg==
X-Forwarded-Encrypted: i=1; AJvYcCWf6x4b363fXShjYOdw8qZ1+L3WPeTUH9Hc0LnWMsJrKGDSNqXL3a3nAjpSr3xaz1PKqXos@lists.linux.dev
X-Gm-Message-State: AOJu0YzUK/wUl4cCJ0MW8Nyg/pKSYmHhpuImJFb3K3ccK5AUfGwOiO/5
	5cD3UCU3cC51vXNYwoHXFHRGiJWGvQ0Ds9nT5jIrVuKcRbMxjGjam5MK
X-Gm-Gg: ASbGncuWUbjeiP+MACgahOrlHnHvy/x1DQXNancJaWtn7TJoWufyKalqv9RRCZehn35
	C2EAqaSs8zi0lEt0zKONjlJCxjyu6tgXn973IJgFUnvrsjNz25hg7e8rxc8ZEn9OYwcVaQQHB3f
	9ZLlikIFdoUvCw+tB3u4sEX9iqhR4WTVGgX5SCtNK1X1HO6f02wu4TfsDGMNrjp+n6LjvLyl0B4
	Y0zS6O8QI+l3MFN/9hkBCvCnlevS8bhsNZn4aDX3qWe26KkLjBIyE5WhiXMQUm7FtZhgRz4BhCU
	O5nhJfV01NNxPYjdrJGYM00A0BZFcPgPxG27O2yV1KDcDeSPFC7EJ7daT0v1TTfWCTF2QbCCAv5
	G1AW2Zh9sx3xpiVAjbnzEZsdBq3o5l6iZuH7JIWmI7SCBEN3zJyKtzrPj8LCbUWDpAl0ePTyM
X-Google-Smtp-Source: AGHT+IHL+n9BswPUU/oHfhmEaW00Mk2l89+YrF7PxELyUmd2/Z/ecgzlueG9NX53az0bLz4lfUZx8Q==
X-Received: by 2002:a17:903:298c:b0:27e:eabd:4b41 with SMTP id d9443c01a7336-290c9c89eabmr442795985ad.7.1761562866909;
        Mon, 27 Oct 2025 04:01:06 -0700 (PDT)
Received: from hsukr3.. ([2405:201:d019:4872:e28f:8b98:990a:8261])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e540csm8111162a91.13.2025.10.27.04.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 04:01:06 -0700 (PDT)
From: Sukrut Heroorkar <hsukrut3@gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>,
	Bob Peterson <rpeterso@redhat.com>,
	gfs2@lists.linux.dev (open list:GFS2 FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: shuah@kernel.org,
	david.hunter.linux@gmail.com,
	Sukrut Heroorkar <hsukrut3@gmail.com>
Subject: [PATCH] gfs2: document ip in __gfs2_holder_init kernel-doc comment
Date: Mon, 27 Oct 2025 16:30:41 +0530
Message-ID: <20251027110041.426022-1-hsukrut3@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building with W=1 reports:
Warning: fs/gfs2/glock.c:1248 function parameter 'ip' not described
in '__gfs2_holder_init'

The ip parameter was added when __gfs2_holder_init started saving the
gfs2_glock_nq_init caller's return address to gh_ip. This makes it
easier to backtrack which holder took the lock. Document @ip to silence
this warning.

Fixes: b016d9a84abd ("gfs2: Save ip from gfs2_glock_nq_init")
Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
---
 fs/gfs2/glock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 91d0afec4087..bc6f236b899c 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1163,7 +1163,7 @@ int gfs2_glock_get(struct gfs2_sbd *sdp, u64 number,
  * @state: the state we're requesting
  * @flags: the modifier flags
  * @gh: the holder structure
- *
+ * @ip: caller's return address for debugging
  */
 
 void __gfs2_holder_init(struct gfs2_glock *gl, unsigned int state, u16 flags,
-- 
2.43.0


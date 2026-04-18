Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B6A35FF6E
	for <gfs2@lists.linux.dev>; Sat, 18 Apr 2026 13:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776517868; cv=none; b=sapAxgG1b88Jfd8GtNtCVHRUJEw361mzvADocMNDmI2VlzB3cjAftJOxykMGP36SSO01r2/RrkIA17mSVwN9XEYOHCIVhQWjqa6jixhMq29h16sTqZbE7L7HFwAeS2rw4fW8gtSHczdMnfUv/wstN8iehhYwQFXxW6eW/rEAe8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776517868; c=relaxed/simple;
	bh=+xkPi3Ts+vZPFs6LV6P2y7SlqE1SPgnlAU7DIjbAE+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HFgwG8IBm01Q3QE4VgNdGc82NRi3LLS7yw1P1jaA0HHbNIDkge3mgHzKDmPEjWlmubuTu5GJQZza8QBytHWb+kDrd2J2JsVv2ve97ByVRYNigFOWeNjYiKDGW+si7eW6VWRf2+WEESltg8ch/DD+6nRSA149K1zsEvfKlaFbLZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goZcNswm; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goZcNswm"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4887ca8e529so11468515e9.0
        for <gfs2@lists.linux.dev>; Sat, 18 Apr 2026 06:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776517865; x=1777122665; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qy9Y3Izl0t2648U+SRfDngw68zD0TyRucNL5CZqQfL4=;
        b=goZcNswmlee0zBtVMVczvWvT9BJ/WMD/Eg0/Tlt40m8Ljwg95gC8aUeFVUN3KqP5Qo
         BkiFNCDVT9cwfiM/xg2HqPGo8pTJHCUSqBJ6+runmRUGWr9bzUv9KaaUTltn7/2a+LtS
         BqM9jUgbi2pg/hue/7MG6vvF4MeFqYLFwUGj3VFWxF6iz3px52kxUDcry0/EvI48PsqF
         cyooZIB/SUFoOyEa87gr+Gg2RO6w9qw2pMn3wfn7QUwgCFjoif7YL9GJWMNltfu6YyYO
         qUXBQkDg6o3IWCk77jn+36VvN11ODuNkcGWoYESqeneE+g8TTQXrJkLFju7x381/wwpv
         12XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776517865; x=1777122665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qy9Y3Izl0t2648U+SRfDngw68zD0TyRucNL5CZqQfL4=;
        b=Kz9VAk9NjOuhlda/3XwasMANVHqjBGbG2sH9UxRNKRciIVk/k0G6SIbXI17jwkPIDz
         AlrX0Sq0DrLVLE96J7ZqxKi1BnbEeLi4dgENowgHDYrFNhdo3VHrF5c33PpBIjoc+C4O
         +ZB1HPRFMSFx79ewMu0WRMdfQ8AmKPsLe9THEWuJPSduvqNpPYCWlHQ7Sfzs+wtAbQl4
         j7newdb8yxbdIIWLS9n8ZrUFRPFkIy3cJIAQLP9H3R+akw6XYe3Q6dLewvd7Hv6P+AkN
         qeIwkxMWnSddejXctL9j6U+5ZAN6l97dwFfkB4iaL+tJoi4+9jEqlqH4Dz4MTI1uZQbH
         Y2Zg==
X-Gm-Message-State: AOJu0Yx3fbJG4yvPJKaqNqOEPRjX0iOeAtYSYV2mnDQyW+W/VAujt7gF
	y3JZRQaRL7MIx3yv8Xtqstf+OFjec1OH1M4n+KUNAU6xHBVs4887bi8nTqf27q0=
X-Gm-Gg: AeBDieuTOaNxy4+I3vqE+wWHuGSZ/k2ffbj/7a8iBQ/EfXIZ3FEParglClQrlenLwyb
	I6KhPx1tfHi0tM0DgcDa0A9LYmPNK2sD733QF6oP1Mm2XBlMOA2TLX3TXZgvucgTD6IrD8fSEMB
	B2R/3frWXWoNUa40Lm3F1csUyqiNkSfbGYzqzWRO1AZYyJniTckHcOfX7TVd8jgFrwaiUa6VE0p
	KpPiEvk0Zj9sAu8brtRANWaE+uFXfUv8nK+qMjRFKoI26pdbquxmVdfpfUn4Rd78c8YrHL2GEd1
	PP8ERA/O0uExsQKRpCnQ7mzXyd8E/zDBS4zgjf2kRtfpelfO1r8KXSzLq06CMKHb7d1Ho+SC3en
	6+geKIUPZABc72sqU2IA/p99v4JjRzsPozwrNHcNtN/fTr3IrSywmovhXyMemf+LB5rn8uoZcOB
	f+xgQ=
X-Received: by 2002:a05:600c:6089:b0:487:22ad:403e with SMTP id 5b1f17b1804b1-488fb8ba594mr86850415e9.14.1776517864809;
        Sat, 18 Apr 2026 06:11:04 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4c221cdsm13191103f8f.0.2026.04.18.06.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 06:11:04 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+3e2c95229d1ab81a0bfd@syzkaller.appspotmail.com
Subject: [PATCH] gfs2: replace WARN_ON_ONCE with fs_warn in rgblk_free
Date: Sat, 18 Apr 2026 13:11:03 +0000
Message-ID: <20260418131103.1058618-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

rgblk_free() triggers WARN_ON_ONCE when gfs2_rbm_from_block() fails
due to a block number outside the resource group bounds. This can be
triggered by a corrupted filesystem image, causing unnecessary kernel
warnings.

Replace WARN_ON_ONCE with fs_warn() to provide a more informative
diagnostic message while avoiding the kernel warning.

Reported-by: syzbot+3e2c95229d1ab81a0bfd@syzkaller.appspotmail.com
Fixes: 5b924ae2b7b4 ("GFS2: fix rgrp end rounding problem for bsize < page size")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 fs/gfs2/rgrp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index 26d6c1eea5591..7707c1b1082f8 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -2266,8 +2266,11 @@ static void rgblk_free(struct gfs2_sbd *sdp, struct gfs2_rgrpd *rgd,
 	struct gfs2_bitmap *bi, *bi_prev = NULL;
 
 	rbm.rgd = rgd;
-	if (WARN_ON_ONCE(gfs2_rbm_from_block(&rbm, bstart)))
+	if (gfs2_rbm_from_block(&rbm, bstart)) {
+		fs_warn(sdp, "rgblk_free: block %llu outside rgrp\n",
+			(unsigned long long)bstart);
 		return;
+	}
 	while (blen--) {
 		bi = rbm_bi(&rbm);
 		if (bi != bi_prev) {
-- 
2.47.3


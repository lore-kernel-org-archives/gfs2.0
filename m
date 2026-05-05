Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DDE283FCF
	for <gfs2@lists.linux.dev>; Tue,  5 May 2026 22:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778020406; cv=none; b=K1E9f84QxJ/ql9MB4P9bpIUT1ikWAK5kTNnnr6FZ0KlNdZvvLdnqUCP72ojBdr/KOwb8kuTMporl1v1U1e8kcNcBxiPJeOtN1ppyMSG179peFjxc5vTzyL8y2YbU5Y9426AgG3DMTWelV1s8QNl6GxIoqFEQu2HZ4JqECF58TGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778020406; c=relaxed/simple;
	bh=dRVUCxsT6DJmW+pmYVJSArVrvoJMu/3shlvB+b7KlVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dh8ZAlMOSViYMrWunrGuiPQgQnHzxP8qMYV8Jzu6acB+tPMCwNpR7kAYegoVP6qH4oiv7vpa7QPjICAr9fC02XZdMxr78hjruT4i5H1Jf9vt+bZygCCICTzW4nevkaYvOqOLiiCg4Akx6u8NZaVXVxgIeRdLzNkx0nF22e5SpgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkzC41FC; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkzC41FC"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38e7d983f79so59688941fa.0
        for <gfs2@lists.linux.dev>; Tue, 05 May 2026 15:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778020403; x=1778625203; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/QQ/AZq6dN6XWq2wBEVOP982dVF7mCAGe15xpN9wlKI=;
        b=hkzC41FCNpAGB9v9hXHN4kkSItx61qvS8DZUVT0ZryX0upnh64lpvlF6mSSxswKlIQ
         N1Nnhbdev+cjIwOioVYgA8v9MnVyInLp9mGhgJ0IjJphurVyKjjcmWPNKHKeEyYSOXxr
         y4eh2DycQjgo2JkoVBh3FYEGauSSNHjWwKeeGwknhBk+FLCNw9ynmmk20xBpncBFU5Ky
         dtW1cFn/43X3TBmutfmPhHmWv0M46znhd1679VGUZ6NnVN2fikUYNLzRPxcCXDzh2Cu7
         gMcXS84Nd3njxgOgPaCb+EL+g43YWZUvAO01V5JMU6EMkvh45QQIUhu49iws8h2OSSBN
         NwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778020403; x=1778625203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QQ/AZq6dN6XWq2wBEVOP982dVF7mCAGe15xpN9wlKI=;
        b=rKVPDEfP4EEH6rmLKdEg7uceAq+huWbUW+40R3VNfhkQNgKaXuMdWu2U2iJ5pLT8g3
         j5ErL7xNIyvO3zUVbSf/Ay0tCkF8AnPZvop/yrImUcmxQD7jXRj3NAJevDgPb/bhuXlf
         RokthVgqQs6P+nJSRJ3nUCQgr/ztaCViHZAmm5zIBSUiDnrcSsoLiDLTbZzMJwno1GYK
         GadbOxMV+XbQHSNXqkfrfR5r66/4/XdooePFXAT7ttNCGz9dl7a+x3/rqU4KNwjfYV0t
         LoafoSnT5XzezJauURtfKET9ccnP2ahV4wLi2h0GF26UxbrxPOTc70I/InJ51TsMrYJa
         yyYg==
X-Gm-Message-State: AOJu0Yz73zEsL+lgWitBDbcsepfx/f/bCfZhGHCP+ZrdzFdf3T7dnNAv
	0qFtvIR3LdieA/I4ELFh6xTs/eCo18/EOYYzVqDguQr2s0aC29dr4HJ1JOK0OObC
X-Gm-Gg: AeBDiesr65rjp8vuGlu0p2dKS4TsksCtbewky6PA6PMoFqNUSxNTVWo3iIWHPgcJy+c
	Vhf4OQi9QvgJxbTvMdWq2THDcUYXCPgmMO4+u8bnNdLeFvt4Tt21jmt5uNsKXw/bcjeI8sIWK3+
	JLEQyuOvCMEtHWbO+IrGhhQGyKj9Jtu/huZsn44Y4Y+pTyu5BjPjsQTaQkudjJWjqkE5ScjQ4vR
	9zCsybnaVa1uEAxFNzNIUa3uCpJ1HeBRKWHudiVZWaMggS0juQH2p3hawF7Czz2Ih4M935DZbsH
	/0gedqkXY/w/Djnu95Cii8uFU2rGZ1N+TSVsEpigipKSB34J9GsJrWT+Pb5O06H93bHqgT7SLAT
	RXbCCGaeBLhb3PrISUBIsCP7Z1k23OhAVocu2tcJiGpmncnU5ge42pUAOnxkH09UO/gZ/RpUxly
	R+l0Jn4taO+erSsxDWNkqhYeTPbVHvQe3gPm2nqg2H2jPOrcaevuyXyJ+HLd4g+EwysypBsYDuB
	0pK2A==
X-Received: by 2002:a05:651c:420a:b0:38a:902:dcd with SMTP id 38308e7fff4ca-393c41e252dmr3042351fa.20.1778020402483;
        Tue, 05 May 2026 15:33:22 -0700 (PDT)
Received: from Shofiq.home (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39361356c5csm44604321fa.36.2026.05.05.15.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 15:33:21 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: gfs2@lists.linux.dev
Cc: agruenba@redhat.com,
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH] fs: gfs2: Fix typos in comments
Date: Wed,  6 May 2026 01:33:19 +0300
Message-ID: <20260505223319.5661-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistake in comments:
 - occured -> occurred (twice)
---
 fs/gfs2/lock_dlm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index 7828ad0b6..563bb90a3 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -434,7 +434,7 @@ static void gdlm_cancel(struct gfs2_glock *gl)
  * 10. gfs2_control sets control_lock lvb = new gen + bits for failed jids
  * 12. gfs2_recover does journal recoveries for failed jids identified above
  * 14. gfs2_control clears control_lock lvb bits for recovered jids
- * 15. gfs2_control checks if recover_block == recover_start (step 3 occured
+ * 15. gfs2_control checks if recover_block == recover_start (step 3 occurred
  *     again) then do nothing, otherwise if recover_start > recover_block
  *     then clear BLOCK_LOCKS.
  *
@@ -812,7 +812,7 @@ static void gfs2_control_func(struct work_struct *work)
 
 	/*
 	 * No more jid bits set in lvb, all recovery is done, unblock locks
-	 * (unless a new recover_prep callback has occured blocking locks
+	 * (unless a new recover_prep callback has occurred blocking locks
 	 * again while working above)
 	 */
 
-- 
2.51.1


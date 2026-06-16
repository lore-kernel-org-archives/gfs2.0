Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2593BFAE2
	for <gfs2@lists.linux.dev>; Tue, 16 Jun 2026 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622238; cv=none; b=EtICJI+U/lhmqnSRji6TKYVls440Oy26xa9wXTc/abwrf42Ivlr4koGxNW6c3QwMFFYffzeRb5SrA2Ff8lCgY8v3dNX2Su2U2MRrSO4pyBJjlpENo36xxBS4Bc4BMsrB0wTatlLd/hORC56lxlVVMBuy+QE1b/d+apQol2X/SwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622238; c=relaxed/simple;
	bh=zmckEySf1bnjvXLe1y8S3JJ1K511ztr3Ub59I4P4nRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FAKdrHfFpOyCVsaF1qwb7Xg95gmgdYUrfOWsDRAc+rh1mFBUfRonSAeCg7WSgVu8BKoYOBeuHlIlZpsYLtbqJ8SPY4A0g0KSBJs31mOHulcAi9PSW6Iao4DqDmSvkmKMytkFc8tk4LPG842Ue3J8mw8U/XGAC/w6whgfO5Rl4ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wn6Hp6kl; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wn6Hp6kl"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aa7a7ad4d3so4102294e87.1
        for <gfs2@lists.linux.dev>; Tue, 16 Jun 2026 08:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781622235; x=1782227035; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ArrqTfPT5xZYsqejdLAgeANpi6axW0WX5h4i9zN84Ks=;
        b=Wn6Hp6kl8CH2w0RqVXjkV556Wcu25eii/zpHGXIxcWqXtIQtcNX+y15c8Z4TJEvXtg
         gy1WkK/iUN784jeAYzgLLOXFi9tz1Bh/vko75CMzelDXSACBcoKJKM9A35YMT9wu+pfF
         itZ4CDgC/T7pxqTu6f1RH7FF3OFUn9URyis28KOsoEKncmtm+qgEW/sWzePJuj95LzEJ
         jyP1CShfTXN79YiO7cYlK4VsFPzii5cdQfNkq7AmTOWQ7/UqWG0Mt5MzCliVkqVvzckb
         3Xq92mdsV2Z4gSizkkDtsKtmxSDQuhzcyWTYtth2kbsVt+MYxbuktwtYmgbZgHB67OYV
         fFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781622235; x=1782227035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArrqTfPT5xZYsqejdLAgeANpi6axW0WX5h4i9zN84Ks=;
        b=L//ZjIkR8QfpJ35LqLlB9LoT4mBMKjL+6XhmZlgSQIC2GEqJXVdoFX77DbplTHCbjG
         UynkrAabldpTi5lKApqNRi723G59s9kcqzH5za6ONHDLNCTnl4LULjCb4mq7auTgnYQf
         TZrSRzzdMfKAQ2HoT+ruOq9JKxOtn52CzN6oboPxwqoyT3C3Qf9cYiZU2dckgIb7rif7
         pw7BBeJ8i8pwYfTQ2krhuwnzykAYZBotrxRiw5TJxZvaVw4FW/DIEuHOdw5r34ikAKr2
         7yRAxkfjj/OXwy5jGYRXvSimeOXYEAM+OLvA6i1+IY5YYJfMP8m3DoOW2g3S5pW3DFo1
         oB0Q==
X-Forwarded-Encrypted: i=1; AFNElJ953s286kQfQs5LIzlAdvGcP0oEPSiF3iCshrnzMGV3MC9Kh+cauTgFnfzj2J4AdgvEmU8K@lists.linux.dev
X-Gm-Message-State: AOJu0YxAQTDvjL4fleXJzeaFMwo4TlLT1NsvX14ffXEYCha4lGABmqi3
	M+i8Xs95JUrNwT96DiF18WXB2W+AR6Xk/wy8EH5i4wemhkXAnei+hvDV
X-Gm-Gg: Acq92OHqV32O2gHuWSF0xZJF3Cbj+YRO6uBiGxogRGHKo4KvOZIv/BMwtber5GYOveI
	J2HEdDBF91ZABZEFq4lbb/SOzywzOomInqBMqbLbP3fHrFOAttnjpukWC5vjQGlZch1q0rwDdRe
	f62DvFVbIQV1esg2PGlhb9nbVJ88KzT4TYDluQaZQy1C1A2gM4QOXTw9xckAUngmhVv8kNLrd+U
	ahwr3oV63zahk6lXutWiejoFQOcBM7mxKNwHKOqvyBuiYSf+7ZX5Rr+0zwbhlXjaj5lyZhWrx9l
	HoMtEES0clLmeuK20QklzAVFukYENYmg1al/L3Ae0aHlNp0PAoOR7WmMyinapOC77SyDJHYOTKV
	Vmo0ig9xSRPhn0IJxVNJmklhv1ouZJrnYT6XcDtnQVuYdvlTQgyiQOJapzvK+IBs8dUyYeUckgv
	ccBXg7zogE9sSJTN65hA3peqkv++jhW5K04Qr/5gSilOpu7TcMn+17IXETvw2fdgvmRvI=
X-Received: by 2002:ac2:5fca:0:b0:5ad:3035:c2be with SMTP id 2adb3069b0e04-5ad43759ce2mr1020836e87.51.1781622234324;
        Tue, 16 Jun 2026 08:03:54 -0700 (PDT)
Received: from cherrypc.astra-academy.ru (109-252-17-231.nat.spd-mgts.ru. [109.252.17.231])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1adae5sm3650988e87.56.2026.06.16.08.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 08:03:53 -0700 (PDT)
From: Nazar Kalashnikov <nazarkalashnikov0@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nazar Kalashnikov <nazarkalashnikov0@gmail.com>,
	Christine Caulfield <ccaulfie@redhat.com>,
	David Teigland <teigland@redhat.com>,
	cluster-devel@redhat.com,
	linux-kernel@vger.kernel.org,
	Alexander Aring <aahringo@redhat.com>,
	gfs2@lists.linux.dev,
	lvc-project@linuxtesting.org,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 5.10/5.15] dlm: prevent NPD when writing a positive value to event_done
Date: Tue, 16 Jun 2026 18:04:05 +0300
Message-ID: <20260616150407.810370-1-nazarkalashnikov0@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

commit 8e2bad543eca5c25cd02cbc63d72557934d45f13 upstream.

do_uevent returns the value written to event_done. In case it is a
positive value, new_lockspace would undo all the work, and lockspace
would not be set. __dlm_new_lockspace, however, would treat that
positive value as a success due to commit 8511a2728ab8 ("dlm: fix use
count with multiple joins").

Down the line, device_create_lockspace would pass that NULL lockspace to
dlm_find_lockspace_local, leading to a NULL pointer dereference.

Treating such positive values as successes prevents the problem. Given
this has been broken for so long, this is unlikely to break userspace
expectations.

Fixes: 8511a2728ab8 ("dlm: fix use count with multiple joins")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Nazar Kalashnikov <nazarkalashnikov0@gmail.com>
---
Backport fix for CVE-2025-23131
 fs/dlm/lockspace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 5394c5713975..5072e81603ed 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -638,7 +638,7 @@ static int new_lockspace(const char *name, const char *cluster,
 	   lockspace to start running (via sysfs) in dlm_ls_start(). */
 
 	error = do_uevent(ls, 1);
-	if (error)
+	if (error < 0)
 		goto out_recoverd;
 
 	wait_for_completion(&ls->ls_members_done);
-- 
2.47.3

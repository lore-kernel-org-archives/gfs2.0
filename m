Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1B03A7F54
	for <gfs2@lists.linux.dev>; Tue, 16 Jun 2026 15:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622323; cv=none; b=k95V+KFgpbo/pDqpwS0tXwSaR2Sa1NjdPE6syltpkAk8ubRddEXwUiPlnxcBmOWcsOu8FiVj5UBUbTLrSE+Z1d9KN0sypoobu4lI2lhC72hq6Mp29rqXpOIO+IMBFddL+ztGMImiXi87XRbahRG29glHhDKzzZ9N3ZtYYoUMSn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622323; c=relaxed/simple;
	bh=JEOLSZ1AJjN3AaMIcahaAX2ySPe5GUtyp0G050zEmnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T0CLm+33Okxnx2JgxwLUOogQzNksJ8RZwqCv3jIUQwCj7ZLV4UQengAy3bMgQJCOFJ5QTnGkVzIWUGYKfyj0s4cz9TGzWijBIMrusNQmduSIGatVIfw8pPpWF/SBgs32Ag8EKYShUyvjyg0ckP50gN4DpuF9SXvvJ30oGTuOejs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbaDkfWW; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbaDkfWW"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-397e391cb2aso41485841fa.2
        for <gfs2@lists.linux.dev>; Tue, 16 Jun 2026 08:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781622320; x=1782227120; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jlLTtSeNFufiChT+v/pvFzDbVk/DIrJgt+8tFHA9RhY=;
        b=lbaDkfWWHyE61gbvCXBMYk3SP5R8A4DpVua1HxoU0h/GBf0o447sJhE3j4n3cOBazy
         J/6lGCv2JRBaZSYPHrs51af41g4giGWb6kHMLaBOH4pQMp1Qyy2vNysiA4GMWiuIXl3G
         L59NJJK/y4JjiatYZ8Zd/lcAMY4ikCPikhLAvcSr5wDDj3cKeLVp9P+5AbirIVJ99R64
         TmzhAYLcablzabZ1dUAy/ksH4z9iDxnLrkftKnCgLwf93cE7KBhOO5O56rYZA6pRmg2v
         4tGvSA28cSX3tpUa1wLGusZVWNLsK/33gMO5L7/5fevuSZJqQTL3z0qc1N27ZsjEyqa/
         KwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781622320; x=1782227120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlLTtSeNFufiChT+v/pvFzDbVk/DIrJgt+8tFHA9RhY=;
        b=B+JAPAZXnIkrNKlrlx/Wsy7bdd4LBXP4Uk4mItJnde6CitceRdKi8smi15h0TKU7Ck
         4GeEOMmzpnCsaxlONDy2MFt6W9JIfqMSvekIbNCpW+yh6Dc5InbBQ9hS86+BnbYdDsOp
         6/Edv2ymzCpQLglQEB6fuYqnOp6flv8t4aomVkpBlEsmcFUmn5RUlRN7iKicWBPI93tU
         kwAwDMwdSr/XweEVKEpgRv77it4QSINZf9ANqobwf9rAchHzxQdMoCk1GZDoV6/nT3rH
         csyfoCUyGpe7LXuyIXVLy4WC13jeEcjGxcco0TQdMmTs8rK9596EbN7ggvxBAsd1i8R4
         ur1g==
X-Forwarded-Encrypted: i=1; AFNElJ//lrYI8ucUBi5ffgxu/4VBx4LGiSeDde8ZejkEQ0svXPdi8UHi7dBOtNkrccdNXMOGsjsT@lists.linux.dev
X-Gm-Message-State: AOJu0YzumX31NtVkCt7yzNH6a/Qy5SEnY/9TMxHEOf+ZOzL0mFtg0r6y
	nVRI7SC1c6Zgl2J8pr7634WNBG6Z4YkBdEA3iHu+gaUwzU1jaLzO3PaZ
X-Gm-Gg: Acq92OGUw6FfWnqAnGg3/H2+WoW79T4owz53BiO8SpCaLm932s4mwI0b7MFAoigCNi1
	QEi7IOEfRwWoF9STuR/6PCCfJRke1j/lNQiWjfWIctLLIWeu5E5QXy0n401Xi5Uk67Ht4PQXAgw
	JZhlzjcGY/ZIWkixYPkYCp5GKjmahDNlyqbRQYS+PnawuJJmPb/D5Qc2XYc4v/ikgKVkR1/s//N
	kGF5SgD7PgztWJ3NQ+1YGgsjS2P+xw3fVUdfC0v6zvTkld5x46MnWYIfbqFdKHczarxDCbtH3KK
	aa9W8A0PXlEOOHvKcufCqYGhgKW+23CVKbslmEvj1FJbITMZxShqc1BRP14hVgdboy5THsD0LZR
	fwykautxbrE+gzJHiRWjXuJNYCvdGHrJJttIa9jqQJjzjN1Wa2udlzAg8RSOWORC5UA9w1MSv9E
	/E9O66SB8o7sonQy6nlk45XiNJ/y3cUfeYwZvnWFHTgqbPXRgjzjyedVpvktrC2CO629E=
X-Received: by 2002:a2e:bba5:0:b0:38e:83a6:d37 with SMTP id 38308e7fff4ca-3993ef57664mr24550401fa.13.1781622319750;
        Tue, 16 Jun 2026 08:05:19 -0700 (PDT)
Received: from cherrypc.astra-academy.ru (109-252-17-231.nat.spd-mgts.ru. [109.252.17.231])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3995c191cd8sm7765001fa.20.2026.06.16.08.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 08:05:19 -0700 (PDT)
From: Nazar Kalashnikov <nazarkalashnikov0@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nazar Kalashnikov <nazarkalashnikov0@gmail.com>,
	Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Christine Caulfield <ccaulfie@redhat.com>,
	cluster-devel@redhat.com,
	lvc-project@linuxtesting.org,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 6.1/6.6/6.12] dlm: prevent NPD when writing a positive value to event_done
Date: Tue, 16 Jun 2026 18:05:34 +0300
Message-ID: <20260616150535.810849-1-nazarkalashnikov0@gmail.com>
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
index 7b4b6977dcd6..ee11a70def92 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -576,7 +576,7 @@ static int new_lockspace(const char *name, const char *cluster,
 	   lockspace to start running (via sysfs) in dlm_ls_start(). */
 
 	error = do_uevent(ls, 1);
-	if (error)
+	if (error < 0)
 		goto out_recoverd;
 
 	/* wait until recovery is successful or failed */
-- 
2.47.3

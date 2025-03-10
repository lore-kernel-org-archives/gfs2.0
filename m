Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F0B2206B9
	for <gfs2@lists.linux.dev>; Mon, 10 Mar 2025 07:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741592201; cv=none; b=iujcTHKNtabBVti9sI/nbio9ALRSJNNjo2x6tE4gqUgAeCJASkjZEGXUC36gTi9HOKk/cOxFWdNPQKI6DGGQ+qwfMYkTkKvj5t9FAV9tdrAjG10pHevEpi9gX/2hLjAg+w0dsD9w1L8tSRx3QYUk1RyviIMPHAmVQF76UV0hmTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741592201; c=relaxed/simple;
	bh=ExVI32TQiZ1xYypo6IYq7rzTjovDtadZ6y7/4BFpc5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=McypMBRjiw9Mz3mNny1womTA6CMleGskPrbFEHqVqrkVt0i0Hhpm5fd6PQdaJQwnfgtJLBuJ9ZEAjidTDuYhjLA08RQL03iirMND3QkjSvKhpDRodIkpwnexFeXpOYcNwG4t5GSBZns6xmQUrAPlsEIfQQ2TdE3/OK++IzyBzUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I+/D9/sa; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I+/D9/sa"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-390e0f7b272so317249f8f.0
        for <gfs2@lists.linux.dev>; Mon, 10 Mar 2025 00:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741592198; x=1742196998; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pV58m25EIpkQ4Nimx3VQlVuDlPetIko5FT0lFOjGRTo=;
        b=I+/D9/sauUNgbchNwqLukVVW16/p0S+co22IMnl44e25RixrTSrh7Y3Sy9GrM9ID40
         zNFeS2c4zxsDE4cts6Xs4NjwBAb52AR8yL1y6H+1nJl4WXbTqWKbRbJQTocDXIrgEHQ2
         sOkCeaMrjILsEone2fK+wCGVB9Syh16ufndIF0GMhOo5AJtcPoc7R1ahgDoo2T2SDFim
         91JYwJ4wmUrVvU+8emFdGcECMjqLkn9Yqu7UXGF3YaXoRXMCKtPfleGrxc+CNsyEQZ4x
         ut1VNo7yE0cNIhoPOt/tWJjTrLxjITvIBO7vuADCWDutlfKa337efuj6ArkgciJ43et7
         Cisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741592198; x=1742196998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pV58m25EIpkQ4Nimx3VQlVuDlPetIko5FT0lFOjGRTo=;
        b=lhp6RjuNPvAX2oA9yBMbbwkg3oDTgowWzoLY8cPtRHcB2jasN7exgQMiURHHtZrLpK
         K+msVyPEH8oUshngY96/gdAoHyuWZJzoJWC0C5Xo5DbrmyJ3i6VveteXRq3ykxHndHef
         ssmBOmrq2IR2Ieoqev3jI+UOYZpUXlpgIhu9aUx3lzxj4K1O8cvfadFsfEK8YjhGoJt7
         Ruu2F7o90pCsZWs4hbcZhlQ4u6X+AoizrJ78UyVM+hiytO/mr2nzibMkrRm/8WEeO1Yy
         Ar/+tdJtuxVlEM4FD8vZOXmlJCdrmLZyc0Clhk26UDpj5E8zZMS8e0N8/CPbVMNGihNq
         CYvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCvjk6sSGN7DEFaY4ZLUnZmuFUsm73psReVch4A/D3yC7RLFSeq5D/8xN8GPdI6YED7BCn@lists.linux.dev
X-Gm-Message-State: AOJu0YxnDrAPf7VzgkqksbrBKYKvDK4efTDvGppsKNgLzP8Q+EvcwyQ2
	VyMRbTpUFY2mMmMvyT9BQ6MDS1z3+LH6mL/Gq+Y8DL/fA2zFRhFOogZotNIxRF4=
X-Gm-Gg: ASbGnctnr3G2OWB6oYdqXLq7N20mJQrdPutRLDJf0P6RJv0MBMTghHiiFyz3eCaCPq/
	PCpwsypIZl4pUrie2SRQcIUQjgQj42HwaG7tFhoo1CdtGrGsCSHy5V2tT/62wwt+yr/6k8jAoN5
	COUUZGDZdewW0PrvpFzRCQ8j5WqqfTvaTzMbYPXjaN86tt+mE0UfIYxpeI9kvFE2SgMKfh85egv
	YFc419kpUZlsEhZRhIBInmAy0CBt0C0PRWQ5pXcpD/r7jHYB2Q6pxxd14XyI/j+Yl1dqo76jLWb
	bBgoxw2XlU8Ud6rDjKONBuNWloH6NZfL388BcPhI4vsYy5079a3MTeyv5sM=
X-Google-Smtp-Source: AGHT+IHRm0c/5PhhhYs7X8EE+YuDjXeeHdePvMBqH7FbHSFqjlxP6DGSDI/rIYDb/wXebdXnsiW9Ng==
X-Received: by 2002:a5d:584b:0:b0:391:10c5:d1b4 with SMTP id ffacd0b85a97d-3913bb49265mr1588472f8f.7.1741592198011;
        Mon, 10 Mar 2025 00:36:38 -0700 (PDT)
Received: from localhost.localdomain ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f9e0sm70806935ad.113.2025.03.10.00.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 00:36:37 -0700 (PDT)
From: Heming Zhao <heming.zhao@suse.com>
To: teigland@redhat.com,
	aahringo@redhat.com
Cc: Heming Zhao <heming.zhao@suse.com>,
	gfs2@lists.linux.dev,
	glass.su@suse.com,
	zzhou@suse.com
Subject: [PATCH] dlm: make tcp still work in multi-link env
Date: Mon, 10 Mar 2025 15:36:21 +0800
Message-ID: <20250310073623.18607-2-heming.zhao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250310073623.18607-1-heming.zhao@suse.com>
References: <20250310073623.18607-1-heming.zhao@suse.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch bypasses multi-link errors in TCP mode, allowing dlm
to operate on the first tcp link.

Signed-off-by: Heming Zhao <heming.zhao@suse.com>
---
 fs/dlm/lowcomms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index d28141829c05..70abd4da17a6 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1826,8 +1826,8 @@ static int dlm_tcp_listen_validate(void)
 {
 	/* We don't support multi-homed hosts */
 	if (dlm_local_count > 1) {
-		log_print("TCP protocol can't handle multi-homed hosts, try SCTP");
-		return -EINVAL;
+		log_print("Detect multi-homed hosts but use only the first IP address.");
+		log_print("Try SCTP, if you want to enable multi-link.");
 	}
 
 	return 0;
-- 
2.43.0


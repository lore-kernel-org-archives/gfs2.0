Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61DD341062
	for <gfs2@lists.linux.dev>; Thu, 18 Jun 2026 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781810075; cv=none; b=nKc3tdNJ47Unz99LqpTqQzJiBQ+j1v+VIMjUH/xFYgxLete8acUil4yAFoayt0Rs3iixQ+W/RADijZGLZaodw50PR749pkUE2yfwuQI9iPKVOt/G1MoGuWRVjIVmWmJP3Byu7K/3/rd6BL2g6fvOf/kNF2Ny2dq5PMgRHHHsCpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781810075; c=relaxed/simple;
	bh=ZpKwHxm3u6Pjkz1AWo5uHFVbpHIhgiVPKva+Iorr53Y=;
	h=Message-ID:From:Date:Subject:To:Cc; b=BARsWPn3BBikqapOQb1E01h1/DkcoqqJh/bdawHecxT+5v7FQ2p6lyNiet/i9wbEJZ9EGDZyuq/DdTHWHdpt7GRgwjoEWYh6DxH85MyQEEFkwpYWRUirzwgX6cRzjgmtMnm/EdeW+++snzpwhGFxZDcuElVVM864fkNMeTeORKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2BF5YIA; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2BF5YIA"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490be29c1c5so11293715e9.2
        for <gfs2@lists.linux.dev>; Thu, 18 Jun 2026 12:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781810072; x=1782414872; darn=lists.linux.dev;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l14cZE2k8Sh7Sr0inIcurRPAR+flPBDbsfRLlK+C7hk=;
        b=U2BF5YIAFyqXiCPoO9MPlAPzoDaIuW+ycGSqhINXuNiildPRq0h9Ui1YqAiotgkCK7
         i7Ufujq9Ngd8p1hd1YEGYz+93h+6IQwcsIoPHmgAaTJlSQskuXNcjQd9eu3MeGYEzjAU
         kKcfcD+RzuRPf+7DVumYR9c/MUhw2L11tJeINpaOg4Aw7XRcqAUqfjJBdOgEV565N5Tf
         xleBN1r2ij+GfwWX9AoJnmLMe34so7p87W7TK3BBFGkFqP8eWDlCeKwgXdwtFdBRXbb3
         sHISDbs4bO4b7sqi8YEQXPgrQDB3WD5jMUWZ444dmKbBRzOA6971uclD5L8uU1QDPkjl
         5L2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781810072; x=1782414872;
        h=cc:to:subject:date:from:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l14cZE2k8Sh7Sr0inIcurRPAR+flPBDbsfRLlK+C7hk=;
        b=DeZE8DJl2JDrLGu7+bpHMIYy7IC7z4KnSvmnxLOz4UP2Hp7v2ljtMqL/jZhhnBiWIH
         b6uU9c1GsfHgyhZ3Yex/Z0prREDDN4qweSlcMCzecZnJv8s7udTz/UI1cqNym9kKP48S
         zaB/fEb0KWDD+lksGe/XBuFoNKXRFOPNZcVRcGew0xmKQUzT0NapANt5lQzHZyYGq5Ed
         d3rJ8N4JElDtGugMlsFBP9Vbp8b4cPIdy82/VRgOFrSirI5dY7ZVQsnGVa1DipjNAvgh
         9sKMleg5GNGWgqB8TUbmhFxp5shrCxCg9tH3Xrqw9PtAny5i/bgsktl9gtp55EtT2srC
         uRVw==
X-Gm-Message-State: AOJu0YxKK2ebZlv6pIjluEagHiuYDNUQhvvIndRRtQqOmuEAZz+HvY3r
	yXUEg594idpguoJBpzUWmjPGCUyKeoJi5wOZB/veyiDTevDi7VxKMGTrME0/Sda3
X-Gm-Gg: AfdE7clEa6dlmSTMpWOHiQHDZwEr5fZp8NXWkzKPvHx2ggfL5MQSO5/1kW7TgnRLX5P
	//kyby90JU8LnnkTTtjCYVNy87d7ExxIKBJf9/5/YJOCuSOLSPwzMnsNqnQSmdwKWib/LPRFUeG
	pRML4RByZ/+DEET+vz3WuP4sUX3qftmHyyML6yCFSHVvkmKK8AdiVc6Rqwj3EQYbaAdrBUy6MSs
	6yT3BkpD4OVLGUsoiU1Csf6Ke0pQoKzvVM5YIik9a0Mz4MaSgG+7Qf5d8KNshfAyQEpsqmG1zhe
	KCC6vCj0qxAF8aGfJRTkmwlE9bVphdXzb1vc6RdcyJ/4q9zWyiQwIzr+VWttjyVX+3SpSZ85T5d
	jfL4P0Psmwp3iwe7XDim7MmFqoBC5La8nih3SiH1iu88w2wvxaubMYOK4lyBKwDJWyQBPMld2Xk
	x4og7YuqXnJBrNr61bHZq4yIie55/cnPijlupDJHYL9p8=
X-Received: by 2002:a05:600c:5950:b0:48e:6db3:ff3a with SMTP id 5b1f17b1804b1-49240e527cfmr3164035e9.16.1781810072199;
        Thu, 18 Jun 2026 12:14:32 -0700 (PDT)
Received: from parche_gfs2.eml ([46.222.122.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd15535sm11055045e9.3.2026.06.18.12.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 12:14:31 -0700 (PDT)
Message-ID: <6a344397.561280e1.325e99.aabf@mx.google.com>
From: Adrian <adriangarciacasado42@gmail.com>
X-Google-Original-From: Adrian <adrian@tu-correo.com>
Date: Thu, 18 Jun 2026 15:56:26 +0200
Subject: [PATCH] gfs2: add missing __rcu annotation to i_gl in incore.h
To: gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>

Signed-off-by: Adrian <adrian@tu-correo.com>
---
 fs/gfs2/incore.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index 614657778..16df75336 100644
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
-- 
2.47.3



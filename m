Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5134E1C9ED3
	for <gfs2@lists.linux.dev>; Wed, 14 Aug 2024 21:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723670782; cv=none; b=b0yoUEIflZWMOq1gqtcROLf78FRMs1V1m1A7PHJJ4EKRCxA/1RE03dFO3nQERQcI0yaxfMWzvs/ftX3JB/z1W4VM2NVmlc7Z75Cx0ICtumMacNg05KQPU4VJgaOw1o32X+wS8aBqTvfG1Jg2EKyoyW91mxkQCI+BA80lk2DDeOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723670782; c=relaxed/simple;
	bh=/ZdKHR4pHjntJYSoUdVRDKcFzv/LrElzLuY8Xsnn2js=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RLvkig9Lg8nntcTS/3piKoaO4NKI9Gz19jYc7AV1sCKqltp3XQ8T3R97TUJAo/IFYzmseCMOdqvSiZh8eX0BjzPidlHxH9AR0jTdC+u1ivXPoHeO1ty1+AgC9vjyNGX6srptTxxyFgtWgvNd8sTkLt8Q06jgbGuFAXIXmMVp0+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=O+aWZaFb; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="O+aWZaFb"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a1d067d5bbso16778585a.3
        for <gfs2@lists.linux.dev>; Wed, 14 Aug 2024 14:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723670779; x=1724275579; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AN6bShe37d+I+GAe4SQfQZex9z+pcNLPbf8dU2iG5Y0=;
        b=O+aWZaFbPA9eI7LHYbtcDIgr77wq8SWytI7SVSk5RYvlNefcoWnLnlI3AhcxeWIVF6
         a2f7eZ07juEgBIwNGWq8deOedtlDwEX6uFWyGh6kItK6OKrpy9XVzM5PPhyM7ddYX0L7
         byZxiYILPkhCnyk6qCT+OFrv8tirDNoYp7NAJv66cZZ+V4uAuuz4Dux2IH9v3UqOCEaB
         u2qmZJj5vv8WGIAJ8pzFExj+X7LxgCDJfCgLNRmsfor2/ISZHf5eM2z77ePoNK28K7x0
         U5n7nhd2VkXkhUC+my/tL4+K3QirkL2RgZH6n/XvG37B5/3RFFk6pCb1At+2ctRmjepF
         ANHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723670779; x=1724275579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AN6bShe37d+I+GAe4SQfQZex9z+pcNLPbf8dU2iG5Y0=;
        b=aKkqRXjtzIcay39RMg4Wl0wiyY2QRjyWzdcXdy+x7mTQAV0ATXC4tznST5q9ooCzQD
         Z01mh1pjRCePsycJG2DpzNBElRCz5L++grvfAt3TI+ylufkT5EUkjDK0JysTyStasSDk
         +kV3YBVHjwqX2tGbhIjy8AVDeoaDij/mfLECcP8JHfWqBognCHKeYXNmyZb1wFfO1ozJ
         1g9okQyKTljWWYtc1vBtBMydIGwDSpkalGiTXHVB/GiDNjGtx2DnqFz2pRS2EOLfdF0z
         vqTyCXprXkFUreyXff7QMiRxOlvBS1uxN13czquuc9a5eiuZmNOtumoUGJKJTgMhWSd7
         FgJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUanWiG9+eevEhYqn+A9wIn6NSGGdpCChFXwLiBXRewxxxEaIbLPU3D+PJcKJzozvyza+rV+dZs8Zd5NGWx3uz8rjfIZQ==
X-Gm-Message-State: AOJu0Yw36QxrLTARGqBZg2Zy+2T6FmJ5XN/FA/oDeXM7TqXOvS/Pd9Kr
	ieIK/8hQPSF++9unxreyU4MeeOuUOCqkQuPXtRPTc/6F78hMlTo89ygmwZuMbX4=
X-Google-Smtp-Source: AGHT+IFQOOdc7hk322ZC4VYavDskQmkGcpA4gUJL30TWlxeg1xLDQtxnIo9ze+bETsdddSmDQjnk1g==
X-Received: by 2002:a05:620a:c47:b0:79f:1cf:551e with SMTP id af79cd13be357-7a4ee323d9emr460557185a.5.1723670779329;
        Wed, 14 Aug 2024 14:26:19 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff120085sm7708485a.131.2024.08.14.14.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 14:26:19 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v4 14/16] bcachefs: add pre-content fsnotify hook to fault
Date: Wed, 14 Aug 2024 17:25:32 -0400
Message-ID: <9627e80117638745c2f4341eb8ac94f63ea9acee.1723670362.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723670362.git.josef@toxicpanda.com>
References: <cover.1723670362.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bcachefs has its own locking around filemap_fault, so we have to make
sure we do the fsnotify hook before the locking.  Add the check to emit
the event before the locking and return VM_FAULT_RETRY to retrigger the
fault once the event has been emitted.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/bcachefs/fs-io-pagecache.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/bcachefs/fs-io-pagecache.c b/fs/bcachefs/fs-io-pagecache.c
index a9cc5cad9cc9..1fa1f1ac48c8 100644
--- a/fs/bcachefs/fs-io-pagecache.c
+++ b/fs/bcachefs/fs-io-pagecache.c
@@ -570,6 +570,10 @@ vm_fault_t bch2_page_fault(struct vm_fault *vmf)
 	if (fdm == mapping)
 		return VM_FAULT_SIGBUS;
 
+	ret = filemap_maybe_emit_fsnotify_event(vmf);
+	if (unlikely(ret))
+		return ret;
+
 	/* Lock ordering: */
 	if (fdm > mapping) {
 		struct bch_inode_info *fdm_host = to_bch_ei(fdm->host);
-- 
2.43.0


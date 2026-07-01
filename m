Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D217C233953
	for <gfs2@lists.linux.dev>; Wed,  1 Jul 2026 00:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782864724; cv=none; b=QPE/JGcLyeNQdHjJtwXyqK6gWgJLzz6d1n/f3WhwHdSCcUOTKphXsrfXvD1QNsw6umBGWZk4IDZnvV2GDvBElfPluxYQg7maAZqGWM/mQY3Ml+A6FMDRsiX+8rzjYKlc9orCAOCfRQgqaU5nIRIsd5C8908cplzTRj9A7ppBS3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782864724; c=relaxed/simple;
	bh=YSSocn/9Lzgta+zrc1Y3ogzo5RcF7lik+7d4HrX9T98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lnzkut9sAgZRLLUlvNlInNi9d0L+/deA7Hhk/+BXh+BQoV7jWVFZdiHXVyCYu/ObCL8s1kGaUnfMNG+8QTdQUJlZ0NQT75sM/D4ns5hf8vpLVmSp2xJp6+h5/BKVAcKHBKhfKETQb0LlZOkh4Rgc5Wa37yFw9cGqIpgyn9q12ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sdm3sNea; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sdm3sNea"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-69e1f777bcaso39299eaf.1
        for <gfs2@lists.linux.dev>; Tue, 30 Jun 2026 17:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782864722; x=1783469522; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zAJp8kY6IFFjt3pxCIPIq/VsrqKUfgyaUYuo526e7E=;
        b=Sdm3sNeakjnRO6mL++BaCKX/5xRni3GX9umf4T7MwC+xJQzfGFUFU8cGWKCY6g68MW
         KVytag/4TRefNRFhTgYNpKE56u2zENc2Mofn/aceXrbiuwQnfE8CqOm7kj2NSZwiJgOp
         VDVU8iIhvfKp/fy8V/MS3FLMib6i4qAvN67Y8dgXAORi8g7gIz4HYazTerQd5op/rT2z
         0w/U9KlsH5wAaELJKfuJ06YpKF/D61gL2bAtb+A1kLbN9ou29Zdy3xeqxSTw1m5V2SlK
         bBPkHCUANpCfJRSRn6uC/ey6yz8QWYLtw9sdt9rGNAjryZbHRNk/3VXm1zqawNRD7CTs
         bHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782864722; x=1783469522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7zAJp8kY6IFFjt3pxCIPIq/VsrqKUfgyaUYuo526e7E=;
        b=CLiPljaEfyrdvea8Y0t9qRyQmAlp/VXrEaXZY/86C41MJcO5VGFVPWTc+Ou9dyNLb8
         +FhPlgIQUlPyZ7Pg9cTmQfo7dVBxTmNxD5m5P/fVhnpImLLbQfNGVNW+PFzBbvEJNBGl
         oxyfqhUF0K0bkGoaFow+bJCJbt1Shjkru95FaV4KZsyEXXL3uFsF9/hIVAd36gtyT+n4
         GYWWJ1T4N1TO6vzsXTEzjz/XBH8mzndhyd4fpTINh64qxRp0YyFNOp2gAduR6XvsphS2
         igDbiU+HeqDkv/CfGVx3kcmN62aAfwf+Ritxvc/nMVZeDNIs7UxfY+Lk3nuhtOtnp26f
         PAAQ==
X-Forwarded-Encrypted: i=1; AFNElJ9NlskHBk/NtFWIwAKDSV/qSQDLWn+pltYKKN9dAYzAml/7YCjyWN1MqKvtA50dqPNrPqYu@lists.linux.dev
X-Gm-Message-State: AOJu0YyT6qGpgxxMc7VrKXB1GRw7FiPa3ezrVaX7nZfOmXmYhUIpgA8O
	nUGSBMouFRmGSObkiz77KWjSTi4Ubaf0zsfYwisU5ZL87zGP+P56a6IF
X-Gm-Gg: AfdE7cnwfnnpex2VMAQZhvx74Ul6gyj7EKxzZvdnszoVlTktuhkkDApTHcvN+eFfx+S
	yzDMmLKxdggtWFjwMfP1TGYhRCg+hfaoMDf3R90RsyvXHO+dcZUbqN3hzlmAb7S4H3Jxr0xlMkc
	h2Er+6de8wipMcoujnQPd2hRt8326OQH88oNEfV1MnKpnLr42vtaz5x4cC/VsvSrKJAmGcbibJ2
	2HOxmARw/beCWj7USPJvVva9soD0ftmorl9epFf4z0HO83JMami4ooV+XC9iLtNj3Oziq3AjWPy
	S7QMnBu8K/fwcBxurkAlKBhXjG5vwfV0MEQhyJ7TMgJx/LPl+JEW09pKSF0zX0QStD6M2LMmciK
	09Y3VbWFIWLgeNTRTa5wsS/vrKpWx/ASyIxz+9I+PEjyMGZkCpB+RzqkaMQG8GvBDPome5Q9RZ8
	iPAHr2oN2CAZAL3pWeFyRB/SiV6qFWPySqVCddx93xtW0gNrZOh1m46ktKIvpx+xc=
X-Received: by 2002:a05:6820:1c88:b0:6a1:11fa:1b37 with SMTP id 006d021491bc7-6a1921d5a31mr1953624eaf.25.1782864721828;
        Tue, 30 Jun 2026 17:12:01 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a188f77891sm3095730eaf.0.2026.06.30.17.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 17:12:00 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	hch@lst.de
Cc: djwong@kernel.org,
	willy@infradead.org,
	hsiangkao@linux.alibaba.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev (open list:GFS2 FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 12/18] gfs2: convert iomap ops to ->iomap_next()
Date: Tue, 30 Jun 2026 17:09:27 -0700
Message-ID: <20260701000949.1666714-13-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260701000949.1666714-1-joannelkoong@gmail.com>
References: <20260701000949.1666714-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert gfs2 iomap_ops to the new ->iomap_next() callback. This uses the
iomap_process() helper, which finishes the previous mapping if needed
and produces the next one. No functional changes are intended.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/gfs2/bmap.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 51ac1fd44f78..6cb1d4513882 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1200,9 +1200,15 @@ static int gfs2_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	return 0;
 }
 
+static int gfs2_iomap_next(const struct iomap_iter *iter, struct iomap *iomap,
+			   struct iomap *srcmap)
+{
+	return iomap_process(iter, iomap, srcmap, gfs2_iomap_begin,
+			     gfs2_iomap_end);
+}
+
 const struct iomap_ops gfs2_iomap_ops = {
-	.iomap_begin = gfs2_iomap_begin,
-	.iomap_end = gfs2_iomap_end,
+	.iomap_next = gfs2_iomap_next,
 };
 
 /**
-- 
2.52.0


Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E836D528
	for <gfs2@lists.linux.dev>; Thu, 18 Sep 2025 20:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758228536; cv=none; b=l1yP1yTdbjCajc6oB5tvlBBhllTd1S0lpWobu/Jq8kLAOaI65FXgvkMfcHtCPRo96OS9W4pT4a4+bNa4QVIUclDTI2MQXPFVNz+W2n43M8of0zmb3foG0NIrnfHJkwZKZaAvnDj4vsXCRCLy3XcSMmy78L7q7o2BSE3m1tctN5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758228536; c=relaxed/simple;
	bh=R8VdHAizxiIZiX4FLFq7J/L0lVxWiWwNMZ7Ks/nE3G0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uXu44zoiZAgsjQOKL6s5e5Ipa7q4uERliHnyC98/0G5pl4pTRq6x4Lhia4vRjZTJXzumSRzdCiNUuhjNmaC7HOmKk2vjuDDW5XsLVHsTHdL6zj/510qtI/o9f1sf+mYRdnJzYJeH4tptPCC0HEaexamt9MQY46KTji7GLbrjTn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJECGoDS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJECGoDS"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-268107d8662so13328755ad.2
        for <gfs2@lists.linux.dev>; Thu, 18 Sep 2025 13:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758228534; x=1758833334; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RWvpfkXVsTXpCF10bCqC7yVTYFDAtVdXNdJBDL/F03g=;
        b=FJECGoDS93XwSdfOfm4SFSBKcvXUP98mDyqfE+TbnfBtuF1BhvVLyPlej6JfavFFLK
         cP8V0Rkl/QS2aGZ9rqWZ4wHSQv8sDVb5w/iqTR5iyIFtFm28sZThPYryaWTwK2cU6d55
         NVJx/K8mKrkpM+mcUq/N6+fQ6G66fgAu3+sPia4jFPgCxXiE7DtNDf9y9hcL3q2sSg2K
         7apfc1coA0OXE7mA+Y+rk+lN1RqT0IgS+dOAhqQIyGTVFbCkvbNN4SeOknl0ZFxh9KtO
         ZwFVbTzwBeJJ0AWoVpeguytJYKRVavvwzZnPEPeR2BE7CPK6ix0dldvWwyq56FxJcDk0
         4lYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758228534; x=1758833334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RWvpfkXVsTXpCF10bCqC7yVTYFDAtVdXNdJBDL/F03g=;
        b=O78steFRctnrJZ+qKj8I9p3FD0M2cRDWU80anEzZ4maYiECtYTcmYAiyVXl9Nk5k+g
         AIbLxnwsWcTbVuPpCxDNhp/HSSUDPlTl3IB/DK4z3WoMtef3PmqfSV2tvjCZ+oXWsKTF
         +N2ygiOSWt1G5vd1SMHAklj784xZkcd9Mgsv2C0XTqEbS06/XJwIBfbRO3E8/jXwjoN5
         6194xBPOPW/PoPX/ULy69k9LWPesT8AzAFrv9ZhyB+8OrrRYVyKr6e6eLx0xgqz9USbW
         M40Hpr4pE3t2uq2KoEv1NdgYHVrXrO1dXQOaAX1KDrbfDF8IhXWRM/99Oj7tICfcg07I
         klQQ==
X-Gm-Message-State: AOJu0YwtJxMxH18zXTadLko7dBl6QRSTKOoF+YG9r4BNWb5oWNFAU+ua
	fsgBgm2Jichv+rIl/6+Y6cjC0l68yA/uvS1kARFumwIqqX5RaDVAwIhH
X-Gm-Gg: ASbGnctoMUyQLYrhDfCWIakGvr4Xibn1YllRbNpqhkWyQUVDVHzv9dyX4lwHgJryQwN
	dX2DOTqDUvkCv6l9eOaYCZ6ohx9QM+q5sdjI9GMjtQGXXghqRtnwwoilkt5M4P+9ENHUPb4UgMe
	nfO2yMrMVMBBQWdIBf1yIdzFUOIdywf4bJeaw86c8+cshqXqc04QTLKzBReA/V6oQPwazUzWsev
	1+wbmsgkFE1WP9P3s2mXoxNo6pZWptoCtZtmWSeofmj6tggwVmvkInhnfg8+5sTIFWa7TpggyUl
	mvlEMHBzcxihXxmmEqSVCaMVD0UM5MDj4tgHaKUVL2UlO/OCErHLyiY4FCygqYlC8eq7qmDYnjR
	KUWjgkJFTtWNT4ETJUpWV5yB6s8HHgBaopktmEmSr6rvqyGUqGZgU62NK1HUZZUk0Wv8v45mL4r
	MZ8dbvUJjYlUeOa2hujmfpmQ/Ff2z4OaCIGmv9/4Cw4DtW
X-Google-Smtp-Source: AGHT+IGvApn9NcuvVzGprdBHvz9fgjbBfoh2S7GiEqj/2hx5hOyGCmpC/rOdk8KdIWmY96AzPPcNKQ==
X-Received: by 2002:a17:903:2ecf:b0:267:776b:a31a with SMTP id d9443c01a7336-269ba517048mr11002435ad.29.1758228534309;
        Thu, 18 Sep 2025 13:48:54 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980368ef4sm34486625ad.149.2025.09.18.13.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 13:48:53 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linux.dev,
	Kriish Sharma <kriish.sharma2006@gmail.com>,
	syzbot+7567dc5c8aa8f68bde74@syzkaller.appspotmail.com
Subject: [PATCH] gfs2: add bounds check for rd_length in compute_bitstructs()
Date: Thu, 18 Sep 2025 20:48:30 +0000
Message-Id: <20250918204830.229918-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

compute_bitstructs() allocates an array of gfs2_bitmap structures
using kcalloc(). The function only checked for length == 0 but did not
guard against excessively large length values.

If rd_length is too large, the multiplication inside
kcalloc(length, sizeof(struct gfs2_bitmap), GFP_NOFS) can exceed
KMALLOC_MAX_SIZE. This leads to the allocator calculating an order
greater than MAX_ORDER when calling get_order(), which is invalid.
As a result, __alloc_pages() warns about the bad request.

This patch adds an explicit check that rd_length is not only non-zero
but also within the maximum safe limit for kmalloc_array():
    length <= KMALLOC_MAX_SIZE / sizeof(struct gfs2_bitmap)

This ensures that get_order() is only ever called with a valid size,
resulting in an allocation order within MAX_ORDER

Fixes: b9158815de52 ("Merge tag 'char-misc-6.9-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc")
Reported-by: syzbot+7567dc5c8aa8f68bde74@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7567dc5c8aa8f68bde74

Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 fs/gfs2/rgrp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index 26d6c1eea559..a879e8030568 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -760,7 +760,7 @@ static int compute_bitstructs(struct gfs2_rgrpd *rgd)
 	u32 bytes_left, bytes;
 	int x;
 
-	if (!length)
+	if (!length || length > KMALLOC_MAX_SIZE / sizeof(struct gfs2_bitmap))
 		return -EINVAL;
 
 	rgd->rd_bits = kcalloc(length, sizeof(struct gfs2_bitmap), GFP_NOFS);
-- 
2.34.1


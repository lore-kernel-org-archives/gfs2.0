Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165BB397929
	for <gfs2@lists.linux.dev>; Thu,  6 Aug 2026 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035565; cv=none; b=LIsbXMOSOWWzD5+VX/M7zzUMPAHtXCS34VF1W3kzhqJ8MzmvQ9dP0diqopnLmTWl4jZbm863VZTLl3Gbq/HIzgSoOlnCIjHFDXNDMPfgB8kqp+qHQ3X1C4E5MoR3qiAn4uyz3eEyZvKv4ZB9LvvSUXvawQrfRdSy3LDkUsJ5UfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035565; c=relaxed/simple;
	bh=kuaP2Ip3RQshQpbYi/ZOrxn5Jrkw64bBBtC+6NgGKu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/zVPCHiPQfy0Rjogt3yb2+OtmGHB3TywXaiTlddyiIDxuQLn1mKmQFuO6Gb+0C4T2iWvWyqcBEVmQqe04Pcl9r29qj5AHssgZR5SqSt8ZOaRRXOcdbGk5GtlpVaSvadjC0egT2Qxa1qCRoq7/33umLfFX6HJR82cSXrXglx1j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnE7ErTy; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnE7ErTy"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5bf94664327so1024420e0c.1
        for <gfs2@lists.linux.dev>; Thu, 06 Aug 2026 09:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786035563; x=1786640363; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y4mp7C2u8iNxOV7vEnH4xyJiQARLq+7PYATgmrobvgA=;
        b=lnE7ErTy/cGIf9vaCRh1sKDh4mtPv9NwtI1Gr17pky2fIVG8apzCqCrCA7XVLwtDME
         VyIdMMIfc2G8ZiwtbzVxfzmoEXUU4l8Dw6F6Wtdbbj8iyv8uKiap3bytkRhzio1oIig1
         f9+gzj5Bpx/RDUnTEFqwhOQeNZiNqOQpdAFEO/x2pW+hZxRK7UcYAzUbmVqOcL0zmIni
         nIbU1TnUtCDLeCcMmfk/2ecV7DMekGu9yWxWEmn75xiZGXb8rxYoVC6U81d1DnTlMM48
         78OvWFH2xFiAPYrTmxfiIQVi0RQO4OpP++Y5rD18EUszOS/WuOrr1++osbaH8sj30UuW
         oMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786035563; x=1786640363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y4mp7C2u8iNxOV7vEnH4xyJiQARLq+7PYATgmrobvgA=;
        b=UKgRKQZjqf1bsG+5GyHBiVt3b5qYxoqEwww1rczlZRB6OVWsQrOg9zohl8fpUUlZZJ
         29P8V98g4u6gcbbp3POv9tkYpf99drA9r+/zI8reuQjdq8+ExTe3QeH20hjeJQMhnE9j
         cHqQ4FIW2IufvUvUDS612khXFGZeBjgxSEfSdAr+e0YHvly/NjJX9/wTk1LCYrB682P7
         eOFZLpuVsIIc0gwTtKAJb5M/SLC+tv/M78nR5hnYEc14GsJ8q/GyGZI9Ieg/gBZernqz
         /8trIXlXbMsb5FEPBzH4Py4i7jIkcarTkZArXbhuQQk+K0IpsvHNu5eajg9CfutusON1
         axmA==
X-Forwarded-Encrypted: i=1; AHgh+RoBG1Yj1hyERQdiLKna7NtlgNfIOnRwPbyD70ThB79vvqC5qBxnvECURDq8di36KnaTtxk9@lists.linux.dev
X-Gm-Message-State: AOJu0YwN4lgHAXqJY9/52NT344MT9dOMW375zqEAn2aR3a0lrQTv8+48
	2OY4bLYKvnDjRifIKKWTMDyhrD88DzwIJ3qT9d3QKtTxgxCS+rek+uE+
X-Gm-Gg: AR+sD11bAEX2dzjofHm7SKE0Ple5nzuGmKG9QfmTKSvN7gvVDqKlMd/phkomg6twkjg
	6Ii8CYW/AA003b+AolIXw79wtFf39TY4gO73m2m5QiZTMAj97ywe6grNdREpz+yRKMKbvfqPme9
	ypueB1n5GNHpttI7YPhmdfgeg9s9Bo6l53dIF9kI68w/WmEOklWHXgX/I42Jr0NNBJXdTLFSPmn
	eLnjrz0q8Sy8pYo47oTLGkh0BYnLW7fk1H8ltd6PZrUS2GaGWuMClV9OGnriCeYuDRAegkGv0Au
	1sjR6Jhyvs5dpqRN7A0+uYacP0Pda9FaSiph6FVs/v3Ol7OaBkQM29lE/fuF/9c74o4JjbTNebB
	U1Z+0hI49ob7W8GIWw+Qd6dWtooUPUoPHUdcHmJvM3fE3uUNmVpOa3S1/xubhUvgLMqJQ7LZWwc
	3f1tO5A5/rkt3J3AcU3cQvk1rSAFpN6N6JohqTV/uSS25lLxPA4AB+I1HIqVup3T3QCdo6wgvpQ
	GpJYsM=
X-Received: by 2002:a05:6122:8f88:b0:5bf:b3a0:388c with SMTP id 71dfb90a1353d-5c3d91849cemr2184457e0c.6.1786035562798;
        Thu, 06 Aug 2026 09:59:22 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c3d05c594fsm3706321e0c.8.2026.08.06.09.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 09:59:22 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Bob Copeland <me@bobcopeland.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-ext4@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chao Shi <coshi036@gmail.com>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: [PATCH v2 06/21] buffer: discard BH_Write_EIO along with the rest of the buffer state
Date: Thu,  6 Aug 2026 12:58:29 -0400
Message-ID: <c6e9db48d8d0feb83d4ca29306f4bc1e58f1ee0f.1785951556.git.coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785951556.git.coshi036@gmail.com>
References: <cover.1785951556.git.coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

discard_buffer() strips the state that describes where a buffer lives and
what has happened to it, because after an invalidate none of it applies any
more.  BH_Write_EIO belongs in that set for the same reason: it describes a
write of the data that is being thrown away.

Leaving it set means a buffer_head reused for a different block starts life
carrying somebody else's write error.  Like the bforget() change, this is
mostly theoretical today and becomes load bearing once the rest of the
series makes BH_Write_EIO the report of a failed metadata write.

Suggested-by: Jan Kara <jack@suse.cz>
Acked-by: Weidong Zhu <weizhu@fiu.edu>
Signed-off-by: Chao Shi <coshi036@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 381690479520..570ce7f495d3 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1518,7 +1518,7 @@ EXPORT_SYMBOL(folio_set_bh);
 /* Bits that are cleared during an invalidate */
 #define BUFFER_FLAGS_DISCARD \
 	(1 << BH_Mapped | 1 << BH_New | 1 << BH_Req | \
-	 1 << BH_Delay | 1 << BH_Unwritten)
+	 1 << BH_Delay | 1 << BH_Unwritten | 1 << BH_Write_EIO)
 
 static void discard_buffer(struct buffer_head * bh)
 {
-- 
2.43.0


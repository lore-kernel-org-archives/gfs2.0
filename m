Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D953D9DA8
	for <gfs2@lists.linux.dev>; Thu,  6 Aug 2026 16:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035592; cv=none; b=WQHPXNtCWHIzbyiuRU529J/cA79DMMjim7PAIxc4sczepLGXTD7OhjA7dUoeMlerZzigAbDjkZDnp+qeTIVw9oqKcD79tdaiguYQmYnGuHJwZCYL3MhfODs0p4u36afo8kk6AyM6hvC+ykI5S3xhBAZ9m1ChlcH3Qw3d6fz2ZfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035592; c=relaxed/simple;
	bh=D13OR5xsYh8JEaA5aDJc/1Dh9iYDdCdoFjWLWDwwfds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTAUn01j+i2Ud3DgOIxixakF7ccssj2FMT7MMQwymT7ApZy2qoH0C8N9a1G2oU0SZW9r+i0yF1rL6r6ck0rqKHd3KXnEMWtcf1zFQjaYLyqa/kY5zY6Q7OAy6atRfPBcKgkqjE7vygAYceJWXSr6e16G98o9p54Xaq01z6gtQz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOS6ZMdG; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOS6ZMdG"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5bf9466412fso1912373e0c.1
        for <gfs2@lists.linux.dev>; Thu, 06 Aug 2026 09:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786035590; x=1786640390; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rb7ASnE8Sx91CLFoiOKNMQmqUcK+VC1xbbyNQo6vc/k=;
        b=SOS6ZMdGM4EtegjFPCfbgCN2BA6kXFOhawJ3YSm5J1M+e6w5SQPgxk/LRw5mKNnwG1
         jN7BExts4AuCMXAiD+w74RQyhyO/t1oerCkkSyEEOqvWAFWxOQd+1Rz1meHiHoPxiP1G
         fmyCqvqnx0f168zH5oU1xgdv2T38t5oZxy0+i2kyV3GHJHk6FgRAiNd6hZEKkpnpTgtI
         gXUIuIi3yfjFnUCU3WHdrdHveVamJBplI5YBuOVNeuJl/wBavceYB1ix/7fI7N+NnEJl
         WBdLqNHY873eIv7bRTk5mmPd9Qxjo+0YZ2OdJf254LFtxnwVSU//wg8xsocgSjujxvtk
         PKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786035590; x=1786640390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rb7ASnE8Sx91CLFoiOKNMQmqUcK+VC1xbbyNQo6vc/k=;
        b=LH5Wzw2sjnQtIgKuTbHMfBvIja63YO7Uz7Yy0wE0UbKXPoFkMZ6kXsnvktExbQzSOz
         H21G68ixywj8IpWM7Vb949VIZH39IF/XDxZAU5fncfVEz20t6Bs2gpmLmd7R8BsEq4cz
         yPNK1BpprRciGZEmz/r7FHYCTVw6y+XD0TzU0294YhiIbAhYH8JImYxsXEEPZD4VNJkq
         vOFjtb1+UUnuucPZDy7fR6A1lfIrtLKm4JQ5kiUJO4wHKF3rNNnACt0A3u3lAeXvSTFJ
         VDU8kZJr1mJeFgxOONc2VsAVfHfwS5WXw87GZhaSXmnvrtA3S/TVfi4fZ1fNxSHNQ7Th
         QcCA==
X-Forwarded-Encrypted: i=1; AHgh+Rq9Vw99OlieAF9iAFxhboTgVPET4K3MZQxcoxWmLkSeYPC0f0rted4HsNt1Sjp/pOTk36OV@lists.linux.dev
X-Gm-Message-State: AOJu0YzugaHqJK5BFnb5li1ed3BjowxtUNddMFE6DuXitDcG11YVpDT+
	o9fCEKelG+Ncd1lz2zsNxz7mgdTVyXen+70JJ+SNLGYKQgREEeuQbp8H
X-Gm-Gg: AR+sD10gVcf/XkOlxZfb+VCwduF/zo4N1wKjmsP5Aou5/gZYOqcNYic+aMUYam8edMx
	goO6Cn/1pM3rNS6s9r+eJT810z7bv05j/pvVySKEtxHgxn4up6yRUpv/h+g7vt04kkyiyHakTCe
	rmz7gzE1nkcBwIuLdijRISJxvb/jKqGUL4UanydaNmLH44Dsodv2DI/PM76jVidKVu1AtMnbbvj
	JZ6UzF3DCYXdB0F0mpnIE8bR6Vugw9T22zEY42a1pA2vKfeJX5hyWmPE2zfh127AzIZ7oJrDgft
	UYNkMM+iPtYJOSokvzngu1O9IPU7yqbRUzgfEK7/0DEhnBKkp2C2PFPki6TRJAvOR4j7kbHn4fh
	kxtpY4gW1wzVr3wJFkaF3uXypRMoZgv4K2EI9mTrWnzot2smobmYSzwkk2G8CaAEkD2EqmFJ0Vg
	71i8MMLcbexoO3TGJzCiqyexZja8cgpiYUh5muCQIEax0xn6rvUslYlRBOyUGXVLSoyfiDkzalU
	dySWxk=
X-Received: by 2002:a05:6123:2e6:b0:5c2:b8a4:95c9 with SMTP id 71dfb90a1353d-5c3d924e663mr477877e0c.11.1786035589499;
        Thu, 06 Aug 2026 09:59:49 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c3d05c594fsm3706321e0c.8.2026.08.06.09.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 09:59:48 -0700 (PDT)
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
Subject: [PATCH v2 11/21] exfat: check for a directory write error with buffer_write_io_error()
Date: Thu,  6 Aug 2026 12:58:34 -0400
Message-ID: <0784ef63a525434e7c0aff730eca7b43e043095d.1785951556.git.coshi036@gmail.com>
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

exfat_update_bhs() waits for the writes it issued and then tests
!buffer_uptodate() to find the ones that failed.  That relies on the write
completion handler clearing BH_Uptodate on error, which this series
removes: a buffer whose write failed still holds the data the filesystem
asked to be written, so declaring it not up to date is wrong and makes
callers re-read it.

Test BH_Write_EIO, which is what the completion handler sets and what this
code actually wants to know.

No behaviour change today - a failed write sets BH_Write_EIO and clears
BH_Uptodate together.  It stops being a no-op at the end of the series,
where the new test is the one that still works.

Acked-by: Weidong Zhu <weizhu@fiu.edu>
Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 fs/exfat/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
index 6f11a96a4ffa..dfd0bbf31c94 100644
--- a/fs/exfat/misc.c
+++ b/fs/exfat/misc.c
@@ -187,7 +187,7 @@ int exfat_update_bhs(struct buffer_head **bhs, int nr_bhs, int sync)
 
 	for (i = 0; i < nr_bhs && sync; i++) {
 		wait_on_buffer(bhs[i]);
-		if (!err && !buffer_uptodate(bhs[i]))
+		if (!err && buffer_write_io_error(bhs[i]))
 			err = -EIO;
 	}
 	return err;
-- 
2.43.0


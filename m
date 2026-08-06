Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D7C46C836
	for <gfs2@lists.linux.dev>; Thu,  6 Aug 2026 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035557; cv=none; b=jmAM9cNzvYguFsoegf+T3+Hu4VhR3QNIPtv7buOLQNIpF75VGFH3HaY9fHl+cH8lyGKHzGlTxohmV3PdLPXBS7UVhcbuskNm8p/8MI5B/CPBlTjBmC6lHvSf57EjmqUoBOULZAnoe7FhUyz4UP1VpTM6z7mLYmP+HYDs3lZBcXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035557; c=relaxed/simple;
	bh=5Z1GSiO2bc0sbRA3/0yuB6INnEL0uS+pxP2xPMYMvWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IY8BavD4GrHOSLb2N6D0284JYwGCdsHpJNC0D4Im+NbSEKZwAPn70v5VsFArWj0wY+6os2lxOPYC1aXjSGw9oZZKQLJH2j4T5mFz+CWgcQ1zhCyz+dBQDjykEcUTaUPsQSz9a6Fd9zgspA/2aBOeeIigx9U7QyIuEmkq5TKLUcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ls4w5axF; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ls4w5axF"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5bf9466412fso1911762e0c.1
        for <gfs2@lists.linux.dev>; Thu, 06 Aug 2026 09:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786035554; x=1786640354; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ft6ziQssPBfawpI3vOIh0QGxtSEYHeudqaZ7dvpKRmU=;
        b=Ls4w5axFxevzpyOKUIuKow7vRD+SCOwxPG67r0vkRpURfIqYW1Svufrd+wY3Izw2fh
         cFVNDdShz5oSoBWhUSPi6p9XLwVpkaY9qrud5Mt1f9KKOVLJAlDr28tKsMAAfShwUdMm
         EibNVLu4cMG86bfM66H95CiFMPdewcR/tAjARQJQ+b+eqXVJOFUdwTgD890hgXXpNkkW
         QLCL9PY8AGlP+QBog1gervFpEqbuLtSJy9TRoPkDJ6Rdcq33T+zyRAGPwbX7bNzWyOZI
         py4mY4Bp2RsS27ht6b0guZMs17W38a32UC5ZD3/F6q7TqO3+7MwSffQjRlL9Psi8pqm3
         xESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786035554; x=1786640354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ft6ziQssPBfawpI3vOIh0QGxtSEYHeudqaZ7dvpKRmU=;
        b=VJ4wzraj/T4Oa2mHjDK6C4B32hCI7DNiZa7zmmQwY/Lxva4KD4DXYvxQ8Gar+OftqN
         LU1nXvaHzrGRoPm2I8yMPuf+wHBXNW7HZkRGRtZuEt8nTO9CVK/M1mLPE/dKJiqSmeoA
         orPW6Ff2EBf5FngmghviT3Ga6nRzDtoJ7ilT1OjxkpCXg51wSvcwR69DnGigPtsQJo8T
         vWaN9cYW5G0l5doOP2NfFN4SqGz64oZb6hsDku1UlwR5p81/2kQhLQCMUyRZm02ISSbu
         b5C48+LdZverzC28WpvRYYchIbrC6C726mvqrmuq9Kx2hncxpwoi0JBy+V+ClFR/8+t7
         rmHw==
X-Forwarded-Encrypted: i=1; AHgh+RoAbkpwIPU6SKFJGQX3S4ciGFQxO4kMXKGB5ehzoiPnbtTPeeVMjBApamRRaG39QOMCtYKf@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5JxFt4Hi63sPd4TKPo2MImNEImGLAwMmfvMnivAAVdpQGujcI
	LucHjQvbOjVxs7rrg34HeXb4lZtms8QaUp3GO3p7XGQAH3ixmStLEi5b
X-Gm-Gg: AR+sD10CT06XlOIPTzuc/2mCt3yCmm2CC5IKg8gcQ5sMrtV42YLmexuzQYUE7kRQ356
	4lTB8R64KbTQnCEhU6SyjRaTzT2wd/e15eSAoJqfe75Hcc7F/HQGO3LwBOvwwy+YywbonhDiOsq
	wvys2omkDSTJpHGk0FC73giSYUr6YF/rGB/pG4eCdzXRaIUAKxf9OyDoHtQpIuKafEvSNJFF/iV
	qgkJ8seA+6XVhN51S8lehFXH0iA7c0EeiLc/Gp6z2/f7tFFkXokWh90Yn9C79NoTiqNpCe96cvZ
	Ys1VCDKWFbOngGqZowh1AEsmAyYlOkPEV6GfaFB8kJufL1qiHK1md7vN6k4HrFYrme3WjIbpiXm
	uJj9TAgZCCBxclS8xJDDzu9jP4tm2BQGDeIxWilYtvtYEJQY4vIxwxWA3rtDxM4wJS2MCwJydkS
	tQLlUQ77Qa8EdfDKcRJnuMm6vbRWyCsI+c/z236IXaoAjs5uZlHKm3EbX9j6Moz6VHgXGx6qO+y
	K1AXQg=
X-Received: by 2002:a05:6122:1c85:b0:5bd:8c84:59aa with SMTP id 71dfb90a1353d-5c3d9162e78mr2479549e0c.8.1786035553890;
        Thu, 06 Aug 2026 09:59:13 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c3d05c594fsm3706321e0c.8.2026.08.06.09.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 09:59:13 -0700 (PDT)
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
Subject: [PATCH v2 05/21] buffer: clear BH_Write_EIO when a buffer is forgotten
Date: Thu,  6 Aug 2026 12:58:28 -0400
Message-ID: <ebe0b4f179ccdac7a9400fe2611623ce218c8d87.1785951556.git.coshi036@gmail.com>
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

BH_Write_EIO records that the last write of this buffer failed.  It is
cleared when the buffer is written again, but a filesystem freeing a
metadata block never writes it again.  It calls bforget() and hands the
block back to the allocator, so the flag outlives the block it refers to.

That does not matter much today, because the write error is also recorded
by clearing BH_Uptodate and the buffer is discarded soon after.  It starts
to matter in the rest of this series, which stops clearing BH_Uptodate on
write error and makes BH_Write_EIO the way a failed metadata write is
reported.

bforget() is where a filesystem says it no longer cares about this
buffer's contents, so clear the error there alongside the dirty flag.

Suggested-by: Jan Kara <jack@suse.cz>
Acked-by: Weidong Zhu <weizhu@fiu.edu>
Signed-off-by: Chao Shi <coshi036@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/buffer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index 2851830995d8..381690479520 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1091,6 +1091,7 @@ EXPORT_SYMBOL(__brelse);
 void __bforget(struct buffer_head *bh)
 {
 	clear_buffer_dirty(bh);
+	clear_buffer_write_io_error(bh);
 	remove_assoc_queue(bh);
 	__brelse(bh);
 }
-- 
2.43.0


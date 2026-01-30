Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB44B34EF1E
	for <gfs2@lists.linux.dev>; Fri, 30 Jan 2026 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769764903; cv=none; b=GUMLWmGNWCH2qHUb6EKzuI8utOKbXiqDQW/czEFsnchXuYgHyY/AU4veV19OFtRKyk6aM+j6ROa2isAbq+VmA2hvGMeqg+EfXZK7Ecn8v1eqe7GVRugxXsGUNN+bwWndX4mOM8MJMDg2OTBaCnB4NG8tvl31wwiMN4kYc2M68a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769764903; c=relaxed/simple;
	bh=Lela0ry8siNc7hGk4/vu1l+LVXOLLqVweXBOwVjgNU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g9iZPDM6nnWvUSrqAxq0XLUhTU1nIeSWK2eelIZjerFQuK/guaxRaOueF7i/Vi3BQTRx1kBOza016CEJuVWRxwkFImxAyIeXhC3DJGzB9wd/wYgM+EMvg5OdHs6Xhbo77tzTOaacBOI13DRcjMLxJLptOjKOm8hUSrBB+S8IvJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgtZT0yy; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgtZT0yy"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3530f597ea3so801142a91.1
        for <gfs2@lists.linux.dev>; Fri, 30 Jan 2026 01:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769764902; x=1770369702; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t+b+o8h8vodG0ADVK4B8Fa23C+lDACI7ZUVBlKr7S8U=;
        b=OgtZT0yyVxgzZr0KVvvvq+e+B5OsO0RbpJWH0mz1I6VYBkbRcolHk+ppk+yI3Zeslq
         yDAkuB8y9nqe7AuBXG/wT8/UFXeHYp/cKydhmLvAlD5jWHjdVd8cT4pgJPV4WsA60+x4
         IHBogtcVeVL/6j+9SmpDelJE28WEsRlzy4ORZ9RxelkfzkjX1q09dX8Xt0HTXRE1nlWe
         Dmp3jdoe0CikxLNJWnQ8g4OjyqkiE8maLosAHFqADtbCYZx6uNWqKjxe/9GBWJIItooM
         yMrIJcWynuTUCS9oEDUlN86pceNv6KA01Jn0xuKKwdnD42rR27knk8+W/suhJUqHm/ir
         Yvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769764902; x=1770369702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+b+o8h8vodG0ADVK4B8Fa23C+lDACI7ZUVBlKr7S8U=;
        b=NIErlG3uFE1lrRoL9x/+DU42wcWOmC9cLIOfPuIF+nnV8YTTefrGInzWX4s5SVO01B
         f5so3Hh/r4UIEcuvBN5vNArpI6m9DCSKDRfwpm0F9D3ZJMC7CUkyOINaw90PwVX/IMNH
         d+UiG22QKaL7W2k2w2BbMtnrNzl5euvOBgeCgF3c6rGa/UXvOHLYFPJhN5qfCS97IXom
         U5pwOkfJAg7UOE4hL2i0KZxUUGpZYglFNBjmGHK203VXE2XnUuMnck/1Y8kN5QzYmyJi
         yJYVqZPP5hjYDS/uHgqjzyEZTyiqBQ9AAbomY5SgUs42diWXKW8yUYj5zieeHSwDMGpJ
         iIxA==
X-Gm-Message-State: AOJu0YzUOHS+If5L9rNah6+iiBm0JLNJ9mC/xCk8taseI+GRNhqu8WpN
	FafqMRSMZ1/zanYpjaNsZXHUUkj+5hbf9UrZ42U8o1wuZiWodPtayemy
X-Gm-Gg: AZuq6aJjJ6lu8MCzQLiw724aeqYaEKAbhrsgNGRjCZBkJr+GmmFF9GP4DdH83bgv35/
	yicvu4R9jkrv0anczUDU0L5e/HffG0Xb/4GqB0NZxePv/Wze/cd/Z3GDLL0uHDmadAX51yMJ4m5
	PWpTEc+Rn7UPmynbbUj3Gay6q3OgLn2tTzPokq/0UXMVDDtZXedeRDQ01DjfcxaJDFJQIf76ggQ
	p54HHo/Bm+yf+XIb12hJdDF+0YbOcxloMQq70osEnwdSEKhCKtnJC0Sx0zYKz48flsMF2RSoYZa
	RTcuVxP5gUSt7FO6wl4QCZcKzJt/eMH1RuecdXpmOQBzN29fC/WSr1f/VDovlTxv8fHbIco6lmu
	zCtpbuDKQHvoqAyt1DdjrqG8/GEILmtAdy4WuhrxVyVRaKhOjC12uWVKo8EBdQLUpZdJ2S68xob
	UfsSw/8Icq7IHSfMu1PzGTZ5kZ+mRkNDLL2cDj9nCutD5/jJT3Qsw4ObSk2l+PQZY5MA==
X-Received: by 2002:a17:90b:3e48:b0:33f:eca0:47c6 with SMTP id 98e67ed59e1d1-3543b3acfdbmr2031178a91.30.1769764901949;
        Fri, 30 Jan 2026 01:21:41 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:46b0:a00:42ac:8b2c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3543d5afb5dsm569271a91.8.2026.01.30.01.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 01:21:41 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+ea1cd4aa4d1e98458a55@syzkaller.appspotmail.com
Subject: [PATCH] gfs2: Fix use-after-free in iomap inline data write path
Date: Fri, 30 Jan 2026 14:51:34 +0530
Message-ID: <20260130092134.62407-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The inline data buffer head (dibh) is being released prematurely in
gfs2_iomap_begin() via release_metapath(), while iomap->inline_data
still points to dibh->b_data. This causes a use-after-free when
iomap_write_end_inline() later attempts to write to the inline data
area.

The bug sequence:
1. gfs2_iomap_begin() calls gfs2_meta_inode_buffer() to read inode
   metadata into dibh
2. Sets iomap->inline_data = dibh->b_data + sizeof(struct gfs2_dinode)
3. Calls release_metapath() which calls brelse(dibh), dropping refcount
   to 0
4. kswapd reclaims the page (~39ms later in the syzbot report)
5. iomap_write_end_inline() tries to memcpy() to iomap->inline_data
6. KASAN detects use-after-free write to freed memory

Fix by storing dibh in iomap->private and incrementing its refcount
with get_bh() in gfs2_iomap_begin(). The buffer is then properly
released in gfs2_iomap_end() after the inline write completes,
ensuring the page stays alive for the entire iomap operation.

Note: A C reproducer is not available for this issue. The fix is based
on analysis of the KASAN report and code review showing the buffer head
is freed before use.

Reported-by: syzbot+ea1cd4aa4d1e98458a55@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ea1cd4aa4d1e98458a55
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/gfs2/bmap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 131091520de6..e70095809e4a 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -887,6 +887,8 @@ static int __gfs2_iomap_get(struct inode *inode, loff_t pos, loff_t length,
 			      sizeof(struct gfs2_dinode);
 		iomap->type = IOMAP_INLINE;
 		iomap->inline_data = dibh->b_data + sizeof(struct gfs2_dinode);
+		iomap->private = dibh;
+		get_bh(dibh);
 		goto out;
 	}
 
@@ -1144,6 +1146,12 @@ static int gfs2_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 
+	/* Release buffer head for inline data */
+	if (iomap->type == IOMAP_INLINE && iomap->private) {
+		brelse(iomap->private);
+		iomap->private = NULL;
+	}
+
 	switch (flags & (IOMAP_WRITE | IOMAP_ZERO)) {
 	case IOMAP_WRITE:
 		if (flags & IOMAP_DIRECT)
-- 
2.43.0


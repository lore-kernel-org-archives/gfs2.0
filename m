Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1628C2FFFB8
	for <gfs2@lists.linux.dev>; Fri, 13 Feb 2026 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770974502; cv=none; b=A2BsL8d5N5h+gmqD7rbtvJSzrV/Bp5rQ0MVKI0K1YHJ7gwrTdK3xBBP1tAZO2y3hwqZHF4gBufEGncL8VmAf7Ejg4vAZOtmYtx+ftKr95NB4aL+Fkom24uMLJ68s529OW7tesyhU70H9+/KvdnawTvx7ATnYTsvs6MbxseCYtXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770974502; c=relaxed/simple;
	bh=P3ol9aqljEQY0v+2iW18Y+12Wzl2ereqTmmO0cad0W4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IR9+dNniRbmRkRX9icTWUoE9pauckrHMIn1KuA5+UpV55YcEe8qdFHBtTAwAJzeB/qQ9/6OKpqXvDOkLkQ4oSpScW+m1bhmeeUF6AJBLImjIigIY/j26ZrlGGumMhLIt7K+B7VQUidmGoJQCmJE1KvqlilA63YZBy2uh1+hEhGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNcFYOTk; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNcFYOTk"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c61343f82d7so276497a12.1
        for <gfs2@lists.linux.dev>; Fri, 13 Feb 2026 01:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770974499; x=1771579299; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pawZyXic9z3C+Wqw4dOXYOgYxfcCdwdIL0wQeRYt6jo=;
        b=PNcFYOTka4/9GwwtCe8HMZDyffq6pJLszEWfJg0fgr7uZMT1buzz5jx5teZSOo8es6
         4J8nt7967F3WFGiLdaaYQnrPbvla1hmfpM9gGUPyhZNHwY83Aws2Q9PkCOGvPkxXfAj6
         xhllXBVxnyUqS2QZr9x5Wra789etUbDeMhr4/40W0wCKxle8urTFkCv3XvGk91VxLU/i
         tLRdrab2d8cqNFGu1ex3f2Sk14n/AmI4QYU/PQQ56ZloPcLpqi4xhYfXINM27neyrJbc
         DZ3i5i+MSNdgv/umpua799gtgaz1AN47HvlNHhFe0k1166xjJ3AfTrsIPWhuMD9Aa6dA
         VquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770974499; x=1771579299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pawZyXic9z3C+Wqw4dOXYOgYxfcCdwdIL0wQeRYt6jo=;
        b=Jfj+uI77+oV4y3IoMXUmwEWivHQv7Nbu+9AUNkmGa3y3uJzpdu1a05F61maPOeePpx
         Rlte43O++PGNV1ZuaPCgPKJ9h7asaWnqC4JOEAtDlA3h31+szY12dNe8XvQcww5WLONi
         eX2vB30h8YQmTe2CvSX0cQs5Q2in8KzbjHaZEabJpD/4xqknW0W9hgv069yHTOIWOYhx
         swe/lYri6z+1vGFuZiyxQPWUwiXRnZrNXpvLwsP7st9sWNvq5XA0v/N0Ug04qP8QMFxm
         JY3d/qy17RDjRixx+0Y9ZcjJLksjZiHA4dvNVlfx6BVRLTh9WiKTeviZeSPUIb9tVjKc
         j0Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUCfePR/qdXABP6aqGWGMgnmlKt7CAfKGMxy1juZyHTnM/1IRD6otxBcYpCGANRZccq927l@lists.linux.dev
X-Gm-Message-State: AOJu0Yyw8zVegV6ROySolU6HyWutB0h0Vq8fq+LibgrZgWUvGD1KTwf5
	ZPccjj/ULSBNFLvEvy5K/8HCNW+EGKotxsWxcIm9TAXXQZHQ/sONgDM6
X-Gm-Gg: AZuq6aKbOWOJAqgTrqRt7ZG0BJ9vf/jurT7eGB6XaFNH2uAg2C63B3GngFZ6vUCyitN
	aw4lzKQRBKvg7VRqeKtA0gEtwpBOaIkWaXPKqAPDGTzgigbvSg8QdMqqG/cMsFKYpe+11X0H0+x
	ccwmle+498lcc5L8YSEYpzyki9I/EY7KC/4B4Qk8NlvTVGnBv5ux4nVuDK6ni2P6t2WQi2ZhOg5
	n/jy6mDs565qrVwO0DYpVgOA6Tkq4Qg52tllage3i5+dYFsOlDJZvoYE7wTxXrrwqW+0ee1AYJA
	ezupKp3C+ZPOGoGYCY/XRCb0dBmLO0tnaTwW8sLmfdFPihTswb+iECorVhuEa6/wAyQezOrBVYO
	dYa6kqJT6l62M1Onxe+l5GJmfcv1rnaIOIhYMb5N+sYCaM9VW6O83NpoNbNRSGOaFWhz/P+pG65
	QlZQBd8mNIxRCgiDOpKSE2aico0BV/cp8u1+Wu5jOBV5fcaHMZNA==
X-Received: by 2002:a17:90b:1f8c:b0:356:2eac:b649 with SMTP id 98e67ed59e1d1-356aab9019bmr1392445a91.7.1770974499377;
        Fri, 13 Feb 2026 01:21:39 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.214])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3567eba9451sm7392202a91.10.2026.02.13.01.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 01:21:38 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+cff8e1b82d7911dd051c@syzkaller.appspotmail.com
Cc: agruenba@redhat.com,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [gfs2?] general protection fault in gfs2_remove_from_journal (2)
Date: Fri, 13 Feb 2026 17:21:33 +0800
Message-Id: <20260213092133.2440431-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <693b73ba.a70a0220.33cd7b.0044.GAE@google.com>
References: <693b73ba.a70a0220.33cd7b.0044.GAE@google.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index e4356198d8d8..3a60a8bd80f7 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -349,7 +349,8 @@ void gfs2_remove_from_journal(struct buffer_head *bh, int meta)
 	if (test_clear_buffer_pinned(bh)) {
 		trace_gfs2_pin(bd, 0);
 		atomic_dec(&sdp->sd_log_pinned);
-		list_del_init(&bd->bd_list);
+		if (bd)
+			list_del_init(&bd->bd_list);
 		if (meta == REMOVE_META)
 			tr->tr_num_buf_rm++;
 		else

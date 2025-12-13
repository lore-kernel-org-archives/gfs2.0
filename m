Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A878F49
	for <gfs2@lists.linux.dev>; Sat, 13 Dec 2025 06:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765608193; cv=none; b=GTkIEVqwffLh7BFAPZ4uwxYEEzoES44sXeVa7PVjbqMUHP7Pz76hggOrJQ++D8/uq2qaweia0sbHXABTiJfy+vHK1htiR3rBssBIkhXf5DSWFo+pQzMiyT5D5tbJOLoUSoTdhgtl3Amg/8OBNnPc7mYwlmUg7Vdtl6RrRM8bZow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765608193; c=relaxed/simple;
	bh=C3lSCMOJht2Bq03lxV/OkgMVuaU29ien5FqxfFGYWjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OWqPn8+hMX7PTpPvSRHWA7fYRBO5IBHXwZayPEnwYiYwkyosY5iJbC9bI0WFnB4HT4QpD5NxPN7AzKySMvu30j7Xq4BR0FG7I9cCPeEUdpqZcw+Ke1urhazAz+KiJDVEuioaxhoeyt7NznVMD+1qnkt5LaL34jv4NlbxafKAEeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOjdesDc; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOjdesDc"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso2035561b3a.3
        for <gfs2@lists.linux.dev>; Fri, 12 Dec 2025 22:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765608191; x=1766212991; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BRpSV6RgpSXu2TxYA6JTWEB1NQC8YeikIKjU+s/DpyA=;
        b=bOjdesDcCOJOPe8MM208zAkhUr7/st0tZwwNY6gyyv9h82KLPQew51iwi9dErnh7PW
         848l4dZiI8sVdvXQ4txImAkcmxjuCJ7DNHkssMmeuLoesnVW8mMp7RgGKHvFnRcLCYWl
         dTtKKkGgvIEIdwOdb+JVzjzAdTpZymw9M2G3gYup94Glr9MUWs6gGILlxhvr8n0z3r1T
         bc4QznFuNeQswHaSfvrpzSdqQD4mJjTFYrJxHqrIDH8e+n0O/eVQmZVhuV4sgQPt3t1v
         LvebM0Qmx0lGNLml8k5RCig4p6G8QE9dMUpWFtUACHrhB2kOgBzLRpzlsD2JZPUAyYyD
         6S1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765608191; x=1766212991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRpSV6RgpSXu2TxYA6JTWEB1NQC8YeikIKjU+s/DpyA=;
        b=An+DA7Pg7GaIEXIbS60KoQJGovfsRJMGPGoHI49WkrHvRjQhClLlZqE8wAShy+MV2h
         101KFmj7UnPLEIeoWxzCkIRT9NqlT1ZS3vVDPy9YuUp72r4AFo4cyFIgvQf6W8HG1sWb
         mzNWK8YXNrg5sBrByJLB5tAddWVxCP5txwv2YHAiDl2chUaWr/8KFQ4vpzogjEiI1My9
         4ZlHjCQ9Cw6yr2HuEOLZchtYNqpsY9v5QpKQ7rGc8Dxapg6TqGjnkHFHGjDzLVQQha+E
         Cg6wi5TWJWUaMWt0tS7rl7QUpK1Fb5oXU85Fvll8GZcCN7ZPViXf5XNeHYrdaKS1bTUN
         3pHw==
X-Gm-Message-State: AOJu0YwE/cK6urXjr7fyrLgDE5+ruN+TRI5D+OqTRdIgjOyZ2Tc66sX0
	0TJNDKxLCKCcsz6GpOcLHisB5b1LrDFG4S+hZzUaIOye+CVfUrCejEca
X-Gm-Gg: AY/fxX6K15jBErp/6iyl9vl4lAB5f1x4kHAGg7+j3rkA8x31Uj6S2VDwfVlF26bzlSs
	I0dB/H3CtnCBOj06PF/aG60Nifero1/pwth7eol80j3RQVETTxqUAz2LkUkB7y0aB2hLhidgyvQ
	AYr0aKd8HtOWOex0eG+oZcJbVBwb03UjVXe1kMBaam8MOGQRUm6K/FYiUpRVhXI4MjWGN+OmiTf
	s/Gn/YaMnm+wjK8p6uXB1Cl4RaojyoYdmqRq/m6sYfQe4M91ZF8f2T1t7BSYERHIS0W025AA534
	RLS8Ei1YXQApigWugXaFVUFa4ICdIDMhBlHF0AFdENBa1THBsQ1szAIDE41fq/7Hy7yRI1XQApq
	8dR6a/aR24IXu1mMwoaC+WixLNvdZvweGxKEO227R8iV/yvtQ5ECXYWem6ZWJXF+jHkkgg9Xx79
	Nt1eU/ATKMEYZpY81FH9XPpLS886B8pKchPlceoSSNf8CSzRUSTaT19KOwTfURVJkyfWo=
X-Google-Smtp-Source: AGHT+IHJvu2hbqmMjZCT5aKA7vpe4OhpcjZqMpzAEvy73wqndlRBnM2g2lfzG04dZlot5WhTKjYsSg==
X-Received: by 2002:a05:6a00:bc8d:b0:7ad:9e8a:1f72 with SMTP id d2e1a72fcca58-7f66f9f2ee6mr3514893b3a.14.1765608191224;
        Fri, 12 Dec 2025 22:43:11 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:f267:ca6a:aede:ba4d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c4aa9b94sm6993180b3a.37.2025.12.12.22.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 22:43:10 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+046b605f01802054bff0@syzkaller.appspotmail.com
Subject: [PATCH] gfs2: Fix slab-use-after-free in gfs2_qd_dispose
Date: Sat, 13 Dec 2025 12:13:04 +0530
Message-ID: <20251213064304.148987-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In gfs2_qd_dispose(), the quota data (qd) is removed from qd_list and
qd_hlist, but not removed from the LRU list before call_rcu() is
invoked to free the object.

This can lead to a use-after-free when the shrinker (gfs2_qd_shrink_scan)
runs concurrently with filesystem unmount. The shrinker attempts to walk
the LRU list via list_lru_shrink_walk(), accessing quota data that has
already been freed by the RCU callback (gfs2_qd_dealloc).

Fix this by calling list_lru_del_obj() to remove the quota data from
the LRU list before scheduling the RCU callback.

Fixes: faada74a90563 ("gfs2: Factor out duplicate quota data disposal code")
Reported-by: syzbot+046b605f01802054bff0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=046b605f01802054bff0
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
Note: Only compile-tested. No reproducer available from syzbot.
---
 fs/gfs2/quota.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index b1692f12a602..85b0b5105b4b 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -125,6 +125,8 @@ static void gfs2_qd_dispose(struct gfs2_quota_data *qd)
 	hlist_bl_del_rcu(&qd->qd_hlist);
 	spin_unlock_bucket(qd->qd_hash);
 
+	list_lru_del_obj(&gfs2_qd_lru, &qd->qd_lru);
+
 	if (!gfs2_withdrawn(sdp)) {
 		gfs2_assert_warn(sdp, !qd->qd_change);
 		gfs2_assert_warn(sdp, !qd->qd_slot_ref);
-- 
2.43.0


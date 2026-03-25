Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FE61DE8AF
	for <gfs2@lists.linux.dev>; Wed, 25 Mar 2026 23:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774482725; cv=none; b=emYqQl9JYLZSjc+deWWnUMDxSSgACVn5ZYxztB0C0pkd9/dbcVDzEt9gUlmlVmBYY/Q/Y6DIQFBcGqPe37jLvVE5hP6dtxmvoSjYpMfvccWw37GvEEe89VRzO3tCztXdZEegLRlQVXCAx8KxxnJdMXMZQnEfqB/CEfjtS94qJbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774482725; c=relaxed/simple;
	bh=2FvDzr0zkKxpwWcAuam0W5y0bIC8jjvBBrRXotJfBIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q0OIKjBLSlNJMANAvyUAvIZA7SyAb0r6unBR8ekj6bmIACVuypMibZe7oG+qjPHsrgcx98BDOH5hgERnOgNMQAigOPc2eN+lLoWQ5KkI3ngjPpXWTgIEJurFahw07kzWcd/R7Z4kgNrpDc9ZUX6hAkX3o0sCni2vgxbYK3bPoIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDaVwzFr; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDaVwzFr"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b04d051664so3611305ad.0
        for <gfs2@lists.linux.dev>; Wed, 25 Mar 2026 16:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774482724; x=1775087524; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ChE/DCAkwjRoMSkqrMLv/NhoJxc6D54T4bw90LEXp/w=;
        b=iDaVwzFrj3sHaspwjEImYvDumSYkkTusv3aRTlX2NY63LyL2K08u4dfMxTdLz9eQNk
         FWUdt7EhjoETZJg1M+C9uqlKU30eYisSCnlOm+WHxUMXM9UHxOuMQvQ+A+zKB48WPCe3
         4lRxlt930vBhUJxa+6ZvMXuS5owvKnmTQFrotHv6dgd68y8jLN5B+tJ2JPcm7oJrXJRj
         A3OhU41/b9kssVxkVljWOwLQRFQEtewmqjlNjDUAv0oAFcWJwieBao8PMRe7SYz6M16v
         m4xsmWc8hR4Qym4lA1i7fZOE0nVPtikfBBtowJEoZdCY4uvxh3aoFq6yPtoaezcXEvT9
         mT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774482724; x=1775087524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ChE/DCAkwjRoMSkqrMLv/NhoJxc6D54T4bw90LEXp/w=;
        b=DRhy5ytYZTKn4C7LKie0SnXZcAWEitFOnL5OeetBvVdhLOaCkh5hRrefNUnj1R1xhh
         5TpbCm/gnKbRtbcp4ty81vfBwsR3+LF/LMHdWrbppJdrp3IvxYF0LkTzs4VIpV5ZCe4C
         aqB3bBZ2QXl3bD/HI7tavNRof7B/M9ffr4S1lZoY1chxRu9YACjWq5T48nF/tMhT6mxc
         DnYQcKMGG1ElAx6B3QTCHciSrFDb9HX3qq3EEGnRR6z3QBcliSBG+8g71bBtKBkK1Ppl
         6LOGrMBh+kio4d7crZMjk5MLD6ArK6TJicored2DiTREs6ydZV6AcvgVSCZzKuxz69Zw
         4ZFg==
X-Forwarded-Encrypted: i=1; AJvYcCWO9BhhK45sWsTY1Gqs1+UygqbZsMgnQ9ZKH40aLiu4SUTSFYii8w7EmY3sKXA0IBWOgoiZ@lists.linux.dev
X-Gm-Message-State: AOJu0YwL/62bfR0mD7HPjyHhh3feV/jDPFpXZvz/3N8fvnFmy9UzG0Vc
	yMF6RHz/DdQryxyHmxK/7wYoH4etYEn7vAUHiY1ZjHJe0y/muT4/QuHg
X-Gm-Gg: ATEYQzwthu1dBtDyd1O29TGT86Hp/K507XrZnj2DuzSovHfLT+imjHcsdMcz92Q0vIa
	mjwr5y91qZBXPwgwyxIKKe9vVwugayG9jj8yeQ7n5MEbT+BFcisu9v3Kbkmlmlv352pRmQS3Hzg
	qF3+Rf9oRtI+dBHIbhgVNgXegN66WFnHTa3FO5+TWezksM8cZViUzgOOM1O3MmEUHSTwkw+HVY3
	sjdEEUGCRYNTjAT1zwwuyPdA02Okw39AdBPvQY9/qBA2CoCBfDRcIkrfveDpgpZu68UOlKbF579
	h4GFlOs14N7B8rQ6YsC3GDvTQaNiF6dtO69pJgT6eCOzK8zVbXn/J2KM+hPzZv67U26vF3N63pk
	pPSxOqv5fnwKd1ayFHCr0OeYSgzIV//I8Rat+OpZlx/9oSl+31mtoY3Swf1NZBezqQxaqlqRT67
	mM3HWmagGEY3YrbG4rudQ5mIl3K5uvB5Sq9hBxWaCSq3K7CkDxHTygALiDWKHy47JmUf+3KGwCD
	4oSM8w=
X-Received: by 2002:a17:903:3845:b0:2b0:afad:7ac4 with SMTP id d9443c01a7336-2b0b0ad24ebmr62189835ad.26.1774482723961;
        Wed, 25 Mar 2026 16:52:03 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:aa3b:c188:588e:e0f2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc916b73sm11285755ad.83.2026.03.25.16.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 16:52:03 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: agruenba@redhat.com,
	willy@infradead.org
Cc: adas@redhat.com,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+9013411dc43f3582823a@syzkaller.appspotmail.com
Subject: [PATCH v2] gfs2: reject journal extents with gaps
Date: Thu, 26 Mar 2026 05:21:55 +0530
Message-ID: <20260325235155.9503-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A malicious or corrupted GFS2 filesystem image can have a journal
extent list with gaps between extents. gfs2_find_jhead() advances
blocks_read sequentially through all page indices, but only grabs
pages for blocks it actually visits via filemap_grab_folio(). Pages
falling in the gaps between extents are never grabbed. When the
cleanup loop at out: calls gfs2_jhead_process_page() for these
pages, filemap_get_folio() returns ERR_PTR(-ENOENT) which is passed
directly to folio_wait_locked() without checking for errors, hanging
the kernel task in uninterruptible sleep (state D) forever,
triggering the hung task watchdog.

Fix this by rejecting journal extents with gaps at mapping time
in gfs2_add_jextent(). If the new extent does not start exactly
where the previous one ended, return -EINVAL to reject the
corrupted journal early, before any I/O is submitted.

Fixes: f4686c26ecc3 ("gfs2: read journal in large chunks")
Reported-by: syzbot+9013411dc43f3582823a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9013411dc43f3582823a
Link: https://lore.kernel.org/all/20260324033959.1456418-1-kartikey406@gmail.com/T/ [v1]
Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

---
Changes in v2:
- Instead of checking ERR_PTR in gfs2_jhead_process_page(), reject
  the gap at extent mapping time in gfs2_add_jextent() as suggested
  by Andreas Gruenbacher.
---
 fs/gfs2/bmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 1cd8ec0bce83..d3ba37291e4c 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -2219,6 +2219,8 @@ static int gfs2_add_jextent(struct gfs2_jdesc *jd, u64 lblock, u64 dblock, u64 b
 
 	if (!list_empty(&jd->extent_list)) {
 		jext = list_last_entry(&jd->extent_list, struct gfs2_journal_extent, list);
+		if (jext->lblock + jext->blocks != lblock)
+			return -EINVAL;
 		if ((jext->dblock + jext->blocks) == dblock) {
 			jext->blocks += blocks;
 			return 0;
-- 
2.43.0


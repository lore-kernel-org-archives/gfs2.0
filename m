Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6333A530DE5
	for <gfs2@lists.linux.dev>; Wed,  9 Sep 2026 11:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952880; cv=none; b=q7lX1tv/nTp8SN8tokCBYIMVOg9VGOWfs35OqKXuAdccKMB1UBXKhoFxKgLu8R9J26YaiKnFSNtemLzQ/HJB1VCzDX3XJvRyNr2JW9IG8M8fFcBbI5yUsTyJo3p1GRiVQlPrVRnO0A7tvW5EdvzeR2y58rLcTePmKtDsf9GFTUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952880; c=relaxed/simple;
	bh=ejKLOMfYN5cbTm0XLhNm/9cnSoVZpQ0xyMtLlfidjgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=InYeT9YocIrdV79Cv6CxrcRKDe2oM9PcK2e2kZC12Qrxso2+ba3q8gifWeceR5/53Ia1ZLaWnYTuJUJCFihuZed3AoHsHotkAkhmOOjeA2zg6bg9Bs3sAUVFGa76qjTp4FikK3OWCBtGjQz5pl//btCuhrbGZ/sSo16nx1DOq9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ee7LyE9w; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ee7LyE9w"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso5352359a91.3
        for <gfs2@lists.linux.dev>; Wed, 09 Sep 2026 04:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788952879; x=1789557679; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AUHFFioMah0sAuoQzwWsCFgryzdcGUF6ghThqp3wfNI=;
        b=ee7LyE9w3jSWgAxAZ0qa47SbhVcbSKLp5QVY9NG7zYHvASrDyE26+mVqSYXRW4IaQj
         rBxrQs4ffmv5oGCl4aqghPRhbytU8ibHOeN+qiQLwETlY3jD+CAZjPcJGlETSb0mDej8
         zkuATtHKd9iDCNwUsS+rr7G/wemE1wWCr/jiMa41SIsfHHjHmv4+oCbyr3v/pxOvOc3U
         xTpcp2VJ66InZRrJRE32FT2dIAer8q6YOLVPaiZcAOKr2kFH+6ucAQIbRH9egp2kdrSq
         8B4H3pKOGd6xnxt2dcC2z9RF3WdvzzdkwxQsyFNKnsOlkLhFlV2hRZbFLPktpccnynpz
         5iCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788952879; x=1789557679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AUHFFioMah0sAuoQzwWsCFgryzdcGUF6ghThqp3wfNI=;
        b=BLL3lE9cPQrHCY5cLcEqEvKtJYxxzEmY7LpNXQRTdLcyA2be4ZiSUaK3oaOuD+YvtK
         3XNx4xX+v+Cx3xGAw8hbnmF8Po50guAh1SZXHF7DPx61dyhx2S8yEPDT658NUZ38YQRn
         GhxEEypsthe8F38pJlleLiZD/l1/z52My2NBhU5xAfTzOn+muI6E2F2nq814ytGR86LH
         NLDPj66C+1LRcaMWw7NMiMDmi5q2C81/3iqLj9PakqMWoLIEO9bTd3/V7WEXlTf7VAyr
         bJUZny0vS7MW/OemDPKSBwedNDFlAUvlcdSY6Jr6kZr3wXftWIcMWq6ZknDEUoS++HSX
         HbUA==
X-Gm-Message-State: AFuF++kPO7WiO5lKGBToU4BhixCeK3NwN7Ey3HNkYBnFkFEFXvfKfH2i
	JtpNbJxQnwJv/m/eoDJejCPlNLjbGEtptlxGBYrneOT1dBtfhTfalDwGuThh1I/2ngg=
X-Gm-Gg: AYBFou0StY+pbbpYXSG4hrHFfC1a1W4gyqqqF3dcrX+iPOFEZQIJRb3h4zZWLFhPddy
	hLKv2yDNSfov843lUMko+X2wH2dt2tW9W925sI0M9z5hzfVf+ll/Jrjuns3YWX1LOSF2554AiE+
	5NowaZtZgDG6lfoSlfN12XguAaL2BwBN3gjK9rEiWb3mrXM+LOSMi86RXz+h+aKA6m3WLlRq2lV
	ZzNnvwN5PHHIHP10hbBKwBcmcqYgBde3FtMdwxNz9Gei8CNsSzMycCx3eH5Q7AkwCQRER2ogvNI
	Zf5yMNJBb5NB8pQ4e9yVvBnvNB5mzQW0LmXWtJciRO2gaXr8hNs/u21c7+5tcW82OCYbouLSN9W
	/5oQ4tBNLcVAPleBfc1wicI+DEVa/dtYSd4nzxriy6h/RJbpIDrMpjcyQ//Fr6W3VNUMNkcusMH
	K2zRIBkhZawbkb+cSqrduG0+1m1mlBicXzchu2jHdNdMtzLliFhnOxPCacTBCGapq+SYGYpbfcD
	0g3UIDwH5XcbQgWurUTwO2CPtXF+YTjc+Q=
X-Received: by 2002:a17:90a:1188:b0:39b:a8d8:985 with SMTP id 98e67ed59e1d1-39ba8d80b06mr5282578a91.12.1788952878427;
        Wed, 09 Sep 2026 04:21:18 -0700 (PDT)
Received: from LAPTOP-450UDG4J ([223.185.135.143])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260cd2aasm31265258a91.3.2026.09.09.04.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 04:21:17 -0700 (PDT)
From: Yogesh Gaur <yogeshgaur.83@gmail.com>
To: Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	syzbot+da6dc573ce5e6624f505@syzkaller.appspotmail.com
Subject: [PATCH] dlm: don't return a lkb that has no rsb from find_lkb()
Date: Wed,  9 Sep 2026 16:51:08 +0530
Message-ID: <20260909112108.2281-1-yogeshgaur.83@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

_create_lkb() publishes a new lkb in ls_lkbxa, which is what assigns its
lkb_id:

	rv = xa_alloc(&ls->ls_lkbxa, &lkb->lkb_id, lkb, limit, GFP_ATOMIC);

but the lkb only gets an rsb later, once request_lock() has resolved the
resource name and calls attach_lkb():

	static void attach_lkb(struct dlm_rsb *r, struct dlm_lkb *lkb)
	{
		hold_rsb(r);
		lkb->lkb_resource = r;
	}

So between those two points the lkb is fully addressable by its lkb_id
while lkb_resource is still NULL. find_lkb() will hand it out, and its
callers all go straight for the rsb without checking:

	r = lkb->lkb_resource;

	hold_rsb(r);
	lock_rsb(r);

For the userspace API the lkid is simply whatever was written to the
misc device, so a lkid can be aimed at a lkb that is still being built
by another thread. hold_rsb() then reads res_flags off NULL:

  BUG: KASAN: null-ptr-deref in rsb_flag fs/dlm/dlm_internal.h:386 [inline]
  BUG: KASAN: null-ptr-deref in hold_rsb fs/dlm/lock.c:334 [inline]
  BUG: KASAN: null-ptr-deref in unlock_lock fs/dlm/lock.c:3333 [inline]
  BUG: KASAN: null-ptr-deref in dlm_user_unlock+0x2ab/0x690 fs/dlm/lock.c:5956
  Read of size 8 at addr 0000000000000050 by task syz.3.570/7893
   rsb_flag fs/dlm/dlm_internal.h:386 [inline]
   hold_rsb fs/dlm/lock.c:334 [inline]
   unlock_lock fs/dlm/lock.c:3333 [inline]
   dlm_user_unlock+0x2ab/0x690 fs/dlm/lock.c:5956
   device_user_unlock+0x1ca/0x260 fs/dlm/user.c:321
   device_write+0x905/0xed0 fs/dlm/user.c:590

Reject an unattached lkb in find_lkb() rather than in each caller. Every
find_lkb() caller dereferences lkb->lkb_resource -- convert_lock(),
unlock_lock() and cancel_lock() through the r = lkb->lkb_resource above,
dlm_recover_process_copy() the same way, add_to_waiters() via
lkb->lkb_resource->res_ls -- so none of them wants a half-built lkb, and
a lkb without an rsb is not a lock anyone outside can name yet. Callers
already handle find_lkb() failing.

Testing lkb_resource under ls_lkbxa_lock next to the existing kref_read()
check is enough. The value is not stable under that lock, as attach_lkb()
does not take it, but it does not need to be: once a non-NULL rsb has
been observed it stays attached for the life of the reference taken here,
because detach_lkb() only runs from __put_lkb() on the last reference.
Observing NULL while attach_lkb() races is the case being rejected, and
the thread still inside request_lock() has not returned the lkid to
anyone at that point.

This is the null-ptr-deref only. The refcount warning syzbot reports in
dlm_user_request() itself, where hold_lkb() runs on a lkb whose count
already reached zero, is a separate race on an lkb that is past
attach_lkb() and is not addressed here.

The unchecked r = lkb->lkb_resource goes back to the original DLM
import, but an untrusted lkid only became possible once the userspace
device interface was added, so that is the tag below.

Fixes: 597d0cae0f99 ("[DLM] dlm: user locks")
Reported-by: syzbot+da6dc573ce5e6624f505@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=da6dc573ce5e6624f505
Assisted-by: LLM
Signed-off-by: Yogesh Gaur <yogeshgaur.83@gmail.com>
---
 fs/dlm/lock.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 2609e4fdeba8..73e92237fa07 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1554,9 +1554,17 @@ static int find_lkb(struct dlm_ls *ls, uint32_t lkid, struct dlm_lkb **lkb_ret)
 		/* check if lkb is still part of lkbxa under lkbxa_lock as
 		 * the lkb_ref is tight to the lkbxa data structure, see
 		 * __put_lkb().
+		 *
+		 * _create_lkb() publishes the lkb in lkbxa before
+		 * attach_lkb() gives it an rsb, so a lkid that comes from
+		 * outside can name a lkb that is still being built. Every
+		 * caller here dereferences lkb->lkb_resource, so treat such
+		 * a lkb as not found. Once an rsb has been seen it stays
+		 * attached, as detach_lkb() only runs from __put_lkb() on
+		 * the last reference and we are about to take one.
 		 */
 		read_lock_bh(&ls->ls_lkbxa_lock);
-		if (kref_read(&lkb->lkb_ref))
+		if (kref_read(&lkb->lkb_ref) && lkb->lkb_resource)
 			kref_get(&lkb->lkb_ref);
 		else
 			lkb = NULL;
-- 
2.55.0.windows.5


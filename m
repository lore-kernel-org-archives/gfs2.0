Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CDC3AA187
	for <gfs2@lists.linux.dev>; Wed, 29 Apr 2026 08:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777450524; cv=none; b=TJ9DpSnGDluLP2RgcanE8Iv8v9bFAFK4s5i2lrr6cLruFsBV6LpxD/VwfsXTmHWup7q7Wb35fqiGOsJrqm0x2wF1iibc4ExyAbW9t2mknPmn7OGlyF1g03AX6vLGbDj1AAXslCt20JunuOdt4NRv96IMhDqcB8YUc5Ws1PNpuws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777450524; c=relaxed/simple;
	bh=r/M2mKRE35qiR7iF124hoEvcuXchp73r1PHFfcOkRrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n3mELChBgWrfhrYlsQV2QyM+t0cSK5rtBlM30dHDywTpJFGZViT14iPmmeQfmBZ9VpuwdcU5ksTObRZa8L4H+4rQyZ4qiGJvq89OL7793bWihwYlpEPOGAT72ewLHc4REKi3aKYFa59OW14VD0nc9VxmWb5MRNesAlGMZcO5PMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THWyv/EA; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THWyv/EA"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-44261378651so358564f8f.0
        for <gfs2@lists.linux.dev>; Wed, 29 Apr 2026 01:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777450522; x=1778055322; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w4gjTGx+70pRN4y0LykgasMlakdmxDvAyxekGVsskSU=;
        b=THWyv/EAdZP2/3T4Uop8rS5B5GvBBuRnhXGN9e0E+YsS4lDYZSGZrBdL2AErJ2c4fQ
         E1IFIdDAojZkYvHaVRprcn9ElBb5LnyI/u+M48G0M/WvNhAoK4jh+WJ8PkkJbYHSY+rF
         OFJaCPx0mTo7kPwBUVPu0k+ZBzpJ31csDulg+MjVROSAndaCbD6vtUeACzYWSej76LWg
         Mg2II2iG80GJKaSlJ2fm0q/grLX+3oWVSeuW8Bv+pMMqEky3q4OztdLUwUqhWLPF0dp4
         JGI3uFW3aAsDpxGSYi/HTU9UgES11okYHtnSpdMR774ZvSMgEP97RH/j/Sx7Ti4xJNPX
         coiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777450522; x=1778055322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4gjTGx+70pRN4y0LykgasMlakdmxDvAyxekGVsskSU=;
        b=FkK9QuWlRwP5CqFRbVrZ/ee3dQSnn+xwkPjgdKKz/KtToHoLyxTn21SnLa738+Ld9f
         6eB7QOeOpWu8Y/Vl0nqINAPmLaeSRdOSLMK+CCky8R1CuNieNuzmfMDyMYflEeikeHWx
         NCkGGaz2bxKUnUPZVxrAfii8G7+/t0PSu+D3oG1iFiHoSsqBJiSWXWseDZvx76UbPi7/
         SEc4mfrvRc8P6kpYQfW/Xcx6mLjZKpI2/SB0nMtR55x5/2T4JJuXvuVCRh8A1YguXU4T
         KISqCtYw4THHTSg/ju+CruJzM42ho+yWROAKYLUg4pa1ha2jPfUye2RmRLIBaeePKI+d
         kmQQ==
X-Forwarded-Encrypted: i=1; AFNElJ8e5/1xXW1mjmaQpRaBvxlMSGy6PfDSOLMfRmyF1MwlHGlxRk8UqKa1HgMexQ62IkjQbL1z@lists.linux.dev
X-Gm-Message-State: AOJu0Yypx9iGbWcBMdxK6hixr/LajJd22fVX/J/MPLzDIAJw9fURK1LY
	rshPO/wXEHvSBAPwiD2XFgmAty10wbrB7GAkjYrhxsZn6c2B87DavmsDRbQZUpbn
X-Gm-Gg: AeBDiesQpgW9vJtlPqVXmBA4DvC2HyNpUuaEIBZ8jnCD3qNkd22XiQH7be6r7mDwzHa
	98/2FLJoF4Ruw4GL6NHqFFsMnTM/hQeNiivNth157F5Vnr1WjWLMR9Q+elMxDcMAW04bZz0QYDH
	iichf+FBoxDN4bV9rVMm6HvCrI7KvEtXIPcJ0cQ8twVg+v52F2cR6jIaWxwSs7S6l/nUloHmKOJ
	CsWjqJwSRVyBkJ1HxR1CHtQPJ59HpafniFfYtgT06NiBZzshkJUm4R6nJYlw3gpc1Xer3cv8RTR
	LxscEvOE9udLVB13m5xCFYjnIr3K2PpupP/Iuq+zzPQLY/WxbrdAVD0F52j+M/VBD+ag5YeNO4U
	APVBNQbRlDNAQsaeI1N4anXwjoFB2s/QJ7fSzUK5xcwlWkxjbvWF6D8JlNCYSu8lrhAqLH+CnkW
	XxAjZrydjzU6/jNQdFmo5vgEc5A0Ksn1ryA9O3KHNTpmC4dZ4E1NbNXt94BeM/0TXkemDO1NBTa
	7SU1SDR6suz2xrEhmhp
X-Received: by 2002:a05:600c:a10d:b0:489:1abb:5559 with SMTP id 5b1f17b1804b1-48a7bf9956fmr24250695e9.5.1777450521325;
        Wed, 29 Apr 2026 01:15:21 -0700 (PDT)
Received: from alessandro-pc.station (net-2-37-205-63.cust.vodafonedsl.it. [2.37.205.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7bc23f4asm44256265e9.7.2026.04.29.01.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 01:15:20 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: agruenba@redhat.com
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	linux-kernel@vger.kernel.org,
	gfs2@lists.linux.dev,
	syzbot+642d0561f78362d67d3f@syzkaller.appspotmail.com
Subject: [PATCH] fs: gfs2: fix sleeping function called from invalid context
Date: Wed, 29 Apr 2026 10:15:14 +0200
Message-ID: <20260429081516.566812-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The issue arises on a PREEMPT kernel because gfs2_quota_init
calls gfs2_qd_search_bucket while holding a bit spinlock and
triggering a "sleeping function called from invalid context"
bug.

This patch refactors the quota initialization by splitting the
lock into separate locks, moving the search outside the atomic
section and using RCU lock for a safe access without holding the
bit spinlock.

Modifications of this patch:
1. Use rcu_read_lock() around the invocation of the function
   gfs2_qd_search_bucket() for the search.
2. Add the spin_lock() around the insertion into the hash table
   and lists.
3. Remove the usage of unused spin_unlock().

Fixes: de0d95c26c41c ("gfs2: Check quota consistency on mount")
Reported-by: syzbot+642d0561f78362d67d3f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=642d0561f78362d67d3f
Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---
 fs/gfs2/quota.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 5290865f27f1..48516cbc8b49 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -1456,17 +1456,15 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
 			qd->qd_slot = slot;
 			qd->qd_slot_ref = 1;
 
-			spin_lock(&qd_lock);
-			spin_lock_bucket(hash);
+			rcu_read_lock();
 			old_qd = gfs2_qd_search_bucket(hash, sdp, qc_id);
+			rcu_read_unlock();
 			if (old_qd) {
 				fs_err(sdp, "Corruption found in quota_change%u"
 					    "file: duplicate identifier in "
 					    "slot %u\n",
 					    sdp->sd_jdesc->jd_jid, slot);
 
-				spin_unlock_bucket(hash);
-				spin_unlock(&qd_lock);
 				qd_put(old_qd);
 
 				gfs2_glock_put(qd->qd_gl);
@@ -1480,6 +1478,8 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
 
 				continue;
 			}
+			spin_lock(&qd_lock);
+			spin_lock_bucket(hash);
 			BUG_ON(test_and_set_bit(slot, sdp->sd_quota_bitmap));
 			list_add(&qd->qd_list, &sdp->sd_quota_list);
 			atomic_inc(&sdp->sd_quota_count);
-- 
2.47.3


Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5989330569B
	for <gfs2@lists.linux.dev>; Mon, 31 Aug 2026 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181613; cv=none; b=a5T4nrpkuGXuDvJSkpR+rx0ut5t2+0M9b8jUt4BizY0rBEiyTFr8Smeduft4LP4/ycEWn6Nq+6mofjiRySML3UoljCQdiUj55re3FdMZYD2xa91egXAbcUc2BGKfxBMPItk4mWcmr2CTzNq8gwSfhe9zU5SV1MYK46HAh+NlBmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181613; c=relaxed/simple;
	bh=gy+M6bfDLyvt2lfUFYqSi5byfUiCbOs3B5y6UxPpdoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XXIW/i0pDnqRRInqhVMeO1jONn7cNYbxtD/Q/hHwnVnZn431mf5QqdUyfDNGkB2UBZpDtvAO8rPJgC2oNpVJDpbXZ0D9j7TpL/GbJ2+IYXJv2wfVghkOnXPZs9GImCrgUXc8a2B70Fl+U73iMW8R6ztrB/LM+mLRijC3JbsVMSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lui8ftcz; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lui8ftcz"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso37949575ad.3
        for <gfs2@lists.linux.dev>; Mon, 31 Aug 2026 06:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788181612; x=1788786412; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tqSWJ7B8C23FQTjYdEqlYLga5GlnyX9z3S1zAHLJRuc=;
        b=lui8ftczh3ZOfe+nSZQaYlVmMmVJLS3c7njB1H9ltBV9j35uaAbh6yDb+GMVE8/iVp
         NC0xJsibc8hTsWLogyay3KGDy0RqOEfG6pY0no0kU1fK73YmVMHeZ+6d832oxT7DXm8M
         9Sb93lAdLsDY28OMcG4Ui8Ql2r104vVJkDBRDsEQjPrR131PM6YjeLs76uf87fPW+xV3
         kC3+tyqFMEt5NZAO+hAh9ZfydE+xpXoLxg1uxgOvlMMZTFgQQz/lrtLyYsUNzrsTodQj
         oZDMbKaqrAf1vbSrm443XpDVie72Ce94xgyYgiH6Ga/iDPwixbB+fhmsRSvY7zsLx0fg
         dNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788181612; x=1788786412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tqSWJ7B8C23FQTjYdEqlYLga5GlnyX9z3S1zAHLJRuc=;
        b=sRSUtAbVRnIdXPDTNLmdy7BzRN+/eAuIXVzoLOGzhZbafHRVB+JafqsQWzZ/l1bOv7
         BDcSuNTnNhqVTW3RUBHBEPXNDrJtTLnjAcS2tExwPfsIuuGwVQHQqiWaTn3y8sNaWbOT
         pVVxwpZ6wuJ4SHUlMagL90DXdhSHsSrJpVyvB7wBxTU3xf2lxh0yBCauqjRVm//U1UU+
         m5hRLTVtOBUI7qL1kwxA9KZ2LdE7zERAnkg2PicvS5hcPkzLswvVQPz26KfkhMCI1EJr
         fhPNVjRbL+vPzEF26Y03dMi3XdTgPu1ZEu21wTLmOJHGVBXnOusMUB1e2CrCxsRf0W8/
         dNKw==
X-Forwarded-Encrypted: i=1; AKwUvBziWd+1fiQ+la+zfPgYCEgP7kN4vOW0jtox/jHqVwSjl2i+jOL6GJ7m6tauerD7kKA74iuk@lists.linux.dev
X-Gm-Message-State: AFuF++nZ54guvIkFzXyD2PVO1/IeCvBbJqdF79Qu4+lDwlUb01wfJojU
	d8yw9ETBIqS8DZvKYgBigWOPXrgwnnc9Tzc6UZwyMAG1ngJV8PoJp10k
X-Gm-Gg: AYBFou2+SZR8z06ulql6SfGszBDjqm6suywtgvz3PrbJMrykqkmwqI1zohxF00BQHpR
	TmkWJ/amuBFzbQd7X9oNR5I0JN4iiTwiRjw3gDqG6owS/Gpof+6jcGANqSLPaTweWBNpAZ9W9gI
	u3yoW9TP/ucUHokpCTNJjJYQLY9oGGqc+RKmmGoI8XAYB7B3LfLSwbr3LStc6MKSyTS3OyYynaJ
	/dP2Wog+yNu62l3BDqFFODuYLcpbmbK+wnRIPV3szEDbj8PMd+6TmUbyYReN+0qCfOcWp30B/xu
	8NPZ1mGT4d6yZiAM2BO5ekCOA4gVxPecoqo4Q61mdMKuoWe3PVJkDMN/Lfor1z/5Cd/o20fWIBp
	rByuRFrF0lBMygMc3UZZA8it8XNYxLXKQ2VilnPLTQ8U8+hw2p+IgWkTST9R6gKf0cQ0tQLwNKg
	RIWMCLr7f87Qjbvi5oTsJjAZfzBcOXQ+ac+Ak7v35XHpP5mnfIO5hNvDTRJHuCwAv473TECao/
X-Received: by 2002:a17:902:d988:b0:2cf:afa5:b19a with SMTP id d9443c01a7336-2d74e0cb133mr481609655ad.11.1788181611558;
        Mon, 31 Aug 2026 06:06:51 -0700 (PDT)
Received: from ustb520lab-MS-7E07.. ([123.124.147.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d75986aea3sm35368325ad.52.2026.08.31.06.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 06:06:51 -0700 (PDT)
From: Jiaming Zhang <r772577952@gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com,
	Jiaming Zhang <r772577952@gmail.com>
Subject: [PATCH RESEND] gfs2: stop logd and quotad before kill_sb log flush
Date: Mon, 31 Aug 2026 21:06:43 +0800
Message-ID: <20260831130643.780514-1-r772577952@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gfs2_kill_sb() issues a synchronous log flush before stopping the gfs2_logd and
gfs2_quotad kthreads. Given a corrupted filesystem image, that flush can spend a
long time while holding sd_log_flush_lock. Since the background threads are
still alive at that point, gfs2_logd can be woken and block on sd_log_flush_lock
in gfs2_logd(), and gfs2_quotad can block on the same lock through
gfs2_statfs_sync() -> __gfs2_trans_begin(). The threads can then remain in
uninterruptible sleep long enough to trigger the hung task.

Stop the background threads before the kill_sb log flush. gfs2_destroy_threads()
waits for both kthreads to exit via kthread_stop_put(), so after it returns
there is no live logd or quotad thread that can wait behind sd_log_flush_lock.

Closes: https://lore.kernel.org/lkml/CANypQFasb8voDrg=O9xJikYHdRFeupb5VP2VeJaZ_wFNMoGr2Q@mail.gmail.com/
Assisted-by: Codex:gpt-5.5-xhigh
Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
---
 fs/gfs2/ops_fstype.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 718e0da7dfce..65c536fffefd 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1777,6 +1777,8 @@ static void gfs2_kill_sb(struct super_block *sb)
 		return;
 	}
 
+	gfs2_destroy_threads(sdp);
+
 	gfs2_log_flush(sdp, NULL, GFS2_LOG_HEAD_FLUSH_SYNC | GFS2_LFC_KILL_SB);
 	dput(sdp->sd_root_dir);
 	dput(sdp->sd_master_dir);
-- 
2.43.0


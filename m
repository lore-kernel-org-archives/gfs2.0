Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAEA3BD22B
	for <gfs2@lists.linux.dev>; Fri, 28 Aug 2026 05:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787895980; cv=pass; b=Gl8l0z3CI0+ZPjwcIeMhSTMon4Od70BG08dC60U7h6De+a8JfdKzx+r3NVtTCePnyGPuv8gGSr5bh5AG+wkv4IEk9LS2ZohlsozhTRRhj0ST1M0B56mF1ZmuxkUfB41+inhtowSrcSAlCHz7FrQT4tUXZadQNTjITzaT3uiUhTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787895980; c=relaxed/simple;
	bh=3mzePdxBZU/3WYB/4lvrTeALz11TsrQx6TVNX0NuogU=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=GZURxZdvgyjlOvm5uFAGGmzOW6YVchlj7CafLx8j1+bsEGYYk86XKpop3WZmC2wsRUUeZ+u/4sIaN/p2Byz5AjAuvXXd0OFuVE3huEuIpfMox0yegWGtpd71/aYfooFthf3uiFS1aw4jFK/CtFeQHK6iGFIFOwLgvn8N1iZUg+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=UI+/Stm4; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="UI+/Stm4"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cacb8416a1so6200095ad.1
        for <gfs2@lists.linux.dev>; Thu, 27 Aug 2026 22:46:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787895978; cv=none;
        d=google.com; s=arc-20260327;
        b=f6oaSMtL5ZnLEu+qQUqiot/Y2FUSENP/nXraQt8W51mk6GrXaUn5YJBPCDYL26sxeJ
         jHh4ZB8ZAAXXcqzYr0EOKrYN8TdAc2npQ2lmhhlKFEd02M/KVcSt92pNhiGqNHscGEed
         iVFdDVCQoiL9r1+5vi2iOn7cBYxqNsljpf/2EzgiCojQOgdThoKhPg4+Gu6K4+pJnhtI
         TZhUdeI5k2vbOwsdF3d2iwulD1Ehc5qsdsTa1EWJme1yAU/fnuEj3OzT1lrZSNqFhBpY
         owJybHJfDDe5Wn0epPCymx6IIUizoB4eu3ubeRW56hyZiuDFrfkzYkG5vo7cx9kWdJmH
         V9Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=0GUepPC6eQwQ4aTuikrhpmMNCO3bQ+7a/vXwuKLRNKU=;
        fh=ubRXaz14pvkyD9p4Xz2WTD/3UaW0pov+Ts8B5MkiHnc=;
        b=j0LKBhRADlIXEtvm6h2BpinsJ/qnt3Xswum8+8fCYaHn5f4ybEr4PXC7MX66AL22SZ
         z39FCG6gFItw8wbyfK7UdvI44Gh8itcW2TcSiRBVLoxvHLsM7ojBls0+QxGb3UzbUiL1
         bFe4PYbNQjpsDWgOFsAZo4T+ruumk++MV5mGsawAnomTJJtsbxepHOTHOzFb+s2kZ5Qy
         OyKkkyaRiwjWuQGrobtubhxR+hnF0fBPDm2c7UY7E16fgEJrvw1QXhp607auKCQWJftN
         ihuoZbAXaxmpR5l7yGRTnfjhcm/fgWKAddnrvECXf1Dexx1jPBgHB2kGVKxO3S3RB7F+
         DjpA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787895978; x=1788500778; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0GUepPC6eQwQ4aTuikrhpmMNCO3bQ+7a/vXwuKLRNKU=;
        b=UI+/Stm4OtKMay2Un0qQftFsD0ZIGW3dwA6a3U/ah+29j206K9QiGrMX6IP3lMOxZQ
         o462TWLrAf6tLiDIbYA/4p4liIqi0Qp+kLN0xrIRjI1OYOXEF7LIXX1TqbiAtrPRB5xI
         cSA5Pi9DoadVYgogh7B8f5MoyzYjDU1GX34fiP/2EfF1EPfY2wONGG+zTwfjnelHDAIK
         cetK+aXjBEDyY/SYkTIWb4S2RsKNHo4TMiNoUbksvHu4rzzrxkCWxnippOJrd6MqSS37
         gv/L0rdSvMmdSDiTdgcGt+dKpGbkzCBgQLav1PcbYZB6W/bj3G+QWovH9bYyMLdHh3aR
         44pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787895978; x=1788500778;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0GUepPC6eQwQ4aTuikrhpmMNCO3bQ+7a/vXwuKLRNKU=;
        b=Nc2tPQFfnLwyWfI6GEIT2ujbHslE1HrZ9K+ErcTRRFDJrK2qBMWtpePM5fE504wEwt
         RZEN6bRyeXv5HN3B9YKeDUe7TkE1DCSfxd+8xWxTYlBDEyoHzlBm57ix6+Y4FJZFR93d
         3JxwVuLXkaTlotKOEvmTkIiOI0ttwbpwYwHYS7iMctryvrSqs0X0+QfttnVJdwSZGhJO
         sjNT5Lby/vXgb8jngndUGW1MnZ4uiX1pm+NQ4TiiGtL2u9WM9xfDUCpz7MlZ9wTGdLLT
         Dn32GGLXN7spHGciJpxIs241mvIZGKIOIcShi4J/BbuIJtAl5OwGYMwNap5nA+ihaN/E
         quJA==
X-Forwarded-Encrypted: i=1; AHgh+RqGMuJNpH5ksc/wK5xuFuEsIORmd9nF5/lYTQHmDIrz2wD2dC2+OmPZyR+mtFGwT4FpLIYA@lists.linux.dev
X-Gm-Message-State: AFuF++lWvLaALpbxpgjcW0p5CCchwRaQRTBOnPGz2NJXX28K+BAMnarl
	FnZrKu/EeIzb1ZiV4QNK3oYLC3rEbIePy5DlgnSLI1osjyFiZyb2SVFXy9ZPFmUgWQKG7hVBykC
	ucmYo85PN4jwCuNlSoZ21DCLhR9QVYeWAJbtBcdp1
X-Gm-Gg: AR+sD13lpUwoEMUVNAcguUGxnnZP0zP0tSJgWjVaoJWYAsjUTEXn4e7zqtDSt+4q6IQ
	lkEpPen2WdmTB1gF7PKUKWJn6SlBGHdU40KyjtLBDXE9zUSy4t4jaexm8uDM/lA17SujyhBR5b/
	A9dKK2omwkgFbkLIB2nuQSYtO3NzOYZVVD2kJNgX86EGYPbBWsxPkPRecjQBbpzE8oWrzKsZMD6
	kngRAyAZoyOiFd1mXMGo1xXFECQIpHuMCR1eH+9HgSKgTQoHkM5YVbj7FnKOz+g1XkGDqiM0dhg
	0fPSHVTqiZRtNJcYjstBdLyIo5WHdQJ/FOcyCHMdwETQ2gxuFpml/zslXW6Z9PIuhHAcxm26oGa
	mgOsn4o0oV1xRMYovPXekyAQtBb4zdzZA
X-Received: by 2002:a17:903:15cf:b0:2d7:1aeb:739 with SMTP id
 d9443c01a7336-2d74e1295c2mr86465035ad.13.1787895977223; Thu, 27 Aug 2026
 22:46:17 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 22:46:16 -0700
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 22:46:16 -0700
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 22:46:16 -0700
X-Gm-Features: AcwNN1X4mXiwbv-zD7khlznKWnAht63BaDjhnKiIcjF9IZjcchKCLalWAp7F7Lo
Message-ID: <CA+0ovCj14CqeH2qH-fxDdvdK3Tp=rgZM7opqOp0PkYS52RmOmQ@mail.gmail.com>
Subject: [BUG] KASAN: use-after-free Read in gfs2_rgrp_go_instantiate
To: Andreas Gruenbacher <agruenba@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>
Cc: falemi@asu.edu, gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

As part of the kernel research at ASU's SEFCOM
lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/177-kasan-use-after-free-read-in-gfs2-rgrp-go-instantiate/

  BUG: KASAN: use-after-free in gfs2_bit_search fs/gfs2/rgrp.c:188 [inline]
  BUG: KASAN: use-after-free in gfs2_bitfit fs/gfs2/rgrp.c:249 [inline]
  BUG: KASAN: use-after-free in count_unlinked fs/gfs2/rgrp.c:1159 [inline]
  BUG: KASAN: use-after-free in gfs2_rgrp_go_instantiate+0xb0d/0x1340
fs/gfs2/rgrp.c:1238
  Read of size 8 at addr ffff888011445000 by task syz-executor/17182
  Call Trace:
   gfs2_rgrp_go_instantiate+0xb0d/0x1340 fs/gfs2/rgrp.c:1238
   gfs2_instantiate+0x151/0x210 fs/gfs2/glock.c:442
   gfs2_glock_holder_ready fs/gfs2/glock.c:1250 [inline]
   gfs2_glock_wait+0x1b2/0x280 fs/gfs2/glock.c:1270
   gfs2_glock_nq_init fs/gfs2/glock.h:253 [inline]
   gfs2_inplace_reserve+0xc43/0x3420 fs/gfs2/rgrp.c:2093
   do_sync+0x64b/0xca0 fs/gfs2/quota.c:948

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,

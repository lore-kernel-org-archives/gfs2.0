Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794385346;
	b=TEx9rS/LpdvkOjiDrIDPAtssZm896rwrU8AKhUynukh3oMou4tQCDO+ttE3rhvXuxTki
	 +0F28nvs4tifR+FoSRS4lkl+52oWrQitQ2YK5y7ZHtz7McbcTA3hL5I9i5sCyaHGKSFMg
	 5ns2YB9vMRv8N/KWOgnBkR4OV4fjR6v46j7HV14R5YOncdHsRz7KQ+it1P/pp/PF0NSFf
	 5/UAziZLjW2VU2G3h1eTGoiaEaZr+6CpfasG0v/hg6OJD8oLvZ9A8NGIwY8+XJq/7EkCV
	 eVH5tiuAJ5o30W4YKJGmgNdSbNjd6X1uZhG7t4SeEqqivy7Up9L7ESMRLOr7Myq04Og==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385346;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=AgIMfPzec9DY2ApqYmXaL9OIT8JJtsh4iQln6el8AxM=;
	b=guClAHNpTJU1KMh4MzzBi6B39/IGeZvZf2fAJWsiJNYkdeo3Uj1v8v5BF8WawLsUxjB4
	 feQrrV8RbsyAhtYWonwLAO6CWF6YywgpFCfc6XBBe50K5LZ2/XkfqZMy9PSlnqepNAr0T
	 MfZHYqh2nKnBitp00i0XiF+wqYXyr8IOFpLLFN4Uwv52MIZi1wPW0Oh8LY02NEVw/7K3t
	 dbOR+uFVPkh1877M0LcMLAtanXAgCXZxMixGTAGJDmXNx3OP0DSopqWaC9WClsvgFDpGf
	 qZX0ZkD6o/5B1g7YDTFogI1/wJizOka3DCU4vDr4/TIfUkz5HL3mKEzIFet6bfd9gQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DsTmr0hZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.70
Received: from mail-lr2-f6.google.com (mail-lr2-f6.google.com [74.125.230.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559B460A2607
	for <gfs2@lists.linux.dev>; Wed, 11 Nov 2026 08:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 559B460A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DsTmr0hZ
Received: by mail-lr2-f6.google.com with SMTP id 38308e7fff4ca-3ab1bfd1373so20816981fa.0
        for <gfs2@lists.linux.dev>; Wed, 11 Nov 2026 00:22:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794385344; cv=none;
        d=google.com; s=arc-20260327;
        b=YzVFHc40P3RdiBLQ2m3sG3yWXKBor1LABFPEvCC/SBSCVPO4p7OtBBHbIZMEr2hwXT
         VthmCKmKJ0tRSNytt3u1edokfQIbNLsEMSz5wg2q09JPySIk3V3XEbX6CCIR+Xgo1CDV
         JTYl0Ydv1IhXxWyemehV+kpXPgoA0ErZ37hZh4NROSpGWsvO3J2v50UDpePzF+mOvAso
         60/yezoL4u5pDbjgRWnbYOK+wCQCmMCtAgfeVYVVU3C2cREMA/ri7SXSLXcjL7S4bfvQ
         f/eIG3MXtygTCNMVt9ltOjRQ+sT9pyvzdNBNWIVwKrGafHcwVQs3Bp20mL740Ue7Xq0p
         2RNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=AgIMfPzec9DY2ApqYmXaL9OIT8JJtsh4iQln6el8AxM=;
        fh=bwAya4hPtLQJn8mlFa1wMmDyN9kVQnvlVUddOm6TRPM=;
        b=fLl6ienyghExaoMIFSmMFMQrAVAu04EgIB+pJ6KtRBRJaxeHg2r7oyfO5Vf3Z5DrPL
         ppcImHtkVPOavAv9AZqRxncO4w+scc4BYZZmaCDdkdob3uj25k3a0W2pfeRUQlrLJXMU
         iKAMwfhjI2YRKB66Q2OGTbdJ03Uhbwctkc/QYDcBtrm3o8K6Sy/9P9VhCIjGTd8xKDcH
         zxXKGPxTMHgLoQMadOvfv4DMbboXEMq4FYzJmHGv/76L6vZnFpBTpdXwpzl5gsMk9085
         IjxLVd5w96W52OinMJQPMcloIpcjqenD5zMmbYvXUVTKao4Mv1S2La8dPPLCHp44Ah6k
         a43A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794385344; x=1794990144; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AgIMfPzec9DY2ApqYmXaL9OIT8JJtsh4iQln6el8AxM=;
        b=DsTmr0hZ8CcsTyjp7ngxR3oagcZX9VCmjSZQBFJ8iSBDMz6XnpJDqxUUNRcshJpkQX
         xFTf4AL/wUueaxR/HENRF/q1dWl4+GIYOoS2UQUcX7Z0ME3LdttYuKZTXWPC9SZzB7so
         UtyY/maFiTCgPftLNxc/Yf3oBR2uVTef787EPWGh2ie89JIwHt+5MXK64w7fFM4KpAnL
         /yRP2WdoSW9xGn23NZXN8i0I7fJZ9d5DWtJQe+OEqti+cUYKpATVooRdmL006ymoRlCY
         w0DCKoQbik0tXs1UgOrmPYfvYYYYp23iXnkp2/NlAAdg7nc+8//zRjMsb/XZh5e5Oncu
         ufDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794385344; x=1794990144;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AgIMfPzec9DY2ApqYmXaL9OIT8JJtsh4iQln6el8AxM=;
        b=pwLxvYXAzDWCddYXOeu6V7Lt7SICnu98nBh0KFcamJmrb7v7F25sms88crIqj3Mc/Y
         /wrPQKk1GbzTM/vtA3NOrNH1xWmpcrstEo+G+QJuNdD3l5jR87v2yHqsMTm+N5HdMJoF
         eFiRaT7fGUS7zEoRCzCDBLYfuC50HaNM2SfU6nWJsq++DFcjsKSIBCy4pNi5Yle8bqfr
         yW5Icig94I8/4rbZfule4xVXYBpLzsBSvCIzk9jaroyFflwjSpEpZGu+njQU7nw/weaP
         GqzpcI3NKlfCA076iL4X46BKAGxwY0EjnY8XGUJwiW3gOxgrPaJ8EVlN687yGeKaFBYq
         FQSQ==
X-Gm-Message-State: APuU4Z9aPIgeBmIOApkIcHpdtvjo+iB8Uu1bcJ9O6fpkgjeC1IVZ/Bh0
	mJ3M+oLgzYGjIssK90Zvykr8J1UC4vStnI6wIZoA3xFL82bNdHYhR5KbYiclNHS0Mx04L7HGgZg
	icpK3denT0WX3CQQRbfK95ElTpmS4FnZOTcKzZWn3sYCY
X-Gm-Gg: AYBFou2EONwuUw5ZK5zvv67VQzTejzZ91jjVtZGmXlQQV+xub3I/6i8HbZeMZc/4Jbq
	26DtEXiFpL5KAg0cf97o3F5Bdp5bGSyBvir6HW2C3pu6YITp9idb5hbvLgZD7kVY6b94dWfL4HK
	tMncbyz+brLF3coy+iH2gq0/g51DzuKa6V3SSZxWQzucu3QbFgYyRBQabanN/NzviLGmtXClyeU
	Fyl2LOCYuYdJApiam3noRc+p2/FHEZTZhn++ov7BC3fFsoxjSuc2ZiCAViNT+uF2EAicsnHRKQF
	8T0voDZOgl8GLBPs1Rngd79FphAjwksBkGnD75548/RXz66psgiDIuBhfihETQfD9rlDnAMoQRQ
	aQ49C0cLK2PTKU3eNPy4EYmM0tQMddPpo8CIeae99GyktKltTJ3R8oUe49+cEB/n1BBCBLQ==
X-Received: by 2002:a2e:bc1e:0:b0:3ab:690f:8298 with SMTP id
 38308e7fff4ca-3ae126e0386mr2437781fa.26.1794385344031; Wed, 11 Nov 2026
 00:22:24 -0800 (PST)
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?B?6ZOu?= <fengaojigui88@gmail.com>
Date: Wed, 11 Nov 2026 16:22:09 +0800
X-Gm-Features: AclHuK_hy9veouiudQcSobg5SV-wrnT6hvHxKyBw3U6wMxsahH9odZuqLSKRpQw
Message-ID: <CAO-4RZ2nS7ToE6rJxbTJM7CXHVY84YL4zqysFZA7=UzYg3SB0g@mail.gmail.com>
Subject: =?UTF-8?Q?=5BBUG=5D_gfs2=3A_kernel_BUG_in_gfs2=5Fglock=5Fnq_=E2=80=94_recursiv?=
	=?UTF-8?Q?e_holder_via_statfs_slow_path_=28fs=2Fgfs2=2Fglock=2Ec=3A1476=2C_v7=2E4=2Drc?=
	=?UTF-8?Q?2=29?=
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

We found a reproducible GFS2 BUG_ON with syzkaller on v7.4-rc2 (also seen o=
n
v7.4-rc1). The glock recursive-holder detection fires from the statfs slow
path:

  ------------[ cut here ]------------
  kernel BUG at fs/gfs2/glock.c:1476!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  CPU: 1 UID: 0 PID: 27376 Comm: syz.7.24 Not tainted
7.4.0-rc1-kernsight-kasan+ #3
  RIP: 0010:add_to_queue fs/gfs2/glock.c:1476 [inline]
  RIP: 0010:gfs2_glock_nq+0x6ca/0x17b0 fs/gfs2/glock.c:1518
  Call Trace:
   gfs2_glock_nq_init fs/gfs2/glock.h:253 [inline]
   gfs2_statfs_slow fs/gfs2/super.c:900 [inline]
   gfs2_statfs+0x45a/0xcd0 fs/gfs2/super.c:974
   statfs_by_dentry+0x13d/0x220 fs/statfs.c:66
   vfs_statfs fs/statfs.c:90 [inline]
   user_statfs+0xc3/0x190 fs/statfs.c:106
   __do_sys_statfs+0x79/0xf0 fs/statfs.c:194

The BUG is triggered in add_to_queue() while gfs2_statfs_slow() is
acquiring glock holders for resource groups. The recursive-holder check
detects that the same task is attempting to queue another holder for a
glock that already has a holder owned by that task. The console dump of
the reproduced crash shows the glock is a resource-group glock (lock type
3, n:3/22) with both the "original" and the "new" holder owned by the same
task (pid 17923, statfs_by_dentry); these diagnostics are included at the
top of logs/crash-serial-excerpt.txt in the repository.

The resource-group iteration in gfs2_statfs_slow() may revisit a resource
group before its previous holder has been released, causing the recursive
acquisition =E2=80=94 this is a possible explanation based on the source co=
de;
the exact cause in our reproduction has not yet been confirmed.

Kernel/config: 7.4.0-rc2-kernsight-kasan #1 (same crash on
7.4.0-rc1-kernsight-kasan+ #3), built from v7.4-rc2 with CONFIG_KASAN=3Dy,
CONFIG_PROVE_LOCKING=3Dy, CONFIG_GFS2_FS=3Dy, booted with panic_on_warn=3D1=
.

The crash depends on glock-holder state accumulated by earlier operations
on the mount, so the reproducer is an ordered syzkaller program set of 107
programs (state reconstruction tail + a triggering statfs(), in execution
order):

  syz-execprog -procs=3D8 -threaded -repeat=3D0 -executor ./syz-executor
repro.kernsight.prog

Stable reproduction on freshly booted VMs: expected time to hit is
roughly 3-5 minutes. In our standalone verification run the kernel BUG at
fs/gfs2/glock.c:1476 fired at 290.6 s after guest boot, ~250 s
(~4 min 10 s) after syz-execprog started (the guest finished booting ~40 s
before the reproducer); the fuzzing pipeline's state-primed sessions
reproduced the same crash repeatedly on freshly replayed VMs, typically
within 4-10 minutes of session start. With -repeat=3D0 the program set keep=
s
looping until the crash fires. All fresh-VM attempts so far have hit.
Do not reduce it to
the minimal testcase alone =E2=80=94 it depends on the state above and does=
 not
reproduce by itself.

A full write-up, the reproducer and the verified console log are available
at:

  https://github.com/Zheng-zheng-codes/gfs2-recursive-glock-bug

Repository contents:
  - README.md                      full bug report: phenomenon, stack trace=
,
                                   mechanism, reproduction steps, timings
  - reproducer/repro.kernsight.prog
                                   reproducer (107-program ordered set: sta=
te
                                   tail + triggering statfs)
  - reproducer/repro.prog          syzkaller-extracted single-call program
                                   (bpf$PROG_LOAD; does not reproduce the
                                   GFS2 crash independently =E2=80=94 inclu=
ded as
                                   original evidence)
  - reproducer/repro.priming.prog  state-priming program set (pipeline reci=
pe)
  - kernel.config                  kernel configuration used
  - environment.txt                kernel image info (sha256), QEMU command
                                   line, syzkaller commit, reproducer comma=
nd
  - logs/log-*.txt, logs/report-*.txt
                                   original syzkaller execution logs and cr=
ash
                                   reports from the fuzzing pipeline
  - logs/machineInfo-*.txt, logs/title-stat.json
                                   guest environment info and title statist=
ics
  - logs/crash-serial-excerpt.txt  console tail of a verified crash
  - logs/verification-serial.log   full serial console of an independent
                                   verification run on a fresh VM



Happy to provide the raw console logs, the state recipe, kernel
image/config or extra crash instances if useful.

Best regards,
Zheng Zheng

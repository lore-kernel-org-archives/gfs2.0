Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.230.72
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794916564;
	b=ZnxOO7D6+6+4MoglcxhXWDzH3aVCAfsivSSwyQXwjSYMMUb/FnDpfBloclLcwl3WjpNC
	 7K3Qr0buhnw2pCuf5FmYoMWtsFH62ZP6+ZXA9BgP+WPsmN5sAe0uUqtOq4i3sdl3CZiiM
	 TQEbD9MoTLhhUIt/7/Xsf3P/egP2C0jjb5Zvsn/GSncAySbr597zp/dDAVI7xJCFt+/kC
	 itOMj1lYoMyOUNl0S7b7rTTJBFahjMWcO0M/aYbg1PgPBiiBBxzJTzsgj2Ahb7bEvJqOi
	 KP2nIKRX4EmQBZdcKBGa8xm3+uOJxlVFH/xMzTCSbpnemSHl2FM40a9uoamDKF40Ubw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794916564;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=zPU6ceRrOQUHHV+hxPWUqGfVLvSRRuiDTUWQgjgb5i4=;
	b=12nf5NDXxzVAJdZNN8KuT1uvDlAz+RsdzkS+EqlZ9bBYyahZvvvGzyIjHE1QjsOrNmhm
	 p9y6Vd4ieyOfb78zhN68wcUbWJrILAcUWs2vBNAqOCZ1BGXpDkxv/6oOvuVR60vzgIfHA
	 cyT64svcnLVlKMwvJ/NOGS4SPX2+LxfbGnUggQJSCqcx6t/1efmbBwKzBNKcaygPdnmet
	 8pfy5XRZ3pgqetnkUFLLgG8gBSBffIlU7hnNsnXlGvmSfr11fDFN2lmep9K7joa4AUHww
	 IlwY4cNqwTzF/uxyMcuhylNBEfgSkbugwnzEEpuZrAX/7ooH+ZY15PjvyULsUWCpSVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AfgBa8wT;
	arc=fail smtp.remote-ip=74.125.230.72
Received: from mail-lr2-f8.google.com (mail-lr2-f8.google.com [74.125.230.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19103606A323
	for <gfs2@lists.linux.dev>; Tue, 17 Nov 2026 11:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19103606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AfgBa8wT
Received: by mail-lr2-f8.google.com with SMTP id 38308e7fff4ca-3adf2e3fd87so26770821fa.0
        for <gfs2@lists.linux.dev>; Tue, 17 Nov 2026 03:56:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794916562; cv=none;
        d=google.com; s=arc-20260327;
        b=hOuv3JwDC1QXZTcx7gRLSN8TfIPfBWE9FT20n2lVLje8t66erDPnAu33iIgwpiPWGJ
         vykBej/yix08jSlBkxUiAYCwu7KZSBoHekt/txTKBKuMr/rR2SbCtJp5trtUC0YzOznN
         tipDpDDlozAWxFJ6/BbdchUwgd3OLJUxgaDWxUZulird1zlV8P2nYKhn+Sawlr6Lxypk
         2BZAThr0oQf7roQiVE/VYnDPdFlgjcCp2LlRKtPfyQiOtHUX0lpH6KWjRLXtS5DUbVVX
         zMm8ffq6MMdEMjimiYkf/ki4/nWfMTO/RGv2ar9FGZumIzTvYxwD9aX8CMJ4qUYFPoRW
         YyHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=zPU6ceRrOQUHHV+hxPWUqGfVLvSRRuiDTUWQgjgb5i4=;
        fh=8WzfwL8oiIa3Mi1Yr7YWJjh9cahsbT3iUpd51POwzW0=;
        b=j+laPWOslffnha0OCxem0waRlkgXSjmy2D3hYdc8XfE3c9H39HrzIvttRCBOlCNKrH
         B1WBuj3+5murBJQVNMhnYyUYFb3iq+dGTYi5lfh7ElkNe0cifC/+rb9BRP8YpEwvtNF0
         xh6taISXW7kKEtn4uq0w9JmUtTZ/HlQJBUqPXWNd++CTn+EHT4XPATIcqort/M/MefoL
         aJBvnJB0Kng+yT1vDTM/9s2qNNmNaLYShAs5ooS8cte86SvMq4mWBcIL0z2hpIwxA8J/
         RnZFowdbPaDeiYZ6FxVb7ujp6b64AX37MmqFk4HaY61HENu95vy4uZQN7DV2br3UAAhk
         Zagw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794916562; x=1795521362; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zPU6ceRrOQUHHV+hxPWUqGfVLvSRRuiDTUWQgjgb5i4=;
        b=AfgBa8wTlP+N3EGJXDc1PibN5KTd1j1dW38I8Ae7o6WJcMAmeae83Vq/SCGdQs8vLX
         i+3wty+hjq6ee/Hgab+1Ot2pvNBzk6+VRNLqWY8JEwe09CX2WVaiNJVMzT+zD8whtwNF
         h3RK4c1PEh76PD21moKtFhiuKv1lr6H3Smxsz9gb3Mhk1bOQOwAyif/7lKjcP7AZNHFC
         qF3cgkUOOyPcypSXF2qYZPAaKJ/Zqkgwff483z9Biv/TYIJpmym8zmgW+bxyOeGLD5Fj
         i7WfVf4yT4dUZfIMEd+EBANGODW+Xyv4gHCypnjyijRCpx73D1oSOsg1qrjJnmPeAJMx
         9T2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794916562; x=1795521362;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zPU6ceRrOQUHHV+hxPWUqGfVLvSRRuiDTUWQgjgb5i4=;
        b=SZnSg8tZp3uiNE5oGTz8LKDYGpn+hIL4+Gzm0W0iIg53IAsdSCq1HxLRPfxKmUwuHY
         Nj9p+PmhWfIqulGsgarXX7ZMuOid2MuwB0gW9aYaBZe7BPrlC+rrb7UCrtKyp88IH7Lu
         Dl4ibzShWvtekboNEgoErNBLiuNQG4+jF9JqSXmwyj+vohSvKOHu1ebEKkPn2dGiAJYw
         ezvDeanQvGyrcWbd6JcZCH0wv1J86iz+nAGeSybNh2SHKkMfysDLpzisMb8u6kRVynLx
         8CWf8cPAR0to2MXs7JKbYaUgfuoZhpzvtw57bgs6JI+SMbjemnMR1ZkdMBXDxfKn+qu+
         f53Q==
X-Gm-Message-State: APuU4Z+n+A593GZwXRps40750Vuuh4EetjemhCrnOGxXHBK1CMCwOcgA
	SCG3zbuCbXOZDfe+uXB/FducUcDGIDPDn5VV1hq3twarBEwvslP3Kz+1vrBWmfHkm34+TU9aFHG
	px9afem6X8phrUFYN2IED99kAMJptS4I=
X-Gm-Gg: AYBFou10Sc0OAr3v0Z8x6SEdkb/svnkD1Y7b5I0FXaHNCVcy/hghI3kI7vzjMan18g9
	simnmGbafi7MaKfw0qcHxw9878+zxFvkpA3Cyntx42fPk4xzcsQhlnR7us2haEe8hXjZYUYdwOB
	T4ABsfX8LaJS4liigAia8mOdfL0GZdPKpODPYwiJSvrt0fGqoJk3deUWkNIBGvH/qagVKfBpsQM
	Ks88NJGWZJ+X83iZDq2+Boxe3KIJcfmWDUAXQQQtukoen2vNmsPiJipm/t4YDqiiVUTFTwBlOCK
	7YR7vwIWZzk8IBpEvEzl9bfkyElP19C6GwsdWN56DPMaurzV95xhB7M3SbSYwQEilEvEER0vc53
	NRtj6ehHXa9DVb3uGrxSt8KCjx2YwTEm8XLiF9/0VoON2ldCIAENsh9s0zXWAZh9bghvyBOGMvG
	akTtow5sOTA0C7u5o=
X-Received: by 2002:a2e:bd08:0:b0:3ae:25db:795 with SMTP id
 38308e7fff4ca-3ae2b55b170mr41244861fa.12.1794916561911; Tue, 17 Nov 2026
 03:56:01 -0800 (PST)
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
From: Zheng Zheng <fengaojigui88@gmail.com>
Date: Tue, 17 Nov 2026 19:55:48 +0800
X-Gm-Features: AclHuK97JT3tcI4OB1Pi1Tv50c508Am-TqojV31gyjYgKRKJYvztqlBkLpD9SOY
Message-ID: <CAO-4RZ3Od6cyGSMJpW=yATKYde8NEc=Mkyv328+uA1Y56z_7Mw@mail.gmail.com>
Subject: [BUG] INFO: task hung in gfs2_glock_nq (v7.4-rc3)
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hi Andreas,

We found a reproducible GFS2 task hang on mainline v7.4-rc3 with
syzkaller.

The hang is reported by the kernel's hung-task detector (khungtaskd), not
by the test harness. A task sits in D state on a GFS2 glock and the kernel
prints:

  [  331.476369][   T44] INFO: task syz-executor:10136 blocked for
more than 143 seconds.
  [  331.476395][   T44]       Tainted: G            EL
7.4.0-rc3-kernsight-kasan #1
  [  331.476415][   T44] task:syz-executor    state:D stack:22904
pid:10136 tgid:10136 ppid:1
  [  331.476466][   T44] Call Trace:
  [  331.476472][   T44]  <TASK>
  [  331.476489][   T44]  __schedule+0x1405/0x7510
  [  331.478052][   T44]  bit_wait+0x1a/0x130
  [  331.478073][   T44]  __wait_on_bit+0x6f/0x1b0
  [  331.478127][   T44]  out_of_line_wait_on_bit+0xdf/0x110
  [  331.478237][   T44]  gfs2_glock_wait+0xaa/0x2e0
  [  331.478267][   T44]  gfs2_glock_nq+0xd0b/0x17b0
  [  331.478312][   T44]  __gfs2_lookup+0x10f/0x2a0
  [  331.478360][   T44]  __lookup_slow+0x15b/0x330
  [  331.478509][   T44]  lookup_slow+0x59/0x80
  [  331.478532][   T44]  path_lookupat+0x603/0xb80
  [  331.478568][   T44]  filename_lookup+0x218/0x5f0
  [  331.478767][   T44]  user_path_at+0x45/0x90
  [  331.478794][   T44]  __x64_sys_umount+0x100/0x190
  [  331.478871][   T44]  do_syscall_64+0x132/0x7c0
  [  331.478898][   T44]  entry_SYSCALL_64_after_hwframe+0x77/0x7f

The blocked task is unmounting a crafted GFS2 filesystem. It enters
__gfs2_lookup(), calls gfs2_glock_nq_init()/gfs2_glock_nq(), and waits in
gfs2_glock_wait() for a glock that does not make progress. The guest runs
with hung_task_panic=0, so this is a hang report rather than a panic.

Stable reproduction on mainline v7.4-rc3:

1. Build vanilla v7.4-rc3 with:
     CONFIG_KASAN=y
     CONFIG_PROVE_LOCKING=y
     CONFIG_GFS2_FS=y
     CONFIG_DEBUG_INFO=y
   The bzImage used here has sha256
   0c16409f8aec508ac44a63e631c2bd352536401f3fd0856df1d839fb953a1882.

2. Boot a Debian trixie x86_64 guest (6 GiB RAM, 4 vCPU, KVM) with at least:
     root=/dev/sda console=ttyS0 oops=panic panic_on_warn=1 hung_task_panic=0
   The full QEMU command line is in environment.txt.

3. Copy syz-execprog and syz-executor built from syzkaller commit
   853b104bb454141a5b0fc0e4218ec78e9f34ffb1, plus
   reproducer/repro.kernsight.prog, into the guest.

4. In the guest, as root, run:

     syz-execprog -procs=8 -threaded -repeat=0 \
         -executor ./syz-executor repro.kernsight.prog

5. Wait for the kernel hung-task detector to print
   "INFO: task ... blocked for more than 143 seconds" with the
   gfs2_glock_nq / gfs2_glock_wait stack.

The outer timeout is only used to stop the -repeat=0 loop; it is not the
success criterion. We observed the kernel hung-task report 2/2 on fresh VMs:

  Run 1: 331.48 s after boot (blocked > 143 s)
  Run 2: 290.82 s after boot (blocked > 143 s)

Both runs show the same gfs2_glock_wait -> gfs2_glock_nq ->
__gfs2_lookup -> ksys_umount stack.

The pipeline-provided recipe is a 183-entry state-reconstruction recipe; it
builds the needed glock state by repeated replay.

Repository contents (all v7.4-rc3):

  https://github.com/Zheng-zheng-codes/gfs2-glock-nq-hang

- README.md: phenomenon, kernel hung-task semantics, reproduction steps
  and verification results.
- environment.txt: rc3 kernel/guest image hashes, QEMU command line and
  syzkaller revision.
- kernel.config: v7.4-rc3 kernel configuration.
- reproducer/repro.kernsight.prog: 183-entry state recipe.
- reproducer/repro.priming.prog: priming portion.
- reproducer/repro.prog: triggering testcase.
- reproducer/repro.report, repro.stats, repro.outcomes.jsonl,
  repro.context.json: pipeline verification evidence.
- logs/log-0.txt, logs/report-0.txt: original rc3 syzkaller log and crash
  report.
- logs/machineInfo-0.txt, logs/title-stat.json: guest environment and title
  statistics.
- logs/external-verification/: full serial consoles and run records for
  the two external rc3 reproductions (331.48 s and 290.82 s).
- SHA256SUMS: checksums for the inputs and logs.

Could you advise how to identify which holder is preventing the glock from
being granted in this state, or whether this crafted-image path needs an
additional check?

Best regards,
Zheng Zheng

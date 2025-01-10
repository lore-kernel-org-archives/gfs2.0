Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE2A206F06
	for <gfs2@lists.linux.dev>; Fri, 10 Jan 2025 09:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500140; cv=none; b=KRu0HnySEq4+mIPYYfdjUkPZQKEviSu8nMhYQYOvl0XD73xH3T7O1N6S2d/wugqr8wYw/xxx+q2kzLyQx8+yTis5HuQn8ybI5xrioiYwnd+Tne3hg5JqVp3/lFdd651TB7VQ4YE6d/NNraw1I3CE/xhQyWtfPvTHlZNf17UNxpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500140; c=relaxed/simple;
	bh=7ICl+UI4pC64VbEQnYyxGNzjeXiomMl3d6kHSKf/6tU=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=UNvfZjDwJiHZT+Ny7TF55es/9sZQeS2uzDc7GAltnKt3ISuyWIkGpOTyRiutN8yEKL/W5IQJB+rCi1f80zVCeaUJ7pzL5w9+5u8CUR2AJolS6/CgxAXi5jhJZuDLd/4Kr5JQ2JGjQ84RtF2mZPAcLrvZGaNc48gBvuRBIRgy3Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=Vrg5kilq; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="Vrg5kilq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1736500100;
	bh=RUYjVPA6LlbOBYe+npC3zXOy9xnuB1sat6XjZmixYv8=;
	h=From:Mime-Version:Subject:Message-Id:Date:To;
	b=Vrg5kilqc5z65uqwU527olD3MHvRchczk10MlBRvz4l+BmXN6OFpeDls1ybtw86dz
	 BPTIdc3zKXLrlkPNTvc1nWkK4zpj7h3NFgzK0csgA21vKtEglvTJikvMTSXmuGzQKW
	 921xzc3Di0MazrkUFfYTFGevphRrV8YkKK0i7nMk=
X-QQ-mid: bizesmtpip3t1736500098t26fsr0
X-QQ-Originating-IP: 7dJI7vIba/hWdBN0VeeBXcrJv8mjBFZIVTLqS5+qzD8=
Received: from smtpclient.apple ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 10 Jan 2025 17:08:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9950390689075430388
From: Kun Hu <huk23@m.fudan.edu.cn>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Bug: INFO_task hung in gfs2_glock_nq
Message-Id: <3BA254AB-CAA6-4D5D-8C1D-26C3B98682B1@m.fudan.edu.cn>
Date: Fri, 10 Jan 2025 17:08:06 +0800
Cc: "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>,
 gfs2@lists.linux.dev,
 linux-kernel@vger.kernel.org
To: agruenba@redhat.com,
 teigland@redhat.com,
 swhiteho@redhat.com,
 willy@infradead.org
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MHAMmLg4tmnVVPJlOkXezd6HVGZr/PzahW7IhwYv/5BjBi1GWhuVXhZa
	fOyVtLGCfzGf0Wwr17tGUSPH+/dpOxXCilzwu4wyD2zIQL9q7T5VbdhQL/v4b4QJ1t7f4OX
	P/SttayFAz2Of96UeWEYXIYn3PwEYE3vkwt/uYSa+9p80dZrAyUcBMt2c8/eG8PtOKXFwl8
	yO7UsTXaJd0yFiKP/oyDpMXDtddZjYdiFruOHXMy2qACqgSDURI4Bc5tVBpnJrRU1WAO+PZ
	ufQERVtk70H0JTbt/wt2kV4IfKgxyUIgyY0foOoFsE3F3KjWinMAmSG+5SgFL91g02M9HeY
	xRcs0+gYdh8+4YSXPG+++g49En+al2CHUAz0/s/KUa8S8T7g1/rtLonamm/CK0+nfjc+KIU
	Xx6T8+iHLOuPiNGiuQMKLJbF4WwHDa35gQmp2Cxg2JqerlzSdkENkaFU6SW2HGgLLaGTkFF
	E9u7ZqXW9bo9hLzLkQo60EKIl15pIq2KttkUiXeW1j+bB9a8HPdjrBs8Qm3nthXYKurIKKE
	GP6zSFA3hr4Aneccuc6drp2mV1i3ZI0HOHeRp6KN2fYdMQo2sra82L8kpDLzMYtE/2AoIo1
	cWYwjBvVU2SKjgWJpRUtsvKSIwvApgLNYIeESPFCPxK0E7tpteWcluR+sUIDLu0ikWVmyrP
	FO2ts5iVB3DrVI9jwvxD1GZ6MtSh+pvWYX+qH2WRcsPDKLKw4kDuZzyIOD720Ll0gwB2iSQ
	7wYDeIrOwYNkzipOWooIg1VNuETdUsPBI4qd7XW2av/66dL8HqL1kNqdf4X0QBRlA1uM5/M
	3rxUpiwl3sEpOk0xsbT34YJ61jUuPVH5oz0+Vlv5zmRagjeTzbE+yQyiX6aF8P7chsauOPD
	eVBc36IWbAISY2Yvjw90HKcDXEwkwyVovvVMs7LBua1bhR6odsrGBECVW6G2zn5/BJhkcUH
	FcgNKKRVMHlBDyaChw0FYCcs78HbNjTWa6TSZzgDqXzaB2fTnAl2RcmRrzJaOnGiyNERipi
	S2EvmbukLNHp6x5qiI
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Hello,

When using our customized fuzzer tool to fuzz the latest Linux kernel, =
the following crash (40s)
was triggered.

HEAD commit: 9d89551994a430b50c4fffcb1e617a057fa76e20
git tree: upstream
Console output: =
https://drive.google.com/file/d/15EBah7QQ03VRfHjEo5OXXlk5qWbVI4tf/view?usp=
=3Dsharing
Kernel config: =
https://drive.google.com/file/d/1w49JIxvyeFZT7bqCXvZjozqpoLYLUvJH/view?usp=
=3Dsharing
C reproducer: =
https://drive.google.com/file/d/1czqOOvilUQ72hWWV0EBqVmL1PFUWKw2k/view?usp=
=3Dsharing
Syzlang reproducer: =
https://drive.google.com/file/d/1rF5bJCUHeBf_YBqI1E8yzEnrW8QdrSiR/view?usp=
=3Dsharing
New crash log: =
https://drive.google.com/file/d/1reYrjFPhMMziRp2IEH5sMGRsGcZ8za65/view?usp=
=3Dsharing

We firstly encounter the crash in gfs2_aspace_writepages on 6.13-rc5, =
but we failed to get the C and Syzlang reproducer. After that, we try to =
obtain reproducers for multiple rounds of testing on 6.13-rc6, and found =
that the location of this issue has varied to gfs2_glock_nq. I=E2=80=99m =
not sure the above infomations whether is enough to locate the bug or =
not? If you need more infos, please let me know.

If you fix this issue, please add the following tag to the commit:
Reported-by: Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin =
<jjtan24@m.fudan.edu.cn>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
INFO: task kworker/u17:2:56 blocked for more than 143 seconds.
      Not tainted 6.13.0-rc5 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this =
message.
task:kworker/u17:2   state:D stack:24424 pid:56    tgid:56    ppid:2     =
 flags:0x00004000
Workqueue: writeback wb_workfn (flush-7:1)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0xe60/0x4120 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0xd4/0x210 kernel/sched/core.c:6848
 io_schedule+0x1a/0x70 kernel/sched/core.c:7681
 bit_wait_io+0x15/0xe0 kernel/sched/wait_bit.c:247
 __wait_on_bit_lock+0x12d/0x1c0 kernel/sched/wait_bit.c:90
 out_of_line_wait_on_bit_lock+0xd8/0x110 kernel/sched/wait_bit.c:117
 wait_on_bit_lock_io include/linux/wait_bit.h:221 [inline]
 __lock_buffer+0x66/0x70 fs/buffer.c:71
 lock_buffer include/linux/buffer_head.h:426 [inline]
 gfs2_aspace_write_folio fs/gfs2/meta_io.c:56 [inline]
 gfs2_aspace_writepages+0x441/0x530 fs/gfs2/meta_io.c:96
 do_writepages+0x19d/0x7d0 mm/page-writeback.c:2702
 filemap_fdatawrite_wbc+0xe9/0x120 mm/filemap.c:397
 __filemap_fdatawrite_range+0xc1/0x110 mm/filemap.c:430
 gfs2_write_inode+0x2ec/0x450 fs/gfs2/super.c:463
 write_inode fs/fs-writeback.c:1525 [inline]
 __writeback_single_inode+0xb09/0x1010 fs/fs-writeback.c:1745
 writeback_sb_inodes+0x5ee/0xf00 fs/fs-writeback.c:1976
 wb_writeback+0x1a9/0xb50 fs/fs-writeback.c:2156
 wb_do_writeback fs/fs-writeback.c:2303 [inline]
 wb_workfn+0x134/0xe10 fs/fs-writeback.c:2343
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0x5ee/0x1ba0 kernel/workqueue.c:3310
 worker_thread+0x59f/0xcf0 kernel/workqueue.c:3391
 kthread+0x345/0x450 kernel/kthread.c:389
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz.1.14:1738 blocked for more than 143 seconds.
      Not tainted 6.13.0-rc5 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this =
message.
task:syz.1.14        state:D stack:23744 pid:1738  tgid:1736  ppid:423   =
 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0xe60/0x4120 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0xd4/0x210 kernel/sched/core.c:6848
 wb_wait_for_completion+0x187/0x240 fs/fs-writeback.c:216
 __writeback_inodes_sb_nr+0x1d7/0x280 fs/fs-writeback.c:2735
 sync_filesystem fs/sync.c:54 [inline]
 sync_filesystem+0xba/0x2a0 fs/sync.c:30
 gfs2_reconfigure+0xca/0xfc0 fs/gfs2/ops_fstype.c:1550
 reconfigure_super+0x375/0xbe0 fs/super.c:1083
 do_remount fs/namespace.c:3047 [inline]
 path_mount+0x17f2/0x1d60 fs/namespace.c:3826
 do_mount+0xf8/0x110 fs/namespace.c:3847
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount fs/namespace.c:4034 [inline]
 __x64_sys_mount+0x193/0x230 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc3/0x1d0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc80584d15e
RSP: 002b:00007fc80449d9b8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc80584d15e
RDX: 0000000020000f40 RSI: 0000000020000140 RDI: 0000000000000000
RBP: 00007fc80449da50 R08: 00007fc80449da50 R09: 0000000001a4a438
R10: 0000000001a4a438 R11: 0000000000000206 R12: 0000000020000f40
R13: 0000000020000140 R14: 00007fc80449da10 R15: 00000000200008c0
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/45:
 #0: ffffffff9631aea0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire =
include/linux/rcupdate.h:337 [inline]
 #0: ffffffff9631aea0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock =
include/linux/rcupdate.h:849 [inline]
 #0: ffffffff9631aea0 (rcu_read_lock){....}-{1:3}, at: =
debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6744
2 locks held by kworker/u17:2/56:
 #0: ff110000022f8948 ((wq_completion)writeback){+.+.}-{0:0}, at: =
process_one_work kernel/workqueue.c:3204 [inline]
 #0: ff110000022f8948 ((wq_completion)writeback){+.+.}-{0:0}, at: =
process_scheduled_works+0x1175/0x1ba0 kernel/workqueue.c:3310
 #1: ffa00000003d7d98 =
((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: =
process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffa00000003d7d98 =
((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: =
process_scheduled_works+0x52f/0x1ba0 kernel/workqueue.c:3310
1 lock held by in:imklog/327:
2 locks held by agetty/372:
 #0: ff11000005fbf0a0 (&tty->ldisc_sem){++++}-{0:0}, at: =
tty_ldisc_ref_wait+0x26/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffa00000034fb2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: =
n_tty_read+0x44e/0x14c0 drivers/tty/n_tty.c:2211
2 locks held by kworker/u17:5/738:
 #0: ff1100006a23c458 (&rq->__lock){-.-.}-{2:2}, at: =
raw_spin_rq_lock_nested+0x22/0x30 kernel/sched/core.c:598
 #1: ffa000001411fd98 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, =
at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffa000001411fd98 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, =
at: process_scheduled_works+0x52f/0x1ba0 kernel/workqueue.c:3310
1 lock held by syz.1.14/1738:
 #0: ff1100000b9520e0 (&type->s_umount_key#80){++++}-{4:4}, at: =
do_remount fs/namespace.c:3044 [inline]
 #0: ff1100000b9520e0 (&type->s_umount_key#80){++++}-{4:4}, at: =
path_mount+0x1340/0x1d60 fs/namespace.c:3826
1 lock held by syz.4.104/3635:
 #0: ff1100000b9520e0 (&type->s_umount_key#80){++++}-{4:4}, at: =
__super_lock fs/super.c:58 [inline]
 #0: ff1100000b9520e0 (&type->s_umount_key#80){++++}-{4:4}, at: =
super_lock+0x17a/0x3e0 fs/super.c:120
1 lock held by syz.9.725/6947:
 #0: ff1100000b9520e0 (&type->s_umount_key#80){++++}-{4:4}, at: =
__super_lock fs/super.c:58 [inline]
 #0: ff1100000b9520e0 (&type->s_umount_key#80){++++}-{4:4}, at: =
super_lock+0x17a/0x3e0 fs/super.c:120
1 lock held by syz.0.908/7881:
1 lock held by syz.8.911/7896:
 #0: ff1100000b9520e0 (&type->s_umount_key#80){++++}-{4:4}, at: =
__super_lock fs/super.c:58 [inline]
 #0: ff1100000b9520e0 (&type->s_umount_key#80){++++}-{4:4}, at: =
super_lock+0x17a/0x3e0 fs/super.c:120
1 lock held by syz.1.925/7982:
 #0: ffffffff963b1508 (event_mutex){+.+.}-{4:4}, at: =
perf_trace_destroy+0x27/0x1c0 kernel/trace/trace_event_perf.c:239
1 lock held by syz.6.932/8006:
 #0: ffffffff963b1508 (event_mutex){+.+.}-{4:4}, at: =
perf_trace_destroy+0x27/0x1c0 kernel/trace/trace_event_perf.c:239
1 lock held by syz.4.930/8013:
 #0: ffffffff963b1508 (event_mutex){+.+.}-{4:4}, at: =
perf_trace_destroy+0x27/0x1c0 kernel/trace/trace_event_perf.c:239
2 locks held by syz.0.933/8019:
 #0: ffffffffa1b03030 (&pmus_srcu){.+.+}-{0:0}, at: srcu_lock_acquire =
include/linux/srcu.h:158 [inline]
 #0: ffffffffa1b03030 (&pmus_srcu){.+.+}-{0:0}, at: srcu_read_lock =
include/linux/srcu.h:249 [inline]
 #0: ffffffffa1b03030 (&pmus_srcu){.+.+}-{0:0}, at: perf_init_event =
kernel/events/core.c:11987 [inline]
 #0: ffffffffa1b03030 (&pmus_srcu){.+.+}-{0:0}, at: perf_event_alloc =
kernel/events/core.c:12309 [inline]
 #0: ffffffffa1b03030 (&pmus_srcu){.+.+}-{0:0}, at: =
perf_event_alloc+0xe24/0x3ea0 kernel/events/core.c:12173
 #1: ffffffff963b1508 (event_mutex){+.+.}-{4:4}, at: =
perf_trace_init+0x4d/0x2f0 kernel/trace/trace_event_perf.c:221
2 locks held by syz.2.934/8023:
 #0: ffffffffa1b03030 (&pmus_srcu){.+.+}-{0:0}, at: srcu_lock_acquire =
include/linux/srcu.h:158 [inline]
 #0: ffffffffa1b03030 (&pmus_srcu){.+.+}-{0:0}, at: srcu_read_lock =
include/linux/srcu.h:249 [inline]
 #0: ffffffffa1b03030 (&pmus_srcu){.+.+}-{0:0}, at: perf_init_event =
kernel/events/core.c:11987 [inline]
 #0: ffffffffa1b03030 (&pmus_srcu){.+.+}-{0:0}, at: perf_event_alloc =
kernel/events/core.c:12309 [inline]
 #0: ffffffffa1b03030 (&pmus_srcu){.+.+}-{0:0}, at: =
perf_event_alloc+0xe24/0x3ea0 kernel/events/core.c:12173
 #1: ffffffff963b1508 (event_mutex){+.+.}-{4:4}, at: =
perf_trace_init+0x4d/0x2f0 kernel/trace/trace_event_perf.c:221

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


---------------
thanks,
Kun Hu=

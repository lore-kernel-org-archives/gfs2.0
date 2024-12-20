Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB16ECA4E;
	Fri, 20 Dec 2024 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734704393; cv=none; b=LPaBwHLjn5eCIv6R1mz3EkoJb8RIRMzua8K2tfn/tVvz/mYgaoIi+eoDTcgvRE5CcI081+AnMnooMrkZv3r0FgjxMYWrZ6X6I4vBSlTt6CO1MbeuALDtOGsx1t4D9JqkJmcuSZ2u8rgPCHsZKkcEzuegKs+lRhfbAMxQQCREIhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734704393; c=relaxed/simple;
	bh=kkEB3DbyvpGF2fyNm4TNUEL9zrtcxtRoXd/4XUnyLe4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A6YievQkyM7vxQPMOYGvmUKrRF8LOzZLbz1WqwecNZ8wEfIy2Hw6xg7apv1zeIqWGajkClhloUXSY8qZVIeBSZpVDBwxGfhlQUEshvEVcx1fVHi8eNck+J+mqxOZLXmpy913IPa6Mx0LYq56GELFgZsfbl1MjMh+4IS2ncW+lUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=UzN9gTBT; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="UzN9gTBT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=2JfVfghOBv4UC0em8e/2kmYFLI4yikzt9kTUaS3JkX4=; b=UzN9gTBTi0R8tbTO5LghvQJbG0
	rZ5fw66yVxcpzjbbgyrVwO0XJbXrrz7+SAjpdIpwQfv/4YcRDp9BmsXSKqqvFzEFkBjISPGs8pe97
	x6zZJCzDyTuiO/1qzWJ6KIPEkXRrdLtXn60Zt+FLwDzLYin8C7EGGJmwF9Knb4tSd57ajCNfFJGwP
	dJqA/pJLtb7mVNIm2TrjKQn0tHDd9h42AwgTkDVtqvSy7UYkuJYG+TiJ9n5huDHRGVLfZU0U+Z9XK
	HFfkCjNumtIC8UceOiFfuz/qyNWjIrvDDjY0iFicHIhqHzV0gkO1xShvXua21BeUvup6wmjQ5SRsY
	JvLUXCuw==;
Received: from 179-125-91-129-dinamico.pombonet.net.br ([179.125.91.129] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tOdqs-005ncx-T4; Fri, 20 Dec 2024 15:19:39 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: gfs2@lists.linux.dev
Cc: Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH] dlm: prevent NPD when writing a positive value to event_done
Date: Fri, 20 Dec 2024 11:19:13 -0300
Message-Id: <20241220141913.1346301-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

do_uevent returns the value written to event_done. In case it is a positive
value, new_lockspace would undo all the work, and lockspace would not be
set. __dlm_new_lockspace, however, would treat that positive value as a
success due to commit 8511a2728ab8 ("dlm: fix use count with multiple
joins").

Down the line, device_create_lockspace would pass that NULL lockspace to
dlm_find_lockspace_local, leading to a NULL pointer dereference:

[ 1130.159339] BUG: kernel NULL pointer dereference, address: 0000000000000020
[ 1130.160015] #PF: supervisor write access in kernel mode
[ 1130.160242] #PF: error_code(0x0002) - not-present page
[ 1130.160242] PGD 0 P4D 0
[ 1130.160242] Oops: Oops: 0002 [#1] PREEMPT SMP NOPTI
[ 1130.160242] CPU: 4 UID: 0 PID: 213 Comm: dlm Not tainted 6.13.0-rc3-00077-gcbfcf8f40ff5 #318 0df1a232d58f3206f4f481ddfc0108c8b3da89be
[ 1130.160242] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[ 1130.160242] RIP: 0010:dlm_find_lockspace_local+0x8/0x20
[ 1130.160242] Code: 75 f3 f0 ff 43 20 eb 02 31 db 48 c7 c7 50 d6 85 b0 e8 4c aa 58 01 48 89 d8 5b 5d c3 cc cc cc cc 66 90 0f 1f 44 00 00 48 89 f8 <f0> ff 47 20 c3 cc cc cc cc 66 66 66 66 66 66 2e 0f 1f 84 00 00 00
[ 1130.160242] RSP: 0018:ffffa4bbc0637b08 EFLAGS: 00010246
[ 1130.160242] RAX: 0000000000000000 RBX: ffff8c8fc3cbab18 RCX: 0000000000000000
[ 1130.160242] RDX: 0000000000000006 RSI: ffffffffaeb012ce RDI: 0000000000000000
[ 1130.160242] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
[ 1130.160242] R10: 0000000000000000 R11: ffffffffac61e550 R12: ffff8c8fc34b5000
[ 1130.160242] R13: 000000000000007d R14: 0000000000000000 R15: ffff8c8fc3cbab00
[ 1130.160242] FS:  000078790ad92740(0000) GS:ffff8c903dd00000(0000) knlGS:0000000000000000
[ 1130.160242] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1130.160242] CR2: 0000000000000020 CR3: 000000000518a001 CR4: 0000000000770eb0
[ 1130.160242] PKRU: 55555554
[ 1130.160242] Call Trace:
[ 1130.160242]  <TASK>
[ 1130.160242]  ? __die_body+0x64/0xb0
[ 1130.160242]  ? page_fault_oops+0x3eb/0x490
[ 1130.160242]  ? exc_page_fault+0x4f2/0x6d0
[ 1130.160242]  ? asm_exc_page_fault+0x22/0x30
[ 1130.160242]  ? stack_trace_save+0x70/0x70
[ 1130.160242]  ? dlm_find_lockspace_local+0x8/0x20
[ 1130.160242]  device_create_lockspace+0x7c/0x180
[ 1130.160242]  device_write+0x252/0x310
[ 1130.160242]  vfs_write+0xe3/0x350
[ 1130.160242]  ksys_write+0x74/0xe0
[ 1130.160242]  do_syscall_64+0x87/0x100
[ 1130.160242]  ? _raw_spin_unlock_irqrestore+0x3d/0x60
[ 1130.160242]  ? __slab_free+0x2b6/0x320
[ 1130.160242]  ? do_sys_openat2+0xae/0xe0
[ 1130.160242]  ? kmem_cache_free+0x146/0x380
[ 1130.160242]  ? do_syscall_64+0x93/0x100
[ 1130.160242]  ? lockdep_hardirqs_on+0x95/0x140
[ 1130.160242]  ? syscall_exit_to_user_mode+0x1f0/0x270
[ 1130.160242]  ? do_syscall_64+0x93/0x100
[ 1130.160242]  ? do_pte_missing+0xfd/0x1410
[ 1130.160242]  ? do_pte_missing+0x1e7/0x1410
[ 1130.160242]  ? handle_mm_fault+0x7ad/0xa30
[ 1130.160242]  ? reacquire_held_locks+0x124/0x1c0
[ 1130.160242]  ? vma_end_read+0x12/0xe0
[ 1130.160242]  ? exc_page_fault+0x49e/0x6d0
[ 1130.160242]  ? lockdep_hardirqs_on+0x95/0x140
[ 1130.160242]  ? irqentry_exit_to_user_mode+0x1a7/0x1f0
[ 1130.160242]  ? exc_page_fault+0x49e/0x6d0
[ 1130.160242]  entry_SYSCALL_64_after_hwframe+0x55/0x5d
[ 1130.160242] RIP: 0033:0x78790aeb0214
[ 1130.160242] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d 55 b1 0e 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 48 89 54 24 18 48
[ 1130.160242] RSP: 002b:00007ffc0309b5e8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[ 1130.160242] RAX: ffffffffffffffda RBX: 00007ffc0309b7c8 RCX: 000078790aeb0214
[ 1130.160242] RDX: 000000000000007d RSI: 00007ffc0309b610 RDI: 0000000000000003
[ 1130.160242] RBP: 00007ffc0309b6b0 R08: 0000000000000000 R09: 000078790afd1210
[ 1130.160242] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
[ 1130.160242] R13: 00007ffc0309b7d8 R14: 000056989ab4bd98 R15: 000078790b003000
[ 1130.160242]  </TASK>
[ 1130.160242] Modules linked in: mousedev
[ 1130.160242] CR2: 0000000000000020
[ 1130.160242] ---[ end trace 0000000000000000 ]---
[ 1130.160242] RIP: 0010:dlm_find_lockspace_local+0x8/0x20
[ 1130.160242] Code: 75 f3 f0 ff 43 20 eb 02 31 db 48 c7 c7 50 d6 85 b0 e8 4c aa 58 01 48 89 d8 5b 5d c3 cc cc cc cc 66 90 0f 1f 44 00 00 48 89 f8 <f0> ff 47 20 c3 cc cc cc cc 66 66 66 66 66 66 2e 0f 1f 84 00 00 00
[ 1130.160242] RSP: 0018:ffffa4bbc0637b08 EFLAGS: 00010246
[ 1130.160242] RAX: 0000000000000000 RBX: ffff8c8fc3cbab18 RCX: 0000000000000000
[ 1130.160242] RDX: 0000000000000006 RSI: ffffffffaeb012ce RDI: 0000000000000000
[ 1130.160242] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
[ 1130.160242] R10: 0000000000000000 R11: ffffffffac61e550 R12: ffff8c8fc34b5000
[ 1130.160242] R13: 000000000000007d R14: 0000000000000000 R15: ffff8c8fc3cbab00
[ 1130.160242] FS:  000078790ad92740(0000) GS:ffff8c903dd00000(0000) knlGS:0000000000000000
[ 1130.160242] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1130.160242] CR2: 0000000000000020 CR3: 000000000518a001 CR4: 0000000000770eb0
[ 1130.160242] PKRU: 55555554
[ 1130.160242] Kernel panic - not syncing: Fatal exception
[ 1130.160242] Kernel Offset: 0x2b400000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)

Treating such positive values as successes prevents the problem. Given this
has been broken for so long, this is unlikely to break userspace
expectations.

Fixes: 8511a2728ab8 ("dlm: fix use count with multiple joins")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/dlm/lockspace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 8afac6e2dff0..1929327ffbe1 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -576,7 +576,7 @@ static int new_lockspace(const char *name, const char *cluster,
 	   lockspace to start running (via sysfs) in dlm_ls_start(). */
 
 	error = do_uevent(ls, 1);
-	if (error)
+	if (error < 0)
 		goto out_recoverd;
 
 	/* wait until recovery is successful or failed */
-- 
2.34.1


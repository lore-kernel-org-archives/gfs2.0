Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E892219DF4D
	for <gfs2@lists.linux.dev>; Wed,  4 Feb 2026 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770224322; cv=none; b=HSLSxnljgGzzLKqNsZ9egaYxoWLGLAJ/gaGMmNAlS/vhoOWsmnsqme2E+jqWoN6UGptwNQWiGrOtAEjwYiJysOoOJPuYtNN+mLafhNfEqE1UgJqls9ukre/r1+Dqu2W337y8o7qsznRcRjOPH5I02BCiUJP0MPPfTvr3TcteyXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770224322; c=relaxed/simple;
	bh=lU2WsBPhcxscoZw+O2DvIw00RsiPU9CY6EVhEJiOiAg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Xi2mp/nybZsF7mOTocWEdhmr7ype+ZFgWVUDb/IpHZtkDrzh505VJm20UUNGIuh3tbOjAfA1F25qTARyuhL341SVj2wkrmjUiWA8/1ZcYTwyUDt6zIk1ZwbOZ9gdC0An8HnY5EvT8nc5W54iOctH4TH4ggGI5uWbux+yBeaNWto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-662f839d680so13607eaf.2
        for <gfs2@lists.linux.dev>; Wed, 04 Feb 2026 08:58:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770224321; x=1770829121;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NSyDNamann+yh93+/JRAZDIVe/U2O2ydLQcczFr/+hM=;
        b=EqCUQ3RcB0d84sN10uzUMCDG3vFV70pZReTNKzqjIwT+l7FJfkzqtWGlUPVY8SM/ug
         yURZdTpRNe7sf1knWVc0mTq/sP17YQdA4OOed8DNy0nvB3qyCu+Xtt4u6zULS0FGsT+b
         SU4ckzBljTpvxGnHpdtHfY1Qzhru/0hfBBCmTTJAxMCVxnhVhdoMaOTK82mcZDGR/rwM
         AD0KArdKFExEMYt22uTN8eE7N1DmF+V/R/bnTRW9jPJ0FpE88CHZlJ0/1F5TGNIujMmX
         4xbyvuIijQZ+K+ePUrvk5WEm2Vu08CX6jYYS3UKVknbOUX96py0U2wk978G3MFSt/Deu
         Nm5A==
X-Forwarded-Encrypted: i=1; AJvYcCXZFi0k6lFpQ44vc15IPMeR6sLa2uRKCrgdE39t/kRYFpm16mptptV2DKI0J10LPwhIa/hV@lists.linux.dev
X-Gm-Message-State: AOJu0YzuBSCFoLFZscZNgoa9qh0rV33pYe/KBcZmT1bh5yK44XYYnGlQ
	ZSdURpRO4UoVUI0O15rC1NmbiXRTeVft+h8EucPxqSx4ykWh1N+aUfUwJz0gURTh8YiZ5lC+bIQ
	38C8+rd83Zh0TXqg2DV3LiVWCzwhATseIKLilP6NDMyCiV5O4EK8ZiQslFCE=
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1524:b0:663:2b12:14fa with SMTP id
 006d021491bc7-66a229792d7mr1787822eaf.51.1770224320836; Wed, 04 Feb 2026
 08:58:40 -0800 (PST)
Date: Wed, 04 Feb 2026 08:58:40 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69837ac0.a00a0220.34fa92.0011.GAE@google.com>
Subject: [syzbot] [gfs2?] memory leak in gfs2_quota_init (2)
From: syzbot <syzbot+e57495fb65020ac7bca4@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    283073725700 Merge tag 'riscv-for-linus-6.19-rc8' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=108d3c5a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7d0fbecb37bff8
dashboard link: https://syzkaller.appspot.com/bug?extid=e57495fb65020ac7bca4
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=158fa72a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=174c9644580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/29ae0baa9654/disk-28307372.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cc5f836cdf79/vmlinux-28307372.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c40c2fb29195/bzImage-28307372.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/bb1679f271de/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=170d3c5a580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e57495fb65020ac7bca4@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810e866000 (size 8192):
  comm "syz.0.477", pid 7931, jiffies 4295008793
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 8429a099):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    __do_kmalloc_node mm/slub.c:5656 [inline]
    __kmalloc_noprof+0x465/0x680 mm/slub.c:5669
    kmalloc_noprof include/linux/slab.h:961 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    gfs2_quota_init+0xe5/0x820 fs/gfs2/quota.c:1409
    gfs2_make_fs_rw+0x7a/0xe0 fs/gfs2/super.c:149
    gfs2_fill_super+0xfbb/0x1210 fs/gfs2/ops_fstype.c:1275
    get_tree_bdev_flags+0x1c0/0x290 fs/super.c:1691
    gfs2_get_tree+0x26/0xd0 fs/gfs2/ops_fstype.c:1332
    vfs_get_tree+0x30/0x120 fs/super.c:1751
    fc_mount fs/namespace.c:1199 [inline]
    do_new_mount_fc fs/namespace.c:3636 [inline]
    do_new_mount fs/namespace.c:3712 [inline]
    path_mount+0x5a9/0x1350 fs/namespace.c:4022
    do_mount fs/namespace.c:4035 [inline]
    __do_sys_mount fs/namespace.c:4224 [inline]
    __se_sys_mount fs/namespace.c:4201 [inline]
    __x64_sys_mount+0x1a3/0x1e0 fs/namespace.c:4201
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

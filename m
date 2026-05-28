Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B566C2F1FEF
	for <gfs2@lists.linux.dev>; Thu, 28 May 2026 20:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.194
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001187; cv=pass; b=SoVcFyuxU8IoG+gLnkb7+hpOLRL3nxJrER5nJbtMNoBBB93A67UxqaRvcPOGmTktC6OHksj0xUN9uDrObSu1Ug0XikAEsumWtHqlBHqfNAEa3zROarWmJc5mDVgooz4R0r8IwPepTnidsooLyo96U5ZNg6pdnslNuPIaCGQHPtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001187; c=relaxed/simple;
	bh=EDJNvm0YrjeMnSgMUb+fvcef3p2ZkXve5QJOezV7E5A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=EHSwRbdRiu3K33U28j4dxfxEVKkhEFhTU/Eyx49qWJguSrPrWhC37XSEnyNsibTw5sffj1jUnud9zJ6txQgOaMJStgb075w06+CSg5p+FWexnFmtVeObyr6HwdC/Fg4CdL2AiaiUD8Lkv3g7dOsG8XbmdJcErfR6ePZLVywGqvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=l5J5ttpD; arc=pass smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="l5J5ttpD"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-7dc78af7371so15058297b3.1
        for <gfs2@lists.linux.dev>; Thu, 28 May 2026 13:46:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780001185; cv=none;
        d=google.com; s=arc-20240605;
        b=IVK01FelBM0ON3oJyZVqKBrmolzB4j/0oT1khj48af2ggDuLRMa0IriYa9VS1XugB+
         4Mb+NFONEEtgwCOFB4IUxEAx8OJin0Qb8tbssKoTCdsn/7yUAoEOxXN9psjwGbrPuyoG
         o6RQQjymMK7fKHLUcOUeGJOwvVZdHPGYKicKLVb4pBvJCm2ZPhiYCQvoTh+7r7SuQ9Fb
         7hsrf5I29/+a4mw4b0qgvDptgzvGDQgfqtbXOY0wClzdreWZGQEByjKWuKibaw0bejzS
         LhvOL5UU/LLaw/lPnXCCPr1v4mdwx+VmOfSqCsfHreERHJ0yhvJV+9BQt3wMJwVdqVTL
         Dr0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=HjgfqX7QNXnSnP3koXPVYHPRxEus+HDmNJT6HKYumdw=;
        fh=CU3YQPcG4g+2LYYdTdWurlbOyfsaHGBahtksic2Le70=;
        b=Mb6fPr33PckvOFE9BoV4SNIUTUx73H96vxAtA0sCkr7qTM7RquUIXzqVn3YCKn5YaW
         LqAdIF1ParSrg+6DBfvgw1BQqIvRg8mq3C4NvALKTvA9m5piVRnioj4FEiNAGER1tHG2
         f1UzXQFw/vNO+mU3TEyHul64tKk5u86QDwfhEEOlzaivZdCFxDx1PMeWXtL0AkpLYof+
         PJxxrHhLGew9Wck6ZcEGOatG9L/+d1Hg23sQ1oWKJGr69muef31a4dI+QEpHrRrLGj1T
         U/efNUTM44JYtwcttIgrTWj7lCVbwcuUgndKA/oUyWnsH9a+bDr/UD6wFXQasWWOS4B1
         1Fog==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1780001185; x=1780605985; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HjgfqX7QNXnSnP3koXPVYHPRxEus+HDmNJT6HKYumdw=;
        b=l5J5ttpDq+PbF68FW0DB1/0cPdIa8xGAbsicHg9pGWCOQ03kT5LKafxngosozihImQ
         8JXEa/JjcUan0crhXd7iLyRFRDdFgYkk8SmuWuWV2bmAiH/NLYbueS2832xmAO/szTrf
         V+w0MvisA9a/qvwwSn0zSgPWAA4KjknQsbKpuSIoT+nMZ7n5UKXkIBPRXexX2Xts24L5
         rjS4GOajto66+mHyA007edG5mJIOCWajspYidZxN3nbnY/U8e6Ya/b9mOaUl2FUv+1ba
         kiIVtMwg2w6RreSQcXJkmkJsWktGkOCRQMqNGrpcdNp3Sg8v55DJT6NUMXSnrHH2ujDh
         RyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780001185; x=1780605985;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HjgfqX7QNXnSnP3koXPVYHPRxEus+HDmNJT6HKYumdw=;
        b=acVh/aSMRuhmPI/KDbb7h7MGdU4RqXb+teigIQzdkYov6X2Q5JxGMqKpim0024w92w
         MnZf2ecNtMyzcg+QlfZu/gjhgYWUMOBC9ozR6FwCyG6DFhorGctbjOuS2ORcQ2j3amgz
         aVh1UfGvN6bezyfv0Zr0SXno4s3aVUXcZ/iY/hQabPUnxL1oW++FZgbiXiHLoomplfs8
         wxUZpBlvW6akGeTPIN7gC0CV6iyA8+M48enBvqvECgw35nIT/QqK41xBHQEa2m3MAGcv
         o0YAZ4jnWr4hzv7KERWwfqjQKSAwPcRHPkZs4eATntLmhIIBUaJ17s2IQLReZGt5lSTe
         rMvA==
X-Forwarded-Encrypted: i=1; AFNElJ9LBmo5zapmyW91QvKq02qk6SeAGeg+dNtSiY/TtOSD8ju1XIUDxBeEmf4DpU+tiKg6D5UY@lists.linux.dev
X-Gm-Message-State: AOJu0YyqzRA7RH36VuhsK2Lylm23PatyzTNGL5y3yqHISFy+m74f+qoL
	5uvCZxJGpQQJIqoQsCKMdZl46QwYvdCYFuA/+9WL1Q+a33on8jsuW7bb3Bir1bR6gMumz+ltlly
	ScJtVIEIciX1Yb/RT7M8YtGL1Fd2ffxGJjl/SyfsO
X-Gm-Gg: Acq92OGdhNdhKI9878B1S5gzly5CLRvHpwvsCblroFyla+6mytJiroAPzeiBmQ5W+S8
	DUxeXxs3VcDkdvy5L/0w1EHFo0ywkJ1UsJsOkhD7LPprMZ75N6XF1Rs5cbtg5CxDXHI652RNPHr
	XFo9ym+SKnK5sloI8Usjw8t0fSd94thShkixp/dMSuaPMlv1vpGSEemH0B39VFRzk4CUdip99xQ
	NFEHRF9c0HYA5UKOp5/XTeswk6HPvHL0NkcZkszUiTPuScI5ejQDA6spgm+iqB/zO/llQRHHg6M
	B1ZumE6qM1jvdqscmQ==
X-Received: by 2002:a05:690c:c4c1:b0:7bd:a4dc:c22a with SMTP id
 00721157ae682-7ddc5519b99mr8715477b3.48.1780001183678; Thu, 28 May 2026
 13:46:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Farhad Alemi <farhad.alemi@berkeley.edu>
Date: Thu, 28 May 2026 13:46:12 -0700
X-Gm-Features: AVHnY4JAj-3VfYypeFJ7wOHjZcqEp9eB_RGlPOsLE8_Y8Dvn9TOd4zDJQpub1m4
Message-ID: <CA+0ovCjP5N=37oRM53FfXZbZ7dRgTcJ1_kpT1JGxB55Npnr7TA@mail.gmail.com>
Subject: [BUG] gfs2: list_del corruption of i_rwsem.wait_list during unlinkat
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000041f9460652e6d211"

--00000000000041f9460652e6d211
Content-Type: text/plain; charset="UTF-8"

Hello Andreas and locking/gfs2 maintainers,

I am reporting a DEBUG_LIST list_del corruption on a gfs2 unlinkat()
path found by syzkaller. The slab the kernel implicates is gfs2_inode,
but the corrupted list is the rw_semaphore's own wait_list, so I am
Cc'ing the locking maintainers as well.

Summary:
On a contended unlinkat() against an inode on a mounted gfs2 image,
do_unlinkat() takes the target inode's i_rwsem via inode_lock_nested(),
falls into rwsem_down_write_slowpath(), and reaches
rwsem_try_write_lock(). The list_del(&waiter->list) at
kernel/locking/rwsem.c:662 (on v6.17.8) trips DEBUG_LIST in
__list_del_entry_valid_or_report() at lib/list_debug.c:62. The kernel
prints:

  slab gfs2_inode start ffff8881283f9aa0 pointer offset 304 size 1576
  list_del corruption. prev->next should be ffffc900075ffc40, but was
ffff8881283f9bd0. (prev=ffff8881283f9bd0)

The trapping entry is the queued waiter at ffffc900075ffc40; the
prev pointer it carries names slab+304 = ffff8881283f9bd0; and the
printed prev->next equals that same address (i.e. prev == prev->next).
Since list_del at kernel/locking/rwsem.c:662 operates on a waiter
queued on the rwsem's wait_list (rwsem_waiter carries no other list
membership in v6.17), and waiters live on the stack of the blocked
task, the prev pointer being in the gfs2_inode slab identifies
slab+304 as the i_rwsem.wait_list head itself.

Observed on:
- Linux 6.17.8, x86_64, QEMU Q35
- KASAN + DEBUG_LIST enabled
- Crash context: Comm: syz.2.171, PID 4766
- Reached on the fuzzed unlinkat() path: inode_lock_nested ->
  down_write_nested -> rwsem_down_write_slowpath ->
  rwsem_try_write_lock -> list_del(&waiter->list)
- As the fuzzer didn't have a reproducer for this,
  I have NOT verified this bug against linus/master at commit
  e8c2f9fdadee (v7.1-rc4-754-ge8c2f9fdadee); the relevant
  data structure was restructured in commit 1ea4b473504b
  ("locking/rwsem: Remove the list_head from struct rw_semaphore",
  Matthew Wilcox (Oracle), 2026-03-05, first appearing in v7.1-rc1).
  After that commit struct rw_semaphore no longer contains a
  list_head wait_list; waiters are linked via sem->first_waiter
  plus inter-waiter waiter->list.

Impact:
A user with the privileges to mount a gfs2 image and perform an
unlinkat() on a contended path trips kernel BUG, killing the kernel.
The full Oops header, register dump, and call trace are in
crash-report.txt. The trapping RIP is
__list_del_entry_valid_or_report+0x15a/0x190 (lib/list_debug.c:62);
the kernel BUG fires at lib/list_debug.c:64.

Expected behavior:
Either the rwsem's wait_list invariant (no list_del observing a
self-referencing prev while a waiter is queued) was violated, or an
overlapping lifecycle operation on the gfs2_inode placed the rwsem
into an inconsistent state. The maintainers are best placed to
identify the root cause.

Reproducer:
A standalone .syz or C reproducer was not produced for this seed;
the crash fired during automated gfs2 unlink fuzzing. The console
report is attached as crash-report.txt.

Novelty check:
I searched the syzbot dashboard's upstream open, fixed, stable, and
invalid (per-subsystem gfs2/locking/fs) namespaces, the Android
dashboard, and the marc.info linux-kernel archive, for
"__list_del_entry_valid_or_report" + "rwsem", "list_del corruption"
+ "gfs2_inode", "rwsem_try_write_lock" + "gfs2", "rwsem" +
"wait_list" + "corruption", and "corrupted list in do_unlinkat". I
did not find an exact match. The adjacent gfs2 + do_unlinkat tickets
in the invalid namespace are task-hung / soft-lockup / deadlock
variants, not DEBUG_LIST list_del trips. The adjacent
__list_del_entry_valid_or_report ticket is a KCSAN data-race in
nfc_llcp_register_device, a different code path.


I appreciate your time and consideration, and I'm grateful for your
work on this subsystem. I'd be glad to test any candidate patches.

Regards,

--00000000000041f9460652e6d211
Content-Type: text/plain; charset="US-ASCII"; name="crash-report.txt"
Content-Disposition: attachment; filename="crash-report.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mppygz770>
X-Attachment-Id: f_mppygz770

IHNsYWIgZ2ZzMl9pbm9kZSBzdGFydCBmZmZmODg4MTI4M2Y5YWEwIHBvaW50ZXIgb2Zmc2V0IDMw
NCBzaXplIDE1NzYKbGlzdF9kZWwgY29ycnVwdGlvbi4gcHJldi0+bmV4dCBzaG91bGQgYmUgZmZm
ZmM5MDAwNzVmZmM0MCwgYnV0IHdhcyBmZmZmODg4MTI4M2Y5YmQwLiAocHJldj1mZmZmODg4MTI4
M2Y5YmQwKQotLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0Ka2VybmVsIEJVRyBh
dCBsaWIvbGlzdF9kZWJ1Zy5jOjY0IQpPb3BzOiBpbnZhbGlkIG9wY29kZTogMDAwMCBbIzFdIFNN
UCBLQVNBTiBOT1BUSQpDUFU6IDAgVUlEOiAwIFBJRDogNDc2NiBDb21tOiBzeXouMi4xNzEgTm90
IHRhaW50ZWQgNi4xNy44ICMxIFBSRUVNUFQoZnVsbCkgCkhhcmR3YXJlIG5hbWU6IFFFTVUgU3Rh
bmRhcmQgUEMgKFEzNSArIElDSDksIDIwMDkpLCBCSU9TIDEuMTYuMy1kZWJpYW4tMS4xNi4zLTIg
MDQvMDEvMjAxNApSSVA6IDAwMTA6X19saXN0X2RlbF9lbnRyeV92YWxpZF9vcl9yZXBvcnQrMHgx
NWEvMHgxOTAgbGliL2xpc3RfZGVidWcuYzo2MgpDb2RlOiBlOCA1YiBjYiBmZSBmZCA0MyA4MCAz
YyAyYyAwMCA3NCAwOCA0YyA4OSBmZiBlOCBhYyA5ZiAxYSBmZSA0OSA4YiAxNyA0OCBjNyBjNyBh
MCAyYSA5OCA4NiA0OCA4OSBkZSA0YyA4OSBmOSBlOCBlNyBkOSA1OSBmZCA5MCA8MGY+IDBiIDRj
IDg5IGY3IGU4IDJjIGNiIGZlIGZkIDQzIDgwIDNjIDJjIDAwIDc0IDA4IDRjIDg5IGZmIGU4IDdk
ClJTUDogMDAxODpmZmZmYzkwMDA3NWZmYWQwIEVGTEFHUzogMDAwMTAwNDYKUkFYOiAwMDAwMDAw
MDAwMDAwMDZkIFJCWDogZmZmZmM5MDAwNzVmZmM0MCBSQ1g6IGQyZWI0M2I3NzZmZjFiMDAKUkRY
OiAwMDAwMDAwMDAwMDAwMDAwIFJTSTogMDAwMDAwMDA4MDAwMDAwMiBSREk6IDAwMDAwMDAwMDAw
MDAwMDAKUkJQOiBmZmZmYzkwMDA3NWZmZDEwIFIwODogZmZmZjg4ODIzNWMyNDBkMyBSMDk6IDFm
ZmZmMTEwNDZiODQ4MWEKUjEwOiBkZmZmZmMwMDAwMDAwMDAwIFIxMTogZmZmZmVkMTA0NmI4NDgx
YiBSMTI6IDFmZmZmMTEwMjUwN2YzN2EKUjEzOiBkZmZmZmMwMDAwMDAwMDAwIFIxNDogZmZmZjg4
ODEyODNmOWJkMCBSMTU6IGZmZmY4ODgxMjgzZjliZDAKRlM6ICAwMDAwN2Y5ODlkNjU1NmMwKDAw
MDApIEdTOmZmZmY4ODgyYWJiZTgwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMApDUzog
IDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzCkNSMjogMDAwMDdm
ZmU4ZDg2ZGY4MCBDUjM6IDAwMDAwMDAxMWRhNDYwMDAgQ1I0OiAwMDAwMDAwMDAwNzUwZWYwClBL
UlU6IDgwMDAwMDAwCkNhbGwgVHJhY2U6CiA8VEFTSz4KIF9fbGlzdF9kZWxfZW50cnlfdmFsaWQg
aW5jbHVkZS9saW51eC9saXN0Lmg6MTI0IFtpbmxpbmVdCiBfX2xpc3RfZGVsX2VudHJ5IGluY2x1
ZGUvbGludXgvbGlzdC5oOjIxNSBbaW5saW5lXQogbGlzdF9kZWwgaW5jbHVkZS9saW51eC9saXN0
Lmg6MjI5IFtpbmxpbmVdCiByd3NlbV90cnlfd3JpdGVfbG9jayBrZXJuZWwvbG9ja2luZy9yd3Nl
bS5jOjY2MiBbaW5saW5lXQogcndzZW1fZG93bl93cml0ZV9zbG93cGF0aCsweDk0ZS8weDEwNDAg
a2VybmVsL2xvY2tpbmcvcndzZW0uYzoxMTU5CiBfX2Rvd25fd3JpdGVfY29tbW9uIGtlcm5lbC9s
b2NraW5nL3J3c2VtLmM6MTMxNyBbaW5saW5lXQogX19kb3duX3dyaXRlIGtlcm5lbC9sb2NraW5n
L3J3c2VtLmM6MTMyNiBbaW5saW5lXQogZG93bl93cml0ZV9uZXN0ZWQrMHgxY2IvMHgyMTAga2Vy
bmVsL2xvY2tpbmcvcndzZW0uYzoxNzA3CiBpbm9kZV9sb2NrX25lc3RlZCBpbmNsdWRlL2xpbnV4
L2ZzLmg6OTE2IFtpbmxpbmVdCiBkb191bmxpbmthdCsweDFkYy8weDU5MCBmcy9uYW1laS5jOjQ2
NDUKIF9fZG9fc3lzX3VubGlua2F0IGZzL25hbWVpLmM6NDY5OSBbaW5saW5lXQogX19zZV9zeXNf
dW5saW5rYXQgZnMvbmFtZWkuYzo0NjkyIFtpbmxpbmVdCiBfX3g2NF9zeXNfdW5saW5rYXQrMHhk
OC8weGYwIGZzL25hbWVpLmM6NDY5MgogZG9fc3lzY2FsbF94NjQgYXJjaC94ODYvZW50cnkvc3lz
Y2FsbF82NC5jOjYzIFtpbmxpbmVdCiBkb19zeXNjYWxsXzY0KzB4ZjAvMHgzOTAgYXJjaC94ODYv
ZW50cnkvc3lzY2FsbF82NC5jOjk0CiBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg3
Ny8weDdmClJJUDogMDAzMzoweDdmOTg5ZWM0Nzc4ZApDb2RlOiBmZiBjMyA2NiAyZSAwZiAxZiA4
NCAwMCAwMCAwMCAwMCAwMCA5MCBmMyAwZiAxZSBmYSA0OCA4OSBmOCA0OCA4OSBmNyA0OCA4OSBk
NiA0OCA4OSBjYSA0ZCA4OSBjMiA0ZCA4OSBjOCA0YyA4YiA0YyAyNCAwOCAwZiAwNSA8NDg+IDNk
IDAxIGYwIGZmIGZmIDczIDAxIGMzIDQ4IGM3IGMxIGIwIGZmIGZmIGZmIGY3IGQ4IDY0IDg5IDAx
IDQ4ClJTUDogMDAyYjowMDAwN2Y5ODlkNjU1MDE4IEVGTEFHUzogMDAwMDAyNDYgT1JJR19SQVg6
IDAwMDAwMDAwMDAwMDAxMDcKUkFYOiBmZmZmZmZmZmZmZmZmZmRhIFJCWDogMDAwMDdmOTg5ZWVk
NjE4MCBSQ1g6IDAwMDA3Zjk4OWVjNDc3OGQKUkRYOiAwMDAwMDAwMDAwMDAwMDAwIFJTSTogMDAw
MDIwMDAwMDAzOThjMCBSREk6IGZmZmZmZmZmZmZmZmZmOWMKUkJQOiAwMDAwN2Y5ODllY2VlYjNk
IFIwODogMDAwMDAwMDAwMDAwMDAwMCBSMDk6IDAwMDAwMDAwMDAwMDAwMDAKUjEwOiAwMDAwMDAw
MDAwMDAwMDAwIFIxMTogMDAwMDAwMDAwMDAwMDI0NiBSMTI6IDAwMDAwMDAwMDAwMDAwMDAKUjEz
OiAwMDAwN2Y5ODllZWQ2MjE4IFIxNDogMDAwMDdmOTg5ZWVkNjE4MCBSMTU6IDAwMDA3ZmZlOGQ4
NmU4NTAKIDwvVEFTSz4KTW9kdWxlcyBsaW5rZWQgaW46Ci0tLVsgZW5kIHRyYWNlIDAwMDAwMDAw
MDAwMDAwMDAgXS0tLQpSSVA6IDAwMTA6X19saXN0X2RlbF9lbnRyeV92YWxpZF9vcl9yZXBvcnQr
MHgxNWEvMHgxOTAgbGliL2xpc3RfZGVidWcuYzo2MgpDb2RlOiBlOCA1YiBjYiBmZSBmZCA0MyA4
MCAzYyAyYyAwMCA3NCAwOCA0YyA4OSBmZiBlOCBhYyA5ZiAxYSBmZSA0OSA4YiAxNyA0OCBjNyBj
NyBhMCAyYSA5OCA4NiA0OCA4OSBkZSA0YyA4OSBmOSBlOCBlNyBkOSA1OSBmZCA5MCA8MGY+IDBi
IDRjIDg5IGY3IGU4IDJjIGNiIGZlIGZkIDQzIDgwIDNjIDJjIDAwIDc0IDA4IDRjIDg5IGZmIGU4
IDdkClJTUDogMDAxODpmZmZmYzkwMDA3NWZmYWQwIEVGTEFHUzogMDAwMTAwNDYKUkFYOiAwMDAw
MDAwMDAwMDAwMDZkIFJCWDogZmZmZmM5MDAwNzVmZmM0MCBSQ1g6IGQyZWI0M2I3NzZmZjFiMDAK
UkRYOiAwMDAwMDAwMDAwMDAwMDAwIFJTSTogMDAwMDAwMDA4MDAwMDAwMiBSREk6IDAwMDAwMDAw
MDAwMDAwMDAKUkJQOiBmZmZmYzkwMDA3NWZmZDEwIFIwODogZmZmZjg4ODIzNWMyNDBkMyBSMDk6
IDFmZmZmMTEwNDZiODQ4MWEKUjEwOiBkZmZmZmMwMDAwMDAwMDAwIFIxMTogZmZmZmVkMTA0NmI4
NDgxYiBSMTI6IDFmZmZmMTEwMjUwN2YzN2EKUjEzOiBkZmZmZmMwMDAwMDAwMDAwIFIxNDogZmZm
Zjg4ODEyODNmOWJkMCBSMTU6IGZmZmY4ODgxMjgzZjliZDAKRlM6ICAwMDAwN2Y5ODlkNjU1NmMw
KDAwMDApIEdTOmZmZmY4ODgyYWJiZTgwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMApD
UzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzCkNSMjogMDAw
MDdmZmU4ZDg2ZGY4MCBDUjM6IDAwMDAwMDAxMWRhNDYwMDAgQ1I0OiAwMDAwMDAwMDAwNzUwZWYw
ClBLUlU6IDgwMDAwMDAwCgo8PDw8PDw8PDw8PDw8PDwgdGFpbCByZXBvcnQgPj4+Pj4+Pj4+Pj4+
Pj4+Cgo=
--00000000000041f9460652e6d211--

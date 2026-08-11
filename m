Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72DE2C21DF
	for <gfs2@lists.linux.dev>; Tue, 11 Aug 2026 04:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786421418; cv=pass; b=YyZkY6VX7XLMk8UgiGeUQiWz04o6RiMOKhTlrrRoX/iGolXKbdOy7ppi+WzpeavCfNp2Oa6ALIBFp+Wd6aGK/IHX9sjU0iz2qj78faTCAR8wYB3OoZ7zb6vo0h7zWFeMHfjM3PRCmL1EYU1rWGAKqrDGwqcry3qAz3bGy3s1vCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786421418; c=relaxed/simple;
	bh=UzmPob7U+DszjEwQYiUnXHSqrVJafTHAZyvCTekzRpE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=SYx2dDil/FerdvJQwYChTiwF1T1lY279LImMJC3a65PDfqgw4BbTJ463Ri5QIlWtA9H3eeEe8hRgx2xMYfpkeAdMnLlUpzvT5h82+mZwY1y1a3TB/KT6Eez3s1nAAgrFkU88qjSS9y3iAOEjLtMrYN/IjFdbi5mLd9/aeq6KVUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sslcBM9Z; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sslcBM9Z"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-529a1ee0e62so17961501cf.2
        for <gfs2@lists.linux.dev>; Mon, 10 Aug 2026 21:10:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786421416; cv=none;
        d=google.com; s=arc-20260327;
        b=WqzxaKSuCHPSK09Rl3RZQcXTD5syjw4kmqqOIqvq30cO+XNnb6u91aS3F4fRzlliGn
         ZgCWY2KfKQs68qw0JYDgB/ALeHzdzaKYgdVn6PftC5sx6dOkErVX6lKBf60ybIDBRWaS
         U+36P4fXAu4TCafFI2stykCRamekUCfq44W/UlH4FvKcjBdFPr5h4CqFUygvemVuEMMX
         YFFsu1BA6s3YIg11yJ8ligZv0uTu8tWNI6nVreJXQFhD2u+Pl2JtVMkK1w0xm8GnlPII
         7TO7EZ+WgbHkDYPYfu95s/Bb+Iw1nYMyBGBOb+igOeedZerdTcJZAXo+7jlBw51aX0nw
         X0EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=UzmPob7U+DszjEwQYiUnXHSqrVJafTHAZyvCTekzRpE=;
        fh=nC68G2AunKHK/BsqCHk3TwgLgnCdCGy5NGaFiE6LD9k=;
        b=W9BSVGJ4sBSGu0/rEI0uahaqUACTpuvtbxuWxJwFbBKX0egvTKCvYAgaUOgu1Swj7O
         +BJxJnESYStrnZm3MMykZuM4AEBY49LVQk33op2EIYQUjCsvkPw7xb/40IhFP/ZIInFr
         AWh9+nXUySRPfq08rlo2g04V7qaAHhsuyPQSQXXcTOFr6jvb/1WAw7dB/N5k6yfWAzCJ
         tLCTfug7OkM13di/qC4yBFPPnE6wjHblX19ZZJpRA/tyO6BxJn2loJUa9hyJxfrCKfOV
         ET8nkDtqwdsawFK8YWzwPrYLa+CLhlZuWUpmYSr1yzpuyCoj+jWd0OWYDLvTiC5Qo9z5
         CT5Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786421416; x=1787026216; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UzmPob7U+DszjEwQYiUnXHSqrVJafTHAZyvCTekzRpE=;
        b=sslcBM9Zjany2zy/70GVvU3cYh3xOm8BEwwSe7CCshLFpts9VEs2izlYOfQx82nbj1
         XT8+nGa2sy5lT7BuJZ0aF8asMdwqKD2j6HdoOR3GMJwYyRG/P8GG0Iv7cnS88lQa39ij
         Wh6QSIAaNNOhYGnC853HZXmUgu4Psbi/xIsVLDmA0/Qf4GYyTrs3bgB5SM/nJ5q8e69I
         tTW6wBmARG2Ja15W7bADEaId7hdumSL9E7B1dDmlN5H8RpCfi1KtUHlay/l6JTR12xqM
         q+ognGP62/a0j/xG8ARPJ1uvG5hE4+Vled7Xoy2ywsZTIfsfm8Z9neYui7wJZap9w3Y0
         ZDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786421416; x=1787026216;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UzmPob7U+DszjEwQYiUnXHSqrVJafTHAZyvCTekzRpE=;
        b=E0YrjCPT9tDlhUW25sYOZj7cEfvIgR/f3dydBAChRn0MrhwVOn+wxwBmS46APv0p10
         NBRFiK0LBGpO4Clx7qJqjjw2qF5h3bANaA/a5fVRXPGyYtOpPFjp6WmJ+5qL/LjLg4WX
         PQkLRojuhCzlBUXDjMg2fnDL4g/vuQ9tIYLUsh8n8jk9RcSyFod0OiMsmlCzE4b/v/17
         SAgcQRX2fEF8Hf0eKUwrhhoovZ89aBY07Uu3QNg3xOn8i9ehiUQ3WvBD5yytsk8Tddj9
         fRmlmJlab9NnsiYW5gK77VoeMLrbGenAq77YH9X16Sf9QSYpaK32I0ssA0xYyX7s8lrN
         dz4A==
X-Forwarded-Encrypted: i=1; AHgh+RoHjpncVkprYoVZ49YVYRsYzZwl3xdUYGHFLCuFNLFYr5xHJKZgcHgQCy141xkBbv+M0AmH@lists.linux.dev
X-Gm-Message-State: AOJu0YwyYvLNvABzNvWZY7FkADnO5TMkg5TP0/cg5OpY3wTjpGckWcJj
	kMPpuOqxNWbj7Ga1dZh4Him8zfN70LB9TmCZd2MciQtW3Rtu06QJq+PWA1vEmb8/Rqyw9yuPgDQ
	IqCqP9zX0odMVzp71fRir/DWfDtjUH0c=
X-Gm-Gg: AR+sD10xEBKnjqBaCMOr32Bg9O/+s0BWdp2wAOC1G9kYol1gjATUvVJfw1mFSb3Qx1w
	n5IPtuMI5Hr8GMnxNMO16ec2BCLQ/qlwSM66MjjZCGy2QbzUyDvwQgD69xpxwb9oGJeDYE/8SqD
	V3NIByW1ePmZ4dvlDaB7XQtwLh2Tpx/MNjU4Awag+tTnYPSuHqD5iT1nwaVSSG8txnbghMxSZ4v
	0A4g8lqHQWCRV0K7Wr/scIEddieK7JRYAOC/qTjCthIUynkW8rX5lweceyOO6OCAjXs+9sj8UDR
	YI60gWH/uFXC8T8Vu8Gk4rJ7fRTK1eOoD2CRKlRewObbpg==
X-Received: by 2002:a05:622a:5587:b0:51c:2190:3b56 with SMTP id
 d75a77b69052e-52d5861c4a9mr4777981cf.21.1786421415686; Mon, 10 Aug 2026
 21:10:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: ZW Tang <tangzw515@gmail.com>
Date: Tue, 11 Aug 2026 12:10:03 +0800
X-Gm-Features: AUfX_mzwaztD8H2fG5OOP7gHcyGUN5p1n-hLH2ZqABH4GnUHjKU5AFDUDDrPanY
Message-ID: <CAA2SOT4s2NLUvJKemj6RMdiO=6Jw9TV7nxhi=fsM+WiMH-We3A@mail.gmail.com>
Subject: [BUG] gfs2: hung task in gfs2_recover_func during journal recovery
To: Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I am reporting a hung task issue triggered by a syzkaller reproducer on
Linux 7.2-rc3.

The reproducer mounts a crafted GFS2 filesystem image. During mount,
GFS2 enters journal recovery. A kworker from the gfs2_recovery workqueue
gets stuck in I/O wait while running gfs2_recover_func(), and the mounting
syz task is also blocked waiting for journal recovery to complete.

This looks like a potential GFS2 journal recovery hang when processing a
malformed or corrupted filesystem image. The recovery worker waits in
gfs2_jhead_process_page() / gfs2_find_jhead(), while the mount path waits
in gfs2_recover_journal() from gfs2_fill_super().

Reproducer:
syz reproducer: https://pastebin.com/raw/Nt1QNWne
console output: https://pastebin.com/raw/TtBGNqf6
kernel config: https://pastebin.com/raw/ikdiZcSS

Kernel:
kernel version: 7.2.0-rc3 #1 PREEMPT(full)
HEAD commit: 1137d8b5df06137fb49513cc923b3b24d94cb809
environment: QEMU Ubuntu 24.10
taint: Not tainted

Relevant log:

INFO: task kworker/1:4:10801 blocked in I/O wait for more than 142 seconds.
Not tainted 7.2.0-rc3 #1

task/1:4 state stack:24024 pid:10801
Workqueue: gfs2_recovery gfs2_recover_func

Call Trace:
<TASK>
__schedule
schedule
io_schedule
folio_wait_bit_common
gfs2_jhead_process_page
gfs2_find_jhead
gfs2_recover_func
process_scheduled_works
worker_thread
kthread
ret_from_fork
ret_from_fork_asm
</TASK>

Another task is blocked in the mount path:

INFO: task syz.0.18:10824 blocked for more than 142 seconds.
Not tainted 7.2.0-rc3 #1

Call Trace:
<TASK>
__schedule
schedule
bit_wait
__wait_on_bit
out_of_line_wait_on_bit
gfs2_recover_journal
init_inodes
gfs2_fill_super
get_tree_bdev_flags
gfs2_get_tree
vfs_get_tree
fc_mount
path_mount
do_mount
__x64_sys_mount
do_syscall_64
entry_SYSCALL_64_after_hwframe
</TASK>

The system also shows the recovery work item still held by the blocked
worker:

2 locks held by kworker/1:4/10801:
#0: ((wq_completion)gfs2_recovery)
#1: ((work_completion)(&jd->jd_work))

The syzkaller program uses syz_mount_image$gfs2() to mount a crafted GFS2
image. It appears to drive GFS2 into journal recovery, where the recovery
worker waits indefinitely for journal page I/O and prevents the mount path
from making progress.

Thanks

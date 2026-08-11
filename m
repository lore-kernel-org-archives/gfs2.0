Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03FF25DB0D
	for <gfs2@lists.linux.dev>; Tue, 11 Aug 2026 06:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786428276; cv=pass; b=QQbV2mnOvqLF85gOoo6ZpteKGaVQ5wdwPiXZyucYTqsjgy4v22GFK7lZMK938s2/NxQo6vXc7fvo06iJHy1p44Gxied0Dcglfozud5CVGt9UYo6cwh7OEBBsXkwKKJIN0AG5z5GVDttZdN/1pMA4AGJqFe9T9QlBe6juibLxhVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786428276; c=relaxed/simple;
	bh=Uy/jO9mMvHF7aBTMw7yjC5vxOsOc/V/QjQx5Zj9oknI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rtCFIxyHamOeKWmJsOg05mB8Eqor00nKWF9UcJHiB4rpuhELvBphvaZkSrCLH/xVhwsJRsPwU8bMa/ntGIjHspYTv+z42OiV2AXZkfGLKx+hoED/D1MxuOGbJm2y4zSnkhopbRPxvsdcezIuVOsslbMAdwFbzlNopcGYWWQD4Xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlXw+rSO; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlXw+rSO"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51e4ba1cfb4so16046951cf.0
        for <gfs2@lists.linux.dev>; Mon, 10 Aug 2026 23:04:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786428274; cv=none;
        d=google.com; s=arc-20260327;
        b=kecHENUhRqD5DlqzXsOm9WAQSLZ6VAI+A6TmANDWbz27EWBcTG/k1qKI5AdOzqE4fS
         oGWMVNvEtvcNcokJc6TG9L/qRlV5iMozhkaqmrwhfY9ggRtGF+uABVG+mE9F9vYFvQMN
         ZeafJmkdfC0YN3//2ndKR+7GKAKifK1gfO1IL3y6bY8WBI4SsDAW3BIRDNyvFQvKcwhE
         HQ7PR131QHwpECajtH/5t0xDYlYgbEudHok9/XNULNoGlVHeB3ge7bwDya4skeAAKeo5
         AI8WuHSRXo/HQbSQ+GigTdHTRNsip3MsB2URQtswW6xnLTuqN8GmW9Y8K4IRIV/rDJ2A
         HpLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Uy/jO9mMvHF7aBTMw7yjC5vxOsOc/V/QjQx5Zj9oknI=;
        fh=Tv/QsSjRUfTQRL/7SBvDftqGuk/h+qdLjOZeQyBREYo=;
        b=EJHYwXCp9nj4HssXVJLmmEMN08L2gB9IVdcL5V24L9Yu45usUC0AGCersyFZhf62xL
         79JAV4Cl7JAmcy6t+x7mdzKG1vkh/Cro3PCtMqBGuGKUSho/VXvM5P47Yp76ZfPJwwSa
         20tyUDT8aFOmed7O5r9GJ2rW0QlP4TdyokmNP6QgJ9fkjml9Rtp15XIMlMzk26J9llB+
         rutxuYiDnh2i4qzIHtIDbmI9VVkDqvZcaiOGu5Xd0yaOUpWtEXHM4h0f4EjsgTl4g6tm
         n85TvHVoj4FXAK58KsxBnlfV4z70u7uteYnrVtVd0tGSLnBk1YeaVSW7CzkHF60DAlR5
         HKFw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786428274; x=1787033074; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uy/jO9mMvHF7aBTMw7yjC5vxOsOc/V/QjQx5Zj9oknI=;
        b=MlXw+rSOTp7I2RvdhRCaLN3ZVb4TvckYe7Y0QQ1Ot5dWdr2unXQxGlIGZpZzASEfGT
         HemsByjemeYryNlgGaFmJRgH7Tdq0SbbO3xIkymUvap77REBLb+j1yn0WzqAhcNztDX9
         MHpaOLrOowIf/5Mv7um85ngSGYGhWueW2PKxxG9zFxWY9H2uZpJRbH+GTrvY7CzqtV0b
         7w96bLzd4oRqroTRaCkOdw0HUEtHuMlzfahwuWczjW9K6WbdpIEmXssM+dZzSsEBM1Ag
         y6cKIShdVdDC8AZhvnaKyuUMDdI6btXZ5jX7hZEICP/SAuKRKYib5RIKKvxmoQSyRDh9
         QnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786428274; x=1787033074;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Uy/jO9mMvHF7aBTMw7yjC5vxOsOc/V/QjQx5Zj9oknI=;
        b=T96cEc/+vu/g25SPlkSJVMNT3y1uEa0efETznaof1keijryCizJ0gIAkngTsC+3tjG
         UcXIfB6EpHCy2SZJ2tfXwK7SX81R0O7/j2FXJIqozktKopgThSSIj/9xXIfWIredtSfs
         XT7/+E50APOIN5+7KSP549ys8ojYtprngeh6CDfHhe+VoM6WGjvDxKcUJi0ZIYREiv7N
         AtnnoIxDqLbhFrt5BmvmXhUYtX+QaRUbriQtV6jiAtU1NJazwushFBofyoKc4sv7AKan
         /AJ2Ut1H8BftVRqJtG9NG4y4vpHdtSF6JrX41Szk0OCx4AIuyuytSdvsm0Dt8VSZ7H49
         cvCQ==
X-Forwarded-Encrypted: i=1; AHgh+RoZiOCe+jgkTkt8BzkRPFHWWIZKEd0brhF/Ur/fhNCSlAUyGHS6HczQllIOedRX9j7XtoHv@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3Q3uMEfFqp8Sgq0wc50bFyurBXAXGIEfwqsu0jb5zbsyDOrsW
	dvx8Vb5WVS3+JAQhkk8eN7nI3zhgaWYOI7FVQ+5f8EMSld7CfChjopF97miYE9MPInFuErhgfUt
	B/pcbJNVJsqAp3Ub5bez5zCE0u/w05qM4OJ/uPFo=
X-Gm-Gg: AR+sD133CE0ouFYRJszGUc/3eXhScH3v0wSmvRFb80+bR2nbkgrGQWGqg98sDF2MqcE
	ckVwB9W7iIcyGnD04nlxjX1O5lH98dEGnoNUME4RhyD+oWk+qbgF2sQquC+i0qeXhHU4EQPI16t
	ddntmyho4etVo3GruFA4q2i4RP5ZIDAcbC3FNwQ6Uj66DwZdzLThiXHwv+qHSM2Lo+BRf044pzy
	cLfUyqgdhGmIrUE10gxSahvpYwZVZ5HfVRfnZdW3H07S6bhp4aTO4sw7BE5bsxQ3+KByK3SMjnR
	+A2OzVUN3xwEXxrQJ1msZ0/hclKWdrSdTGBq+vBfuLFjQ5INYN7lSzkmUw==
X-Received: by 2002:a05:622a:5143:b0:51b:9873:e379 with SMTP id
 d75a77b69052e-52d586240a7mr8413801cf.36.1786428274341; Mon, 10 Aug 2026
 23:04:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: ZW Tang <tangzw515@gmail.com>
Date: Tue, 11 Aug 2026 14:04:22 +0800
X-Gm-Features: AUfX_mw2ZX47eJCn_fWunjBoZh1gxZR-egPol-xLmwgaehivsR8jj3HsR92G7VA
Message-ID: <CAA2SOT47WN+ODLqB1-VbhVL-daQSU24f=99ojLfqw1eQec9yXg@mail.gmail.com>
Subject: [BUG] gfs2: task hung in gfs2_glock_wait during umount
To: Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I am reporting a hung task issue triggered by a syzkaller reproducer on
Linux 7.2-rc3.

The reproducer mounts a crafted GFS2 image with syz_mount_image$gfs2.
During cleanup, syz-executor gets stuck in the umount path. The task
remains blocked for more than 142 seconds while doing a path lookup for
umount, and the stack shows that it is waiting in gfs2_glock_wait() via
gfs2_glock_nq() and __gfs2_lookup().

This looks like a potential GFS2 glock state / lookup teardown issue
triggered by a crafted GFS2 image during unmount, rather than a generic
VFS or scheduler problem.

Reproducer:
syz reproducer: https://pastebin.com/raw/V8BAF98m
kernel config: https://pastebin.com/raw/GYQ6Gtrs
console output: https://pastebin.com/raw/4sM18pxc


Kernel:
HEAD commit: 1137d8b5df06137fb49513cc923b3b24d94cb809
git tree: torvalds/linux
kernel version: 7.2.0-rc3 #1 PREEMPT(full) (QEMU Ubuntu 24.10)

Crash log excerpt:

INFO: task syz-executor:10343 blocked for more than 142 seconds.
Not tainted 7.2.0-rc3 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task state stack:23336 pid:10343 tgid:10343 ppid:1 task_flags:0x400140
flags:0x00080002

Call Trace:
<TASK>
__schedule+0x294f/0x8050
schedule+0xd2/0x260
bit_wait+0x15/0xe0
__wait_on_bit+0xc9/0x190
out_of_line_wait_on_bit+0xd7/0x110
gfs2_glock_wait+0xaf/0x240
gfs2_glock_nq+0xadc/0x1ca0
__gfs2_lookup+0x105/0x290
__lookup_slow+0x15f/0x340
lookup_slow+0x51/0x80
path_lookupat.isra.0+0x619/0xbb0
filename_lookup+0x213/0x480
user_path_at+0x40/0x60
ksys_umount+0xb7/0x130
__x64_sys_umount+0x54/0x80
do_syscall_64+0xc4/0x7a0
entry_SYSCALL_64_after_hwframe+0x76/0x7e
</TASK>

Locks held at the time include the directory inode mutex:

1 lock held by syz-executor/10343:
#0: ffff888055af0e00 (&type->i_mutex_dir_key#7){.+.+}-{4:4}, at:
lookup_slow+0x43/0x80

The reproducer uses a crafted GFS2 image and mount options including
lockproto_nolock, errors_withdraw, quota, locktable, and other GFS2
options. The task then hangs while umount performs a lookup and GFS2
tries to acquire or wait for a glock.


Thanks

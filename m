Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9896F3126B9
	for <gfs2@lists.linux.dev>; Sat, 25 Jul 2026 01:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784944650; cv=pass; b=gfaORi2nbV5+ZHberhoUsUG0ctsO+dHIdDvXNz0JgJsZaWdH/9T5NZQ3wBfVxkfL3khrH9ZpIjrwvragd7xbNo8+i6iI0JZRJUfCXuYiecOiqC0OUp1n0x5ByKO7iJHhEOkcJ+jbyBijXaCv8C0bvdt6K5MqwNvtbOeO7hh3R+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784944650; c=relaxed/simple;
	bh=RCAtMFYb+zdnR0GIczH1uZWBYhBwrM2jM9QcgYTdX00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jNQjrIrwGu+0tJIGQrkWXBdcyieWayNl+z47ld6lXqBEcNsy97Bh7ddsX89F6tQeEIEUD729SCaD1kAMTNM5igV05LOyNsa0+660YsH+WHW4OWUefEmgBYmmYD8J2PB9noy3Cp6eV/NoNYg3t5Bv13Ueit/k+pxZkMqYj0kaCkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zv/u4+KN; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zv/u4+KN"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-81062fdeaf5so19433557b3.0
        for <gfs2@lists.linux.dev>; Fri, 24 Jul 2026 18:57:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784944647; cv=none;
        d=google.com; s=arc-20260327;
        b=pvivnF6CN7Hw11712n3BTmf6II/4xCREC3JkA3nRg8IgyzJV3de8mXsSxBPu2Xx8HZ
         biheaDa2rOzepGMlRwT2H+kQcAAyYqI6wRHpkSrwp4ERwBfiskPaI5sNWym568LmR7vg
         bk2HMRuk8xSMieU7tKTyF7FqUp0u1Xq6t6ZJxqu0/of2rv1V/dFJNRTzCvoEgMogkyGo
         39nLe7v5xOEwYj8sBDxfjeqpIr30jb2K85VSQriyZN10m6Ilv6kz90z2a/A44OCsPowO
         csAbR58EREs5bukvz3yJzaToD0P+kyDYFBsYwrZ+y3SNjrf43fNVQK2M2ZStxSQL1mup
         ULGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wzv4Xl6+So60IEFQ6g/nc0NvqiVpLKJxHqR7Aofa0P4=;
        fh=oTPljz1RMd3pwcZpscNAyCZFXsxaH5CbNUCTo11Aifc=;
        b=bOZd3lAG3vXfc7BTMvU9BARV5VIRg1Rlkui1gRgK4RMLQm0hi/zOUBWtfE0cpmKggF
         0dxySLTEWBa/BCky3jWAzeyAl9fMDeqCbSk1XZgo+VJ7L2DbXlYgBKqMgbWk8pMS8zBO
         x99S/lpsxvPI22BEhtKIM8khEtvN6eI59rT7KuozveigTx/H7wT/vWVhLbZmcRaCBDQ2
         YXTtY4fAwIldwrCwvS8kO27fipZv4ip2ssPvdVF0HNK8DwIvmGAaXhtuyNyJ0+JwRcJ8
         gCQOu6+BzhoUu3NGqDK/uCEXAb0vfeTrOud317XJra68EpEzXuSW6m8OyrVUyJdEPQnK
         e+PA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784944647; x=1785549447; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wzv4Xl6+So60IEFQ6g/nc0NvqiVpLKJxHqR7Aofa0P4=;
        b=Zv/u4+KNNF8DAqmWk53nMLdKt9eqXmpFTGe4xLbD/g8ouTXOd5V6EEjaY3mPp7pn/Y
         Fu/bVMhnvMYFG2oRXAF1crVyYmeca7IuXsMJHJqqpHDL4uk4fuQo5PXFp0bk9p2VtV14
         HJGcN3BGvCnbocbGtlQhOP+g4oF/7Y90j+ad5fhY4kpB+arvd9a5z+s2KZQZhniQyxka
         81+uyWNYmILSSy/WN+XfHkb3kVGq4lTvGy4E6KEEVoEhb/j5VMpj1+BPo2X4F5mcefd8
         zEdXmrZuZO+lEpDtN1nmZMIeWhJFgJOo4vDkdZGYe8IO/MQspnsVw3XBO1f3SkzUsOWP
         ipow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784944647; x=1785549447;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wzv4Xl6+So60IEFQ6g/nc0NvqiVpLKJxHqR7Aofa0P4=;
        b=EzE4Ax1LPgAxeX4sCjaiC3JlK5F1YbesNJaFphVfL0JH9CQ9B6uuSLXMdAYDHrKwO8
         HhAWSY7MHI0I+rE5/BW6cwFBtbnrfTFSSiS7cSPEjzD7ZUCWtWkLCPEGoRAAVwIa6wzc
         SQPMdtsZ0ZeQxJEHqr3npv3q9wzQ2DNhI9tY1Ie1iMyUskfpArf2JnLKOX8DUT42vRU6
         uKGkh+kf/O8+vAdTvH9VBI69A09A8hYEDKWYLori8X/JbchYkvVBQpv7RylNhdaVA0pW
         0X/8ucBxUpPyJemcjz6xIcse5mg9ERMGqBxnQzYITGK4rQD9hxLHY8mWmjkcDc26viWX
         C6sg==
X-Gm-Message-State: AOJu0YwqZ0HjVzxcsPbMBeTfoUWKr2pGmb6qtBFYQyAG7IJ2gCYdyq7X
	uHUu6CBD4VB7UEdwA5Gmhjmb2572uvuqHxDBEXjArGaHkN5Bh4eOezLAPFomwOyiYOyBx5qgCJw
	sNwiyR/PqkMwaVAUCVZCPHNexyHadMgg=
X-Gm-Gg: AR+sD10VWMXoj0QnpFwB4hQzxGEDaji4pCWr4x9ykG8qF0mJRF/67lP40j33r0tCHAm
	IdyEGO5EQ0cAH9isCA1WRpKxmq9G7gv1x9+Obm/2bxN2v0cFGMsEbeeHwicthJjaDGqShZpVfJ3
	ujreFaw6b2J5p34+BHpFHJz/Lj+FVC/9/PhTQkI8yLLX0j0d2fUCXfQ5hYrxp/koRYXwBGWWsd+
	wHwgguewjTdAq62TFas78HPzatKVCsNTpaxFICu8GPgnX8zWgPMIV9vTtjZiK8d3CFDKhEr7oPw
	QLJ4uFs/qdj2Xa/mw7yQD0+pGF7wbwfacskYQqziW5L7g5gxJmT4
X-Received: by 2002:a05:690c:3343:b0:81e:c31e:f633 with SMTP id
 00721157ae682-81f6a7e4bc0mr1942987b3.36.1784944647355; Fri, 24 Jul 2026
 18:57:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260630041432.96776-1-kartikey406@gmail.com>
In-Reply-To: <20260630041432.96776-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Sat, 25 Jul 2026 07:27:14 +0530
X-Gm-Features: AUfX_mzbqINSZznBIMBIENvlsc0iP4shJxjLLj0rI_r69Th3gE7oOzTn-y-FMU8
Message-ID: <CADhLXY60Ly=EUQLZos4gwrhC1247xsDCiEBRPoXaZW9U9q4GAg@mail.gmail.com>
Subject: Re: [PATCH] gfs2: fix null-ptr-deref in gfs2_quota_hold during unmount
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+cb79de2cc8b76fbf474f@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 9:44=E2=80=AFAM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
> gfs2_quota_cleanup() frees sd_quota_bitmap early in gfs2_put_super()
> before the iput() calls that can trigger inode eviction. When an unlinked
> inode is evicted during unmount, it goes through:
>
>   gfs2_evict_inode() -> gfs2_dinode_dealloc() -> gfs2_quota_hold()
>     -> qdsb_get() -> slot_get() -> find_first_zero_bit(sd_quota_bitmap)
>
> If sd_quota_bitmap has already been freed by gfs2_quota_cleanup(), this
> results in a null pointer dereference:
>
>   KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>   _find_first_zero_bit+0x29/0xb0 lib/find_bit.c:149
>   slot_get fs/gfs2/quota.c:355
>   qdsb_get+0x133/0x340 fs/gfs2/quota.c:522
>   gfs2_quota_hold+0x191/0x5c0 fs/gfs2/quota.c:606
>   gfs2_dinode_dealloc+0x176/0x3f0 fs/gfs2/inode.c:488
>   gfs2_evict_inode+0x11cd/0x1400 fs/gfs2/super.c:1479
>   gfs2_put_super+0x300/0x860 fs/gfs2/super.c:618
>
> The same problem exists in both paths through gfs2_put_super(): the
> direct gfs2_quota_cleanup() call in the read-only branch, and indirectly
> via gfs2_make_fs_ro() in the read-write branch.
>
> Fix this by removing gfs2_quota_cleanup() from gfs2_make_fs_ro() and
> moving it to after all the iput() calls in gfs2_put_super(), ensuring
> sd_quota_bitmap remains valid for the entire duration of inode eviction.
> Restore an explicit gfs2_quota_cleanup() call in gfs2_reconfigure() after
> gfs2_make_fs_ro() to preserve the remount-ro cleanup behaviour.
>
> Reported-by: syzbot+cb79de2cc8b76fbf474f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dcb79de2cc8b76fbf474f
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  fs/gfs2/ops_fstype.c | 1 +
>  fs/gfs2/super.c      | 5 ++---
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> index 9b9e70f14d25..56bc966531f2 100644
> --- a/fs/gfs2/ops_fstype.c
> +++ b/fs/gfs2/ops_fstype.c
> @@ -1592,6 +1592,7 @@ static int gfs2_reconfigure(struct fs_context *fc)
>         if ((sb->s_flags ^ fc->sb_flags) & SB_RDONLY) {
>                 if (fc->sb_flags & SB_RDONLY) {
>                         gfs2_make_fs_ro(sdp);
> +                       gfs2_quota_cleanup(sdp);
>                 } else {
>                         error =3D gfs2_make_fs_rw(sdp);
>                         if (error)
> diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
> index 4d854556b529..e13c9f9efe6c 100644
> --- a/fs/gfs2/super.c
> +++ b/fs/gfs2/super.c
> @@ -565,7 +565,6 @@ void gfs2_make_fs_ro(struct gfs2_sbd *sdp)
>                                    HZ * 5);
>                 gfs2_assert_warn(sdp, gfs2_log_is_empty(sdp));
>         }
> -       gfs2_quota_cleanup(sdp);
>  }
>
>  /**
> @@ -604,8 +603,6 @@ static void gfs2_put_super(struct super_block *sb)
>         else {
>                 if (gfs2_withdrawn(sdp))
>                         gfs2_destroy_threads(sdp);
> -
> -               gfs2_quota_cleanup(sdp);
>         }
>
>         /*  At this point, we're through modifying the disk  */
> @@ -637,6 +634,8 @@ static void gfs2_put_super(struct super_block *sb)
>         gfs2_glock_dq_uninit(&sdp->sd_live_gh);
>         gfs2_clear_rgrpd(sdp);
>         gfs2_jindex_free(sdp);
> +
> +       gfs2_quota_cleanup(sdp);
>         /*  Take apart glock structures and buffer lists  */
>         gfs2_gl_hash_clear(sdp);
>         iput(sdp->sd_inode);
> --
> 2.43.0
>

Hi  Agruenba,

Gentle reminder. Please let me know the status of this patch

Thanks

Deepanshu

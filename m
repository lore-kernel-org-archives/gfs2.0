Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC6330499A
	for <gfs2@lists.linux.dev>; Fri, 21 Aug 2026 01:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787277055; cv=pass; b=BCOlJvUvNugg7zIHdSE1WBnQUFC+YavAPfH0NtgV5cQxy+EUpMpmA/dHRkZqure3N9lFHdelho0JUhTNMXzRaRgvuJb/f6pXGEG+tSEOdSyb38wJMELVVgbygwZZXphLnCqOiyBrk8Hcvmm5ppQZhHdnKW6r/PgELQlDJ6tpFP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787277055; c=relaxed/simple;
	bh=a+YkI+s6Xqsff4vj0e2b6KLAjbPzXX2t3fa394wBKto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hdbg/NT8kuUd7rrQYVljV9Zqe28n76f97beDcJadK1+AfbcAwIpL1Vdmup7ITRoVwXfWzKzXBRU2riQvKbjBsE+4zz3BfaI/RLUQHS2fiL+dnIWkKPC+veIGdPhdSs5WXcdzYu4JvKBHvJFqta7DlYuj6zKWB9Y9aZl62OVm+aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hImrp13h; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hImrp13h"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66825847b2cso515050d50.3
        for <gfs2@lists.linux.dev>; Thu, 20 Aug 2026 18:50:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787277052; cv=none;
        d=google.com; s=arc-20260327;
        b=a0to4cVjNj85Z0Q4wW9Pn/dyl1LJAJXwIpABPXKfVKcBNyapoa3VCRDKhu3FL1B/hg
         Nc/sqcyrRycLlGThJhoXxEqn3/m51qQbAVX7ETrAf5MT13ab+AvibzRjD3FnE5SCoi0H
         bDkuKHHsK9fk5dD/U25TvSVrY7fR1fZndYsobzvO6oH4N9E+3Daid3eH3wX9aPIar+pp
         cGZHCoVxbi+6adEUrUSd3S/HP23G0Iy9GKIJuWHON73Fz+22lNLpZmtQIpdpV7AA3F7t
         czwCfIHbkDflVmzEZvIt6pRwSE6kWiDHDdIV53Fk93Me/L2mrtWSJf1vUSMn+sGlcnvH
         saMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JYyAB0la8YVaDkquEXQ/IqA9tYN5hHg41s05mynfa6M=;
        fh=oTPljz1RMd3pwcZpscNAyCZFXsxaH5CbNUCTo11Aifc=;
        b=M2/HIdZgzdppr0/HhbWdZXHC5WCeatwDPqJebqvOD1bRSdmcCkrnSguFRvjkNDTFg8
         PjFAVC624WIbncg67WubpsNmtRyIwwFaOn1yYo0Qeta8g9ilkIV+e/E21ut0MyBURCiR
         oNyBecCa7LtzuP2e2dw6PtlAZIFfTnC3vb16ltgdpqjGxIxoOtlp+BVVMjE9NYgMf9nP
         muBZonHet3rtiLirpx4NKAjvxhGSUCCo2GHL8706Tan7IWQwh5w4TcDEsoDpE5jxwOfM
         ZRCJGBPmxSnj/ynueyTQPCftusY4JwUhv4C0sLzu+Ki9ccUNarfS89Yr24smqorztkN2
         j8Hg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787277052; x=1787881852; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JYyAB0la8YVaDkquEXQ/IqA9tYN5hHg41s05mynfa6M=;
        b=hImrp13hXXABCeaoVu+JA8wBjKNaDZ9Z2rZ8jqtX/eH63P2YtFyk5r1TTjcKxafM3B
         SyOFtBSRJnVKsmA6kemwyCtdjRoR+5IH6ciPpju4OM1KsF1bmrx/KyR3hiPQKGNoogYQ
         1EDMS5FpewBzgOZCQoWYRlAXYdGwdMco4xgA+D9l4HNTOv/TR4XOdrkScI7Yq504mwgf
         M5ypWL4vZChKg3S6o+QlvhD57CqUx01fdFlSNqqEVh6iWrTtSmqiTXfgEgLWGFJ24t5w
         copsiyL4qtBBbiEtVrQ0oidsMrhge2k6o7rjhAVjYj+s0E4laEHQ1PNHM/pN2/QmkP5+
         QEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787277052; x=1787881852;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JYyAB0la8YVaDkquEXQ/IqA9tYN5hHg41s05mynfa6M=;
        b=CeXzlVhtcx/KMmoDW/oLQi+i3+MYbJZmiAcV4/ThY3/hN6e0gVhZtwQUXIiX93OABX
         lj9st03rJq31grlaGcg7JnWmdPTrG2DiNqt/CKG0FNWLbRyuV0aGrHO3h82ngokja4VW
         mMQjq0wKeBXAcELWciMyX95iBYvIMx2SULZaNrLL0cjt41JOhCD1EZbRgmgqZubKx2eT
         qds2LEmeVV9tSbYyAwoxdE5KNzapMpJ9X5ZCH0NloKFuKGyE1s28Y253/aeWXZzlyrhF
         JkPykLjf2QaL4QzT1HXcvoIGEN1C/dfogeGAn/VocOHx0nn5+zyVtZ0ZLxhqh5HpV8iH
         Z0bQ==
X-Gm-Message-State: AFuF++k7dvBGNy5hGUYrimN05JjPRpok/oqn3KBEYj1Cv/kdBu1CsacI
	zVt02jQgzlLQlAlRUg6eAZ8GWm/mUSocwuT+8pcBEW04BndT74PoBw7FJ3jB4MAD4AR0KsWYVLU
	ZbXSz832WeiDSMFOszZuKLQh/YLp3sRN1KsxgyzI=
X-Gm-Gg: AR+sD11sTivd4XroJlYBzqXnYCq3eRtW0p702tmZ8c8i+unN0d5PAp0gNCOKaZwbe7V
	iR5QQ1VEPfsjlq2Bk0IwrVVY2TDee15Tag5xwGhe7re5o7iGvrT1RSZQ9YWD6Ygt4rZ56La/D/V
	F68aap7ifUJ6y9jbM1iZq8Be/GWohsA2jaWXrdpslTfaAkVxPE0f0UX+iLSn1VG9iBunayTY9jY
	0ZetzE7FpbThxZKSBbZC/b8S5tkECd4oebWUB41nSgnPHqe2Uj30L+qEnpE3uq3gWAXCOhqlRx+
	ye5tj9T6usoDigSMYQCT3REsUbx1nU/4q8+FQGwMiMLnvtSWX05zfe7qtfIquKC2Mfydqbv6rAn
	sv/7lEBO0xA6YHCzeb0mn4eaN5Z3X4u8ebg==
X-Received: by 2002:a53:dd50:0:b0:664:c535:ee27 with SMTP id
 956f58d0204a3-66ce4b6e650mr973706d50.54.1787277051644; Thu, 20 Aug 2026
 18:50:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260630041432.96776-1-kartikey406@gmail.com>
In-Reply-To: <20260630041432.96776-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Fri, 21 Aug 2026 07:20:39 +0530
X-Gm-Features: AcwNN1Vh36ACpaMqYzcCnRtqjeHpRqyp60IDeWfECQ9bdv8ysOfo7wXNYUYVAa8
Message-ID: <CADhLXY5ae10jP8H4hkgnphSyvdamK2XoKCy5XaMjvQXQLfmpKA@mail.gmail.com>
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

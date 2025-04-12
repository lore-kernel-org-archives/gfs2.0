Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1691E9B28
	for <gfs2@lists.linux.dev>; Sat, 12 Apr 2025 12:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744460680; cv=none; b=CsgD75aVeGkExhz88I1ZEMe91P6t51X2D39xHT0II7LqqZAn2F/UBSXU8og4sIgjla9I7bCeUbvrh//ja5aV7Rua0Xylih9cZ+Uq4YOXhzPqUu48wIIIj3RcLibUXeMS3u9djE7iFmojH6cMsFvkwOQjHuHQudch33GBguyQZdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744460680; c=relaxed/simple;
	bh=NqAv1TV864Xqi+E0ZtzNiKeIgyz7+EmpUkpDdubgk4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQVXOz8C3a9C2JQ5yulCdenUEzCoOoZUoQlg7nwkY6xVtsqEeYm9+DKkExMTBgDkldcfb7Ni6mJueO0IVFH2Ysu1hBC2+DMit8SG/itB0wGf0j5L3Ns8ETD+XUhjIqE3lpEVflylP+Z5aJAAEvl6jTOoluTkNFszZTmmUjKd0HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iA3Wkl9T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iA3Wkl9T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744460677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PstkTZ34lBm2NUVL+KAkFru/gxIEVY1LaGP4oPHMoPo=;
	b=iA3Wkl9TrBRX4ClYV7QHR1D73FJCqOK2Mf+ejvjt05AEJ8JNBe54axo5evlMKqWaJXNoeb
	yfbmqHVBekiAifz1ACg8G0dFyyJbm69oBzy8ZilCfsgH7ywqVEwzOy6liheoubI1ITdwpA
	l75ddqYu91Mre7yQMxuT0koB1+Crflg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-MsIEgJEpM0GOpYG9FA4PUg-1; Sat, 12 Apr 2025 08:24:35 -0400
X-MC-Unique: MsIEgJEpM0GOpYG9FA4PUg-1
X-Mimecast-MFC-AGG-ID: MsIEgJEpM0GOpYG9FA4PUg_1744460675
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-227ed471999so24890385ad.3
        for <gfs2@lists.linux.dev>; Sat, 12 Apr 2025 05:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744460673; x=1745065473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PstkTZ34lBm2NUVL+KAkFru/gxIEVY1LaGP4oPHMoPo=;
        b=wbunO2eyMnMsk8FF4t0XQbunJSLx36QW5Rk6R0rBeHnvOKdWjSl/SXZRqcVumO2C87
         6fuoA2UkBpXw1zM1IsCH0SwS4XFfxZczKImEKlvICpLkqVSaJwg1WuQdaITSxtuGcRgU
         UPEn6rkJIp5gMUheBn6cH11lPbVn+UmjyQZLhxTtgQUKGaUL9AOwXhlSoGXTNJXITjA3
         K1vj/Pn312rrBG5BiF+aE5jtVhdZDMW4Fr6o3/TpD+6XaWPoKwIiGjXr7Vt+KEJfNxqm
         yqWlD73g2UCKxOyPYwhS5aCm1Ij2oW46dSp9O1RCmn6PAOKijsuCHQbQP7pMYx5+NXap
         X4Fg==
X-Forwarded-Encrypted: i=1; AJvYcCViN2q5e2RoIhtdr+NcnRlUcJ6okbgyf+1oQuOg0j4SD3x/eIyJwOg2JXSHtfMb+0dNKmPF@lists.linux.dev
X-Gm-Message-State: AOJu0YwKMPmgpZGio/LPSKdYiFtSSgxe3P3pyzMjNulsRfKmk058Xj9P
	hTxxwXzlVyb7pkR8LcrKfaR1PfJ/kQzTEGJSmSjB3h0AGohEPJQVkIDUeLCblSQRMzpaATRnfvi
	ortCbBcEFJZ1uUDOcvOcCHtgTqjuEOuHiOE6gmtm6Xad2+O30jhHxXh4IjObyEvXXnMOO8U5Sq9
	juuKmnQ5ZwINdtoxxRule5vTDJ4YXngHsVd//e
X-Gm-Gg: ASbGncvj7qneexm6Zvy4ce/w20g8rT6AaXhz/v+w/XePVtmtM7YlVGdPq70GxrK9h9/
	Lp/D6KheAfKqBJ8xvmcr/l6sWxiOZnhvFSObE3EsL6ijr+8HMHXB+AgRTsrysJDkPsPE=
X-Received: by 2002:a17:903:2392:b0:216:410d:4c53 with SMTP id d9443c01a7336-22bea4ef20cmr105041785ad.41.1744460673277;
        Sat, 12 Apr 2025 05:24:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdwLi3is9xzOobpflle8QawgvTBanFLeQKCo4W7mdaerjMfbMARDG/Av3Ou9QEft2fRetb/E6lzOJYKUFnldY=
X-Received: by 2002:a17:903:2392:b0:216:410d:4c53 with SMTP id
 d9443c01a7336-22bea4ef20cmr105041485ad.41.1744460672807; Sat, 12 Apr 2025
 05:24:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <67f8d2b2.050a0220.355867.001c.GAE@google.com> <tencent_C803BAF1BB47330C9E131B254B191B682508@qq.com>
In-Reply-To: <tencent_C803BAF1BB47330C9E131B254B191B682508@qq.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sat, 12 Apr 2025 14:24:21 +0200
X-Gm-Features: ATxdqUHgvWknHJJ78rpWQQ6kr8Tjf-L7N-ZDmzI4ZGsdt54hEMM8c3Sq8QOSQhg
Message-ID: <CAHc6FU6pznS5PfaSavub7y6hxXsSZcP+TrsUKNhw2g4eOEbJKQ@mail.gmail.com>
Subject: Re: [PATCH] gfs2: capture blocksize set failed
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+b0018b7468b2af33b4d5@syzkaller.appspotmail.com, 
	gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0Oejc0Iz_1ZrUDbSk_6yQV1E6JtOkONuOSmmGYhyoSw_1744460675
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 12, 2025 at 7:16=E2=80=AFAM Edward Adam Davis <eadavis@qq.com> =
wrote:
> syzbot reported a oob in gfs2_fill_super. [1]
>
> When setting blocksize fails, the s_blocksize_bits value is incorrect.
>
> [1]
> UBSAN: shift-out-of-bounds in fs/gfs2/ops_fstype.c:1172:19
> shift exponent 4294967287 is too large for 64-bit type 'unsigned long'
> CPU: 1 UID: 0 PID: 6127 Comm: syz.0.42 Not tainted 6.14.0-next-20250404-s=
yzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 02/12/2025
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  ubsan_epilogue lib/ubsan.c:231 [inline]
>  __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:492
>  gfs2_fill_super+0x255e/0x27b0 fs/gfs2/ops_fstype.c:1172
>  get_tree_bdev_flags+0x490/0x5c0 fs/super.c:1636
>  gfs2_get_tree+0x54/0x220 fs/gfs2/ops_fstype.c:1330
>  vfs_get_tree+0x90/0x2b0 fs/super.c:1759
>  do_new_mount+0x2cf/0xb70 fs/namespace.c:3879
>  do_mount fs/namespace.c:4219 [inline]
>  __do_sys_mount fs/namespace.c:4430 [inline]
>  __se_sys_mount+0x38c/0x400 fs/namespace.c:4407
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Reported-by: syzbot+b0018b7468b2af33b4d5@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  fs/gfs2/ops_fstype.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> index e83d293c3614..d5bc25164b89 100644
> --- a/fs/gfs2/ops_fstype.c
> +++ b/fs/gfs2/ops_fstype.c
> @@ -1167,6 +1167,10 @@ static int gfs2_fill_super(struct super_block *sb,=
 struct fs_context *fc)
>         /* Set up the buffer cache and fill in some fake block size value=
s
>            to allow us to read-in the on-disk superblock. */
>         sdp->sd_sb.sb_bsize =3D sb_min_blocksize(sb, 512);
> +       if (!sdp->sd_sb.sb_bsize) {
> +               error =3D -EINVAL;
> +               goto fail_free;
> +       }
>         sdp->sd_sb.sb_bsize_shift =3D sb->s_blocksize_bits;
>         sdp->sd_fsb2bb_shift =3D sdp->sd_sb.sb_bsize_shift - 9;
>         sdp->sd_fsb2bb =3D BIT(sdp->sd_fsb2bb_shift);
> --
> 2.43.0

Thanks for this patch.

I've made a small coding style adjustment, added a check for the
return value of sb_set_blocksize(), and I've changed the description
to:

    gfs2: check sb_min_blocksize return value

    Check the return value of sb_min_blocksize(): it will be 0 when the
    requested block size is invalid.

    In addition, check the return value of sb_set_blocksize() as well.

Andreas


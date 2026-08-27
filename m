Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B353FDC05
	for <gfs2@lists.linux.dev>; Thu, 27 Aug 2026 09:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787821840; cv=none; b=ccSPJSzGqLWbf/dIM7jD+FvoeyznGb97eX2LvflkOPzKiGhOCM7GDc70zj9BJN1Vgf9ZRlJZ2tqKa39iY84ppcYA1hRtjq1GXy0Rc9KwAuifmW6RZTPeN3VTigqrByGKs+8F4zLOJMLLfJvspv9ITXIQe+qJ3+5KL/ETF1L2ix8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787821840; c=relaxed/simple;
	bh=ffk7yhkMn5yWaeiktxqoQY7y03JdGLhOcXTrnlS50cM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZrviIgv8wUhy4Q6EzJFMGC14EISnXaJAHLy0jsW+pWp+A07cpCmb0LZjMC06Y8XUbm9ssLz4br4qjGGBM8xlBMjjVOUbr5sAE0rxsEe0AHLndTlaK8wo31fHmLLMCy+qK06RV4Z28Q/U/cNbq+VDYv984IniQfXYffl4ZERrkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W2rYcG0z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W2rYcG0z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787821837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y2mD1VpOn6zsGqEXcVvc0XCXSBCkdT2KooQ2hM2MFC0=;
	b=W2rYcG0z9vzeOzq5HvsJBlrQ8nEkweJM2s4weKonCqyZX7KlCDRWuWlwnN4ToxmKbhApZs
	HwZnjYxikR8Fg/SUaCgoRBawcwK9ZYCwAbKdBB94N8bllpAhvhzXRN0p+VSAd/BF27IFds
	dgDnkHI1KW4GRX1LdweoshBcSBUldDE=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-sce3IyLRP2mQAafpAAIz1Q-1; Thu, 27 Aug 2026 05:10:36 -0400
X-MC-Unique: sce3IyLRP2mQAafpAAIz1Q-1
X-Mimecast-MFC-AGG-ID: sce3IyLRP2mQAafpAAIz1Q_1787821836
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-845cc1ab48eso17730297b3.0
        for <gfs2@lists.linux.dev>; Thu, 27 Aug 2026 02:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787821836; x=1788426636;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y2mD1VpOn6zsGqEXcVvc0XCXSBCkdT2KooQ2hM2MFC0=;
        b=GZUdfNnNVkQlqXVysne2SyZ5nkS0C50G/S0Q+2g0lTJuATHgBhSN9uWbjgs2bJPa9V
         VaEfMj3eS9gTeh15E+IqVAL3B+I1+BTrwIQ/hzPlUzeVrHjedpsXh+2E9Po0vSuzPiVs
         tJ2NLexOgk/PvCfdYu0pkVolrVCpCbXFp/ZSuSUrPTmqksJNynzNbtmMJ5PV0W0g2v8t
         syFzr98kHVNpXdS0sg9gziaIOvGyqSraaRCQ1qPDu1Ec5KoHeRtx9w4+ZXrCnSL6Epqy
         WGkEBtjC5HfChGn0zah38J+2RrC7pcaSLzYFjAlA049JF9b0lEE5kt/MWidlOQxjmUiG
         PgyA==
X-Gm-Message-State: AFuF++kfIaIy6slWTD/DK19vaoUam/68c9QtN98vW0h8mtprlQtu1YiX
	SFGdXK0UjKK70aUvvse857RMuqSbN6YbNIMeVuO+aUur8fWhYYlLMHcgsN82FTdFiuo2M+edZeZ
	FuVrgVfqeYmBWAflowAMvLbinYVrqw7wsH5Ycec7DkH+G5F3xxSsSgJ2qPN629zXJKs+3D59W//
	vACSvoDO2OYiaQPkAunF/pJ4hpBbtwBA==
X-Gm-Gg: AR+sD13xOU2cRHXXZ31puXgcy49bUb60k+QlZYOryVETTbZeuIOLtb5O5jEYWoIlFCN
	tgwnyjqH+RW0cz8wWKyTKw+o7SjItl+XfvNQVY8/SdSXSTklYLKtxun9rxBdsjEG0Z1p38eifjw
	QYqA7Uvqzh0uEghfhQ4qsXqBza6WyivpFSWGvXiqnOMhOToohXeZawyCObiQ7JQOov4WMSd2pwE
	coPtIDQ39+zhAUdMx7OgHwB4vQFlfVp4LsWagZYQuGX
X-Received: by 2002:a53:d00a:0:b0:66d:207b:a0c3 with SMTP id 956f58d0204a3-66d256f8603mr4641445d50.16.1787821831327;
        Thu, 27 Aug 2026 02:10:31 -0700 (PDT)
X-Received: by 2002:a53:d00a:0:b0:66d:207b:a0c3 with SMTP id
 956f58d0204a3-66d256f8603mr4641433d50.16.1787821830908; Thu, 27 Aug 2026
 02:10:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260804023335.2682101-1-tao1.yu@intel.com>
In-Reply-To: <20260804023335.2682101-1-tao1.yu@intel.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 27 Aug 2026 11:10:19 +0200
X-Gm-Features: AcwNN1XG81zp5CJlHewSW_-zrnsK3_wAdrPX97RAd3puwNxaVd5zvf-xZxXStos
Message-ID: <CAHc6FU7_gUr3wHY-78qcENsH28v2dd_HcpFttkzSqCfj+ORcYA@mail.gmail.com>
Subject: Re: [PATCH] gfs2: mark the VFS superblock read-only before quota cleanup
To: Tao Yu <tao1.yu@intel.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+cb79de2cc8b76fbf474f@syzkaller.appspotmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yWnm9GfFJLEoT7etbD-ihKSu_PhEu2AllNsoxaBS7ew_1787821836
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 4:34=E2=80=AFAM Tao Yu <tao1.yu@intel.com> wrote:
> During unmount, gfs2_put_super() calls gfs2_make_fs_ro(), which shuts
> down quota/statfs activity and then frees the quota bitmap via
> gfs2_quota_cleanup().
>
> However, gfs2_make_fs_ro() did not mark the VFS superblock read-only
> before that cleanup. As a result, later inode eviction could still
> enter the deallocation path through gfs2_evict_inode() ->
> gfs2_dinode_dealloc() -> gfs2_quota_hold() -> slot_get(), even though
> sd_quota_bitmap had already been freed and cleared. That leads to a
> NULL pointer dereference in find_first_zero_bit().
>
> Set SB_RDONLY after the final quota/statfs sync and log shutdown, but
> before gfs2_quota_cleanup(). This keeps subsequent inode eviction from
> re-entering write-side quota/deallocation paths once quota state has
> been torn down.
>
> This fixes a crash reported by syzbot:
>
>   Oops: general protection fault in _find_first_zero_bit
>   KASAN: null-ptr-deref in slot_get()
>
> Reported-by: syzbot+cb79de2cc8b76fbf474f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dcb79de2cc8b76fbf474f
> Signed-off-by: Tao Yu <tao1.yu@intel.com>
> ---
>  fs/gfs2/super.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
> index 4d854556b5299..6b5457f965673 100644
> --- a/fs/gfs2/super.c
> +++ b/fs/gfs2/super.c
> @@ -565,6 +565,14 @@ void gfs2_make_fs_ro(struct gfs2_sbd *sdp)
>                                    HZ * 5);
>                 gfs2_assert_warn(sdp, gfs2_log_is_empty(sdp));
>         }
> +
> +       /*
> +        * Once the final quota/statfs sync and log shutdown are complete=
, the VFS
> +        * must see the filesystem as read-only so later inode eviction c=
annot
> +        * re-enter deallocation paths that still expect live quota state=
.
> +        */
> +       sdp->sd_vfs->s_flags |=3D SB_RDONLY;
> +
>         gfs2_quota_cleanup(sdp);
>  }
>
> --
> 2.34.1
>

Thanks for the patch but no, that's not it. Instead, I've added this:

https://lore.kernel.org/gfs2/20260827090637.676820-1-agruenba@redhat.com

Andreas


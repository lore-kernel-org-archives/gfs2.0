Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A56C36921C
	for <gfs2@lists.linux.dev>; Fri, 30 Jan 2026 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769772829; cv=none; b=tLF9ZiencMtJjzbkOlytBiSWtVPuqBxYY7OjVMiIsp6Ue8KAQFcIGUb43beH+Qn07yfRqJtzI8mbgBq8NzYjZ+0JUWrfp2o/1KGYB4/kd4RZqRyoNYmqidDqSkNI8Z4UFt1+fir0oEgbiVVfBhuMbNgIK21eS2ak7BIDLAeH3gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769772829; c=relaxed/simple;
	bh=0UXqps9z81jxC7Re44x33t6pSTwNIGHFCP3c3RC9YVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=orj353V0NUBcg6cSWnfPWxx+3+72mpQ5hM5RvO0NBIOd49zWbhYqELKDRXKHgVmI6VEmxCcFrdTngLtACrkFcfJr8Xo57fuIbPoqtUYrJi4uyJLBtkXRo7bktl0MT7VwPkY9Wf7Q9xPyU9PXNrn/X2NNZXCLyIEjUk+po6/2w9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HnwgtBFC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HnwgtBFC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769772827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oXB6yOPhNDvjmckqK8HeJAblNhCOGuKVq5Oc4wwowbg=;
	b=HnwgtBFCUAwZSvM+BvMp1AzmBy+h4KUST3hIOcaiZtwyQR2susPmIGU0hn9qCAj4n1SVYC
	Kke/UgstTKzZ88hr7LzvNpyoN5A9BXcFkmGnSuzO7nc3L5G7EHxlWGmp5zFV1PgeLly/3t
	Q2m2jRCQg9F8q3YHHgejKTfh7MeY4SY=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615--u52odZLOve2gJNFThQ0eQ-1; Fri, 30 Jan 2026 06:33:46 -0500
X-MC-Unique: -u52odZLOve2gJNFThQ0eQ-1
X-Mimecast-MFC-AGG-ID: -u52odZLOve2gJNFThQ0eQ_1769772826
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-6455532d07bso2797081d50.3
        for <gfs2@lists.linux.dev>; Fri, 30 Jan 2026 03:33:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769772826; x=1770377626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oXB6yOPhNDvjmckqK8HeJAblNhCOGuKVq5Oc4wwowbg=;
        b=qr/8mfYY37I+TjeHs0m0aW/EYJgf7SpH3xb9I+FfrglZAlME0NhR5O2wtt7/fGqhbq
         LauC2Esg84cc8pWSfxRrfB/2OsMnba8t+KXQTby3ga3HILXZ25BcPcDzBb1Qr5I56nCs
         3zuglzxCdmrML3Nkxjt82Kj8nYDTHbsI8AKn47gvNANO+A+60SkgnVJyTxsu0nxYtfwU
         joSsJnB8L6M0KvSc25BrBlUAIozSk8bGMyBd4y9XWmnPn63TAUWQT5j4LgcU9nE6+d2A
         QOZyr9e/mgig2a+x9H8F/qQE3z4Rbh+yzp/07/CcFNAgDtOZmvE0leIsD98ib3fJAteZ
         W7eg==
X-Gm-Message-State: AOJu0YwjaJg5ey9Y68EeJA2/KmMCmuumUUjdvfFNTVQDtrVl7k/rbrju
	a5tPAfEKmtK2+tr7fNyYkNzCvSsrVIJeEvJTEj114VM8I4YMjrz2EAEP337UgQh17C/sPiTJStN
	1yweW0ZBPjUYdWM5GfN9f2MeSOAkihZTKXvQ0k6l/9k60P+9IOUd6LkYHIMYsW9mFh1yn9aX8xB
	S8yUIsgpc81VvPuPif5OfkMe+WZFXr5Q==
X-Gm-Gg: AZuq6aIlFcr1opIsWCJ8ZNsiS17MeKs511FeMWLss/T5TH/m3LlBQu9/kjQzkf46C6D
	0xmDKstG1cS5vuP8FOVQOpl0rbgHDFJQ2Be2GVtLFYIf7cbC120k/3gd7YHrpF3HL2Lv3llgGM2
	yUYmCXvCOpBPGVw8RfAjDYaeHpkMuXneiDIcBc+CfHSmJr9GAp9Ohrqpir3u4P3rpPw0gqyxJvL
	c3xB+U+iRA8XdHVVY6XVoII7CBZPnAlMsTEfSMoX4+6dVi7Hbk39g==
X-Received: by 2002:a53:d844:0:b0:645:5811:fb30 with SMTP id 956f58d0204a3-649a8437ca0mr1551879d50.11.1769772825726;
        Fri, 30 Jan 2026 03:33:45 -0800 (PST)
X-Received: by 2002:a53:d844:0:b0:645:5811:fb30 with SMTP id
 956f58d0204a3-649a8437ca0mr1551852d50.11.1769772825311; Fri, 30 Jan 2026
 03:33:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260130092134.62407-1-kartikey406@gmail.com>
In-Reply-To: <20260130092134.62407-1-kartikey406@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 30 Jan 2026 12:33:34 +0100
X-Gm-Features: AZwV_QgY-f50CJ_lgrh9DujViOlZmV7nwXmIZ9vwXC_iORooLwzgTuSrhxjjxf8
Message-ID: <CAHc6FU4myfqhqjB=xxVh9JZWi=un4tWYKWRSm0YJZ6DRh3UTZQ@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Fix use-after-free in iomap inline data write path
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+ea1cd4aa4d1e98458a55@syzkaller.appspotmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FaQOxWFi_SynwVJSuibXE2BVVJ50Q-GZi4M_zvMDicc_1769772826
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Deepanshu,

On Fri, Jan 30, 2026 at 10:21=E2=80=AFAM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
> The inline data buffer head (dibh) is being released prematurely in
> gfs2_iomap_begin() via release_metapath(), while iomap->inline_data
> still points to dibh->b_data. This causes a use-after-free when
> iomap_write_end_inline() later attempts to write to the inline data
> area.
>
> The bug sequence:
> 1. gfs2_iomap_begin() calls gfs2_meta_inode_buffer() to read inode
>    metadata into dibh
> 2. Sets iomap->inline_data =3D dibh->b_data + sizeof(struct gfs2_dinode)
> 3. Calls release_metapath() which calls brelse(dibh), dropping refcount
>    to 0
> 4. kswapd reclaims the page (~39ms later in the syzbot report)
> 5. iomap_write_end_inline() tries to memcpy() to iomap->inline_data
> 6. KASAN detects use-after-free write to freed memory
>
> Fix by storing dibh in iomap->private and incrementing its refcount
> with get_bh() in gfs2_iomap_begin(). The buffer is then properly
> released in gfs2_iomap_end() after the inline write completes,
> ensuring the page stays alive for the entire iomap operation.

I agree with this analysis and fix. Some nitpicking below.

> Note: A C reproducer is not available for this issue. The fix is based
> on analysis of the KASAN report and code review showing the buffer head
> is freed before use.
>
> Reported-by: syzbot+ea1cd4aa4d1e98458a55@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dea1cd4aa4d1e98458a55
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  fs/gfs2/bmap.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index 131091520de6..e70095809e4a 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -887,6 +887,8 @@ static int __gfs2_iomap_get(struct inode *inode, loff=
_t pos, loff_t length,
>                               sizeof(struct gfs2_dinode);
>                 iomap->type =3D IOMAP_INLINE;
>                 iomap->inline_data =3D dibh->b_data + sizeof(struct gfs2_=
dinode);
> +               iomap->private =3D dibh;
> +               get_bh(dibh);
>                 goto out;
>         }
>
> @@ -1144,6 +1146,12 @@ static int gfs2_iomap_end(struct inode *inode, lof=
f_t pos, loff_t length,
>         struct gfs2_inode *ip =3D GFS2_I(inode);
>         struct gfs2_sbd *sdp =3D GFS2_SB(inode);
>
> +       /* Release buffer head for inline data */
> +       if (iomap->type =3D=3D IOMAP_INLINE && iomap->private) {
> +               brelse(iomap->private);
> +               iomap->private =3D NULL;
> +       }

We're not using iomap->private for anything else and that field is
zeroed out automatically, so this can be simplified to:

if (iomap->private)
  brelse(iomap->private);

> +
>         switch (flags & (IOMAP_WRITE | IOMAP_ZERO)) {
>         case IOMAP_WRITE:
>                 if (flags & IOMAP_DIRECT)
> --
> 2.43.0
>

Thanks,
Andreas


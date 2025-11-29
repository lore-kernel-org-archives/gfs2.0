Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADBE1DE2AD
	for <gfs2@lists.linux.dev>; Sat, 29 Nov 2025 02:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764384051; cv=none; b=hdSAlgKxq9nv/SYPOq88y+iSKZZ/QdggNUAc8l+2m/8mWsdruARc2hOaVLSm/AoldxoSRdaJt7FfEs3SDQR1fmjrRXOKF04LAMc+95CowbOf9VyR8eUxuumYx4oxc0PhpyGnJGBx+VzJMBb5CiotwRUPnSt9wm93/0KxI1S2svA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764384051; c=relaxed/simple;
	bh=zHvwDf5Xq+iEVnjbasw1OMjmqc8Je/9Bg17U+6o9Pt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djZU61TWAm9p6oZXnkeNsXLz4jdCjI8grxsbBXO0vMcXe8mnoz/SoylJHePgJX4VR5qgg/4CBjquwzSGoDp0ljH+yn3yCA++zqqHVuYm79shJEVcXTDd1UF7/xgrIMH+TrbA9/k9QvKuHR1vgMpS57PaA0tk6l06kBaNm5fpytk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgZL8W47; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgZL8W47"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4edaf8773c4so28165521cf.1
        for <gfs2@lists.linux.dev>; Fri, 28 Nov 2025 18:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764384048; x=1764988848; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAPySlCz6W7rFB53xcBPcWM3i1+fAM460YdX4Fw6oEA=;
        b=EgZL8W47vVSLSqHiH/oSc1B3SJpVh5EGfzOpAQCGTUiMWOO8mCVyksEdon+nLwoQVC
         +2NQaFSgscVtwJJ77K3wTj+54Eee3LLAwpuvLQ0f7c15kQaVwqXs5RyNFCyDXAaNq9RV
         psW511VozzM9bpoKniBxnkuMsSSDsMUXso6Pfe/cLLVM3etjidxQhxHDe2wgsbHdP7v/
         8ZBsXckhSFp+xuo1SvZhezfAZsWn/Eo09b2HOMJJu1zo+VAO+6OKaORNM5EiKwmd1iYJ
         C/NW0QN07fwYrVNQRIkRe28uueUg4fybgeExUEkRXlpHpRjUQ2uPIutCmYurxvJWMdEj
         BYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764384048; x=1764988848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QAPySlCz6W7rFB53xcBPcWM3i1+fAM460YdX4Fw6oEA=;
        b=QZDGudsELxY37hIZxAJhfTmoHdGyxBkZOi38/1Q3wfq+FNiWA3sgg7eE34O/pofVN9
         V1i4+WWqQQ3wcIG9cSbvxylOuvzpjrX7U6MoOAuNHRDgoShZkspQxE0aC7E2HSiRAaFO
         85fmAkstbw28syOFgXLPjQUg41k4DEG22OAUccQVxI82M8jwLkI9O19QWTd6IPC2Sl7F
         oHaehG/dlbOIS+trGV6XPa6TsfoHwuxbHi/ccIA3kKnTGjW/sFhbomcWBMF1ahAKD6J/
         0itE/oc8IbL7iN50qHU4abHnkobQYVIAJHeTZTLlr87FxRIPMTDSxsG9DIwvKMq47Gx4
         osqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeVleITIxqCPJU5Png6BZrcDAAPkYdM1stRKOC3C1ITE9N4ka2AmPzaDKJd8cTCwuVnuXs@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0jgmK/qxdq78Uk+5APbF8lBhSA+kCXopOVQIAxQROxgR3ATKG
	v7Gw8sMPQ76i6GX+8N0N723IvaKJk4WOV1EKCnj7i0iLiawREo8WJvau5SI7ArphK9eiefgc/2/
	vjoHrXLZeohU0kt/WsN8YUV8N5qXYg7Y=
X-Gm-Gg: ASbGncsRqjKKHKpQwQMpwgUz9IQnLqs2Biu0flsQ6Agy/iekS2Jdod3bnr+6uVDo8Mj
	18LLPmxR/Wdhet9V9VMyy8vTIGP8cv2i2yUMdHt9Lo6aC9rvMFs9FnRSbtp1bA3bCWkn9BuiNRv
	JNG9B6gfyCSMzZviHyuyQZu4gtVpA5o8Di3KacH6kTvDv5NGITlZJoFEGGit5DlKpLrDnC768UD
	bWSF8IWhABOAZEqlta25VR5eus57Ocq2eZb2f/SmH5yhRFIimU9mt/3Ik+FVEmz7t00cA==
X-Google-Smtp-Source: AGHT+IEc3jQjTSh2wGwA1eyD2xP/eWtKWxB49pbTJ6uDNzgYaFeaO9lvwOhTEy0qjR7rLP4x3OvjjW+3HSCvva4PQqk=
X-Received: by 2002:ac8:5753:0:b0:4ee:1b36:b5c2 with SMTP id
 d75a77b69052e-4ee58af12d0mr418152811cf.68.1764384048425; Fri, 28 Nov 2025
 18:40:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn> <20251128083219.2332407-7-zhangshida@kylinos.cn>
In-Reply-To: <20251128083219.2332407-7-zhangshida@kylinos.cn>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Sat, 29 Nov 2025 10:40:12 +0800
X-Gm-Features: AWmQ_bkvl1bn1ab0FbiQv1s_-KpnO8A0jbXWmROhOJd-0tcEov6J9fzUaa8ydUI
Message-ID: <CANubcdUtncH7OxYg0+4ax0v9OmbuV337AM5DQHOpsBVa-A1cbA@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] gfs2: Replace the repetitive bio chaining code patterns
To: Johannes.Thumshirn@wdc.com, hch@infradead.org, gruenba@redhat.com, 
	ming.lei@redhat.com, Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, 
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

zhangshida <starzhangzsd@gmail.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=BA=94 16:33=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Shida Zhang <zhangshida@kylinos.cn>
>
> Replace duplicate bio chaining logic with the common
> bio_chain_and_submit helper function.
>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  fs/gfs2/lops.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> index 9c8c305a75c..0073fd7c454 100644
> --- a/fs/gfs2/lops.c
> +++ b/fs/gfs2/lops.c
> @@ -487,8 +487,7 @@ static struct bio *gfs2_chain_bio(struct bio *prev, u=
nsigned int nr_iovecs)
>         new =3D bio_alloc(prev->bi_bdev, nr_iovecs, prev->bi_opf, GFP_NOI=
O);
>         bio_clone_blkg_association(new, prev);
>         new->bi_iter.bi_sector =3D bio_end_sector(prev);
> -       bio_chain(new, prev);
> -       submit_bio(prev);
> +       bio_chain_and_submit(prev, new);

This one should also be dropped because the 'prev' and 'new' are in
the wrong order.

Thanks,
Shida

>         return new;
>  }
>
> --
> 2.34.1
>

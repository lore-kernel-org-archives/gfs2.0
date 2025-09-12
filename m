Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FC131A045
	for <gfs2@lists.linux.dev>; Fri, 12 Sep 2025 16:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757694496; cv=none; b=fGA1uXN9xspO1EK9byENNWwzRQnxpgCzBEbeiKHNA48Jgu6380XdMm4B26TpjfNM9DFuvYdCLXzTXfzWsnqRWxUDXiQ2pzleu3vxtb1oqitJaAsbwhKgrV/wWMC4e5xVDw5tH1tT//27HgKQ31cItg4r1T3Jbdgr/qwFc+67jKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757694496; c=relaxed/simple;
	bh=4ZQds+rLQqXKtrUuxNGp9y/Vi70dhfBppH9lnk7gdCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1cOCLXjtt11IJCy6GWXSvelGtaJ3e28pJDgVw7l5g69LuhoZ0aBW9XYAEO5Fs7RIHG9aSGX+IDc2Gh6iBit3omtjYoyqSkAYL0CvkjI8mWpn595Pbk1nlAMAtlAFiyNnyrjX4yFn/5NJc/KHbfbgun8W9D7wqaWr9JdpGQJTMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaEismS4; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaEismS4"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b5e35453acso26406011cf.2
        for <gfs2@lists.linux.dev>; Fri, 12 Sep 2025 09:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757694494; x=1758299294; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZQds+rLQqXKtrUuxNGp9y/Vi70dhfBppH9lnk7gdCA=;
        b=BaEismS4OYKzvlbcVLP5X8+teUY+Rdi0uMvTGzM51qOss+5RfudVtHHjNj378o8RgQ
         P+Bfi2yUDIC2EdQlyyAoDuefR9InuogzpXqzCsxcsCJP9B7ltGu3YPTibHV/CvSbtDZj
         LhbonjUnai8TiJR69WNBW3e6Tt9nfFR67gSMPVM+uFcBcIUTXBrV6WA4xKom6Rif8k2Q
         R+uHlhXWYoeoi3+0jGkzEnMUlzP6vmsrTlbqDWChZx0vLL3E8gIyNhHiRbDMgOllLggE
         ARTiBbJtvGChZaaQuDFmxiIMk9pd6pZIQo6f91XP4TJAPQs1EZeE5PiLHvZbYBHBt9kt
         2P1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757694494; x=1758299294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZQds+rLQqXKtrUuxNGp9y/Vi70dhfBppH9lnk7gdCA=;
        b=uG7309SnnK0/C8V4/tUmRssG47cnYFkYoXNl9JupdqBm5h4Mms1PVOKx6+F/ugvWRl
         qe53NqPI7ojoWyxrz5AuwOiHwreu97qXkHJvm+MXs8BfvD2SAQWp0fUmB4g3638/Svlr
         9mmBwvCbSQTTDStH9hjVqUbut5jdMQdMADmlw8gf501x0tvq/LN8h++FJOPSOspeYjDu
         +5VOaTLh1wwK3TU9v44mFyEqiGqwC5sEVCrN4PbhE4NHQCPyTa+U+dw4x5/TGLw7Q7Rn
         lC9qX9QScVfvcEODVpo4a65PX08nUkos5frSTGeUE+ZSfL1tkeAHy8dJVDPU8IumU+4E
         mO+g==
X-Forwarded-Encrypted: i=1; AJvYcCWC9lx6VCqizTr7m+RArzGVX9kmXctExRsu7/NV/ONVXXO7ct/eFxuIfHI4jyz/g57UFMDz@lists.linux.dev
X-Gm-Message-State: AOJu0YxM+9Mc/6BIqhbEFEm83Rrr1vKCeQzBwd1deKIjUg9zmm4aKW27
	6do3k18HgR2Tc7gXrs236b01xAsZfZ3FLItedzDhInzqUdMdUpBsQ5gGOiYqnNvw6PDwyonnxmj
	rNncd84rI4cnRm7zIPAm8f7YQWZywWxo=
X-Gm-Gg: ASbGncsB1SwC0JphY/5Bmn7vZenZQiOnLQAgTpE/0Isg2vW0vGWVFlRcaL9aJzabDXI
	IT4B6sO0E+uiwvUOjVP9RYcl+8oxFg61N0FkplJmVTV86LIyNqW5IaoCl+WXb0O1HXrGFcg5cxm
	AVsmurAUimGT10ekHkrsvFGIY1C/lJjBc3+pvZR10H538qw+pO8KoSpd2vv031Q+Yx2CDkWOMWf
	W0rf+KZUVEkWJqup58LFkETJf03IVVErvRzHAWJkjp5WfFNZ2O56h3nbjkp1yI=
X-Google-Smtp-Source: AGHT+IH3sgRSs+dcbMoU7VA9j2cW53LQyv/IZLN7O9xGcrcKIirLDxNle7DY6XecZsiCSB6AFLxXPVP6mp6QV78ZXRU=
X-Received: by 2002:a05:622a:1c09:b0:4b5:b28e:f0ee with SMTP id
 d75a77b69052e-4b77d035872mr40986501cf.51.1757694493815; Fri, 12 Sep 2025
 09:28:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-6-joannelkoong@gmail.com> <aMKuxZq_MK4KWgRc@infradead.org>
In-Reply-To: <aMKuxZq_MK4KWgRc@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 12 Sep 2025 12:28:02 -0400
X-Gm-Features: Ac12FXxFDjN5YQNfv2vrM4ZDEgMv6WgrZBCDj2pFB-Fs02NqF_4tIokmTzA_qak
Message-ID: <CAJnrk1b8+ojpK3Zr18jGkUxEo9SiFw8NgDCO9crg8jDavBS3ag@mail.gmail.com>
Subject: Re: [PATCH v2 05/16] iomap: propagate iomap_read_folio() error to caller
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, djwong@kernel.org, 
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 7:13=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Mon, Sep 08, 2025 at 11:51:11AM -0700, Joanne Koong wrote:
> > Propagate any error encountered in iomap_read_folio() back up to its
> > caller (otherwise a default -EIO will be passed up by
> > filemap_read_folio() to callers). This is standard behavior for how
> > other filesystems handle their ->read_folio() errors as well.
> >
> > Remove the out of date comment about setting the folio error flag.
> > Folio error flags were removed in commit 1f56eedf7ff7 ("iomap:
> > Remove calls to set and clear folio error flag").
>
> As mentioned last time I actually think this is a bad idea, and the most
> common helpers (mpage_read_folio and block_read_full_folio) will not
> return and error here.
>
>

I'll drop this. I interpreted Matthew's comment to mean the error
return isn't useful for ->readahead but is for ->read_folio.

If iomap_read_folio() doesn't do error returns and always just returns
0, then maybe we should just make it `void iomap_read_folio(...)`
instead of `int iomap_read_folio(...)` then.

Thanks,
Joanne

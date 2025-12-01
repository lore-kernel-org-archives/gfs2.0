Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613652F3617
	for <gfs2@lists.linux.dev>; Mon,  1 Dec 2025 10:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764585093; cv=none; b=SW1nTaNplXGzxKw+d/AI0AKMst6IObUGgdY9+PHYp99i3p1A/o1n6CPY4JftQl6lxB3pYeNP/aIbAKDMHWS0tVc9eTa4ttO8I4Ol/WiOc+Su4VM27ntKss1mco7DxTyQCjBB2lF470xIHsxskOFcxAwatz4eCHt4gqr/DM0J184=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764585093; c=relaxed/simple;
	bh=oAKELPmBA2BqrK0o9QFtBWPRSKg+tCcCo1sXueOdRDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ib3Lryb7G5sMwPUbEEhypfyNTWmcoCokg4da2n2NPzvw6kioS2OQNga9Lo8ogiG4nYMkFTcXk1PRZhTw0ZcDbmYBswzVXicuwxlPU+yiuY3i5x+2fugz/OOLoWL7KJB99fPiRH+82PUl5h0cqizyeRTMLzed8+uEyPm5HrLRGH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DKwBQ+kx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKwBQ+kx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764585090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XepCzKXSZv6JjslqxB2za4xngOadSy78tcQeBtMRexk=;
	b=DKwBQ+kxeZbiHRbCMiLmH1/AsEZKyLuCzzWwfc+PkGVIunWLEIWTCTNOTzn3vp+PM2Zf5o
	Fly9NEuBqYiJ/Be4lPNam2lPcT4dQWx6K5eY+sBsBagCCtxYmwAFqTEHehyFY3U1v+YsEo
	tH18tzg0CNwbuq9Rx42aZInd1xWlqa0=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-IuyutmZsO4-zRV0hZp4xfw-1; Mon, 01 Dec 2025 05:31:28 -0500
X-MC-Unique: IuyutmZsO4-zRV0hZp4xfw-1
X-Mimecast-MFC-AGG-ID: IuyutmZsO4-zRV0hZp4xfw_1764585088
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7868061f373so52873787b3.2
        for <gfs2@lists.linux.dev>; Mon, 01 Dec 2025 02:31:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764585088; x=1765189888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XepCzKXSZv6JjslqxB2za4xngOadSy78tcQeBtMRexk=;
        b=j1OQETKtqzp6Ib7kwarVUVuG0ncmc6Ud5DTCQmoxvO2Iv1YJyNTuwhVQO2pa/fNWFJ
         irJxm1zAmz2kX1f3AUVuXJqTNAlfHpnb2qDtisfYzb+pLiW2ZtdGGMlrlOLhT/0tDQrd
         mi0ivjlk6gOSt1aHmUNYfaRLUpS2bdiXBY4dWRQx4DSoj8cXvqgG+vryDNtZ2ZxwPgQK
         0abjqT9dcg8MKw4qOB5GZnoB9Ivvm/88bfI+RBExYIs51DAg9eFIePKaQIfqbvn3eKLs
         zYjcZ7/2SfJHDLRD6sz23axi1g+BDgVf5nL/IcDjjIfycUvaWiQLvYJGVnQh/Qibj6RB
         WvbA==
X-Forwarded-Encrypted: i=1; AJvYcCVBNCeohdF/KQla289olSH5s2BZGdpnSASAGo2LYPl0GPZhndhhOESXdp0QxYbTdTvR28NE@lists.linux.dev
X-Gm-Message-State: AOJu0YwgAhuD9YWr65d9ylr79dJXnexgPtdBr9Ei2Qx+58zEuNapSDoQ
	WxNy9rqtdqa92aWIPrlYpIzMrGmWtIVkvjpWsHQcaleLGXFVFXDIOjTUUcCYThP7D2bd7pgpZd9
	9Q5rx9UthbtKI83n/yFhHdOtfkFhCbwHpxzptevATneFBa3PtffDtwLVOCoJyRq0jUXAIRbmTWm
	9flRETbnczpsis/rSbelmC7vlP9W+tvA==
X-Gm-Gg: ASbGnctTqwWgGtLmVm1U4yLCmNHxqSHm1wk1oXw+XKi81SjLwHTVB1UMtEvaeRVAHWF
	WoZ/VqZEvq3sdM53SpKHCSe28/0KnMPYnCDUJWXzbjS5EcBS0+WNLDm1tyATPxC9HvU0WbJq/7T
	Aez7ZnRyBeDd/S9mbHA9+07fzzZnNhrqDxp940cbI6owxl09xYw/Y5OyBvvl8GLkyL
X-Received: by 2002:a05:690c:6f8e:b0:77f:a301:4634 with SMTP id 00721157ae682-78ab6f19dbemr204012257b3.45.1764585088402;
        Mon, 01 Dec 2025 02:31:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHv5zzmMokroNvK6hxRqePUK2sUy1kyOakdwZXoQ77gSpCZtxQfALMHCo45aGmJsVIK/6txSFE4cjS1pCWEh08=
X-Received: by 2002:a05:690c:6f8e:b0:77f:a301:4634 with SMTP id
 00721157ae682-78ab6f19dbemr204012007b3.45.1764585088053; Mon, 01 Dec 2025
 02:31:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
 <20251128083219.2332407-7-zhangshida@kylinos.cn> <CANubcdUtncH7OxYg0+4ax0v9OmbuV337AM5DQHOpsBVa-A1cbA@mail.gmail.com>
In-Reply-To: <CANubcdUtncH7OxYg0+4ax0v9OmbuV337AM5DQHOpsBVa-A1cbA@mail.gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 1 Dec 2025 11:31:17 +0100
X-Gm-Features: AWmQ_bnf2BodBLtXxgPiuMZc2dFAC9eikQedB20yLRtD3dfyefefH-ZDvfFzYn8
Message-ID: <CAHc6FU5DAhrRKyYjuZ+qF84rCsUDiPo3iPoZ67NvN-pbunJH4A@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] gfs2: Replace the repetitive bio chaining code patterns
To: Stephen Zhang <starzhangzsd@gmail.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, gruenba@redhat.com, 
	ming.lei@redhat.com, Gao Xiang <hsiangkao@linux.alibaba.com>, 
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, 
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhangshida@kylinos.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: L1drvWd8Ryk2DPBfrbyIT9S6TysKypirAprbKAg1ejc_1764585088
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2025 at 3:48=E2=80=AFAM Stephen Zhang <starzhangzsd@gmail.c=
om> wrote:
> zhangshida <starzhangzsd@gmail.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=8828=
=E6=97=A5=E5=91=A8=E4=BA=94 16:33=E5=86=99=E9=81=93=EF=BC=9A
> >
> > From: Shida Zhang <zhangshida@kylinos.cn>
> >
> > Replace duplicate bio chaining logic with the common
> > bio_chain_and_submit helper function.
> >
> > Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> > ---
> >  fs/gfs2/lops.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> > index 9c8c305a75c..0073fd7c454 100644
> > --- a/fs/gfs2/lops.c
> > +++ b/fs/gfs2/lops.c
> > @@ -487,8 +487,7 @@ static struct bio *gfs2_chain_bio(struct bio *prev,=
 unsigned int nr_iovecs)
> >         new =3D bio_alloc(prev->bi_bdev, nr_iovecs, prev->bi_opf, GFP_N=
OIO);
> >         bio_clone_blkg_association(new, prev);
> >         new->bi_iter.bi_sector =3D bio_end_sector(prev);
> > -       bio_chain(new, prev);
> > -       submit_bio(prev);
> > +       bio_chain_and_submit(prev, new);
>
> This one should also be dropped because the 'prev' and 'new' are in
> the wrong order.

Ouch. Thanks for pointing this out.

> Thanks,
> Shida
>
> >         return new;
> >  }
> >
> > --
> > 2.34.1
> >
>

Andreas


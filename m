Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A00418DB0D
	for <gfs2@lists.linux.dev>; Sat, 29 Nov 2025 01:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764381050; cv=none; b=SziQWofB8Y4Qpnadx5FDMqSYNvcHv1tmXCoCpRqN4D57W/yWJ1tzznAEkCf8joP71m6rj8rzWo0KYXSlBqGlI1sfuU1S6NDyA4xxNuZs9fLLh49OUh2gAVoKmg9IKXHxqtpWRILzXqzsQ4dN1G8G4bUIfCkdsaiz82D1By5stYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764381050; c=relaxed/simple;
	bh=NaSVgYTQZj//T0kXBeK5L/YqRjV2JfM4MD+L1BQ61uA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YCRgZ2xJGIbbJrXucF6cOWQKZ//kAkKB0b7TdRDDhWOcYI8dwhHiPu+O23LD4/b7jFPVJx84wF4seefeL8UBhomV9VbObmepxEkAqt6GHOHFYdxsgRz2BBdBZ0108Fvo2GY8EOyI2G4TZwAczVfwnnYI4KkBX7EtoRzW9IcUzjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMJjDDjJ; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMJjDDjJ"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ee14ba3d9cso21932791cf.1
        for <gfs2@lists.linux.dev>; Fri, 28 Nov 2025 17:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764381046; x=1764985846; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXq5BoozcLEtMZPipx/4wTBGFkZq8n4VHxCYYlUf+vY=;
        b=bMJjDDjJ5rnwUmxelqZQIsONtcAwIKG6APHeeO61XbtDsG6TlKBNvwaHuBvhz7/EqS
         B3Q8qr9FSt+OU44Sl7oZmtxEjAvXhA4KkPvlOFmLYu0O8eRxeCZHLwFvTEsHXEnK2UQu
         PLSwoF3RDnlLNrP2J8z09ogBbL+ol9rvfGhCXgTynX9T3PTpejT4LAuOKVnh4XWDkGLg
         Srt88epe3I7kaf+o/pKTLpKmqZDEssMKGSGiWM+75OJXRxGKDjyeWAYD06TIkNOIKSLQ
         nC1F1uDxClmM2Q0srn2dyDH57a8MdBOtgpJYZzhyW/AmPkmoaJxOZnxuIIkeiBPIWbQ2
         Q+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764381046; x=1764985846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xXq5BoozcLEtMZPipx/4wTBGFkZq8n4VHxCYYlUf+vY=;
        b=XXJdQAGj0zQ3L+H9A6W8vNn6VVq7Tqpl2tnxYe/GLVKSISzaJ3NI0yNZ1tpf7BRAc/
         i8S8mHk2LIYzUMt2tRdqzWEKQyFu8J4iliXWCVpM4VP7kjbmekVrAtIb2P0Y+jpxRXRf
         fFBlg+A/UIgs4b29hBRInWQ/ImnpJnRIG1iyT2TbIcxflFQttdrBXj1S3++cNpRcPR+j
         1gFDGLxsLSnxCLXk223J283zBbaAobiGghmtXhXs/H+r8n++/mNIO0yg/mmLqnK1uLrV
         Yjrqm3qiTtWdKgCcwEWtppWXT6LVeMr7qDMytkzcC6S63f8WNIlbnYNxGB4h4UxGVLXY
         yqCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoTYL7/JC4PLfxr//KoKBcRVy1ybbxn5KAuaKJ/XLluKMufjW+quEkBjS14iXl5dwq/B8I@lists.linux.dev
X-Gm-Message-State: AOJu0YzZc/gIBdAdmFVPhabsxc/tqeTN2nKW0B0nFFG0C2h9l4CtQKye
	x0oNnWpSOOUmo6whK+chUJMY8gXs2HAji6rF2xkvYipWM8r4QlvWiGAe/7Qz372zsbaQWsTE3Rk
	kzIdZ4+TALyHXJBQdwFoW/SezJihX68E=
X-Gm-Gg: ASbGncsmjN6n5a8sE0isnahz4/pFrFd+Tj+zXM2iwsniDTKWOEjPLpdIF8vcf+blN4m
	zR0FHwsTXz+T4MTvJ8Cx8EDCkGP7HrVD7o37XyRDxKzKbSTRjRM02iY+IGmez20zcB4YCbORtUR
	Vb4s0tJdVP0Ab8HPmU/Opk5h2RZCabFcjkM7+VmgO3iMnMrrrOMmzt0t542XPOY4B7fSl1SOh+i
	jHShK2CS4MO3WzFAbTwk0xFm/K4XSSZQznTQmQggousA826VmCj+I2ITZpoYnUK1wC6+mqVtf7U
	PG6f
X-Google-Smtp-Source: AGHT+IE+Tw+9Y5Bub3lN6sC4Pj0OtdTK9knmaYL6GikYTYtgwTjW4uUHcZO2kGFVdLFpIVKdsMHQoOJ3Bk1wdK27dic=
X-Received: by 2002:a05:622a:1909:b0:4ee:2942:c4fb with SMTP id
 d75a77b69052e-4ee5882d9d4mr417978631cf.31.1764381046350; Fri, 28 Nov 2025
 17:50:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
 <20251128083219.2332407-5-zhangshida@kylinos.cn> <CAHc6FU6dmK1udCgj9vMj1ew-4+bZOK7BA47kyEgONEwGg42veg@mail.gmail.com>
In-Reply-To: <CAHc6FU6dmK1udCgj9vMj1ew-4+bZOK7BA47kyEgONEwGg42veg@mail.gmail.com>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Sat, 29 Nov 2025 09:50:10 +0800
X-Gm-Features: AWmQ_bmFiM-2nj0DOVO633rnw-D1LMnVAvls5FZ2mk8-RJDyk4i3to2si2g7WjI
Message-ID: <CANubcdW7FxbtSRzePgO4wQwUFBpgbSYdL-GR87vUXKq7tAPsJg@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] block: prohibit calls to bio_chain_endio
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, gruenba@redhat.com, 
	ming.lei@redhat.com, linux-block@vger.kernel.org, 
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn, 
	Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andreas Gruenbacher <agruenba@redhat.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=88=
28=E6=97=A5=E5=91=A8=E4=BA=94 20:58=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Nov 28, 2025 at 9:33=E2=80=AFAM zhangshida <starzhangzsd@gmail.co=
m> wrote:
> > From: Shida Zhang <zhangshida@kylinos.cn>
> >
> > Now that all potential callers of bio_chain_endio have been
> > eliminated, completely prohibit any future calls to this function.
> >
> > Suggested-by: Ming Lei <ming.lei@redhat.com>
> > Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> > ---
> >  block/bio.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/block/bio.c b/block/bio.c
> > index aa43435c15f..2473a2c0d2f 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -323,8 +323,13 @@ static struct bio *__bio_chain_endio(struct bio *b=
io)
> >         return parent;
> >  }
> >
> > +/**
> > + * This function should only be used as a flag and must never be calle=
d.
> > + * If execution reaches here, it indicates a serious programming error=
.
> > + */
> >  static void bio_chain_endio(struct bio *bio)
> >  {
> > +       BUG_ON(1);
>
> The below call is dead code and should be removed. With that, nothing
> remains of the first patch in this queue ("block: fix incorrect logic
> in bio_chain_endio") and that patch can be dropped.

Yeah, that makes it much clearer. I will do that.

Thanks,
Shida

>
> >         bio_endio(bio);
> >  }
> >
> > --
> > 2.34.1
> >
>
> Thanks,
> Andreas
>

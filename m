Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126912701D9
	for <gfs2@lists.linux.dev>; Wed, 25 Mar 2026 01:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774402982; cv=none; b=CLXsM4HRGkdONADhKuUoORqzpNI8HDY3+hgKlZPo5gcIH7QBcIZYJ9zpyyzsL4tWQedSJReUgc3biHdcwivfoj/xBQf+V0xP35gTCpgS3k0nE8wzoy/JjStZKgFegYup22n/83jFax/LjfydbhchuRRKD7oB2gyPivAwNfAa0L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774402982; c=relaxed/simple;
	bh=Ymcto7jkPsCuZ1uk4wYwv0WAb19BuA3OR79XlMTuZBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=As/6UCje4iJu8jkTf9KwxzRLZZZWxoYBBqEpNodTIh9SHDEXok+oe0JuIECzHKDZFN/VCYyjWW3iCRVbYnNK/rmYgBNyf6uyzUslSR8K5TKKfo7aAsBcTlIK0I6G0hfnNinImtnLBl+GScVJo62dNTCauHqScicxzJpOgm8kBXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d2iRy3pn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2iRy3pn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774402980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U4zrNcwIO3v7o+IE2/d9EKuL/OIMoxS4plumd+68W+Q=;
	b=d2iRy3pnkgqsvELJf9smAKHCLTPQoVNvuQTTYF2KNGD8Fx+Swi9iMCiRoNysT+YOlvYccG
	upQ5tgr/A51muu8A6DrVtRw99P4Bqxl/6DpFCx+wDmC6yyIfPOZSIR6q2y55oYX+ATyjbp
	xYvPVYpetPdBrlaJ+0wIXaVDjQoV7/I=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-_GiTCyU7NiqJdzgtovzMWw-1; Tue, 24 Mar 2026 21:42:56 -0400
X-MC-Unique: _GiTCyU7NiqJdzgtovzMWw-1
X-Mimecast-MFC-AGG-ID: _GiTCyU7NiqJdzgtovzMWw_1774402976
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-64ad0c50067so9406971d50.1
        for <gfs2@lists.linux.dev>; Tue, 24 Mar 2026 18:42:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774402976; x=1775007776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U4zrNcwIO3v7o+IE2/d9EKuL/OIMoxS4plumd+68W+Q=;
        b=sPwlWu50t5eibhiUMp5srkYmDu4paL4qcaPo9whDz1jTbFT8NUebkxuMdoma7kBj8M
         re2zujQWuN6Ux7glVDt+gwJoW4/TNgFfKhXpCS+SCnPOcPfPiuAKY4Ic/v01o1592B5y
         bbgIn6wdq8OwnHXRDa/Y4E0v2M7+H7+/J/koj4F20n/ALUh6yrhxHYE5M+Bk4sVVDYBB
         caLh6OsizX0arHPEZYb9iCXGdhkolWwN62MkNbdSDkh/ENctkZvXfCb9UdgVC8sBlfRY
         9THSfCOq+50UGWwkUNlHsmnkC/p76Goa11ydZ+rlNOMZxkn8ya9mZr18ZCCHvrV07g93
         rM9w==
X-Forwarded-Encrypted: i=1; AJvYcCUjToe/msyaTYlX+5VvJMb61WVtUmX0SeArbQOcbVfnrsTUUXh/EqW5THz1MXApE55uUS89@lists.linux.dev
X-Gm-Message-State: AOJu0Yxeq2fuMAKcnFazCLP4WYxga/c1YrVvRnqmRm8FrFKBM7PP8Fxo
	Bm79TMb+2coBMu42jEuEoe6GUP+ROmhyJPeEkx0RxPj/YmJCXdz3Z9Gtuwk/Y8SIEyWp71mmN4J
	p/nRvkoGzw8oqFEjPtZDavxoRI1EwURkOqOSrDDoZ6kXvIZoN9FncYsOdasIEgQQ+ujt/cxjhqA
	nvtLLshNXNwfq3kv3Syb9uVA7AJKrHFw==
X-Gm-Gg: ATEYQzxjJe39HS6/CBJOpO4NVU5vpky060J4FF6xaGEHAEN+5tJ+bhFm+hRy3ArzEbY
	2PBkdm19NAdtYRjkCaxt44V2Q9VecV4lxzwOuGlZKyaKA7df6iQoHmNpxgzBCb76wxj01KwH6mM
	41RYIuzSn4AiIu1JR9C1Go7aOKZ5PAC9ia+5Co0Y5x25dvsklCVM69qvlgSFsl5mRQ3rsgmItZU
	hudvclfsOA3UCvJF1NpkmHZe7J8p17+J8xRVkmbfil/PAyaWqqh73bcfgjqSgrwzw==
X-Received: by 2002:a53:d98e:0:b0:641:f5bc:68de with SMTP id 956f58d0204a3-64ee617c723mr1486596d50.75.1774402976082;
        Tue, 24 Mar 2026 18:42:56 -0700 (PDT)
X-Received: by 2002:a53:d98e:0:b0:641:f5bc:68de with SMTP id
 956f58d0204a3-64ee617c723mr1486580d50.75.1774402975582; Tue, 24 Mar 2026
 18:42:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260324033959.1456418-1-kartikey406@gmail.com>
 <acKjtaMVQS_d0Esi@casper.infradead.org> <CADhLXY5fxo_fOUTZv_DoHn3FJr6dFkKhRopzCLQYCKEjat71Zw@mail.gmail.com>
In-Reply-To: <CADhLXY5fxo_fOUTZv_DoHn3FJr6dFkKhRopzCLQYCKEjat71Zw@mail.gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 25 Mar 2026 02:42:44 +0100
X-Gm-Features: AaiRm53HvpzIMET9rRQxGP0m95d49ZSvhDU7AU5YLrKsUkwyQ67ZkQvvekJsUqk
Message-ID: <CAHc6FU5YouqqiyPgPsNshw50NCEiptzf=yePwEujGKu8NtHA7Q@mail.gmail.com>
Subject: Re: [PATCH] gfs2: fix hung task in gfs2_jhead_process_page
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+9013411dc43f3582823a@syzkaller.appspotmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1wsqOYHOSrUJCOiLfemUu9jYYH9cl7sUWRPheTTQJ-A_1774402976
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 1:07=E2=80=AFAM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
> On Tue, Mar 24, 2026 at 8:16=E2=80=AFPM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >
> > I have my doubts that this is the right fix.  If you look at the entire
> > function, it assumes that the folio was already created and added to
> > the page cache.  The error should surely be detected earlier, not by
> > this function.
> >
>
> Hi Mathew,
>
> Thank you for the review. After further analysis, we found that the
> bug is triggered by a malicious/corrupted GFS2 filesystem image
> whose journal extent list contains extents with gaps between them:
>
>   extent 1: lblock=3D0,   dblock=3D1000, blocks=3D2
>   extent 2: lblock=3D100, dblock=3D2000, blocks=3D2

How about something like this?

--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -2210,7 +2210,7 @@ void gfs2_free_journal_extents(struct gfs2_jdesc *jd)
  * @dblock: The physical block at start of new extent
  * @blocks: Size of extent in fs blocks
  *
- * Returns: 0 on success or -ENOMEM
+ * Returns: 0 on success, or an error code
  */

 static int gfs2_add_jextent(struct gfs2_jdesc *jd, u64 lblock, u64
dblock, u64 blocks)
@@ -2219,6 +2219,8 @@ static int gfs2_add_jextent(struct gfs2_jdesc
*jd, u64 lblock, u64 dblock, u64 b

     if (!list_empty(&jd->extent_list)) {
         jext =3D list_last_entry(&jd->extent_list, struct
gfs2_journal_extent, list);
+        if (jext->lblock + jext->blocks !=3D lblock)
+            return -EINVAL;
         if ((jext->dblock + jext->blocks) =3D=3D dblock) {
             jext->blocks +=3D blocks;
             return 0;

Thanks,
Andreas


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151D91AED4E
	for <gfs2@lists.linux.dev>; Thu, 20 Jun 2024 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718894764; cv=none; b=SlS4A4GQApjNPtRgBrjXI64SXWIF26J6yTlelD3a5E8v+1jo8RseiA5chndC86ENXeqjBwExnLgrppjb5OV03es9JSwUwXwxe/3tcdxBQhCcyPou6sBQpgMV/xS7jodzINSs6dvJudLQkG2nDMvtVHHX+cgGWu1rYl7D7teuPLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718894764; c=relaxed/simple;
	bh=rJNoDvUaNOSxsFP7J7yPeo0Kb4QNp9frk4vxsBiu2+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l3nWSEaCafNiYarC/UT9YLES19RWIuLSy5MNXwtgWSR9w70mCHwVcvgBXUKje03FEpMQT2kYhVvI33nxtmrh0Ca6NUL1m9Vqxt5FhAvrsBq6sNt5tmBjJs/1UGbCEmntT4vOnBX34UelXOIN5yqpH2ICQVWrzP+J+ZDVGU6J3lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aGQRsxXx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aGQRsxXx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718894762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NOyPbK7ga5DA65OixqRfLSJsSdBFQ6DtyLNoN6hbCSw=;
	b=aGQRsxXxYChWQsAPjFCmu2+aBSFhofmIaSftYctLvASwBG4a2frdknU91TjkJG7v+/GEsS
	SJ5VAhSOuIiGv+pweV3MgOIjbnCQqGllNzb8n/AMfdtGb5Q5uoylVzIYiCLKLQfxj8oVJd
	/G+AU5+dtjiU8uDoAiEUBUUGN6Yy1rs=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-RJSpwyneO8KogpkkH8dmFg-1; Thu, 20 Jun 2024 10:45:57 -0400
X-MC-Unique: RJSpwyneO8KogpkkH8dmFg-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1f68c07cbbeso9741965ad.3
        for <gfs2@lists.linux.dev>; Thu, 20 Jun 2024 07:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718894756; x=1719499556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOyPbK7ga5DA65OixqRfLSJsSdBFQ6DtyLNoN6hbCSw=;
        b=IG0/eASlhZhyu/rHt1o+hsqjMuOLnIqr4GHlTKE/i20v2UHNHYVpqbRtPJ7n1A+NPf
         NzlBkEHuGb1wBi7QecWyKky3CajJzjfj39hMV4wLMNyfxU+aKG/NHbVJeJtnQZcHs67C
         6E3NfjTM348IFpk0mKv/zrhZxz59inj6O1oWev5Sl0mIfZHvqAF52PKqsd30/Y9ntkSU
         LlBgJ/XnOE/FDyOXGJDakukX2p0ZiEbeXBNT4ts5Dwd83UW2far8aw40HVXSYgpvrPGu
         AGRF3N9C4Fpir4sQjLN7lgGHAvXkJaugAWfVY/4tUKQVYYivIRvUXcp8ISm5DQPQxbZB
         VPEQ==
X-Gm-Message-State: AOJu0YydEeQr4qvq2JUPOdM5/833MOAUuCN9wTQpO/5bDhpYOo/ufoSj
	oqPgm4xSM2W4SpYMfKmZfgiukM9TWbPI8J467nsFihg8vQV//hUD2Arpgdf2vjjzhaU9XcQwZac
	IkXjUYOvp++IYaJJ7SF7pNcO2yU3x1YL3kK+5sKNruQAIqKoKuxz/PcssjIvO3H8gnbonc9T+Q4
	k+126nXx02FU42io1NCSyjyi0jPg==
X-Received: by 2002:a17:903:1cf:b0:1f9:9a87:76f5 with SMTP id d9443c01a7336-1f9aa42d459mr66127945ad.27.1718894756476;
        Thu, 20 Jun 2024 07:45:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVPznqVHXRaTdmrOcWBN++woZDfmioTaGS8jiKKyzS/e7hw9Z1Y3zMTINL1846Y9FOWPmHqGu4yK+pu9Kd1AQ=
X-Received: by 2002:a17:903:1cf:b0:1f9:9a87:76f5 with SMTP id
 d9443c01a7336-1f9aa42d459mr66127695ad.27.1718894756116; Thu, 20 Jun 2024
 07:45:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240618160517.901589-1-agruenba@redhat.com> <20240618160517.901589-12-agruenba@redhat.com>
 <CAK-6q+i4YsSPX5i3zAUK5PX1XZ4JY_U=hhx-8N8mEeoOiRKw5g@mail.gmail.com>
In-Reply-To: <CAK-6q+i4YsSPX5i3zAUK5PX1XZ4JY_U=hhx-8N8mEeoOiRKw5g@mail.gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 20 Jun 2024 16:45:44 +0200
Message-ID: <CAHc6FU4uYipHx6frNK2uCRuWjouKsTbr_6N=cJ52PPa+A3i-wg@mail.gmail.com>
Subject: Re: [PATCH 11/13] gfs2: Get rid of some unnecessary quota locking
To: Alexander Aring <aahringo@redhat.com>
Cc: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 4:24=E2=80=AFPM Alexander Aring <aahringo@redhat.co=
m> wrote:
> Hi,
>
> On Tue, Jun 18, 2024 at 12:13=E2=80=AFPM Andreas Gruenbacher
> <agruenba@redhat.com> wrote:
> >
> > With the locking the previous patch has introduced for each struct
> > gfs2_quota_data object, sd_quota_mutex has become largely irrelevant.
> > By waiting on the buffer head instead of waiting on the mutex in
> > get_bh(), it becomes completely irrelevant and can be removed.
> >
> ...
> >         error =3D -EIO;
> >         if (gfs2_metatype_check(sdp, bh, GFS2_METATYPE_QC))
> > -               goto fail_brelse;
> > -
> > -       qd->qd_bh =3D bh;
> > -       qd->qd_bh_qc =3D (struct gfs2_quota_change *)
> > -               (bh->b_data + sizeof(struct gfs2_meta_header) +
> > -                offset * sizeof(struct gfs2_quota_change));
> > -
> > -       mutex_unlock(&sdp->sd_quota_mutex);
> > +               goto out;
> >
> > -       return 0;
> > +       spin_lock(&qd->qd_lockref.lock);
> > +       if (qd->qd_bh =3D=3D NULL) {
> > +               qd->qd_bh =3D bh;
> > +               qd->qd_bh_qc =3D (struct gfs2_quota_change *)
> > +                       (bh->b_data + sizeof(struct gfs2_meta_header) +
> > +                        offset * sizeof(struct gfs2_quota_change));
> > +               bh =3D NULL;
>
> here you set bh to NULL.
>
> > +       }
> > +       qd->qd_bh_count++;
> > +       spin_unlock(&qd->qd_lockref.lock);
> > +       error =3D 0;
> >
> > -fail_brelse:
> > +out:
> >         brelse(bh);
>
> It might be called with bh =3D=3D NULL?

Yes, brelse() can handle that.

> > -fail:
> > -       qd->qd_bh_count--;
> > -       mutex_unlock(&sdp->sd_quota_mutex);
> >         return error;
> >  }
> >
> >  static void bh_put(struct gfs2_quota_data *qd)
> >  {
> >         struct gfs2_sbd *sdp =3D qd->qd_sbd;
> > +       struct buffer_head *bh =3D NULL;
> >
> > -       mutex_lock(&sdp->sd_quota_mutex);
> > +       spin_lock(&qd->qd_lockref.lock);
> >         gfs2_assert(sdp, qd->qd_bh_count);
> >         if (!--qd->qd_bh_count) {
> > -               brelse(qd->qd_bh);
> > +               bh =3D qd->qd_bh;
> >                 qd->qd_bh =3D NULL;
> >                 qd->qd_bh_qc =3D NULL;
> >         }
> > -       mutex_unlock(&sdp->sd_quota_mutex);
> > +       spin_unlock(&qd->qd_lockref.lock);
> > +
> > +       if (bh)
> > +               brelse(bh);
>
> Here you care about that bh is !=3D NULL.
>
> is breise() now NULL proofed?

Yes, always has been. I'll remove that unnecessary NULL check.

Thanks,
Andreas


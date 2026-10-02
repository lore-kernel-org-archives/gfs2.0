Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB6954781
	for <gfs2@lists.linux.dev>; Fri,  2 Oct 2026 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950043; cv=none; b=f4txobB/i7hge3IoFsyqk0J7rdHRDedpdTBpVK+ISxpgjpq69/LFZ0VfYwdreKuLbiC+MJtg15be0V5LyeRnIyXiQ4oY++g/1pywYHy6q1gBI6EdrQ4QdtcSEvsPorexi+MgbEp6vdO/Tc+AEkHwWJVBJKL67xrAahYzWlwKHRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950043; c=relaxed/simple;
	bh=yfDvPO4H/mIRlRzgF1ehHxShRFO4ABWe5fq0yL3+cMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=njCnhvYHx+1+sniQ1k5RR7TD1bWp3oRMolouHlXfVha47O3NgTITViI3r9We/SDFC5pdVAOWbWrGAmSKSrImztN+4z3Uml/Gj4we+0SCN1bWWWWbWgmUKalTbAxmzkuOLpdEF3o2vXnxkAwB3D2UjlSa7M9KIS5rgP/1Zz+xwDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dKFCknPv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dKFCknPv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790950041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XDp0RcD7HYWUzlsOLtsxZUXX4GvVdXcns7B6N4dcr9I=;
	b=dKFCknPv6Q8JGuaI8BqTjxde4bPOprVbssP+IKbXoofZmstTDIG6an3UFPSKJPImx5QOom
	BGrEgG05lbszbUR5tfiatLM1KtPDRjSAHcc95DGQWhgrxhHA+6fatLCvmSMBIU7uL1KQY7
	dtvB+IBPt3ZHq2ycrQPj7bsvK0x8Vv0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-YCTIQADjOIipsY9_PJBVLQ-1; Fri, 02 Oct 2026 10:07:15 -0400
X-MC-Unique: YCTIQADjOIipsY9_PJBVLQ-1
X-Mimecast-MFC-AGG-ID: YCTIQADjOIipsY9_PJBVLQ_1790950034
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-3a77e9a0402so486591fa.0
        for <gfs2@lists.linux.dev>; Fri, 02 Oct 2026 07:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790950034; x=1791554834;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XDp0RcD7HYWUzlsOLtsxZUXX4GvVdXcns7B6N4dcr9I=;
        b=1YgKVCsXL4vsAR0mz/6IMvMdJ1WsrjOt62Nyyj6IS5TLXiBANkbpzk4wkFTvW5K9S2
         4fsdvTHuArq+wa+Yn/LN2KV49X1zXNjW8twJTnKchX4r88KH998dFhLrPP30layKGeTK
         px0x67dtp1wHOhUY7L+XLY7mO+2BQIbXrc9yB0eF89Mv9bWisXOgGgyAtsS6bGIFQj4c
         72rzwwzjPOnxsR60W7Zps8wz2EmOB8X8mlTeEsBwdxfnJlYU40y5qiBwiTSjbHt71+ib
         49f50rKH2ETHtC5RhG7BOnx4GmyGEhQI5hbHYb97U4eEZo9MYzJ2RK8BWerf0ACA4xvu
         9EAQ==
X-Forwarded-Encrypted: i=1; AKwUvByaA1+fOxkcM6qchj7vfgwm3UBVzjKunwTrC+U1vU2JP551WwZlD6prnAtQxoW+Q/iZocZc@lists.linux.dev
X-Gm-Message-State: AFq9FYJhvtS8ZLJ0DkM53oT4i9mWePhfvT04JcN36hFduXNF2cAQq0us
	admc2tAHw45EV9MX512hZEFwZEB3Sc0siU7jTu96LpCYtTinp0utHfUVCiVABfaNlxrM6UZyidr
	eyyx5S+vzf0sgyueySck8VCrcNPVKsaZWP8XyEh+FCP0Qhtpw2HakZm4BINoloZpCRKhOBzxbB4
	FdwtAI579M8XgVq5rkPqrpW4TYiOV0oA==
X-Gm-Gg: AYBFou0FfsxcaETzD5tbyLqFgkBO5afw9NN94XeMa8rhtaBYxbjrzgwnboYJOnlbthp
	vuvwrD1knjYQpQm6XgHQY1WqcrBH05lD9Ta15xJ6GiNZ71z0/5v1JuI3Ie73NsQX8cwewLsmW4N
	pQhSSSUMap/NZ+fEqf5zofFT7p3QkjE8dttJqBPqkmBVUXU+APmHpj1fXw
X-Received: by 2002:a2e:bc24:0:b0:3a6:95a:52a6 with SMTP id 38308e7fff4ca-3a8877b72d8mr7514571fa.20.1790950033932;
        Fri, 02 Oct 2026 07:07:13 -0700 (PDT)
X-Received: by 2002:a2e:bc24:0:b0:3a6:95a:52a6 with SMTP id
 38308e7fff4ca-3a8877b72d8mr7514081fa.20.1790950033516; Fri, 02 Oct 2026
 07:07:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260929071743.23624-2-edumazet@kernel.org> <179090395863.434549.3668493667259120759@kernel.org>
 <CAL4WiipAe11BJA0rs33_0=bzYXMr0qQvQMPc+6-awyFQdQ1yCA@mail.gmail.com>
In-Reply-To: <CAL4WiipAe11BJA0rs33_0=bzYXMr0qQvQMPc+6-awyFQdQ1yCA@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 2 Oct 2026 10:07:01 -0400
X-Gm-Features: AclHuK_sfowi4LPKpSWl8IXP3uRNzWbqORQfvYROS9BqQto16BFcN8kPZWF14yQ
Message-ID: <CAK-6q+ga-MNEXgENToB2hLB9jzpsGMrz-1sOo7WQP5M-scnAxg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 1/9] dlm: fix send buffer backpressure handling
To: Eric Dumazet <edumazet@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, ncardwell@google.com, kuniyu@google.com, 
	edumazet@google.com, netdev@vger.kernel.org, teigland@redhat.com, 
	gfs2@lists.linux.dev, john.fastabend@gmail.com, jakub@cloudflare.com, 
	sd@queasysnail.net, jiayuan.chen@linux.dev, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, mptcp@lists.linux.dev, 
	guwen@linux.alibaba.com, dust.li@linux.alibaba.com, alibuda@linux.alibaba.com, 
	cel@kernel.org, jlayton@kernel.org, neil@brown.name, okorniev@redhat.com, 
	Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org, anna@kernel.org, 
	linux-nfs@vger.kernel.org, achender@kernel.org, rds-devel@oss.oracle.com, 
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com, 
	christoph.boehmwalder@linbit.com, axboe@kernel.dk, drbd-dev@lists.linux.dev, 
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	linux-nvme@lists.infradead.org, idryomov@gmail.com, amarkuze@redhat.com, 
	slava@dubeyko.com, ceph-devel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JON_x6hYd-rRLBL6X8mAF67byEqA2XpG2rUfg-dWans_1790950034
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 2, 2026 at 4:33=E2=80=AFAM Eric Dumazet <edumazet@kernel.org> w=
rote:
>
> On Fri, Oct 2, 2026 at 3:19=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wr=
ote:
> >
> > Thank you for your contribution! Sashiko AI review found 2 potential
> > issue(s) to consider.
> >
> > Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 1
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchw=
ork
> > know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> > (one such reply per series is enough).
> >
> > - [High] A TCP reset or TCP timeout while the connection is waiting for
> >   send space can stall the dlm connection permanently.
>
> I dunno if I want to spend time fixing all dlm bugs.
>
> It seems TCP changes are now stuck because ood pre-existing bugs in
> in-kernel-users.
>
> Sad.

I will take a look into it and cc netdev people.

Thanks.

- Alex


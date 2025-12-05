Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12CA309F14
	for <gfs2@lists.linux.dev>; Fri,  5 Dec 2025 08:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764925036; cv=none; b=iUM+HAYm6tikRQlW0xbiMXk2D/l/UMH1jlfWsSqiotzI/vrs0Ogedp71s+7YeW0k6XkCRWDyGzGAUHxhrg7lQBxJZ/IcQQh9L5got6mtk1wwE2sRJa6sVTFkWJnPnvJ32qfMwNs/koxQDopanXJchom4O4ELwqGxME2fxFzJukQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764925036; c=relaxed/simple;
	bh=kI/BmZknfJEnMAoux6UNqNWZZavATt2Ci9CEQ2NFztc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ACQqDms1h7Nqyn9B5oToB0OpWvXk2SDdtgJSLND1ahprPGWJbJvosYVKJJ7mh+sBTuWSuwAaR+c3vqWx21OPadwH3a/A3kxnGkRlWJa/uyaomcAh8HYbR0AcqO1aGPnc9qXWA4lLfRJOuWe4XtkbCnmimajKfgptXgp5+a2ecA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eiju6t7R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eiju6t7R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764925023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kI/BmZknfJEnMAoux6UNqNWZZavATt2Ci9CEQ2NFztc=;
	b=Eiju6t7RMtai85cSMPrtrjLWi2O7i1qS26HiitMkGTNeJdQQrhEU1iPYI7dMN8bjjH+pJx
	+j6JvdKrVieAVzm7xZWXMLEWfEGSNf5S/hQgsW/FGqP3egDLh/vtL5AnHw7ISkQDx7EHlV
	GwdzdATTZP4+UTS6Cukz7LgdR5c2HBo=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-SPdi8RsIPUGF5TlRYGMgZA-1; Fri, 05 Dec 2025 03:55:51 -0500
X-MC-Unique: SPdi8RsIPUGF5TlRYGMgZA-1
X-Mimecast-MFC-AGG-ID: SPdi8RsIPUGF5TlRYGMgZA_1764924951
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-63e08ae023cso3276767d50.1
        for <gfs2@lists.linux.dev>; Fri, 05 Dec 2025 00:55:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764924951; x=1765529751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kI/BmZknfJEnMAoux6UNqNWZZavATt2Ci9CEQ2NFztc=;
        b=X0lSgjIzZoUDN1gKSDAQR0VFzfoBW7k1CghzlhX9G3X9XxyNtOk8U2TCfu5fFHUf+u
         4IoY1QSX4nqu41WcWzHsgxWorfJBXFV0Z/DStawl4UwIHVW7yNdC3dUNblnvrdwCqxXn
         dy4A7nfW8QSiNYd8/ieiCcfwWyiLtd/jRkt/PQFUYNx0Swl2knA0t8PXPl8Z51/m6X6s
         8j9px2kO7KwC2NDiuj3DfI6ga0vUjv3yJPdHRdvb21UcB5o6Wffx64ni+wSsong55WZS
         mNLa/FB3SnVR09sT5t/G1NXfXYLAPZAFmEckn32/K5vv1OhjpJ1Dqdzi7ilc2asx70Xv
         4VTw==
X-Forwarded-Encrypted: i=1; AJvYcCXTPD8Zg8AlhggmsYMJdCfjD6Ie0IiBNE6xcAdo31rax1mIB0r/R/rWncI0xm646vkutewE@lists.linux.dev
X-Gm-Message-State: AOJu0Yxq/jInHtzbUACN4wz4rkxqdYcdkD6Gqj0rHhS10jlqY1pawhqO
	k+CqNrk6jpHbbpka7JLE5KX73K8G4kZ9UIbAvYQshM3B7tg3e60bUSTJeJztm34eeLaBGilCQ7D
	gSRqHd2yuIMJIvBIGfHyxsuo/MO4aMSGApyIvdCXz6zPlRem0N2HaC2nvgIb9miD+CnhdhN2sSg
	ivEJDAzhH0+bCvpTgENTUb+Ub3QAE14Q==
X-Gm-Gg: ASbGncvWfjpgBiVdNUXg4fuR5EkoAJ9r1zZ1yRnimAv3Ej1d4G60ZimggpgdBODkIUn
	a/SCgsTZiqtium+r8EDtjcIFUEKRDYHgScChmZh7/xRMEHpn9zk14/5f7bDuucfqRxlxj7w6LOg
	fCz5J3tG+lcGtcrjNumlgqXjGtn62YV7AVLiwfYc+rfHNXEPEWh01F7G6f650nlwH+
X-Received: by 2002:a05:690e:11c7:b0:63f:a876:ae58 with SMTP id 956f58d0204a3-6443d6e683bmr5035628d50.9.1764924951055;
        Fri, 05 Dec 2025 00:55:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH06t5ScTL3/41cXQ9/KNdNBUKke6bRZRDIIsDOJI/s90MmtU+OELXMsXOy8CKQ41Y5BIrK12B8cMtyqGUq3aU=
X-Received: by 2002:a05:690e:11c7:b0:63f:a876:ae58 with SMTP id
 956f58d0204a3-6443d6e683bmr5035612d50.9.1764924950709; Fri, 05 Dec 2025
 00:55:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
 <20251128083219.2332407-7-zhangshida@kylinos.cn> <CANubcdUtncH7OxYg0+4ax0v9OmbuV337AM5DQHOpsBVa-A1cbA@mail.gmail.com>
 <CAHc6FU5DAhrRKyYjuZ+qF84rCsUDiPo3iPoZ67NvN-pbunJH4A@mail.gmail.com>
 <CAHc6FU57xqs1CTSOd-oho_m52aCTorRVJQKKyVAGJ=rbfh5VxQ@mail.gmail.com> <CANubcdVuRNfygyGwnXQpsb2GsHy4=yrzcLC06paUbAMS60+qyA@mail.gmail.com>
In-Reply-To: <CANubcdVuRNfygyGwnXQpsb2GsHy4=yrzcLC06paUbAMS60+qyA@mail.gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 5 Dec 2025 09:55:39 +0100
X-Gm-Features: AWmQ_bn5nYIfNoOVXdPvu9TIQvwvBK4TRvGDwrtrakvgOSxNJSsbjWkIZFSXMho
Message-ID: <CAHc6FU4G+5QnSgXoMN726DOTF9R-d88-CrfYMof0kME6P_o-7w@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] gfs2: Replace the repetitive bio chaining code patterns
To: Stephen Zhang <starzhangzsd@gmail.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, ming.lei@redhat.com, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, linux-block@vger.kernel.org, 
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lYCP2r1yS3kmtzU4R37InrH8ys6KNUWHSp3PDoCAHe0_1764924951
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 8:46=E2=80=AFAM Stephen Zhang <starzhangzsd@gmail.co=
m> wrote:
> Andreas Gruenbacher <agruenba@redhat.com> =E4=BA=8E2025=E5=B9=B412=E6=9C=
=884=E6=97=A5=E5=91=A8=E5=9B=9B 17:37=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Mon, Dec 1, 2025 at 11:31=E2=80=AFAM Andreas Gruenbacher <agruenba@r=
edhat.com> wrote:
> > > On Sat, Nov 29, 2025 at 3:48=E2=80=AFAM Stephen Zhang <starzhangzsd@g=
mail.com> wrote:
> > > > This one should also be dropped because the 'prev' and 'new' are in
> > > > the wrong order.
> > >
> > > Ouch. Thanks for pointing this out.
> >
> > Linus has merged the fix for this bug now, so this patch can be
> > updated / re-added.
> >
>
> Thank you for the update. I'm not clear on what specifically has been
> merged or how to verify it.
> Could you please clarify which fix was merged,

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D8a157e0a0aa5
"gfs2: Fix use of bio_chain"


> and if I should now resubmit the cleanup patches?
>
> Thanks,
> Shida
>
> > Thanks,
> > Andreas
> >
>


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EDFF504
	for <gfs2@lists.linux.dev>; Mon, 18 Sep 2023 12:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695040704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IbTT3UxyL3H/nEohNzpH2nr94phq7RVCv6YPBkujK5k=;
	b=jVY/LUP25zAlXcjNC34O2GYwnP9WPGbZUg328ATTDxa8FDc1dDXI2bv2PHt43vnjnwATQW
	M3ubLxP3mfYt8xqLem9fW9FxG6RbgEsCcavG5mtj2r5ikebQTR6cEJpAgp+s2th5Y0ViI1
	uWUvahLYZjjC5G1wFKCqmkBh+Jc+jYo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-GMXd-SmxPeaU-I-MMi2z1A-1; Mon, 18 Sep 2023 08:38:22 -0400
X-MC-Unique: GMXd-SmxPeaU-I-MMi2z1A-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-51d981149b5so3044800a12.3
        for <gfs2@lists.linux.dev>; Mon, 18 Sep 2023 05:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695040701; x=1695645501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbTT3UxyL3H/nEohNzpH2nr94phq7RVCv6YPBkujK5k=;
        b=RsB2uaq7uSWAXQB2hIHuA6H/oAWMFwf+7IzI8aONeys04mR4Z4VLxXnh/lzhRk1KvB
         52S1qhPKUd/6vCFRexnLNnk6ZvOEJedpmZeHeJj30l6YgkXY5vTooj/zHurr2DnRvWvf
         1ZYi3Kph3Q7nwJrOYcJoiGHkLfVSMoFojTv4BiWVPqBbTHIy81uY+Lus/cOgN90Ma40v
         pmo5CjAaSfi/qQtN2ilJW4amPyz5LBPPyfDlWULVTXz/3STF2baHOAPIpcduzwfs2sr9
         aADN2stdy8Pq0fcidsR4jVckELFrR1W/jkJ2XHzorzevP46cWYU72Wkq7NyEIEfew1UH
         GKyA==
X-Gm-Message-State: AOJu0Yx/GUOzpQi+VElksdn3pUOBqs93bzp/n7WwoVmKjhEcjwWBITaG
	cAd11hwPd7fDM+1jMmf4ez3OzblLvk4S8PfaAD/46DMRSjGcYbnCK5CifZFP/PL/zm+6vcPLV+a
	V/LW2wmuXywDgiyOukDU/TkaJ7W1i+w==
X-Received: by 2002:a17:906:32c1:b0:9a1:c659:7c56 with SMTP id k1-20020a17090632c100b009a1c6597c56mr7442393ejk.22.1695040701547;
        Mon, 18 Sep 2023 05:38:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzI2EitJR0zJDb98cayvdczTbfNmReyYoiX5qbAGrH1KzCfB9fNZ62SOPdtO2qfvgfJn1kpICDpn7XizCnTc4=
X-Received: by 2002:a17:906:32c1:b0:9a1:c659:7c56 with SMTP id
 k1-20020a17090632c100b009a1c6597c56mr7442378ejk.22.1695040701286; Mon, 18 Sep
 2023 05:38:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAK-6q+ghZRxrWQg3k0x1-SofoxfVfObJMg8wZ3UUMM4CU2oiWg@mail.gmail.com>
 <ZQUjD0liUnH+ykKY@gondor.apana.org.au> <ZQg7s8MtByk4kfzP@calendula> <ZQhButkhI8K6cduD@gondor.apana.org.au>
In-Reply-To: <ZQhButkhI8K6cduD@gondor.apana.org.au>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 18 Sep 2023 08:38:09 -0400
Message-ID: <CAK-6q+jLe_WnsMrkASv_AB722YARP=f7j=Je2VZYOKjfYUKcuA@mail.gmail.com>
Subject: Re: nft_rhash_walk, rhashtable and resize event
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Network Development <netdev@vger.kernel.org>, kadlec@netfilter.org, 
	fw@strlen.de, gfs2@lists.linux.dev, David Teigland <teigland@redhat.com>, tgraf@suug.ch
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 18, 2023 at 8:26=E2=80=AFAM Herbert Xu <herbert@gondor.apana.or=
g.au> wrote:
>
> On Mon, Sep 18, 2023 at 01:59:47PM +0200, Pablo Neira Ayuso wrote:
> >
> > One more question: this walk might miss entries but may it also
> > duplicate the same entries?
>
> It depends on what happens during the walk.  If you're lucky
> and no resize event occurs during the walk, then you won't miss
> any entries or see duplicates.
>
> When a resize event does occur, then we will tell you that it
> happened by returning EAGAIN.  It means that you should start
> from the beginning and redo the whole walk.  If you do that

To confirm this, redo the whole walk means starting at
rhashtable_walk_start() again?

Thanks.

- Alex


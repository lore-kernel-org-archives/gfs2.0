Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8BB18E01
	for <gfs2@lists.linux.dev>; Thu,  2 Nov 2023 13:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WcpfCTTN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698931894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iOyvRI2FQDiFgvGCyMy/JC99E0d2utaDb/RxBJ8JTK4=;
	b=WcpfCTTN15slyNw9Yf5Tn7jtqshdvfaXd4utr2TsIzQn7vatJlPpZncQosqh5LHr/K+2kj
	nBcjCkD8nCMxDgpVD5j6eV/I1BHOOyuTVxvlCStS9IAP+Oe9NelBinDGpApVDm0A5+h8s4
	sfrVNL7QLsA+n0CdQdgPLM7/dCH94EQ=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-iLxgWo2IPpKtiviNkLxmyA-1; Thu, 02 Nov 2023 09:31:33 -0400
X-MC-Unique: iLxgWo2IPpKtiviNkLxmyA-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b2ef9e4c25so1276007b6e.1
        for <gfs2@lists.linux.dev>; Thu, 02 Nov 2023 06:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698931892; x=1699536692;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iOyvRI2FQDiFgvGCyMy/JC99E0d2utaDb/RxBJ8JTK4=;
        b=iUjNBRDJuDxBmsnjNxIDPyVUOlzi/DDRZUUCr6EVQ22fX3+rIlbj2T4CIfoRCgiY9G
         i9v66mxUXTnPYU1vEzZlH4a9cFn1QipCbZ+z0ZVbPTz6YSb6y3azA6SIKRYDSUrjyQgI
         SBgdB0ZYcAzWWcnuqwvugQy8ojg+sbPpgNAQtZ91UoD1/gvcYw6Ya+Tm3oR48harA850
         PJYQIQW6W8jcW7OcBD3kcRUaGZ82YzY7L1Js0HVgrTlj9/9QgG8Eprii7sgD9WkP7+dF
         9IEWCVDKNFWIUg6z+3zw1bXdmojJqDyKC070uCGM+slEfPkIHj/X7Ty9PV2VDME70/qi
         m/HQ==
X-Gm-Message-State: AOJu0YyxMD1l/osi4l3RmA8D9mSPDRWaiW8LKaNx72FIAa1OV5zOvtuR
	zvYdyLxskrn9y9ICR0eFN/mVETck7sTYUockIYyExVnk2ijVMKKteFhuzuxcupitN34cX3lBv45
	MYmgZYET48BZPGg==
X-Received: by 2002:a05:6808:2004:b0:3a3:ed41:5ab with SMTP id q4-20020a056808200400b003a3ed4105abmr24485337oiw.9.1698931892246;
        Thu, 02 Nov 2023 06:31:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdy5bL/bkBsYEtGS6WGL+rGk9rV/54hsP6yXQcGK4r7VuxFarEg/sfucLU/5Tzh6xBogNhjA==
X-Received: by 2002:a05:6808:2004:b0:3a3:ed41:5ab with SMTP id q4-20020a056808200400b003a3ed4105abmr24485317oiw.9.1698931891973;
        Thu, 02 Nov 2023 06:31:31 -0700 (PDT)
Received: from localhost.localdomain (0.7.3.c.2.b.0.0.0.3.7.8.9.5.0.2.0.0.0.0.a.d.f.f.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:ffda:0:2059:8730:b2:c370])
        by smtp.gmail.com with ESMTPSA id pa37-20020a05620a832500b007757eddae8bsm2315201qkn.62.2023.11.02.06.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 06:31:31 -0700 (PDT)
Message-ID: <b53a9c1db1792ca7fa216e7856a32672b9fff5ea.camel@redhat.com>
Subject: Re: [PATCH 10/25] gfs2: Two quota=account mode fixes
From: Steven Whitehouse <swhiteho@redhat.com>
To: Bob Peterson <rpeterso@redhat.com>, Andreas Gruenbacher
	 <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev
Date: Thu, 02 Nov 2023 13:31:29 +0000
In-Reply-To: <9831e5bf-ee77-480e-98a6-68a852911ab2@redhat.com>
References: <20231101164615.1138692-1-agruenba@redhat.com>
	 <20231101164615.1138692-11-agruenba@redhat.com>
	 <c512895f-5d97-4227-9885-6948f5bbbe9b@redhat.com>
	 <CAHc6FU4Tz-M7uYaKy3vw9ycrqOiS6B_cHys0=txNvTHc3P+JZg@mail.gmail.com>
	 <9831e5bf-ee77-480e-98a6-68a852911ab2@redhat.com>
Organization: Red Hat UK Ltd
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2023-11-02 at 08:14 -0500, Bob Peterson wrote:
> On 11/1/23 5:06 PM, Andreas Gruenbacher wrote:
> > Hi Bob,
> >=20
> > On Wed, Nov 1, 2023 at 7:19=E2=80=AFPM Bob Peterson <rpeterso@redhat.co=
m>
> > wrote:
> > > This doesn't look right. I purposely avoided coding my patch as
> > > you did
> > > in this patch because it breaks -o quota=3Daccount. I admit I don't
> > > know
> > > much about "quota=3Daccount" but it's coded into gfs2 and this
> > > patch
> > > changes its behavior.
> > >=20
> > > The way I coded it says to return if not "on" or "quiet".
> > > With this patch it returns with "off", which means it proceeds
> > > with
> > > "on," "quiet," or "account."
> >=20
> > you've said exactly this in a related conversation, and my response
> > was:
> >=20
> > > According to the documentation, the "quota=3Daccount" mode is
> > > supposed
> > > to do the quota accounting while skipping the warning and
> > > enforcement
> > > logic. How is it supposed to do that when it bails out of
> > > gfs2_quota_change()
> > > immediately? And gfs2_quota_change() depends on gfs2_quota_hold()
> > > being called first, often through gfs2_quota_lock_check()
> > > gfs2_quota_lock(), no?
> > > So at best, the way you've coded this leaves "quota=3Daccount" mode
> > > broken,
> > > but the code actually makes no sense.
> >=20
> > So how do you think this breaks quota=3Daccount mode?
> >=20
> > Thanks,
> > Andreas
> >=20
> Hi Andreas,
>=20
> I did not see your earlier response, (which is odd) so thanks for=20
> including it. The important thing is:
>=20
> Your patch changes the behavior of quota=3Daccount from today's gfs2
> code=20
> and should therefore be treated as separate.
>=20
> My recent gfs2 quota patches were all bug fixes or cleanups, plus
> adding=20
> the new quota=3Dquiet option. None intentionally affected behavior.
>=20
> If it's true that quota=3Daccount is broken today, we should probably
> do a=20
> thorough investigation of how it's supposed to work, because I
> suspect=20
> it may very well be broken elsewhere as well.
>=20
> The gfs2 quota code is really ugly and hard to understand, so changes
> in=20
> current behavior are scary at best. It sounds like your patch will at
> least improve it, but I have not looked into it. I'm just wary about=20
> adding patches that change behavior without "my" fully understanding
> the=20
> consequences. And I don't have time to investigate it thoroughly.
>=20
> As I said, I don't know much about quota=3Daccount. I've never used it,
> nor do any of my tests use it. Maybe the patch should be included in
> a=20
> group of patches designed explicitly to fix quota=3Daccount?
> And maybe we should add new testing for it.
>=20
> Regards,
>=20
> Bob Peterson
>=20
>=20

quota=3Daccount simply means that we keep track of how many blocks are
used by each user, but we don't enforce any limits at all,

Steve.


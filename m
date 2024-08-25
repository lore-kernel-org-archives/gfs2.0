Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F78F383A5
	for <gfs2@lists.linux.dev>; Sun, 25 Aug 2024 19:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724615668; cv=none; b=rrdSbzN30jMsvf+Hw3DL3jx7GekyKUMykUBw3Wkh6fLIdFE1o7nYJfMtV47SRSkkQslTN1tFNir8f2F+smc2v1b9JJKaIv32qgMUHXkg/AHjnrrLSTSZgSpA2Y1sDGIvJRBxh30MTBL+YNsWekgu+By5XoiHK62ug6cpWpa3fDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724615668; c=relaxed/simple;
	bh=SZDhFSz5cGQqOrGnjwqK1octDVUeO0+e9a3ispg7DMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HKqxRl9A7ThKlaCPqbps7cVUNIsvTMK7mVPijMxwRPLqrNFu3Ta0vGp0Iy1xRjOh/ePdrCJ0GLHRpPBTw8Yy/uikOFdI+U7DeD25mMwS8TYBlEG351s19KqNr/bmxGv25Pln2tPb9E/RwDR23M9XRq3YcCZaQjPwFNyQasFv41k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CWPU8w/Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CWPU8w/Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724615664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SZDhFSz5cGQqOrGnjwqK1octDVUeO0+e9a3ispg7DMk=;
	b=CWPU8w/Zr3X2eu8X1zdOj4DmiTeGOlTzQkKqaLhBjb253nfbA3zY1B+qOSPuhaIxzbzWDV
	ZxjJpD0VCsCU1h4aJ9YXqP8bHfaaymltVBjMarwrwR1VV+qAfEVgop/P35N8JMpF0xxugq
	szzXoqyiVVS5moMUdDjCcOq6ETIn3UY=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-qIDfVAtBMN-Ip6otcuvlkg-1; Sun, 25 Aug 2024 15:54:21 -0400
X-MC-Unique: qIDfVAtBMN-Ip6otcuvlkg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2f3f82f55feso29621631fa.0
        for <gfs2@lists.linux.dev>; Sun, 25 Aug 2024 12:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724615660; x=1725220460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZDhFSz5cGQqOrGnjwqK1octDVUeO0+e9a3ispg7DMk=;
        b=KwJwCzFUb/CXdphe8ppNNt9hlZUcIiSDshUwBabQqohf4QJulkPVnz8x7tqhy9ddaq
         eRaE+7M0OepxVKDk2LyO4w5p8rTgFPPbWCdb/ntgcRRXcfpSz13dYeoIURPH6tB0WoLM
         fklv3wOFNY+AF/3jbhFKVOq71tSFRV3AoUF1Dey6s/wmiaxO/3Zc0nk6k8hcrQ2FxI2i
         kR/I8VNv9R9h/d0p+5dSt0282Ra3FtZtDSClCvDzLEZ6pMigDwkBlNso7jPzoaORbUAa
         c4SA5m4GdMcCATW7MgHD/VPvt1usoLd+jMx++JFcu4Aht/1/5HPkEmzky3nenBKttbpB
         BN5w==
X-Forwarded-Encrypted: i=1; AJvYcCXFOUPQXe25oI53P08dcgvWwl9lBes1UWW2xreQEcktC+nPk06+P5KzEWmiqLPlMKiLe+Hd@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3mvU8CCIraYg5//XHeE8WhfvQyUXDAHR6UgTL6Ulv4B0DXv4+
	AxK9nKkflYNd0FH/Xa0JFgp2qyZJ8S8ATkuniKbiRiEGUDozxCexwU3C/3X/oxCod5R2hmyd4+N
	WFrQaGLR8CbBW3sHFeSqT6R6YVudo3KfB8yQCYdc1NHU2sVArkr8Q67PkhCmi/H5dGY/+rMAxpL
	aIOAPipNrtb+8lR/F1afgO5LdvTw==
X-Received: by 2002:a05:651c:88a:b0:2ef:2843:4135 with SMTP id 38308e7fff4ca-2f401ef2f8bmr42010111fa.22.1724615660298;
        Sun, 25 Aug 2024 12:54:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRR2RFGKYRIqaHIAtJY42+DmWhiPgyqSAg1f8W2qWMs4UGf31c1qZMTWRheB2QuKBk9MdDY6hnbgQqeIx520A=
X-Received: by 2002:a05:651c:88a:b0:2ef:2843:4135 with SMTP id
 38308e7fff4ca-2f401ef2f8bmr42009901fa.22.1724615659703; Sun, 25 Aug 2024
 12:54:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240814143414.1877505-1-aahringo@redhat.com> <20240814143414.1877505-9-aahringo@redhat.com>
 <2024082459-neatly-screen-9d29@gregkh>
In-Reply-To: <2024082459-neatly-screen-9d29@gregkh>
From: Alexander Aring <aahringo@redhat.com>
Date: Sun, 25 Aug 2024 15:54:08 -0400
Message-ID: <CAK-6q+hqhitE=_Lw2kd3kN3-hrquK550-d4jHgrkUX1uqj=zDg@mail.gmail.com>
Subject: Re: [RFC dlm/next 08/12] kobject: add kset_type_create_and_add() helper
To: Greg KH <gregkh@linuxfoundation.org>
Cc: teigland@redhat.com, gfs2@lists.linux.dev, song@kernel.org, 
	yukuai3@huawei.com, agruenba@redhat.com, mark@fasheh.com, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, rafael@kernel.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, lucien.xin@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Aug 24, 2024 at 1:18=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Aug 14, 2024 at 10:34:10AM -0400, Alexander Aring wrote:
> > Currently there exists the kset_create_and_add() helper that does not
> > allow to have a different ktype for the created kset kobject. To allow
> > a different ktype this patch will introduce the function
> > kset_type_create_and_add() that allows to set a different ktype instead
> > of using the global default kset_ktype variable.
> >
> > In my example I need to separate the created kobject inside the kset by
> > net-namespaces. This patch allows me to do that by providing a user
> > defined kobj_type structure that implements the necessary namespace
> > functionality.
> >
> > Signed-off-by: Alexander Aring <aahringo@redhat.com>
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>

note that I added the comments the kernel test robot pointed out. [0]

Thanks.

- Alex

[0] https://lore.kernel.org/gfs2/20240819183742.2263895-9-aahringo@redhat.c=
om/T/#u


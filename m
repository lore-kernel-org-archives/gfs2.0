Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453B41369AA
	for <gfs2@lists.linux.dev>; Wed,  7 Aug 2024 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047902; cv=none; b=CiPjbk87OE3nepaoAV4ihYD+kB5Y/Sjzd5Hw+PpLqklv4t760lz7v/qt2A3A2cnsq9AKnUBPRP+09x0ff63OV2F0KOmoWS6Crjk6kadeJ4kJwBAy35df8J5db/NFZmgRYdrv42JWvoV4V/p7vdjBL/n3Oqwq8/vlD5+MGKy2bfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047902; c=relaxed/simple;
	bh=6lPMOQH431GKWxLLmMbzAnj9XuawpFfji+CXA1tfKoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQwNr+I5Z3wWqc0oq9Tueg1/s00QBEsQ37cpk8GAFiPJKqh6ZyB2pgQKrG58UJkwOSbeBMkdNzJ8kxE7FDYAbPfYXhp91vsfc15MT1+S1Gcv97TGkJgD8lE8dO0ad7UVDAhUqAGJwVvy3KQXLJFJQ13PCSR1kTBFBhAOicVqNbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WCqyh5dm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WCqyh5dm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723047899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L0C9YfRuY1PQLeP1M6aYawPuUYOmUOGm2Mf6dVrGLnI=;
	b=WCqyh5dmWlwV2QiYjPM42TsiKZcHNiszMFXgLqG4L7CfXhlbmmPhEo/WndILr1EgjwJCnq
	yL62pcroJNOJyz94i1QRuzKD3EgF4SahjIx8KyMTBOjcDWZxywSlKAesJGzQAUDJaBQTCK
	2cKuKjRPlizmOhYbPnqLUeihmW5H5zI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-evKDrpibP9CUqiQ_qYbyvg-1; Wed, 07 Aug 2024 12:24:57 -0400
X-MC-Unique: evKDrpibP9CUqiQ_qYbyvg-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1fc596b86a6so10557355ad.1
        for <gfs2@lists.linux.dev>; Wed, 07 Aug 2024 09:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723047895; x=1723652695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0C9YfRuY1PQLeP1M6aYawPuUYOmUOGm2Mf6dVrGLnI=;
        b=YNqcyh9yrdEVQc5ireECXESPEJ+S0Po6fdD929VzImFLD8d9vVrvxK7mPjbHH559N7
         0XWh2iSBh+7QWVxTyqTL/g4MP+cd98ZL3WDUh4Hhi+ZKSGAu9pMuiD9WrsyN1uFhHYe4
         /nDtsYXIFf2T2Rq9OYvEUMTLDhULPxYUQaXnbhiSKJmHMF4BpXFKzYxOuWntPIqAT7jW
         ZVBOJcFeLGU7jqabZfBy3aFxhEMjFCyxIGJ4HXZ/wkUHsuxqhZAZC736pjIcQswa42Od
         uOLFh+QTc8JdBg1C5zF+yyvBhUQpD/AuPJMUhVeO9e5z7J4bYuB/ShESBmJQNGBakLEV
         ZO0w==
X-Gm-Message-State: AOJu0YwMBpaTkPTsnVNB+Ij+OiYJUF4ytAb2tivtJOeEcB+XYjsjhGNo
	yLkDsqMaZ5ye7YZ0M0uDP6X2p5/kAb1Uivj9dctE+HryLDUDvhy938S9m80p6KE9MM6JdjePbh5
	jmn7xqbxzjdMwfLBB9bvPkmzcREcKi438v4jBZU1nq8qCu1HHLA49MVBGy64o/SYjx3QU/Li7f/
	eMh4/jwJN3Qj9FVMOG1Rfn2C8o0o0q3CBdBQ==
X-Received: by 2002:a17:903:32c8:b0:1fb:80a3:5826 with SMTP id d9443c01a7336-200853e6263mr46329685ad.4.1723047895457;
        Wed, 07 Aug 2024 09:24:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmpmXkhAE5hUqLSQ0+2y7OvmcWYO6zPANJy3anj8AtdA79ZKNfIl9VuRJiROff7yJ5+Aj3W7cRzHoSavKmZmI=
X-Received: by 2002:a17:903:32c8:b0:1fb:80a3:5826 with SMTP id
 d9443c01a7336-200853e6263mr46329295ad.4.1723047894949; Wed, 07 Aug 2024
 09:24:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240719175105.788253-1-willy@infradead.org> <ZrNm1gh6Fsm0tIil@casper.infradead.org>
In-Reply-To: <ZrNm1gh6Fsm0tIil@casper.infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 7 Aug 2024 18:24:42 +0200
Message-ID: <CAHc6FU76ioJT4UDRPQNMZ94QOgs6ReuM2WUcSAD4irqERmGckg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Remove uses of aops->writepage from gfs2
To: Matthew Wilcox <willy@infradead.org>
Cc: gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Willy,

On Wed, Aug 7, 2024 at 2:21=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
> On Fri, Jul 19, 2024 at 06:51:00PM +0100, Matthew Wilcox (Oracle) wrote:
> > Hi Andreas,
> >
> > Here's my latest attempt to switch gfs2 from ->writepage to
> > ->writepages.  I've been a bit more careful this time; I'm not sure
> > whether __gfs2_writepage() could call gfs2_aspace_writepage(), but
> > this order of patches shouldn't break any bisection.
>
> ping

Thank you very much for the patches. I've had a quick look, and it
looks like they should be working now. Testing still pending, though.

Andreas

> > Matthew Wilcox (Oracle) (4):
> >   gfs2: Add gfs2_aspace_writepages()
> >   gfs2: Remove __gfs2_writepage()
> >   gfs2: Remove gfs2_jdata_writepage()
> >   gfs2: Remove gfs2_aspace_writepage()
> >
> >  fs/gfs2/aops.c    | 30 ------------------------------
> >  fs/gfs2/log.c     | 12 ++----------
> >  fs/gfs2/meta_io.c | 24 +++++++++++++++++-------
> >  3 files changed, 19 insertions(+), 47 deletions(-)
> >
> > --
> > 2.43.0
> >
>


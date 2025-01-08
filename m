Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C12525949D
	for <gfs2@lists.linux.dev>; Wed,  8 Jan 2025 14:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736346468; cv=none; b=MrzPVaBXyD4Jru6/RVH8cjSedM0rcGFSKBfsRezMQ0iziqVkgauvVwbC9xzOdp9iPn0mQH2V736akujDMIwK43ADy29hquzZE2nuwZSQ/CxD4JPBAQlgaYGQLZe7a7gLKGvqwiAZRYlu9NUsBhfiI/9FUTKg8Mx6YHjQdyfA5BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736346468; c=relaxed/simple;
	bh=WULXdAqNRsXXbxaxU4bpmD9eY7ctbTcKquvYfm2fSR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8tcJaZZKstUiy/OpLLUDBLB1Of4fAKtx5/ugqE9M1iNrILqTg2oc7GYTUVnkxWUjnnuwWGEys5EBDiiQOsyPSNvQqBaGmcPLlrbmml70jH0NIJEs7jZZqidxln5bwbkrVEJTZjsbyhVLxlNMT9NX6F9ITZ4Hgg2lUIvUciucpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ho3Qn1Kf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ho3Qn1Kf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736346465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WULXdAqNRsXXbxaxU4bpmD9eY7ctbTcKquvYfm2fSR8=;
	b=ho3Qn1KfVbWTPN3irTBzSqk0pjutxRlqyKjYuextT6sK2CSC9joq9mpA8ljEL7a+XOnduy
	Lb24WVSn+0v1q97bK9S26ShHH6c8bCwLcd+78Nc9VWWRWtAlXBE7+CTfZAo6u9I9lf/3/7
	d6Y5awt4CPI0I3bK+k5Yo9ol8awtmf0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-djLZ_o6VPc2bjeNDJ8k8CA-1; Wed, 08 Jan 2025 09:27:44 -0500
X-MC-Unique: djLZ_o6VPc2bjeNDJ8k8CA-1
X-Mimecast-MFC-AGG-ID: djLZ_o6VPc2bjeNDJ8k8CA
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-3003672320dso67836621fa.3
        for <gfs2@lists.linux.dev>; Wed, 08 Jan 2025 06:27:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736346463; x=1736951263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WULXdAqNRsXXbxaxU4bpmD9eY7ctbTcKquvYfm2fSR8=;
        b=evNXBR+FF6pz1Db0yMAWyq93m3yOCRJTG7JUnGFBWgbzBV9oy9GKw3rD5P89+lshwk
         vkq9BHU0HXXhhy+ucQj/3QsPoQ0H4KZQX1bzOkQoFljoT+22575STYgaEiuscgRMkhXF
         yD8zcBDefO5QXDWO2gWWyvGI9cH2WZ6FTXROSldrbB1yYSReuCtrYlcpadcGEJucHz6n
         0yDk/KH3rBsu4mZQughEEOK2mk9kP1dv9XRBFII+Mjojzw7NJGUztL42Wcaiyw0WlOhs
         mouH4K2Rxs3EoEuls/jachv+svVUD8qs2zJfe8oIZ8Xw3LoWe1X3Xst8CC4RqwxopCOI
         3n4g==
X-Gm-Message-State: AOJu0YwjW4KG1Du1D5gAAjXEZpEubTMlHyMqFQ1pW6F4S6GGSmCxemSZ
	chW3uKs9Lt6iFLu1rIMD3TDcU+DNjd5kyO/yvXlaL5RlyCR1T6jyNXMfnT4k966wG044i7KneoE
	O4I8jnwRP0LWUUdnkyYogTbpeWJuRwzcNSX2iUQONx2Ab1NJp/z2Vaa/+uTBKOrMxCQkxNF9LNm
	78XkW0aR7nbTR49NZMFGLAtqmmhQ==
X-Gm-Gg: ASbGncsr1abxZOeuyxbSNaCK2Pn2dwyaP50NPceX8s/unlaZ3B5mNh5por/iZE5GOAe
	1KzZroxkNSkR7Fe+PBxJ0Za2xVIlk4y/1VI0cBBI=
X-Received: by 2002:a05:651c:4010:b0:300:8ff:d93f with SMTP id 38308e7fff4ca-305f4575ec2mr5373971fa.22.1736346463042;
        Wed, 08 Jan 2025 06:27:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyjpMJjmIMwtfFeQScSQQditEqhEVX6UFKeHFBK4FT4W4GfFgpnnaRTmRfJLynxQLdddjy6FPun9sTv+Yfsk0=
X-Received: by 2002:a05:651c:4010:b0:300:8ff:d93f with SMTP id
 38308e7fff4ca-305f4575ec2mr5373841fa.22.1736346462595; Wed, 08 Jan 2025
 06:27:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241220141913.1346301-1-cascardo@igalia.com> <CAK-6q+hV41=KuZfFUpmJgm8YX8GVxoWZKiA_gGNHWXopt2VpBA@mail.gmail.com>
 <Z31wEtweV8FlQsVA@quatroqueijos.cascardo.eti.br>
In-Reply-To: <Z31wEtweV8FlQsVA@quatroqueijos.cascardo.eti.br>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 8 Jan 2025 09:27:31 -0500
X-Gm-Features: AbW1kvbWxb09GxRavrwuLJonlVFd-yL8n2mGU4LL7A5BGR9o--B_3pL-pDNY-30
Message-ID: <CAK-6q+g3TYu5MKkwzcgDsBGjxZ3j5D-kxXdeFmQPv1dMxkSzRg@mail.gmail.com>
Subject: Re: [PATCH] dlm: prevent NPD when writing a positive value to event_done
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: gfs2@lists.linux.dev, David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org, 
	kernel-dev@igalia.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ALmE1b9dfpEA1FbwWymiWTF2Eja792Vx5aooKTrnSa0_1736346463
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 7, 2025 at 1:19=E2=80=AFPM Thadeu Lima de Souza Cascardo
<cascardo@igalia.com> wrote:
>
> On Mon, Jan 06, 2025 at 11:14:35AM -0500, Alexander Aring wrote:
> > Hi,
> >
> > On Fri, Dec 20, 2024 at 9:28=E2=80=AFAM Thadeu Lima de Souza Cascardo
> > <cascardo@igalia.com> wrote:
> > >
> > > do_uevent returns the value written to event_done. In case it is a po=
sitive
> > > value, new_lockspace would undo all the work, and lockspace would not=
 be
> > > set. __dlm_new_lockspace, however, would treat that positive value as=
 a
> > > success due to commit 8511a2728ab8 ("dlm: fix use count with multiple
> > > joins").
> > >
> > > Down the line, device_create_lockspace would pass that NULL lockspace=
 to
> > > dlm_find_lockspace_local, leading to a NULL pointer dereference:
> > >
> >
> > This issue starts to be an issue since commit 4db41bf4f04f ("dlm:
> > remove ls_local_handle from struct dlm_ls"). Before
> > dlm_find_lockspace_local() was then returning NULL and
> > device_create_lockspace() returned -ENOENT as it wasn't found a NULL
> > lockspace handle, see [0].
> > After the patch it dlm_find_lockspace_local() will end in a
> > null-pointer dereference because we don't do this lookup of pointers
> > when we already should have this pointer already.
> > This behaviour is kind of weird (as it makes no sense to lookup NULL)
> > and yes, I didn't see that when I wrote commit 4db41bf4f04f ("dlm:
> > remove ls_local_handle from struct dlm_ls"). Just this commit signals
> > us we do something stupid with the error handling.
> >
> > May I ask you which user space software do you use? As for
> > dlm_controld I can't see that there is a positive number case for
> > telling the event_done attribute. [1]
>
> I was just playing with it manually, that is, without dlm_controld. I was
> writing down into configfs and sysfs manually while issuing ioctls and th=
en
> tripped over this NULL pointer dereference.
>

ok, thanks... I am worried now you probably see more issues. :)

> I see how commit 4db41bf4f04f ("dlm: remove ls_local_handle from struct
> dlm_ls") leads to the NPD. In any case, I suppose the Fixes line could
> either be the one I pointed to (since that is what leads to such positive
> return values to undo lockspace creation and still be interpreted as
> success) or 4db41bf4f04f, specially if we want to restrict the backports =
to
> only the kernels with this latter commit.
>

yes, it was already broken before. I agree.

Acked-by: Alexander Aring <aahringo@redhat.com>

- Alex


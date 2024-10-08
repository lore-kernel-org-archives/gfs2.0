Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1919320ADC3
	for <gfs2@lists.linux.dev>; Tue,  8 Oct 2024 17:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728409019; cv=none; b=uG/Iuc3H55QCUQM92HfLamg7AI2eTOOgaWGrMhh8v764WclxnsosNcbNM27fI3O6X4bQ8A2UTzc+nrd2GOORw6BLBBOSegPvulEj6aw1fUvGENR8schWPpOdc6ibkZ0ljI5KS/RRBCe7N/dZS+q2Gmxc3yaEpEdFndRUO6fk44A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728409019; c=relaxed/simple;
	bh=MEAowTIs9B6ucEs2WWgxfjYvBWfoswPfIgFCG+Z+mJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgeakvN0T1QjbMMCkp9EGY93CIXhYt5mPxj7sATV7ta4D1Y7edsxvT5vmJtQNrYZaFlhgcroVC2YBXC5qeaXDbia2j+SmvFYxhEc35K7d12n9L0BEWMnN8S2Jl/GRE4qNhgIuqJ4bFJJBFc2UjyFL5DGOKsROpNGq35JGjuDElM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fqS+sJ+X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqS+sJ+X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728409017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MEAowTIs9B6ucEs2WWgxfjYvBWfoswPfIgFCG+Z+mJk=;
	b=fqS+sJ+X7S3dRbkdHrt9KrZ+/BxYM2NgY3ozwzqEQwyRqVXoBeV6BWVvxvkXNaQYkLAOsb
	KB6QH0dEr+SXOWnVYMsEMZozQ3qICP1x65xO6IDyKxOhtZRFwe+cAXuMOi4PGAaz9eeF5J
	EGDb3xb3Bu85RvJJKW72+KmEFn87wqU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-9FXDQ0QrPUyTW8kHqc6uTg-1; Tue, 08 Oct 2024 13:36:55 -0400
X-MC-Unique: 9FXDQ0QrPUyTW8kHqc6uTg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2fad0f66e28so42013701fa.1
        for <gfs2@lists.linux.dev>; Tue, 08 Oct 2024 10:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728409014; x=1729013814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEAowTIs9B6ucEs2WWgxfjYvBWfoswPfIgFCG+Z+mJk=;
        b=q/TVPKPZ0ivAh+9dBSTeViQ8QRdVGCMSLLV/Rjhr8mIqszlIl1yO72j3sFHRu9Wps3
         dI5bGeCGIyFwPlv0cy5Y4tG3OVcno9i1SI/sQRm2vekp4qYMfZf51q6iBk6cDLF2/2ub
         +rSAN3a9pMMUqz+LWYKD0BWrhKF8d1PKDZ0Eo5UePrU2oHbnnLjIFktCRO0Mx8mHiAPm
         RMDa4N5MHtOqvq00bXjgP8ntXcZQ0FcX8Kp/YmxMdZAEVSbg0m0zvDONNVXHmHIkFNWW
         P8RVvG7TXTIRz80IaVFqGKjtcbYX7OrOr+j72u3XPJxv1NrgGb1RdMyfjwKWDrFcTsK5
         7FUg==
X-Forwarded-Encrypted: i=1; AJvYcCUCjnajwC0LEG5/oGDOaMnw7BO6KTw0GPza0blUzxMcI0kHY6nooq251zAeXyrZd2B1Gz7k@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8vq75IB1LgQzb0kLzjveVEkn2EU8JZTFuu27vgDI0F0l3s5uN
	tPMmzm3wyn05GjAry6eDcRmE1nm1E0VHoTkhgJF692iUVWWxx0av9dbrpP3ULXJo3VPntRdbuEk
	mO7FIEO3hCpUC2CytRxV2agOFqRVN+8Mz53cbytWqQMoklOAbUNfdyBCkYSWaxFax68h+Kqcbfd
	gGHU9HxLLuvO1ga07SygN90ICXXQ==
X-Received: by 2002:a05:651c:4cb:b0:2fb:51a:d22 with SMTP id 38308e7fff4ca-2fb051a0f84mr41785871fa.23.1728409014236;
        Tue, 08 Oct 2024 10:36:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyxvYUsWDXwuq1qgj9KeuoeJvQZvdLhpB95VL+Hxq4QwXy+WT778qu25XObcmaxbqJ8/S99KWvEgS8Zzxmmi0=
X-Received: by 2002:a05:651c:4cb:b0:2fb:51a:d22 with SMTP id
 38308e7fff4ca-2fb051a0f84mr41785681fa.23.1728409013810; Tue, 08 Oct 2024
 10:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241003151435.3753959-1-aahringo@redhat.com>
In-Reply-To: <20241003151435.3753959-1-aahringo@redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 8 Oct 2024 13:36:42 -0400
Message-ID: <CAK-6q+imtq3=pcM-gEnAYyyA_uYZsBpPbirCOh5yiDs9fr326Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] nfs: kobject: use generic helpers and ownership
To: trondmy@kernel.org
Cc: anna@kernel.org, bcodding@redhat.com, gregkh@linuxfoundation.org, 
	rafael@kernel.org, akpm@linux-foundation.org, linux-nfs@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear nfs tree maintainers,

On Thu, Oct 3, 2024 at 11:15=E2=80=AFAM Alexander Aring <aahringo@redhat.co=
m> wrote:
>
> Hi,
>
> I currently have pending patches for fs/dlm (Distributed Lock Manager)
> subsystem to introduce some helpers to udev. However, it seems it takes
> more time that I can bring those changes upstream. I put those out now
> and already figured out that nfs can also take advantage of those changes=
.
>
> With this patch-series I try to try to reduce my patch-series for DLM
> and already bring part of it upstream and nfs will be a user of it.
>
> The ownership callback, I think it should be set as the
> kset_create_and_add() sets this callback as default. I never had any
> issues with it, but there might be container corner cases that requires
> those changes?
>
> - Alex
>

Can we have those patches applied to the nfs tree? According to the
udev/kobject maintainer it is fine to take this in any tree that it
needs to go through. [0]
I made nfs as a first user of these new udev helpers functionality, so
it should go through the nfs tree if there are no other issues with
this series?

Thanks.

- Alex

[0] https://lore.kernel.org/gfs2/2024081519-caddy-monstrous-b37d@gregkh/


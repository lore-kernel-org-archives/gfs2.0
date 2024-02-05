Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4415D3A1A7
	for <gfs2@lists.linux.dev>; Mon,  5 Feb 2024 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148393; cv=none; b=gbIeVQ8RSM64m5Mssllfm/oN5oq1EcN4Sje+MIuRxryur+rAL1Sm5+ShgghfUCrzlBrXY59LlF+Nf9NvyOAhoX8Jdz+BU+Kny+d82ckb4MSX3uo5gP++djQHMqbpLyo1w97lLOjNzQm95pDrUjaZGkY+UEgOXXlF2h7crwwU8G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148393; c=relaxed/simple;
	bh=J8roI+XJDSVMI0a0Dhawqwac0Zkmnw0WWNfCfpE3idI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VpMZL9sHJ9brG+W36u/O1Kf/BGpGKdjNzBakBPMg0669+9EclPllxtYm+T7d6RQN4DYSCHBgOlnAvHOI/AoBQ3Fd/hOCRJhYRB/eLi5T4UlArYjRqV/lV9OmtR1MeYalN8S/nuw45sFBkeRlsMxV2Aq0cK23pefhTv0n5Yo2M08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P6+K8S8M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6+K8S8M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707148391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J8roI+XJDSVMI0a0Dhawqwac0Zkmnw0WWNfCfpE3idI=;
	b=P6+K8S8MCSBfOBiY+90WZP/UxX017LukqqYtPXPcLrhjxlqFPETwhxMsn3fXPZUgEu9y+l
	ND/cnXcdz+kJPbNJBrsDmIT5zMsKprBDJMnH67fNwCDExHgv9/1QiOy3d0guUlX8p5XEpt
	d9eNBXTiDrVs7KwkSTFRuOJZjlN48KM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-0kRhATn1OauRms90KNJckw-1; Mon, 05 Feb 2024 10:53:10 -0500
X-MC-Unique: 0kRhATn1OauRms90KNJckw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-56001d4c9c8so1539720a12.0
        for <gfs2@lists.linux.dev>; Mon, 05 Feb 2024 07:53:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707148389; x=1707753189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J8roI+XJDSVMI0a0Dhawqwac0Zkmnw0WWNfCfpE3idI=;
        b=dlzNl8FQ/obiC/a5H7ZiQGiTQqFtRnKftR1GF5Py6lSDGohoat3953m/f4bkZMSGEf
         jRPd1XyzUxjMJ7HjajSCmdYbMiPSG/8MOixSz7QSV7iaoh9WY5n9rAebjM9l+MJOY+QM
         rMmV4Zrp53kkbpgaME7JAWZRw8jZnpIkiCnEAzkve3Cwf+o7kBhSL1NMCbdhvnbEBqId
         luX+eDvHqPYS/YqsjOUzj426HScMqLog4AZQ/EXYIb1EfC7SjdwpsFBpa3aJdLfViVis
         DGx/qds8AIuSaqolKqsoHUFopc2TVeED2/o8y4zuO4R9JOhhQfr7c+5F2GjvLJ1tQxZz
         bIEQ==
X-Gm-Message-State: AOJu0Yy4dlOgTwYjVilk0SrNQDqWSPvYFR2pqbnrq/WCMo6wcrkY8j6X
	KmAxhV5NBVF9RuWRmLZfedxVsj50ORfmcLga6F9vpRwxf3waQk4BKvp9PMAxStPat4c87KgElBW
	ZH7WRl5fkCk/kISFXtF8EUKcIVHE7gQ7YdfQkVlm4/eMhhHArcgPypGHSCaFx2mNIM5wWgkd65v
	9yll5eNaMOe9Cm2whTnMUMV4Fl3g==
X-Received: by 2002:aa7:c89a:0:b0:55f:fad9:a91c with SMTP id p26-20020aa7c89a000000b0055ffad9a91cmr4963742eds.6.1707148388963;
        Mon, 05 Feb 2024 07:53:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6NX6qqHmiFdtuSKtOZNZLcM6JUDXJlz0lA4ylVz4SdTvG0QkbsGX8bI+10/SGJEYXt3Fexd6AN+vUoubJvhA=
X-Received: by 2002:aa7:c89a:0:b0:55f:fad9:a91c with SMTP id
 p26-20020aa7c89a000000b0055ffad9a91cmr4963735eds.6.1707148388821; Mon, 05 Feb
 2024 07:53:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240117094912.155729-1-chentao@kylinos.cn>
In-Reply-To: <20240117094912.155729-1-chentao@kylinos.cn>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 5 Feb 2024 10:52:58 -0500
Message-ID: <CAK-6q+gjtDZOb-JFFPCt9oR1jPZ=NsLeph3H4npF8rrb0ifm5A@mail.gmail.com>
Subject: Re: [PATCH] fs: dlm: Simplify the allocation of slab caches in dlm_lowcomms_msg_cache_create
To: Kunwu Chan <chentao@kylinos.cn>
Cc: teigland@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 17, 2024 at 4:54=E2=80=AFAM Kunwu Chan <chentao@kylinos.cn> wro=
te:
>
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Acked-by: Alexander Aring <aahringo@redhat.com>

- Alex


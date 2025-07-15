Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957CB2D8DAF
	for <gfs2@lists.linux.dev>; Tue, 15 Jul 2025 11:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578032; cv=none; b=Gq631WUaTI95iv/+A8nIYSQmUK5cSGVXdueRs2UgrN9CS7jZ/eZ1+QBSVCVwMLkMrIG/0teVVJ3R55e0/E8ec4QhZ4WW4ViJuEex7n+i0jYbVCakFXpwIN0IIzmh+p6JE+K/AvNlKwu62MYyKe2gDv7R28wzMcVKNKJq+P5n3dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578032; c=relaxed/simple;
	bh=0Psq+LF0fFXBjFzE7pcErI5N1pXJT4eRpt7sxYHTe/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qr67RdpJZK+pG0Rx+gCRpx6xsuatwZYzvcaMDpjJrYQ3ofTYqf1zSdXME738qoPmQryFxrY7OpcaGIRTjD6oFyWB8O5Peo535MDMg7/kEFeeULsnVkBDyuUEtTtWhJpaFxSdXi937Epcbwl2XAUmk61DZuVACYCNvmOChzmoK9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aQ+S4PrH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQ+S4PrH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752578029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UOL35FYxBgi0boRyCseienvrlvRyobXfNrbobxVWpFo=;
	b=aQ+S4PrHGWd4cqwDie/BgMlbRjcIgYoLU8ERQRpgGTd7s2Wl9Z2cqNSFCTnH/u+HS3JFha
	LCs5G8QDr9r+VSJSX3lUaTUfIrpx2rou96A1Brchaf9vZ4JG86nlN1Qjl+MBJOZxJBU7LY
	BA6OlV9UYzbkCpsYGHkPcqQPqqFE3H8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-UMxY7SUeOpyAssO6ogErog-1; Tue, 15 Jul 2025 07:13:48 -0400
X-MC-Unique: UMxY7SUeOpyAssO6ogErog-1
X-Mimecast-MFC-AGG-ID: UMxY7SUeOpyAssO6ogErog_1752578027
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2356ce55d33so81013995ad.0
        for <gfs2@lists.linux.dev>; Tue, 15 Jul 2025 04:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752578027; x=1753182827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOL35FYxBgi0boRyCseienvrlvRyobXfNrbobxVWpFo=;
        b=RW8B38ygdJHKWWcmdt/cYHQZuLV/CIMyWVdW2VCHxdsRynPRxiHxtVN/IJLZnMICAP
         n1Ad1/dmtiFYcaKTLTZVNhR9ASAMtQ2Dym3P6WLK/YqOE+TceVWCDy32r+Rv+KH+LD9A
         uYeLp5quVr96tBeCw4fS/mvSQ6jhPWUf3AEIn8QKgN99g7QrUZ9v4PiYJAJffcNnh2Fq
         lI4OYDLaZndaj4Fam75dfAMb6B/rdX1uXEOJz6WZbL4ZVeSaDWcUbJ+hIq5xYfmFNFsO
         uh/zy6ecaV6XD5z19rGL9Gh7K6D3lZ0pyapYo102XDyqC4a0XDLWbKqz33ItqtpgDIW+
         9nWw==
X-Gm-Message-State: AOJu0Yz0358rSiNuMjHOl1eD4VBFCRs+wweYQlqrCKE2BVA1yxAlDvdZ
	CK8H6ZLFV15nFrcLRnBriSa7zsCBKZVTj/IUpHPBTf6yDOvmFyQ+qs8MaZ23gnIYMB3AME1Cxb1
	m38DWrRjmYFSOptA7D7u81PaoYZXhLrfQCeYP8XpgSMAyuL9N9V2m8DHPXjpoowT7amPw5g9OL3
	mdZRuVxfMh1DoUNC3T7RESmIkcqSAUZA==
X-Gm-Gg: ASbGncvFHPBl3uQRPXkxp42jGx7xJQvuC5oFY2q8DHiKxGXoQiYt2WlP5v1FTmM/9c9
	gw0PpBxF6ZdHVZRTXCwryKilAM+KLN05hfRVu30ji9mUbIYSGFSgyke4ZZZENe3bZ7kHhNZly4F
	N2wGQnJVnJzb58Aiv68PE=
X-Received: by 2002:a17:902:f98f:b0:23c:7b9e:1638 with SMTP id d9443c01a7336-23dede8c409mr183252855ad.35.1752578027105;
        Tue, 15 Jul 2025 04:13:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFF20jPBqkCK5sC7WCGmfd+awMU214WUALxZwme8+8AHshin2FxLGCsX8aAVtc4qUtWoxelwIAVEpM1d5uqJBI=
X-Received: by 2002:a17:902:f98f:b0:23c:7b9e:1638 with SMTP id
 d9443c01a7336-23dede8c409mr183252615ad.35.1752578026726; Tue, 15 Jul 2025
 04:13:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250714165459.54771-1-anprice@redhat.com>
In-Reply-To: <20250714165459.54771-1-anprice@redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 15 Jul 2025 13:13:35 +0200
X-Gm-Features: Ac12FXyu0WcA3bhI3kVxis6z3U10Kd9CzdAwCQ4I1WlglQCtZFNFnmFITUbiot0
Message-ID: <CAHc6FU7sGV4OJ5EpEqzHXmCdN07uW8hFDirvoqgJeZVOySXmsw@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Set .migrate_folio in gfs2_{rgrp,meta}_aops
To: Andrew Price <anprice@redhat.com>
Cc: gfs2@lists.linux.dev, willy@infradead.org, linux-fsdevel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hWibXYVoXSDNwURkxLV4mKoJWP7ekuCl6Di2hoxrKnw_1752578027
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 6:55=E2=80=AFPM Andrew Price <anprice@redhat.com> w=
rote:
> Clears up the warning added in 7ee3647243e5 ("migrate: Remove call to
> ->writepage") that occurs in various xfstests, causing "something found
> in dmesg" failures.
>
> [  341.136573] gfs2_meta_aops does not implement migrate_folio
> [  341.136953] WARNING: CPU: 1 PID: 36 at mm/migrate.c:944 move_to_new_fo=
lio+0x2f8/0x300
>
> Signed-off-by: Andrew Price <anprice@redhat.com>
> ---
>  fs/gfs2/meta_io.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
> index 9dc8885c95d07..66ee10929736f 100644
> --- a/fs/gfs2/meta_io.c
> +++ b/fs/gfs2/meta_io.c
> @@ -103,6 +103,7 @@ const struct address_space_operations gfs2_meta_aops =
=3D {
>         .invalidate_folio =3D block_invalidate_folio,
>         .writepages =3D gfs2_aspace_writepages,
>         .release_folio =3D gfs2_release_folio,
> +       .migrate_folio =3D buffer_migrate_folio_norefs,
>  };
>
>  const struct address_space_operations gfs2_rgrp_aops =3D {
> @@ -110,6 +111,7 @@ const struct address_space_operations gfs2_rgrp_aops =
=3D {
>         .invalidate_folio =3D block_invalidate_folio,
>         .writepages =3D gfs2_aspace_writepages,
>         .release_folio =3D gfs2_release_folio,
> +       .migrate_folio =3D buffer_migrate_folio_norefs,
>  };
>
>  /**

Thanks, I've added this to for-next.

Andreas


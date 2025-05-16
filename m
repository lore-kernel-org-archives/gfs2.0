Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6140321E097
	for <gfs2@lists.linux.dev>; Fri, 16 May 2025 21:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747432707; cv=none; b=fAW6/jOOxJPP705OVP5CVycCCnbylJKozMv6aOtxIt426TNnN1Xz5gwi1p+8NgCz3SBwSQMI1cxVcnU1kwtac+7/g9h39P84HEsZjTrc8Vm1rXYuEApjYG+OUd10dVZGcQI3giB5uMCPKFIMxGF65jrXrtpMdLDtPG+e6t4cG1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747432707; c=relaxed/simple;
	bh=+gkVO3A7u3Y0egQ2kX+0tBO4nrNxffayTnc5LB2TjUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=F5sSIaQvICwpf5jJuEYZVqLQvGUH/mNuw2htZsHAST/Rl0lKIABmX3mMJf0aRDPtCdERQP3O8YV9UqYi5tfzL8629vjfFt2I2spkfUDXcctU6kUYYeZNLRCGPjAWbUkOOYzd/VvwwuxI5AwVDe8z8cGhIzLX5hRc8QJU+wLMsXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GRm9W7bF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GRm9W7bF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747432704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SkXRr0Hm5igjev8Jz3auNGaTLBuapGUJv/L6Z9TrISs=;
	b=GRm9W7bFZiyzDQ9dRNnsBbvRp5v7vKnaZOd1gn8b6IUt5ksaCL2CpwhSYF2TmPzbYTUXi4
	hb45XpcoS7PqiBvbhyGKUj5ALtTflDNGophvLYO2t1n8KcGaBq+XGUmfXMcbHvRi9i5T6Y
	mHv4zXVYRuMHwkdY3ZURAKcywQFNjH0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-HKON4fiwMj210RT9y991nA-1; Fri, 16 May 2025 17:58:23 -0400
X-MC-Unique: HKON4fiwMj210RT9y991nA-1
X-Mimecast-MFC-AGG-ID: HKON4fiwMj210RT9y991nA_1747432702
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-22fd4e7ea48so23727145ad.3
        for <gfs2@lists.linux.dev>; Fri, 16 May 2025 14:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747432701; x=1748037501;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkXRr0Hm5igjev8Jz3auNGaTLBuapGUJv/L6Z9TrISs=;
        b=PBj2SvSoliDU8s08rjUH3lO2+XmNptJcmaDBxLKPSGdsPyV47RlLm5Uv84hyImKhrC
         UBAbmTsK4BoqexpHb5Gh2G/inuOBilktAHnINf+Qs4b2NIEAa78yotUXxlFZyXO+vUrm
         S3CWyxSosY4ehn9h+/kgOaRNX0ThiXjeAfi/XH8pfp54UkkuOnbHsFq8gPP6XgKlfL86
         ixAVw0/+BVfcppUXLkEb8s+eqmwMFAfsAnq6w6Awhi5TW1XAMhaeXWur3dKshM2Ty9bJ
         Pk9PiHLJp+taw5BHJ6tf3L/QWFDMAR1kCN/ob4DedhtTyejfk9SUmc+J88ZabhW8/w8N
         mj2w==
X-Forwarded-Encrypted: i=1; AJvYcCVlVnD7IZQbGCKpf+A43o5anj5AoGuDjRohaNVfDuUa7ii51Qw46WdYF6eJjkDm625GF1Bq@lists.linux.dev
X-Gm-Message-State: AOJu0YwlGlTS/q0e0B+PeQNjGcroG+zfmYGDxe8QKtbAZaZZjf31m3Nj
	pKlaIgA/GqM+pdkvN4d/NXAtIIDX/R9d7TeBMI4/sH+j6vzZQFOf8A9lk3RQLXmKQtYc/kbLPRr
	He8c+lUbzT3pponZ6LH4yeWoEHvCdHeIdKBfHdEry17cE6ttl7GbyZ/JKuuj+LuYxYbwvevgbei
	4fJ0Ygv7AHsedF+L4sMLy8xU4nxlHnW4Ixm56CsA==
X-Gm-Gg: ASbGncuZy1jfZgWsXXw35eeP2gHtvVDWFDljlZ/IqbQrkIgbwV1R8TZrVHs4866qKp+
	osK7SynnzVZhn8vczho8RYjhSPk+yB4fnXCCigibPrBEusQQvkWeBGiIy09AKxI64Vkc=
X-Received: by 2002:a17:902:e78b:b0:22e:4fe6:24f9 with SMTP id d9443c01a7336-231d44d8041mr63458365ad.13.1747432700754;
        Fri, 16 May 2025 14:58:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFISU2qPp/F4lfGnM9hMiUzvu3ys03EpWFZ05/PvTGkZyYwyXUsoJgNxxxmCULOsVXIuJNuJejFEafoAwAW9lM=
X-Received: by 2002:a17:902:e78b:b0:22e:4fe6:24f9 with SMTP id
 d9443c01a7336-231d44d8041mr63458245ad.13.1747432700446; Fri, 16 May 2025
 14:58:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250516214822.905056-1-agruenba@redhat.com> <20250516214822.905056-3-agruenba@redhat.com>
In-Reply-To: <20250516214822.905056-3-agruenba@redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 16 May 2025 23:58:08 +0200
X-Gm-Features: AX0GCFuoEWLqqKTZOoyWSoZjPAU5Ee_yCjcrXXvsJbe9XymBVDNo0t5FcAGLMfg
Message-ID: <CAHc6FU4XbM8AE06uWz5EsQf4J6MRZ5SDb4WLNSEagAbxwKr9DA@mail.gmail.com>
Subject: Re: [PATCH 1/3] Rename jdata_dirty_folio to gfs2_jdata_dirty_folio
To: Matthew Wilcox <willy@infradead.org>, gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DykmimN1kZz5ipSd1X2yxw0PZhYDYtTuVtI8OTZxsb0_1747432702
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hmm, please ignore this duplicate.

Thanks,
Andreas

On Fri, May 16, 2025 at 11:48=E2=80=AFPM Andreas Gruenbacher
<agruenba@redhat.com> wrote:
>
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  fs/gfs2/aops.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
> index 5be99d87bcdc..66b0ad9f1f92 100644
> --- a/fs/gfs2/aops.c
> +++ b/fs/gfs2/aops.c
> @@ -532,7 +532,7 @@ void adjust_fs_space(struct inode *inode)
>         gfs2_trans_end(sdp);
>  }
>
> -static bool jdata_dirty_folio(struct address_space *mapping,
> +static bool gfs2_jdata_dirty_folio(struct address_space *mapping,
>                 struct folio *folio)
>  {
>         if (current->journal_info)
> @@ -714,7 +714,7 @@ static const struct address_space_operations gfs2_jda=
ta_aops =3D {
>         .writepages =3D gfs2_jdata_writepages,
>         .read_folio =3D gfs2_read_folio,
>         .readahead =3D gfs2_readahead,
> -       .dirty_folio =3D jdata_dirty_folio,
> +       .dirty_folio =3D gfs2_jdata_dirty_folio,
>         .bmap =3D gfs2_bmap,
>         .migrate_folio =3D buffer_migrate_folio,
>         .invalidate_folio =3D gfs2_invalidate_folio,
> --
> 2.49.0
>


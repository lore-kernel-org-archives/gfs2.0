Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26EB1E1024
	for <gfs2@lists.linux.dev>; Fri,  1 May 2026 13:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777640947; cv=none; b=D2V83VMjGkq6v7BkLecDiQltAXy2QtR2O82sNU8dxsbzmLHlhiuDUQp1sLsEjEHvp0Licn7to70Nmw7Rha7C0+/WKI68ppKLWiLVSUVrARshcParymUhb/TA/HT4lTVDOGD/LaT3GBZISj1I1VR6El4RPngjZpnwLXtN50jlQkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777640947; c=relaxed/simple;
	bh=YVBrL72mB2J7tpsfPSBT/AswSylCTjaaLeIPiqjHqWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBZ9h6CvtL4D6wLhjKtKh/WbprZBCmcQwsV9MqYB6s/Hwmgq/MQ+Ea5Cxn4EzI9OqO37SaDeWAomDs2lmB5kJ9J2Y5nkwCmSFFiikFPrMPAOtHmshH3Vb5kMf7IqNWgnAdojgpH39QdpTNaiNaFvTgicS34/rdjZLm1iAiMl70s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DfEWp/ct; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DfEWp/ct"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777640944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/eaULyQKOyN4aY5NJm97aR1hyXCBsmSRsfBgBSEXyzE=;
	b=DfEWp/ctfTNCM7lAqQOmDCAFVywdVXLQRRTRn+RSDPgaN628vHeOJhnLR2XS0eojj9gxH+
	oHLAHoTJ/J0GkZIXWzaPCXdlb4lRdVQoMtJ+XxueWYvKPKLGgUY4G8lCQPUbXn2SEURRp4
	s1E3jMRnvYgVXULRqYFvNM2WLjxjkow=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-XMrdoOhwOrCZccNTllGKlw-1; Fri, 01 May 2026 09:09:03 -0400
X-MC-Unique: XMrdoOhwOrCZccNTllGKlw-1
X-Mimecast-MFC-AGG-ID: XMrdoOhwOrCZccNTllGKlw_1777640942
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-38bd70a386cso9657591fa.2
        for <gfs2@lists.linux.dev>; Fri, 01 May 2026 06:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777640942; x=1778245742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/eaULyQKOyN4aY5NJm97aR1hyXCBsmSRsfBgBSEXyzE=;
        b=WM240pFZ5LO8FamGod+tdosSWQ96srscdjzMFlYOBdJGlCigAzu+iX/bSuUjrJNXRn
         qDAqulBD2G8aqXW2/4j02YNH0EGwOgimastNJLyiA1SJ6GKtaGeMtyQY9uVz6U10PhfV
         VU0zO3j2HmpLEi/ARd6/pBf94+2ftcphGWMXmrM2V5eK4A2/+c/AIF3hx2yiOFvo63Iv
         amgz4osg4OV+PPbAEO5LqJx6TrtCE7ciH3OVodsB/0KmRgfC9ubstSnRKJavJDDkf1B7
         5ZkswZzEWIq5Kpps/gcQhsfjcmumAcP1XA7POYScvbG33tJ4qTCikf+c5Qu4awEjmSoP
         ESWA==
X-Forwarded-Encrypted: i=1; AFNElJ9Hgje8F1USnG2mJJOH7F7Vokw9uVvUKeaNOlkKXFelN22yWUN9hVqA/vGQo73/BzDoE5BS@lists.linux.dev
X-Gm-Message-State: AOJu0YxFWW78Bw24eeR5L6Ue71hQQ0fquznF21x+413Iz8EcDUu8mexA
	C7zHaSeszlGOwxzaB4ts0B8q6nF7ktIGuuL3LpVui4ZQraf8L3bTgPIIOsapbbuQZNfdlYL01Lw
	wro6w9Td2rF2fAzuISs4tDbo4X70kktpLXvKyD90a5XdmhwhSdz/YoyT35u2et0PiYGJWJGD075
	kO4GhooVUBTDLyv4BP+Yme5I4kaQ6Wew==
X-Gm-Gg: AeBDieu/hafxJ+ewmoG9ghuepXme6O7tkMxnL5doT0mFijZiI9vEPwx1Ex+mWgqfSBT
	GAMTPpfINuIc5vjQ+0NLQxDgjnR/nzG/nZchJLInOVnm9ISCBFZQrGMD5cY3ispNsyATyo8eSPk
	OljBViKXIUcrnWPKnmKlzfgPdkR4HALfwJC3PgDwg/O0KHDzEyloaKHjF2S1Sks7V1m3u+X9pFa
	ZcxVGoN0Hs0JPwcT6Mv7BBW2K4DIjxMW57PxiW59YzVTrGG9F8=
X-Received: by 2002:a05:651c:1582:b0:38c:63df:82a2 with SMTP id 38308e7fff4ca-39364451309mr9484601fa.27.1777640941815;
        Fri, 01 May 2026 06:09:01 -0700 (PDT)
X-Received: by 2002:a05:651c:1582:b0:38c:63df:82a2 with SMTP id
 38308e7fff4ca-39364451309mr9484451fa.27.1777640941324; Fri, 01 May 2026
 06:09:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260429081516.566812-1-alessandro.zanni87@gmail.com>
In-Reply-To: <20260429081516.566812-1-alessandro.zanni87@gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 1 May 2026 09:08:49 -0400
X-Gm-Features: AVHnY4ITuZuAUVGJMG-9gg7xUhoIjbV5ak94ndVXeby8IoUMWTo2T79kj4Ty8yI
Message-ID: <CAK-6q+hi2NyK3W17Yn_VBrtvBXdPkuOtj0q+tNA-xxqZTwwnZA@mail.gmail.com>
Subject: Re: [PATCH] fs: gfs2: fix sleeping function called from invalid context
To: Alessandro Zanni <alessandro.zanni87@gmail.com>
Cc: agruenba@redhat.com, linux-kernel@vger.kernel.org, gfs2@lists.linux.dev, 
	syzbot+642d0561f78362d67d3f@syzkaller.appspotmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gR1ETqbtYZRDcemBZbs7nWwi3sKXthrTFfEG-rCgyHs_1777640942
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 29, 2026 at 4:21=E2=80=AFAM Alessandro Zanni
<alessandro.zanni87@gmail.com> wrote:
>
> The issue arises on a PREEMPT kernel because gfs2_quota_init
> calls gfs2_qd_search_bucket while holding a bit spinlock and
> triggering a "sleeping function called from invalid context"
> bug.
>
> This patch refactors the quota initialization by splitting the
> lock into separate locks, moving the search outside the atomic
> section and using RCU lock for a safe access without holding the
> bit spinlock.
>
> Modifications of this patch:
> 1. Use rcu_read_lock() around the invocation of the function
>    gfs2_qd_search_bucket() for the search.
> 2. Add the spin_lock() around the insertion into the hash table
>    and lists.
> 3. Remove the usage of unused spin_unlock().
>
> Fixes: de0d95c26c41c ("gfs2: Check quota consistency on mount")
> Reported-by: syzbot+642d0561f78362d67d3f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D642d0561f78362d67d3f
> Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> ---
>  fs/gfs2/quota.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> index 5290865f27f1..48516cbc8b49 100644
> --- a/fs/gfs2/quota.c
> +++ b/fs/gfs2/quota.c
> @@ -1456,17 +1456,15 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
>                         qd->qd_slot =3D slot;
>                         qd->qd_slot_ref =3D 1;
>
> -                       spin_lock(&qd_lock);
> -                       spin_lock_bucket(hash);
> +                       rcu_read_lock();
>                         old_qd =3D gfs2_qd_search_bucket(hash, sdp, qc_id=
);
> +                       rcu_read_unlock();

As far as I'm aware, the RCU lock critical section can't sleep either.
So this fix seems incorrect if "gfs2_qd_search_bucket" can sleep.

- Alex


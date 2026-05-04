Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E30390C9A
	for <gfs2@lists.linux.dev>; Mon,  4 May 2026 11:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777894048; cv=none; b=aWMD8mLgbc7g7c/3yH+9CZWROgM7vJXeZKRK44Llm0VsPpSoWJFC5PLE5n1giVJCUjUBgg4A6k3H9uM0dPeFqUzWY2O1bYIN2qE0M8KsM19FvEVUNoX0zIfhAKBSdTPXiOevJlwqY+848OmYUoZCuRD/W5gD3dM9edx5pLw6shk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777894048; c=relaxed/simple;
	bh=ZzRT6KN0mD49OVCdVUrO4vvY8hzKiPwpbbpYIQzYXwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sMeBHicBI6lD3qh4wzGZ98sJI6cBnZCMjQGPHDNJcKySrH+9/kg/dsHRx3lshyzOqKgm+HydGIDA3c6YQAVOi6eMoaTrLdT2zm6JmGfi4W3FXBOZ2yNkWYhsmJTHr93jDDb58O1n/NItXdsYoaLenMREfzxRHoCfo3gQbGR8S6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MhJujd87; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MhJujd87"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777894046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2mWU0mQg4yOJTtHe2fXt8bSPg22Nsbewx/KaA0WdScE=;
	b=MhJujd87/fmval1lvkO8889oMpnKTftU997+j1oYiDA+YLGIqi77SyPOSGBeQN5RsofQHe
	+AStY03Fl31IRK/26Gt3Cv10zRDcohI60be03Wbo1jNvNowLETqO7wa2UYOEHRMYxvXJaJ
	Bd/iT/GfAw4cIkdn5CSXA+uhq2SGcq4=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-9EHDDhZXN6-Ef8KiYy2GxQ-1; Mon, 04 May 2026 07:27:25 -0400
X-MC-Unique: 9EHDDhZXN6-Ef8KiYy2GxQ-1
X-Mimecast-MFC-AGG-ID: 9EHDDhZXN6-Ef8KiYy2GxQ_1777894044
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7bd8cff196fso12255547b3.0
        for <gfs2@lists.linux.dev>; Mon, 04 May 2026 04:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777894044; x=1778498844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2mWU0mQg4yOJTtHe2fXt8bSPg22Nsbewx/KaA0WdScE=;
        b=X9M7oNLuPvgBxRTKVFN9FwQ1jYY5a3wgwkA/64Mh+1Vm5qGAPzCtgPiIgXnM0BSlI5
         PQhm+HAhyDuSQ2bQbHxO4lDJqVofHK1lvPmPCKdndMqE1Sqtv7Zvd7NV8G1iBgKLiPBG
         j+DyrgZJ0rvSMebjhOLSEhwU6od/W3K/OobhYXR5O2Q254TCl3HILvxfl5JU+G2cLmM9
         wMH9ri1dtjvaapDjI92FBmVHct0ZMwJdp47DYFq1biPyKFvlGXydd6xmWGBIOgDVN9aa
         ag5Z6enjrh9TQ5vchRvbRqhytIBmgIH4e3ci8Gu1gAmtWhaP7po/J8PUcgJiveY9P+NA
         JxOg==
X-Forwarded-Encrypted: i=1; AFNElJ/hfQ7Bn/4Ybf6yHbLgT/ClEuBVMD0ipKrSqN/tV7KNICoA5LXTigPoO/DgDnn9eDO5TYLX@lists.linux.dev
X-Gm-Message-State: AOJu0YzC6323xHQUd7Bd22TY4zS+LjcguTt/lCI6SakngFA72/u1FYbT
	0lLPab0kTC3UkDNtZxV2tDMjMUBP/MFaUD+dsdPk1DWI0ZX3DtjyOFH5qsIx5sZSo8ZsjxTVEYP
	vml2sYM3hQH4ZY0Z+iUUzjjMn1GvUl8/hT/knqe0vTPK+kmz5OCWvs44B6sV5YuIwlyOUcRVb1F
	i0kRHzIVMVAVq0dV5x4IdOer8D9I8I/Q==
X-Gm-Gg: AeBDieuUcfVqwDAYkGbIOAvfKuMJK2yf345mTEcmxQqzJZptveJnBSN8O2GnSb6+ZEX
	mzGiYoZ0KD+6z4p12+allOf8MkbTJdtzo/MvkzUqMVcDxYA2q9qjTOb7GXniWzdDNCLz3z4nAek
	jjgDYoqY7ANfwlf5xtK3RShiaaZU2fbQIhIlla1lghXF8xwISdbmdqP4yJYBwoGoZ8uHrcov+JI
	z7iApvTb3uYsZ+cpJKWfu/9f/Jlv4OwOCp5cstJjgaGjuxHy67O04d/3rU77a6RrZz8q0ywTcbz
X-Received: by 2002:a05:690c:c50a:b0:7bd:7b2e:f08d with SMTP id 00721157ae682-7bd7b2ef198mr80276617b3.12.1777894044407;
        Mon, 04 May 2026 04:27:24 -0700 (PDT)
X-Received: by 2002:a05:690c:c50a:b0:7bd:7b2e:f08d with SMTP id
 00721157ae682-7bd7b2ef198mr80276357b3.12.1777894043956; Mon, 04 May 2026
 04:27:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260429081516.566812-1-alessandro.zanni87@gmail.com>
In-Reply-To: <20260429081516.566812-1-alessandro.zanni87@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 4 May 2026 13:27:12 +0200
X-Gm-Features: AVHnY4IS0QsPmqK52JKBKZwLI124pIC32bJM_7ETHS-KUQyndn39J_blDiSshq0
Message-ID: <CAHc6FU7ciE1yUDxM0RaksAEHf8S1msBGxN0qcmSy+Z7kBjyQPw@mail.gmail.com>
Subject: Re: [PATCH] fs: gfs2: fix sleeping function called from invalid context
To: Alessandro Zanni <alessandro.zanni87@gmail.com>
Cc: linux-kernel@vger.kernel.org, gfs2@lists.linux.dev, 
	syzbot+642d0561f78362d67d3f@syzkaller.appspotmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Iw_8Iis4nYfZTU7Cyt0t7WzdWfYZEgZJUwfXC83W71Y_1777894044
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Alessandro,

On Wed, Apr 29, 2026 at 10:15=E2=80=AFAM Alessandro Zanni
<alessandro.zanni87@gmail.com> wrote:
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

How is this better than Jie Wang's fix from April 23?

https://lore.kernel.org/gfs2/CAHc6FU7DLZrunqxQkY35voRraBxUG=3DwNucn_3s7LqF1=
BdrxzCg@mail.gmail.com/T/#m37764558ab05e4166ad27abf85576cd67957cbfb

I've had Jie Wang's fix applied already, and I've now also updated for-next=
.

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
>                         if (old_qd) {
>                                 fs_err(sdp, "Corruption found in quota_ch=
ange%u"
>                                             "file: duplicate identifier i=
n "
>                                             "slot %u\n",
>                                             sdp->sd_jdesc->jd_jid, slot);
>
> -                               spin_unlock_bucket(hash);
> -                               spin_unlock(&qd_lock);
>                                 qd_put(old_qd);
>
>                                 gfs2_glock_put(qd->qd_gl);
> @@ -1480,6 +1478,8 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
>
>                                 continue;
>                         }
> +                       spin_lock(&qd_lock);
> +                       spin_lock_bucket(hash);
>                         BUG_ON(test_and_set_bit(slot, sdp->sd_quota_bitma=
p));
>                         list_add(&qd->qd_list, &sdp->sd_quota_list);
>                         atomic_inc(&sdp->sd_quota_count);
> --
> 2.47.3
>

Thanks,
Andreas


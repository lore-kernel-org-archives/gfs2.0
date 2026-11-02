Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793644955;
	b=ksayW2HefUcG6X+RgGJjzcSXp6QwEQ9ELRLfMYxv2A8C0Gq51uFAhrHOCfcXKPMQVYew
	 6v/fkHGXYPBeNu1Ok1Xm4QOXgpNfXXTGn8JpWM3ywaNSFI62rRwIOBw4FBfcOxJDmCP8P
	 XiDuFyrEBYTNwwJfbNEJrQKweu+SahIT/YUJWnNgRz1uI/Ssokuoy+VhFc+slgSsriuqM
	 YlsWUYgy1C1Dif/FdaP67wKArbWqZLkJfsNXnfNfbHcZGBP9kfi78OAIuNE5JeWUOGPGr
	 wob7nQE6UNvWvhL+nVBzgSVQTA40Pg6RG0Vycb90QstSMAg/8njuDk8Vuc4pZENRiyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793644955;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=OffO7dkB7rQHK4T1MzrGHUKDeBIQijFGky1S3tl0aq8=;
	b=mWfwDMfhabXXQBsDMkhAPcj4+sTu+pdYl/xzi2rKv3dCcf+/XoIRB6fIUvB5mE2L7NKa
	 WzHnn2JW5QDo23EcsjKaNT6krpc/jOOrO000aQBkURKdbqptzRWYtZHPxaYubxy+cXvKU
	 bgc/mXfTFRnp1Xxu2uCq4AGR35uzDLN4Ty7oZEC2fDbPNa8VLTaKDW5ag65b7Ro1YC3PV
	 GvHI9IxYCXpWjFw0TDPzw6ltKafgakY377vvG6PgPIh6jM6dxW7Iy0fuc4fRJcz32iXiH
	 xWUt1/Koc4bRxPMWg+m1gL10vjG3SM1zLa+rls9tg79xSkVLB7B4n/QSDzIifsmPQYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="PZGyzn/K";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C408B606A329
	for <gfs2@lists.linux.dev>; Mon,  2 Nov 2026 18:42:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C408B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PZGyzn/K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793644953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OffO7dkB7rQHK4T1MzrGHUKDeBIQijFGky1S3tl0aq8=;
	b=PZGyzn/KBHVS4aPsoksU/XScXNomYE7vxIt3D07QTR9FeuOJ7MF+sAFQHBo6tW+NVaeQ0p
	f+jqdvYDH59Ow1cF785D1Uk6ELRGqlI7w8fZCDKP8DSwQCE+Y7v4+pTgmExHgfGCncmVc5
	wnkJFDeiFUfj6dl2t/Pm/nilBa5mj48=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-geKnK1zxP4y8YSg2VAhLFw-1; Mon, 02 Nov 2026 13:42:32 -0500
X-MC-Unique: geKnK1zxP4y8YSg2VAhLFw-1
X-Mimecast-MFC-AGG-ID: geKnK1zxP4y8YSg2VAhLFw_1793644951
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-3ac60f010ddso15143041fa.2
        for <gfs2@lists.linux.dev>; Mon, 02 Nov 2026 10:42:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793644951; x=1794249751;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OffO7dkB7rQHK4T1MzrGHUKDeBIQijFGky1S3tl0aq8=;
        b=M7NJ4ldo+9o7oUaYRfjqKFwdjSHXFXPGM1KU0Nc06IqGAuPbk+fWUyKElQu53xuel2
         tzgNmCWOT3ZeVoRvELHZONhHSWZRtwNOk2C3zEVIeUAXtu6UZePpCtGvJsl2omlYAt1C
         DCNRnuS13FUP8zurxNyNm8hinAVFJa6J812f/OJ1dLmKnyCNzwvN2bDoW1VzfYbNlfvN
         Z1M6wcJ/2NSo/IHJkW6hkuPsHKqtW3kbPC6JcYpIJtXYYBMmEkporDxTy+q+b9uVFrzJ
         VGJKq4S+CH8sSlnjM+72BEIG2ZqpwiOBZQXMhf0hnyOFkrDnkpMYzJGdC9YjCzoTqlL1
         D3bQ==
X-Forwarded-Encrypted: i=1; AKwUvByjxbzABDHWdQ4nw9gp2XY6Ss0F21bQutztYYQE7iWCILfeQijrU6Zo7UfJeilCzPY1nh5S@lists.linux.dev
X-Gm-Message-State: APuU4Z8uu3kFHmd4qxIhk7rByFUMWbJLbdMMyzE9F742lO02qFpAvmK3
	wPKQzqcM+w6JusuQQhR/Uf8/WhAI1d2Kts7PUptEruO6ut31ksbGSirnPaoHkutH5vDJkpgUJR8
	8Mz3revxLT+I487NQ2uKbwpTm1RjgoDmZkoy/SODI81x54cpqiQKlxREQGGf7wS47tJ5J+t2+p3
	97UzbEUtICenC77MFYHNQVmPT1Z252KQ==
X-Gm-Gg: AYBFou2I1i/NbIHcQopU14aoYku6fTHDzbbXAq5dpdLPvrLY5MKhaQheeZDM0eHN1Ed
	IxpDP8bOYoudfRp3ERm280MtMQ74wGsQyPn8iXvjeg5TICo090x/N5HMKw4o9FCU2EfiLXDiNbq
	yt6/60L4VvYuSB5WWyXX+eV0y2KMpO1LiGzlW+7SrfuQ3mAWglGsBKVHWl
X-Received: by 2002:a05:651c:31cb:b0:3ab:690f:829f with SMTP id 38308e7fff4ca-3acb7a634ebmr23219801fa.15.1793644950910;
        Mon, 02 Nov 2026 10:42:30 -0800 (PST)
X-Received: by 2002:a05:651c:31cb:b0:3ab:690f:829f with SMTP id
 38308e7fff4ca-3acb7a634ebmr23219771fa.15.1793644950503; Mon, 02 Nov 2026
 10:42:30 -0800 (PST)
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261004051912.1045-1-yogeshgaur.83@gmail.com/> <20261007113155.1982-1-yogeshgaur.83@gmail.com>
In-Reply-To: <20261007113155.1982-1-yogeshgaur.83@gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 2 Nov 2026 13:42:18 -0500
X-Gm-Features: AclHuK8rBGB5wbaRzCDWzUOnSPFNBECgyTWFrxDUcXK4DB8L9ZuxuP_bS5Bz1no
Message-ID: <CAK-6q+gXQgw8s4PAuR-FR=TscwC-OMwL+XVaeiWBVPgk3JV51Q@mail.gmail.com>
Subject: Re: [PATCH v3] dlm: don't publish a lkb in ls_lkbxa before it has an rsb
To: Yogesh Gaur <yogeshgaur.83@gmail.com>
Cc: David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+da6dc573ce5e6624f505@syzkaller.appspotmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tbXc63qCBs6FZ7jz4Jhl4rZhrp-sK80LTKcUKMnOzBE_1793644951
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 7, 2026 at 7:32=E2=80=AFAM Yogesh Gaur <yogeshgaur.83@gmail.com=
> wrote:
>
> _create_lkb() puts a new lkb into ls_lkbxa straight away, which is also
> what assigns its lkb_id, but the lkb only gets an rsb later, when
> request_lock(), receive_request(), dlm_recover_master_copy() or
> dlm_debug_add_lkb() call attach_lkb(). In between, find_lkb() hands the
> lkb out with lkb_resource still NULL, and its callers go straight for
> the rsb:
>
>         r =3D lkb->lkb_resource;
>
>         hold_rsb(r);
>         lock_rsb(r);
>
> For the userspace API the lkid is simply whatever was written to the
> misc device, so a lkid can be aimed at a lkb that another thread is
> still building, and hold_rsb() reads res_flags off NULL:
>
>   BUG: KASAN: null-ptr-deref in rsb_flag fs/dlm/dlm_internal.h:386 [inlin=
e]
>   BUG: KASAN: null-ptr-deref in hold_rsb fs/dlm/lock.c:334 [inline]
>   BUG: KASAN: null-ptr-deref in unlock_lock fs/dlm/lock.c:3333 [inline]
>   BUG: KASAN: null-ptr-deref in dlm_user_unlock+0x2ab/0x690 fs/dlm/lock.c=
:5956
>   Read of size 8 at addr 0000000000000050 by task syz.3.570/7893
>    rsb_flag fs/dlm/dlm_internal.h:386 [inline]
>    hold_rsb fs/dlm/lock.c:334 [inline]
>    unlock_lock fs/dlm/lock.c:3333 [inline]
>    dlm_user_unlock+0x2ab/0x690 fs/dlm/lock.c:5956
>    device_user_unlock+0x1ca/0x260 fs/dlm/user.c:321
>
> Make it impossible for ls_lkbxa to hold a lkb without an rsb, rather
> than filtering such lkbs in find_lkb() or reserving a NULL entry that
> every walker would have to know about.  create_lkb() no longer touches
> ls_lkbxa; attach_lkb() sets lkb_resource and only then allocates the
> lkb_id and stores the lkb, so the lkb becomes visible already attached.
> dlm_debug_add_lkb() presets the id it wants and attach_lkb() allocates
> exactly that one.
>
> attach_lkb() can now fail, and each of its four callers releases the
> lkb on the error path it already has for a failure just before the
> attach.  On failure attach_lkb() also clears lkb_id, so that
> __put_lkb() cannot erase another lkb's entry when a requested id was
> busy.  All four callers hold the rsb lock, and nothing takes an rsb
> lock under ls_lkbxa_lock, so taking it there adds no new lock ordering.
>
> As a side effect an lkb has no lkb_id until it is attached, so
> trace_dlm_lock_start() and the validate_lock_args() and
> receive_rcom_lock_args() error messages report 0 for a new lock.
>
> The unchecked r =3D lkb->lkb_resource goes back to the original DLM
> import, but an untrusted lkid only became possible once the userspace
> device interface was added, so that is the tag below.
>
> Fixes: 597d0cae0f99 ("[DLM] dlm: user locks")
> Reported-by: syzbot+da6dc573ce5e6624f505@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dda6dc573ce5e6624f505
> Suggested-by: Alexander Aring <aahringo@redhat.com>
> Assisted-by: LLM
> Signed-off-by: Yogesh Gaur <yogeshgaur.83@gmail.com>
> ---
> v3: Incorporated Alexander Aring's review, don't reserve a NULL
>     entry in ls_lkbxa either.  The lkb_id is now allocated in
>     attach_lkb(), after lkb_resource is set, so ls_lkbxa only ever
>     holds attached lkbs.  attach_lkb() can fail; all four callers
>     handle it.  _create_lkb() folded into create_lkb().
> v2: https://lore.kernel.org/all/20261004051912.1045-1-yogeshgaur.83@gmail=
.com/
> v1: https://lore.kernel.org/all/20260909112108.2281-1-yogeshgaur.83@gmail=
.com/
>
> Not runtime-tested. Built with W=3D1.

I tried this, and it seems to run without problems. Although there are
questionable things like [0] as now create_lkb() does not add the lkb
to the xarray and [0] will call xa_erase() on a lkb that has not been
added if set_lock_args() fails. It probably will not harm as lkb_id 0
is invalid and never be part of the lkb xarray, so this xa_erase()
will do nothing.

I am willing to ack this patch because I think the cases where an lkb
has no rsb set have already affected us several times in the past and
it seems to be going in the right direction. We will just see what
happens.

Acked-by: Alexander Aring <aahringo@redhat.com>

- Alex

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/fs/dlm/lock.c?h=3Dv7.4-rc1#n3412


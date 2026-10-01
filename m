Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD1347255C
	for <gfs2@lists.linux.dev>; Thu,  1 Oct 2026 18:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790879601; cv=none; b=adwxcqKwR2c5dBtWQwZeOPXnagNRwcwV3ManEwY6J6PslPbVFjvt9nVz/75Zye3/iA7HZK5Z/7sKuaA3xEPlUT5t1mafwhZddG/1PyUn9pffJpaNbWK0gccpADD/oSYfHSwNZWemsx8R1oXMaEKob0pHMVKTlXSaT3pr5Rh5BZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790879601; c=relaxed/simple;
	bh=WAFsqqAFghDoay9hVBuvxqFPNBzWjsWrsZZqn50QG50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJx6jwm016LWEi8LkJw3sJ6sDisZIGmJVxaE54P+jE/30ohherGgwCd5gh1AmYX2k3DBq2qM0+bKYE77FS0Pq5A/UibgmNkJFOsrNUf0kZr0b4CqkoIph3nIi0FKFvIg7O7rjEcEOmmrkq5i4skOIGuLGuWZKpF4hDOreyL1iY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AhQQzfUH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AhQQzfUH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790879599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dsbX+3Qe5DdiwBq4QKL6zwCanz3fxbDUJiCcszo+6nQ=;
	b=AhQQzfUHQ7fNhVPFTtXnq6bQROffDdau9YQLH+y+yNkCeF9j2iVt1rVh4DIaQdO0ih/ybe
	aVoRcLY1uyG214YO2LmbM5z/z9egewa+mykMf4h+gGEB7NedRfGqnsNVwMU1PN24+eojNY
	BN4m4aCqshG2EhRBfC2y3rOPgN0iKaQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-RegxTbnGNPOXIqfQd7jYPA-1; Thu, 01 Oct 2026 14:33:17 -0400
X-MC-Unique: RegxTbnGNPOXIqfQd7jYPA-1
X-Mimecast-MFC-AGG-ID: RegxTbnGNPOXIqfQd7jYPA_1790879596
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5b14d51dae1so3505969e87.3
        for <gfs2@lists.linux.dev>; Thu, 01 Oct 2026 11:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790879596; x=1791484396;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dsbX+3Qe5DdiwBq4QKL6zwCanz3fxbDUJiCcszo+6nQ=;
        b=2qeJ5YQrEtWfSXVJcjhCLz7egOH3jfym4OMnJHus2uPV8kb/Xys7PkjM4qNRsWU1mx
         T0+oCtCywoYSLJrTDBkFEQHA79E0stDthcJiH63R69fpiBuShODppkDmg10cE+mZK5xL
         HOoP1WQwJL0SlP/H2Jgc8n0gMrEAkbfWK2RIN+rupiiAfS9CaGnvkE1nI+XkFDiHflEz
         4jb0RC7FMGa1tklrYg/xkX19fQRSQysqPPJNeaQXgJOv+B6Q9406lRBsBPKSeO2druyW
         FPyPDuHSQ5A5kTYgcWvOtdWYG7kdjDqDaItyn2kXbZWS5xy465dVOww+GT0h6XKIidtQ
         MYmQ==
X-Forwarded-Encrypted: i=1; AKwUvBzvr6l15U33IHV/AWJ9BoTi7aufAJxbGzxb/m/saQPh/eXqO+7Uxp/gMDCzJ2pFrfWCI6gi@lists.linux.dev
X-Gm-Message-State: AFq9FYI9NU5XpMXgVvHVtHV6yLFopCirmNvZQouJ85boMXPkhJtKN2Kr
	hTzGqmUmqq8lj8Po0KGEKJ+XwmSJjmqClUMRWVdxUgjAT1VZI+rungvFo2yArfFi9kQ6nxowLkC
	BXpdN4bd9iNt2lzlFuqmqk7Ic+aufN+YE9VTeUc2D2FrSdCDy6er/w0uIYk/Xe/DZ0au0y2IPuy
	K04uJAkkcaibVDHkJN6Vb3FSZrx7x65w==
X-Gm-Gg: AYBFou1HNChbbLy8JE069kTpYHx4He2uJPCwqEgKKB4uE4xz9EtaDyd/HGrcDL12ZuM
	Uktr3NLmI6yS4PsXViTm5C53RGOKWH5Rr4jXcPU/ShV1AeaHeTqLW99kAVH/+0H68Q51sBgTW7g
	KiXDr1yBzWj7FIimDTRUziIwBT13PKRtCmgutdHXCZ//B++icDoK+64Ed8
X-Received: by 2002:a05:6512:208c:b0:5ba:3c60:b875 with SMTP id 2adb3069b0e04-5bb9bc44e4amr11917e87.43.1790879596115;
        Thu, 01 Oct 2026 11:33:16 -0700 (PDT)
X-Received: by 2002:a05:6512:208c:b0:5ba:3c60:b875 with SMTP id
 2adb3069b0e04-5bb9bc44e4amr11906e87.43.1790879595674; Thu, 01 Oct 2026
 11:33:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260909112108.2281-1-yogeshgaur.83@gmail.com>
In-Reply-To: <20260909112108.2281-1-yogeshgaur.83@gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 1 Oct 2026 14:33:04 -0400
X-Gm-Features: AclHuK_IpbC-cQT4SPT04vLYo0uLsCMO-LZnpEw9kqK-f0pIB2awo-M9mOqBIRY
Message-ID: <CAK-6q+jbm3ctGXtJt5YRJjOdtrVTH5gxZ4pXtD+O9fp65AXu8A@mail.gmail.com>
Subject: Re: [PATCH] dlm: don't return a lkb that has no rsb from find_lkb()
To: Yogesh Gaur <yogeshgaur.83@gmail.com>
Cc: David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+da6dc573ce5e6624f505@syzkaller.appspotmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _Opm-cSuE2Wm6J8BFymwglCgse51dzwRMyPS64MYpX8_1790879596
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 9, 2026 at 7:21=E2=80=AFAM Yogesh Gaur <yogeshgaur.83@gmail.com=
> wrote:
>
> _create_lkb() publishes a new lkb in ls_lkbxa, which is what assigns its
> lkb_id:
>
>         rv =3D xa_alloc(&ls->ls_lkbxa, &lkb->lkb_id, lkb, limit, GFP_ATOM=
IC);
>
> but the lkb only gets an rsb later, once request_lock() has resolved the
> resource name and calls attach_lkb():
>
>         static void attach_lkb(struct dlm_rsb *r, struct dlm_lkb *lkb)
>         {
>                 hold_rsb(r);
>                 lkb->lkb_resource =3D r;
>         }
>
> So between those two points the lkb is fully addressable by its lkb_id
> while lkb_resource is still NULL. find_lkb() will hand it out, and its
> callers all go straight for the rsb without checking:
>
>         r =3D lkb->lkb_resource;
>
>         hold_rsb(r);
>         lock_rsb(r);
>
> For the userspace API the lkid is simply whatever was written to the
> misc device, so a lkid can be aimed at a lkb that is still being built
> by another thread. hold_rsb() then reads res_flags off NULL:
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
>    device_write+0x905/0xed0 fs/dlm/user.c:590
>
> Reject an unattached lkb in find_lkb() rather than in each caller. Every
> find_lkb() caller dereferences lkb->lkb_resource -- convert_lock(),
> unlock_lock() and cancel_lock() through the r =3D lkb->lkb_resource above=
,
> dlm_recover_process_copy() the same way, add_to_waiters() via
> lkb->lkb_resource->res_ls -- so none of them wants a half-built lkb, and
> a lkb without an rsb is not a lock anyone outside can name yet. Callers
> already handle find_lkb() failing.
>
> Testing lkb_resource under ls_lkbxa_lock next to the existing kref_read()
> check is enough. The value is not stable under that lock, as attach_lkb()
> does not take it, but it does not need to be: once a non-NULL rsb has
> been observed it stays attached for the life of the reference taken here,
> because detach_lkb() only runs from __put_lkb() on the last reference.
> Observing NULL while attach_lkb() races is the case being rejected, and
> the thread still inside request_lock() has not returned the lkid to
> anyone at that point.
>
> This is the null-ptr-deref only. The refcount warning syzbot reports in
> dlm_user_request() itself, where hold_lkb() runs on a lkb whose count
> already reached zero, is a separate race on an lkb that is past
> attach_lkb() and is not addressed here.
>
> The unchecked r =3D lkb->lkb_resource goes back to the original DLM
> import, but an untrusted lkid only became possible once the userspace
> device interface was added, so that is the tag below.

I agree that the one design flaws of DLM is actually to have lkbs
around that does not have rsbs (lkb->lkb_resource) set, which makes
troubel all over the place if somebody forgets about this case...

It should not be possible to have lkbs around, e.g., in xarray of
"ls->ls_lkbxa" and the rsb is not set, however this is not what your
patch is doing. Your patch is simply to not return a lkb when there is
no lkb->lkb_resource set. It seems we can run into this case as the
above KASAN syzbot shows, although I am worried about cases where we
know it is not set and we handle it.
I would more suggest changing the patch so that it's impossible to
have lkbs around without an rsb being set.

- Alex


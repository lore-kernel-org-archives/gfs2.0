Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795459552;
	b=BYyZb9bF4+0H+Ol5aIaifYKUbyW1OThFFKlWT1mfatHC4nh9CEeqKRpkF0hlKxmP4gGT
	 HBkh9hsgjH2MsUtq8b4LWtp3N1bICqYqA9WPNza8NU07AA+cw+wx5fRDA/x/r5oxZdwNj
	 XDf/MWgjDFafjtPjjUlhFpjia0hQ1VF1JoQTawB3P0HQhNy2URkhUxla/ICajKOORNGFK
	 n/KAa3LfqMyfxPmhsGvDUdS+5xNFAvw/F/0w+ecLBQOShWZLGYguTCFvRQmhKEI3RAMrM
	 XK76cXmpxLDZMJH48gDN1ocRSLVfjCwr12/oSILGVZrAWc7YrAcASbveyKuTB2/s/cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795459552;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=yLz31rzEEz8B8LvaagkLUBNRVU/PkTTsvaMuzc+APJg=;
	b=zf/u8tU0H9K0XrQ79yCELGG84pvz5An+RYHRWmZICs5S39smd10YzE2aNkekRE1gmVVG
	 lZE/3H6kUpTtOKnzUk0nL8X4tVUuFCXNpzjsJid9axvDplhfATH5LjobP7vk6CkHqYNn5
	 wXb+VT+rq4C0HgxtQeRkScyeITrb0tIDICO/Cl//i1zRYq2YWYaF71rWHL2LUmi2uiJOM
	 H3iabWZwsH35ur8zx7Ek8RZ1PEuq8QlLuIVdKcjYsn7JEYKW48FKixkw39ujJNv8ojGvW
	 Jn8EoV3X3WcOoN6YD3OWtCE6for3JOqOWqfnSc2ElA5tR5C6oyfoWJSBgML3djyBrCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EI1bNRSp;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F366606A31E
	for <gfs2@lists.linux.dev>; Mon, 23 Nov 2026 18:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F366606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EI1bNRSp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795459550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yLz31rzEEz8B8LvaagkLUBNRVU/PkTTsvaMuzc+APJg=;
	b=EI1bNRSpbfBP/NRB22tzFT0EeUzNG54NGxSI4E113oTdQHoBZdBSrCh8w3gW9YyXtpWWQI
	MxwLG892zUDZo3+P/z1xdhpRB5amLq0JXgF+V2joMDGKQ4XMkvTKJf1ceIQdCv4l2+d/8i
	9EYJeUEfgEq+O/rQgllfe76uhesQhfc=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-uJC3nnPuOJur9TraWs6xbg-1; Mon, 23 Nov 2026 18:45:48 +0000
X-MC-Unique: uJC3nnPuOJur9TraWs6xbg-1
X-Mimecast-MFC-AGG-ID: uJC3nnPuOJur9TraWs6xbg_1795459548
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30bcb065bfdso4054751eec.0
        for <gfs2@lists.linux.dev>; Mon, 23 Nov 2026 10:45:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795459547; x=1796064347;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yLz31rzEEz8B8LvaagkLUBNRVU/PkTTsvaMuzc+APJg=;
        b=ws7N2/lZfhNQjLjWFvfWs6TESNq0kFv3hSoBXdlW+w3cH8+uYHC+6kBbDivmp8bLtN
         zs2LGOSSWb0Vl/tuK8DvKrUfx6ggM9I3CK/hER/55XNwcCCI9R2k6wm4Ceh/j7hQHyZ+
         KyZyeGieBrYdZcXWQntFa9AW7xzl4OzqAOQP4LtLPtLV2NGDIBHKpmVIjC6ugbGPig/k
         u7XOIWiue2g6Y0qTnmNnKWoJZE+sRR93adPYpiNTZP5fsKUzJQabwOx6tZxYFjHXSdGD
         27CgsjOr2Iua41noFjobuxMhLER2U1fd6yS3mFF+efjGDFrkoL6o1E6/tRMPb4jwp50/
         uoRg==
X-Forwarded-Encrypted: i=1; AL+hErE6JhwRi1myTkHPjTE279ULvdScbTdq7TDrxqZozc6liRqpJi4t6RzxzrS7j7R3Uis/3VQw@lists.linux.dev
X-Gm-Message-State: APuU4Z828lDBLAFPPVHK2plure7PvhX48TWEr5VxIPWKHmwsKGDGtcxb
	5zinkHdY4nXyFxp/ump+f4I5YD7u7R+1Xbw1zo+bvv1kKleKdFwFQ5+l5D1ZsK0xLhU+a+VvBYm
	1l0oxdRwPe4ydqAhNu815cfmEPVY5iIjJx/j2hV7CC9VV6XghvoEQ3akXI62WqIhNd5QLatkoX3
	0E3BmO3ekPzS9GsbY2E23C2PsfkVsdkg==
X-Gm-Gg: AZFdTZcPiQoh2YrFIePFbuk6+ZYAWYU6WnM2FYqdBqPcRo5j9RdDI8tWqmiPN6yCLBj
	U8TjwHQnYTWOQaUjtxLliH4yf73Y0K804unk00omsdO2JWJX0i+ECZmrYdQSLP+EQVHLJpCYRSa
	gRyRpTdA2yVLezxc69l95EzKAL07ZmGEmBLmMs6PTjEwAaf0rMDLdafI2g
X-Received: by 2002:a05:7300:bf10:b0:376:b957:bfb with SMTP id 5a478bee46e88-3856f7563b1mr16030783eec.17.1795459547465;
        Mon, 23 Nov 2026 10:45:47 -0800 (PST)
X-Received: by 2002:a05:7300:bf10:b0:376:b957:bfb with SMTP id
 5a478bee46e88-3856f7563b1mr16030747eec.17.1795459546910; Mon, 23 Nov 2026
 10:45:46 -0800 (PST)
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261120200040.257152-1-aahringo@redhat.com> <20261120200040.257152-4-aahringo@redhat.com>
 <sashiko-outbox-226014@kernel.org>
In-Reply-To: <sashiko-outbox-226014@kernel.org>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 23 Nov 2026 13:45:32 -0500
X-Gm-Features: Aa3M54q5RFylsWib9aLOt62IDwRHbAyAXpdaAKRwedV-GMP5_zeZT8TffKwDAYI
Message-ID: <CAK-6q+gC1kjNi+toH5pJHtMVRM6hRY2u9bpYrNu_ARQ=hboV3A@mail.gmail.com>
Subject: Re: [PATCHv2 RESEND v7.4-rc3 3/5] dlm: don't publish a lkb in
 ls_lkbxa before it has an rsb
To: sashiko-reviews@lists.linux.dev
Cc: teigland@redhat.com, gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Gse4-XOmT08heg-riMAk12_c0gZUu2DsJH-Lf3SGTqk_1795459548
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 20, 2026 at 3:19=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] dlm: __put_lkb() erases active ls_lkbxa entry on find_rsb()
>   failure
> --
>
> commit c68d5fa6b30984a97220ff35d349c3276a988660
> Author: Yogesh Gaur <yogeshgaur.83@gmail.com>
>
> dlm: don't publish a lkb in ls_lkbxa before it has an rsb
>
> This commit moves the allocation of lkb_id and insertion of the lkb into
> ls_lkbxa from create_lkb() to attach_lkb() so that find_lkb() never retur=
ns
> an lkb with a NULL lkb_resource.
>
> > diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
> > index c715e171bab7e..3b3e15157f4c9 100644
> > --- a/fs/dlm/lock.c
> > +++ b/fs/dlm/lock.c
>
> [ ... ]
>
> > @@ -6300,12 +6324,14 @@ int dlm_debug_add_lkb(struct dlm_ls *ls, uint32=
_t lkb_id, char *name, int len,
> >       if (!lksb)
> >               return -ENOMEM;
> >
> > -     error =3D _create_lkb(ls, &lkb, lkb_id, lkb_id + 1);
> > +     error =3D create_lkb(ls, &lkb);
> >       if (error) {
> >               kfree(lksb);
> >               return error;
> >       }
> >
> > +     lkb->lkb_id =3D lkb_id;
> > +
> >       dlm_set_dflags_val(lkb, lkb_dflags);
> >       lkb->lkb_nodeid =3D lkb_nodeid;
> >       lkb->lkb_lksb =3D lksb;
> > @@ -6321,7 +6347,15 @@ int dlm_debug_add_lkb(struct dlm_ls *ls, uint32_=
t lkb_id, char *name, int len,
> >       }
>
> [Severity: Medium]
> Can setting lkb->lkb_id before find_rsb() cause __put_lkb() to erase an
> existing lkb's entry in ls_lkbxa if find_rsb() fails?
>
> attach_lkb() clears lkb->lkb_id on failure for that reason, but if
> find_rsb() fails first (for example, with -EINVAL when len >
> DLM_RESNAME_MAXLEN), dlm_debug_add_lkb() calls __put_lkb(ls, lkb) while
> lkb->lkb_id still holds the caller-supplied id, and xa_erase() removes an=
y
> live lkb already occupying that id from ls_lkbxa.  Setting lkb->lkb_id
> right before attach_lkb() would avoid this.
>

although it is just a debugging feature and the user (root) needs to
know what its doing as it can break a lot of things in a invalid
production use case, yes it might be better to move that before
attach_lkb().

- Alex


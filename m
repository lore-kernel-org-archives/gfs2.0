Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61E3208A4
	for <gfs2@lists.linux.dev>; Thu,  2 Nov 2023 18:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmMNVxis"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698948497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mT/QKLXZjSOEAM1VYfv/o6aKp5qA5CCeOOYUiFipnBs=;
	b=UmMNVxisd2v97ifRuzXDtpR1kZ6MvY9FQVWyjTOk4nxHHC5m98ef7mW6GW6qug2w8flih4
	7xemD0JPr505Es7Qw9Wt2zLbVfpViV/bQiv44UVWEm9pfu7KUNXgP0nYl7uqnKA/C5vtx+
	a/BHAOhv5CsXUcBEcbkXylCMTF1xRC4=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-HjKDIy44OUK0HT3u7oF5XQ-1; Thu, 02 Nov 2023 14:08:15 -0400
X-MC-Unique: HjKDIy44OUK0HT3u7oF5XQ-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-573fdb618eeso997606a12.0
        for <gfs2@lists.linux.dev>; Thu, 02 Nov 2023 11:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698948494; x=1699553294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mT/QKLXZjSOEAM1VYfv/o6aKp5qA5CCeOOYUiFipnBs=;
        b=FBOMwhXh3dSM19lj6QjC9lwJgtxLxEUikUNK7AyRPdjFV2w+KrLBfeyCbOijfRuZTo
         HTVtSFsBh/t3GrlNyyyIhNSqFnsaQnlnoJPr1rEW3lCy6qrvzmGU42rbA0jChHRvgyPY
         MYgn56sM+X/5DqACPihtUBwnQYLm2UfFLHKVvtL/YhXWDrLsVWZcOy2/j9vD01r8KEba
         yRXNnpGJYjSVU1Xs+AvPktlXUu792rVNerTQGN61YUeURh9OQxSEAqw9gUYTSXqpFyP2
         PWD1CXN+wI0dxc/Cl0sFNXvZO15eppdJ/m8SQnT2bZdePjWEYDZs++g1bg8/9DPKosmM
         Oi7w==
X-Gm-Message-State: AOJu0YzncECJiPz+U8lD7gPcapiFKbOx4LKlfUCrbDLDEN0NE6KKy+WD
	ECVEEB8j/nXnQmz3uOlLfpGT+hSd+mZ1PF0wzVeNt8jHndjkmHz9GgfapgDIVbn3ppmvwWhZ6Jh
	vr+RsZNcEjyVhMGxoi67yfDIaWtA82Q==
X-Received: by 2002:a17:902:f1d2:b0:1cc:2575:db14 with SMTP id e18-20020a170902f1d200b001cc2575db14mr15432461plc.60.1698948494738;
        Thu, 02 Nov 2023 11:08:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHKEeKnyHWJcu/Ef+N7Hwry4yNNHx0oi4RigFp/cgDJAuRNxqGaXSUYwwPdjVf6VnCiJOdHePWbrTmRh11/xI=
X-Received: by 2002:a17:902:f1d2:b0:1cc:2575:db14 with SMTP id
 e18-20020a170902f1d200b001cc2575db14mr15432444plc.60.1698948494381; Thu, 02
 Nov 2023 11:08:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231101164615.1138692-1-agruenba@redhat.com> <20231101164615.1138692-11-agruenba@redhat.com>
 <c512895f-5d97-4227-9885-6948f5bbbe9b@redhat.com> <CAHc6FU4Tz-M7uYaKy3vw9ycrqOiS6B_cHys0=txNvTHc3P+JZg@mail.gmail.com>
 <9831e5bf-ee77-480e-98a6-68a852911ab2@redhat.com>
In-Reply-To: <9831e5bf-ee77-480e-98a6-68a852911ab2@redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 2 Nov 2023 19:08:02 +0100
Message-ID: <CAHc6FU4-yzaQOGGVj5G5CZmPV=hh9mk3YpdJgpWReW54VTioww@mail.gmail.com>
Subject: Re: [PATCH 10/25] gfs2: Two quota=account mode fixes
To: Bob Peterson <rpeterso@redhat.com>
Cc: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bob,

On Thu, Nov 2, 2023 at 2:14=E2=80=AFPM Bob Peterson <rpeterso@redhat.com> w=
rote:
> On 11/1/23 5:06 PM, Andreas Gruenbacher wrote:
> > Hi Bob,
> >
> > On Wed, Nov 1, 2023 at 7:19=E2=80=AFPM Bob Peterson <rpeterso@redhat.co=
m> wrote:
> >> This doesn't look right. I purposely avoided coding my patch as you di=
d
> >> in this patch because it breaks -o quota=3Daccount. I admit I don't kn=
ow
> >> much about "quota=3Daccount" but it's coded into gfs2 and this patch
> >> changes its behavior.
> >>
> >> The way I coded it says to return if not "on" or "quiet".
> >> With this patch it returns with "off", which means it proceeds with
> >> "on," "quiet," or "account."
> >
> > you've said exactly this in a related conversation, and my response was=
:
> >
> >> According to the documentation, the "quota=3Daccount" mode is supposed
> >> to do the quota accounting while skipping the warning and enforcement
> >> logic. How is it supposed to do that when it bails out of gfs2_quota_c=
hange()
> >> immediately? And gfs2_quota_change() depends on gfs2_quota_hold()
> >> being called first, often through gfs2_quota_lock_check() gfs2_quota_l=
ock(), no?
> >> So at best, the way you've coded this leaves "quota=3Daccount" mode br=
oken,
> >> but the code actually makes no sense.
> >
> > So how do you think this breaks quota=3Daccount mode?
> >
> > Thanks,
> > Andreas
> >
> Hi Andreas,
>
> I did not see your earlier response, (which is odd) so thanks for
> including it. The important thing is:
>
> Your patch changes the behavior of quota=3Daccount from today's gfs2 code
> and should therefore be treated as separate.
>
> My recent gfs2 quota patches were all bug fixes or cleanups, plus adding
> the new quota=3Dquiet option. None intentionally affected behavior.
>
> If it's true that quota=3Daccount is broken today, we should probably do =
a
> thorough investigation of how it's supposed to work, because I suspect
> it may very well be broken elsewhere as well.
>
> The gfs2 quota code is really ugly and hard to understand, so changes in
> current behavior are scary at best. It sounds like your patch will at
> least improve it, but I have not looked into it. I'm just wary about
> adding patches that change behavior without "my" fully understanding the
> consequences. And I don't have time to investigate it thoroughly.
>
> As I said, I don't know much about quota=3Daccount. I've never used it,
> nor do any of my tests use it. Maybe the patch should be included in a
> group of patches designed explicitly to fix quota=3Daccount?
> And maybe we should add new testing for it.

I'm inclined to add the following functionality-preserving change for
clarity, but other than that, this seems to fix the implementation of
quota=3Daccount mode. The testing I've done seems to confirm that. This
has probably been broken in one way or another since the day of the
gfs2 merge, so it's obviously not that big a deal.

@@ -50,8 +50,7 @@ static inline int gfs2_quota_lock_check(struct gfs2_inode=
 *ip,
        ret =3D gfs2_quota_lock(ip, NO_UID_QUOTA_CHANGE, NO_GID_QUOTA_CHANG=
E);
        if (ret)
                return ret;
-       if (sdp->sd_args.ar_quota !=3D GFS2_QUOTA_ON &&
-           sdp->sd_args.ar_quota !=3D GFS2_QUOTA_QUIET)
+       if (sdp->sd_args.ar_quota =3D=3D GFS2_QUOTA_ACCOUNT)
                return 0;
        ret =3D gfs2_quota_check(ip, ip->i_inode.i_uid, ip->i_inode.i_gid, =
ap);
        if (ret)

Thanks,
Andreas


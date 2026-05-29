Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080271DDA18
	for <gfs2@lists.linux.dev>; Fri, 29 May 2026 13:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780061117; cv=none; b=XiUcePKPITF5ya2hFYayk1L03GD5LA81OTIs9YkMX9ehE2+39LgCN/HfncdPhEvDojqDBS6MVA4dLFC713R22ir8YbrmX+J3nV4zk2p9E4+vlUH2tCQPTWNu2eGsobwkwjLos4nkeehcUbNInr58WG5S7A9NHCKwt2VvNHvff1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780061117; c=relaxed/simple;
	bh=y/WutNbUhRCx+h2S3eL+geBB6+MuqNiIAFDbYVWCrpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i0Lt6EuAh90XDWl6rxR78+mDLvzmDroaGaAeG32QqhVx02cmGgz06SrRw3v2Nx61PyuzTNXCKiBaK9LCS19L74ckBtIr5PiVcKK97UYyuqgxPjX4WwG9w2sOAspZd9A+xAvarSirGaY5499av3md4S1n7jOoJXSJvrnx5GMVGes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MABMQka4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MABMQka4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780061115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y/WutNbUhRCx+h2S3eL+geBB6+MuqNiIAFDbYVWCrpc=;
	b=MABMQka4P3ev+3JPPbh25Mm9bP5CzIyU/6eMOf6O5qPr2gb5pz4QNPhXyc5OCWYtv0UETW
	8tghEPDQ9hK6lStjXCfDsp997e2EjCmb/PEBb5KJudrOadXOVkcx0TgZvRdW9feBllNpZH
	HY2yq5dRh+1VJlFRHFQzXFJBLskB7NU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42--DjSzlwMMyat1HrtA08Pig-1; Fri, 29 May 2026 09:25:13 -0400
X-MC-Unique: -DjSzlwMMyat1HrtA08Pig-1
X-Mimecast-MFC-AGG-ID: -DjSzlwMMyat1HrtA08Pig_1780061112
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-393d5b5ae63so51715821fa.3
        for <gfs2@lists.linux.dev>; Fri, 29 May 2026 06:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780061112; x=1780665912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y/WutNbUhRCx+h2S3eL+geBB6+MuqNiIAFDbYVWCrpc=;
        b=eEYppTPrIjp3n8dblL5xqP96AeoQyL1jtYHDn6uBNcBdGiS8VfuFFEcBcZrFobLeWb
         dVg8mUaoVCVr5B6EqY+w4apZb+xYupeGO2DBkdf6MtVdYfouYVU5kPkEyN/vQHMAikfW
         7QsFo2MUfF2Iztb2s+XFaoHJNHqvvAmo/ocEd/PPvsxZoUQ7nD1hAbMLZO95xcjTMFQq
         /30gNO+cejxS+zeBiEPIZndVvUGZrSWuH7R0xkdXJTqWs2MyjoHX4P6XJJnt3D8f3+Cr
         fW3RKWO5Lj0JnlO2FtH5oozqnNcQMn8kdIKDAe9pcNrH4eDJT5dR2OOsCW3hSwd01mhv
         2Spw==
X-Forwarded-Encrypted: i=1; AFNElJ/L6ZGp6QY9UyFHl5BH3UVszjlPyaVfZtKJv0IVlz48eZH1ojZnZ1ihRmKKKwiXzvs/RZrF@lists.linux.dev
X-Gm-Message-State: AOJu0YwNzcYPIivHrcjR6G6gbYeqX6ro12wQ3DIHBXNZ91o1gMzsMz18
	xw02zCiBCRMKBKb/JIIMuT+qgaxa1mxDWhPu0CgtlM3C4kJ5owmVwb9bEIB9gdiWML/rHbyv1WO
	OPfnOu1blXLJC8KdV5thEw/EQTLBSWWfOMPYnEek0Vl37HhC/BAekG4wZtoUKBY4OXQopP37Srx
	OzfkCS1t4XCmwfmY4gxxrJo1bqb/bjlXC5pfvNW77f
X-Gm-Gg: Acq92OFaki2L0HWCR/NN/6PLHzX1d1B9tRAC5O6xDWgMJOqUmYqvztPXbdiBXGc2Kkq
	GBodBrAblED6cXm3NnCouo0sMl6BQyEZkSNKWe21ZdEMKGJJjqjRPNxroilvuaKvq7GcNA3AVfF
	cqEJytB9Q8NCOoox31IF5XNj/N63yk9mkNnzXZBSzP9aYy5tB6ZhUhEAoKIiXuZ98NNIrPiz+BS
	0dSHwHVFg7eOO3Bd4y9TLb7e+kbt3eLdaT7TqFZoDCwvmQ05ao=
X-Received: by 2002:a05:6512:3da4:b0:5aa:b6b:7970 with SMTP id 2adb3069b0e04-5aa594b4ea0mr983131e87.44.1780061111779;
        Fri, 29 May 2026 06:25:11 -0700 (PDT)
X-Received: by 2002:a05:6512:3da4:b0:5aa:b6b:7970 with SMTP id
 2adb3069b0e04-5aa594b4ea0mr983114e87.44.1780061111309; Fri, 29 May 2026
 06:25:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260517020315.1064253-1-joseph.qi@linux.alibaba.com>
 <CAK-6q+jvaQx6y_tOzks3utBWaTRjvVnDWrznBYRfWjTQBcefBA@mail.gmail.com>
 <CAK-6q+iC3AgX7r2fZkvDJHibS0oqTwVCF4ZgV-1OFkV0d=R2Vw@mail.gmail.com>
 <CAK-6q+hPM=+fXkPSbr60Y6S1O_RfYGBUeL3mfVu0H1ymZ0gp6w@mail.gmail.com> <2026052626-galley-glitch-dcd9@gregkh>
In-Reply-To: <2026052626-galley-glitch-dcd9@gregkh>
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 29 May 2026 09:24:59 -0400
X-Gm-Features: AVHnY4Kcb5eF6s09kj3qj5rm81QBvrvdBt--Wu8MeTQ4MnBZVnVHbhMjIQK5CK4
Message-ID: <CAK-6q+ibs=hWiCPGKNdELdgiqq5kpmwDfUJdMTQkbrGGP4yHUA@mail.gmail.com>
Subject: Re: [PATCH v2] dlm: fix buffer overflow from negative len in dlm_search_rsb_tree
To: Greg KH <gregkh@kernel.org>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>, cve@kernel.org, 
	David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RvgfF0Es5LDHsqoKc7YFdiFpEx1H5lg0FM4cGwsJJyo_1780061112
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 26, 2026 at 12:09=E2=80=AFPM Greg KH <gregkh@kernel.org> wrote:
>
> On Tue, May 26, 2026 at 09:58:32AM -0400, Alexander Aring wrote:
> > Hi,
> >
> > On Mon, May 25, 2026 at 1:39=E2=80=AFPM Alexander Aring <aahringo@redha=
t.com> wrote:
> > >
> > > Hi,
> > >
> > > On Mon, May 25, 2026 at 10:27=E2=80=AFAM Alexander Aring <aahringo@re=
dhat.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Sat, May 16, 2026 at 10:03=E2=80=AFPM Joseph Qi <joseph.qi@linux=
.alibaba.com> wrote:
> > > > >
> > > > > commit 080e5563f878 only checks for len > DLM_RESNAME_MAXLEN, whi=
ch does
> > > >
> > > > check with checkpath, it reports an error regarding how this commit
> > > > reference is done.
> > > >
> > >
> > > This also addresses CVE-2026-43125 [0].
> > >
> > > - Alex
> > >
> > > [0] https://lore.kernel.org/linux-cve-announce/2026050619-CVE-2026-43=
125-c9f9@gregkh/
> >
> > cc the right folks cve@kernel.org as described in the kernel documentat=
ion.
>
> For what?
>

because

"If the CVE assignment team misses a specific fix that any user feels
should have a CVE assigned to it, please email them at
<cve@kernel.org> and the team there will work with you on it." [0]

The initial fix did not resolve CVE-2026-43125, there are additional
changes are required.

> > There is another patch required for CVE-2026-43125 [0].
> >
> > Joseph I think for v3 you should cc also cve@kernel.org and mention
> > this in your commit msg.
>
> Why doesn't this deserve a different CVE id when it lands in the public
> trees?
>

because the vulnerability described in CVE-2026-43125 is the same, I'm
also not sure I cc "cve@kernel.org" that the team there will work with
me on it as the kernel doc told me. :)

thanks.

- Alex

[0] https://docs.kernel.org/process/cve.html


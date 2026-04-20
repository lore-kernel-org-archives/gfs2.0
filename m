Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AA13AB299
	for <gfs2@lists.linux.dev>; Mon, 20 Apr 2026 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776695497; cv=pass; b=j4myxg8ngyBH2toceGBOV3t0DemaoPDZftGA+AfdYS43J7PKfeyTtyk4eLaBPNPUydRtLgnPCfPv7k+S05zQO8mTGuH+TyzDXgSmonol+8emGLpsTU5l0f6pnaBWb2dp/ZPGCelYjA6xDgz3EiVZ372Pd6ihQkd+6b19jVeEbbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776695497; c=relaxed/simple;
	bh=kqPRzU1r8Upp5TYgefpiWZ9RVnkrVKI+N7GY819VmUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B8i1xGHOebwQrYeqmw70WBZPPJkLICnCBMAqQbytu7uSj7Z/yPfr7nqdGrqEZ5Dl7/boYC0WaEddAm+pwphr8+8mdpJmHV9F64ki41uwWIzNmdL7gKp1InKPALQvcPurpRZJ7C5Qv8qFEqXw3MkvYT9c6oMQD6GFltr4Z+yeq60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGFqUsO5; arc=pass smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGFqUsO5"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5675d609621so2390907e0c.2
        for <gfs2@lists.linux.dev>; Mon, 20 Apr 2026 07:31:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776695494; cv=none;
        d=google.com; s=arc-20240605;
        b=hW5QZgWZik2J7RJl1rsPJL/ieUrR8Hzdu3Osz2vP/RBWJSCSFKVQZiGjXFfZyBU2MT
         3hsOBfAACv51fKL+D3LTEt423WsSBrd43qzNS15fOYiwlRsd28KWCPpWsZ0NGiL1rOky
         R9dbrcIkoOhaDtuJRZ06ZFXSql4W1Y1f6B3Hb7phkiU9LJiRH0DQ+p609z8J/fehddPw
         yOZmh2BGH0otO/8wbZLiuEtmIl39BkZE7wO8Q5jlSkDiK0jT8skuGhNWBvdndbtIweHq
         EmZNA/1gNc7LJz6UaFloqAMZOuuKCDVWmMGC1s8mvQasIPIVudtErM+GE8cPwPi8M2VV
         xlRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4O8Xd8WCONGvKBMRsNl+HFLA/9jUjeJYvKk/a3SZv7Q=;
        fh=8UpHcJYXWHDoh2paXEjdFKiZXLiuRqfhDRr65c3nvG8=;
        b=PqYihXfB62QdYMAz8wd5qQ+XJ6bRFe4y30VLNH55QIqfEBbydL91ecFGoTiJgVO3Nu
         Adg17WDlGfUvwHVvLGB9+9wt11UtL1njiwEf821T4QRP2BnRYYuikVjakdhbOKtqRGVY
         obUVs9GKAYDQ7LBeErP6k7ZgYqyT1g1Yq9mW41FtwJGloLmzrMp0ti6foVauotG53WeU
         HB1IZGuCzeikp195iQAtOP8/hv2Ip8sO9AcqJTZLep7es3WSIgiy+vDMGO8bBMEWte4z
         bhgMUtse5jhT0A2qQgpaOUpqILkU5Qc04kqcX9fZ9R7uTCC9k2b63Op074a9QsS9nu0p
         WeYA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776695494; x=1777300294; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4O8Xd8WCONGvKBMRsNl+HFLA/9jUjeJYvKk/a3SZv7Q=;
        b=bGFqUsO579jKt+4QLU5K8qN4nb5sYUgm73Uri+tyEYPrOBpuTzBD2PK0NT2hgqK+EU
         xPWdejDY6RxIyMp4XF6loohWSyTjCXrvf8Y4sj9eH5f3tCobPFT1U6smV9+EpdHZLS17
         etm1D/xRh9FLAwLn9vxF0b6GOLJD5Z4G4V8HkqYoy/dBZriLbEpwtcE7uywo52jl5RKI
         1v3zrkjBjUqLYXzszdro/ASblVBLxcvTv9OGgUOlPYflskqKseD6udIstweo0WtNg66I
         TiyNx5dhkaMkLd9BcPnQv4mcPBUS0d5eIgmlaNsBuXfhQNLkAom16E6BsloYMTWRJTz9
         y5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776695494; x=1777300294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4O8Xd8WCONGvKBMRsNl+HFLA/9jUjeJYvKk/a3SZv7Q=;
        b=FH9WEPzgW+mUNAB8/hYT8HF6EsryD/zBUTo++VtknkRAUCiBAgFCrE8LHcRU9Df0He
         W+Gl55iZfNro6XS+FLSWDXX0Ca2SQQiDRl5vCKe4W5gl+6hWNXkjsxR89aiRRETx0D3X
         SeLwhDs6CyYo+Lk4v2ZMtLFxqH9CpdK0kp41Yz7IOmDr3Fz7123AY41+ArjwSTzhF14F
         9jFF9fqE9GEzDaD/wDwSdrVIzYi0m89oXgRt1Fbxx72LvKx9z4HMpnhXrjK0W/X9zrUn
         SQB/ZHgcGd1WgoXXQGmkQoU7/WIQbLUQpAd/9V3L1BmZm0YV0doZcwk82x/hDqVOmtI8
         J9qw==
X-Forwarded-Encrypted: i=1; AFNElJ/omFYk8QGqa0TAGWf+rhqIp2O/6MsG7OJmWhyNBr9viGpydtaonf/Fxpfu1xXmkcyfnCt5@lists.linux.dev
X-Gm-Message-State: AOJu0YziEZeWdQh98B6DUVkicqeaboPvm6325YAj5rg1hPTa3xD6zcU0
	Y0C3Q2XRGcKw5wzSWEJ2sZvxIeTgzNukIb1Jz2HKOzEUCZRRmEWToB2dnqmIQ1c8o8GbYkAXsOm
	DHYvySarW4un4LQ2Hv2Kn4gwjrnfros4=
X-Gm-Gg: AeBDieuk6ikNULb2kEXY9b5qGg6ACK4kN9Xhx2jdnj53o0c2a9ggteHzUfiOCc7aTmv
	Fl3OPjmFEyhx93GKarDeaylpJAH27OjNjYEcMYLe+kJVdr0suYJaGu51U0mDypADcK0T/y7pFrz
	L2Z/OWGR18pxUhuQRHiw59HYZzjCDOLqOpjZix+x6KUbLC5eiEIyQ+wyyB/hUI26fYzNODJ3Ghg
	lNkDRUdghV94OclYdzMbzIAgi9hGG9I52YFPJUCIaBmE/ojIh4CYzuh+utzceGPruT/7/HHBrvH
	6N22ByyWnHKub04/VR6AugqnyRe4GbAu+UgWytOtrqtnHo/HfOAl
X-Received: by 2002:a05:6122:4d12:b0:56f:9512:145 with SMTP id
 71dfb90a1353d-56fa5a39aa7mr6593038e0c.13.1776695494119; Mon, 20 Apr 2026
 07:31:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260416-abgraben-seeweg-a44ce660957f@brauner> <CAFfO_h5mORm0OuK-d4thzBWWySmyvLSVeVa7phZc4Df-8D=1Cg@mail.gmail.com>
 <20260420-laufen-einzeln-4cf4bb364a5d@brauner>
In-Reply-To: <20260420-laufen-einzeln-4cf4bb364a5d@brauner>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 20 Apr 2026 20:31:23 +0600
X-Gm-Features: AQROBzDP8Lx2bqkiL-O80tZkD0rFOUG8sjvNKKIkhcPgFqdc6FHkIJDo6D1Xn7k
Message-ID: <CAFfO_h5FH36eqYuuoYy2eVRXGytmQHLfz5p7fLi+3wHmQN9MnA@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] OPENAT2_REGULAR flag support for openat2
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	jlayton@kernel.org, chuck.lever@oracle.com, alex.aring@gmail.com, 
	arnd@arndb.de, adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, idryomov@gmail.com, 
	amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, 
	trondmy@kernel.org, anna@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
	bharathsm@microsoft.com, shuah@kernel.org, miklos@szeredi.hu, 
	hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 7:20=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Apr 16, 2026 at 09:22:03PM +0600, Dorjoy Chowdhury wrote:
> > On Thu, Apr 16, 2026 at 7:07=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > On Sat, 28 Mar 2026 23:22:21 +0600, Dorjoy Chowdhury wrote:
> > > > I came upon this "Ability to only open regular files" uapi feature =
suggestion
> > > > from https://uapi-group.org/kernel-features/#ability-to-only-open-r=
egular-files
> > > > and thought it would be something I could do as a first patch and g=
et to
> > > > know the kernel code a bit better.
> > > >
> > > > The following filesystems have been tested by building and booting =
the kernel
> > > > x86 bzImage in a Fedora 43 VM in QEMU. I have tested with OPENAT2_R=
EGULAR that
> > > > regular files can be successfully opened and non-regular files (dir=
ectory, fifo etc)
> > > > return -EFTYPE.
> > > > - btrfs
> > > > - NFS (loopback)
> > > > - SMB (loopback)
> > > >
> > > > [...]
> > >
> > > - I've added an explanation why OPENAT2_REGULAR is only needed for so=
me
> > >   ->atomic_open() implementers but not others. What I don't like is t=
hat
> > >   we need all that custom handling in there but it's managable.
> > >
> > > - I dropped the topmost style conversions. They really don't belong
> > >   there and if we switch to something better we should use (1 << <nr>=
).
> > >
> > > - I split the EFTYPE errno introduction into a separate patch.
> > >
> > > ---
> >
> > Thanks for fixing up and picking this one up!
> >
> > >
> > > Applied to the vfs-7.2.openat.regular branch of the vfs/vfs.git tree.
> > > Patches in the vfs-7.2.openat.regular branch should appear in linux-n=
ext soon.
> > >
> >
> > I don't see a vfs-7.2.openat.regular branch in vfs/vfs.git tree in
> > git.kernel.org.  Maybe this hasn't been pushed yet?
>
> Nothing will get pushed prior to -rc1 which is due this Sunday.

Understood. Thanks!

Regards,
Dorjoy

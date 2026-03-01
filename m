Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E8E3321B0
	for <gfs2@lists.linux.dev>; Sun,  1 Mar 2026 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772377332; cv=pass; b=pxX6NsfkMMEG7ievUTETaJEvuxkoExWJTEmG7v9vl/mK7kw4jM/oBucSaZjc+MJly9rYlN8tGw/oyZGBODwvocdyYoESODzINl0yaL1wZjI2O4Y8ZflNfE0izwAmyBS3CTxCoOrjVzVHmXfsi4F/RqvZ89XzI847yxodu5JDCVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772377332; c=relaxed/simple;
	bh=V37CR9us1N0esOdbbifQtaXVD0Ciudjbj+QVzwLv+pU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5qEEENBmtdvjCYvRKwpgrWN6bqc4f4j46u2E2PEedNGjPOUrJN3NU1N1CASrALb1IIwl7I/Ev+VHjwYXd4ir5jILWkiPRpYcmC9ZWBxSWaYC9RC68YBsvbcEqHGUQGe10gM3L3YA2fgUrknVawt95pDJJZJzSh2Eknv1yKrqRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6ojLO+K; arc=pass smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6ojLO+K"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5ff1703cb94so2338595137.3
        for <gfs2@lists.linux.dev>; Sun, 01 Mar 2026 07:02:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772377330; cv=none;
        d=google.com; s=arc-20240605;
        b=hUrr4Q4ujkpylF1sxFKhtALfw3fcYcyA+epOS/bDUd6upZ0qh+cYCixW+XZ0EGXmMG
         9b4T5hb82nKMS3NfhLPtj+aDxhUDMiNyyw6hUevnnlX/JEB/WNT+Kg/Cv9zuvpjQFc2X
         8hu386yXiuKOntTQwiZHLErvUlj4HfNYhkc+OTa0PYsPX3ZKX4xA3DEG3l1G5zCwpZKb
         T+7hwjICpdwgA/ue3Dn1W7F2qlh3Sn7bf8LcK8QbTAFdhM3+eLNOLM95iWvloid0yVKN
         znN7xm8agvJJ794cFwZnqEkaMoeVa/U/T6UfUhn1hYtVijM2O7BkWNgl+XRgZoSsvLFq
         Px2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2DEbj6UlaLHWTSmc9tFmxEh3Nd0lpNrPuON3F9X96hM=;
        fh=mxzLBnOBwI4mLMAAJys5AaQCerhC5LU0hx6+osVe/pI=;
        b=KfH5uybdgE585fxaxdSWpDno6CtbsvCZtI5yMkQQS52vKWAR06CpESOgsqp3KoYmdv
         E+SHKAM3E5ph+tRiYXTIZ47F6gKTwphzlJ/+FevKpkLwLd7RajR50stYVM1ftLAvQyzN
         I8+rD/5EwLISwIj9+EiSTC6kmxMhF2+PbFH9VogeEvAMeSvT1Gu9CiAk0ZkRkZebOIa7
         5sHyRGtUuRvLF2wreHcPUSMUMtTLzRFQ5s1JbEz2c60C2YpDyxhO1j8m1iNSEk4f4WQ5
         dNvGks/8GkbaUtuw23ZaPYVEYaORd7DD4mXqvQfrmBiGIHrWMGH+YhPkPnCxkmEU0ZX9
         OoZA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772377330; x=1772982130; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DEbj6UlaLHWTSmc9tFmxEh3Nd0lpNrPuON3F9X96hM=;
        b=N6ojLO+KaFFJl20u2JDxJDro17JRopLwFVMGhR9ECvFYy7jw2L8019dVqMB7yuDtfF
         8yc9q7CyTSIhFH90SuHWUr5mXATAYzdDG6mSIEvImgyjLxy/Fj+apXqNFLY9sA8TIuth
         rbz+qnU4e82fOVNV6P14lTvmBGfMV2Npgvwn70G9EeDnirss/tnYiI5ZLGPaLG6+X9Ck
         +vNHhKSWEHzxnRd0Rt11ykLowhrWz/ijWHUv035Av4fS2/kp7MFC28Uodsxmd5sWUxbF
         wAVdLWILaezLYl2JDI051jT+3DwGRlvpTgtcsMAcV+l9xijpK5VrlFHfOQHpDAE+gVAe
         fwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772377330; x=1772982130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2DEbj6UlaLHWTSmc9tFmxEh3Nd0lpNrPuON3F9X96hM=;
        b=NtltUz6HDniKuRoJBgAjCQCox+2B3QrsJ1KdTTjTJVuWy3UF4+nt1J5jev4WtdzNU8
         NEVpnARxfo+LSZeJcrsuennowg/xbs0qplru9n9jvGIxC1jrLTfycEuw2g3l6vDe3DUK
         sDJ40xK/32NacxJjhrKtPxpryplL+JQi+YrsT6cpjW2K0+MUFr6PyCXeFRByv4OOgJfB
         e4qAMM/mRwXnKjQNkagSsMPR87pkzb8FgjLEo6vP8+XoXF7IzsG039px5Yo2afukZIq3
         iQjBQnj5sPMy4aiKx4+KsA/Dpc0vVmhRqXB979Db6cNak9LsAFl70vtd2tmQ6btJdOW9
         MzJw==
X-Forwarded-Encrypted: i=1; AJvYcCUuPpLei7hkbfIsqHDkrD4TD64o4Rk5EeOPdTfDV0TDA+oa2iNLDMWnc3VKJz/2MXmxA+eN@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9eakON7O5lKRznFV4EaGyuqhZGvLi1q+vUqTE4ykZQzUh6uwB
	iIF0XNwJd8IfRFbT2N7tiKNRVXL9WybcuBDjIOmT3S9fVW5pMgEXJYiyTyU/gJsoRUYmSKh3x2b
	H4RUjAPt53B61NBrkwOucr9/ds/e1OiM=
X-Gm-Gg: ATEYQzyusp6qGX9g5GJg3vMKN92zrei658VB8lIdF0LVwkaxeiGNesxosFCi6M23xuC
	e10kOa4vbWv5kn7vRnKs6Hm/yoFSdciL0+0t/2O/thFJ8Zcz/ezJznlSp3aWFHDjNINt8bk++Xc
	DQRYsc2f4Vp5Bf/DgKp/JltnuBFX50KoHjaZVUAN7r000PcECqOvdisWEIBiKaPxvi68YXh4dDT
	F1/C0fgrIjybD6pJ4x8FNJhaJ+fccE6ueMIOpXHoR8Dc9+Pp5ZagmIn8IB5KdZRuICtOJoSijLS
	cZ/hTmjviCP93UE0iYgNCcpCjnCJPdp0kbFA003dWg==
X-Received: by 2002:a05:6102:cc6:b0:5ff:1445:88ff with SMTP id
 ada2fe7eead31-5ff322714abmr4377922137.7.1772377329579; Sun, 01 Mar 2026
 07:02:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260221145915.81749-1-dorjoychy111@gmail.com>
 <20260221145915.81749-2-dorjoychy111@gmail.com> <2f430eb613d4f6f6564f83d06f802ff47adea230.camel@kernel.org>
 <CAFfO_h7i86qdKZObdFpWd8Mh+8VXVMFYoGgYBgzomzhGJJFnEQ@mail.gmail.com> <ed5aeaa81ad9b87926fa7ebee0308aeb8df9f0ac.camel@kernel.org>
In-Reply-To: <ed5aeaa81ad9b87926fa7ebee0308aeb8df9f0ac.camel@kernel.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sun, 1 Mar 2026 21:01:58 +0600
X-Gm-Features: AaiRm50b25Ilp0U_HqmXYGEDuiLaRPqAldbyxEp-tlfkTSKlimm7-yBVSXDXKJs
Message-ID: <CAFfO_h5za6gV99TQS3pwHnf7zyCeVySn3CdRyV+_jFqjovGBqA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] openat2: new OPENAT2_REGULAR flag support
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
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

On Sun, Mar 1, 2026 at 8:47=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Sun, 2026-03-01 at 20:16 +0600, Dorjoy Chowdhury wrote:
> > On Sun, Mar 1, 2026 at 6:44=E2=80=AFPM Jeff Layton <jlayton@kernel.org>=
 wrote:
> > >
> > > On Sat, 2026-02-21 at 20:45 +0600, Dorjoy Chowdhury wrote:
> > > > This flag indicates the path should be opened if it's a regular fil=
e.
> > > > This is useful to write secure programs that want to avoid being
> > > > tricked into opening device nodes with special semantics while thin=
king
> > > > they operate on regular files. This is a requested feature from the
> > > > uapi-group[1].
> > > >
> > > > A corresponding error code EFTYPE has been introduced. For example,=
 if
> > > > openat2 is called on path /dev/null with OPENAT2_REGULAR in the fla=
g
> > > > param, it will return -EFTYPE.
> > > >
> > > > When used in combination with O_CREAT, either the regular file is
> > > > created, or if the path already exists, it is opened if it's a regu=
lar
> > > > file. Otherwise, -EFTYPE is returned.
> > > >
> > >
> > > It would be good to mention that EFTYPE has precedent in BSD/Darwin.
> > > When an error code is already supported in another UNIX-y OS, then it
> > > bolsters the case for adding it here.
> > >
> >
> > Good suggestion. Yes, I can include this information in the commit
> > message during the next posting.
> >
> > > Your cover letter mentions that you only tested this on btrfs. At the
> > > very least, you should test NFS and SMB. It should be fairly easy to
> > > set up mounts over loopback for those cases.
> > >
> >
> > I used virtme-ng (which I think reuses the host's filesystem) to run
> > the compiled bzImage and ran the openat2 kselftests there to verify
> > it's working. Is there a similar way I can test NFS/SMB by adding
> > kselftests? Or would I need to setup NFS/SMB inside a full VM distro
> > with a modified kernel to test this? I would appreciate any suggestion
> > on this.
> >
>
> I imagine virtme would need some configuration to set up for nfs or
> cifs, but maybe it's possible. I mostly use kdevops for this sort of
> testing.
>

Got it. I will try to figure this out and do some testing for NFS/SMB. Than=
ks.

> > > There are some places where it doesn't seem like -EFTYPE will be
> > > returned. It looks like it can send back -EISDIR and -ENOTDIR in some
> > > cases as well. With a new API like this, I think we ought to strive f=
or
> > > consistency.
> > >
> >
> > Good point. There was a comment in a previous posting of this patch
> > series "The most useful behavior would indicate what was found (e.g.,
> > a pipe)."
> > (ref: https://lore.kernel.org/linux-fsdevel/vhq3osjqs3nn764wrp2lxp66b4d=
xpb3n5x3dijhe2yr53qfgy3@tfswbjskc3y6/
> > )
> > So I thought maybe it would be useful to return -EISDIR where it was
> > already doing that. But it is a good point about consistency that we
> > won't be doing this for other different types so I guess it's better
> > to return -EFTYPE for all the cases anyway as you mention. Any
> > thoughts?
> >
>
> There is a case to be made for either. The big question is whether you
> can consistently return the same error codes in the same situations.
>
> For instance, you can return -EISDIR on NFS when the target is a
> directory, but can you do the same on btrfs or ceph? If not, then we
> have a situation where we have to deal with the possibility of two
> different error codes.
>
> In general, I think returning EFTYPE for everything is simplest and
> therefore best. Sure, EISDIR tells you a bit more about the target, but
> that info is probably not that helpful if you were expecting it to be a
> regular file.
>

Good point. I agree. I will fix this and return -EFTYPE for everything
in the next posting.

> >
> > > Should this API return -EFTYPE for all cases where it's not S_IFREG? =
If
> > > not, then what other errors are allowed? Bear in mind that you'll nee=
d
> > > to document this in the manpages too.
> > >
> >
> > Are the manpages in the kernel git repository or in a separate
> > repository? Do I make separate patch series for that? Sorry I don't
> > know about this in detail.
> >
>
> Separate repo and mailing list: https://www.kernel.org/doc/man-pages/
>
> ...come to think of it, you should also cc the linux-api mailing list
> when you send the next version:
>
>     https://www.kernel.org/doc/man-pages/linux-api-ml.html
>
> This one is fairly straightforward, but once a new API is in a released
> kernel, it's hard to change things, so we'll want to make sure we get
> this right.
>

I did not know about this. I will cc linux-api mailing list from the
next posting.

> I should also ask you about testcases here. You should add some tests
> to fstests for O_REGULAR if you haven't already:
>
>     https://www.kernel.org/doc/man-pages/linux-api-ml.html
>

I only added a kselftest for the new flag in
tools/testing/selftests/openat2/openat2_test.c in my second commit in
this patch series. Where are the fstests that I should add tests? I
think you added the wrong URL above, probably a typo.

Regards,
Dorjoy

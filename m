Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B3B3C456F
	for <gfs2@lists.linux.dev>; Mon, 27 Apr 2026 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777299477; cv=pass; b=UFS/0lGFlUesGya9Tl2c8oeoJfLNw4Xe/MF5JBYeqwMpeJ/zlPRwZzlqAho7zEcrOnSa3NTr7demvT0ri15gSftpdtRjmlYlUCApPM8Zs8C/aDJ9nIQzrYkyrkY1xUOjJ7A1ACbSx+DB03Z2FyXEutEoqXQSbITZgS2CTecpPtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777299477; c=relaxed/simple;
	bh=dCas8RQKsBsKm7RPEue3wRPtJ4lneFcySX6TUqGbvVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LqZo1as4Kb+WtIp1eWNbvsC9HwMGG6lheEIk6FGLm7hREBvv1i06DCULRfJguUyjYoxzUS3bD9Zdto+CgpsiwleORXzQ0qaDhtETCiwhCDzKdLFVcCDz/MbAuMmUr8U7HLcQkJmk1ATm6nkJ6eCfiGuKTCvYu+uBQz4+uwJcWxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/+bTgEV; arc=pass smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/+bTgEV"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-56db1b3626bso6691887e0c.1
        for <gfs2@lists.linux.dev>; Mon, 27 Apr 2026 07:17:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777299475; cv=none;
        d=google.com; s=arc-20240605;
        b=JzTSgkGlngjE+ohqyd1SOYk5E9R2F5NyXid6enIkJqNEXZvxkKrwVHvCK4AMuczAqm
         wy+LvjNbgsrBgSojpSAiv1tkAPHmrOoL61ouEeEIMX9KianvhLJHRABIaFwAQHlv5qmJ
         0FWi49N8UDHF39Qw3+o/WoCaHbukXESLPxLIoCq3Nm80bJubN8g9lYTc1WG5ibjAhC6P
         uLUPJOt0sLF5+vORNXKvGDojYngg7zs7Pq97OXKq1aZwM5NaY5s6iRE3O2m78b9uBJRC
         uyBT51b9qOwYufc6jonJXnWHxYzTGZuwvLbZKUAbYFAYrCsGzPSRegV/tIFER9iVhyJN
         kqqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mZ1b/SaO6jwDwL2+8FqnCPqXNKQ2XKB8aPpu8Tl3aso=;
        fh=ZUwVczEJshTpGQrB1lIjcp7iUfWKoe5Sd9Hw6jFR09Y=;
        b=exRoQ98E32XDfZEVeqrqtvjCa4uQVJatlXrDKng99VCMtxnPoHGr99spbgZlzooZOa
         qoE1S7496iorUjJEhYG87TGCTtW3RnpVH1zl+K+5lcrBIumxUptlK1dfkuI9Jh1jAJoC
         1Hr1akFF8EfZVSD/ADAwmfFQBVDSjBXhq7AJpJFB3a0lhRVXg+lzRX+mW6j2770pNWc4
         dzdyN00W13QtbWMWI/fzcFfxKMdy5jQ7QLNfK8ltIl/kIss+lPWePXgB7TrybP3bBUtG
         P+CKUjaC9AZqruEWpEyWOKyRMktN+lNpu+h/PXjZrNinqovXx8xplydvcR6/25fyGC21
         9b2w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777299475; x=1777904275; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZ1b/SaO6jwDwL2+8FqnCPqXNKQ2XKB8aPpu8Tl3aso=;
        b=b/+bTgEVwo5J6HwyHJ5sI1qkp9lTyqmPvYf8V6w8LGj5QzZm3uPgu8q/sSAhIl16vR
         SOiz5A4ulL0rQ+CLSFN7KVFtqDx3Fis5daTgSNAIEXDYD9pkcJ0uvOl1HMsoi2pXmquD
         bPUeJGAFvhGEWmyVTnR7NCBV944HTrwyvahYIgTO9iMt88WnclaLKL4YJakaB4z9pUIg
         9Dr5aaYAc376zONCj5YLi5zlbjHo6mFicfRx+FeBswIwtwK6dVRslUfsce3tzpPne0RP
         DVd91gqe1cwSKrIEngWH1H+qYHE71QlXrtsd2FKGjzgRWDTJAk/gJ6bQvYeGWVenm7/D
         BR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777299475; x=1777904275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mZ1b/SaO6jwDwL2+8FqnCPqXNKQ2XKB8aPpu8Tl3aso=;
        b=MUs2A5QL+KduZTCyVkH0dvxJxvBj3A8MZehoacElXubKNW1u5jyBjBGI3JdpRDWQjx
         yIMnblNpX2TdRtty7FPY27JtoN2fpmCC+S0vQE5MITf8d1WHaQ1YLEPVVBTMOApOL921
         QUtToZY+ReGyXNMN/nmcVM/iyW6/0rYWLFXuzkvGHt9qu+c2BlONskps1IOFxnga7+B/
         F2ck46Yia4bgXVEoUk0AABxbuCIS2vPANd5++WhKCUpl/S1s4kqp5qfX/98WtSk5pR+H
         f0YGv2M9MyeYjHoZPtVEXNlTEwg+nAtF7oKMAgC+HqLUV0OybD5zVUA3YAnAcPR5fxk9
         kPtA==
X-Forwarded-Encrypted: i=1; AFNElJ/uO2bAUlWy2PR0lC3Ctb1tnguJpCIGt7MoklJ9bKlP7C864SMVd4V5KozgHqqB9NqpcFFv@lists.linux.dev
X-Gm-Message-State: AOJu0Yzn+pRNVSf5KuNUGUiQYQCwe9DxIYz0/uHAghkJZFB2DQWExlkn
	T2UUk/+TeMGUA+oSYBx4cWcAlwMGQwIRERAZJd3PcJnIJ5gZLUGEvfwJdVWbn1xFuIckcdQ8ia6
	sxLoU8FJBsLS7HPmu/rmzrBD+oMFuMdc=
X-Gm-Gg: AeBDievSyycp7T4Cjep9CflMJ/fkeKaFL9/Id3VO7Q4HDT3sqQVX6Q4gKIT37av48pO
	poszz14qIxCBvGJle7BzRCn8LLwYTelRPe/svVH+iMF+xe9xG+3Qv57qsHQbM2x/PaA12C6brdm
	+iABPscz0IJ3XNmu+lyoZ4ieYY8RWK7iGPFI1EYuzJz3EdBuXYr3MDaX8EgFarqKNJ6YFsBB8jJ
	d+/eOTJnxD/zWJxupaFh4uNVNdDz9W+bkh1YatULbjA+0lBUpv+8letUhhr/O7QrJPg//MBE+aQ
	Lny99zEuXDQCWCrLi4+Gja3Mdtw+J/c1imZxSRpcZT3OmuJTFzg9
X-Received: by 2002:a05:6122:8d3:b0:56c:d5cd:1e7c with SMTP id
 71dfb90a1353d-56fa58856b1mr21307327e0c.5.1777299474612; Mon, 27 Apr 2026
 07:17:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260328172314.45807-2-dorjoychy111@gmail.com> <lhuzf2oy1me.fsf@oldenburg.str.redhat.com>
In-Reply-To: <lhuzf2oy1me.fsf@oldenburg.str.redhat.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 27 Apr 2026 20:17:43 +0600
X-Gm-Features: AVHnY4JD2JZaiwDyyuW_kBt_sHjEkoUZKURjGdK7nlj6KmXsjRIqpl4zFGzklnA
Message-ID: <CAFfO_h5B=Ox9S=Xc=az2vQwowffohch-mkvSggYAfNXaVuv5GA@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
To: Florian Weimer <fweimer@redhat.com>, brauner@kernel.org, 
	Alejandro Colomar <alx@kernel.org>
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

On Mon, Apr 27, 2026 at 7:28=E2=80=AFPM Florian Weimer <fweimer@redhat.com>=
 wrote:
>
> * Dorjoy Chowdhury:
>
> > diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generi=
c/errno.h
> > index 92e7ae493ee3..bd78e69e0a43 100644
> > --- a/include/uapi/asm-generic/errno.h
> > +++ b/include/uapi/asm-generic/errno.h
> > @@ -122,4 +122,6 @@
> >
> >  #define EHWPOISON    133     /* Memory page has hardware error */
> >
> > +#define EFTYPE               134     /* Wrong file type for the intend=
ed operation */
> > +
> >  #endif
>
> This is what POSIX says about EFTYPE, in the Rationale for System
> Interfaces:
>
> =E2=80=9C
> [EFTYPE]
>     This error code was proposed in earlier proposals as "Inappropriate
>     operation for file type", meaning that the operation requested is
>     not appropriate for the file specified in the function call. This
>     code was proposed, although the same idea was covered by [ENOTTY],
>     because the connotations of the name would be misleading. It was
>     pointed out that the fcntl() function uses the error code [EINVAL]
>     for this notion, and hence all instances of [EFTYPE] were changed to
>     this code.
> =E2=80=9D
>
> So I'm not sure if reusing this name is a good idea.
>

Thanks for pointing this out. I had started out the patch series with
ENOTREGULAR and it was discussed that EFTYPE was a better and more
generic error code which is also used in BSD systems like FreeBSD[1]
and MacOS[2]. I also agree that EFTYPE makes sense. We can of course
change to something else if everyone agrees.

cc Christian Brauner who originally suggested EFTYPE for input on this.

[1]: https://man.freebsd.org/cgi/man.cgi?errno(2)
[2]: https://developer.apple.com/documentation/foundation/posixerror/eftype

Regards,
Dorjoy

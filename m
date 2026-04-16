Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC1C3DE441
	for <gfs2@lists.linux.dev>; Thu, 16 Apr 2026 14:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776349302; cv=pass; b=DybybFCyVayoHbF9WUsAzlbyDYR8xL6GJjSH/uTIazHY13kSkyMTAT8sH5cNh55S1EZNEqj4uQs9+HPMQ9a3uXXneTQoi3Z5nQbPi0LBN7swdmCRI+DMEBxwCP2sKzENSu84upIKs01HLRttHY7JNd04VProyiZPmY7gYiEkVfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776349302; c=relaxed/simple;
	bh=MPSStrB5WQZXjuD8LVCQJRe2/QVXDyCuUjmphyPyAE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=GPqajYoGVz7/Ogw6B89TG6IBSzlzNtwkqZjowSQ4n7+9yjgPEx0ISv8RCP1i4mHSKNf2GJl0Mrd4uTzUbtJsZ1ovMM3zTWFL9UL2V4GqjOwbmThk4y2Y1Q7LDNAigfpdCTu5WeIwAO2pgr4aUVLVd1bD7WeRTZh5lhiMb5EUY44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OeMPlua3; arc=pass smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeMPlua3"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-56f72d27e7eso602936e0c.0
        for <gfs2@lists.linux.dev>; Thu, 16 Apr 2026 07:21:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776349300; cv=none;
        d=google.com; s=arc-20240605;
        b=MoH3d41DXyExSn2lFgM6jo7Mjy8oa7kIYBXaiKb7ug2jj6XOuPUS68bjyB0IcoUt5f
         GM/JO9Wo956cHDeolvb5xNKolBBJOLAlpTqhG49T9HKIQuW3RE7pnQp8myKo+QHVH0fQ
         U9w/fDdfbCdSuDAhpKD0/w3YAyCMe8Usld/ND4hNxlMVmqY1IG8VpKXI7K5/ANbkFCFa
         yKA+tCHpbtLf4GMZCtthD0EGOBpLnAdu0RQXP/qlS685CP4lthOl2ZxXECFhLHpfJefX
         6TwZECssqdOA1L2crocSL8D+vK1gGjAtxcnDYSJuWfAd+AoPlbVWNu75hD2htrh2IOCh
         y+RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lO8+zS1qnuU0zyUegMfTKGfj9Y7WBTQIob4jJAeuR1I=;
        fh=2a6B3cuvTyBZEw0/wP1nabV5ea2fR4T0MQ4L3RemejI=;
        b=B+VgEd9SmRBfuU56K1ZAxz+YMjJ7jZAWUZhOVa2WHGpNvA+WJZimqSJOmUwALwQdy0
         suZgGLraD5PC2Q51age+ILWHhx6SvG5sg4ZNLA4lbGracVHUM++YlvRztrWwFIxXLDlk
         AwaWgOlZjuHrgKDQSLbPWlxvJtAbxyB4IrE5KJRiOFlPeLWA4+e9N1rD1YFstuiMrwq6
         Q7siix29EiArdtT44caIuJA1Jk2PMiCoYGYBeOroxGl6sg+WC+1RYIOQC90mV1JNcn4Y
         QY1JbPUYjTAlWoaBsPhCkLYGgXPYWBLHJ7p0tIzWzhmcTMx8uVUlXizhv8Oty6Q5XHsd
         A0LA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776349300; x=1776954100; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lO8+zS1qnuU0zyUegMfTKGfj9Y7WBTQIob4jJAeuR1I=;
        b=OeMPlua3Z3TT5Q1TqctrFMg1ptjPcOLwMAet1GqQdTFpZk5lq8GU5WCpvI4IF3Dlu/
         tDswPokH+ud26HlGSQN5J8xEV0JmiOc8GqyFAiQiOYG93asF27LuUokElBNr5rG5Q+A1
         oy7j9jlLnhAOITEZzRUgSvJ4FklKoszHcubZTj5PYeQ4pl/xfJsgcGw/p1wV16GIFvgp
         KEQrc7wEVrguUBOcBA2kM7WFHE1PuBq9AAbTY550Pd3Dwfbh18Z/0wSFm20W2NWdS85R
         Dc1eFfuuWv1DMv+QkSm1wPI6y7gsu32yABSesdgidHIN9oJV42XG9mi+sEHhrrAP2D+r
         xWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776349300; x=1776954100;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lO8+zS1qnuU0zyUegMfTKGfj9Y7WBTQIob4jJAeuR1I=;
        b=n+rPp2yk03zyIjfWsBGoS2CD0fzWm7bqhNt9Fm0Nq2uyViNiB/UWpzznb9/nZRI/sd
         2UY+moOsrbut8noscQLlLU3husxBqUEWDw0O4Ms6axMjPU8TjLnfw55dP8uWyVEAG6SA
         MPsb+FbaxMsdw975tckwt0WCquy1ndYfkxuGuRb2rhTFLoG5N5HDcwtcA7hpUfriCF3o
         AM2oDF0M7XtWTFzhQTX9BAHO6e//glq7MzN+c5w9o3PrkLnB0vD4xEBnkJ1IvYgEoko+
         micXLBxESwu2NwX+1qvpfCtQ0A9jndJctrGEwcXK+bgU8pBjOnajfS2epLiJnIyxL5Kj
         W9Xg==
X-Forwarded-Encrypted: i=1; AFNElJ/jWbX0Bo4kxPfPNwadYpa5O14WWz7qT3cEbIDeyZFo5GI7uS037GozsCy7T0NS3xueqcYe@lists.linux.dev
X-Gm-Message-State: AOJu0YykuYK+5nn/TOkdCE4lzTCMPWiYnjOfsy8+81zSGTeGdVP6eo0T
	4/n4n7+m2HQIpokFWrtcs6RTZldt4cimMXdIR+NvmYzTR+dpvyg+ouzWb8CDzNfUADVho+kBUFv
	U8o/EK0mc+NFMrlWHSP57v47nOosTfRo=
X-Gm-Gg: AeBDiesrPUibifmO7MmJEtb4pK0JyuVy3zcqjrZ5U+0Th0IxmvIs60biq9UFps3z1I4
	2nIT9/Q616zHwyKfVeK5uMC8HFmFB/c9t1YDztOU/oeQMECPXuxEXfzCRzmz5wyAY+5B2mQI2hI
	UqN3p2hmLidOUjd6psbWh+JxtyKEc0wd94L+U54zX/LDjZjbtDIbCKoARBOsMzNaWLfoO7RRg2F
	EInDeSNmuLxyE9YnRfgObcZ5wLqv2kEMnHYYAu8GkYz8EEB7cgQsxPXxIjP0SYqj669t2URTSrN
	VzF5TRlC7X5SZ98/LvY4EoJFwB5U2w08NURjV8Ek0A==
X-Received: by 2002:a05:6122:608f:b0:56a:8f7c:49aa with SMTP id
 71dfb90a1353d-56f94725c32mr1843622e0c.4.1776349300022; Thu, 16 Apr 2026
 07:21:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260328172314.45807-2-dorjoychy111@gmail.com> <aeDpIgfDaIKEaBcL@lt-jori.localdomain>
In-Reply-To: <aeDpIgfDaIKEaBcL@lt-jori.localdomain>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 16 Apr 2026 20:21:28 +0600
X-Gm-Features: AQROBzCVSNvQ07toCtw3F1sHPLg5Z_-nre3iq90Dw0MflD8nQqdsL_RQ56rFZc0
Message-ID: <CAFfO_h6pkyX=uN5uoXda6toTtT6KsahfBNBLom9i21HdZ7JOmQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
To: Jori Koolstra <jkoolstra@xs4all.nl>, Dorjoy Chowdhury <dorjoychy111@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, jlayton@kernel.org, chuck.lever@oracle.com, 
	alex.aring@gmail.com, arnd@arndb.de, adilger@dilger.ca, mjguzik@gmail.com, 
	smfrench@gmail.com, richard.henderson@linaro.org, mattst88@gmail.com, 
	linmag7@gmail.com, tsbogend@alpha.franken.de, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, davem@davemloft.net, 
	andreas@gaisler.com, idryomov@gmail.com, amarkuze@redhat.com, 
	slava@dubeyko.com, agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org, 
	sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	shuah@kernel.org, miklos@szeredi.hu, hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 7:52=E2=80=AFPM Jori Koolstra <jkoolstra@xs4all.nl>=
 wrote:
>
> On Sat, Mar 28, 2026 at 11:22:22PM +0600, Dorjoy Chowdhury wrote:
> > diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alpha/include/u=
api/asm/fcntl.h
> > index 50bdc8e8a271..fe488bf7c18e 100644
> > --- a/arch/alpha/include/uapi/asm/fcntl.h
> > +++ b/arch/alpha/include/uapi/asm/fcntl.h
> > @@ -34,6 +34,7 @@
> >
> >  #define O_PATH               040000000
> >  #define __O_TMPFILE  0100000000
> > +#define OPENAT2_REGULAR      0200000000
> >
>
> I don't quite understand why we are adding OPENAT2_REGULAR inside the
> O_* flag range. Wasn't this supposed to be only supported for openat2()?
> If so, I don't see the need to waste an O_* flag bit. But maybe I am
> missing something.
>

Yes, OPENAT2_REGULAR is only supported for openat2. I am not sure if I
got a specific review to not add OPENAT2_REGULAR in the O_* flag 32
bit range. But as far as I understand, for the old open system calls
we can't easily add new O_* flags as the older codepaths don't strip
off unknown bits which openat2 does. It's not easy to add new O_*
flags for the old open system calls since that could break userspace
programs. So I guess it's okay to add OPENAT2_REGULAR in the 32 bits
range anyway? (Also lots of code paths take 32bit flags param right
now and those would need changing to take uint64_t instead but this is
of course not a reason to not add the new flag outside of the 32
bits).

Regards,
Dorjoy

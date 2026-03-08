Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC02D392816
	for <gfs2@lists.linux.dev>; Sun,  8 Mar 2026 17:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772989826; cv=pass; b=PT9CzXT2JKsBItFhJiKyuwibsJu6VMLnLh1+KKgeO+82G9QOc1Pet4ldnhJfc3v3Pm175Gj8SGpdrFFru18Bgtohl6aJTlIRJ3MR0wAAWWcwBOK1nw+Xd9S7D70vL7Qm4UOP3lGEf8LCZ2QBP5TArG+1mLb+do0KYZiHMZkv1i4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772989826; c=relaxed/simple;
	bh=mPpVNiloCu6uzQI1WxZPytR2t4HpF2nlFZDXYS8kVTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1SmQK8j4xxUpFHEXSvp5xk1wzsGKeF/x7x95J0NA3Ke3gC9wNIJVToaYo95SyFYY+9vICsBkmyLwTNFqx5XzXzW14xmDjN1+Sg6nAmaZ+FsW1sJGZvgjURj6hynw26McmVmNZQHr/YD0+9wEYwu0GcjOuMmp7TWjnWMZZccHHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=rkNHNVY3; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="rkNHNVY3"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a1330ac6c3so3654863e87.1
        for <gfs2@lists.linux.dev>; Sun, 08 Mar 2026 10:10:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1772989821; cv=none;
        d=google.com; s=arc-20240605;
        b=KmLzWVtG9dMwPtR0LTF4mIIfkTt73Yum0cgRHvKqNpFPPyOe5Y/p1nPiCpjCqgNduf
         d9sbSAtbI7CJ5mM/L5isvFa4ZAKi94yLqkYJ3O9fB0sAbvgAlIimiUhwultj77KR0Sds
         XH/I0zXhIsOi6GkmjGWuLZ+g2yYS/r1K1y1jxdpFyUWcjrXYGqtzSig0ARuwZ4ubRvSI
         iV+hcU6yTr9J/LtN6D+8bLWtpB/Dc53Y3sber1xmh2xD7Cq8dMX06cBfneJmSvY2KwXi
         imTlk0ogMS/hTgSrzEJH6VUNkUT6PQEFmYNfMzLg+GJkggwgqptBQfllM22FTGYAiv+9
         83+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gg9ZdLv2ki48mUNl69QeK9y3vC32V/8zR5xNICHMQ28=;
        fh=9RA7RkxXRK8Fmw+jzBD5IhYLJWYp63kVq2BGzOYyH7A=;
        b=YUtgszSPtp7hGAAIFHeF++0/lhVYooluWifu58HxbrYH9u6zU1FYKSOtoxIp7AppQD
         Ps+DWQmMw3yAhG3r2egpw1gnsvefpq6T6ilgrtu8LSx/LkJ9DZ4cAazT3yGDetpWkaFO
         aDmMfYDRafmznQfQREiYWyHEa3K4SxvbTD4EqyKk+eTXKAkypgxD3N1CDwFcVidq8fHe
         P75aZ2XLHWJIAZAAOxWv/rmHET+sqtsbPG0b3ZpYZ5lfSEKNsSI4xnsbsUtZA68Tpjmj
         znXHzvbMuAKZmBa1g98rhP7KbaQ6XCOLCb2oqu9CNoOAUv0ckblaOIUA0nBaJh8T7udJ
         MkGg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1772989821; x=1773594621; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gg9ZdLv2ki48mUNl69QeK9y3vC32V/8zR5xNICHMQ28=;
        b=rkNHNVY3S6GL1IRmDUzZDsGTamb3/JlqCwNiIRPlrHH1HXS6yJVEwsTHQATyTI7Sfy
         qH5aT9kZcoy54PIdYRJLGBk9d1u+LbsiZOf+Z9kR9rluPQhwlBIZ3hWfE5c5rG5o75Zq
         x8tAZJ++9Ae/9dxe16+ntCd/W1uZuaMctO7LDm72FwcdMHRlO2K7oQkdEDuYKydWgLCF
         DxpgGQO+yOvIZMt2ygwaR6wSShvOykxQ9PeXsZMyoyMJ4PgUTwrnJ0lQOjVrfT+tGOyo
         tM9nj4HAzkoCogNlVaBjJlmq+9Ap/PphSvPoRPIMRWl+l0cDwjDEjFJiUMyOaDT1Oo/A
         br+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772989821; x=1773594621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gg9ZdLv2ki48mUNl69QeK9y3vC32V/8zR5xNICHMQ28=;
        b=i66FzDjqsOikLkA/P0aTTAghljdugyvktJMRxX/TzINxH/ccMzKHTsTQKQnCkJg1qi
         G+iL+0qX8nubFYEAtlqYSMmHHjvyAQIXYRD1RdQl4ikBvC+qKWtKPIe1ZPpNozKViUNe
         pNpvgf8bQ5E67asWz77pFr3sy3AnZdU4CUQdY3BKPflbUfa9ywmD6oemzQw1LTH0yH5w
         lFyrIinyaYHm3KigfIt9G3mRd7yzXdxfsC6w6iA9pVaT5G5Tuvvro1+pD3ktp9oawR2o
         oVAl1okvZ6XZeOMeNIbmt0aq8+d+MiUnK+1lqAeLqK8ZAbrR3w/SBt+xyJwLAjz7lxTJ
         abJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhwKlJR7A+gAMyJi66Ls0K0j98m5BpPfq/oc77Lxcy6G6t2Oeuf2raDsUJ2Mzy0mnw3fs9@lists.linux.dev
X-Gm-Message-State: AOJu0Ywed9Vcqg8X8uDs/jPnx511s2KLJFP8J6f5etOIg4Xe+nz3/crT
	NNmXbAb5VeFmp434fjsNdHO5hrcogLP3OmSmWFIzkYYauNzhxTujw6lwQj9hsLChEcB3K9aa3N+
	yQaoO4qhbPiwx+HzEu6LJbF+t289ZTSCiEjboyc4X
X-Gm-Gg: ATEYQzy1TvosKgRPChwaLMs5HdlBqChOekkRCUwmEHm+dZn+XWb6YriB1hT6RRu+q3y
	mLHOov1dD91B0m6pfFJekLrZ6UTQYc3pNa2nyc593nJHTGoxuE5MLU7pSYnF+uO6qtgIIKFxgwi
	Nd+kgCsgER66nigKjPHQRHTSknPz8d/fbLiC6GJeD5fGI7qLd0RiFMlgLmkiYhWgcGVw7uiCTCt
	fkn3EbKGk085f277tX9ZRruVWxo4rIMO8fzV/GLF4T580Dq4s9eGd426Z5FDQshHHUhgbfv6nw6
	qQLgHyDcY+0o8EA=
X-Received: by 2002:a05:6512:10c1:b0:5a1:3539:1181 with SMTP id
 2adb3069b0e04-5a13ccc6854mr2584241e87.20.1772989820622; Sun, 08 Mar 2026
 10:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
 <20260307140726.70219-2-dorjoychy111@gmail.com> <CALCETrXVBA9uGEUdQPEZ2MVdxjLwwcWi5kzhOr1NdOWSSRaROw@mail.gmail.com>
 <801cf2c42b80d486726ea0a3774e52abcb158100.camel@kernel.org>
In-Reply-To: <801cf2c42b80d486726ea0a3774e52abcb158100.camel@kernel.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sun, 8 Mar 2026 10:10:05 -0700
X-Gm-Features: AaiRm53NE6RSEVl9G8ylA7uki0xCjhtuxwfA8HvbEL_OVbVZXAi0saXeclsKpvo
Message-ID: <CALCETrVt7o+7JCMfTX3Vu9PANJJgR8hB5Z2THcXzam61kG9Gig@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] openat2: new OPENAT2_REGULAR flag support
To: Jeff Layton <jlayton@kernel.org>
Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
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

On Sun, Mar 8, 2026 at 4:40=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Sat, 2026-03-07 at 10:56 -0800, Andy Lutomirski wrote:
> > On Sat, Mar 7, 2026 at 6:09=E2=80=AFAM Dorjoy Chowdhury <dorjoychy111@g=
mail.com> wrote:
> > >
> > > This flag indicates the path should be opened if it's a regular file.
> > > This is useful to write secure programs that want to avoid being
> > > tricked into opening device nodes with special semantics while thinki=
ng
> > > they operate on regular files. This is a requested feature from the
> > > uapi-group[1].
> > >
> >
> > I think this needs a lot more clarification as to what "regular"
> > means.  If it's literally
> >
> > > A corresponding error code EFTYPE has been introduced. For example, i=
f
> > > openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
> > > param, it will return -EFTYPE. EFTYPE is already used in BSD systems
> > > like FreeBSD, macOS.
> >
> > I think this needs more clarification as to what "regular" means,
> > since S_IFREG may not be sufficient.  The UAPI group page says:
> >
> > Use-Case: this would be very useful to write secure programs that want
> > to avoid being tricked into opening device nodes with special
> > semantics while thinking they operate on regular files. This is
> > particularly relevant as many device nodes (or even FIFOs) come with
> > blocking I/O (or even blocking open()!) by default, which is not
> > expected from regular files backed by =E2=80=9Cfast=E2=80=9D disk I/O. =
Consider
> > implementation of a naive web browser which is pointed to
> > file://dev/zero, not expecting an endless amount of data to read.
> >
> > What about procfs?  What about sysfs?  What about /proc/self/fd/17
> > where that fd is a memfd?  What about files backed by non-"fast" disk
> > I/O like something on a flaky USB stick or a network mount or FUSE?
> >
> > Are we concerned about blocking open?  (open blocks as a matter of
> > course.)  Are we concerned about open having strange side effects?
> > Are we concerned about write having strange side effects?  Are we
> > concerned about cases where opening the file as root results in
> > elevated privilege beyond merely gaining the ability to write to that
> > specific path on an ordinary filesystem?
> >
>
> Above the use-case, it also says:
>
> "O_REGULAR (inspired by the existing O_DIRECTORY flag for open()),
> which opens a file only if it is of type S_IFREG."
>
> Since we allow programs to open a directory under /proc or /sys using
> O_DIRECTORY, I don't think we should do anything different here. To the
> VFS, all of the examples you gave above are S_IFREG "regular files",
> even if they are backed by something quite irregular.

That's certainly a valid and consistent way to define this, but is it usefu=
l?

--Andy

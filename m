Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3033D7D6E
	for <gfs2@lists.linux.dev>; Mon,  9 Mar 2026 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075034; cv=pass; b=kvv7Wty23yCzIr+HK409mdKyVHKHfJabPWBYWUx4SaHKE7ptT2JUqVBN8QOU7ChIT1SssOZfIy4ZaZL67zzkCQLird8mKtkN5hXfQgzG96XXkNZjifFMlHciHzBamkKOH60HOSEOeH758ScaXUxtS8Z6Y4u7b/Jjj9FXzlfAL8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075034; c=relaxed/simple;
	bh=dElGlCWfTDUCaV3zjXVrwEshlrdMTwzM4Mn069fiLm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Peu//1p6xu3KctojSddy9Iu7xTmegeglWqHR/aF6PYWD1ndUhLSBnYvvcx7cGSizgG5X6o0VXL4/UXX8xK65vtyxmG4AcbaGNCWzCazZP+LpnD82baIR332Be2s+hEsPkgcvJItslGHAgUYnof10VmxewvlgvWpI/zJDWidQ8Ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=UcjeJYuJ; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="UcjeJYuJ"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59dcdf60427so6723183e87.3
        for <gfs2@lists.linux.dev>; Mon, 09 Mar 2026 09:50:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773075031; cv=none;
        d=google.com; s=arc-20240605;
        b=JN4uRlzZfCON5EkOQS1KJ8Sj/qqi3Ps/zSt1O0drfgqBb3Y/AOGzObpWmMxUTqTHNF
         cmgTI75ekO1+jxj/mGK5wa2SD9RudA1by6YZIUg9eIEw6WCTvGC21mfZOIT2yKUpn/Mn
         AtGvrc42zXWbqFfLSSXW/tZBk66Li+a5eXMp9kqFWTAxBWbt77Moyr86JdE9PHTJKLjR
         BchJMnIxtgGWFRljnIGLVe4S/9jWYnnjHpxRNOR7Ht6MbGnrsf/ZKHO9/xhjn5blHrx+
         QKnD2Ows5H/b85JGWuXe6iHemCTcX5G5YaDJgsCzPHogNRcwn5E8+NA5jX52vbAAEA+T
         +X8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1qXi97N/dEOi9sir8d8Z87lcT7PElOkZiITQbx2fwCc=;
        fh=irRSuFSZYnzyYIF3w1keK0HldNfwK0aKCP/BIjh0MlU=;
        b=lOSARr4f84lZ+cToFq8NqFXKFaKhDkcW4POxgHDGwuRq1X3MXDoR97dUo+gfsWdYh/
         nDwxDPYksPtaWI5UUumLeGHds3ocVV0n5s7LMjxLEFMUFNHgtqmOhwEXdM1d6qveSQ9H
         x7MmF5t9rVQ6B1Q17vNuts5x/u9kmlNpzSnnnuGrI1l2x+GNANqlMdvAXjx/goL+eY3c
         g0ZiSc1/H5+EHinWwvoxzNylLa8KFE08OTcFkNvd4ZDdOMfuDaxlkkyUY5iofPBqRawM
         eidGZ8Ejwt2nryEzPtZuNFPTG4V+35Mh6qxPMXH4C9SNwDnSOWASBiiRUohdzTj9lWsq
         MjbQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1773075031; x=1773679831; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qXi97N/dEOi9sir8d8Z87lcT7PElOkZiITQbx2fwCc=;
        b=UcjeJYuJZzFQG+SJZgTxVUgESAKbc5A28ur9OMNPuF2pMc0wbg4Hbfp4nqWmb7NqQw
         vK9Enuslwy4eBGwz19ywhs9uKL7bHA58IWKMtu+AYqWTNfFsrUy2o18mWHNZWPXu/hdf
         orpPmdClhc5tWl9UmlCbFGlSPgmftpz1aNwYqmenL6BICWoe4Eca3oKHAXQmqOefCy+M
         dNvW4vtUGUAGjslp/ap1ZVpr73Ir4hp0KVZ35fCv4yVfhBAI5R27Zw++MHkd46wqG36n
         HuANY2rlRpjE0lrlT1jGr9w5zaLmjdm0ullPsqA0syR2oARIoE05PPg8bAtGb4OkSofK
         CKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773075031; x=1773679831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1qXi97N/dEOi9sir8d8Z87lcT7PElOkZiITQbx2fwCc=;
        b=CECbtfuPieCvTatfKNHnV1AZCltEeiOomk9QhGVs3V2Zih+xz3xm/bWNGXmHr01VT7
         am2GhcOt/tJVxVDHLnJn79tuzu+oFrLtZUTif7nHd/y/8NLQeR6F1Zz9jMGMs0NStBje
         fA9EumA+KN057NCM2oIf3lOvlvviZIgrKrpIx4r1Ktmq9y+KPpEHRzX73Hp7rkKg8au4
         kjs9Va5xaUW3IKOBfoBuHdb4ILEFXofSgAb3c/3yGrIt86hOsUn/8jETHFfnN20evvAA
         UR3+OxeUTVgalZZvprZtdiTYZSqZbJIZJePA0p8oo6iivUwVJbXfp6fnDTCnR6vvDOmr
         7xGg==
X-Forwarded-Encrypted: i=1; AJvYcCXTIqxapBjPeS67G0X2vhOtQ/Lf5jET6JnL4XByAOHkdbB+nlPpHjf7++gELtAPLgc5eAm/@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2Cl+TRZhbU17+XMIlWaIwMAFCPM75lqpT5zsjstA5QyGxdSsc
	I9K+1mye8fqaSsBqU3b407eyGgAm+RdB7jGow3cvtkQWq6XEYbsm/2GdnJwzuYNzo+9GhkE+WRn
	R+MYuG1POcAwBi5nM8B2suRpvjMcjw27zGj70heGZ
X-Gm-Gg: ATEYQzw5M4MtL8DJzybcNVH9jnbSdt5dx5xId8Pm1lJaqcpexX6oVDg5HzCwKMzwEDR
	L1SKx1LYVgjWAocA/WbGccqI7VeaQ7sUQoc8lxrBX13iIHpRTQXkv8qctAmcz9FEKU72o0I29mH
	qctekB4rU2aRnSJT9Y9l5bVtrOf98NyEYPC+b1WcZK6+bQeW8J6js9Y+0+fGwG2hT08J2iU8xX9
	yGhnZD79h12SB4ITD0rJ1iQbgMUAnvPKWvkbZa08D7brtq7SmHKiVsQSazwuiW2wbEyoqrCuQdH
	n+23G3UIktoo718=
X-Received: by 2002:a05:6512:33c9:b0:5a1:3d7f:8fbb with SMTP id
 2adb3069b0e04-5a13d7f930amr3518616e87.2.1773075030208; Mon, 09 Mar 2026
 09:50:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
 <20260307140726.70219-2-dorjoychy111@gmail.com> <CALCETrXVBA9uGEUdQPEZ2MVdxjLwwcWi5kzhOr1NdOWSSRaROw@mail.gmail.com>
 <801cf2c42b80d486726ea0a3774e52abcb158100.camel@kernel.org>
 <CALCETrVt7o+7JCMfTX3Vu9PANJJgR8hB5Z2THcXzam61kG9Gig@mail.gmail.com> <20260309-umsturz-herfallen-067eb2df7ec2@brauner>
In-Reply-To: <20260309-umsturz-herfallen-067eb2df7ec2@brauner>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 9 Mar 2026 09:50:18 -0700
X-Gm-Features: AaiRm50Rb5608a_d1ziKt7e3a5xZPZu4oB7F4zw8iu_Gm1KsPQukeeL-PdrpHz4
Message-ID: <CALCETrWjb+V-zrMT412MtmgDCx9y8simJBQ7+45C9MtdiSMnuw@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] openat2: new OPENAT2_REGULAR flag support
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Dorjoy Chowdhury <dorjoychy111@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
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

On Mon, Mar 9, 2026 at 1:58=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Sun, Mar 08, 2026 at 10:10:05AM -0700, Andy Lutomirski wrote:
> > On Sun, Mar 8, 2026 at 4:40=E2=80=AFAM Jeff Layton <jlayton@kernel.org>=
 wrote:
> > >
> > > On Sat, 2026-03-07 at 10:56 -0800, Andy Lutomirski wrote:
> > > > On Sat, Mar 7, 2026 at 6:09=E2=80=AFAM Dorjoy Chowdhury <dorjoychy1=
11@gmail.com> wrote:
> > > > >
> > > > > This flag indicates the path should be opened if it's a regular f=
ile.
> > > > > This is useful to write secure programs that want to avoid being
> > > > > tricked into opening device nodes with special semantics while th=
inking
> > > > > they operate on regular files. This is a requested feature from t=
he
> > > > > uapi-group[1].
> > > > >
> > > >
> > > > I think this needs a lot more clarification as to what "regular"
> > > > means.  If it's literally
> > > >
> > > > > A corresponding error code EFTYPE has been introduced. For exampl=
e, if
> > > > > openat2 is called on path /dev/null with OPENAT2_REGULAR in the f=
lag
> > > > > param, it will return -EFTYPE. EFTYPE is already used in BSD syst=
ems
> > > > > like FreeBSD, macOS.
> > > >
> > > > I think this needs more clarification as to what "regular" means,
> > > > since S_IFREG may not be sufficient.  The UAPI group page says:
> > > >
> > > > Use-Case: this would be very useful to write secure programs that w=
ant
> > > > to avoid being tricked into opening device nodes with special
> > > > semantics while thinking they operate on regular files. This is
> > > > particularly relevant as many device nodes (or even FIFOs) come wit=
h
> > > > blocking I/O (or even blocking open()!) by default, which is not
> > > > expected from regular files backed by =E2=80=9Cfast=E2=80=9D disk I=
/O. Consider
> > > > implementation of a naive web browser which is pointed to
> > > > file://dev/zero, not expecting an endless amount of data to read.
> > > >
> > > > What about procfs?  What about sysfs?  What about /proc/self/fd/17
> > > > where that fd is a memfd?  What about files backed by non-"fast" di=
sk
> > > > I/O like something on a flaky USB stick or a network mount or FUSE?
> > > >
> > > > Are we concerned about blocking open?  (open blocks as a matter of
> > > > course.)  Are we concerned about open having strange side effects?
> > > > Are we concerned about write having strange side effects?  Are we
> > > > concerned about cases where opening the file as root results in
> > > > elevated privilege beyond merely gaining the ability to write to th=
at
> > > > specific path on an ordinary filesystem?
>
> I think this is opening up a barrage of question that I'm not sure are
> all that useful. The ability to only open regular file isn't intended to
> defend against hung FUSE or NFS servers or other random Linux
> special-sauce murder-suicide file descriptor traps. For a lot of those
> we have O_PATH which can easily function with the new extension. A lot
> of the other special-sauce files (most anonymous inode fds) cannot even
> be reopened via e.g., /proc.

On the flip side, /proc itself can certainly be opened.  Should
O_REGULAR be able to open the more magical /proc and /sys files?  Are
there any that are problematic?

--Andy

Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F44427F73A
	for <gfs2@lists.linux.dev>; Sun,  8 Mar 2026 06:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772951479; cv=pass; b=mc/29/tfxLbSdzAALHUtY2Xek7zhP3YFlSGJ2sbz/kZiw0ew1UajNUibRkJfTZ4wLPrN5Ku3boTe0VV2ZEBLQnaCEwCFQGjoT1xoabbCkceUmmkoozLX/KzieSRHVuey/N9NIle7C2eXrwxi7SAl4ptuvjkkG+FvoiDni6MUhIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772951479; c=relaxed/simple;
	bh=bqMEOQ0Ckcrgyric5QOWebyRcZKyiXhkKZw3Ukws05o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BI5YrYedZbb9qHOHWrFdXixqlYXV8vb//1Xnbe8J2jL0CSHTNQbr6nce+dLJrx974acEWqH1Ayti0l9MWESnoAQ64VTgygw7TPmqdnstxKmgWqTnOF8uoRwuYFXrAcZJXE+JO5EL1xwZfIrgLXVMmKYQVNqKZWFsa0XuTL6mmuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LY6x3S8p; arc=pass smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LY6x3S8p"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-94aca174532so2884802241.3
        for <gfs2@lists.linux.dev>; Sat, 07 Mar 2026 22:31:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772951477; cv=none;
        d=google.com; s=arc-20240605;
        b=CXStbP+cpyrN7XDxvu/gpClOEHJaqIyLIThb21fmL72V21WzxE8OauLTlUx87xL6uw
         8n7qqMHXVFHf2Doat/+9kyc4ghGV8z+3MkFPjLhLt0W8V3+Iv4+m12jytGtZPN7M0ygf
         mTfruQdO/VOrdmRpuqHEU9s9G4MwSSGcP3socxCd+sh4RnZglZ6TjibREhb9uCrH2Mo2
         xBuboVs8c9PKSKivAFUC4bx2dUnNqQQ5P4NiLvtGJy0lEu2zAjCr6XvWETMTvhUDvkEB
         gk4bZ/pj1inS/N9wftCVNM5M6HfGCQ7WvXkS+2TigqauyrEJ1zNDW3zRTavuwTHdQcUt
         00Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wmFGvCnSNVovQCGgt6RuGUFVOm9BbgW1X0Xq7Fd9owU=;
        fh=d+Ni7clbvBq/EjVcq2USh37lj+Zb1N/zC/chk00Bs8w=;
        b=X5S+2dVCzzKqCABU4tLO1Nlph2SJ1+7s6DfsoyvIGTYmf9fCDg3vi9jXKpj16NZFYN
         FVCe/xoW32THH78sG0sgOW4Uw2jd6wlyOW1OUqP7F/FuwHW+9rJ2ZMMxxwfD4qCC/vmG
         cYIJ2uoacm+I/BrSuTuZWfRETGuZgkbmwLZozHsLIk/RCczDh9mI6bgu13EY0MuM+rra
         uZpvKJ8TXK/cZos9U7XWkyF/aXXGTmNs7QIid53z+IlaQ2LWC5OrtiHvTwzDC5ruZNtT
         4LBPiYklfncYsXt5moEW72EvFng2GwJnRN27D6AknjEiBLiePQWraNkL6ffhFlycXiI5
         P/MA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772951477; x=1773556277; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmFGvCnSNVovQCGgt6RuGUFVOm9BbgW1X0Xq7Fd9owU=;
        b=LY6x3S8pCIfbk5YNWPPE3wII3LPou2MSvcMlEbe005o1/ttqWZQcuXoaX0LDZZJpxo
         D68J4bR3JS7h1PMgZFd6gBapEk3KGkWK++LuCGNUarCm8vQK+kaYBQT05998zzazucjq
         Id+dd09KyfKEzESUrVmxBzFm9nfgH42YAQbXOEChu7hwhXb/XdG33ChjPazVZCdd1mvN
         dIUD5RHXqawGVDcIcjVwBqy3UNTxK+Ec9b0zFJMv03nD1OyWX311V84pon7qUTNcAwx7
         0Ec0qKfZ7db1pFcaaju5mEA+oHMJPCi5Sq+MfBCdZldeOxQHEf6/rWvr7j6eJWdARUrw
         EYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772951477; x=1773556277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wmFGvCnSNVovQCGgt6RuGUFVOm9BbgW1X0Xq7Fd9owU=;
        b=WnuQDJBhlk0RkvmjFyYzZeUXpOij1LWsnIvqlztKq7v5vizMEnlPh+uteenNo5mBGM
         B6+CkzifMa3VZahDUsnJKykFNVhFVGCwRCLmSaFC8d5vycbQrzmm2m314levBJ3RwrOf
         tx+uC5XKuyzsl8NHl8fN91lGF2hP6srr25AuNrqd4yAqCb9Z4rJ/dIv+p4+/Jg3Eau7E
         Xn6Ut/LY2G0ALYa4qWkhas9WFVaqM4/L08pJaMNEmKHm36yfYbNlhFGPC3KtDL+bJ1Jk
         KBET7AiUXi+PlPgY6l5H8KUkXsrrmpOjHETfl1MLOKW3kVXX2j2Jot0StsKvuFjPN473
         oXMg==
X-Forwarded-Encrypted: i=1; AJvYcCW+K9/aZkc3WWx5tfuMk+3nNh/wOd2rS416w8BmoprNJMnY2h5zCh9oH8pWQGCfAurts9Wp@lists.linux.dev
X-Gm-Message-State: AOJu0YwRcR1vo7DsFSpOG2GfWcgslXoYE7wcraFxoRTv/sEOxPsLrk8Q
	5eHCBuvCqF1dxrcpxwUyJbXCi3usA0P0+DsNbnQoB1vkFwff0MswLB/OQuaSEQOax4QUp09xb9y
	IAcq2ezRc90nYUani/6WI0Teb447UrxQ=
X-Gm-Gg: ATEYQzwtkbmvLht7s2DINa7uqGkgyWUaf46a8hRlFKnlu/3ndtGYOTsJIbz1v5Z0p1U
	S8+F2v6kveUCZ3lm3v4kjLVfooGfTc/IxzjQK3G8fNK/jVNugIgHrOScNzTxvWYdforOWqSccuq
	Rbm1doc7qCpDdiJ40xKg0BIhxTId0q0r6AvgYRvBJsXi/3yqLhnJFXKLzBOmgYaoDCmWzR9Rb79
	P4sqsS9D3+yA2Nr2sa/DM71hJHuDsBqDvtbNel246JKD6VBxwpTuaXauL9crU2dNRP0ron+TL3l
	r/NG372jkfUp1wSlakC8P91Io7pXlo5NVsWe14SJmg==
X-Received: by 2002:a05:6102:41a6:b0:600:11e1:2a4b with SMTP id
 ada2fe7eead31-60011e12bf3mr732622137.34.1772951477120; Sat, 07 Mar 2026
 22:31:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
 <20260307140726.70219-2-dorjoychy111@gmail.com> <CALCETrXVBA9uGEUdQPEZ2MVdxjLwwcWi5kzhOr1NdOWSSRaROw@mail.gmail.com>
In-Reply-To: <CALCETrXVBA9uGEUdQPEZ2MVdxjLwwcWi5kzhOr1NdOWSSRaROw@mail.gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sun, 8 Mar 2026 12:31:06 +0600
X-Gm-Features: AaiRm51WCqo6sYLOpIV6hZ1XNIYME3jM_VRhuXhqPcz8hjUnJuRMBp96SANcO1M
Message-ID: <CAFfO_h4g-QtE1gsp3nw7+BUYnRj29au=pYs1goEnppbdU-8DbA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] openat2: new OPENAT2_REGULAR flag support
To: Andy Lutomirski <luto@amacapital.net>, brauner@kernel.org
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

On Sun, Mar 8, 2026 at 12:56=E2=80=AFAM Andy Lutomirski <luto@amacapital.ne=
t> wrote:
>
> On Sat, Mar 7, 2026 at 6:09=E2=80=AFAM Dorjoy Chowdhury <dorjoychy111@gma=
il.com> wrote:
> >
> > This flag indicates the path should be opened if it's a regular file.
> > This is useful to write secure programs that want to avoid being
> > tricked into opening device nodes with special semantics while thinking
> > they operate on regular files. This is a requested feature from the
> > uapi-group[1].
> >
>
> I think this needs a lot more clarification as to what "regular"
> means.  If it's literally
>
> > A corresponding error code EFTYPE has been introduced. For example, if
> > openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
> > param, it will return -EFTYPE. EFTYPE is already used in BSD systems
> > like FreeBSD, macOS.
>
> I think this needs more clarification as to what "regular" means,
> since S_IFREG may not be sufficient.  The UAPI group page says:
>
> Use-Case: this would be very useful to write secure programs that want
> to avoid being tricked into opening device nodes with special
> semantics while thinking they operate on regular files. This is
> particularly relevant as many device nodes (or even FIFOs) come with
> blocking I/O (or even blocking open()!) by default, which is not
> expected from regular files backed by =E2=80=9Cfast=E2=80=9D disk I/O. Co=
nsider
> implementation of a naive web browser which is pointed to
> file://dev/zero, not expecting an endless amount of data to read.
>
> What about procfs?  What about sysfs?  What about /proc/self/fd/17
> where that fd is a memfd?  What about files backed by non-"fast" disk
> I/O like something on a flaky USB stick or a network mount or FUSE?
>
> Are we concerned about blocking open?  (open blocks as a matter of
> course.)  Are we concerned about open having strange side effects?
> Are we concerned about write having strange side effects?  Are we
> concerned about cases where opening the file as root results in
> elevated privilege beyond merely gaining the ability to write to that
> specific path on an ordinary filesystem?
>

Good questions. I had assumed regular file means S_IFREG when
implementing this as mentioned in the UAPI page:
"O_REGULAR (inspired by the existing O_DIRECTORY flag for open()),
which opens a file only if it is of type S_IFREG"
I think Christian Brauner (cc-d) can better answer your above questions.

Regards,
Dorjoy

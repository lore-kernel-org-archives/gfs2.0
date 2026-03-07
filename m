Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74F436214A
	for <gfs2@lists.linux.dev>; Sat,  7 Mar 2026 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772909795; cv=pass; b=Xt+IOf8HnCBueqUenT8k3AVpLvxkJKtURLi7ppHzddEzA/6qGJRbqwXHEF5EurPte8afP5Rct2PHQLxrGp13kUTPSf+MpnoDuvDntpGk9h4Q3oNHRX9pP26JKYaupQ5l6xbNkrRDAUlazcSCskdZWqgRSk8yla/BRaLED+fKFWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772909795; c=relaxed/simple;
	bh=ipPnoEwRKGay/Kqh3e72TxDAS0WvWm5QHtGzwkgIhmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKfRkZXV6oS/+Uy8RjTrxUpHNCJZGe43UU6yOBVRZWuZhWl8yzi4IjoCqeEnQqK7Rjrcxwt1rR/R6WjwFp3GIgMOarOyvzlyz+KF0vxI9CpD0AT+pveqgshJxduD6jobE0Lcp8ws+T91GJKoI650NoP9T124pR1Zm9K2Lx4S0qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=SqZyTEVh; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="SqZyTEVh"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a12c19affeso3643722e87.1
        for <gfs2@lists.linux.dev>; Sat, 07 Mar 2026 10:56:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772909792; cv=none;
        d=google.com; s=arc-20240605;
        b=S4Q56FXm3xynKeo2KgrKIQ0IUW5wQnBZrrsIHaTuat0tUqxP9RaLIQWW4NHeqnMQrG
         B8cNnK0MWuE9c9Jkc77h1azthBOWPIQOcmI8osuiMCqo2Ej1VHFM7kd0hgrQYaYvYfsh
         xlSKnpAykSYzEDHnXKvmv3GKJmi83VkwyHlR+LlwzZ9xEBZYhNW7zAaFmG3oqqrg/v2e
         Tl02IW/GwouPOAOHRR20Ct/sX9ioS6nBApZKUVTmhOD+HlvVGELEh1Mrz2FBSzOmjy2S
         5BDTfUVqCIdv3dp5cje6usOZSHWFhdoDsWsUNT3rss3kobOujInSL0v+W8Z4LYCfzg/H
         a2sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pxUV6l0cXcVJnfGWc1SwZOsz+kJgjCkHV5Xd2O+xjBY=;
        fh=EfqtIoo7yMa6q1CjMlh3CFHexnGvYoxR35DgbmW7bD0=;
        b=WkMqF7SU0z/j/IH0FqXHhbUEtw+AuxDYYDp2GpKAi9r71LjEuf2CxPWwRAmYgiY52X
         sJtP978AjouJM9EqlG8VlyDThJoz9RF8FwBQrIk6a+LXcfbOmWPOLBrSDiIYCHgmtrPq
         iHjAkVs1oaaE8/BiV2HJNFCn+NXQjdXsBrHSQFStTlYnq/U8TT0DqPgbKh6IH3pGO5Dx
         4NhlrRzWi61d4xprmYKPhktDea9fUsG+F88FQPCdZhstWyYuaQ/XHHg5ACRxILJ/rkvy
         nbl3YKbf6A8ADv8v5bVxAVFSYAWwT+Pp7t7RliJD2XvH3oC0ULva7q8XjNYfreHsr9h3
         KC+w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1772909792; x=1773514592; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxUV6l0cXcVJnfGWc1SwZOsz+kJgjCkHV5Xd2O+xjBY=;
        b=SqZyTEVhZ3F7inxHVHbc0NvMEIKNoiEbgTdSx+E8r3qeoQTj9oefSZO0QZs6OUZVWT
         M2kZ2SLlXMhWYyBPhv6kEclcE6I//ARb/yyUy1sneWn/tMXFwqa9MzyHmsfU5LcLVYJ0
         CXw7eVXQr/6C60ws8ie8lyFV4fHSLCCcLgXNc5B7fsF1IGNyJkIvguuBMagz8GnawJ1m
         aLLq65ezHYS/beVaLvRLT3c8oC33d8XgoOmiH5mtMu9aYQvkNQslvM3RJNtPOsrHc+3b
         fYelXc0dP8ylFU+SlvMRpb5v1OIiTwWlAXN1AR0GpLX/AbNHr3AXFYHWnScrMC5Pt6wt
         dE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772909792; x=1773514592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pxUV6l0cXcVJnfGWc1SwZOsz+kJgjCkHV5Xd2O+xjBY=;
        b=QvNZaHxK0gvJbZ9CTtDJ4JGI7InXzLCwp08+UdnbE0YB4wLOUVZerfWzeUYlkFWSY3
         IiRLH/6+Jjen6A667fsJ4a+vh1sEOtldt/LUpksNK3lQBcWycfHMNdugZZK8KXxxYUu9
         yQY9q5vxAWJPpo5kfqU/vHylixxvN+bWBtLoHeRTiK6rlr55MF/B/QR6Ec9hhQNTwzN4
         SJ0xkLKyEhhKhLDk2G0gOt06SODZ6UcsqMN0d4zEMLdQjatgRIS2tP05TONfjZ8Y9x4y
         NQ6Tvwh7OV7U5qV1QOCDDyhqNZdAaXdUE/VKeZrFOX43ZlxCwVtPU5M4piDSkjUDe761
         Ut5w==
X-Forwarded-Encrypted: i=1; AJvYcCUFHGa9ngqIsH2j4mdWiyYO1AI3YggbLE8xvePfVfj03RspSSx29r7SzJnBF1TprA87Xc0/@lists.linux.dev
X-Gm-Message-State: AOJu0YyR7Q8/Dka3oc5or52p2SpGX0TXgWb/12bZt0uh+tYkEBlh5soN
	5xPVNJcs53gzrZQz2JrGXZJXObVCZu7RJr+SDk7eQE4Zimc2uVHdWKjDjnNM7EnoSTf7YVv/2Rd
	QkgU75t4Yh65qpVnuSImjV5mGA85eVT+D9SFiuOCU
X-Gm-Gg: ATEYQzzhCMYtvr3JVFpDUToOShYZXLUuIVkHvqCRpCpmzj5hvamqzod17rKwm7nNoit
	LZMl+xwNG6ozAevrCBaz2lCbHU3U9PKPN6xxXUnmuNVDlkc2bs2zSAse1PiaC8uSa+EjHP+pa7V
	yaHeB/c2iPbVY+NZYWkyP4+gTZ6pALk5RVoyx8qneW3Xt/X5+xWs8inPpgtgFQZWjZYWXF9jR2F
	qQQCIh4i143DnKPa7zHJYHIawVebcjla8UVnxbTeSNsOAsuQyZsX+14dqtgU0MC3VWc9A6/zKXe
	FE9V25y9
X-Received: by 2002:ac2:5694:0:b0:5a1:1de6:bc66 with SMTP id
 2adb3069b0e04-5a13c93d9e3mr2016793e87.18.1772909791880; Sat, 07 Mar 2026
 10:56:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260307140726.70219-1-dorjoychy111@gmail.com> <20260307140726.70219-2-dorjoychy111@gmail.com>
In-Reply-To: <20260307140726.70219-2-dorjoychy111@gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sat, 7 Mar 2026 10:56:19 -0800
X-Gm-Features: AaiRm51B7g_JMhlZIdflpWCsx5DmxAmpibsspywnWIGz_sEa1ctulidKDYlHz5s
Message-ID: <CALCETrXVBA9uGEUdQPEZ2MVdxjLwwcWi5kzhOr1NdOWSSRaROw@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] openat2: new OPENAT2_REGULAR flag support
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
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

On Sat, Mar 7, 2026 at 6:09=E2=80=AFAM Dorjoy Chowdhury <dorjoychy111@gmail=
.com> wrote:
>
> This flag indicates the path should be opened if it's a regular file.
> This is useful to write secure programs that want to avoid being
> tricked into opening device nodes with special semantics while thinking
> they operate on regular files. This is a requested feature from the
> uapi-group[1].
>

I think this needs a lot more clarification as to what "regular"
means.  If it's literally

> A corresponding error code EFTYPE has been introduced. For example, if
> openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
> param, it will return -EFTYPE. EFTYPE is already used in BSD systems
> like FreeBSD, macOS.

I think this needs more clarification as to what "regular" means,
since S_IFREG may not be sufficient.  The UAPI group page says:

Use-Case: this would be very useful to write secure programs that want
to avoid being tricked into opening device nodes with special
semantics while thinking they operate on regular files. This is
particularly relevant as many device nodes (or even FIFOs) come with
blocking I/O (or even blocking open()!) by default, which is not
expected from regular files backed by =E2=80=9Cfast=E2=80=9D disk I/O. Cons=
ider
implementation of a naive web browser which is pointed to
file://dev/zero, not expecting an endless amount of data to read.

What about procfs?  What about sysfs?  What about /proc/self/fd/17
where that fd is a memfd?  What about files backed by non-"fast" disk
I/O like something on a flaky USB stick or a network mount or FUSE?

Are we concerned about blocking open?  (open blocks as a matter of
course.)  Are we concerned about open having strange side effects?
Are we concerned about write having strange side effects?  Are we
concerned about cases where opening the file as root results in
elevated privilege beyond merely gaining the ability to write to that
specific path on an ordinary filesystem?

--Andy

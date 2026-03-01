Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBDA2E7F0A
	for <gfs2@lists.linux.dev>; Sun,  1 Mar 2026 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772378402; cv=pass; b=bheXzUA2WR7eLCwrPaY0qSjj+7gkbZjtdEcz+XFrsP0fX9vG9lgAQix5QGPX8afwfeTo7uCK50CKNTPO3Q+l3PZ/W8k76kWlXRU+t6BdhIt6rTF2JZChpNQHHXJDluBYqVNGBJrF5rQWPCtqiu09/s4ME2FR1gMTkz8GGHGaSCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772378402; c=relaxed/simple;
	bh=Fiwwjp3q58poFbwEi1UnSoyKncjAv5ZQQsyqXdz0VPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rBSiB7M8JPYf7rX7RieXqaWJaMl/XwvC4J0bbTOMBbzMTB3FIpD/C0Ye/YUsNJDxIMCVVPXjfy3QNhXczN/4ZEzlGOnyyfKteEKN5/sfxgTDKdt9KucoB2CjTicJ6zi98ybO+kK5Aq5GrKtrDPJQhuLjaqg9gnvl6+t/uDG7fMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eou9cqiZ; arc=pass smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eou9cqiZ"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56a987683baso3683161e0c.2
        for <gfs2@lists.linux.dev>; Sun, 01 Mar 2026 07:20:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772378400; cv=none;
        d=google.com; s=arc-20240605;
        b=RRccVATo0Bbc1h3hxksBXqBWrQ2OsKo3KsSbCmxEbW6Jhq03u9kRxUPg9T+wc9Sb4j
         N2sYvalMhXnlBbuPpX5kAlx36fCGVJMXCHiTuWPsuSCClePfMKiA+RMlvVs0DIb+a/YM
         Jqb/rzXy6LXrdzhOji7LQvk7e2HIzuMitUhby0gnEMqIsjLsJmMESAw+y3KdnmpFAEYl
         goWHT6C2bRujsNCN9tyB4X+Zcsd8KwsA3FwL/XlHb156QE/TYz7YhpOfX8CXySY0sEzW
         DBuVdiOOHTKEVO2ACZFCYtVLo0xsdLGcSqim35sh6gdL+FopSM6D3HZ4oCOMms0redji
         dYkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fiwwjp3q58poFbwEi1UnSoyKncjAv5ZQQsyqXdz0VPE=;
        fh=/UzmyEiH2B7hPVhAOURvvG22XpwvCEFjB4xH/Y7yeTs=;
        b=a7bqLUYAa35xxX9JkGhGRumueAgtpgL1CqBjKlMPknEYZumx7NwWll9YgH4ndDEKIS
         6lZWbxGfhmlGx7aYzMPiXIi3HhsBixVqyOHaijp4Kl4am6+bccnr3+sgKTZ58u1roHdE
         3Za5P91HnTs0W32pcha2dBrYYXhvMhFV6icRtC0cogh5vZVEm6eDePZ2Frx0XqYnGRRg
         eIXB+FAlXZskzoug4dKOTmxjDaLa3J772j+RiywcLLyFeFdjMdQTH9tFP1Yal6AwvYb/
         j7MSTmbQ5xvA4lBjWUomQuh79zGWh8dByYeZxbzNxN73j+yhplx2m+NcK73dl9M5Jhkh
         S5Hg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772378400; x=1772983200; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fiwwjp3q58poFbwEi1UnSoyKncjAv5ZQQsyqXdz0VPE=;
        b=eou9cqiZWk6qHGF2PZGx5GD8KewsY5HvCPPZvYtIlwRvb9AuNvnvwGrXbObPnv4ANW
         FOObYbNZzJZmwMGMaZtgjCwr/Hf3Tsv2k0CgFpsN6u9MesHnH/XjcJFwd7kof5AsSEyJ
         kctC9ReXA2f/xKwDt3P8E4OGLb9GfAz14waB1m3RgLDK9NTjMRjruNMn2LxI8bap/ATZ
         0E7oMYGDnuxQXwDeuiOv9THy66HFlfizPDXlToMLVC9c3GRp8+T5YyGC3RyaFoqoeEg5
         wDTQsrM6/So2usZg4RbE2jsL9ug+yJQLRj3lhpc3Ve28j8XBpz6Vsp9nb569XE5mEEUR
         XlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772378400; x=1772983200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fiwwjp3q58poFbwEi1UnSoyKncjAv5ZQQsyqXdz0VPE=;
        b=gomZNKm6IbcW63tL3YMWRtketXkSlsZX8IpDDlLJdMn+Eokb+IO3mTuUcgGsi5wnp9
         aH8MOQhHiZhP3Bs3D5Lkt6djRSmAKYuKpzqwZMK2O6/V14H7hVkryI0w8FLpJ/tQ8T+C
         qzzGMmhLBFYbyUfedWV528QBOHh0EtPOzaamQr9YdTKivpq+neyvs42T4PHd8NEI/md4
         1L+78QI4YI4SrxVaJH/hXwXUTIgMBX4f5cW+iDlNRPnQN6kTaeqo/NzaXZwY/mmticww
         vVqnoKtpQyZmw2yRnbUC/ZQrXNYPo3aZg4/zomNzFXdlzyqiErwNPCTSXKFPaqifZFro
         pQfA==
X-Forwarded-Encrypted: i=1; AJvYcCW/BqioJw8eTchSHnS95AKUCtQIR3GWgU5RLM13RMn71ZEgb18SJM++yVyO4agP+zoPonYa@lists.linux.dev
X-Gm-Message-State: AOJu0YwrwVJmtC+ddTnXxtKDS13vLymSWrrTUBYJ9y9iJe0k560Lz1pV
	LIvSo/K1Aa7W7SLQxdgI3xdi1dVGy3B7TvXrDnxytQnPEnDsrbEQUgjywmeKNDGoJbmL1yR4s58
	YBfQFYNQIvLrZhFsBzWgmTwgD1OShua8=
X-Gm-Gg: ATEYQzwD4eSXvTgAhP+j6+t+81QUnXgHoZx05LzlIZDGRcMlps8DA7Me08/BRwqqmxC
	SipAd+yO16JGnY1Udr+o3TcFzN9HVyUsj/QSVnC3rmi+Px2TIQklpv41IASq2okOwhxOgBusyIg
	mjHG4e48oILdsvKc+3trzLCZtNgAKWoPCVs8JMMSfE27x6MH5O6JA9R/LM2HNeEeMXtdET7FMmX
	7jh034xUtzNBkuRP4t/GdCYZPAdTcTjmtLQSNOv7+4IVcKAXe/AxQrlB0DWJN+MHKo6vxU1C3Nq
	9H5lUXMsrHEq+CjRth2W1I426ZOR+RTyoxKFWTpUuw==
X-Received: by 2002:a05:6102:160c:b0:5ff:1981:aba6 with SMTP id
 ada2fe7eead31-5ff31fab9ffmr5005001137.0.1772378400433; Sun, 01 Mar 2026
 07:20:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260221145915.81749-1-dorjoychy111@gmail.com>
 <20260221145915.81749-2-dorjoychy111@gmail.com> <2f430eb613d4f6f6564f83d06f802ff47adea230.camel@kernel.org>
 <CAFfO_h7i86qdKZObdFpWd8Mh+8VXVMFYoGgYBgzomzhGJJFnEQ@mail.gmail.com>
 <ed5aeaa81ad9b87926fa7ebee0308aeb8df9f0ac.camel@kernel.org>
 <CAFfO_h5za6gV99TQS3pwHnf7zyCeVySn3CdRyV+_jFqjovGBqA@mail.gmail.com>
 <beead8bbff344ddfc279e0fc86db0dd5dd98562b.camel@kernel.org>
 <CAFfO_h4brg90tMNp6VAzs5Lo8Lbu=DK2csjDqr2zspOygKEFCg@mail.gmail.com> <73c8ea54bcda0b64093d84fe047914c0632c2d0c.camel@kernel.org>
In-Reply-To: <73c8ea54bcda0b64093d84fe047914c0632c2d0c.camel@kernel.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sun, 1 Mar 2026 21:19:49 +0600
X-Gm-Features: AaiRm51DyMEBRNPI1HVDhCyC4qT7r77uNpEMtKgft97OSaudIMk11BvPwkDJ_3M
Message-ID: <CAFfO_h59LQSjncu_4YE5YB+mt-FL2c1GN-jF_WtoKj1u43DcuA@mail.gmail.com>
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

On Sun, Mar 1, 2026 at 9:17=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Sun, 2026-03-01 at 21:15 +0600, Dorjoy Chowdhury wrote:
> > > >
> > > > I only added a kselftest for the new flag in
> > > > tools/testing/selftests/openat2/openat2_test.c in my second commit =
in
> > > > this patch series. Where are the fstests that I should add tests? I
> > > > think you added the wrong URL above, probably a typo.
> > > >
> > > >
> > >
> > > I did indeed, sorry. They're here:
> > >
> > > https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > >
> >
> > Thanks! This is a separate git repository, so I guess for both
> > manpages and fstests I need to submit separate patch series for
> > O_REGULAR. Do I need to wait first for this patch series to be merged?
> > How does it work?
> >
> >
>
> No, you can submit them in parallel, but they probably won't get merged
> until the kernel patches go in.
>

Alright. I can look into submitting patches in parallel. Thanks for
all the info!

Regards,
Dorjoy

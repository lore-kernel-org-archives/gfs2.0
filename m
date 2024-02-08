Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABBB4F1ED
	for <gfs2@lists.linux.dev>; Thu,  8 Feb 2024 21:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707427048; cv=none; b=KHkwzCaKUG1GFrXoNpD1pgWsxbtKuWV7qMBAWbozgNWXUYgN0/HSzMFQUMYNwYUeSAnin3mNwwnTV7khwGByqCtlWprJSLbuSG+KaJnXCZPJZmCZ70fn5DzqJc5aLC2GKL3cpmD8mmaCgGhdY502iq/C9JuQyem+PoFRk79OCLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707427048; c=relaxed/simple;
	bh=lR1vqEr+NUueGl/+e/z1Y6yt2E6StmXXzwjSE/g3B3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bd4y6yPIFq9irHNVibxcLn+3T+kN8/iz0DUfmSN3lylO15ckvSid5HkevjD31mWuaQzX8xivnwQROyeRCqkdb0wn/gK+/Ot9t9ETjXcohNGUa5PDaJXOK9lYdZ/Ff/S3sRbLQB+uEk+bCMGued92di86+hFQyBYgaELbmzJl8c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S1mO/KMK; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S1mO/KMK"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5116b540163so405228e87.1
        for <gfs2@lists.linux.dev>; Thu, 08 Feb 2024 13:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707427045; x=1708031845; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1FFveSw5oBTNx3rWpSsAiIZo1mBSaoRlz6hNqseCzfQ=;
        b=S1mO/KMKUUuALc5yVs5XJ5MWOHVy9bPjASJ+jnzkRsZwfDXFhVe5ybV9nomucCy7Hs
         Cxc8hZQuqj+6fUDeyNXrdcXczD4w9iG2ZKzhPhxlsDaPed9rPzzOAaj2+/nEQiCv3mKi
         +vr6plkqNC/4AL725elYk9Sol/k38/2brJUO7JApcpGNHn2KN+pRBoaeSJM52NDH/Cmo
         d/k3mVxVRl4xbbpHB7tImjfiHwn4uIjoi74u9EEgYWsAgiPJEU0AfLuIQBKtiRyoOn6l
         BCpGvTpH09r5wnaXGTrMnMYD1GWqPYcN+0tArTI79w2/jOXgtnYRFow9/Xpw6a7K8Mku
         x6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707427045; x=1708031845;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1FFveSw5oBTNx3rWpSsAiIZo1mBSaoRlz6hNqseCzfQ=;
        b=iBoWOl4bgaPT5MsW6LmiRrOZ22IIXnWMuT8nGixDvbgLmF4/uuia04E5Nud6HZYbil
         mjJlwgk4tF+o7gr1l/Zm/HKDsa/pD2IEzaJrEFnKGfPEY13KTd8Yx5mgtpHy8wMLBtsn
         Ev5vDRptlUVU7DeoxNTEzr+opcrYfFHea1qNaLyAQGPq9Zr2/8UjvjFepWccPYUSqIVy
         LpDn6gXomLLc4hetxqPRVNH+f4BOGg6sMIBdjrNhq8mcpPMPnrZBHiHoVKb2tRG1r3/3
         dWgHwMUlv5cneuNteSB+4Dnw7ue2d+K0qqEaJ7Mh3516WXhu6NMdoo/E5wRBCeJu2cah
         KPtA==
X-Forwarded-Encrypted: i=1; AJvYcCWEC6ca2yt+BMmVVOh+uRuMaz6G78MUTAevJQUgDcBtItu/BPsKAlhj6aPdzFpNswu9ObB0PLC7pTc1JrrReeG7tI1S1Q==
X-Gm-Message-State: AOJu0YztN64D3eY3/Vs5Z3VWgFsf5Jp272pHL8e+2d2JXbCg74iqlFck
	5ITvZAf+Gz+a3xeX/LE/B5S5Ocny4nwPBoXOT+eW2DScXDvs+UvNOPw0L+jO91P1AZi3Gvq3+gw
	fkxmoo0eHFhkwFPnc8vMbay99AyvU/OUBb6xW
X-Google-Smtp-Source: AGHT+IFUT+yk7OEqssxrpi3LSHxTbminq8y5LqPkLQXJRWvFrrIlVrH0pgnS5fcRPsLiDNUbal7egDc8/ZLhSb8mf28=
X-Received: by 2002:ac2:447a:0:b0:511:454d:25e3 with SMTP id
 y26-20020ac2447a000000b00511454d25e3mr265348lfl.41.1707427044605; Thu, 08 Feb
 2024 13:17:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <38f51dbb-65aa-4ec2-bed2-e914aef27d25@vrvis.at>
 <ZcNdzZVPD76uSbps@eldamar.lan> <CADKFtnRfqi-A_Ak_S-YC52jPn604+ekcmCmNoTA_yEpAcW4JJg@mail.gmail.com>
 <1d4c7d06-0c02-4adb-a2a3-ec85fd802ddb@vrvis.at> <CADKFtnQUQt=M32tYhcutP0q6exOgk9R6xgxddDdewbms+7xwTQ@mail.gmail.com>
In-Reply-To: <CADKFtnQUQt=M32tYhcutP0q6exOgk9R6xgxddDdewbms+7xwTQ@mail.gmail.com>
From: Jordan Rife <jrife@google.com>
Date: Thu, 8 Feb 2024 13:17:11 -0800
Message-ID: <CADKFtnQnz0NEWQT2K1AGARY5=_o2dhS3gRyMo-=9kuxqeQvcqQ@mail.gmail.com>
Subject: Re: [regression 6.1.76] dlm: cannot start dlm midcomms -97 after
 backport of e9cdebbe23f1 ("dlm: use kernel_connect() and kernel_bind()")
To: Valentin Kleibel <valentin@vrvis.at>
Cc: Salvatore Bonaccorso <carnil@debian.org>, David Teigland <teigland@redhat.com>, 
	Alexander Aring <aahringo@redhat.com>, 1063338@bugs.debian.org, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	gregkh@linuxfoundation.org, regressions@lists.linux.dev
Content-Type: multipart/mixed; boundary="0000000000007a52e50610e556ed"

--0000000000007a52e50610e556ed
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Valentin,

Would you be able to confirm that the attached patch fixes your issue as we=
ll?

-Jordan

On Thu, Feb 8, 2024 at 9:42=E2=80=AFAM Jordan Rife <jrife@google.com> wrote=
:
>
> On Thu, Feb 8, 2024 at 3:37=E2=80=AFAM Valentin Kleibel <valentin@vrvis.a=
t> wrote:
> >
> > Hi Jordan, hi all
> >
> > > Just a quick look comparing dlm_tcp_listen_bind between the latest 6.=
1
> > > and 6.6 stable branches,
> > > it looks like there is a mismatch here with the dlm_local_addr[0] par=
ameter.
> > >
> > > 6.1
> > > ----
> > >
> > > static int dlm_tcp_listen_bind(struct socket *sock)
> > > {
> > > int addr_len;
> > >
> > > /* Bind to our port */
> > > make_sockaddr(dlm_local_addr[0], dlm_config.ci_tcp_port, &addr_len);
> > > return kernel_bind(sock, (struct sockaddr *)&dlm_local_addr[0],
> > >     addr_len);
> > > }
> > >
> > > 6.6
> > > ----
> > > static int dlm_tcp_listen_bind(struct socket *sock)
> > > {
> > > int addr_len;
> > >
> > > /* Bind to our port */
> > > make_sockaddr(&dlm_local_addr[0], dlm_config.ci_tcp_port, &addr_len);
> > > return kernel_bind(sock, (struct sockaddr *)&dlm_local_addr[0],
> > >     addr_len);
> > > }
> > >
> > > 6.6 contains commit c51c9cd8 (fs: dlm: don't put dlm_local_addrs on h=
eap) which
> > > changed
> > >
> > > static struct sockaddr_storage *dlm_local_addr[DLM_MAX_ADDR_COUNT];
> > >
> > > to
> > >
> > > static struct sockaddr_storage dlm_local_addr[DLM_MAX_ADDR_COUNT];
> > >
> > > It looks like kernel_bind() in 6.1 needs to be modified to match.
> >
> > We tried to apply commit c51c9cd8 (fs: dlm: don't put dlm_local_addrs o=
n
> > heap) to the debian kernel 6.1.76 and came up with the attached patch.
> > Besides the different offsets there is a slight change dlm_tcp_bind()
> > where in 6.1.76 kernel_bind() is used instead of sock->ops->bind() in
> > the original commit.
> >
> > This patch solves the issue we experienced.
> >
> > Thanks for your help,
> > Valentin
>
> Good to hear that works for you! We should fix this in the 6.1 stable
> kernel as well.
>
> IMO it may be less risky and simpler to fix the backport of my patch
> e9cdebbe23f1 ("dlm: use kernel_connect() and
> kernel_bind()") and just switch (struct sockaddr *)&dlm_local_addr[0]
> to (struct sockaddr *)dlm_local_addr[0]
> in the call to kernel_bind() rather than backporting c51c9cd8 (fs:
> dlm: don't put dlm_local_addrs on
> heap) to 6.1.
>
> I will have some time soon to fix the 6.1 backport, but it may make
> sense just to revert in the meantime.
>
> -Jordan

--0000000000007a52e50610e556ed
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-dlm-Treat-dlm_local_addr-0-as-sockaddr_storage.patch"
Content-Disposition: attachment; 
	filename="0001-dlm-Treat-dlm_local_addr-0-as-sockaddr_storage.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lsdpwbpg0>
X-Attachment-Id: f_lsdpwbpg0

RnJvbSBkZWM1ZmZkMzA5OTY3ZTQyOWI2MTZhOWQ0OTgwMzdhNWViNDM3YzU0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb3JkYW4gUmlmZSA8anJpZmVAZ29vZ2xlLmNvbT4KRGF0ZTog
VGh1LCA4IEZlYiAyMDI0IDEyOjA5OjU1IC0wNjAwClN1YmplY3Q6IFtQQVRDSF0gZGxtOiBUcmVh
dCBkbG1fbG9jYWxfYWRkclswXSBhcyBzb2NrYWRkcl9zdG9yYWdlICoKCkJhY2twb3J0IGUxMWRl
YTggKCJkbG06IHVzZSBrZXJuZWxfY29ubmVjdCgpIGFuZCBrZXJuZWxfYmluZCgpIikgdG8KTGlu
dXggc3RhYmxlIDYuMSBjYXVzZWQgYSByZWdyZXNzaW9uLiBUaGUgb3JpZ2luYWwgcGF0Y2ggZXhw
ZWN0ZWQKZGxtX2xvY2FsX2FkZHJzWzBdIHRvIGJlIG9mIHR5cGUgc29ja2FkZHJfc3RvcmFnZSwg
YmVjYXVzZSBjNTFjOWNkICgiZnM6CmRsbTogZG9uJ3QgcHV0IGRsbV9sb2NhbF9hZGRycyBvbiBo
ZWFwIikgY2hhbmdlZCBpdHMgdHlwZSBmcm9tCnNvY2thZGRyX3N0b3JhZ2UqIHRvIHNvY2thZGRy
X3N0b3JhZ2UgaW4gTGludXggNi41KyB3aGlsZSBpbiBvbGRlciBMaW51eAp2ZXJzaW9ucyB0aGlz
IGlzIHN0aWxsIHRoZSBvcmlnaW5hbCBzb2NrYWRkcl9zdG9yYWdlKi4KCkxpbms6IGh0dHBzOi8v
YnVncy5kZWJpYW4ub3JnL2NnaS1iaW4vYnVncmVwb3J0LmNnaT9idWc9MTA2MzMzOApGaXhlczog
ZTExZGVhOCAoImRsbTogdXNlIGtlcm5lbF9jb25uZWN0KCkgYW5kIGtlcm5lbF9iaW5kKCkiKQpT
aWduZWQtb2ZmLWJ5OiBKb3JkYW4gUmlmZSA8anJpZmVAZ29vZ2xlLmNvbT4KLS0tCiBmcy9kbG0v
bG93Y29tbXMuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQoKZGlmZiAtLWdpdCBhL2ZzL2RsbS9sb3djb21tcy5jIGIvZnMvZGxtL2xvd2NvbW1z
LmMKaW5kZXggNzJmMzRmOTZkMDE1NS4uODQyNjA3M2U3M2NmMiAxMDA2NDQKLS0tIGEvZnMvZGxt
L2xvd2NvbW1zLmMKKysrIGIvZnMvZGxtL2xvd2NvbW1zLmMKQEAgLTE5MDAsNyArMTkwMCw3IEBA
IHN0YXRpYyBpbnQgZGxtX3RjcF9saXN0ZW5fYmluZChzdHJ1Y3Qgc29ja2V0ICpzb2NrKQogCiAJ
LyogQmluZCB0byBvdXIgcG9ydCAqLwogCW1ha2Vfc29ja2FkZHIoZGxtX2xvY2FsX2FkZHJbMF0s
IGRsbV9jb25maWcuY2lfdGNwX3BvcnQsICZhZGRyX2xlbik7Ci0JcmV0dXJuIGtlcm5lbF9iaW5k
KHNvY2ssIChzdHJ1Y3Qgc29ja2FkZHIgKikmZGxtX2xvY2FsX2FkZHJbMF0sCisJcmV0dXJuIGtl
cm5lbF9iaW5kKHNvY2ssIChzdHJ1Y3Qgc29ja2FkZHIgKilkbG1fbG9jYWxfYWRkclswXSwKIAkJ
CSAgIGFkZHJfbGVuKTsKIH0KIAotLSAKMi40My4wLjY4Ny5nMzhhYTY1NTliMC1nb29nCgo=
--0000000000007a52e50610e556ed--

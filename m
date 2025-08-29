Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736FC334708
	for <gfs2@lists.linux.dev>; Fri, 29 Aug 2025 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756488094; cv=none; b=AIEHFIr/bGff6e/Nx5xHuWp/4DegApobpZbdSEMCoee7BeAor+z/TAn/s9u91ErUfiIy2DqGabxldpA6GnaCc15dyqwF70i9aiGkRKwaVRVKfhEyrHD4kmjXLf9ywD5ZeKtq5Zn6jypZYYuXkDxJmkoSNgs2DjyrenkTZhAei6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756488094; c=relaxed/simple;
	bh=S+/QrEGldts39ESs0/DwWP+mBsUDlC0D9Re5hs3PyJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dc4nKr1y8MGUNDXNQ6pZmnptBTB5SJfcXjclg2+LcweFLGv0wKiOfw7faEnAkV542caaZG483rONkriWvyGR7YVa/GW8MkvBVj/BoTPyjhWY04zl01Yw2SOXAcroK8Ghgi8eyGMPj1Iv0He1p9av+lKyQBac93ugVswzriwOtgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YL5Kc7CA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YL5Kc7CA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756488091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yKyYLWaMs/pGKmOyFZdqr2YDBvHsZW8PlQ57jr7m0Oc=;
	b=YL5Kc7CAVk0OW2xdmVYG3nE3d0mcI96nuVMLC620OInt+BooJapgsF0A/zRgoWFUHD/BWr
	LkZNM5rry9oGit+gcRyTnO3i2uFnJTaS1WNBOmJeKTjgO7K5Xg454DZmCY32LuXzbJ3RaX
	godGnJizyrdD1yc49zT2fw11467ziiQ=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-pQfiJFqnPdWyM-ocSLUGxQ-1; Fri, 29 Aug 2025 13:17:19 -0400
X-MC-Unique: pQfiJFqnPdWyM-ocSLUGxQ-1
X-Mimecast-MFC-AGG-ID: pQfiJFqnPdWyM-ocSLUGxQ_1756487837
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-333f903e1cfso10970841fa.2
        for <gfs2@lists.linux.dev>; Fri, 29 Aug 2025 10:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756487837; x=1757092637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKyYLWaMs/pGKmOyFZdqr2YDBvHsZW8PlQ57jr7m0Oc=;
        b=OV2uxtkpNMehijxY4gMZDAowybUu6769VDzPf08oWil0rk15ZhC+7ZcE14Ve1GFJGE
         Ef3SF4q3O8ofQNGQanWEQDbqQzBV3d03VbN2O2d5a7TKHdilU4nZhHl4TQfDoFT5LEBC
         x0h7/tXow2w/7Hom5L591cW9XmQ5uJ0ILwSNmgCb9w3dgSxcrDslMp5XFtcLFnVsDMoH
         wY5uLQ/Gj6H6odfo5w8OsI0JIj4NygBiVA1vIJbQZN0bP1rVN6PsgfuDnwOt+gAIO7q2
         bdrzXIICnwV8Hea9Fu4NJN9O8sERaDV4XcqQ0xXimdi3RfDNaj/pa+CZVYLn+ZrKljt/
         KwGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/sUPCaV+zqe6JClGV+qtrHNz14+TWfkBxfvI5S9NU76jxbaz9DxbdThIJOqNqVgGZQYSu@lists.linux.dev
X-Gm-Message-State: AOJu0Yyp+UFo+RZTCmSJjqElgk9US6Ft3Ja/mTAWYfpNNEkFzwrXcDLW
	Y/EX5xZEl5jR0JVKcFekWqENf49I2jt275vcCcgOXB/tuI0WStaQmxHtJtb/s7URB2qkx47ZI60
	U2ce3FcUmOFyEJntm9Xv1ZduirUagBcW0ywL/M4iTNGAfAMPwkkSmhI6QX0CvQT8Pxc1l4yM/W+
	EPl5DF4MdM6D0nNMdYsycg6KmH9Rk4vw==
X-Gm-Gg: ASbGncsCDxpf2gGHGoWqqgipraH7l1e+qiJd5Z+4HWpLE/5egx9f9lRY6j0MSbe1Rl1
	8KFtUTCMeMwhMlGwBic/UKLlMxTxkUaJ4+D0bnrNEWClKMJoQ9jaklans2ntjVqshZEb0/nhfvr
	l6NAGfFniMrvyOB2pvv95nBntrpYfTA0H5dnrX1xmPIxLIPziFhghu2SA=
X-Received: by 2002:a05:651c:23c5:10b0:336:b79e:6a7 with SMTP id 38308e7fff4ca-336b79e0d2amr8676091fa.7.1756487837375;
        Fri, 29 Aug 2025 10:17:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIeEdduEcyLzbX/DHy6adyDRRHg7LppkqwFQ3o6vXFiB2gBUJqkpvoCsrihHBGKZT3zE1Q0Zidc0k2I86ZhOw=
X-Received: by 2002:a05:651c:23c5:10b0:336:b79e:6a7 with SMTP id
 38308e7fff4ca-336b79e0d2amr8675991fa.7.1756487836917; Fri, 29 Aug 2025
 10:17:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250829110749.500571-1-226562783+SigAttilio@users.noreply.github.com>
 <CAK-6q+js0y9Pnubg0ev3_GXs8Fa4KYU=nNP5r=FBatuEAUhJkw@mail.gmail.com>
 <CACsb0NhQ8BBzcUtR0awMu6AbP-xwLvkUotDAAg-LbUV_LxwiNA@mail.gmail.com>
 <CAK-6q+gQOQsg5uE2-KioKBip5agCV5AjhXbxgwqngvg8ct=vVQ@mail.gmail.com> <CACsb0Nh0B5F51H-_bxM+wR4JzD3dJFRfRx_fHGorU=fRYzxPzg@mail.gmail.com>
In-Reply-To: <CACsb0Nh0B5F51H-_bxM+wR4JzD3dJFRfRx_fHGorU=fRYzxPzg@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 29 Aug 2025 13:17:05 -0400
X-Gm-Features: Ac12FXzvBhq07YLkMb47kWNVSX_qr62WFvHfJETbiVaaR9Zvkkj6hmNZGneD9g4
Message-ID: <CAK-6q+jV6yo79H6KJoGXL0k=dBndSh1pLTEh34-uOTsG98jGJg@mail.gmail.com>
Subject: Re: [PATCH] fix(dlm): handle unlock/cancel during deferred lock messages
To: Alessio Attilio <alessio.attilio.dev@gmail.com>
Cc: David Teigland <teigland@redhat.com>, gfs2 <gfs2@lists.linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QK0BhYxlsUDkzXCRAcf3X1ZoA2zVlTAVmA0TMXe4XoU_1756487837
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 29, 2025 at 12:21=E2=80=AFPM Alessio Attilio
<alessio.attilio.dev@gmail.com> wrote:
>
> When I say =E2=80=9Cdeferred lock message,=E2=80=9D I=E2=80=99m referring=
 to a lock request that gets queued up because the lock resource isn=E2=80=
=99t immediately available usually while dlm_master_lookup is still figurin=
g out who owns the lock.
> During that time, if an unlock or cancel comes in, it can race with the d=
eferred message and cause some pretty nasty issues.
>
> In my case, I ran into this under load in a real setup. I don=E2=80=99t h=
ave a clean reproducer yet, but I=E2=80=99m digging into it with a debug ke=
rnel to catch a solid stacktrace.
>
>  I=E2=80=99ll share it as soon as I have something useful.
>
> The patch is meant to make sure that unlock and cancel operations don=E2=
=80=99t step on anything that=E2=80=99s still mid-resolution or worse, alre=
ady freed. It=E2=80=99s a bit of a corner case, but when it hits, it=E2=80=
=99s messy.
>

Please make sure you use a recent kernel to reproduce it.

- Alex


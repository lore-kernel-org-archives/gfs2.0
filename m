Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6C01B4223
	for <gfs2@lists.linux.dev>; Sun, 22 Feb 2026 07:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771744796; cv=pass; b=nUNeTovWhjmthlDeB3xteGDGRIohPXZSJeru5sdeqXg5FG64sqeKWNZi+uDnMBtJVAB0hphIZRB5xKb4jDwT0pCb+ZpHjXYxnS0AxYQzuRfHoIS9ZX06//gvAX3RDHzbCU8PTspFYYWMSay18agqD4hk3i+xdzJKnxdDStn32gY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771744796; c=relaxed/simple;
	bh=0lDfK3AuaNxxPB1Mx5JPD44YULX91cix/sE9XtEee8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OdobE2f49SmPRRSGPjrUB2uGZU9+5EIYVxLPKfWcrPZtcBO93acWtv9mUcbr4owAudTUvK4e0utsD8lppXfDmsoMOYJk8xkQTgeVBxFnlFCruAj1e2aKIZkaXKX88sUUuJvANJjBuxguomLZbuwgoTGpWBdOFJ0/lKFdRqdHpSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHzA8O3g; arc=pass smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHzA8O3g"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5675d609621so2738443e0c.2
        for <gfs2@lists.linux.dev>; Sat, 21 Feb 2026 23:19:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771744794; cv=none;
        d=google.com; s=arc-20240605;
        b=A9wVF7BLUK+b4SIyeCkFKXi5ongYUBsDKafM8Ooa5mCLqxHs+EzbPo0SRGq1zd2beL
         32B3sv6fJJ71f5UU2NAPkHZfCI+oLG0Kmq+pnOd2mglz81bwgYckKVIZN7TY0c4qqe2J
         7j1YdPe29xLeBJkoC91CZUEBzZCBVhiGmUh1aFL88YeFTzuKolf2ew/2OEcJLDL16EeE
         zlkyGHw5Nsh/Ws00XYsf9FHPr5nw7jH8avY3Dd1orAfFjsjffRu6vOH2whcrcYobJAR/
         ECDahJzubDDhRrpMol1BhYFgFt2QVu8RcwaeObDtQCq4q3PsMUlU/0DlbLW3AYgTI9y5
         771A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OILCq3HcP44ucOZfdh81GCluvZoTsk6wk990N+3C0dA=;
        fh=kr7JALVqRO4wp3jSuNtMKNF59vOC14o45VbsAb3cj94=;
        b=TGppZlsblkkc3rTQs1gVzJWO0bh1cFQ8PyJQ8hNxFKBx53STEM5N0BDHB+QdXYq1vw
         he0BWFjywnuTWYhnBJcPd1+GuEEti7DGKA4nEoKnzZ2cLurq2EKUQgNUjKHOLt0jc6wY
         kl+TEvFUeK4ASw875cLmzl6kwmaY0CcSodk48xhcw6R8ZBKWNrbx5+Or1g60varVi4CV
         MvnremaRw2CWyo2r4098JehwQ08BZ1xMPQnPdZusEmWAq2Ht2415JrnX6RBGtp+zssJP
         ugf75MNT/BNhSk3ex2ap+amySPffuBLWDTKQZr/NKpdZzrILLKcE2qOwjtkegj87iFEj
         645g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771744794; x=1772349594; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OILCq3HcP44ucOZfdh81GCluvZoTsk6wk990N+3C0dA=;
        b=FHzA8O3gZJlP9U+n2bQJUGLvNB6IykHDU/iy+BCfhFTy1h6KjueJW4SVa2X+D1GIU+
         OsxQnBACF3rue/pPBckCch/qE3CygqFNxr0QsJN/BmIVuTmwPy17e4Q9Dprtvxu9Wotz
         pSNa6iZOi2fEU4ExQJ2AJoe5gMIpp+He0MRLtie5mNMMDKmbV4M3XdDZg5N8tarEWoab
         geAGHpGnXqGPizOTfn1lx4ke7v1rAPqvsIdbGLTtSulQ1BpGoAvF5gHuUvwbCoFB4ivN
         O6or80Jh0hd+R5EFHzAaolP7yfIUUD161eUkZxKo6V+Mufg6CYEYm2YOxgR2w0EOEnqf
         3GvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771744794; x=1772349594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OILCq3HcP44ucOZfdh81GCluvZoTsk6wk990N+3C0dA=;
        b=s16WlighYrOJWl58lSw44LiK2RAKFFWHJ4elOMgVv9qBCKl+r9+NIrZwzNhKUtZa3J
         JyGZJq9x0orGkHl7oPJFSMYrH18IbCZE7FruGEaIdHJGjOQqTKZk8agdlUTuIXrksSvU
         JALxidBoVxM7iDxbhv2U7y1HzX4dAwVWQ1QrH4ZazqL17XqOG81G9hxPfdjjjwT2vAJs
         WjoplZwDqGV66NAWu8bxYZdKB5/Xw9HjMewLAl4WVuH4eRstzVCuw45xgOw7pQM+OLeO
         zdinCnxIARNW4oNXYSTAZ65cI+Mb5F3YqqAL6A7qGjGKz1x2iRpgxIrX9OuoSX6x3yxZ
         6jvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXREYW3Ijuuz6LO8R2VttRMfAhcu82Jnrl1E99g0XegSctVLnLrnNz+mGQTiRwC1fyxdWky@lists.linux.dev
X-Gm-Message-State: AOJu0YxfjRH0lhG3BHcl7rYCMRbwvEVPIw1b7QpIqfuPa2GkIbp4UC2q
	LgBrWuTc343KekffEiUq0JqkXzXQFdbZKKGF099WrxPiQwuYb8oCFkKToz9mz5RaYol8gZZaC6k
	BOIvVnmO4PPnNjH15/WVIG7N2L8G4xDE=
X-Gm-Gg: AZuq6aL+BiNgWcL5c2h0LZ+jKRsOJGRx2dXz0z5Pr3hKC5B+mHs4PMjHQOI8UR4BfcT
	9q0UJj1p97X2IsJZSsCoY639IZzR2J2ZqjXx9kvHTsY9fp2oZWf7x/aTLuumTgyntkilGHCzBWy
	75nwIXqWSQS5w10c5zrdukvLhPu66WcA/ISeuatk4CGHfKDkgMUamkMxTKnbJWNhMlnRJhgfoyq
	TI8t/tVLWRB2iwjvD14AZkjWncBUe9HzUPvyVm4OWyH9K3YRH8FanM5FamrTdql1rFqynIC7cVP
	9ZD7jnBpk8/8QAnKK5wOGf/2VJxiOL/IIIIfI42UQGzqBBpzTz2GgQ==
X-Received: by 2002:a05:6123:2c6:b0:55a:ab0d:bf74 with SMTP id
 71dfb90a1353d-568e489e04bmr2702083e0c.13.1771744793575; Sat, 21 Feb 2026
 23:19:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFfO_h7TJbB_170eoeobuanDKa2A+64o7-sb5Mpk3ts1oVUHtg@mail.gmail.com>
 <20260221234553.2024832-1-safinaskar@gmail.com>
In-Reply-To: <20260221234553.2024832-1-safinaskar@gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sun, 22 Feb 2026 13:19:42 +0600
X-Gm-Features: AaiRm51yAd7WZH0JTtET-y37usKeLDtT6X5Vgs22uOg_jqenzkdmMaQOnOQPf2k
Message-ID: <CAFfO_h4dNydbmKSTP8uD9X6ouEZTyJUGoTBXrEHWeHtD1B=p5w@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] OPENAT2_REGULAR flag support in openat2
To: Askar Safin <safinaskar@gmail.com>
Cc: ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-nfs@vger.kernel.org, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 22, 2026 at 5:46=E2=80=AFAM Askar Safin <safinaskar@gmail.com> =
wrote:
>
> Dorjoy Chowdhury <dorjoychy111@gmail.com>:
> > I am not sure if my patch series made it properly to the mailing
> > lists. https://lore.kernel.org/linux-fsdevel/  is showing a broken
> > series, only the 2/4, 3/4, 4/4 and I don't see cover-letter or 1/4.
> > The patch series does have a big cc list (what I got from
> > get_maintainers.pl excluding commit-signers) and I used git send-email
> > to send to everyone. It's also showing properly in my gmail inbox. Is
> > it just the website that's not showing it properly? Should I prune the
> > cc list and resend? is there any limitations to sending patches to
> > mailing lists with many cc-s via gmail?
>
> I see all 5 emails on
> https://lore.kernel.org/linux-fsdevel/CAFfO_h7TJbB_170eoeobuanDKa2A+64o7-=
sb5Mpk3ts1oVUHtg@mail.gmail.com/T/#t .
>

Yes, indeed. They showed up after a while.

> So this was some temporary problem on lore.kernel.org .
>
> Sometimes gmail indeed rejects mails if you try to send too many emails
> to too many people. So I suggest adding "--batch-size=3D1 --relogin-delay=
=3D20"
> to your send-email invocation. I hope this will make probability of
> rejection by gmail less. I usually add these flags.
>

Understood. I did not know about these flags.

> If you still expirence some problems with gmail, then you may apply
> for linux.dev email (go to linux.dev). They are free for Linux contributo=
rs.
>

Alright.

Thank you!

Regards,
Dorjoy

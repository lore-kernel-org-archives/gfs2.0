Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835643D3CF2
	for <gfs2@lists.linux.dev>; Thu,  6 Aug 2026 07:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786003023; cv=pass; b=BMVYbKlXh+zP5ajZOOz+BPubZT++93e4MS8Xlxxy6q1i9DBSgmCe85V+aqOTPUilwUUx8SYvUF7WmItvM8c2JGMpsrQaUcqcQ8zacjZBgZRjyouji3Gwr1AUGHKbSRO3WDn5Wr5Kj3bRaeiAZ94mTCliv8ibm8ePOoYVrXIAIdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786003023; c=relaxed/simple;
	bh=TMhspWAzu+WlMUsaRsZmJk7631WbeBzu/lPAAX2WUjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNBZIp3iHpx7MkYruBUtrMHScoSwbSYAqMIKe1B/WFktNKAolM1wAVxi2k5AASWEJG2B4aLmZOwNq6WG0sQwytGdl8PoQskO4j5lAg+zpKqOxgnU455u1HMxw0TmMeq6SvNB7HVcRnpPOKrdT92UyzlCh6XyM/GE28T96rWfYBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCoXwtQC; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCoXwtQC"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c1fbe461f59so285226666b.2
        for <gfs2@lists.linux.dev>; Thu, 06 Aug 2026 00:57:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786003021; cv=none;
        d=google.com; s=arc-20260327;
        b=nEVLKnMqIRYmFZ0IFUqD9HngN16ZM0ZKL8u+MGYfLkzkg8lIZrnB1oLQC2W0OpYjXq
         CK9Be6G48YbqQGD1cZgV3kG014dPXyosuCGGXb6R8DepmIfJ9W9I5Q1zpOE7lryEddZ6
         2PxcF6V98ajmEFjzNOrSpXtnyrJXloql0KVP/Ae78sobxpwXZdvjw6uWDQqc5YNGAlDf
         jrA0g1PfXW0ZsDUE69c9zw2PRGKZs0hCFyo7SMm0VtVX6ObDupLSEg00qWxp86rswghg
         epU6iW2aqmAaraOAthbGPidrCsiNPkuHlkQVaVj3o2RSpAStXw6u4J4ANsUtFyaUSGlT
         MAew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ah1hCkAmRfBX3TnhduxT95Qlh5swPAh2RuOlvf2tYGU=;
        fh=aeOFc6a1a4+4N4CJhzRLJs7SAvBb2XTlVskvco+ix/k=;
        b=AcP57xtP406JrG2ijpXZtIgt9/mGzQgFg0JcmiybMqFuC0tcSr+T8i0VOpqbhTp+Cm
         fBNA4ASFExil8nu7o9W5+ImQ//RIqWUVoe4Osekh3vjZcMg79FLC221KraIF+VXreo0h
         /3GUwR/bIT8ebx5IxVf/UBbaPq7K26Gf2OpcrSkuiUgQNePtCKTXqbeAZ1WeDnlLN4YY
         gyi66EEtNgmO2TpFVPl5GmzN+i9QJ6nvnHbiqxx97LPIsVgvXuDz2Qlzd99Qt/Og+HJq
         kltuD5LrOWiVCeU7PS4+4XBeiPwTU4ycAqvLHe6gdt2UdfruCSCkOIwzIa2RIUgUkzSS
         19vw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786003021; x=1786607821; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ah1hCkAmRfBX3TnhduxT95Qlh5swPAh2RuOlvf2tYGU=;
        b=cCoXwtQCVCxdLaS10p0ukAxYj3cWmmw4u+0KWiR5BH4HSM57WWMakdXWHVpE6nHqNF
         7hgUeeVrtwphGREBkgvRmVmQ500PFV4ZUnRtxuKj8dOifX246A1U9CPbFZpynanrnafu
         eJh6Ek3WA1oHPIWrkp8D/7U3MBTES+bgH6fWlbV+Ty2jMBV21wxkMN5GnhuhaQWqVVng
         Pzwbe1EeolhKXMmIQhNbd0FG5q/ueAbyTguSLhEZGok/ve61ZvXN+gY6KBXivdjbZ2x2
         huRZUyRxVfaOVuigNxep7JX7wq1uH+Q8wVVmqysVcOqvkLPeoPqFTAW7lZHkFGGUK7sp
         KVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786003021; x=1786607821;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ah1hCkAmRfBX3TnhduxT95Qlh5swPAh2RuOlvf2tYGU=;
        b=iFctnxO3E+cawOOWzl9HS0udo75/I8k/q5aVQ1ikekz1Kums5APWSFyPmH/FUjlzHl
         kIDF0D4XcRTpX6UQadcsN6gyjs7pbKxaQZagnNm0ODNZ/054pdNSo22Epgt/T1VU0cWR
         RrTAWGQ5sO373fYwiNPvYau5CqJxpju2l3ioYBd6tleIhvMnEjevVNki7znZCYu4SlIq
         FP2U6T3QbxrofySjCKFNayv2fsATQtMtFzv2lqgakrGOqIzA35BtX/8pGYEf1sG1vQut
         cXdJKCuyfJ0VYQbWffCYXWUhyq0NeE0on7UHWvu9f2iusyoYj4rUp8orvvn6WaMkdtcx
         MKoA==
X-Forwarded-Encrypted: i=1; AHgh+RrkI1KiIEYFgte2VDwjGYmPU+zqHkatZtN08J+Mbgw5uQHZwnmVOI/fO/vIq7MqWlTNXfLt@lists.linux.dev
X-Gm-Message-State: AOJu0YyoJghr/BBR1lFrACtIdzMOOOWx32auLuLtJniz8YmtDlecIRV3
	zvPqxNXpV5JXrMYxKT0qg/lia0TQAzXfxdzNdbOJmPiKoPzY4UbMGD7D9Gq3V2eFVAOFYgFpQW5
	YQL2/ZFpEter8sMc6KpOZgkGWEKIlYrs=
X-Gm-Gg: AR+sD11GW6ZWc3f6ITyVYrp3IWycXy5AFdztJABrDbfCN0AxGOwyexyJWVoq695nTuI
	CqMD3Ntac/Cw6tb14/t6Jt6GSz9PgHl/p8UeKRHaTLN7MbuXC8jQqwJbGnNp47nmTGJQhsMkdrA
	kRKCvLu7XuenHFWdmlTFEOhS4vlobnwvrNQEMexOzKXt78mFu5QV/iR5DVhKY+DURn+E+oDMUZN
	TOXHeyObQb/RN9YrW4qaK2fFwVWGQbeSKGllMYLbh6OyGO+6D3y/4/2r4Gyed9EHv9Wx6VMiMBD
	lBBMP/g9IVKEG4qYIABNXf+uxq8ciYTN/Nhe6zMez99M6g==
X-Received: by 2002:a17:907:c18:b0:c1f:9cdb:9965 with SMTP id
 a640c23a62f3a-c2039d1e0b4mr747504166b.2.1786003020225; Thu, 06 Aug 2026
 00:57:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CANypQFasb8voDrg=O9xJikYHdRFeupb5VP2VeJaZ_wFNMoGr2Q@mail.gmail.com>
 <20260710092933.3631376-1-r772577952@gmail.com> <CANypQFY_AYRXuiO++tQuZfdnb4mmM4dbkBJ93xD1BmVYL3bRvQ@mail.gmail.com>
In-Reply-To: <CANypQFY_AYRXuiO++tQuZfdnb4mmM4dbkBJ93xD1BmVYL3bRvQ@mail.gmail.com>
From: Jiaming Zhang <r772577952@gmail.com>
Date: Thu, 6 Aug 2026 15:56:18 +0800
X-Gm-Features: AUfX_mwXIu-f39y-Wo40IgNKm0b2pPUL9vz_b9RKohoirz01uUiw1yOfVucSrEo
Message-ID: <CANypQFbWBR5_Ax3Mvcf48GPMV9tdBYF5jXREeneLP9M7jG2y_g@mail.gmail.com>
Subject: Re: [PATCH] gfs2: stop logd and quotad before kill_sb log flush
To: agruenba@redhat.com, gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jiaming Zhang <r772577952@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=8823=E6=
=97=A5=E5=91=A8=E5=9B=9B 15:11=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> Jiaming Zhang <r772577952@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=8810=
=E6=97=A5=E5=91=A8=E4=BA=94 17:29=E5=86=99=E9=81=93=EF=BC=9A
> >
> > gfs2_kill_sb() issues a synchronous log flush before stopping the gfs2_=
logd and
> > gfs2_quotad kthreads. Given a corrupted filesystem image, that flush ca=
n spend a
> > long time while holding sd_log_flush_lock. Since the background threads=
 are
> > still alive at that point, gfs2_logd can be woken and block on sd_log_f=
lush_lock
> > in gfs2_logd(), and gfs2_quotad can block on the same lock through
> > gfs2_statfs_sync() -> __gfs2_trans_begin(). The threads can then remain=
 in
> > uninterruptible sleep long enough to trigger the hung task.
> >
> > Stop the background threads before the kill_sb log flush. gfs2_destroy_=
threads()
> > waits for both kthreads to exit via kthread_stop_put(), so after it ret=
urns
> > there is no live logd or quotad thread that can wait behind sd_log_flus=
h_lock.
> >
> > Closes: https://lore.kernel.org/lkml/CANypQFasb8voDrg=3DO9xJikYHdRFeupb=
5VP2VeJaZ_wFNMoGr2Q@mail.gmail.com/
> > Assisted-by: Codex:gpt-5.5-xhigh
> > Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
> > ---
> >  fs/gfs2/ops_fstype.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> > index 9b9e70f14d25..d087845a75d6 100644
> > --- a/fs/gfs2/ops_fstype.c
> > +++ b/fs/gfs2/ops_fstype.c
> > @@ -1776,6 +1776,8 @@ static void gfs2_kill_sb(struct super_block *sb)
> >                 return;
> >         }
> >
> > +       gfs2_destroy_threads(sdp);
> > +
> >         gfs2_log_flush(sdp, NULL, GFS2_LOG_HEAD_FLUSH_SYNC | GFS2_LFC_K=
ILL_SB);
> >         dput(sdp->sd_root_dir);
> >         dput(sdp->sd_master_dir);
> > --
> > 2.43.0
> >
>
> Friendly ping. Please let me know if there's anything you'd like me to ch=
ange.
>
> Best Regards,
> Jiaming Zhang

Friendly ping. Please let me know if there's anything you'd like me to chan=
ge.

Best Regards,
Jiaming Zhang

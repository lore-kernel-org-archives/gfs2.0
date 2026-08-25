Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7510C400996
	for <gfs2@lists.linux.dev>; Tue, 25 Aug 2026 12:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787660850; cv=none; b=saU6hgTZbTL8zWS6SZLYk5Im8TK9DsoaLwuiOEmXfxUhuRbdorrtArGCgR4hB3LPK7ZUxnGyF2dQbIC/spIDh4Lyet6uhtl1EIX15kQVK2DQWeewbDUknAUt8m1uKkRMJf77hhUNPSGjGYPW/XGwomgM5CGIO5NtUNI8IuG2sNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787660850; c=relaxed/simple;
	bh=cmfP5eMqk5M+kkz5v3aWm5CabjFPCyDaPXUSEuEkLgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A5rI1IQGvqf/clhU57E8ST2riau8NQbvNTEbZdu2+Zqdf1/A9ehVtOIA+Py2hlS61egl6ZLEZtGWdFE/wPJTgjWJ7vhEX3LSa15T5yUUamOn9MqeBhbwrhCiTaM45WFOvtvdGqZ7zBUjQ1/6ZRGyuefjNC1blihkKrv6doa9dC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T9LMPyNC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T9LMPyNC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787660848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ftm519abBzXhA0e0io/fRLoQZvb6bRuiQohHLE8QDu8=;
	b=T9LMPyNC4UOIkZ63EQ+8WELKJxPYwFnMOOSn5h3jyPE/eBjGLN/rnR3XTy2PC3J7y37zr2
	Wa/+KYhZwBF1OPju1XVPaga/E34Hi0wj1lwIt4GwY41Ll+uDvW4ELJMhIYydu1T6HXwy3M
	7Wy4FptzRWSoLZ2kVGzcTY58O3Qko+M=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-cOL5A9blPtSMgzAWEkI5og-1; Tue, 25 Aug 2026 08:27:27 -0400
X-MC-Unique: cOL5A9blPtSMgzAWEkI5og-1
X-Mimecast-MFC-AGG-ID: cOL5A9blPtSMgzAWEkI5og_1787660846
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-66c70eeacd7so6300952d50.1
        for <gfs2@lists.linux.dev>; Tue, 25 Aug 2026 05:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787660846; x=1788265646;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ftm519abBzXhA0e0io/fRLoQZvb6bRuiQohHLE8QDu8=;
        b=h4iO/jbMmQDUXPxaprhMvNA1PzBSOr7t5lasOyzwbIlNsV03J0YK/V5v/oWmr8Z/ZV
         S3C/0U6sUnv9bvJTdYTmepTdoWYLrn1gCmebQM2wClJo+VnOVkgQq6745NSB64gaL8lO
         xUQst6SrZoTOJ9FT1ro0YuONmH18JR86Jk9gED1ZF0VsGOgqj0dHb1AmT0lrrmu+GnxV
         c4dcbTBvvvt5YsPbcbhUsJQrByxCQnETe56pcx02U0d5QI/ip9VU9mTwCgIxIYrr9gmr
         T73iuI6QwJF27e+t4uiA3vZBfocrnPHxuwk15dbwibj7hj+mz/QEIuReHEe6A+/rUvag
         8Cyg==
X-Forwarded-Encrypted: i=1; AHgh+RrcG+mIKADE+MAhpqlI7kUa7g4qPrKkt7DNTwmdVVZsZyQrHYXzAfVVbNUGDIhY+Rd8Zj/l@lists.linux.dev
X-Gm-Message-State: AFuF++kadKSienmyJX19QquOwSVd9y8nDBkgSuBTrkJ0CLV+CmDWB9bV
	9b4OyDK6KpgbTL95UcJ65KD1l3BR14UCH0ff0zvKSUHBkQxLkqjZGSRgDiTTjKcL+vdnzwjKg+v
	x9TmslyRDXSB3khmGqTMERpVNjFQ49K06u/tOAE5FFMD8wQP/IJZU2N/1ulsrL+9Xjw4HcCuytA
	8CMaIXMPz7sGaeb/PZqgrpnmUI6Lf3xw==
X-Gm-Gg: AR+sD11JIngpBQCIyttUojWqxBcHhclrcslCbJs/Req62NnS84z0HVsAGmp+bL/Hri1
	JdEK3F9VIq2De21XKZEF67CjwczdymFsyYJm/l8WwAiVikmfzU1YfLe8ZugPLg28VZ3i9/4DAVC
	dJYxehuqRMMiyjQs11iGryruVtieOU3lZMysfVNhI3bCJaefesP548L5ZsKGAHZ3Es9L4anwEeb
	j3sXL9bIQDZ23yLieEtj7nq32igJ/5I5EK+BoRW6W4d
X-Received: by 2002:a05:690e:4295:10b0:66a:b622:5974 with SMTP id 956f58d0204a3-66d14a46e66mr1748734d50.22.1787660846317;
        Tue, 25 Aug 2026 05:27:26 -0700 (PDT)
X-Received: by 2002:a05:690e:4295:10b0:66a:b622:5974 with SMTP id
 956f58d0204a3-66d14a46e66mr1748722d50.22.1787660845858; Tue, 25 Aug 2026
 05:27:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260617090143.735219-1-zenghongling@kylinos.cn>
 <d8d1d7fc-4028-4913-8025-cb4c39ab437c@redhat.com> <6A334EF9.3080504@126.com>
 <CAHc6FU4GD=QjKr5nBsxL2pO6Krj-WOtD_dND=hpzHfYwcuZ8Jw@mail.gmail.com> <6A8CF151.8040704@126.com>
In-Reply-To: <6A8CF151.8040704@126.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 25 Aug 2026 14:27:14 +0200
X-Gm-Features: AcwNN1XU4vbKUeF5wAf_t2B_EpEcMZLdW59pTxZOlZ5DLPmqEjWL__NHpWszpjA
Message-ID: <CAHc6FU6G9yzWwwA0ZQJBsU9Kmw3167i+6_1NoUtf234rvtjENA@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Fix use-after-free in gfs2_remove_from_journal()
To: Hongling Zeng <zhongling0719@126.com>
Cc: Andrew Price <anprice@redhat.com>, Hongling Zeng <zenghongling@kylinos.cn>, swhiteho@redhat.com, 
	gregkh@linuxfoundation.org, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aNT84nLRcynAZl_FdW5WUm_prCOrhAM9ugEayvE_XjY_1787660846
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 3:36=E2=80=AFAM Hongling Zeng <zhongling0719@126.co=
m> wrote:
> =E5=9C=A8 2026=E5=B9=B408=E6=9C=8824=E6=97=A5 23:35, Andreas Gruenbacher =
=E5=86=99=E9=81=93:
> > Hi Hongling Zeng,
> >
> > On Thu, Jun 18, 2026 at 3:58=E2=80=AFAM Hongling Zeng <zhongling0719@12=
6.com> wrote:
> >> =E5=9C=A8 2026=E5=B9=B406=E6=9C=8817=E6=97=A5 18:51, Andrew Price =E5=
=86=99=E9=81=93:
> >>> On 17/06/2026 10:01, Hongling Zeng wrote:
> >>>> The function calls brelse(bh) but then continues to access
> >>>> the buffer head through bh->b_private, clear_buffer_dirty(),
> >>>> and clear_buffer_uptodate().
> >>>>
> >>>> After brelse() decreases the reference count, the buffer head
> >>>> may be freed, making the subsequent accesses use-after-free.
> >>> When buffers are pinned their refcount is incremented and the brelse(=
) here is only called for pinned buffers so I'm not convinced that there's =
a bug.
> >>>
> >>> Callers of gfs2_remove_from_journal() also use the bh afterwards so i=
f there was a use-after-free this patch wouldn't fix it.
> >>>
> >>> Did you see a use-after-free in testing?
> >>>
> >>> Andy
> >>>
> >>    Thanks for your detailed explanation!  this is not a real bug in
> >> practice, the reference counting protects against real UAF.
> >>    I'm seeing smatch warnings :
> >>
> >>         fs/gfs2/log.c:1044 error: dereferencing freed memory 'bh'
> >>         fs/gfs2/log.c:1051 warn: passing freed memory 'bh'
> > a "make C=3D2 CHECK=3D"smatch" fs/gfs2/" doesn't result in those messag=
es.
> > How can I reproduce?
> >
> > Thanks,
> > Andreas
> >
>    Hi Andreas and Andy,
>
>    Thank you for the review. The smatch warnings were reported by the Int=
el
>    LKP test robot:
>
>      https://lore.kernel.org/all/202607110908.l7Owhul4-lkp@intel.com/
>
>    I will update the patch with a better commit message based on your fee=
dback,
>    clarifying that this is a defensive improvement to address the pattern
>    flagged by static analysis, rather than fixing a real-world use-after-=
free
>    bug.
>
>    I'll send a v2 version.

I still cannot reproduce that result with smatch 0.6.4 (up from
v0.5.0-9185-gbcc58b9c) on Fedora 44, but I can live with this patch.
Thanks!

Andreas

> >>     And there are potential concerns:
> >>     1. Future maintainers might not understand the ref counting semant=
ics
> >>     2. The code pattern (brelse then access) is error-prone
> >>     3. smatch warnings clutter output for real issues
> >>>> Fix by moving the brelse(bh) call to the end of the function,
> >>>> after all accesses to bh have been completed.
> >>>>
> >>>> Fixes: e93b100931a4 ("GFS2: Fix slab memory leak in gfs2_bufdata")
> >>>> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> >>>> ---
> >>>>    fs/gfs2/log.c | 3 ++-
> >>>>    1 file changed, 2 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
> >>>> index 78bba8cc10b8..a92c84146de9 100644
> >>>> --- a/fs/gfs2/log.c
> >>>> +++ b/fs/gfs2/log.c
> >>>> @@ -1038,7 +1038,6 @@ void gfs2_remove_from_journal(struct buffer_he=
ad *bh, int meta)
> >>>>                       set_bit(TR_TOUCHED, &tr->tr_flags);
> >>>>               }
> >>>>               was_pinned =3D 1;
> >>>> -            brelse(bh);
> >>>>       }
> >>>>       if (bd) {
> >>>>               if (bd->bd_tr) {
> >>>> @@ -1056,6 +1055,8 @@ void gfs2_remove_from_journal(struct buffer_he=
ad *bh, int meta)
> >>>>       }
> >>>>       clear_buffer_dirty(bh);
> >>>>       clear_buffer_uptodate(bh);
> >>>> +    if (was_pinned)
> >>>> +            brelse(bh);
> >>>>    }
> >>>>
> >>>>    /**
>


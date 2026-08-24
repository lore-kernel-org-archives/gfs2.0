Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD06E3EFFBA
	for <gfs2@lists.linux.dev>; Mon, 24 Aug 2026 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585766; cv=none; b=HF5iY4dLRC+e8szjPLdmGL2e/lKZF43id3VxKsrbH3DBXi16XosoCoMpaPuXjay0sclno8t5QEm/wOMm3/cl/ZrD72Z/qV4ReWK64VqWfX+j0TB6Mj1C0324RwppO204XBNQSdkdJRljbc9KQp2oLtCKUOT6Wc1zZy78kPHev+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585766; c=relaxed/simple;
	bh=eWlDsydBkJVGAHzAsnYUbFWQpnO7hLOHYh//wSJVaxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zt6Fecetr1FN1Z0ylLfwbZQIL8xoWq6+lI01BjXmbEu3Qi9p7BJJfVd5rDYlx5JwBeSdKgpkJmxhSYry1A2ZOTcQZaV+Pu82b15B9yC6IswawEw92d/vZsd5pzg7Ofo3bpGaf79hSx074iYLOXhnnIB05qXdWI/IEJOnyaU0ymQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZG4tNQl8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZG4tNQl8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787585763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o4H8quY8mdxgECxCy8ZZ0q2X+7LK5Bniv6J7tDYAPzo=;
	b=ZG4tNQl86GHlAD3pxS+NTjYW+oqwyirzGB2ojq3XKZPwDVE4K9wy2RGwZBzFvd50mz51Wi
	nu8rM3AfSBOqE9M36ZY/kTnTPkUpYzMKx3dp4+q6LjmH3+lCQkk5Q82js7MSsUdH5b/KDN
	YLbDkWqEwYCyoPkNSn85T4nBsJ6cgU8=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-RSB32LXuN22B9SRg-mOayg-1; Mon, 24 Aug 2026 11:36:01 -0400
X-MC-Unique: RSB32LXuN22B9SRg-mOayg-1
X-Mimecast-MFC-AGG-ID: RSB32LXuN22B9SRg-mOayg_1787585761
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-81e6abfca68so47580197b3.1
        for <gfs2@lists.linux.dev>; Mon, 24 Aug 2026 08:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787585761; x=1788190561;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o4H8quY8mdxgECxCy8ZZ0q2X+7LK5Bniv6J7tDYAPzo=;
        b=TGS1TpOtUXOyMZx/x6b6TPHXszrcDs6K2Jc5nkARONsK2McJte4kxaYlo4MhIou096
         zbQqfAuAd7SPh/F16+gy41jmW8BUUX8fiaqAb3UrBESZ5v3NdoFp1ctgXffEX8UMiT7s
         iH1LZT5Cyq3GjGmawT3DSk09S6KbiBHvU8khN2ikxip0hAaRxI7BK4m3Lyi+Eaa2m5Ma
         Li8tFfvumkQyHBm9rJiAPuqbeB4QqbjKHOZBZ7nUu3IDbR6wh1BiVkL1jbyzxNnP635N
         iVw8Yk8J+9vzQu98syhIyL/WAST/TiOahw/1Uqvl65CwdhopvG8P9En0rbnTqtaMMzZv
         qI9g==
X-Forwarded-Encrypted: i=1; AHgh+RqJsArtvevaSv8tZI8rgrj7AbFGe5c0WrlI+g0k9z9v+GjledJ8tBYqFOhEfs4BloqfN5tA@lists.linux.dev
X-Gm-Message-State: AFuF++mka9mY7HSnipidTrovSipUn57vvxk8cxEU7A6yyLkVRy63pZBq
	3zuhkmkRt20lOYEllPQroBiM75nclSOX4XuByLNWcHzul2Fa02IsJfG3O7f7WSzdENOXmjbgEEm
	/Oxv6dYp/KN7W5U79FVah6ca796pYWV5nGU8E77qIFKAVlymBZl4gQPLyjnXjZKvsovIDQ6fDwN
	XDz9Vhoyu8Rg2VtCRvvMQYWjz6rUEkgQ==
X-Gm-Gg: AR+sD11rpEo19eFntD5xTIQnVP7knQdfTQC7iOW61sIoSKGOu8bTJDB5BP2F1z3NbCm
	f4tRhYJr/r0uqRhSCnVe/HDF2JbVucFFnUBBKs5UUAvNkL8GH+Pn98E+9gnkP69QYl4QDlDzwGP
	tNqSN6bZgagjbU9Pf7Q2apOPVy4zv6RUutiiInZouCMCJoMVvicxzQWd83Sir00Fnr6A37gVO6m
	G9OzZ867pGZfkwhOst3XPMFs3i2IUqCaUtqjO27Q/4Y
X-Received: by 2002:a05:690e:1050:b0:667:9481:5b37 with SMTP id 956f58d0204a3-66cf20af6e0mr4154259d50.2.1787585760954;
        Mon, 24 Aug 2026 08:36:00 -0700 (PDT)
X-Received: by 2002:a05:690e:1050:b0:667:9481:5b37 with SMTP id
 956f58d0204a3-66cf20af6e0mr4154245d50.2.1787585760512; Mon, 24 Aug 2026
 08:36:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260617090143.735219-1-zenghongling@kylinos.cn>
 <d8d1d7fc-4028-4913-8025-cb4c39ab437c@redhat.com> <6A334EF9.3080504@126.com>
In-Reply-To: <6A334EF9.3080504@126.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 24 Aug 2026 17:35:48 +0200
X-Gm-Features: AcwNN1XhwfBPNpeyO_lIis6arQg4gOOk78Q-vaD0F3aK-9JBlTEER7midpSU4ME
Message-ID: <CAHc6FU4GD=QjKr5nBsxL2pO6Krj-WOtD_dND=hpzHfYwcuZ8Jw@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Fix use-after-free in gfs2_remove_from_journal()
To: Hongling Zeng <zhongling0719@126.com>
Cc: Andrew Price <anprice@redhat.com>, Hongling Zeng <zenghongling@kylinos.cn>, swhiteho@redhat.com, 
	gregkh@linuxfoundation.org, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: imbetjTjUnJM_HRYaLKHFyVqSb9UaLksL1oswGdac70_1787585761
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hongling Zeng,

On Thu, Jun 18, 2026 at 3:58=E2=80=AFAM Hongling Zeng <zhongling0719@126.co=
m> wrote:
> =E5=9C=A8 2026=E5=B9=B406=E6=9C=8817=E6=97=A5 18:51, Andrew Price =E5=86=
=99=E9=81=93:
> > On 17/06/2026 10:01, Hongling Zeng wrote:
> >> The function calls brelse(bh) but then continues to access
> >> the buffer head through bh->b_private, clear_buffer_dirty(),
> >> and clear_buffer_uptodate().
> >>
> >> After brelse() decreases the reference count, the buffer head
> >> may be freed, making the subsequent accesses use-after-free.
> > When buffers are pinned their refcount is incremented and the brelse() =
here is only called for pinned buffers so I'm not convinced that there's a =
bug.
> >
> > Callers of gfs2_remove_from_journal() also use the bh afterwards so if =
there was a use-after-free this patch wouldn't fix it.
> >
> > Did you see a use-after-free in testing?
> >
> > Andy
> >
>   Thanks for your detailed explanation!  this is not a real bug in
> practice, the reference counting protects against real UAF.
>   I'm seeing smatch warnings :
>
>        fs/gfs2/log.c:1044 error: dereferencing freed memory 'bh'
>        fs/gfs2/log.c:1051 warn: passing freed memory 'bh'

a "make C=3D2 CHECK=3D"smatch" fs/gfs2/" doesn't result in those messages.
How can I reproduce?

Thanks,
Andreas

>    And there are potential concerns:
>    1. Future maintainers might not understand the ref counting semantics
>    2. The code pattern (brelse then access) is error-prone
>    3. smatch warnings clutter output for real issues
> >> Fix by moving the brelse(bh) call to the end of the function,
> >> after all accesses to bh have been completed.
> >>
> >> Fixes: e93b100931a4 ("GFS2: Fix slab memory leak in gfs2_bufdata")
> >> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> >> ---
> >>   fs/gfs2/log.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
> >> index 78bba8cc10b8..a92c84146de9 100644
> >> --- a/fs/gfs2/log.c
> >> +++ b/fs/gfs2/log.c
> >> @@ -1038,7 +1038,6 @@ void gfs2_remove_from_journal(struct buffer_head=
 *bh, int meta)
> >>                      set_bit(TR_TOUCHED, &tr->tr_flags);
> >>              }
> >>              was_pinned =3D 1;
> >> -            brelse(bh);
> >>      }
> >>      if (bd) {
> >>              if (bd->bd_tr) {
> >> @@ -1056,6 +1055,8 @@ void gfs2_remove_from_journal(struct buffer_head=
 *bh, int meta)
> >>      }
> >>      clear_buffer_dirty(bh);
> >>      clear_buffer_uptodate(bh);
> >> +    if (was_pinned)
> >> +            brelse(bh);
> >>   }
> >>
> >>   /**
>


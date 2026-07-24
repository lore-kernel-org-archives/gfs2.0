Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F66443A8F
	for <gfs2@lists.linux.dev>; Fri, 24 Jul 2026 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909887; cv=none; b=X4E72dZEXEFo9QQNqEGQz7x0JkNBx9d193/eSHxa2J1N2mbHZxHpoKLsNTHDpzZ20PQhLeFN/99+f0pvBF17MJWfUrynhqDIowLP5w+Lqh8SLo5XvVp3p9RDXqXCLjsOJjOcIqgjZRP+xvdHRmUPqcAtkKpF47QX/3zyq+umUE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909887; c=relaxed/simple;
	bh=FS148GVtAo9YESa4qtlhjt1m0S7WkWpn51VflSkt4+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dqmBR4eGJvKj1Yt+mD82hb4ZItHN4xac2JnDeAUik/gw0KyhojZx++P89JITFzyvJE5iB7YCIKGEoPPsSHk228yBObUTWOCss9stCM84CEkCLBkF+30Lx2+kBCryfeNNf8/LN3lQGuxDSfW4W75HaLAjRhGQz7pNYdfPU6g4aGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YOTYTa3C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOTYTa3C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784909871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SSASOBNt7OC80h+08zQCyhdWwUBqUG9dl7IFlrv2/SE=;
	b=YOTYTa3Cilnw/4XCgYATaAj3sjUILHVNCk9msYR41kI8JEkuwW4ldNcU4GqOduJXjA0ObK
	dXbyV7lCj6IvpN9YTv43dE7LCZ+pyz6FTFWLqqb0Zjj/ylF7xBjAemQ0Gt71By8SREpS2O
	CJaMgJDRZQpyg67vLwOC21y6iP+hbSk=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-YbI1OtNyOxmVmRT2Dm2EUQ-1; Fri, 24 Jul 2026 12:17:49 -0400
X-MC-Unique: YbI1OtNyOxmVmRT2Dm2EUQ-1
X-Mimecast-MFC-AGG-ID: YbI1OtNyOxmVmRT2Dm2EUQ_1784909869
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-81e68281f2eso5916027b3.1
        for <gfs2@lists.linux.dev>; Fri, 24 Jul 2026 09:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784909869; x=1785514669;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SSASOBNt7OC80h+08zQCyhdWwUBqUG9dl7IFlrv2/SE=;
        b=qmvpgTuDC5+RAjSSefVMG0sY5kPhaeT2V7g4R2OGi72mnF/S1zEfZnY66VoWwO4hZY
         kHjdko+/pyoGuu7m6DGSPftZfmD5kOAW02AGRI2k67bbLlS/Hr6vKBV8QHYGyJlFblBH
         fd5RvEWnKBaAmkmcLY3wG+gSq5J+g1LnVRtzq7iYh0QfcuHYewLo7kPcirF9mvVXBLQ0
         zoNMNr0rcQykFEvI3mEPgkkTQEUkzsyccWZOxncP04p4s6c5xZ2dRk65WhZoBDEDCfUL
         v5rFIa5I+D1qP2NyPyA5UZbe2lnEJcWZL3wf5d9Q7CwBu4YMrMBzLoDjfHck2f85icQC
         6CAA==
X-Gm-Message-State: AOJu0Yynre20eCTG6hz9BJxofAz5hixLKcERuql3Gkx4/bwvC5EoCPXH
	lZD2VdWgdNTrjq4vF8oIyrn0hdnmpXYYRiM/HgWKVSH8S9WqZApjCCp4/ZVT4n39mpCLXdA7kSh
	uCah/+DnLOvJu/pNCgUYG2K99Ed96YOd9LITQB4XnpvbEmPHJY/I/kV5/0OMvPCFpfUjmLUzRJ6
	3Buew3zw5qfcVpTmkumd5O2+ZGEU5Zfw==
X-Gm-Gg: AR+sD135nmTf7TjHYSi5ggNonXAUqiFby9i/D7SQF0iWqNlayUH5yTireuWk8I08/g1
	h4dGWoB0Se+5zCXfO18k4W/MUxcs4VTNfafXuhjZlzZe9h/p8s6B9zhgUW3syhY8N1MSh2FkPfm
	m46uXjo1+SqNMVQ/IG5HYSaLtk6eZ2UtEoXF18wcOaZrz433+0BJUlN/Z+4RKpfrCuclg9O/nId
	aIqheFlNdsVVd8yiC3DRTsBusmLNF/t8dMd/afMwB0b
X-Received: by 2002:a05:690c:d07:b0:80c:90ed:c79f with SMTP id 00721157ae682-81f4c30b5e3mr26327587b3.52.1784909869210;
        Fri, 24 Jul 2026 09:17:49 -0700 (PDT)
X-Received: by 2002:a05:690c:d07:b0:80c:90ed:c79f with SMTP id
 00721157ae682-81f4c30b5e3mr26327467b3.52.1784909868718; Fri, 24 Jul 2026
 09:17:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <6a439474.4d70c427.9c655.9b2d@mx.google.com> <CAHc6FU606F2o-YD7_J7k8b_uUUzGOJyu_3vvkO1NN2c5_-q+8Q@mail.gmail.com>
 <CA+cq9YO=6PJ1Xx97vMuWsv+h8ebe2a8mKYoktuyZOY6MBKRxzg@mail.gmail.com>
In-Reply-To: <CA+cq9YO=6PJ1Xx97vMuWsv+h8ebe2a8mKYoktuyZOY6MBKRxzg@mail.gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 24 Jul 2026 18:17:37 +0200
X-Gm-Features: AUfX_mwHABKpTKcgBPpb_eYqhENEA7y6DBqilGNRBWUjjhCUQ9ZSyu-2nXPDEBQ
Message-ID: <CAHc6FU4X1DM5oKqmQ3FRKumNTvAmfqGgFdwx_m5u7xSg3UubBw@mail.gmail.com>
Subject: Re: [PATCH] gfs2: add missing __rcu annotation to i_gl in incore.h
To: =?UTF-8?Q?Adri=C3=A1n_Garc=C3=ADa_Casado?= <adriangarciacasado42@gmail.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3hIwtt7PP-9ee-wA8KHq9nECcdDUX3pWZ_zDo_rQv6I_1784909869
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 6:05=E2=80=AFPM Adri=C3=A1n Garc=C3=ADa Casado
<adriangarciacasado42@gmail.com> wrote:
> Hi Andreas,
>
> Thanks for applying the patch!

No, I'm not applying that patch. As I said, it's not really fixing
anything, it's only trading two errors against 200 warnings.

> For the record, I have successfully boot-tested the patched v7.2-rc4+
> kernel on bare-metal x86_64 (Debian 13 native on an ASUS Vivobook).
>
> To stress-test the kernel stability under load, I ran some heavy workload=
s:
> - A standalone loopback mount of GFS2 (using lock_nolock) with I/O stress
>   tests (100+ concurrent files).
> - A full multi-threaded compilation of the PCSX2 emulator (using CMake
>   and Ninja) with all CPU cores sustained at 100% load.
>
> The system behaved completely stable with no deadlocks, hangs, or OOM.
>
> Tested-by: Adrian Garcia Casado <adriangarciacasado42@gmail.com>
>
> Best regards,
> Adrian

Andreas

> El vie, 24 jul 2026, 17:33, Andreas Gruenbacher <agruenba@redhat.com> esc=
ribi=C3=B3:
>>
>> On Tue, Jun 30, 2026 at 12:03=E2=80=AFPM Adrian Garcia Casado
>> <adriangarciacasado42@gmail.com> wrote:
>> > In gfs2_inode_lookup() and other parts of the GFS2 filesystem,
>> > ip->i_gl is accessed and dereferenced via RCU helpers like
>> > rcu_dereference_check() and rcu_access_pointer(). However, the
>> > actual i_gl pointer in struct gfs2_inode was never annotated
>> > with __rcu in incore.h.
>> >
>> > This missing annotation causes Sparse to throw multiple
>> > "incompatible types in comparison expression (different address spaces=
)"
>> > warnings and compilation-blocking errors under strict static analysis =
builds.
>>
>> Indeed, there are two sparse errors related to i_gl.
>>
>> > Fix this by adding the __rcu annotation to i_gl in struct gfs2_inode.
>>
>> With this fix, I get about 200 sparse warnings instead of the two
>> errors. So thanks for pointing out that there are errors, but without
>> fixing any of the underlying problems, this patch isn't very useful.
>>
>> Andreas
>>
>> > Signed-off-by: Adrian Garcia Casado <adriangarciacasado42@gmail.com>
>> > Tested-by: Adrian Garcia Casado <adriangarciacasado42@gmail.com>
>> > ---
>> >
>> > diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
>> > index 6146577..16df753 100644
>> > --- a/fs/gfs2/incore.h
>> > +++ b/fs/gfs2/incore.h
>> > @@ -392,7 +392,7 @@ struct gfs2_inode {
>> >         u64 i_generation;
>> >         u64 i_eattr;
>> >         unsigned long i_flags;          /* GIF_... */
>> > -       struct gfs2_glock *i_gl;
>> > +       struct gfs2_glock __rcu *i_gl;
>> >         struct gfs2_holder i_iopen_gh;
>> >         struct gfs2_qadata *i_qadata; /* quota allocation data */
>> >         struct gfs2_holder i_rgd_gh;
>>
>> Applied, thanks.
>>
>>
>>
>> Andreas
>>


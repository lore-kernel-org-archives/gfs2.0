Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072EA415F3B
	for <gfs2@lists.linux.dev>; Mon, 24 Aug 2026 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581272; cv=none; b=dajgZEu4Vr11YxAnUl/iXJz0ck583F2qbxhSK3aAjqoVZsUG6NYHp/knCWth4/fsQCpuK9JohbSYC6pGe81GFlIz+4c2n12+WtGb62Yq62I0S3dBcM7kXoIlGM4TYJl8nH8fqDnt+arVZS/CwPv97KUMs8mJATeB/VaVfRW38Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581272; c=relaxed/simple;
	bh=xyaUNk32UueS0iHO7ZTIoL52DdHNdYjC8aBsaFPf8lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emyaKwWxw20rCm0baAag/or+0u1OxmHWHvYzVV//ZDZ1Bs31aGtKEVOoKPsLOphOm2PolsAQAJqItz3NXZzTdBwDmeDTgomw60PwqKZQb+7Rq7cwHXHWgr0vs0Hxa8vrVyPD/KD4iBVKYkbg0wIemmhJvyYfF5ijdZdF73vTkno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gZ+fGYFY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZ+fGYFY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787581269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xyaUNk32UueS0iHO7ZTIoL52DdHNdYjC8aBsaFPf8lc=;
	b=gZ+fGYFYHNYsezilYBbATzuZBKbMzVCOtebP9uRZEaoSBMiE7mCSUhzkEnPO+XwB7Fs4CK
	GjaTpM3AGL6dGbMsdMF6XxCdUke2ruu0yokyNrvX9Ikon/4IarzndR7QQQy5uon4PBw1py
	PcdfF3NzCqYOzN9bI1z23bNA0RYO19I=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-Uw1WGaGVPHOLrXmcQvcg2Q-1; Mon, 24 Aug 2026 10:21:08 -0400
X-MC-Unique: Uw1WGaGVPHOLrXmcQvcg2Q-1
X-Mimecast-MFC-AGG-ID: Uw1WGaGVPHOLrXmcQvcg2Q_1787581268
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-66cc7e43096so2649185d50.0
        for <gfs2@lists.linux.dev>; Mon, 24 Aug 2026 07:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787581268; x=1788186068;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xyaUNk32UueS0iHO7ZTIoL52DdHNdYjC8aBsaFPf8lc=;
        b=mqwqqA15M4s31sHW0gvdPhQgNnjmJoNMPGR0aNufvrIVRIuUTAZyWLYs9SByKTKy4M
         NVMjOluETEuQvjD4zDJB3x2qYuWbfvyetOQ1QM9p7c6oI1sOOxNYFD01MTPuEhmV07XJ
         UABp+ffz2kIKVv0gl02c9c1oIYvd8ViWUvgiWM3OGrM77tPuN6IJLr6uncehxs2jLnic
         K2oBJYZKUvpLXxltvqOpIctFesszHvOnmtZhcIO5SAL3VHhsUDg2BV4fYpblifbmfuBC
         +Kp06GT7GHnsJp+g8S3u3NOu12JyqQ47alP1cP2DaSrDXGKqhrLXClctfmkWps3j5LEI
         3kCw==
X-Forwarded-Encrypted: i=1; AHgh+RqXIr95u6aU4mg35IfA/3kQcAgw2KvZy+55fH5h5TufSXjdFe4R2CgDBoMfai/uKiMR+HTN@lists.linux.dev
X-Gm-Message-State: AFuF++kn3MP2PR68c54pgVLuJhFwzOh0f4T6uelqvD/VqxhKbHNGMsFF
	05vDBgQTj4Zjk5TmEJOTqSYUWswFpNn7p2rmQvov/GcC4IZJFS//ActZELxiI4xC+xw5m+w9VOC
	ENfGitRvsfk8bK3D4K+A6j4W/ge89jbNO6AJ/OvBDG49qk6fcxrmpGQK3Bz4iwV+Gtc73SNlyi3
	lO2jQwRIWJ0+UcyWeEOzc1UsqvR5N/vQ==
X-Gm-Gg: AR+sD129aSdFvDN22p0fTw4fYDucd4diqL2M/hmmoTyn5OCbgu3Y9b0kezSw9NVoski
	6QZAtcVj9354XR0ywnQikD31CUErCyYazXl71hAl7qzGCCbebM0DvryCKo5p6wd348lwq2yiux+
	KIh2PkUV928D+bvVdmS/fgJm1m9TzAYf8zgzXInLzNfwY9Ssyq/ozJKbwX7tw5hzBbFYSW0FP4N
	7GymSUOoYo0XaI91fBqv6rEUXTv8T5vy55X4hDDtdlG
X-Received: by 2002:a05:690e:4882:20b0:66d:113a:3928 with SMTP id 956f58d0204a3-66d113a47a1mr394387d50.12.1787581267742;
        Mon, 24 Aug 2026 07:21:07 -0700 (PDT)
X-Received: by 2002:a05:690e:4882:20b0:66d:113a:3928 with SMTP id
 956f58d0204a3-66d113a47a1mr394358d50.12.1787581267004; Mon, 24 Aug 2026
 07:21:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260617090143.735219-1-zenghongling@kylinos.cn> <d8d1d7fc-4028-4913-8025-cb4c39ab437c@redhat.com>
In-Reply-To: <d8d1d7fc-4028-4913-8025-cb4c39ab437c@redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 24 Aug 2026 16:20:54 +0200
X-Gm-Features: AcwNN1XEQgwDA5G4wnQLu4cn0ooNxgIyAuHj1704_8F6gMnfG62r0vVlkueYlZE
Message-ID: <CAHc6FU6b00qRUXzTR27TL0u4Nf39zzvrCUjjFAa7ttwWYtRBmQ@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Fix use-after-free in gfs2_remove_from_journal()
To: Andrew Price <anprice@redhat.com>
Cc: Hongling Zeng <zenghongling@kylinos.cn>, swhiteho@redhat.com, 
	gregkh@linuxfoundation.org, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, zhongling0719@126.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UJ8Z3xz22TDv8GzVUCwY8qvVf7avv7LPAKNa1APBEms_1787581268
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andy,

On Wed, Jun 17, 2026 at 12:52=E2=80=AFPM Andrew Price <anprice@redhat.com> =
wrote:
> On 17/06/2026 10:01, Hongling Zeng wrote:
> > The function calls brelse(bh) but then continues to access
> > the buffer head through bh->b_private, clear_buffer_dirty(),
> > and clear_buffer_uptodate().
> >
> > After brelse() decreases the reference count, the buffer head
> > may be freed, making the subsequent accesses use-after-free.
>
> When buffers are pinned their refcount is incremented and the brelse() he=
re is only called for pinned buffers so I'm not convinced that there's a bu=
g.

Not sure what you mean by that. The patch still only calls brelse() on
buffers it unpins, it only changes when it does it.

> Callers of gfs2_remove_from_journal() also use the bh afterwards so if th=
ere was a use-after-free this patch wouldn't fix it.

Do we have any callers that do that when they don't clearly still hold
a reference? I don't think so.

In any case, if there are any callers that don't certainly hold an
extra reference, we need to be careful in gfs2_remove_from_journal().
This patch achieves that, so I'm inclined to merge it.

Thanks,
Andreas


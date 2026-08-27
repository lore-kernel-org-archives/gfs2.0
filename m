Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097453B993A
	for <gfs2@lists.linux.dev>; Thu, 27 Aug 2026 08:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787817911; cv=none; b=EGaJsPd4PKjRx8claW0YPoWB0LU3OdRzfCYqiqAlyWWw589c8meXAzZyvXAwOt/Q01rAp/0CHaOvBdRH/sRq1k1Fx+3P8tq2ndS4p1524MI3OwsSrgtmL6xK7Up/pDqEQwn24udhjsXNWWBDgk6QLZQiwFfJnlvec0/R6vUg4ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787817911; c=relaxed/simple;
	bh=oCHlrU9PYmt9yzqxa3asUHOexrGAA0lr63AtxPgvHsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptt2bKy40oTUKEqOCls/nhrMUe1NXCT66rpslXnpw8blTv4PG/9voIAmsdZ0+HQQbbHqduT9rbQkVxVklhT1KslU8R6y/sxTfzOKBhL4UpWXWWYj8LLl0N4QVkhxT/TLCtgDOsk2vWWf8dUVbIsUxmSqoAZr2nw96FnQNXJJT0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XnXVrP9t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XnXVrP9t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787817904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=azhbdQCZEFVE/DWcZ3GrL9ze7Hy93ahYH6cH+iy53kc=;
	b=XnXVrP9t868R2R7qPf+sO2g9oxSA3HD95evX6HZhdie+FB/wnbBEswuniJZfiWcrq+OVsu
	0eA0KTuYhkvl7pzkFoPAaIdDObftjdVVZxmBhLWVTTmT+abwc2ZihcoTnTfGKtY3nU8Ni/
	//gj6eq1P22n5UrlJvb99fHIVuMIWGs=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-Gyw2NUaHPGidbUaQBCS6sQ-1; Thu, 27 Aug 2026 04:05:02 -0400
X-MC-Unique: Gyw2NUaHPGidbUaQBCS6sQ-1
X-Mimecast-MFC-AGG-ID: Gyw2NUaHPGidbUaQBCS6sQ_1787817902
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-836c8fc09cfso69167347b3.1
        for <gfs2@lists.linux.dev>; Thu, 27 Aug 2026 01:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787817902; x=1788422702;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=azhbdQCZEFVE/DWcZ3GrL9ze7Hy93ahYH6cH+iy53kc=;
        b=icZw/CDvljweUxEAsNGjfQ3HkJP7hwRfoshwBrW5nHcHnlNPzMDHECnCBSN0bP+J1d
         SnYrXh5dPab9uNpLi6u1p+jxTyk6jtFj3bBw20Fx4ACPirB6oYjkXMp+yDunUQ99TaEz
         wN6vJJqKEO2tE9HtfbeE4WJIFd6fJ/zRPJGijaYgEEKfuwyX0bUSNundwegZQ84wYrt3
         xpJhvxJJb5w+JiLtiAPBSyGDqpGWgsQ1pzKI77WafllQhI5jqwpSt9s7Oq9rFsnUUR7l
         IifFRDzcGFD1c0Wxx4pEAHQmEEhcOiMEpvAkcdpwx9lo8ZlrffqWJmdI4HmB/SWucOUv
         6xRw==
X-Gm-Message-State: AFuF++nnsba5+fmFLJQ5w2YKIVmzim9pJ6iM1s4IAJUedmjlDO2SkTuw
	bQZ8E7nJAHOqXSw0dyuiuTOOZ7wdAKDrFErQ9oJfZmp5zSY33+ppx80iHbu647+o7IPPFobsJti
	AuGbTtoZ68sRvMcrHRnH30thk0/7/J5G6hg8wd1BuWE3NAkeKNN7no0Ktp7VFK8nkre1ltVQE1P
	YJeY7wrayf6RVCmFoSUPo7SSJOvGIFIQ==
X-Gm-Gg: AR+sD12MIL1kuWktlMxL/6gMHvsYdj+ogRdbkTpoJXXYjmIEz15c17JbOHNWzfQpzcE
	MNyEqul9PErnRv05zRtArREkptbpyCs7F0K57YqeEZZLsxKkIUG2BZDi+EBRJkUqXd7N8m1ND7a
	CiRqECJU5jkvzyY2Cz7wUd+oNn93qmHPYv9hI2HNHXdfFRzKvIY7eki+E7sDiOKCoIwRkGs5afU
	YBBaSwURFxO7z1/uJiqjPicG9R0RRLJvRQN+je8+yac
X-Received: by 2002:a05:690e:414a:b0:66d:16ff:2126 with SMTP id 956f58d0204a3-66d25792f27mr4527159d50.30.1787817902316;
        Thu, 27 Aug 2026 01:05:02 -0700 (PDT)
X-Received: by 2002:a05:690e:414a:b0:66d:16ff:2126 with SMTP id
 956f58d0204a3-66d25792f27mr4527128d50.30.1787817901739; Thu, 27 Aug 2026
 01:05:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260630041432.96776-1-kartikey406@gmail.com>
In-Reply-To: <20260630041432.96776-1-kartikey406@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 27 Aug 2026 10:04:50 +0200
X-Gm-Features: AcwNN1VRjrrgLiEOz0SquCK7V-ix5FDPB5DR501AiLqy7SgyohwvvMuNsxm_shs
Message-ID: <CAHc6FU7x5By1YusP4RF0DEDe2sWAf6A-p09gxSstDvTsLkQsKw@mail.gmail.com>
Subject: Re: [PATCH] gfs2: fix null-ptr-deref in gfs2_quota_hold during unmount
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+cb79de2cc8b76fbf474f@syzkaller.appspotmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CVFhQhGmJdbn1Z6lAsujQtzw4FjM3GwFoDXREewbb2A_1787817902
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 6:14=E2=80=AFAM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
> gfs2_quota_cleanup() frees sd_quota_bitmap early in gfs2_put_super()
> before the iput() calls that can trigger inode eviction. When an unlinked
> inode is evicted during unmount, it goes through:
>
>   gfs2_evict_inode() -> gfs2_dinode_dealloc() -> gfs2_quota_hold()
>     -> qdsb_get() -> slot_get() -> find_first_zero_bit(sd_quota_bitmap)
>
> If sd_quota_bitmap has already been freed by gfs2_quota_cleanup(), this
> results in a null pointer dereference:
>
>   KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>   _find_first_zero_bit+0x29/0xb0 lib/find_bit.c:149
>   slot_get fs/gfs2/quota.c:355
>   qdsb_get+0x133/0x340 fs/gfs2/quota.c:522
>   gfs2_quota_hold+0x191/0x5c0 fs/gfs2/quota.c:606
>   gfs2_dinode_dealloc+0x176/0x3f0 fs/gfs2/inode.c:488
>   gfs2_evict_inode+0x11cd/0x1400 fs/gfs2/super.c:1479
>   gfs2_put_super+0x300/0x860 fs/gfs2/super.c:618

This is happening when the metadata part of a gfs2 filesystem is
mounted (mount -o meta), the statfs inode is unlinked, and the
metadata filesystem is unmounted. This is not a useful operation; it
will leave an inconsistent filesystem. The kernel should nevertheless
cope with it.

An appropriate fix would be to skip metadata inodes in the quota code.
I will post a patch.

Thanks,
Andreas


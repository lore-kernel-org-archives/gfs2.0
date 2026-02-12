Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B07E29B777
	for <gfs2@lists.linux.dev>; Thu, 12 Feb 2026 13:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770903237; cv=none; b=VAJOHaQ60tMrDsyUEIzx2QbpQnxReLiaVhHF0RNg0otW6UopCYcOSJyuv066kfgenkXplYdlB+CGm+OyxmkmlWLlyRoudsvDXaGSzDMwlZKG7s6LCIgm4lRt8j/s1L9kyp25/JcGRJOwXNeVKxTuURFeYwmFGcWORyKBHDJ3hM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770903237; c=relaxed/simple;
	bh=AHFakH0y2rrZmaWS6xHv4RQ9Ta0qZMhdwwOzR44urWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0XUWPM1xUTWcCNC/T5m+GB8zW7qpvDI+3JeahALwkr1t6D1dF4nDYxgfqK8Az32wEftgRWi4e1GcjNJe6yapU4odNOAAwtpF0eK21GoMIqD7nq1kpcHgEJF5WnxMFS9ba0PAqEioHcPKcGyc+uxRto8znWXFa7b6kJntm29mTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hvbZCvyN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvbZCvyN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770903235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AHFakH0y2rrZmaWS6xHv4RQ9Ta0qZMhdwwOzR44urWc=;
	b=hvbZCvyNXD1bRf4L1IscsJuccNoSbOdfR7QVzaMPCCCJi/JRC0Fo2Q5VaEMvSzLewZDVKg
	0v/IIPXEESCsQa6eEi4N2DV9/8lWsw/SAlKCHx+6OdhmWBuIxOBtyN/j41ccHxL1HBEWI8
	H7vHxxisfLWvCUlKy0KHFsVL9E548QA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-3b_y7ExLN72uWyweLkJS_A-1; Thu, 12 Feb 2026 08:33:54 -0500
X-MC-Unique: 3b_y7ExLN72uWyweLkJS_A-1
X-Mimecast-MFC-AGG-ID: 3b_y7ExLN72uWyweLkJS_A_1770903233
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-38710504f15so5098771fa.0
        for <gfs2@lists.linux.dev>; Thu, 12 Feb 2026 05:33:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770903232; x=1771508032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AHFakH0y2rrZmaWS6xHv4RQ9Ta0qZMhdwwOzR44urWc=;
        b=UAoxVHRf1kfCtp7L/ZFG6nl1h1x0bcr+2DwEGkpQnmXI3NmpldNwnt+tFd1+B5T95P
         jOty0Lu0fm79jqaVU3WdrihwkGY+PYTsUBw5RqT1K5FyPapungXsKaglZ1yY/0UPDnmu
         /giCt77Jk9Iw1jF6qngMGfT8Pz0EBmxULJz1MyyCGQv0XJBJtd7klHS6LFHkMOaMvhFc
         1nYr8uUrtDd7scdya5b8NsUPFbc0NOEPbX+KaMG1rndNPkN75br1uHYLvpOMQig73wyi
         z5Qyxsu+MzS3YtAMTqED1YmsRi0J/IxgDAYmqiYvaTFe5s4AlRHmi8donQCjcfwoyb70
         TRKw==
X-Forwarded-Encrypted: i=1; AJvYcCU+6XZnXESpSBHTySjJ6+mhGtQHFV2PCpPONJ1jAcEqa4bNblN7jyDTuJGWwJEk1Dge3MIy@lists.linux.dev
X-Gm-Message-State: AOJu0YxAJP3qeyzNaaM/cNpzFVX/SHP3Xl8T5VwOjmwRjbQCyDIvIMca
	T+fJCuZjQKKZYjuWaNcLTVIfNO5DlMadu4aOIAZ95Ndh2eLAriaBPVACdeg1tyZzwFs2eV/V/aQ
	t0k1HvHne1afi3zZpizWFBYztgWwABaYEiSDBgSPnFENPhSqF89mlWPM5H4AQMTCLGC73Ji3Pb3
	rlV3hO0WL73f5+JaGIyMAyz2le9yj2Cw==
X-Gm-Gg: AZuq6aJl+8BWtcYbVpk0Z779FTw5m5RAxBa497N+LrrP9TxHEiKW4n7NLxy4XcgkO9y
	WswqBDKehnaiOhNtYYO25SriuEDhZJZrl8fnCVNl6yH18LFp1sbmuRomp/oavQ/msJXTNtLWuzm
	PEc/lRtsLA9T1Xl89s5dqQam642Ihrn1EhRgZ2XFpX27nz6MTOZFHj91NLLC9nDWSGCq2jw9gI0
	ICpGuFHqx0aUM9XPpTOnJXtVWD8PExdyG5GVI4=
X-Received: by 2002:a2e:9205:0:b0:385:bb35:8e45 with SMTP id 38308e7fff4ca-38711bcd1f3mr7034021fa.6.1770903232467;
        Thu, 12 Feb 2026 05:33:52 -0800 (PST)
X-Received: by 2002:a2e:9205:0:b0:385:bb35:8e45 with SMTP id
 38308e7fff4ca-38711bcd1f3mr7033911fa.6.1770903232032; Thu, 12 Feb 2026
 05:33:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260212034254.2864235-1-n7l8m4@u.northwestern.edu>
In-Reply-To: <20260212034254.2864235-1-n7l8m4@u.northwestern.edu>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 12 Feb 2026 08:33:40 -0500
X-Gm-Features: AZwV_QjdTFGOqkL_htkyZaXZiBS7ZHFwqyR0pjmByM8pf3kRv7eqpEW166FK2bg
Message-ID: <CAK-6q+jySOc8qWJD+8oVXojf_T5L3qSB+Tt-q1gdZSnm6a=wxQ@mail.gmail.com>
Subject: Re: [PATCH] dlm: add usercopy whitelist to dlm_cb cache
To: Ziyi Guo <n7l8m4@u.northwestern.edu>
Cc: David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: THtMtfQZduWt1U1HAFuZsXI8zKetHl_2gdX_AuUPqHY_1770903233
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 11, 2026 at 10:43=E2=80=AFPM Ziyi Guo <n7l8m4@u.northwestern.ed=
u> wrote:
>
> The dlm_cb slab cache is created with kmem_cache_create(), which
> provides no usercopy whitelist. When a callback carries LVB data,
> dlm_user_add_ast() copies the LVB into the inline lvbptr[] array within
> the slab-allocated struct dlm_callback and redirects ua->lksb.sb_lvbptr
> to point to it. copy_result_to_user() then calls copy_to_user() with
> this pointer. With CONFIG_HARDENED_USERCOPY enabled, this triggers
> usercopy_abort().
>
> Switch to kmem_cache_create_usercopy() with a whitelist covering the
> lvbptr field.
>
> Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>

Acked-by: Alexander Aring <aahringo@redhat.com>

Thanks for pointing this out.

- Alex


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4233AF644
	for <gfs2@lists.linux.dev>; Thu,  1 Oct 2026 23:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790896035; cv=none; b=QXD/8T1uEPnWfxvkliRE6zg89TtkRAjE9v13QctWa6Tg7ZokntZm8PRWY2YEFaI7UEmSSe9LCGYuVobL+zLoqJfDS1oTzRmEek0tsePPd3I/YfokOKgmnj07OICeQpR2VEdgfhonMhe97IQQTkzk6Ii9m86LkZ72dqfgtxh8sCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790896035; c=relaxed/simple;
	bh=KCv3D+/XMsj5hjQ2qR38XiJ3yPGIPImX0wLnjntJOqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JdSvaHCfdvjkVTCnJHKbLvmUSOPA5qKQLR3Ib7DERqcnI27ZXyhGRu6DH/NRQph7qyQya9OiEaHvzsNna68yY71otUJAOuc8uAM0MC1qM59RkMsFQchgGqIJw9RpW5ZNijLhyHp9IDGq+k1p+aLahbH5r7UTjU4DssUgSnfuTek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GBJYmJna; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GBJYmJna"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790896033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TqdOQpt6dGWKFEcZ75Ec/BD9ZEu1flTfgjeYi1D79ic=;
	b=GBJYmJnaAzNVBA1gGbWsTvq8/HiX93QtuT+6Bgq+JxfpEGF+6Quey7Nn7AckPKCcks5MxS
	4BqzHpX7q6z/++vYu2+LYs5sgXT+P/KR5FdsrwvKWxc29H4c4yfw6eMPYGcFucHewjy3+F
	Oh1tCuwRCryNEP44IUEWMaWBFCRZehI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-7enjl3j6P-af6ls7ifmHWw-1; Thu, 01 Oct 2026 19:07:11 -0400
X-MC-Unique: 7enjl3j6P-af6ls7ifmHWw-1
X-Mimecast-MFC-AGG-ID: 7enjl3j6P-af6ls7ifmHWw_1790896030
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5b8f0c13295so3063091e87.0
        for <gfs2@lists.linux.dev>; Thu, 01 Oct 2026 16:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790896030; x=1791500830;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TqdOQpt6dGWKFEcZ75Ec/BD9ZEu1flTfgjeYi1D79ic=;
        b=P8TbkW9VvaP7QMaHsiu1WH5vN+ZhMXNBqRVscoNmoy8zlWFE1chX8klSsXlQTriO1m
         vG72i+CUacuM71m4C2qKcFafpDXi2ndLTZP+9gF3ON6ZSImCMZo5Ww2sHOAybuKhNfmn
         XAwaWOPjSKM1fseVjhBJMERFolUqeaNM2vFAFzmR12PAUuQSoj0IlpLl2RF/cvrezAj2
         vhcrkaMsitaE1ykVUzwdBIpVbXK4W69yVPWfBcfdKpiM7789ZcOa0/zc1qcsIIt/kEnp
         M/LvXdWf3z6WzwTQw79VW+RrJ1qQ/NWpact4cvya/FS/IlQh2ETmGMfc26sZh4z4shdb
         h7ww==
X-Forwarded-Encrypted: i=1; AKwUvBzyC2ljlsOYDGG30plHMPy7QnCsGEWNeLzu71JpDPC+6cn+yaSg6joEjpZrz/e/grcQjHQI@lists.linux.dev
X-Gm-Message-State: AFq9FYKqMPHQgF7Xs0BnqHoBuH4pv39oTFabDgsy8zwXLbVWsUHfDSBs
	X8O8todjfQiidSAKuS3HMScdJ1fV3ixyQL/c506aR+4Lv+3bBLz57IlD3qhPx/0O1d64kjVEydQ
	xnCb+VgFbbtQ/tnsKmkEiFK4FtZrnGBQeB5pqOPlTpWK5Sb++LGE1gzh/KP+MnOIz7IJbVesAvz
	wk8juEEr5P0DYWjfwf2zEOWgihuYA+wH9JLk9xXpaI
X-Gm-Gg: AYBFou2tbsg5ccPL+ZnmFwEYXCyfW1bPUqR5RfgDlwXzJUwyaUpRggll88VyI70OSWY
	3iP7H4XdLZtMzzMRGfbw9+N8NP4pvvjek3u1CRbn4SEPshojCuhGA3F4u+TPH6w2HwxngowL6tY
	jEhamnQ2SpbvIRC4iXXWZnkuz3tnXPjpYlixXitS70wARFYJmqxhE5W/58
X-Received: by 2002:a05:6512:688d:10b0:5b8:edeb:5c29 with SMTP id 2adb3069b0e04-5bb9bc3af80mr182032e87.43.1790896030361;
        Thu, 01 Oct 2026 16:07:10 -0700 (PDT)
X-Received: by 2002:a05:6512:688d:10b0:5b8:edeb:5c29 with SMTP id
 2adb3069b0e04-5bb9bc3af80mr182024e87.43.1790896029983; Thu, 01 Oct 2026
 16:07:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260910080051.160454-1-a0yami@mailbox.org>
In-Reply-To: <20260910080051.160454-1-a0yami@mailbox.org>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 1 Oct 2026 19:06:57 -0400
X-Gm-Features: AclHuK9t8mONAizNiHQjPOigvsFX08UKMtmwbcDV9l8ZpcLYmTALibJ3JDMn-gw
Message-ID: <CAK-6q+grCijHNfX5CchXmbp+AAzG7a+PStk76K-pU9CDGVoZiA@mail.gmail.com>
Subject: Re: [PATCH] dlm: validate node weights before building member array
To: Qing Ming <a0yami@mailbox.org>
Cc: David Teigland <teigland@redhat.com>, Steve Whitehouse <swhiteho@redhat.com>, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YAsQBHlkOSSjlcHkN18nZ6UZlBw5Y3BaNLToJfkIKRo_1790896030
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 10, 2026 at 4:07=E2=80=AFAM Qing Ming <a0yami@mailbox.org> wrot=
e:
>
> DLM node weights are parsed as signed integers and copied into the member
> list. make_member_array() uses their sum as the allocation count, but onl=
y
> positive weights contribute entries to the array. A negative weight can
> therefore reduce the allocation without reducing the number of writes.
>
> The issue was found through static analysis of the configfs input and
> member array construction. With two recovery members weighted -31 and 32,
> the sum is 1, so recovery allocates one int and then writes the positive
> member's node ID 32 times. A reproducer using dlm_controld and dlm_tool
> triggered the same report on a KASAN kernel:
>
>   BUG: KASAN: slab-out-of-bounds in dlm_recover_members [dlm]
>   Write of size 4 by task dlm_recoverd
>
>   Call Trace:
>    dlm_recover_members
>    dlm_recoverd
>    kthread
>    ret_from_fork
>
> Reject negative weights at the configfs input boundary. Also detect
> overflow when adding non-negative weights to the signed allocation count,
> and propagate array construction errors to the recovery path.
>
> Fixes: e7fd41792fc0 ("[DLM] The core of the DLM for GFS2/CLVM")
> Signed-off-by: Qing Ming <a0yami@mailbox.org>
> Assisted-by: Codex:gpt-5

Acked-by: Alexander Aring <aahringo@redhat.com>

- Alex


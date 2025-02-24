Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA5124C689
	for <gfs2@lists.linux.dev>; Mon, 24 Feb 2025 15:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740410843; cv=none; b=K40GnCA9gj1dbBYG2MRg934iDf8QvmYJDHOJ96+TecGKtavl3jM0ZTku+WoIl4QG79qXSvkiVe1FJv/AhyMoFMY2CBIMZskQ5EeRr5QnqvO0BfVCq4BPhApzZcJ8rRIBG3QUZCCed+kukgDH3smcklJBMp2vboTAxHcVjJnsWhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740410843; c=relaxed/simple;
	bh=0406XoOy5OWhrbkK9IDbrCOzsj+GWbkB8s+tRHBnkyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pkQhz4G6jYRmjPsD0PsN+Sh6biEz02y6bFhLIohMVZF4wP0K4V3/Yjnu6TcoLVaGzF4G6kMl2F018S4gqZAqpnin5CTXkogcP+gIEJIGsilTYP1w4QNlfYfnLIVE9ELAPtTNZNaGVWKG0m4Cv06ZT7px2SYerRmSbyg2FOyxxfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xd5NjeXn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xd5NjeXn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740410840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0406XoOy5OWhrbkK9IDbrCOzsj+GWbkB8s+tRHBnkyQ=;
	b=Xd5NjeXnZgAnGd6rI9oQ2/vk0SfmJBrEf5D5hotydhX1PlS3dcU/JYCBxqKnx5p9d8zvif
	TAV4UooSLB3A7RPzB5y6Hpr6Y4c0ycvY/ZjncrzhRMxnE0FpNPer7nkK/s5TMXb7soBB+G
	y0iZMMRC2Z4QWCHxilbCoRgXv4AYAjM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-a__x_yBCOZiAkhXeoVkeiA-1; Mon, 24 Feb 2025 10:27:19 -0500
X-MC-Unique: a__x_yBCOZiAkhXeoVkeiA-1
X-Mimecast-MFC-AGG-ID: a__x_yBCOZiAkhXeoVkeiA_1740410837
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-307bb84b5f3so26161641fa.3
        for <gfs2@lists.linux.dev>; Mon, 24 Feb 2025 07:27:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740410837; x=1741015637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0406XoOy5OWhrbkK9IDbrCOzsj+GWbkB8s+tRHBnkyQ=;
        b=v8J7CUBvA08tFa3HxdBk2kbQalc15cR4XNuBeel1D+V/hjRVIv5Il5SIAZCI/P7erO
         CLvbXLpW3LFJLO8+aQVbIreSI0LhSfCw3Q9W1NwEisqq7Hk+f9UBcYqISmQ0jvTkXndP
         S9NDNxn1VRG/6XAXcMUOJyI8ZnzPcWj5Q4kfPXqVgMc5wFjl5j6BT8QbdsP0vErAhdH3
         ZIT/liYiRGJ0TvEZjeuxYGs+TZXUzOeA73zCAknP3rCtVrDV3HHro+T2LA6gYJClLiYB
         m+nnVgctB8cX0OMHbRMPVdeNGx97daTnENVNC0MRzF7afYXzJa0gYwYdsRBQitXeN2JN
         JAFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2CxbCk8j10fiEMYAqYvktUkX9L/FbbrkMiD0e6MFwKDc63Q93QpY2k19+oGUUIL/8Paxr@lists.linux.dev
X-Gm-Message-State: AOJu0YzaKbX0Lv4v0K4TDgYm1fniGHB0H7UStRfW3CiaiJZgw+IX1ru2
	uYywoyL7bAW4T1ekJXIuofLWrEOvUBw2ptXy1dfqHpXCj+WLFYY2FxxmvCU6ED4+bYm5vt1T31i
	qzAS7/6JTiP8DtgPJ4u+5HvjtV61c7bapQp9YsfcOkmh5zLjGUJolRS+4UNKc93XkKL+w5NZn54
	IkGl3+QqmyF8u/VhRaw2rFRIg4gg==
X-Gm-Gg: ASbGnctaZSvUecAVUAXko6T3PDTc2weRn3ASfm6Ait7vhl0XMSoCAzxEfYTlQQCA0G6
	CUycFerpLxbNefL7nh6ZPoeqiXgJ2Ki9m+vJmfU7X9mRusL0s7DTHa/EQNs+aY4whYgn7p8uKZz
	48S5FwoE8GRtq6CjuV6Lq18ES0D/1CVCQ=
X-Received: by 2002:a05:651c:2109:b0:302:264e:29ec with SMTP id 38308e7fff4ca-30a59890086mr54978811fa.11.1740410837434;
        Mon, 24 Feb 2025 07:27:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHp1vwlUPoNHoVgb6Iil48nkNS/t2vsMr6RmZEewLSoR8ZuJ1j9JEJIULRuXI5hmbZTsI8JFZbMr6KR6k2CNtE=
X-Received: by 2002:a05:651c:2109:b0:302:264e:29ec with SMTP id
 38308e7fff4ca-30a59890086mr54978671fa.11.1740410837051; Mon, 24 Feb 2025
 07:27:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250221150937.21642-1-heming.zhao@suse.com>
In-Reply-To: <20250221150937.21642-1-heming.zhao@suse.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 24 Feb 2025 10:27:04 -0500
X-Gm-Features: AWEUYZkbnS6aNjMlaRtIIqsc7kSfi8BIc-mk2wYsjT0rRJZinDLHsATqEvpsAPg
Message-ID: <CAK-6q+iiMqW9eknqgVZiKjeUgSEAkL61Q-EbP8xwy_bayjS=fA@mail.gmail.com>
Subject: Re: [PATCH] dlm_controld: Support for extended value of kernel DLM_MAX_ADDR_COUNT
To: Heming Zhao <heming.zhao@suse.com>
Cc: teigland@redhat.com, ccaulfie@redhat.com, jfriesse@redhat.com, 
	nicholas.yang@suse.com, glass.su@suse.com, gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: K7mUewbKFB791AzM4oS6RkjXczcA4KKcejJ6Ox5gh28_1740410837
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 21, 2025 at 10:11=E2=80=AFAM Heming Zhao <heming.zhao@suse.com>=
 wrote:
>
> This patch should work with the updated kernel dlm module, because
> the code changes need to be aligned with the DLM_MAX_ADDR_COUNT value.
>
> Another notice is that with the current dlm_controld code, users
> should explicitly add 'protocol=3Dsctp' to the dlm.conf in a corosync
> 3.x env.
>

I applied this patch to dlm upstream repo [0].

Thanks.

What are we doing with the detect_protocol() change? You want to
submit the current version again? I would like to test it with
corosync 2 vs 3 with no configuration changes on an upgrade (if this
is even possible).

- Alex

[0] https://pagure.io/dlm/tree/main


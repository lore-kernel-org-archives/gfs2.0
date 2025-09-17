Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DD1246BAA
	for <gfs2@lists.linux.dev>; Wed, 17 Sep 2025 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758105253; cv=none; b=T2nOtczyyxvnQASJd2Cj6xoPSKOtXo9SdeQL1WWLrl6Mo1b2agtc3oGcfr0u6esAl79KdbfE0IvJEkVz2+yx9k8HMtLcC92ScLuriLE3wORmfmYsGKFSBFSTTdCxAywhcqeOxyHWphz6nvbw6qnf/752qi+lBwSMcjJYKxjZ4rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758105253; c=relaxed/simple;
	bh=1cBxv1xbY8Fpy8oQcvISFXu2Gvy5Sux1+zhD/ZCpP5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIwh8Ug+qsNFLgkaPAy1V2iqW1wsoWV80/oj+skgG9WasUIIUGeV4IxGKTmGI5+skM/EqqfbhRtTz/GefNE9byn8jlCkiDCNhHw0N4qRrY8+wH3DG/ufbbKf/PLz9t7XFnfjkw+8mY+KqiuWQfOcQItKt+dOm35CRikvE80L5Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=diiuz67A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="diiuz67A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758105250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1cBxv1xbY8Fpy8oQcvISFXu2Gvy5Sux1+zhD/ZCpP5Q=;
	b=diiuz67A3GAhUt1E2g79iZE8lvTIdYx7A1I6OA4JVsiobHXvIsxzu/YLDK3niOc0YfBOtR
	FfuU7wb1L18YEDVerkoeCMhz5es6hwbp5ahq1nwQyA4z5l1iSnGeiz8T7gxJV/vtkhQaGj
	6iS0E7dpB8a9YqhPdbZqu4+/nPwgtGc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-M0VHAbazN0eiM95xLxIM2g-1; Wed, 17 Sep 2025 06:34:09 -0400
X-MC-Unique: M0VHAbazN0eiM95xLxIM2g-1
X-Mimecast-MFC-AGG-ID: M0VHAbazN0eiM95xLxIM2g_1758105248
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2681642efd9so4436975ad.2
        for <gfs2@lists.linux.dev>; Wed, 17 Sep 2025 03:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758105248; x=1758710048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cBxv1xbY8Fpy8oQcvISFXu2Gvy5Sux1+zhD/ZCpP5Q=;
        b=fx0scnpilI0B1Y1n9o0RSt8ubhxrzxQC5UhzXBtlcUg6r7uv59He+mucJ+69ZbfViZ
         YMxOaLgvIzJfjjb8GtOZyl2oqJM0YvAJBOuZjyE9cbzuvqb08kDB3P5VypTri4/yc1xk
         qxUoe+lpzevNLRAFgZnsgG7aHQ5u77SGI5s+1blfka7a7t5GDOKUqjhRVJhyQ8ErQXQ9
         ScR8OlLHGyZiVISVNPr/8zaU2QNznJNzRKoDyqYhR7mmyZILGU4ZaCNZ32wFr1KMF9ZJ
         GROyqvAZGk9pLFwCjt7x7/su1FNCp+hLEe/K+OxaQpigQZWNHNBc/tTwcpVxm1t0V7j8
         sCIw==
X-Gm-Message-State: AOJu0YxuWwfq1FeNYoSzMVEXJdCJhY1vFLipNyQmNRMqZ3nTmOHTe2w7
	h9iffsc5y2i5tc/1K2rgGHGzDwnf3n4wiAO3o31gKe3STqLFWDUV2VyvR4eJeId3jnRZYvkwcSm
	6PdBbMX28EdGx2/S9FFVDNdLVLLuLavJmeQ8X+xqtBzlEPj8Zrw3EBVqCo98TnRv8KxnG6hqKon
	pwU4NaNX/Qs7JiKObeCECxYSaZWG1HPQ==
X-Gm-Gg: ASbGnctV1Ou0MNgvNvhDv+iryIJH4DylLiWqBYs0yevEX/1BFuczRZYmaUfOS0eWihV
	xtc123bxPkS6k1LuKBZM/Y5Ch5mgPzYjAu9ojUzLMQfkjwSnRxuPPFDHsBPCd0lmEe0po3RUiYz
	K2vhji26xCJAlg49RyzPk=
X-Received: by 2002:a17:902:c408:b0:246:76ed:e25d with SMTP id d9443c01a7336-26813bf0c6bmr21731705ad.50.1758105248318;
        Wed, 17 Sep 2025 03:34:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2YzbN/E+UopYldHCixM+VVbcJJcmpQWL8AhaVK43uVZhoyGaM4rEdKN7JZb5lpF619POQOSbhM/3uAXXs2eU=
X-Received: by 2002:a17:902:c408:b0:246:76ed:e25d with SMTP id
 d9443c01a7336-26813bf0c6bmr21731485ad.50.1758105247999; Wed, 17 Sep 2025
 03:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250916211108.1243390-1-kriish.sharma2006@gmail.com>
In-Reply-To: <20250916211108.1243390-1-kriish.sharma2006@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 17 Sep 2025 12:33:56 +0200
X-Gm-Features: AS18NWD1T2FGHwQjVZMQL6NQNbpFLaeIpEjOA39LSJoQzn1UTtglxZVkhl6gbdQ
Message-ID: <CAHc6FU5qWAY=aUjZ+YwwjteWCanNYFZW_xpDbWHkJV99qo=W=g@mail.gmail.com>
Subject: Re: [PATCH] gfs2: avoid %pS in pr_err() fallback to prevent vsnprintf crash
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+fa7122891ab9e0bbc6a7@syzkaller.appspotmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DZNVLVcb14Ge7Fi9h2V4ZFEa63VxusaWKI2OQ041e8k_1758105248
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 11:12=E2=80=AFPM Kriish Sharma
<kriish.sharma2006@gmail.com> wrote:
> While debugging a syzbot report, I found that the %pS format in
> dump_holder() can trigger a crash when we end up in the pr_err()
> fallback path. This happens because %pS goes through symbol resolution
> inside vsnprintf, and in this case that isn=E2=80=99t always safe.

I'm unconvinced -- when and why is %pS not safe to use?

Thanks,
Andreas


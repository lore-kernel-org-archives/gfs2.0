Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E966A1E534
	for <gfs2@lists.linux.dev>; Thu,  9 Nov 2023 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uqq7MyMv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699539327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fz+SNSpXICiEI4BudbkKcKa+vdAT+04uMSQsV3j4UVQ=;
	b=Uqq7MyMvwLXgk5+JlF/e25D3w5ndYHm+5M/Zfpyb5xLhcm2UI8c3/N73ySqHeobbmOfUbK
	frKkQZh6Nti7qem7gGG7Om0g1XS69aSrRvQ/a74KZz2qbM0P1f4dtW8ZWuqglzLnN6igNf
	AM4+7cJ5tl1dxixsfNfplBGL9C9tc6k=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-G2neigXnNPe7FIMBpXifrg-1; Thu, 09 Nov 2023 09:15:26 -0500
X-MC-Unique: G2neigXnNPe7FIMBpXifrg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9e15f05c3ceso75682366b.3
        for <gfs2@lists.linux.dev>; Thu, 09 Nov 2023 06:15:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699539325; x=1700144125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fz+SNSpXICiEI4BudbkKcKa+vdAT+04uMSQsV3j4UVQ=;
        b=WkzuFZtJrwCc7/cNan0eVp5FoCnYUMBvHP7fC3rBY+hJt2WpPW7YJVGMWJ+DaDmQAY
         Pdl6NQzuTcOI1AfhSN5935mpUVKn3ZrFhXRH+bPy75ocvtS/Ny6a3ewux1yoRTXtgiWn
         kKhk9RzqOHpAeMYSh+N3cfWrpqfpVeM78qgMoG7PP0mtzeAthWiNrBLkiT27Hh297aNr
         XNaCn9LlyBoduLoQjJc6nTa3qpof931jCYlwIQ50jtuBz10ARwPkro7J5SRLNhAPhIMC
         HM7Pnhaupr2ywMwa3tGA+U9o9vemsk9Cq709KH/BSKg7K2fYUttkF+nOUmYqU6PhJJ75
         zpYA==
X-Gm-Message-State: AOJu0YxBHR+YJz5wUF39je0l5dmEpUb5CRdqMXwIm84MiDLrbVvsKYFJ
	K4FiOCdu2BwKSs7sOciS/dWQASjd0odu42OyrRz8UHC2lXDyIUUrWVyXWJAMxMikMklN1/m27xn
	mBYHp1QjWaSeGOZlh5WrjAQmawF3QHw==
X-Received: by 2002:a17:907:3d8b:b0:9bd:a7a5:3a5a with SMTP id he11-20020a1709073d8b00b009bda7a53a5amr3010844ejc.36.1699539325634;
        Thu, 09 Nov 2023 06:15:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJ6CkZqOvFWs9H+4kk5luYoXo17JBC8Pp80UIeV+XCzpH+qqNv1UJIq5Vpne80vBo1x34QbqoaP+TljRJakaU=
X-Received: by 2002:a17:907:3d8b:b0:9bd:a7a5:3a5a with SMTP id
 he11-20020a1709073d8b00b009bda7a53a5amr3010822ejc.36.1699539325368; Thu, 09
 Nov 2023 06:15:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231106191138.3179599-1-aahringo@redhat.com> <ZUyDvv0na03qnSH+@infradead.org>
In-Reply-To: <ZUyDvv0na03qnSH+@infradead.org>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 9 Nov 2023 09:15:13 -0500
Message-ID: <CAK-6q+jK7L=Vg6UAr=_vKbywBpQTMcor_1cU75tjx0tT2qNndQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] refcount: move kdoc to header definition
To: Christoph Hellwig <hch@infradead.org>
Cc: peterz@infradead.org, will@kernel.org, gfs2@lists.linux.dev, 
	boqun.feng@gmail.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 9, 2023 at 2:10=E2=80=AFAM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Mon, Nov 06, 2023 at 02:11:36PM -0500, Alexander Aring wrote:
> > This patch moves the kdoc for refcount_dec_and_lock functionality to
> > it's header prototype declarations.
>
> That's not how kerneldoc works.  The comments should be next to the
> implementation.
>

ok, saved for next time. Thanks.

I will drop this patch.

- Alex


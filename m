Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A8B1F7554
	for <gfs2@lists.linux.dev>; Tue, 29 Jul 2025 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753794754; cv=none; b=awhAwAQFxqAaeKjTrTjxSifluLQyCm702jI3YOIdQZxF75sKe+EaGhkD+Ru/puXnmtE9GhOtm8HtAndBTCT6MXoPC320Awp+pMVd/uVCiaH/JB9zo1FcFx+2NeM1sXg1yztKnbLYO8Ks76Ns3Z76Q3jSTYv3nkGic1EDFOu6BvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753794754; c=relaxed/simple;
	bh=yGktK75e2PayS3m6dLJKhN+QyBnGs9rTpFNh5Uw1tH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L1k3Z4Do6/j0RqluDWJl/PzJ0HoGWw0AveFfcpyb8NH1qOv8R8Kpdxg8H4EDgjwWrljOIYjYcEgJ1KWVXC0ynd0fF3TwTH4bQG5zdsgiNutgsqHSz71Zh5lkB/VQ3TFBO9+0sH5pjAOU5Tg8bIjUMEKcUWmQwqEDvvTaMHYrxnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XE7qB4jH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XE7qB4jH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753794751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yGktK75e2PayS3m6dLJKhN+QyBnGs9rTpFNh5Uw1tH4=;
	b=XE7qB4jHrLlga2CFLQUStx8Gbhy74hlcLXlPpiRfK/5XGr71wuy2LPkibzqeQgnBAkU/HM
	RapGPx77Q9rY1K/BvA7cpoTKqq1gT7+RG+VDceo8sCvTkVto12aTXd5cXlUQ9JQrixibCI
	xS9rswX1mQ9nMLLlTT18nsEDVu4J8Tg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-7gKI1ilwOrGJ-EAjiN3nzg-1; Tue, 29 Jul 2025 09:12:29 -0400
X-MC-Unique: 7gKI1ilwOrGJ-EAjiN3nzg-1
X-Mimecast-MFC-AGG-ID: 7gKI1ilwOrGJ-EAjiN3nzg_1753794749
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2403c86ff97so23690815ad.1
        for <gfs2@lists.linux.dev>; Tue, 29 Jul 2025 06:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753794749; x=1754399549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGktK75e2PayS3m6dLJKhN+QyBnGs9rTpFNh5Uw1tH4=;
        b=Tkd642m9zPaVrLT6RH5HIrURs3C8U0DcJkJhnVD7T7MQSY9XNGG/hU2ZDeZLj6dLSt
         R+maSp5Frk2eXCiZi1hFtc9aJniljq4pVKliI4pXk5ncsMdamzhcAUpMNDx3LjgIOoPu
         k14m/7hZd8LLLPfvbOmU4xbMzEULizo347Wp8xRjyYGlNTBm338NuOwt9Avaeiiasxzb
         Z/yWDCj2pLXd760SBDo6+eQa5zGzIhi/AOdwlN1kswZsEqYilV8zn69XLtsvxuIkAH8O
         71dL2XgF9whsqo2wtXRT28y9BGQOEYYwhRI9TXv7Ve0PhsJgZxEdDhB32enQNK6klq6O
         nHtw==
X-Gm-Message-State: AOJu0YzPabIpqrgpCmjGd3tzIcgfHVTTBvSEOZo+AvFiIDGdXpUicVhi
	qdO7ciET3Xtl/V2dzljFQh2+9uKu6GHb+b58evPRpFz9LSxknQcimzwFs+ByzA4tev+ZntJfLk0
	8PBvS2DIXw8CfTmPj04Q0gdm57PJ16eCq86yNVDA4EfamTaErC+ajXfSjXHDOZ2hNOdO4KDsyjN
	HYj9v32695UCv3s0xMGdIxTDaKtbWNbg==
X-Gm-Gg: ASbGncufkhRMHZ0wFtXVQhZh4jWiLvMfVh4Ydxm9lLaZb7R+Tao+Jwi06i9IgxpW4zD
	iZ962a2/KcGLDSNX+yUUzugeOei1b+b2oLYQDCAykbZbipVNsajwj/suoa3ieH7npQmWxYFjGQx
	NquiPonN8zTalHgys/lv8=
X-Received: by 2002:a17:903:320a:b0:23d:d2d2:b511 with SMTP id d9443c01a7336-23fb30cb6c3mr225672305ad.19.1753794748593;
        Tue, 29 Jul 2025 06:12:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1psn3OcEesGJHe+B3xilmqfbqkCCVe1Iwh6GM5j1+Rv5K7pbahMYXP+auHAPPU4oiuTDereeklBYW5LyOIuI=
X-Received: by 2002:a17:903:320a:b0:23d:d2d2:b511 with SMTP id
 d9443c01a7336-23fb30cb6c3mr225671825ad.19.1753794748111; Tue, 29 Jul 2025
 06:12:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250729113638.1925201-1-colin.i.king@gmail.com>
In-Reply-To: <20250729113638.1925201-1-colin.i.king@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 29 Jul 2025 15:12:16 +0200
X-Gm-Features: Ac12FXzgLBMRVsOJXcgqlJnJHj6Of1bbYEOVyc2J0oa2XadRWV0FlbBU2KJNSYU
Message-ID: <CAHc6FU5eD+ROzxpe1tjP99EthOWKBrd8hWToPj5mPurki2JyZg@mail.gmail.com>
Subject: Re: [PATCH][next] gfs2: Remove space before newline
To: Colin Ian King <colin.i.king@gmail.com>
Cc: gfs2@lists.linux.dev, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IJ9xos7yqKS9dDx3DeKXtLNej2XnbeY1fuTqOJEz78U_1753794749
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 1:37=E2=80=AFPM Colin Ian King <colin.i.king@gmail.=
com> wrote:
> There is an extraneous space before a newline in a fs_err message.
> Remove it

Thanks.

Andreas


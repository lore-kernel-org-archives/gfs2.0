Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB451E0B86
	for <gfs2@lists.linux.dev>; Wed, 29 Jan 2025 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738171196; cv=none; b=TXVazOKCY+VUAyDCA8lf5XI/Mzm0tJBrHXBowJ6kudMpfelDVcoghcGram7R/5t4ZfCnbAgbgbQBPc9u3VBo+4XkCGaf8/C8J6iHm5rXc2cLCFC1sRMDANjaHgEpVixBZidItiv3iulMWq2hh8gVE8A7bdjCExcMfk0Lh4hIGTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738171196; c=relaxed/simple;
	bh=3iaxX73XD6lAe5qkay4u9FZLV/j1SD0tFzq+pKK1qKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yg1dyCbyF9NG9sYwaU+8lh0VKGxxnj3147PBpLXHXdAqlN30edN9sQgzE/ciVx7B7tcf5T+9Fq3bjvQ++pLOhgh9BSzjtD4b3to9enisH5Jfuoiu62Ei9qAnlcOVlTvX23xmj1JReFt3FRChIyTxYp6qa2zFqUUfxk9SecaKZ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=efwH6yIQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="efwH6yIQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738171193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3iaxX73XD6lAe5qkay4u9FZLV/j1SD0tFzq+pKK1qKk=;
	b=efwH6yIQ01B7OH+Pji7+DhzjEpl7/6Q5t777007qO73lUgCPgtwnY3HsQerPg/IoMO9bK6
	hSYrFXjUhTIuAbEuEb+LCWNHPJ73JucyjGGS5WkfLnHSWq7e/tcdT7MN8G6nNShH5g6s4w
	tQfyHxKYJ6AdWmxvcTIxz852Wq5cbz0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-QTggjn-ePBi3dMxbHd3Xww-1; Wed, 29 Jan 2025 12:19:52 -0500
X-MC-Unique: QTggjn-ePBi3dMxbHd3Xww-1
X-Mimecast-MFC-AGG-ID: QTggjn-ePBi3dMxbHd3Xww
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-21655569152so144065835ad.2
        for <gfs2@lists.linux.dev>; Wed, 29 Jan 2025 09:19:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738171191; x=1738775991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3iaxX73XD6lAe5qkay4u9FZLV/j1SD0tFzq+pKK1qKk=;
        b=NzWY3MEuhHgasVgwyq2QHOXAO6bw0CPxCQjoW8MiAqWK8eQag483Aqx9X30Nm3QxEv
         +q+jhwBE4fgTW7YHpPNHYGS1B3DhRtkJKnwWtQiQpzYr9NG+2bvMj+EBmF/mtf0NlFpK
         1lkGRwzS11fDVo9+Ht5zBR++zDERPWL6YvwesR64ibR3d8Mykv9t5k25RLz0s/BNwkqV
         KUEBXambMINOhVL2ozGOopz9anWxOnybLBxYYySypCI946k+4FO+SFi2DrRcBuEGnx2P
         8qBwVIZsTdaCo401V1KOorAkiEI6q26lucUXI1BFnJF4iH9tM3NJlcCt5pVXkOTcvgtJ
         1UEA==
X-Forwarded-Encrypted: i=1; AJvYcCXxdXWrKpJBnMAFGuDpXgXcYmfysigAcp5QdMdGEkLvRDIGTeFcWxgVLLiM954aKUtzgqyB@lists.linux.dev
X-Gm-Message-State: AOJu0YzWNG+uRAnd83nPTxb6LT5oVbN8jOgxnnDiAXEbrMrq1tHVIXvV
	gdgItah5/s4ejLRaNy2Dom4nM28o1xL1hnuLTnyaGYxw9DfVJx5PBefObQ1zfXK8Tqbx/0deyE3
	JjIIlZzCI1UQ+kIJJpbufrEqeL1eYu1/aHK402Sx4IKD93OHH4zjOGMPjR08sDevPdwGlp+P3AI
	raz3YAPlyMsATwADvb732XSQRlhQ==
X-Gm-Gg: ASbGncsEmOJF4ua9xcB2a63jzddnybHFv8VxF2i9WlbztdeC7sEiTx/WpDbIA212HZY
	L+bb6RVEwbtrbQt4mlh6hToC5frT6jwB+CPRqKMFoxIZvpIdbGwPjg2BJ0+KS
X-Received: by 2002:a17:903:2343:b0:216:1ad4:d8fd with SMTP id d9443c01a7336-21dd7c4994amr48816455ad.8.1738171191603;
        Wed, 29 Jan 2025 09:19:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfABnFfbgeBzDXWCj85MsPaV0ByB2T2rXUb7QjeIORDiHfVnWfBRCYeARi2+5kL4J3zYcmv97e5BnDL5BYRu8=
X-Received: by 2002:a17:903:2343:b0:216:1ad4:d8fd with SMTP id
 d9443c01a7336-21dd7c4994amr48816125ad.8.1738171191101; Wed, 29 Jan 2025
 09:19:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250129143353.1892423-1-agruenba@redhat.com> <20250129143353.1892423-4-agruenba@redhat.com>
 <20250129154413.GD7369@lst.de>
In-Reply-To: <20250129154413.GD7369@lst.de>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 29 Jan 2025 18:19:39 +0100
X-Gm-Features: AWEUYZk_2Z3s2dY_kkWVLcQgmXKJk2VDezt4d-YIgTtz0UQr4V5Xf2wIXyjUrQM
Message-ID: <CAHc6FU47ToGhxxO1MzcdyL=Mcqrf-E+Wh3dwMiuL365pXSfKsg@mail.gmail.com>
Subject: Re: [PATCH 3/3] lockref: remove count argument of lockref_init
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ty41kCOIavFyxriZDr-B4su_nWCVdXAX-dN8_lEiY40_1738171192
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 4:44=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
> Maybe the lockref_init kerneldoc now needs to say that it's initialized
> to a hold count of 1?

I always feel a bit guilty when adding a comment like "Initializes
@lockref->count to 1" and five lines further down in the code, it says
'lockref->count =3D 1'. But okay.

> Otherwise looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>

Thanks,
Andreas


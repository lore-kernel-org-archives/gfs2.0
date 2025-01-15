Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6842416AD
	for <gfs2@lists.linux.dev>; Wed, 15 Jan 2025 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736947734; cv=none; b=j4WigtMxDRpgfgrpncQNmyu7ZgobTgmUIeeh6v/U9YK9raZhrpOFFDXE84fN7MRSVdKlXPUUM+jAnbpUvL+7Pp22xrw+V8AXFohTrpg0wPrY8jBo4EOqGCYioVn452WfFsb+6u4ZQb1lIDKJzJDO+fd9P4txoslppkHqXW1rb2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736947734; c=relaxed/simple;
	bh=dRBtdBIsIBp/bcoo8ZihGHj8zYl9funD16dxlAiO2mA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aOg1D8nKpoxfNZyHkNLCf/pl31iMCcX9eDJl9etSwBbgrrGmAhWWtv4b/2mlzHJ6PVj4nL8EKMTCC0lrxl59M4G0aVaeQHql/TonxG4sXC3tNQgk5nTJVEhf9gtDgjmbn2JU+OwE1eX0sPEHBJ81lf8iMlPyJ+9ru7clYl9Y34k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GNLboc/M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNLboc/M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736947730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nf/bRI9F8H3DG5UlQJaQACm8ygcBNuxPnrAMW4hnfts=;
	b=GNLboc/MJh2lgPpW8vJ6UJ5QzQA0ds6PmQblZ1WPE42pdQgFZyplxeVgFcSfYBBAJGNTxV
	37NzajXjsVTWnBnUNs5N93bBTJfwqg1kjpd6eJ3knl6VmuXZY0T8RtD/JFgvFI6CUluyw8
	vNrq/Le7rKWHtKLCMVgTl92mO2duIp8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-deNCebygP1mXbDVsULPeIA-1; Wed, 15 Jan 2025 08:28:49 -0500
X-MC-Unique: deNCebygP1mXbDVsULPeIA-1
X-Mimecast-MFC-AGG-ID: deNCebygP1mXbDVsULPeIA
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2178115051dso123135195ad.1
        for <gfs2@lists.linux.dev>; Wed, 15 Jan 2025 05:28:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736947728; x=1737552528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nf/bRI9F8H3DG5UlQJaQACm8ygcBNuxPnrAMW4hnfts=;
        b=bxfDFa4JN15djEkL5Z4t3qtibgx900JUt1vv4k166Hm0SOnrwtk7FD+AyRveGactaw
         FDrqz8+rFDZt4Oo94tlWzbT6Q8A1rBmidb9tn6W4mDRf9mFL2yp+3Mmd2296d23mHsMt
         tHI98r9ctkW9GNHVYCV3ZY82dmj4JZ+1xdI/3eazQdTw+ojSpxHD22+ApB47fFzDi5O8
         nsSKRVq2Bf3+Tm8CKt0WCuUQSXrx98FUJ27dOE+mA4KYYHhdtP5yGj02/5ij5szCGs5l
         lvT9Hm9e49c4M2fThs/GP5QQbNakdAPcplffXvBo+/DETQuC4y9djLnqXLNiDLQV1teC
         nrGw==
X-Forwarded-Encrypted: i=1; AJvYcCU3uD886yViOE3P/dvOQHyjThZoEtPpp34Mr3yoj5O4kR7mwF56yeM7J3+01M/4g0P6+AUK@lists.linux.dev
X-Gm-Message-State: AOJu0YwplAZcs3LqgIyzsDdLWzU2tpCmvES0qWLL3joedj1aqY/OwJA1
	HFprxJkNDAUl8wDdJnD8PY4KX5PqAh4axGOcG6ZsTKs1WRzERQFesHesOyDNbQgdvvN8sg0n8F9
	Bt94rq9hedBDogHts9SNdllJlxsDtjq3WAdyhnPLD0RbQQNleoIwG3kwaKQnRyRMEz+iNFubfRp
	Xl07IeISi/P8Hlhtvg11e+yXJFwA==
X-Gm-Gg: ASbGncunksxOQlIZI1+OJlEGGMI3tmHG7L0jSzPpS/79raSHG7Io8bJY09GrvK6MoAg
	MhZOE0b752Rx6l1bD6n569GuenneoufRPOXwF
X-Received: by 2002:a17:902:ea07:b0:217:9172:2ce1 with SMTP id d9443c01a7336-21a83f5db69mr480494745ad.22.1736947728090;
        Wed, 15 Jan 2025 05:28:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWkCFLrwayc2dPGspndw+hcfEp3QAcYd/bnIVRKhsGboPR86dXo/zwFq2qs4H+jDeTVaXTl/HFSSI3mVDNd2I=
X-Received: by 2002:a17:902:ea07:b0:217:9172:2ce1 with SMTP id
 d9443c01a7336-21a83f5db69mr480494425ad.22.1736947727803; Wed, 15 Jan 2025
 05:28:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250115094702.504610-1-hch@lst.de> <20250115094702.504610-3-hch@lst.de>
In-Reply-To: <20250115094702.504610-3-hch@lst.de>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 15 Jan 2025 14:28:36 +0100
X-Gm-Features: AbW1kvY2TM4e6V0AysHtF1TdOa092YXLOMhimyjIhR1wLmk0-daNjTVYF4PhKBw
Message-ID: <CAHc6FU6OyLot1pA1dH_wd10YyVzXfOEcqa+LKFghuTpfePDEpw@mail.gmail.com>
Subject: Re: [PATCH 2/8] lockref: improve the lockref_get_not_zero description
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-erofs@lists.ozlabs.org, gfs2 <gfs2@lists.linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: scl23ftmTlIb3meKyPU6NxL3dZfLBZ4bm4jIq4tzS3U_1736947728
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 10:56=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
> lockref_put_return returns exactly -1 and not "an error" when the lockref
> is dead or locked.

The function name in the subject needs fixing.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  lib/lockref.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/lockref.c b/lib/lockref.c
> index a68192c979b3..b1b042a9a6c8 100644
> --- a/lib/lockref.c
> +++ b/lib/lockref.c
> @@ -86,7 +86,7 @@ EXPORT_SYMBOL(lockref_get_not_zero);
>   * @lockref: pointer to lockref structure
>   *
>   * Decrement the reference count and return the new value.
> - * If the lockref was dead or locked, return an error.
> + * If the lockref was dead or locked, return -1.
>   */
>  int lockref_put_return(struct lockref *lockref)
>  {
> --
> 2.45.2

Thanks,
Andreas


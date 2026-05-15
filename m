Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C192C13C9C4
	for <gfs2@lists.linux.dev>; Fri, 15 May 2026 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778851857; cv=none; b=V2EdsiXs3UU6Jy5Bmr7YwlufqU4siMQXWoV6/5mOhB+W5zchWKiqigqzBHhyFrZ5NfIfUsWsDT5vUvXLibNVCy0T82SKYwAt7wxZQDzuCJNRiEcRAUxmery5zoo88zCdhqECdYVRlVHos0T4a4nUdtr+sWGED+WMDJIjyjSImYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778851857; c=relaxed/simple;
	bh=s/oaZh6mCieXjM/oe+Uo6m/nnZF0CI9mxTcXhDEwPPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VAciI9n4LZtYS43aX9y49VHnB9QzhZ5FfKUYngNgoObey15W5Bx8PW5ArIbjI1ztcUbc1yCeEVysvlenIZAcdR96wIHH4iyNhU9IgMS1KzzW+OnAfjaGTRotgvP9Po1giAEYrtABeg/SUzKIjmNfFUSICZbDzfifElj9nmD4uVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OeOANg8n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OeOANg8n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778851854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s/oaZh6mCieXjM/oe+Uo6m/nnZF0CI9mxTcXhDEwPPA=;
	b=OeOANg8nszmgh7asplQRN8RyPvikPOAcmXEdtyiAWC7IzfGZ9lWw7rbzuosvlrsBUKA/5D
	+SsotH4Bk5mCnPOxj4N3r8jkLSuxzj3L4sWYRMWTePF8eUDh6gpI+/fjDc50HWiqiT8Jo0
	x0gGPYYs9TUD/q3GLmp32PE/K0kTtr4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-o5upupjjP0K2RHU5J7G8uw-1; Fri, 15 May 2026 09:30:51 -0400
X-MC-Unique: o5upupjjP0K2RHU5J7G8uw-1
X-Mimecast-MFC-AGG-ID: o5upupjjP0K2RHU5J7G8uw_1778851850
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-3954be32d30so7120971fa.1
        for <gfs2@lists.linux.dev>; Fri, 15 May 2026 06:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778851850; x=1779456650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s/oaZh6mCieXjM/oe+Uo6m/nnZF0CI9mxTcXhDEwPPA=;
        b=iRZib3PypEGWdUU/1KeVAUPygYmw8zjEMbZ43K8WsoxNHpaMyw5hEOv19sfft1GRZY
         nLMr85vHhtS6FhtkKZCNuJtiWWGmzUt8zpd12ojLD+RYwdq8lAWuPR/BFv/XBXF1LvcU
         jpsJ+51BmRm2rdD0zM/34krQQ82lcUGiDj0CiPFRscCVwl6UMj3tyjmpjFmUABNveyd/
         /UxiNiWVe7syUsDQk0C7iDGaTwoGNngVXwG6jobiUMlaxjZ12kBiaMzKh0fux2o0nT+v
         SWyHbX1jDubHay4OdtjX0vJIGCsrJ+WgFCY/BnLK9gJPIVtQmxDYHMpW+DnRaXjYxe+m
         iuUw==
X-Forwarded-Encrypted: i=1; AFNElJ+1W1eknPNX4KNGBCmPUVFkf4igul6+YCH/DNuTunS7NV8hDStkURAUxeLMdYzxiAV8pqyN@lists.linux.dev
X-Gm-Message-State: AOJu0YzOzNMoRu3o8pWTbIrzfepNV6d4Sbw8olW/954P6RIPK5O6OVtg
	X+Q4t7cGT8tdMJeR8gyRIaY1Z7EU5D85ilEVHNhl8RJ1mkornzqp5GjWlzej17z6e2tMIo+fTse
	QbUBPJXko9ceJWak6XmFvM+tFq1X1ShGNPSUtv2YBf+EAPkn2jy6lzofeCZ88/EvkLvu2MU7typ
	E5JjuvnVEt0Or0wSGNFOYj55cpmDdabQ==
X-Gm-Gg: Acq92OGi+nf9/6RiLcxgxnEtDSAhpXM+YHJZMz3jS7fDAsTCA9TGrdfHcY8QaCe8oXs
	IwTtYZWX3/J5ARhZatxk7z+cfUQlzRd9RU0e4SzjWoWam31X6zU/6/czpIYx6EWcYLFgIMj85aN
	GySTjJkPH3tUAyLHK181OIWHUQIf97g/O2RNELVrWd2KbnY4ZkpLQEkpmeiultn5jQOsRRYtqri
	ZbUneVbp+ibnqLiDfhKc9MXOhZs0Uu7aQXRMfaq
X-Received: by 2002:a05:651c:1503:b0:38c:6b7:ad39 with SMTP id 38308e7fff4ca-39561a2b235mr11862361fa.13.1778851849991;
        Fri, 15 May 2026 06:30:49 -0700 (PDT)
X-Received: by 2002:a05:651c:1503:b0:38c:6b7:ad39 with SMTP id
 38308e7fff4ca-39561a2b235mr11862191fa.13.1778851849565; Fri, 15 May 2026
 06:30:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260515073933.1978699-1-joseph.qi@linux.alibaba.com>
In-Reply-To: <20260515073933.1978699-1-joseph.qi@linux.alibaba.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 15 May 2026 09:30:37 -0400
X-Gm-Features: AVHnY4KDruL_KZ2Lc6m06bwwVtVPuK-O-1HMOL2mtbzVTxXVTeQZkMLZfFBeq48
Message-ID: <CAK-6q+iOFTdw0caweFQ7tw_amBHzW5xXM+H0_FicBAkHVz5OKA@mail.gmail.com>
Subject: Re: [PATCH] dlm: check negative length in dlm_search_rsb_tree
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: m-L4hP2mIqxbNipfHOMtESiP-nWgGcyVumcYIczT1dk_1778851850
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 15, 2026 at 3:39=E2=80=AFAM Joseph Qi <joseph.qi@linux.alibaba.=
com> wrote:
>
> commit 080e5563f878 only checks for len > DLM_RESNAME_MAXLEN, which does
> not catch negative values. While the input 'len' can be negative and a
> negative int passed to memcpy() is implicitly converted to a large
> size_t, causing a stack buffer overflow on the key[] array.
>
> Fix this by also rejecting len <=3D 0.

or change the parameter to unsigned?

- Alex


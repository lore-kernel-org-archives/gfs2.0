Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D6F238C08
	for <gfs2@lists.linux.dev>; Sat, 31 Jan 2026 01:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769822252; cv=none; b=Lg7MQEv+0GgwV4ChSVYjwLPbQ2VZ7U0AJkzxxpcpo2+UBABBKoTAqB2/5MbV3pxb/x7TUcQ402K+MKqBjcjqPbMdgBBKQnzKqmfuDy2PvzK46MkxAqGrDjLlpZmWpdyg0squeB0RFqogKmWRTpr42je3j2bj6qw1NY4YaLqQp1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769822252; c=relaxed/simple;
	bh=GWTRCN/AycRvbo4khjl5+VFeJJ9X1H7EUJUqhjiIGCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZ7bkS7amMx+we3H6cAqxVURGWwknO5MzPz0Iov4WRfz+tQP6qOuyWrmQIAtX9R7vME0sWPIJDr6zqz3NQoDguv06Ozj0ji94JvvYzfZ9nGYuSGzdUEiqEEgE6bz3PoPWeV4zInceI2UW86mxzCKhDwBr1wvvCnz/Ss2c9xWswM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WcsQinas; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WcsQinas"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769822250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GWTRCN/AycRvbo4khjl5+VFeJJ9X1H7EUJUqhjiIGCk=;
	b=WcsQinasmbFLsHNS0KP9nAYNYmiYYcskzw/7+H9l6BOvYH/AbP5IsECkvXYAqctUSwlDaY
	BT5wyizlpzDGvPKOPd3+8mTCPGtZvB+AjkpXW8FrbuInqLYTZFaz3cB1rKDp6Wj+GvYEVZ
	g9HOWMTheH4tDZb+2eNLQKmw0NzndwU=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-AarJaaM-PMSR-kxiOIwLKg-1; Fri, 30 Jan 2026 20:17:28 -0500
X-MC-Unique: AarJaaM-PMSR-kxiOIwLKg-1
X-Mimecast-MFC-AGG-ID: AarJaaM-PMSR-kxiOIwLKg_1769822247
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-385c81c2ab5so14335651fa.2
        for <gfs2@lists.linux.dev>; Fri, 30 Jan 2026 17:17:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769822247; x=1770427047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GWTRCN/AycRvbo4khjl5+VFeJJ9X1H7EUJUqhjiIGCk=;
        b=xCSvAdNFEAJ8QQ1V4vxeyqvHRa0sU2AoqDc2QpL+eVtUhNCZpqKnXUsIDY4eWy9tgr
         fw/ZPyu8yhzCDopdTlWBQDT3bJGUPbRh2eN/NRecHDB2aoZZUTEH/bVcQsmr5CNoMnXI
         Mj/fDqyeFVPGt/eyBz8DDz+yqFWAN/Efpw2IIld5WACxEpY8SL9cfbYacE0+LtwcKEQ5
         79JsVuVFnqtNDg+iA9G2K7mkzhZZ44F31pZr11thgd+eMLUswnCcdVZd7ygXxjVl1w8N
         KM0+1Jp2tK3pUqZf5NfWuWK20frcM6+sQQTDBBmOZZxh7Ft967BMnd6BQNrlGMyraN33
         brlA==
X-Forwarded-Encrypted: i=1; AJvYcCV2krrrkVebNrs9wqb3AU7DMWbxahaM6swksxcX0T+U4qGGRbGvOMzRX/Fhmg/ZVbM9j3GA@lists.linux.dev
X-Gm-Message-State: AOJu0YwbEPqnvRzgzTm0JflzOJuY6uL432QsjGhhTqxa4KJk58OMvKvk
	Ew/D6EExVmdnWO+nixfB8fjoCuPpnEK/QRgjU/yReapHR21/cn0OXtJefuB73Rlwcbt1dIXvaub
	rMMLmKmc3TsFELSERE9DHwG4qYaCJ8Ta/eILaQrfq5mKU8fyyGzP6L6JQIXFf83XOxS9FedvaDo
	83K+JafCfh4YyhgOoGaX7NapZhHo8MUQ==
X-Gm-Gg: AZuq6aKJvyDReDG7MOGepAWKsFTi9Q45pEtrbEP6mMooAx/JQ6wC2bUdHCW69S+N0ob
	ECjLlRdYKKGL6L73RfbbcKjW+s343zx/Vt39eBnkbRQO2SSLDL3Fz9z0r3vWLcngRysUn5wye43
	BCPEMLD7QjgPCuQmff9JoazCCsLPhxIcCoa6ho15K4G8FA/+F1/c/mzGhuK3FpwTJeoSAftUbz8
	RUisyrrR4rLqcoNellywx1i/LbX
X-Received: by 2002:a05:651c:1ac8:b0:383:1c18:adfd with SMTP id 38308e7fff4ca-386465246c9mr11816621fa.7.1769822247009;
        Fri, 30 Jan 2026 17:17:27 -0800 (PST)
X-Received: by 2002:a05:651c:1ac8:b0:383:1c18:adfd with SMTP id
 38308e7fff4ca-386465246c9mr11816531fa.7.1769822246613; Fri, 30 Jan 2026
 17:17:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <aNFbP3UaRokBxruI@kspp> <7d712992-e006-4787-95ee-e82cfa25f8ff@embeddedor.com>
In-Reply-To: <7d712992-e006-4787-95ee-e82cfa25f8ff@embeddedor.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 30 Jan 2026 20:17:15 -0500
X-Gm-Features: AZwV_QhMawgByiZ71sisK8DLL_VBMZnLRRD0cUo7moFtR891-SdiA88rULw1gIY
Message-ID: <CAK-6q+i0wNRRhhkBGNs6oP159vCfa40SjbrLPbQ_P1NXv2EmFg@mail.gmail.com>
Subject: Re: [PATCH][next] dlm: Avoid -Wflex-array-member-not-at-end warning
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, David Teigland <teigland@redhat.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1lybf3ZoIey8F-CsXfXbv_colcjDcH3vWFdraYUs5YE_1769822247
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 30, 2026 at 4:43=E2=80=AFPM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Hi all,
>
> Who can take this, please?
>

Sorry, I will take care that it will be queued up for the next dlm pull-req=
uest.
I just checked again if the flexible array member can be accessed
under the current conditions, but I don't see this can be ever the
case... otherwise we would access garbage.

Thanks.

> Thanks
> -Gustavo
>
> On 9/22/25 23:20, Gustavo A. R. Silva wrote:
> > -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> > getting ready to enable it, globally.
> >
> > Move the conflicting declaration to the end of the corresponding
> > structure. Notice that `struct dlm_message` is a flexible
> > structure, this is a structure that contains a flexible-array
> > member.
> >
> > Fix the following warning:
> >
> > fs/dlm/dlm_internal.h:609:33: warning: structure containing a flexible =
array member is not at the end of another structure [-Wflex-array-member-no=
t-at-end]
> >
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Acked-by: Alexander Aring <aahringo@redhat.com>

David Teigland can you please apply this patch to dlm/next so we don't
forget it.

Thanks

- Alex


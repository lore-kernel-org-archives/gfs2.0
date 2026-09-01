Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D4A483804
	for <gfs2@lists.linux.dev>; Tue,  1 Sep 2026 17:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282767; cv=none; b=jKW46e6EdV61HXDafYHWCFMwhygqopiwuW+H1k1TnRIrMsQbhhopyRt7Dzq5vfLw5+Jgyieciv2c1aQUUbPhiqKTf5zWJEWqulk66bmtW9D4yzU9/ISLsqZ4PBHdVHDWeN8sYVTc11I9YJzE/3iw/LUBRC9eCznqtnKnXce7od0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282767; c=relaxed/simple;
	bh=jYeLo1dyIKj3smCfjHTE1wfm6NWZSziLX1W9VVGcJ6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b87lX0HLlkEDhERtmLiktihUZxudvkdhHI2CBk3YmVGbr/bVh1PHgooccY6Xu/mbce8Ws1fBkn/DQiHlvXtpbSKuehpXddYJ9exzofO3STsr141sbh+awkz+VzrVmR+QOIc+eaFqkbeqhveIm65znx9717Wrwj4RG8rj0s4wLyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fwjPwKzw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwjPwKzw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788282765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jYeLo1dyIKj3smCfjHTE1wfm6NWZSziLX1W9VVGcJ6g=;
	b=fwjPwKzwwa3Qro4B98QGLxU/DgfCgcAyV6u1p4hl1Wm6iyJrVGWTJKJ3hmcIXWV5oSsi2A
	D7srf3eHLyD8loN/aPzQtAQLM2CnnPlIblxG/UKjKTiqw0H+zBmBqPDhf3l9lbOxXkhaNX
	QeG7Fl28DVa25wiHhrk2gRY7I5Fhhs4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-7XOT6HAePxaQr6tbumZk1A-1; Tue, 01 Sept 2026 13:12:44 -0400
X-MC-Unique: 7XOT6HAePxaQr6tbumZk1A-1
X-Mimecast-MFC-AGG-ID: 7XOT6HAePxaQr6tbumZk1A_1788282763
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-3a27721662eso192251fa.1
        for <gfs2@lists.linux.dev>; Tue, 01 Sep 2026 10:12:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788282762; x=1788887562;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jYeLo1dyIKj3smCfjHTE1wfm6NWZSziLX1W9VVGcJ6g=;
        b=blZjg8LEhtMWpEf7zSNgaE+aSpj2NJoIONZlbBzr+EWH1mEO9zHJGkYO+co/eIUm4O
         KStNP9Lip6ZwWxdXIVuO78znPg5ZXIEJSwXogflpcUez18mSL09JO0vm9qI/aIN/lYVB
         HIl4zTsDs4/v5Y/uO9X6xKo2CSEv020dtAYIDCE1+NAQOZOzSHhGdTSvg6rfTFJ27OIc
         hUOQmSAjVq/kx9OoFsTGF5C7QJ7uoR0lxIc/OG97YRyfXKfJB/Ur56Jvv+uNEYCUKDZd
         WaZu7SvPFir8P6Orb+gCczoxDBObhuBEsBcMMeAD7kJ+qSoi595xL0mLlLSXmTlrUJfp
         Rjpw==
X-Forwarded-Encrypted: i=1; AKwUvBwl0TOAPpvzQUXdc6hv4V2kW2UlqEVqUtPblI7ePfqwhB9+mWGNd0zFgAqVppBXu8z9O3nK@lists.linux.dev
X-Gm-Message-State: AFuF++k+kMH1nOpp0QzrajXdCuOJu4BLuXCEnWQY4gbYh4kQNg3ZNemS
	CqvIynna5PNsnado2/I3pHbHutC9lZfKemfx8qD/ChudKiCyhUmtbzpuZAR9XP4InqCaFLkENVg
	enRzfRKWFAbYnPnm6N8DC0nBvCEWlq0hj6gOX94Uit6GPjhRxJPYu8XMSsT+PGwiJ8U3wAfFGMF
	ZqztKiMzqaluNJFvDS+hcxAE3TtDJaVQ==
X-Gm-Gg: AYBFou1+YXGxmBpBwClyHHkCGq0IVEh4mpr87B/y6wuqWEbbwBlXBGoHAKOMUFayvVd
	MmRO6aDrmR7xr19MhWVQScXnKne5+OTH2MaM2QROMZ8zPrXEXUR+7bcrARDjem+Xfiq+FAk3smA
	6Tl/5euQAm+v/KIKIBWznqMLMj90FK7w9AzWE2Kxv3t9wCbbZC7aXHlKX0
X-Received: by 2002:a05:651c:50e:b0:3a3:63a:baf8 with SMTP id 38308e7fff4ca-3a3063aca0bmr67998831fa.3.1788282762515;
        Tue, 01 Sep 2026 10:12:42 -0700 (PDT)
X-Received: by 2002:a05:651c:50e:b0:3a3:63a:baf8 with SMTP id
 38308e7fff4ca-3a3063aca0bmr67998661fa.3.1788282761971; Tue, 01 Sep 2026
 10:12:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260901091836.16906-1-qiang.zhang@linux.dev>
In-Reply-To: <20260901091836.16906-1-qiang.zhang@linux.dev>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 1 Sep 2026 13:12:29 -0400
X-Gm-Features: AcwNN1V6z9doM154Oh_sdUpaPrT2erEss33T2N0VfrOkvLScrPitfVq7091J7t0
Message-ID: <CAK-6q+j7n5MvSRXMb2b6UZbaf+NxULrFJiAfs-o0CWi2u+48uQ@mail.gmail.com>
Subject: Re: [PATCH] dlm: wait for outstanding SRCU callbacks to complete in
 exit paths
To: Zqiang <qiang.zhang@linux.dev>
Cc: teigland@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IMniQbXDeSoDeqPZH1grZBVvqAiw98Vsli65Y8IeYMg_1788282763
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 1, 2026 at 5:19=E2=80=AFAM Zqiang <qiang.zhang@linux.dev> wrote=
:
>
> The dlm_lowcomms_exit() and dlm_midcomms_exit() iterate over the
> srcu protected connection and node hash tables and hand each
> element to call_srcu() for deferred freeing (connection_release()
> and midcomms_node_release()). call_srcu() is asynchronous: the
> callbacks are invoked only after an SRCU grace period, which may
> happen after the exit function has already returned.
>
> These exit functions are reached from exit_dlm() on module unload.
> Once they return, module teardown continues and the module text
> may be unloaded while call_srcu() callbacks are still pending. When
> such a callback finally runs, it executes freed module code and
> touches the static SRCU domains that are being torn down, resulting
> in a use-after-free.
>
> Add an srcu_barrier() after the call_srcu() loop in each exit function
> to wait for all outstanding callbacks of the respective SRCU domain to
> complete before returning. In dlm_midcomms_exit() the barrier is issued
> before dlm_lowcomms_exit() so that node callbacks are drained prior to
> tearing down the lower layer.
>
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

Acked-by: Alexander Aring <aahringo@redhat.com>

- Alex


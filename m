Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4F24A4400
	for <gfs2@lists.linux.dev>; Mon,  5 Oct 2026 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212037; cv=none; b=oKF1WyQ0gxxABxoAY4CzYxlTx+16ycau/4yEjiHuHk3sFAyrUdEPXHdTLiXgzynh21tTs/xamm3upn3+dFWDZK90CdjzUYhvzLOzPd8gAfJMLhEHsfzAeR2XsmzDui4UPM93B/fqD5+KiyPF7Yx43mVCGEBwlpyUC01uf36fBrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212037; c=relaxed/simple;
	bh=8zZ8QYcbf7PQFHGj3s4MFHZ/+0IN7ifpAJMj58pWUE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLlNX5ZKf5QfZT2hcm2Y5UGMVn56P7OynYR0EnICTB0So/o5Hy7WLsLfx8bmkoNfXiO+tl4RSM/HiDg/g3ckEuGk0XUW6QPkoUPUXRFwdnkLZzUpREpgnmCCIaXy5xGVN3N5xHKcfgnNh5qPPUHqJXx/gqLdo+FxYKp7/MvNb2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WwE+pYae; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WwE+pYae"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791212031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8zZ8QYcbf7PQFHGj3s4MFHZ/+0IN7ifpAJMj58pWUE8=;
	b=WwE+pYaeBHKmERsio5d9KDbpQ6eiJQrvaGv1ZFm3f0aViABJYEJ/VuEql5lWMDct8veNGR
	lcBBrG0snka43vGVfA6H1jovCpuwCaLg2joKyEBezcbj40aXHQSKa0X8ftUSMEcETH4h+c
	8wENioAzj6N4RWSFPMpH55kEj6uWBi4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-DZfYvVWpPCmVN0T1XAMErA-1; Mon, 05 Oct 2026 10:53:49 -0400
X-MC-Unique: DZfYvVWpPCmVN0T1XAMErA-1
X-Mimecast-MFC-AGG-ID: DZfYvVWpPCmVN0T1XAMErA_1791212028
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-3a781d7cc95so9527631fa.2
        for <gfs2@lists.linux.dev>; Mon, 05 Oct 2026 07:53:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791212028; x=1791816828;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8zZ8QYcbf7PQFHGj3s4MFHZ/+0IN7ifpAJMj58pWUE8=;
        b=SXfOSqwaB4PbG+PrGSxxAB6SvcX63HZDM7NRWLYFeslcV/HyzHu3juZJKJdIooFsX4
         0hoxMUO4vyCCR+nvkPNt9LvMPIOtzV/OlGV1OKSrSgZ07WWl14jbf17U/vndv6YDGdcR
         +1ODltbR1Vx45XLh+XrAgttt8v0JnPFjqHzstvT1ACdEqnoGJ7fuST+PR3Te1oYo/VL9
         +DkkGK8Ux7BbdwbBZtS/Og9Uq5lNEcmSfgt022UQgWqK0oTW/Mo4CInVZlgq1WPnMEX3
         TMUrx6Nup0x3jj45HldT1DTBtQv6HPmz1WqoDn3OPnpyFbEFsw0n8bM+TvVFH+CkvYO6
         I4wA==
X-Gm-Message-State: AFq9FYI1/W5JmPbeuK8UGcXoeK5zGDML26omlJmB0ivXT+HFvaHPoaMo
	7EbtJfz3cIy8XYXdCB4FrABwOO+8igw7I06MW6ZyoQvNPCE4uUQM9e06laiVKcDCzlznYeOL1mp
	e178FRb6K948+8/Vx1gb6DVThYs6CpIR5Lx2p0No2VfkHi5fFsm0tu9POxSmJG2/N26vjNTNuI8
	8iKUP0LbYwjBq5NIm10+5Y4L0s7iFR0Q==
X-Gm-Gg: AYBFou2ROccLmsT7wHb/Oaq/k1cl6Pdp1JvaqEhIPHA5iAIwwCR7GFRMvN9tBPVj8V8
	2gMdvgXhRnv8eFc6O+6KOMh3UMPOKMLnwCFZ7Ca+NBJAwFfHlo11T306QcWdklytstgHMSDxZty
	6qb1NtRCOG3bsRK+oWYEzjOO4Y5wDzx3NZdErTQKgm3K1wiNTT8HW89AMn
X-Received: by 2002:a05:651c:a214:10b0:3a6:58fb:8540 with SMTP id 38308e7fff4ca-3a8877acfdbmr19316411fa.19.1791212028019;
        Mon, 05 Oct 2026 07:53:48 -0700 (PDT)
X-Received: by 2002:a05:651c:a214:10b0:3a6:58fb:8540 with SMTP id
 38308e7fff4ca-3a8877acfdbmr19316311fa.19.1791212027578; Mon, 05 Oct 2026
 07:53:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261002232107.1578646-1-aahringo@redhat.com> <20261002232107.1578646-3-aahringo@redhat.com>
In-Reply-To: <20261002232107.1578646-3-aahringo@redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 5 Oct 2026 10:53:36 -0400
X-Gm-Features: AclHuK-ouLvX0-7cuNCKJafhkt9kjj0OqJOrCqwFlOBX9-Z-Ur5EBRc5Gfep-CY
Message-ID: <CAK-6q+i7ix55=aJ0hRHHq-V+YNym-VQ4dKVc0KpWzGP-BLXTwA@mail.gmail.com>
Subject: Re: [RFC 2/2] dlm: fix socket hang on send buffer limitation with
 socket error
To: edumazet@kernel.org
Cc: gfs2@lists.linux.dev, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6ZS4pZHbdHnsf02WDd7AwbadKJ90m59n33BCE5SQvJo_1791212028
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 2, 2026 at 7:21=E2=80=AFPM Alexander Aring <aahringo@redhat.com=
> wrote:
>
> As Sashiko AI bot mentioned [0], a socket connection can get stuck when
> the send buffer limitation is reached and a socket error simultaneously
> occurs.
>
> This issue can be reproduced with the following setup:
> 1. Set sk_sndbuf to SOCK_MIN_SNDBUF.
> 2. Slow down DLM connections using netem.
> 3. Use tcpkill to randomly send TCP resets to DLM connections.

I ran this over the weekend and wasn't able to get the connection to
get stuck in the mentioned scenario as I think it triggers
.sk_write_space() and .sk_error_report() interleaved randomly.

- Alex


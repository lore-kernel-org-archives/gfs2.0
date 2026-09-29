Received: from mail-qv2-f43.google.com (mail-qv2-f43.google.com [74.125.230.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF693A4F30
	for <gfs2@lists.linux.dev>; Tue, 29 Sep 2026 07:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790667061; cv=pass; b=MCeg7Em0wSVy9FOk0+yJ9klJcoQrKzOWyg5N2rhd+qWfbPY1HZ5pSATbeKi6vGnRcAnfyIwcHPpkD7lIRiRawd/3HdVWfcTKoFx7oTwqYcc2rZDEa50IptgfOBjIOJiUveNLMwe+2HMbEMPoAKBgEOa5xNgIija5hFsKluuYK6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790667061; c=relaxed/simple;
	bh=I35gDNGA4fpIsc0ElTO4/D3swmmdD1nD0eRHXQrQQRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tLIxgTcb8qLY4WaJeK46bwxanaE6WCYIBlQMra2X5CaKFN5ViAM2KUh/gYbSctBK6SwBQjaN9HOx2kHkkgcpvbXQELn/lbzM7qId1h+Tr90F/fJw2azKC8mAFInM0En9kHqHPgMk5ivyDaMR0Yni7U8X5BE+eo4qrbQ6K5MK7IU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pdTuAoE3; arc=pass smtp.client-ip=74.125.230.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pdTuAoE3"
Received: by mail-qv2-f43.google.com with SMTP id 6a1803df08f44-91434eba587so38935736d6.3
        for <gfs2@lists.linux.dev>; Tue, 29 Sep 2026 00:30:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790667059; cv=none;
        d=google.com; s=arc-20260327;
        b=ke7cinN+HNjPUn1cAb/NXoOYSKS15Rng4gTAH4CKFXbplPgwVjDq40Msg/+Ji7R8+3
         D371+6EvN3Y9eCs0rqejxfQ+PsPvGDJyGENB0nHqcsPiLQThbZ99mVRNQ19JWiSrQ2o8
         Z0sA08/S4sti3qsObblfVpq9NtSmgYdVCctH1omz2LzgYKRZFTJjTxlcLnASYWLIyZ5w
         QXSeitmgQGReVAEsL5TjcP5vxKjGwSSOwrFYVBooQnjeY+JxZR99B7uWK5TE4PhhrZSC
         t4Yw/7cs3ojtkEFlqx8TTYFmCVTgGKxVvurh5gy/0WtTP87QVdJlsbUHHORfPdrqC8GB
         7VEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9v/Z0GcKezXBRqzYvyQ4v0b98G06dRHjg36qbCp+fss=;
        fh=hVhJ7HJJu30LbIKTPPbz9pftVyXgJ8uH4SSQWKKgKhI=;
        b=Rqdd9X3O1mPLchIePnY60zYcrCGbOB6Ltp5QQWdwtFN/tmyZs4XujZ6gsxqtJEfMQl
         CgAdexI3G4HJlHFs0a2//P5SckelvtDWnvyrMi6cvOSYkiHR74mwhrdf+LX7JSaSdJYf
         qYPO1HD5uLprxLkq1YTo1Vt0JJE51orv5JWqMZ6f8juqxAGrVlZB2huKgIksYqF1X0HH
         hdwC9+HWuywZe7B2oe7SOnJsD7jL8gd0vcO80NVEBltu/KTN3hSILEpIr8MyNvKD4Mgc
         LP8j7qYU9UYJbzejDTpja7aYde+cwhl301m/+TImgStY2RqQL5sNVFUuRRBMXNgF54F5
         WnGw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790667059; x=1791271859; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9v/Z0GcKezXBRqzYvyQ4v0b98G06dRHjg36qbCp+fss=;
        b=pdTuAoE3TBwXW3sfvj8C82vM5pqQuiIimdCNzsV2silb+tvySOMcffTVKxyVyESx+v
         W1UUxlCkv1pvluoTgvrCgaCS0CLifQuMnMY+72pIs/lYQdNFocOVHVPEW1h/GAWGHOQ4
         cDJ3quvWjAOJYFwN8s0r8bGALYwnWb7TtYKN8Vg7GFu6VFT2MCEx7bUS/vZNHXjCH7jA
         UR+HQCmdbi1TYZcZq+Awn3+vdreDD0fAdebBxJ+aVgUfMkhxT7NIV5jndDcWLz24CnPA
         Gdz4PIUDayzeAs5S6g9leK6HbxOqnp1WwVznXegWUO2iohZliy+CV/3bA1qWh/A5qH/8
         9IAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790667059; x=1791271859;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9v/Z0GcKezXBRqzYvyQ4v0b98G06dRHjg36qbCp+fss=;
        b=a/RvDB/MQ8DCuJzX+vyOix9YftKmVrDbJ5hCWLrgR+Z4kmXXzhDuNS6KG7o3dq9K8U
         kjz0pzXl5+/filw20EbrNbqm4ui9qtkYz8siwMcS4XWq1mXNXQVOCTEnEy7K9Cb5SdOb
         loYomXKUuAeblJDMOd+NDopfS24eZRqmmbv1xC7/k5Sr7qHIA6lpTE7EYjCTxygOMU4M
         HA0zB7C+IfYWXF14qs1Dx8RfOrpaDwOmmU36D7aqx1BHhrUGHwlH02m8gKstTJkao0KA
         CJWXUluvRYfmgDFaZGjLpTS6nX/9hLNSlSoi7X8jXN2VaK3bDM/Z+/nGDMFLeGXbiQ1l
         xUyA==
X-Forwarded-Encrypted: i=1; AKwUvBzuoJYkZA+1kb7CEoHk5Lly7Ays0RPk6uZzGUqA0KfBRezt1MwCd28iQyC+q4cN9KmjQkmE@lists.linux.dev
X-Gm-Message-State: AFuF++nEVdUfT8BhM2bqYtqSlkjwWOmtdz/3gY/R0x167zHRI5wGXnvt
	kdmMPY20HtXaFce7FNnqv2PWLfT9G6tnErjva2h4m3YMGENGZNI3GBTsKXCQpspytGZDqsmcsOI
	szNp9Xh6Q3PBomx5qO+qypukDj/Ul/mFpcOK/mce4
X-Gm-Gg: AYBFou3JNlzzxdPHh4LG131vBnovGiBmt1Hujbc5OiTSFDlmV/lcyfIqtrCbEn+rByd
	NCs0Eho5Ew0MOfcI4bEB5EnQ6Ubw+Rj5kplKLUvBoYpgZTmJVHHSFYXFjq7lXq54fUD1ZHswJr2
	JFg7kz7fHhPEpvbaeYB3p/axDi0BMrHKxsL0EVXY+Kv2cdjOgoWPVK7RnfapBK99qgAgfbd01kd
	O5bOZ/AQrFCV4D/ma7rWO3G8ZmJ6t2AhHQWjrzW7EhrrVMgLZdGQpbxTwRipNy4Mq/D1p/eM6O/
	OjUMk5f1s7qE3ZpdeJPnk53wHn7xG+pT9ScXMkur2SU98PLMAAuEK0dL/XEZDABHUSKbJOhctC4
	vS6KXRhpmwGSbo9LTfxEBEAdZjtlpBofXgQsL4z5jIjajubXGzjleRAaBs4L8ZtwaqnSs
X-Received: by 2002:a05:622a:580a:b0:532:d3c2:165c with SMTP id
 d75a77b69052e-5330dbe7682mr252226541cf.5.1790667058017; Tue, 29 Sep 2026
 00:30:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260929071743.23624-1-edumazet@kernel.org> <179066667444.31693.3326934466907750947@kernel.org>
In-Reply-To: <179066667444.31693.3326934466907750947@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 29 Sep 2026 09:30:46 +0200
X-Gm-Features: AclHuK9CAnCUx8smImHilXsTcocuUN-fbbX48CMDJnYU9QbhFatMhZFb2tpvc_0
Message-ID: <CANn89iLUKHZVrUOEtqDwuAghCRAkddigPwSWj4uS=fKyWdk86g@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 0/9] tcp: avoid struct socket cache line miss
 in tcp_check_space()
To: netdev-bot+sinfo@kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev, 
	Wen Gu <guwen@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Chuck Lever <cel@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	Allison Henderson <achender@kernel.org>, rds-devel@oss.oracle.com, 
	Philipp Reisner <philipp.reisner@linbit.com>, Lars Ellenberg <lars.ellenberg@linbit.com>, 
	=?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>, 
	Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linux.dev, Keith Busch <kbusch@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	linux-nvme@lists.infradead.org, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 9:24=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>

Patch 1/9 fixes a bug found by code inspection.

Other patches are not bug fixes.

> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DFE20D4FF
	for <gfs2@lists.linux.dev>; Thu,  1 Oct 2026 18:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790880364; cv=none; b=ZMPv1tB+CpIAB6wzzz73VJncNpJHW4LRu+SmJAGhVPllXiOHuxPxJ2DAuqbpczN2R7WZtjTWxIy5AL8Rc6QhdkBgfE8LRIFIefYt7y9FbzLXfzp6i7/dwd74JQfnhrjd18EWQ9H+/wsfwZYYlo7rmqWxr3Lqx6naBR83es5mLc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790880364; c=relaxed/simple;
	bh=KhZvNHR8S9wRTF9gNlwTsLNH8HmuAJIKnxHt9nq8CeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PqILjF09rCRPHfYsTARLzEWg3X7pRsJG3h3EUv5saPDbvdaeKTjilcAbPggVn83kgqDQvAzidU7UuoN1q6JD3S2ekNc0FrniYXqHIyYnhq6kxQUYMwQmy+mipSwZSi173WAnS6qGqRu1O0J0ccWTfOG/z539fXcf7jSqWtbrbxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PvKXSFIn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PvKXSFIn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790880359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eQS+1BIfTiW5d02m6eavAojtJlZVnOI1LyUgaSLiRac=;
	b=PvKXSFInHYV7347PyofpoN8ikAGFT/hYqqwFy/7JxF7jR1vAnKP8RHCidA9A/SKwY32PFT
	3v0FN0vxb+tCpbsiL8CsVXSzygbOOkHn8sTTWSwEw95jIRp3RQ5C+ikO8vfUpXoH5Ultwq
	57jOJFfn9XET8pTzQYg9/PXFLkPy9c4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-bfxaGB3DNca-6IMc29sqhw-1; Thu, 01 Oct 2026 14:45:58 -0400
X-MC-Unique: bfxaGB3DNca-6IMc29sqhw-1
X-Mimecast-MFC-AGG-ID: bfxaGB3DNca-6IMc29sqhw_1790880357
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a021b1b561so7583075e9.1
        for <gfs2@lists.linux.dev>; Thu, 01 Oct 2026 11:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790880357; x=1791485157;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eQS+1BIfTiW5d02m6eavAojtJlZVnOI1LyUgaSLiRac=;
        b=mmz9hPNueTGCVcx3DXPU0r/21xA1qhc5AAoxi0NBoZoFkMv1ka4Kry5dzSWE1ZFfsw
         otF82CR3/RnFQHTzFux9XJYeSYTyKARoj0HGC0OlEXGyUSWXKzAlUSVImpWEGya/zsJJ
         uQD28K5TNK22JFD2MB3PGn3wgo3Vg6TEQ0fW4ae5sJVePq6e11N2U2qv8DO02uyQF0TE
         vF6omVm0cKEUN2H6RO9J8S7H9zlbtTyqEdCvOgLg8yauw6fkoQnmjMiciO8prFErZm5n
         7a/dSeq1hZMbcajUQyArRhlUey9DCbztEKgdwDJb+Gz6/YJl6fhLPN97HQJGol9mO9qw
         7ZTQ==
X-Forwarded-Encrypted: i=1; AKwUvBxI50P9DuamKzH/xXgqaAOKD7RfWEo0tT4MNFUn+/3tHv1++0O9WNyOZn6Jxop51IwAMj/2@lists.linux.dev
X-Gm-Message-State: AFuF++kViW5qf6lXTkSdaGFmlZ0cmQH7g40aHG54y5OhAMfYZys3Ait0
	vWZM/3Z8CV7FhQRdKL7S2EQt+AGdeJRpMWQ6lpEzqaGpR3gBr20TlMGN8YUxHbwI4a3WMDSYP7A
	reniShdObVd6TJA2Hp3AlXjhYKr+kW1FDjkW6B3CUoXo4BeuFIkI8m9TxiUVWGnVSbh4GuyYmNL
	raU9/5I0HS5LL9wRS8wADqD1OO2fy+4Q==
X-Gm-Gg: AYBFou2RCU2JDjIyd42dtVq5CItMTwb9PckPqg4RGzVRRJsCCLAZTW1Zijm3253mCKe
	HKw8IgVEVjwS/4MIBm27YLEIph+mKvE+17GQuP4483zwY6QJhjIik4JFHE/ailLHXsvP9R9poP5
	znGGsFbzJtWSMU29+aXb9O47Zz6HVu2+J90M/2F43H27Ei4BuN1Wi+dOI3
X-Received: by 2002:a05:600d:640e:20b0:49f:ce78:356b with SMTP id 5b1f17b1804b1-4a0276afcf0mr6697295e9.28.1790880356952;
        Thu, 01 Oct 2026 11:45:56 -0700 (PDT)
X-Received: by 2002:a05:600d:640e:20b0:49f:ce78:356b with SMTP id
 5b1f17b1804b1-4a0276afcf0mr6697035e9.28.1790880356511; Thu, 01 Oct 2026
 11:45:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260917064657.3260776-1-yiyang13@huawei.com>
In-Reply-To: <20260917064657.3260776-1-yiyang13@huawei.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 1 Oct 2026 14:45:45 -0400
X-Gm-Features: AclHuK_7D6uTkoayAykfK_vPNPEK1XpKKIMWior1hkRrRZG49z-vx0HY0e22dFA
Message-ID: <CAK-6q+h4GX5tR2Nmk81E+kVnHAmRN-GoEzdZo88hsw742jbw2A@mail.gmail.com>
Subject: Re: [PATCH] fs/dlm: fix NULL pointer dereference in __queue_work()
To: Yi Yang <yiyang13@huawei.com>
Cc: teigland@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	lujialin4@huawei.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: keInR2kWCfdRi4VbCNrULBgB91ppgxm3tJBqxEfLFIA_1790880357
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 17, 2026 at 3:21=E2=80=AFAM Yi Yang <yiyang13@huawei.com> wrote=
:
>
> The rawmsg debugfs file lives as long as its configfs comm entry and
> is independent of the lockspace lifetime, but sending requires the
> lowcomms io_workqueue, which only exists between the creation of the
> first lockspace and the release of the last one (or a lowcomms start
> failure); work_stop() then destroys the workqueues and resets their
> pointers to NULL. Writing rawmsg while lowcomms is not running
> therefore ends up in queue_work() with a NULL io_workqueue:
>
>   BUG: KASAN: null-ptr-deref in __queue_work+0x27/0xf0
>   Read of size 4 at addr 0000000000000100 by task syz.4.3355/21899
>
> Regular sends racing with the last lockspace release have the same
> problem, as work_stop() never waits for senders that hold
> connections_srcu from dlm_lowcomms_new_msg() until their queue_work()
> call.
>

if there is a dlm_lowcomms_new_msg() running when there are no
lockspaces being around this alone is already a problem if this is
really the case.

> Track the workqueues with a workqueues_up flag that senders check
> inside their connections_srcu read-side critical section, and make
> work_stop() clear the flag and call synchronize_srcu() before
> destroying the workqueues. This gates all send entry points
> (including the socket error retransmission path), while the socket
> callback work queueing helpers check the flag as a defence in depth;
> the flag is published with release and read with acquire semantics.
> The rawmsg write now fails with -ENOTCONN.
>

It makes sense that rawmsg fails when lowcomms isn't running.

- Alex


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7421FC8
	for <gfs2@lists.linux.dev>; Mon, 26 May 2025 00:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748218321; cv=none; b=nmh+VxiWx8RdevRtO3TXKBUqRR/rZtAwQgTUowmdSKNKD0L4KpqCTDzCCFzWII1ROL/cqMzJW7/R7Obcr+OVNp2QGbU0hRgX206zG1U/yO5uASZ+WO+hb4OGsnpQuocoby+EqirfXEc9mkA2ts7WdEbYf0rEimiyfuHHswNI8QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748218321; c=relaxed/simple;
	bh=mZawqeNCtV5RIiwM8QEaWmEbfpt929UpPSKQmlEeQ0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=md5e7HmIdU+tKI/eV33pAByHZaBuceVJ9okj3TJELxJfE4R4mjTZhx5fx/9LjEWFP/hUZhGNqLzEYmru2voiyNLsHqy4craaKHCwoLYQqvXTwgmcnuzEuJR4f4R+D3Ik4cTCzuAmHc3s4Kuk+sA7yXOueAMceOMeBXFB12iiNAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ibVS1e6C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ibVS1e6C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748218317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YnEQ3B0+tF9saGwjZYy8KszduZXiKUGwKSNDFaV3AFA=;
	b=ibVS1e6CUkG30CHQFEDE315bRRQvK8SQxrW2vt8D0Egj8gTaUlvfJce4a/0/kfPbwfKdx5
	WcTT5aSOlo+VQwLLpy4ylf1k7RL2PNmkHAJTga79fV+0mhlx9Ez+UDbGvClAvKoLWAk2yz
	DtSgZ9DFzRU6o1DsxRsVFD18XQaxooU=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-496sCqe9PZKAWINntQUvRQ-1; Sun, 25 May 2025 20:11:56 -0400
X-MC-Unique: 496sCqe9PZKAWINntQUvRQ-1
X-Mimecast-MFC-AGG-ID: 496sCqe9PZKAWINntQUvRQ_1748218315
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-329099f2bb8so8527591fa.3
        for <gfs2@lists.linux.dev>; Sun, 25 May 2025 17:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748218315; x=1748823115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YnEQ3B0+tF9saGwjZYy8KszduZXiKUGwKSNDFaV3AFA=;
        b=ikxD17a5IUrwkayQ0271XHLyXal9c4rTKqRbc2QYLv99W1Tb6Ww5YvVL6dszu33pH6
         qc9K2p+R+9hvi2mFB+YmglzbKtxFCOAbtlkZLIVRe+9nmZM70Mn6P8E79erqcOQer/ZR
         Rt+Zd4Xsnsf4junxl9EU3cKvFHQo7JyjhuL9YoRw9tNBMQ+9Tv7l/sgAuRzvTT70DQ3k
         iVCSyRoFgER95pcU+udul7zPCAULbOevg23G7ZNI5rpT4iG64Lf/NVURlO6Hf/QqV1e4
         kQVS99fiUpgyEtkeU29ZXP8JhDuVt1QjUJOhdfwgrSXWJ0obVJX1XiMKh3BD/kSIClFC
         lWOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe9kdF8YlTLN3coofDU72l7HSOqFzg37EWdXqxRMEhcmWtUmU15jZM5fC5EB9wW7px24YE@lists.linux.dev
X-Gm-Message-State: AOJu0YxbaXwoSadytmg03lxqOdJfuuoR5KittYC+vb3vaNfwYeOOINd3
	82ksJ568REtU3zRKTzifsll1SPapDNIjxP0eD9yLxsGMFragg4JJR54KWpYQvjgTnJdlty4AsMS
	2vh1XDunnAYLMDOydb3GpIBcC54BOx+JnIiCjVaAneesgb/O3SdzdCz09SFidEMOzK6gcHpRZUw
	2Mr/67bSHwCRTCb1ShbrLBPYh0QDzuVg==
X-Gm-Gg: ASbGnctM1R0FwJtY4gQXVZ87vpDEkAomldrlyL3vuKhfFIzQ3da0Yy3WFQx2MxJAbzp
	XEV+9N2v1D8JW43y5nT7ifSxK/16TIdt+cswkBcFH42VKxNLTkCtWB3JCcLbKC+Ko14QIGDBRyj
	c8sLTF2CaFj9S7hnDLAcQZg6vu09c=
X-Received: by 2002:a05:651c:305c:b0:30b:9813:b011 with SMTP id 38308e7fff4ca-3295ba594abmr11293961fa.28.1748218314939;
        Sun, 25 May 2025 17:11:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxSzrANjGZO695pzuEQ2v9B+qoSVMdjfmIKV1W9Kge1MLAjgpFVyrOHqu+lJwacTKEzp6ex38r98Sy7KHAdo8=
X-Received: by 2002:a05:651c:305c:b0:30b:9813:b011 with SMTP id
 38308e7fff4ca-3295ba594abmr11293911fa.28.1748218314504; Sun, 25 May 2025
 17:11:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250522052453.GA42746@system.software.com>
In-Reply-To: <20250522052453.GA42746@system.software.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Sun, 25 May 2025 20:11:43 -0400
X-Gm-Features: AX0GCFv7v9Pg2Kx0t6ojR2Iku4i4QqGsQeOK7H63LAvoObcpfkGL-rils5Ws1JI
Message-ID: <CAK-6q+iiXFh+XhBfghaP6C_+89GnbAzYAfVnm66joA3YTMCJng@mail.gmail.com>
Subject: Re: [RFC] DEPT(DEPendency Tracker) with DLM(Distributed Lock Manager)
To: Byungchul Park <byungchul@sk.com>
Cc: kernel_team@skhynix.com, linux-kernel@vger.kernel.org, 
	gfs2 <gfs2@lists.linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dOOPgpsZZhM8QL-AlD84o-FtY0pr8kPpu9HXlkO-p8M_1748218315
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Byungchul,

On Thu, May 22, 2025 at 1:40=E2=80=AFAM Byungchul Park <byungchul@sk.com> w=
rote:
>
> Hi Alexander,
>
> We briefly talked about dept with DLM in an external channel.  However,
> it'd be great to discuss what to aim and how to make it in more detail,
> in this mailing list.
>
> It's worth noting that dept doesn't track dependencies beyond different
> contexts to avoid adding false dependencies by any chance, which means
> though dept checks the dependency sanity *globally*, when it comes to
> creating dependencies, it happens only within e.g. each single system
> call context, each single irq context, each worker context, and so on,
> with its unique context id assigned to each independent context.
>
> In order for dept to work on DLM, we need a way to assign a unique
> context id to each interesting context in DLM's point of view, and let
> dept know the id.  Once making it done, I think dept can work on DLM
> perfectly.
>
> Thoughts or any concern?

I think the unique context would be the "lock resource". The lock
resource is a unique byte array and is the unique cluster wide lock
context. It is the parameter name of "dlm_lock()" [0].
We don't have a unique id for it, but I guess this can be somehow created.

The locking context in DLM is per node, we don't do everything
locally. It does have a locking protocol over the network and works
with lock masters. A lock master is a unique node in the network to be
chosen to do all lock operations on. To maintain/create a unique lock
id context is I think more difficult when using real networking and
several nodes in a network, although I also think that DEPT is not
capable of running in such a distributed environment right now.

However a RFC patch series [2] is pending to add support for
net-namespace functionality so everything can be "simulated" on one
Linux kernel instance with several net-namespaces as per node
separation. With such functionality DEPT can be used to find deadlocks
in DLM applications. A unique lock context id for the resource name
can be easily created as we know everything about the network in a
local environment.
This is just the proof of concept, how it works in a real distributed
system would be another question...

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/fs/dlm/lock.c?h=3Dv6.15-rc7#n3372
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/fs/dlm/lock.c?h=3Dv6.15-rc7#n694
[2] https://lore.kernel.org/gfs2/20240930201358.2638665-1-aahringo@redhat.c=
om/


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F48930DED0
	for <gfs2@lists.linux.dev>; Mon, 27 Apr 2026 13:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777295728; cv=none; b=c+WiIEqQdHBxBFZ9I/RsVgy6TtuggLWrfRAEwtSYmbuwgo8OF2x+np0F98LaJ/mtg5kB37RS8qAC86k5GMIHFgM7hzzKpEnUANFQyLKAheVGkSBGbOZIWHsQbxB8cpmx9yDEbE/QzbwlLfSeB33F+aR9X2An1v74YBU63fHwnSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777295728; c=relaxed/simple;
	bh=jbo3zMg5htUbtG7GY9KiX3ONo6eKpWv7OwyU5Jw63Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z2ULSPKC0pIXBgLgyIKkYCZQI3KmeO9bFhHnFIQxnTCCqjiHqmjZap8D0whZpNBu0/I2MW73AutOH2+2WB8Gyan+mCR37CbQ5XDED37wNZGHZqQExZRqoSuzhnXTDDySjutTsrH83P1a6kLwErAOWFz+u4KfKZalNU1GBtJ6DBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K6L2Da1F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K6L2Da1F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777295726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vPAfG5FAYkF5imXbnU13cXJBeGWWXPo9LmWS7h5w/hU=;
	b=K6L2Da1FdLhg+VWetSnpfTqoj/lz4hn1yfFy77DQmPeiHFiyoEqmZgEeKmRx3Q8DdDN77x
	Wy8DWN5WejOFqNbsWG4ArMSG0l53JUUHm5BUPZ85yZAjKuK0UDXiNHyetw/Q7/SJQlmsIj
	uws+T7+B3guZQFda9oMYzjYJtVS67x8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-LDL8uhrINlmsmYqf8cNZKQ-1; Mon, 27 Apr 2026 09:15:24 -0400
X-MC-Unique: LDL8uhrINlmsmYqf8cNZKQ-1
X-Mimecast-MFC-AGG-ID: LDL8uhrINlmsmYqf8cNZKQ_1777295723
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-389fef1b721so44055291fa.2
        for <gfs2@lists.linux.dev>; Mon, 27 Apr 2026 06:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777295723; x=1777900523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vPAfG5FAYkF5imXbnU13cXJBeGWWXPo9LmWS7h5w/hU=;
        b=GspO7wUb/zGRkb00gJ6gB6CM09C38/FdovvTA3uRY6Xh/PzOVU0yJ9T2ZlibuL7pEX
         g52rQc3IDRd4OtiQMsonwS4gTNUUa/jTSAS7Yt6PTkoXk/SxF7Q1zpV+/WoX3x9P/GYm
         q4pjqloQ/Cf9rxAFefLxCiwOSZ9eUjLFhLJsrz4qBV0T3d9ZlC3/Ah9rEUvGTRj8tbGz
         7oi7oixG1oF4fKeZNx7dDEYeFoO2fHZz873vcI9RV/Iiqkgzbk6zILDdmHxdYXLiQcZE
         xqXYxekcxfokGEccRYUTkQRiyugbxbamok1pNmITLDot95OGkpYv+K/A4ap3gjdI6w31
         ST7g==
X-Forwarded-Encrypted: i=1; AFNElJ+oNsAzKwvNjqNg3U0QSJ/tKChsHhivk6U3Fs9ctpXf9Mr7K7K/6miDK5JLNGJqiNXeovpf@lists.linux.dev
X-Gm-Message-State: AOJu0YzOOGAp6n7J/+EHs3BUA61ndRHtLHli+ULynrCXRMa5M4irfMKo
	J07oD6YN9fWYm2i1HYBxOHP4FsCxNDn5GD3ZG5rt8tiXYnTZhlh873jR39VJf6FHGJLZYldY0yi
	PQ3TDrBoOvYhzs2G2xfY7VCyUK4+7egENkLW0S9ra+qKpdUSrThUkD+cNd0RBrGKLEh8j6fMAdZ
	CoWOFhDgskh++frzj9gDeA3VqnNI3IJA==
X-Gm-Gg: AeBDiev1iFvI3pVHQViwDn2aJ56v7W5+uKjI3Su/F6P5OXOg+Wf9rVj+XLdFWo+bhPz
	bpjKJzfT/pQpY88fTjbNP5wmoUGHMExFsyWfsnfMENgqiixJE7E26pqMQmRH8bkQWm9ZxVXk081
	YGfJOrDHRrGGhmyQsfsXTLdNUjejhbVOFZuXtYx0yq+368IErbpBIfI14wOjFDTh6Mrj+i7kD9W
	brkuh68BvVKoux6cbc0k6U58JzGeLeVTA4Se5pWfB2rNmwY/g==
X-Received: by 2002:a05:651c:4184:b0:38e:a8ef:b48 with SMTP id 38308e7fff4ca-38ec7ab589amr98647451fa.21.1777295722935;
        Mon, 27 Apr 2026 06:15:22 -0700 (PDT)
X-Received: by 2002:a05:651c:4184:b0:38e:a8ef:b48 with SMTP id
 38308e7fff4ca-38ec7ab589amr98647371fa.21.1777295722419; Mon, 27 Apr 2026
 06:15:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAGp+u1ZE7UsQ4sSUHBKQXU8x3M_jwK=ek1urSjEtd3jXQGFmVg@mail.gmail.com>
In-Reply-To: <CAGp+u1ZE7UsQ4sSUHBKQXU8x3M_jwK=ek1urSjEtd3jXQGFmVg@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 27 Apr 2026 09:15:08 -0400
X-Gm-Features: AVHnY4IPoCGgHB4w-0-zHpmDFPpTPtzNsuGb-H_Cs7qeC6f1wo0VJptdRDAL7AY
Message-ID: <CAK-6q+ijZLm5KPaF_o8L=KyWcuMouri+=67cSQN4Mf-O7D-_LA@mail.gmail.com>
Subject: Re: [bug report] Potential order violation in fs/dlm/midcomms.c,
 between 'dlm_midcomms_addr()' and 'dlm_midcomms_exit()'
To: Ginger <ginger.jzllee@gmail.com>
Cc: teigland@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: onrxQO3Liwo07z_J5mHqxekwyoS2X4TYvmtlrsYNka0_1777295723
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ginger,

On Thu, Apr 23, 2026 at 1:35=E2=80=AFAM Ginger <ginger.jzllee@gmail.com> wr=
ote:
>
> Dear Linux kernel maintainers,
>
> My research-based static analyzer found a potential atomicity bug
> within the 'fs/dlm' subsystem, more specifically, in
> 'fs/dlm/midcomms.c'.
>
> Kernel version: long-term kernel v6.18.9
>
> Potential concurrent triggering executions:
> T0:
> dlm_midcomms_addr
>     --> node =3D kmalloc(sizeof(*node))
>     --> hlist_add_head_rcu(&node->hlist, &node_hash[r]); [t0]
>     --> node->debugfs =3D dlm_create_debug_comms_file(nodeid, node); [t3]
>
> T1:
> dlm_midcomms_exit
>    --> hlist_for_each_entry_rcu(node, &node_hash[i], hlist) [t1]
>    --> dlm_delete_debug_comms_file(node->debugfs); [t2]
>
> In T0, the freshly allocated midcomms_node is first added to the
> globally visible 'node_hash' list, and then has its 'debugfs' field
> set up.
> In this case, in T1, the exit function can first iterate over the
> 'node_hash' list and access a 'debugfs' field that has not been set up
> yet.
> The concurrent buggy order is t0 -> t1 -> t2 -> t3, causing order violati=
on.
>
> Please kindly check at your convenience. Thank you for your time and
> consideration.

Thanks for the report. I looked into it and midcomms_exit() is called
in module init/exit functions. I believe the case above can't happen,
but I created a patch to change the behaviour to initialize the
debugfs field in nodes at first before adding it to the node_hash.
This avoids such an issue in potential future changes.

Thanks.

- Alex


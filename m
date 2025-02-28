Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADB71EF399
	for <gfs2@lists.linux.dev>; Fri, 28 Feb 2025 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756891; cv=none; b=fOiDTlttflNQjKU2YJ+t32bgYRK0PkU4oneM4RwvnU5ge9jjmZhjuHlK9ilYDbggoqfpPmfdmrMett4b/EGHfhfWdRFVQuD4Z7ReAoRnHQidiguQ9yxfwu/kyag1H9Z1evK2/79V0bXf4DeJDv15J2n0iWP8AcJ9KNPrSQwuzRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756891; c=relaxed/simple;
	bh=HyHXdDpgzJ/+/KdK3GOh4wYRFGXmUrlvEEoKiYkwJEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BhFpjdO0tQ+7purENtFXhXClVGqOO9udeUQhSDXiS5AqH6f6PkR4DZ/HHGrjPbMzM0ELCuKLLzgdzM7C3HgAwxmrzkqD/GNiqzB4zYo6q3MfNLU+ksGAOsPGKNVgFlFmdpkUqctf80Dzl1mztEl05cAqze7B/0olo5WDHzs/tLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mygm8u7b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mygm8u7b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740756889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JnXX/G7iP5CQGn6vWDeYsLE2R6XlO+hS6vkx+/3Pc6U=;
	b=Mygm8u7bxHHdMN0F6qquPzHUg9PFVSgSEQdzEAzhiJNtdjv5x9PbwAftYechpooPDHTF0l
	/uwpldrY8+f8p8mt3FhdrKLBw81SpntJxApL7fOTihX0LEPNbNfb9PGZZhSTCDylOJuf+n
	QSVGoxsDvheeH39u5voO3vFgb3/bDIo=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-kxaHrTFqNsuDbzOZk28rTQ-1; Fri, 28 Feb 2025 10:34:47 -0500
X-MC-Unique: kxaHrTFqNsuDbzOZk28rTQ-1
X-Mimecast-MFC-AGG-ID: kxaHrTFqNsuDbzOZk28rTQ_1740756886
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-3091da22365so10295051fa.0
        for <gfs2@lists.linux.dev>; Fri, 28 Feb 2025 07:34:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740756886; x=1741361686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JnXX/G7iP5CQGn6vWDeYsLE2R6XlO+hS6vkx+/3Pc6U=;
        b=fc8gWXjtKoLCKew2quVMhHNU7V1vcmKHGN6/kPZoK+H4XDLD5m8MJXyrn98JQ8TXQ9
         die4KkpDT8svi08HptfB9zhh3vcTK4acaIyZhzvU4+NIr3MtpPxpH8ecrbO+gsVB41id
         WcRau5hdIBIyKmRnTag9d2R7Prq9wXvg+kIOfQi4bB/pcjd+vSGDFo5GxnYDHIEUw9u+
         IHCfOoABQ/hEDiH/ZJTZMccTV//JPx/3bcoBP67zGZ7s9nVUwqht57c2bGAfTma79CnL
         E2//buumL3ALwV7K6rPjfACNeGGOPpQbkdchDyICWVz4fKqY3iLLRHfUO4ExDxqAKhaX
         QKfg==
X-Forwarded-Encrypted: i=1; AJvYcCUGbT3/Yuo6uR9Wnlbh01EH4cge/JZIrbLpE/M5ksbMNFedl6WRy49RWf9HLpbIoUNpPw+b@lists.linux.dev
X-Gm-Message-State: AOJu0Yyab/iBEmLMsSJgmm69DEwJB+79y0jwlzdaUXLUDRoSWD4JEV0g
	DKqnugIJQhudVlUN1IUROKiXynB91Dg7/wB26jjJMY/bDlPnbc2a0v2x6AKhhadLFeu1HbTOqnm
	ATL5wfGCqAsT4iaDYHDofGFYkPd827KS4qPIK1Przz0IFA0/PScCJaxrsNnBZqPm20Kayu/EFW5
	Ccl+IW62XTOxt2gVuJ29or/UuXTw==
X-Gm-Gg: ASbGnctW9ysi+7PkwYSZ7LMD84hwkvoPNdoJ3BMX+eSJRvLG0LuU+Newa2+ipgjSDEq
	Xus+ntwO6Z9f5YIOM6DZg735GWMhbwtfQQ36z1nv0HerNk4gs6GLAZnc6MZM/4At/6omujE2rtE
	tY46PzdZyMZO96qNkXPlM1Z2bbvUkiVRc=
X-Received: by 2002:a05:651c:2105:b0:308:ed4d:6297 with SMTP id 38308e7fff4ca-30b9320d91amr12611231fa.11.1740756885994;
        Fri, 28 Feb 2025 07:34:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKWBbAdU5g3QaEfsny+Ss9/q+mNe9ODSNIEJKdX0aHetSw0jIWEybyzmWa41SH+KT4MT1H0SHuTfDKT6ND2UM=
X-Received: by 2002:a05:651c:2105:b0:308:ed4d:6297 with SMTP id
 38308e7fff4ca-30b9320d91amr12611091fa.11.1740756885608; Fri, 28 Feb 2025
 07:34:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250221150937.21642-1-heming.zhao@suse.com> <CAK-6q+iiMqW9eknqgVZiKjeUgSEAkL61Q-EbP8xwy_bayjS=fA@mail.gmail.com>
 <Z7zJ6OQIzC9Q20sG@redhat.com> <456aa9b1-a197-4de4-a062-2fe11bdaf179@suse.com>
 <3a8cbc24-c024-48ea-869f-687ea740ad7d@suse.com> <CAK-6q+g_bdNoptQ_bPUbzE9uL=strr6utQ3jM_1fxoMOpEjA7A@mail.gmail.com>
 <468a9169-3de2-4226-8aa1-61e0e211e4bd@suse.com>
In-Reply-To: <468a9169-3de2-4226-8aa1-61e0e211e4bd@suse.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 28 Feb 2025 10:34:34 -0500
X-Gm-Features: AQ5f1Jq5IXWEyfqn8WNbLSP92POETRWStb7IjP7tHjvujn9uPYa59AhxeMSxZfA
Message-ID: <CAK-6q+jEhV5hQSjZu6xj7Ap8FzzkFosQ04X+qH2MW8+MOd8Zvg@mail.gmail.com>
Subject: Re: [PATCH] dlm_controld: Support for extended value of kernel DLM_MAX_ADDR_COUNT
To: Heming Zhao <heming.zhao@suse.com>
Cc: David Teigland <teigland@redhat.com>, ccaulfie@redhat.com, jfriesse@redhat.com, 
	nicholas.yang@suse.com, glass.su@suse.com, gfs2@lists.linux.dev, 
	Roger Zhou <ZZhou@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: A3IbnLs3ZAqo2-G4WhQK7TVnmjFIyHf8Qp83SL4GcDE_1740756886
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 27, 2025 at 8:09=E2=80=AFPM Heming Zhao <heming.zhao@suse.com> =
wrote:
...
>
> Let me summarize the above discussion/description:
> - TCP is the default.
> - stop trying to detect:
>    - use dlm.conf to switch from TCP to SCTP.
>    - corosync.conf 'rrp_mode' is not supported in corosync 2.x.

yes, I would just drop the whole detect_protocol() function and don't
have the protocol setting depending on any corosync.conf related.

> - TCP can work with multi-link, but only accept the first ip addr from co=
rosync.

yes.

> - SCTP can support max 8 ip addr for corosync 3.x.
>

It shouldn't depend on which corosync version we are using, or? It
should be the same way for 3.x and any other version, see [0]?

Thanks!

- Alex

[0[ https://pagure.io/dlm/blob/main/f/dlm_controld/member.c#_216


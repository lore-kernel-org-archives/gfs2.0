Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4876A3A0B18
	for <gfs2@lists.linux.dev>; Fri,  6 Feb 2026 14:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770389067; cv=none; b=Rbx7HO/Nrx2PUgcS4UvMs/umwXAqKja1dqXxNsBOmffjOULL391LsjVg+0vROcEtad/t5r5kboBj5IyOsDq+stDyS/ha7Zw8WmRIhYsXVUS6FfffOj4d/hGZ4ZvtNN6jHzvvSUBYtSggNEmHYp/osG8F+pnTKPFG3ZYyYF/FYO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770389067; c=relaxed/simple;
	bh=PRyh5D/kHPcPNHIxi0IbSb7iBBuJWE9dY81InROGpww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQfA83gFApeRMS6uuUKPBkAw8Oh3fdK8FTbUiQrmpkqs3aS5d9waqmVoNYOoc+m+kcbAjH6eyOYRUHKeDKHYYdv0zmIJeSV6wOM98xPLrhoQki30Q0B4r3l8BZdOTYM+vljUHP1UERYgVns1mP0Tyx2WhpgzUPKXicfbEF2tD+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KCRx3ijV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KCRx3ijV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770389066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PRyh5D/kHPcPNHIxi0IbSb7iBBuJWE9dY81InROGpww=;
	b=KCRx3ijVt6fxk7ec89jGzl9rQaobAj39IFe1POjk284Q+d/T/FbuIcJqsHxj5cgod5rxiZ
	2O4DtQHUsJwytL1lAm9BSp1AyUWYZ+Lz4gS+cNGd//b8dTZQHeD+YZTSslp3my4+1jR4jh
	9RZvGAUM6uzEpnNWMXy8x5JDHGOTxwY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-NxkLKvobORaUnUB88TaK2A-1; Fri, 06 Feb 2026 09:44:22 -0500
X-MC-Unique: NxkLKvobORaUnUB88TaK2A-1
X-Mimecast-MFC-AGG-ID: NxkLKvobORaUnUB88TaK2A_1770389059
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-385ba7acdd9so13451251fa.2
        for <gfs2@lists.linux.dev>; Fri, 06 Feb 2026 06:44:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770389059; x=1770993859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PRyh5D/kHPcPNHIxi0IbSb7iBBuJWE9dY81InROGpww=;
        b=lonjZS7TI7qN6h3pQeZ6L948Ke4Eg4+E1kLhNp9X6EfwPkP8YPw/VAn3Ravs00Hpy7
         qEP853CyImahRxoHRZwf1ol6GVRZxGbHblHcLu72TVHqsrk6Wubvmp5dDRMkO2lJ9dag
         jlJZTCWnaInXCSUs8Ahans2lDkjvsdY5l/QFXxIA8gfLqhZopJMaFdKLyk5PxIPZUP5t
         bbBvXo1Jau49JhX/SASpI/ihY4fwGKvnTI5sOw0d/Sl+5wbK1VmP1FeUM1+VaO87YzUa
         54eTS6pcUS2/4JTc4OgvlZenhbCObCrYsiM8BO+PLBrr5+09kYWIuQEz4doOn/ULzu0f
         Bomg==
X-Forwarded-Encrypted: i=1; AJvYcCWF+/1KH5AKvZsoZjHRSVxdAPpG8dJRtIyFC+84sBFxMm9USr8qNngRLIhAivNMzfQ9Zdly@lists.linux.dev
X-Gm-Message-State: AOJu0YzJCv57w6WooLJw1Tju6IpU9GTXBbIM7XAQOrtH/4MM4VY4wr/4
	u1XKszjgUsfPis7612YFQT5wHAzRhx+51ObcLJUhjQOqSSxuBmLaQTRKXZP0jijFbb5Q9RsbTVH
	q+oXaNwdsTUBNwbc1ZWOyFb6fMG1dKpNhpDK1uSY5OlW7MEJZP2Xz+mWf85cAYcaaVc47q8iLc8
	5/mWtoII1pk3vderrqpKVWYG+WBo6Bzw==
X-Gm-Gg: AZuq6aLTBCMMr1BZ4HFBLXtzCv5iRMCPqUrD9Ec7guSSVY5b2flX1Iyr26K4WsxP9xS
	v07WA/N84RNayFsqC64SpY+HS87FthG6e0/FjcUfa0ugbNgg+1LTcB22b+7yNPIU9CN1eNFG2ZK
	GkGOanC0EAKPX5qYGGY2yfJSCkionqAJRKnPj2j6fvyHJHLEIwB2Ar3l9KbudHcALQZru4CbR75
	PXa00MGGZV0JTDcm3wm/TpaSDXk
X-Received: by 2002:a2e:bea2:0:b0:385:c42a:1d3e with SMTP id 38308e7fff4ca-386b4e88973mr11253411fa.7.1770389059048;
        Fri, 06 Feb 2026 06:44:19 -0800 (PST)
X-Received: by 2002:a2e:bea2:0:b0:385:c42a:1d3e with SMTP id
 38308e7fff4ca-386b4e88973mr11253331fa.7.1770389058587; Fri, 06 Feb 2026
 06:44:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260206050329.5834-1-lirongqing@baidu.com>
In-Reply-To: <20260206050329.5834-1-lirongqing@baidu.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 6 Feb 2026 09:44:06 -0500
X-Gm-Features: AZwV_QiwEVMyzvWyBCtQZI0sZudb8dQwxOIPEYdV-JF2rmqU19KlRPlAo3m6_D0
Message-ID: <CAK-6q+gW_a4NNsm7OAovoYy+QVNbqfv+9XR8GY7kp7Mv4vysMA@mail.gmail.com>
Subject: Re: [PATCH] dlm: use hlist_for_each_entry_srcu for SRCU protected lists
To: lirongqing <lirongqing@baidu.com>
Cc: David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7wIIX7vNiBmt3g8OHMrEq7lnjcKJFOftYiQ4LCuENiU_1770389059
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 6, 2026 at 12:19=E2=80=AFAM lirongqing <lirongqing@baidu.com> w=
rote:
>
> From: Li RongQing <lirongqing@baidu.com>
>
> The connection and node hash tables in DLM are protected by SRCU, but
> the code currently uses hlist_for_each_entry_rcu() for traversal.
> While this works functionally, it is semantically incorrect and triggers
> warnings when RCU lockdep debugging is enabled, as it expects regular
> RCU read-side critical sections.
>

I noticed this as well and came to the same conclusion that it doesn't
matter, but I do agree we should change that because the API can be
changed even in the non debug case.

So thanks for doing this...

Acked-by: Alexander Aring <aahringo@redhat.com>

- Alex


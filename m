Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE18189BAF
	for <gfs2@lists.linux.dev>; Fri, 17 Jan 2025 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737126691; cv=none; b=h4+BJDZn8u2jaPQmqiV0ad8F8H20XODbLmctTOfZPzoGxbQoJsC0uEndvR92ZF1ICqHYcLabCHCXVA+PUfmJMEONub4rg3lb9HQQUm6PzJ7f1i7UtCKgA0aeyZe6fseaUDCMU4NrLkGQkxLJ8OABMFc1zIxkNWgHqTuvqRuYXTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737126691; c=relaxed/simple;
	bh=MS9hKY8OsDaYDUlN5+u7couIRrbUd8Kqbk86l4W8oaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cdA/WLz9/Cb4nKzWZ0zJNdtUTyAB94Uu7mwzu9eUkGvpNyfFJm2jG/Ij5OlM6LKwoHK8m+qEbbD6aqC87qAlaQAsuQVuT8Vcmf7ugkzRgGLZ/jyE53qriyGckrxqgTfP4F0OFck8KezorNtF8KxBWRsOKwZfD/YlNXZvf3bBDsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yyxn5y7D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yyxn5y7D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737126688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MS9hKY8OsDaYDUlN5+u7couIRrbUd8Kqbk86l4W8oaQ=;
	b=Yyxn5y7D/hUgrqD0uV15fdu+JNxgVNRiy3JdSdmOtLxOhdTQjCxczG78f3/t2X+QvcE9xr
	vgGdmQj8/cV32pwxG7oNDdM3MnCW1rpU17dJf+0RRFh3oZfaHCZG/zYrTuVJB7y3mVrlpc
	DOsBm4Nnh844CaND2uP/zUlOAwdKIPQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-I2VurPepOKKz32yeTQG2rQ-1; Fri, 17 Jan 2025 10:11:24 -0500
X-MC-Unique: I2VurPepOKKz32yeTQG2rQ-1
X-Mimecast-MFC-AGG-ID: I2VurPepOKKz32yeTQG2rQ
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-30033ad0158so14503041fa.0
        for <gfs2@lists.linux.dev>; Fri, 17 Jan 2025 07:11:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737126683; x=1737731483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MS9hKY8OsDaYDUlN5+u7couIRrbUd8Kqbk86l4W8oaQ=;
        b=iFy4lcUwiSsZt5NCIrcJGIV4zlKCmDR6bbiD1HRAjAQxorPbddqK3nc+1ppTTy9tMs
         uhwNuo48AQnH4i6lwv1warcFfEXNGQwqjuIW6K29ZR/U+HzRZzW06DEG+oXT7WrBh6dY
         uROfG6Elt4WFZyGDQ6h2QJx3RXG+rCzX/s5JysDYZ52iwyNvX8bM9pG+xtdS1r54qlqR
         0WiJTSk/HK5+MBNCSOY6QAmHZfY2cql5hiUCw25b6PfQWVJ8dti3nz6X1egRSe90Xym0
         a3KqNvC4Ur1BP+BAO7d/wzZADhdLcWTHtsPZx7Rek5P2rqlfatVVCs8D6z4n2wUx3XJC
         1rtg==
X-Forwarded-Encrypted: i=1; AJvYcCWsThaYpZRlHljeA3M9ppLwiQwNUw4BYE/MY3WRT6ZmysZ/r15yaGDQdr2rcEgbD31jH5mO@lists.linux.dev
X-Gm-Message-State: AOJu0YxdBD4GbVt2C7nWvaxNFEONJy9tDH1CvCmjKpMI1jlx2Slvsghx
	aGQapQl8xl1v+08o23quv3QeMwfqL2FOkMajfF0V6AXPneSTi+E+Xshtg+IBVGMgkNma7GZrikP
	QjtyvMNXIIZ94EvgZxgsOBspL4FJ9ERfVlG9hanbBP+xDRjHmqIIhnQaU6gfA2eOl7B+65OePcd
	NDXrSYiKtt4zfZLAM5CEwMatrzIA==
X-Gm-Gg: ASbGncvT8hDEjnXo7/P/WFyIC8zklRb9Y4sudSxJ/u+2wLoFr/yVDO94+oDKY3NM3Ze
	g+wQWWPAY8EmQ/VmF8EpAT36Rftcem5pJYIuqdsAsLdEcDjDn1dfzX9UdPepV+e0QQgRPN0o=
X-Received: by 2002:a05:651c:10ab:b0:300:330d:a5c3 with SMTP id 38308e7fff4ca-3072ca6928cmr10524431fa.9.1737126683229;
        Fri, 17 Jan 2025 07:11:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfp96d4RxGOuDmhnZT3RjLauK/KGU6KkQND8Y5WL/0ex8TK3ZT4Oj3j42J4AvS7pUOwAZRAvbpdbQO1Kwi+Xw=
X-Received: by 2002:a05:651c:10ab:b0:300:330d:a5c3 with SMTP id
 38308e7fff4ca-3072ca6928cmr10524321fa.9.1737126682862; Fri, 17 Jan 2025
 07:11:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241224084241.13563-1-heming.zhao@suse.com> <20241224084241.13563-2-heming.zhao@suse.com>
 <CAK-6q+gbGg9rQKuKkpLyURN_nY1N+k87YPj1e8HqL_zTy0GgUw@mail.gmail.com>
 <efad042e-6035-4045-b4e8-7798055945a1@suse.com> <CAK-6q+g0YP+40yQ=8KVOSCcknCRmmn6-LfuvseDW1i4uFDqw5Q@mail.gmail.com>
 <f6062ed5-51aa-4c56-a211-87183e6eb853@suse.com> <CAK-6q+jRn+fXdby1tCQSoayO4HfpKKQkfUOH6SGJ75ujbNn1ug@mail.gmail.com>
 <6e96fe53-869a-40b4-8c28-f7568f2987d5@suse.com> <aaec163a-fadf-4c7d-a193-9b0eb97d584b@redhat.com>
 <55a997d3-df7b-4ead-8ddd-d4819ca95cf0@suse.com>
In-Reply-To: <55a997d3-df7b-4ead-8ddd-d4819ca95cf0@suse.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 17 Jan 2025 10:11:11 -0500
X-Gm-Features: AbW1kvbBJ-9drLMfO1JSBW6pFFx_kFlhog6SDsY7CxPyM9fautmpgS_eS5gogys
Message-ID: <CAK-6q+grrJ5K7FTRnyFatZLTq726s5Y_S8CoKXWywedUTzp3rQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] dlm_controld: support corosync3/knet multi-link
To: Heming Zhao <heming.zhao@suse.com>
Cc: christine caulfield <ccaulfie@redhat.com>, teigland@redhat.com, jfriesse@redhat.com, 
	nicholas.yang@suse.com, glass.su@suse.com, gfs2@lists.linux.dev, 
	Roger Zhou <ZZhou@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iSTDAmudG8PxZiqxjI-AJvuSFrgQBfqzWuxf741Fn18_1737126683
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 12, 2025 at 10:13=E2=80=AFPM Heming Zhao <heming.zhao@suse.com>=
 wrote:
...
>
> The current dlm code design doesn't allow reconfiguring the network
> protocol on the fly. In the above scenario, the dlm will maintain the
> TCP connection until the next dlm_deamon restart.
>
> In my view, it's not essential for dlm to follow the knet dynamically
> multi-link style. if the user hasn't set the 'protocol' item in
> dlm.conf, (with my patch, for knet env), dlm will detect the corosync
> nodelist on startup, and set the appropriate protocol mode.
>
> If the user want to keep maintain a multi-link for dlm, they should
> set protocl item in dlm.conf.
>
> On the other hand, if dlm needs to dynamically change the number of
> links during runtime, it should always use the SCTP protocol.

to move on here, I would at first apply/ack the patches for the static
maximum address increase.

I see no problems to do that as this is required by you.

For the automatic protocol detection and corosync3, at least I need to
doing some tests as I have currently 0 ideas how corosync informs the
users about new/removed links during runtime.

- Alex


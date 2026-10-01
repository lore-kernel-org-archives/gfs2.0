Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7658D3BF67A
	for <gfs2@lists.linux.dev>; Thu,  1 Oct 2026 23:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790898256; cv=none; b=hCsiv3WQPTTFeVnPXYwmhMuErNrCEulofGY3nvdu0OMG83Kase5udBz1fpSrjducKKVAWaF2/iwwiuyfrsWhImLATdsYyKPr2pO9rBit0Y7EPvGps3Zv1KePV7F7Gykw9aNOOgP9lT7yl/l6Bgbu8TnHJfRU1gwmXBdMZghPBjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790898256; c=relaxed/simple;
	bh=o2g104Wfo69c4modhI8ohmf9z/HmP117IrUmXcvK64w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kd33mh28TW9DOWgqHv4lFxs9XcmnVZIDoaP/QzmRs5Y80XRQyfL1J2fQhUgjyxgjbLfWTl3VTKZ7MmHkQOG5ym0z5peH7mTV34l/P7rX/QG6tF2UkWSCvJ2MFDeztmB2LJT1KQqNhis1MZcbrWIkTFShIQZqzM8IFa9weKXs/xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YJo2CXMy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJo2CXMy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790898253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7C0wO41olnFgIkFyxcI/7Fxg3q/LgyAQWGzA9515Wqo=;
	b=YJo2CXMySVAfdUwdP+daGj7wmYg7TIoAJGpc12rzGbWnzr6XeoecRrhcYucUhP0XBUfF9M
	tryRZGqW6YPJfRQtgQdkAvWo9HaIijGnUigUbWbeJkMIphOI4FWZpYPmoBBZfnE1MQR/CI
	XCaExTGEJ1cQFbRR8OQNuiUzjmH2tS4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-yimkTL7IN4a9c7X2qt940g-1; Thu, 01 Oct 2026 19:44:12 -0400
X-MC-Unique: yimkTL7IN4a9c7X2qt940g-1
X-Mimecast-MFC-AGG-ID: yimkTL7IN4a9c7X2qt940g_1790898251
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-3a64e917254so43683751fa.2
        for <gfs2@lists.linux.dev>; Thu, 01 Oct 2026 16:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790898250; x=1791503050;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7C0wO41olnFgIkFyxcI/7Fxg3q/LgyAQWGzA9515Wqo=;
        b=rqi1pyShuhCT+YKAQaX9nAPZlbqjQn0tj0znX8LK3SQKRBqwlXlLmV8ScB23lzPoOE
         B2ZfleIdnmhn8Ku+k5YFRLZ7ATj/Mp9sQJ6fQ26hDOvhufIBacg5qNj3WbeGQakt0AsK
         2dNFWfSLrqCBRNMngCRsGKO2/vZcojDAdSfneXbyEn6Qi/9qrqXfGK64oGvL7+t89Tqb
         D2CSEXjvR45pMpLaQZUNkAo2MFs9N7P3vkmuAED1biA67sDJZnb3OFMNy0aJFDl2cXFL
         2+WCTTD5224P4p25Xd3zgqcGHEko6WwrxXzprR1KyF+Kal5TP0l5yPvqb/OXkkWzBbYx
         +wFg==
X-Gm-Message-State: AFq9FYKoo+3M2rSdk89EoacocuHY/fGQY5n5BGdYHJwolaiKypKI84L7
	XbQQez5gPbkN/Guq3OjUTBQ8jFvKsy4l6+NLVSuQIbs15oTU3OXVOiMlM7wUumiPMz+D1Ce25NL
	/Vaq8263olHSFeVaYmDyX2IVEPfmxpHaq+6Q22VwhoA/jZ035xKt7sa6P7jmGTld0FibyZRh/9h
	Z3CzCaBS/2mT0/C0gKSDv16Bt22gb/fA==
X-Gm-Gg: AYBFou3b/ZLZNZFZoGz6rIqC/EdgXgE2Lqxy1dzQlk8GwHqya2scGKSk66s+h+1uOhy
	4zSR7cu3S1XK2ZqtI55rQk0JP4eeaWhZyj+4ytZeE8coNxtQlt4SPEDd/0Bo36ziFSLSHpl7AhA
	365Y7I0di7exoLo+xM81gB9QCxBr5i+kKGNAJ0eawXXUz3dn/4GwJK28iS
X-Received: by 2002:a2e:bc29:0:b0:3a5:d070:9fef with SMTP id 38308e7fff4ca-3a887787567mr1692561fa.10.1790898250538;
        Thu, 01 Oct 2026 16:44:10 -0700 (PDT)
X-Received: by 2002:a2e:bc29:0:b0:3a5:d070:9fef with SMTP id
 38308e7fff4ca-3a887787567mr1692511fa.10.1790898250148; Thu, 01 Oct 2026
 16:44:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260911065357.3511466-1-ljp1205831794@gmail.com>
In-Reply-To: <20260911065357.3511466-1-ljp1205831794@gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 1 Oct 2026 19:43:59 -0400
X-Gm-Features: AclHuK8B2IlGXv-cagMI52YwLUQveVZTRqqkPPRuJDKafJ4tVysX2bs9w7uZ4e4
Message-ID: <CAK-6q+iB2jjvKN+p5WmMap3znWPUhXXT0dRsCFK5BcAXBJRRuA@mail.gmail.com>
Subject: Re: [PATCH] dlm: fix RCOM_LOOKUP length underflow
To: Aohan Mei <ljp1205831794@gmail.com>
Cc: gfs2@lists.linux.dev, teigland@redhat.com, linux-kernel@vger.kernel.org, 
	Aohan Mei <henrymei@tencent.com>, TencentOS Corvus AI <corvus@tencent.com>, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZbOsJDHqxtIDXDd4fZuGRqdcObZx_Ma3PpaCgGxt-Q8_1790898251
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 11, 2026 at 2:54=E2=80=AFAM Aohan Mei <ljp1205831794@gmail.com>=
 wrote:
>
> From: Aohan Mei <henrymei@tencent.com>
>
> receive_rcom_lookup() derives the resource name length from the
> peer-supplied 16-bit h_length header field:
>
>     int len =3D le16_to_cpu(rc_in->rc_header.h_length) -
>               sizeof(struct dlm_rcom);
>
> The 3.1 receive path only bounds h_length to the range
> [sizeof(struct dlm_header), DLM_MAX_SOCKET_BUFSIZE] in
> dlm_validate_incoming_buffer(), and the RCOM case in
> dlm_midcomms_receive_buffer_3_1() performs no further length check
> despite its "length already checked" comment.  A peer can therefore
> send an RCOM_LOOKUP message whose h_length is smaller than
> sizeof(struct dlm_rcom) (48).  The subtraction is evaluated in size_t
> arithmetic and wraps, and the result is assigned to an int as a
> negative value.
>
> Both consumers of that length only guard the upper bound
> (len > DLM_RESNAME_MAXLEN), which a negative len passes as a signed
> comparison:
>
> - with rc_id =3D=3D 0xffffffff, len reaches dlm_dump_rsb_name() ->
>   dlm_search_rsb_tree(), where memcpy() converts it to a huge size_t
>   and overflows the on-stack 64-byte key buffer;

This case is already covered in dlm/next. [0]

> - otherwise len reaches dlm_master_lookup() -> _dlm_master_lookup(),
>   where jhash() converts it to a huge u32 and reads out of bounds.
>

This case is partially covered but lacks a check for negative values.
Can you send a patch to change it to unsigned int? [1]

- Alex

[0] https://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git/=
tree/fs/dlm/lock.c?h=3Dnext#n632
[1] https://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git/=
tree/fs/dlm/lock.c?h=3Dnext#n1273


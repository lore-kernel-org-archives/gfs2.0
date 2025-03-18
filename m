Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D577620CCD0
	for <gfs2@lists.linux.dev>; Tue, 18 Mar 2025 13:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742305353; cv=none; b=GVRjWiw9Z0cwWSf5kbmV055MN5rios5L6scjzjSDSSh6v6fs23QVSkmZo8JTyGnZSeZmfJW/dAMPpxkSXYaQbQusHcD1sn8NSplAn5S/XhehQL/AasoT6/59Y8FTz4Oq+2xsF4z1YD3JlHW6lAct96T/MFxjXDguivqmKjnSj9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742305353; c=relaxed/simple;
	bh=ay8Hgjrh377GIRayuMXZFYemVF7BlsIH3HnyWLgdr5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nHbKLkwai7J1VVzF1SnVz/75NlrVol97MfvFH/+sVoF2EOT+fDWTICuo5QtKfw8SjOQBEJgXHenR3MiYclNkIEt490hBeV8VwkVNFyfUNxiQnnI+fNAFActbzkBhLsTaBXTvzUoYatTjMkXtRv4J2WThsZj1sAvdqLe8odzSHTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E0+V8uCV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E0+V8uCV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742305346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ay8Hgjrh377GIRayuMXZFYemVF7BlsIH3HnyWLgdr5s=;
	b=E0+V8uCVO9v1MQZnIKpQMKFcvFB2Rtl7WN66bJU+JPKGeRfGF8ejMUff4YQzQYvjRKmzH2
	qmE0J8kvgtnFeYGd+HgEGaLOzD5oWBIVyy5lnNcIp2QjqHZV8K3DWOC2ncnEV6o7aCAMp6
	kXkJYPLFh1QbLbuHQamIR8nHtDrkiIY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-Sy58ZlctOI65LWBx0EymAQ-1; Tue, 18 Mar 2025 09:42:25 -0400
X-MC-Unique: Sy58ZlctOI65LWBx0EymAQ-1
X-Mimecast-MFC-AGG-ID: Sy58ZlctOI65LWBx0EymAQ_1742305344
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-30bf960c505so28814381fa.1
        for <gfs2@lists.linux.dev>; Tue, 18 Mar 2025 06:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742305343; x=1742910143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ay8Hgjrh377GIRayuMXZFYemVF7BlsIH3HnyWLgdr5s=;
        b=fENrwmIqmef0T+zyf4JSCp6lO9sDBBSVWZqLYAuZgiQ66bkcdnh7ZZV2pIUtOaCC1t
         eWukVbS+1rllH6tQ2Rcb+kfJGFHHxAC9TfPE/DnrzTROyUBuX935zfM/wSOV4LnYhKmH
         kUdelNbZZ7pKTj6pQWhRUvzwMpnMRiYMBCwRMg7VZwJUMuSjZYjk3GvLrvAjb0kOs+EU
         bI7g5flUFqJpVq/gdAm+gxzpuprYOzhB1Ym7EOpaKcNiwmdB/dkCM0xrF1yBnWR9dil8
         LNeojbh56ER6Q0awlQWk+DlIG9oX6G9A9/8CqbHR7CRZ6XbOK3dQF0/S70XjGqoPXFSf
         czXA==
X-Forwarded-Encrypted: i=1; AJvYcCU2orV3KhxQ50YoGwCN0eSjsAIzlG9ClZmgMNhPeSJx8k5NlZI1DnwDtliGYFTlW05Vv6Qp@lists.linux.dev
X-Gm-Message-State: AOJu0YzJqbo/PZ77EJJoQWFZvhhs2Nv4+E+293MEG0YYmkO9AzuPot04
	HwkKXbpdw0YTwLM5pBr20Hih7kR45MLI/JPjE3o/XBbaeNv+13k6PAgLK/Ww28hnqhx0C+AfZuh
	oQWufWsgONWSrCtSxFkPoLlXtdQSUsg+1jddiA5ydotfjaeepYomU7dIIrfWbM99zKbFerTPshk
	20Zxl8S/N3OrOc/qH+8OH2S7mi3DoWNj1iKKVO1ms=
X-Gm-Gg: ASbGncvyKPXzm8HZDTeSjr69Go8GvzAPBB89XeRY4TB0s015s1moMZSOtMo9O5qaa0P
	zoutdpS2zeURCUHM6YD5RzNY4sl30aN/XhregFo6pjyPwmZ0C4qObgx8+yT7BsnOi8bD4B9ZBmK
	brm/ua0PFfctFLsdNMHTFNl3xtUAGVrw==
X-Received: by 2002:a05:651c:1a0a:b0:30c:3f82:6844 with SMTP id 38308e7fff4ca-30c4a8f504amr104694891fa.34.1742305343577;
        Tue, 18 Mar 2025 06:42:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeGxsaGukmE6glqpZ+et9Xzhh/JW+5qPL66nx0BGcRjvtsiZtltnS1x/6uS8olsxjN+xCHuZDmUP79H/MKI3s=
X-Received: by 2002:a05:651c:1a0a:b0:30c:3f82:6844 with SMTP id
 38308e7fff4ca-30c4a8f504amr104694741fa.34.1742305343130; Tue, 18 Mar 2025
 06:42:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250310073623.18607-1-heming.zhao@suse.com> <ec8715e5-5a0c-414d-b58e-07852cc683b2@suse.com>
In-Reply-To: <ec8715e5-5a0c-414d-b58e-07852cc683b2@suse.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 18 Mar 2025 09:42:11 -0400
X-Gm-Features: AQ5f1JqGQeHRot-UFpcFmrmIPIuuxqax5-ObS1pekH32S6ywRx2l4kIBXWrgJ2A
Message-ID: <CAK-6q+gxFExe8fr_Y_+cSu3dEB_id8dhfJje0HH=YRskjC6-=Q@mail.gmail.com>
Subject: Re: [PATCH] dlm_controld: remove 'detect' mode from config item 'protocol'
To: Heming Zhao <heming.zhao@suse.com>
Cc: teigland@redhat.com, gfs2@lists.linux.dev, glass.su@suse.com, 
	zzhou@suse.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s8N40UtxjLW0ZPS-1qyF5h9zZMWOAsb7hIZmsSb0gIc_1742305344
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Heming,

On Tue, Mar 18, 2025 at 3:35=E2=80=AFAM Heming Zhao <heming.zhao@suse.com> =
wrote:
>
> ping...
>

sorry, I applied this patch to dlm user space upstream. [0]

- Alex

[0] https://pagure.io/dlm/commits/main


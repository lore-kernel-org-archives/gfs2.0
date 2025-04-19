Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AB01A5B93
	for <gfs2@lists.linux.dev>; Sat, 19 Apr 2025 19:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745089437; cv=none; b=Sjw0R6XmCyJoeWrjmQUNuLrVOhjCsIYIwJ3lvl06YC0wV32/h1v1I2sK/7/OC0NOpPgUxpb1f3XHmrwc3M5ybCFcNwWd3KpCFQGMBpDFAtDhYqSOCUpx2fAuwcOInYBCFBnbqLZferotGfg+Jmb+Hq4Z0JtZR18tScy0CR/EWFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745089437; c=relaxed/simple;
	bh=gQfoRlMU+Df3jZULZuiryeWimEQgD4okILMNicR4sDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g8DBHtL+eUc4/Zon4Bq5WI7AEuoft//DdHGu3kvz5GGPRysatjPjLNadNCnIiIEWGVkcMbPBAJFW8vufL702Fe686og1qRtZokEiK4tl4bNJktiRK6tkK1qRpT5nxKTdkTQN770/OK8ShyZMYhx4h+RRU72gIHJCaYAPoqq4ed8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZF1N2Z+a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZF1N2Z+a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745089433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gQfoRlMU+Df3jZULZuiryeWimEQgD4okILMNicR4sDo=;
	b=ZF1N2Z+a8LzlxmIR92OCtDXeojQrwkSuh0jg0iSyB4N4vPafSyfk/fVWW6EQEGNtUE45Gr
	KtE5uodVtV8dfC6M6MXDJEWVOnj7kX84Bp3crffN4ABcEhMajC6tRAUP7B5vpg7HrdsVZz
	nh+JJan50aepqnTv+4wQX3+hpruFA2s=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-v5uJLBGBNr-h6BfF-YA2Ww-1; Sat, 19 Apr 2025 15:03:52 -0400
X-MC-Unique: v5uJLBGBNr-h6BfF-YA2Ww-1
X-Mimecast-MFC-AGG-ID: v5uJLBGBNr-h6BfF-YA2Ww_1745089431
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2254bdd4982so43450225ad.1
        for <gfs2@lists.linux.dev>; Sat, 19 Apr 2025 12:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745089431; x=1745694231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQfoRlMU+Df3jZULZuiryeWimEQgD4okILMNicR4sDo=;
        b=lPr8yjbDZKO966sFs6Mzr7VFlP9NOy1/w5eBSbBQqKT5V1Uc1s4OpnHR0SezTc1Ouj
         1JMCRdHik8F81p6otDyPS3noFu3Y274XY659NN5qCKBqY1tC2xIdEuAmGuWN2huZKQQ5
         ZwNuCGC/pdFE/+jf+QC0+qQGv1UbIQCFDflkr4mcgj0HASrg+6e+AdS2qGQdr5qQ349T
         8qtcU6VjR9nYMsK+TL9tNOkm2x/i+3VTJEK/gW9pztW5jdg7lwUPRSzNzstIH4blv/c6
         SsimnWj4JxwsawU4WQCvPjik6QhcbQpj6Oc5xtA975v0L3d0HQ2XFMEm70vc1S+0kFtb
         Cc1g==
X-Gm-Message-State: AOJu0Ywt33Fawsk4oow4fkIGh/OUMVaGfpMGBLjObjQJ0sgSuYTo56Pc
	q176BUDWxuL5Q1adaNMZF05tLgzw5gXL0Iw4LTNKLE2kIkDM3vzvL5rMOpDhtqYeaCdHSuA/j6y
	rKOJblSEoWi1EGzxNSyF6CbFwdAP5C94TIuXVxHmDwHKcAT2p9+E1+N4QgJ9ZiZDUMPY+315JB3
	/9gzVJNbJbOUpQbViSvRt6w+JEaA==
X-Gm-Gg: ASbGncuZnAOu02JijrGTLawdBYjYe6ChO3Kri6Hc10I2VV6ks5x6dSrZHX3iUbwj/e4
	OFBynZWr7JtEwI8hxl4GYlusPc7ptmOlSiGwng9OqpKSmEFODEbHwrR2740M3hCh0Lp4=
X-Received: by 2002:a17:903:3c6f:b0:216:644f:bc0e with SMTP id d9443c01a7336-22c535c9db1mr112462305ad.24.1745089430903;
        Sat, 19 Apr 2025 12:03:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYOHQmSctOr6jM5nXIex6dgUr+moXOSuS6DqPsFpZks3IilYZAEc/WBGmExfdeTa+VSuYroYS2cg5fqrON8jU=
X-Received: by 2002:a17:903:3c6f:b0:216:644f:bc0e with SMTP id
 d9443c01a7336-22c535c9db1mr112462155ad.24.1745089430635; Sat, 19 Apr 2025
 12:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250419065335.211252-1-wdhh6@aliyun.com>
In-Reply-To: <20250419065335.211252-1-wdhh6@aliyun.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sat, 19 Apr 2025 21:03:38 +0200
X-Gm-Features: ATxdqUEp6lJ3UULIBfICLsR5UZTdJGKnBXk0F-b-9tVbspGGjg1dKQofqV0Nl9c
Message-ID: <CAHc6FU7rJ4uh5mL-LGNUT1EtTK8BKmrh+S+Gq-dqwVjoviQWxA@mail.gmail.com>
Subject: Re: [PATCH] fs:gfs:glock: Delete the invalid pointer insert_pt in add_to_queue()
To: Chaohai Chen <wdhh6@aliyun.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hB2D_TU09DO8SB51ZbEmo4Tqti2QNtlIooLZ6cffBTo_1745089431
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Apr 19, 2025 at 8:54=E2=80=AFAM Chaohai Chen <wdhh6@aliyun.com> wro=
te:
> The point insert_pt is always NULL, no one will change it, delete the cod=
e
> and useless logic about it.

the code in question has already been removed in commit 0360faca5d4d
("gfs2: Remove more dead code in add_to_queue").

Please always check the for-next branch of
git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
before sending patches. In this case though, the fix has even been
merged into mainline already.

Thanks,
Andreas


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B08240225
	for <gfs2@lists.linux.dev>; Mon, 13 Jan 2025 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782912; cv=none; b=s3rutAkXcrn3RHvE9/WiRlB7fYUteBUCQNG+aKBMV4g97gbCAOfkn5rrPZGSz1WBsWQ50Q6BhaWaRINAI79eItDY17LVWEQVP5THHojxj139W5xIEZTVx8IYpjQW5mu3s/ZQElXaI0tTcqbDvMZJzLPgNWIB4U9DpB9d98bVC9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782912; c=relaxed/simple;
	bh=gYg7v2wBLlHvxcDn7o6TkmSFMBdkJ3utWV5WpaEbvQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5x6TdzDCzwve+NyeXzHuf+HTyy/eVCy3sieMs3fRBMtxoC2ZpyajvMgKNUxzR1y/pVxA7GGvOa0MAb/deJYB2lp0o4c+RcNwC5AfchTtNacQ/LY6u/OKoMAzlFkOP63rcDGvo8cIt5cAA91qF6cByTPk6gMXHnKa1mdZ64uGnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RtPTfkBK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RtPTfkBK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736782910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gYg7v2wBLlHvxcDn7o6TkmSFMBdkJ3utWV5WpaEbvQs=;
	b=RtPTfkBKV+FIU2mXqHYdBKfi62qlVTM4oNI9GFiA6gdH2xScf0ko+ApASGX8pyt6esgHUR
	ZbfFmBF1P/ysiVHXnZtbcO9kNAeFCPRXQ2F2l32A003cQsI9eufiabKoSoaO7uHlQp1nG4
	J+cbi+QNSLF2QaI5XRQFyC1ZsSFaacU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-ZTbLXlxpOmSNxQIlz1tLDA-1; Mon, 13 Jan 2025 10:41:49 -0500
X-MC-Unique: ZTbLXlxpOmSNxQIlz1tLDA-1
X-Mimecast-MFC-AGG-ID: ZTbLXlxpOmSNxQIlz1tLDA
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-216728b170cso83177765ad.2
        for <gfs2@lists.linux.dev>; Mon, 13 Jan 2025 07:41:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736782908; x=1737387708;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gYg7v2wBLlHvxcDn7o6TkmSFMBdkJ3utWV5WpaEbvQs=;
        b=BvEa0wMXQ+Z/ojmC+PzhElSUCTv6Ed7leNd7fF0DGSlz0BPyZhO+Czb1UTvjSbUVo9
         Id6i1UuLlGufosqQNpTaKVrNHs1TMbXkiFNl3tW2/e1iX30b5DbqsUFNc+WQfcFuxiyS
         7QlRYvf8NfA2pgwIE3mSJTz7n+LXVbQPzwB12Mxw57G/5+w1RfFGqWLdWNLdQSnF+yTM
         tqKxuBRny+wphUIFwX3E+I0frGKRZBiLrsM2+3m7cEoiLyu5UHCcCzeNze5Lkppf+sHT
         3aGWpbqiqP5egKl4wyvi8d6OqJ+PcG+uvB9eTsFn/mEuKK0cHNldwnt1MbcAKALrAMwT
         zDow==
X-Forwarded-Encrypted: i=1; AJvYcCVJ1kMmpaNQ70Zx2KXkRk52Hy2xEI4SiJrpDmLtSkIdYM86aqvkbhJUvgtSx8c3tjH+XJS1@lists.linux.dev
X-Gm-Message-State: AOJu0YxmafVgLCu+/46AdEsi0OP4+9fP+0JuQ5o2KcEcH3SiMldZcnuU
	JANHV6xvcw6mtnMKy4KG7BsqrrP/rBbF4bLUw8RNg1xZ4eoucQ7v0/5V9hm2nEIUNPN1Ajm49fI
	uuzSChXVgfM2/1HdecnI9Pnu9JK1XnpCewCzB/iF7vvdYlTL7m2kmcYNBQr3R6b1pEfYKuef13P
	IwzaOAUkSHnTBoxfFWrdwOQURrvw==
X-Gm-Gg: ASbGncsRyA/xXOScHU0TsHKVWSdPL0ahZ1eF1pXIu8pAsqTh4m3CC3uQ+7XPD+qR3pz
	gK2vtIeN5WOKE3bRmBY6ohFqh8twMi/O1XQTU
X-Received: by 2002:a17:902:dac6:b0:215:b058:289c with SMTP id d9443c01a7336-21a83f339f2mr301613385ad.8.1736782908167;
        Mon, 13 Jan 2025 07:41:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZ/Z5o9hGA5nCeYoJCsyh8QaRo/h/BrqoQ80/+eLg/gXfDpGr/wo5b7xjgaelY6+5vLVTddk3Z9C1Ag9z4SMk=
X-Received: by 2002:a17:902:dac6:b0:215:b058:289c with SMTP id
 d9443c01a7336-21a83f339f2mr301613125ad.8.1736782907907; Mon, 13 Jan 2025
 07:41:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <F0E0E5DD-572E-4F05-8016-46D36682C8BB@m.fudan.edu.cn>
 <brheoinx2gsmonf6uxobqicuxnqpxnsum26c3hcuroztmccl3m@lnmielvfe4v7>
 <5757218E-52F8-49C7-95F1-9051EB51A2F3@m.fudan.edu.cn> <6yd5s7fxnr7wtmluqa667lok54sphgtg4eppubntulelwidvca@ffyohkeovnyn>
 <31A10938-C36E-40A2-8A1D-180BD95528DD@m.fudan.edu.cn> <xqx6qkwti3ouotgkq5teay3adsja37ypjinrhur4m3wzagf5ia@ippcgcsvem5b>
 <86F5589E-BC3A-49E5-824F-0E840F75F46D@m.fudan.edu.cn>
In-Reply-To: <86F5589E-BC3A-49E5-824F-0E840F75F46D@m.fudan.edu.cn>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 13 Jan 2025 16:41:36 +0100
X-Gm-Features: AbW1kvZme8_fiRYjqU8QPQBZD6KR6UiY7TzmRpAKFob7Q2UrgMDwN0Cf7_ov7-0
Message-ID: <CAHc6FU5YgChLiiUtEmS8pJGHUUhHAK3eYrrGd+FaNMDLti786g@mail.gmail.com>
Subject: Re: Bug: slab-out-of-bounds Write in __bh_read
To: Jan Kara <jack@suse.cz>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>, gfs2@lists.linux.dev, 
	Kun Hu <huk23@m.fudan.edu.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dJh6Ohh2intFTloqQ7YF5MR3pT2tBT6UNVE1toc4l2M_1736782908
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

Hi Jan,

Am Fr., 10. Jan. 2025 um 18:18 Uhr schrieb Kun Hu <huk23@m.fudan.edu.cn>:
> > Thanks. Based on the crash report and the reproducer it indeed looks like
> > some mixing of iomap_folio_state and buffer heads attached to a folio
> > (iomap_folio_state is attached there but we end up calling
> > __block_write_begin_int() which expects buffer heads there) in GFS2. GFS2
> > guys, care to have a look?
> >
>
> Thanks to Jan.
>
> Hi Andreas,
>
> It seems that iomap_write_begin is expected to handle I/O directly based on folio, rather than entering the buffer head path. Is it possible that GFS2 incorrectly passes data related to buffer head to iomap_write_begin?
>
> Could you please help us to check the exact cause of the issue?

32generated_program.c memory maps the filesystem image, mounts it, and
then modifies it through the memory map. It's those modifications that
cause gfs2 to crash, so the test case is invalid.

Is disabling CONFIG_BLK_DEV_WRITE_MOUNTED supposed to prevent that? If
so, then it doesn't seem to be working.

Thanks,
Andreas


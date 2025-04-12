Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D12D2367DB
	for <gfs2@lists.linux.dev>; Sat, 12 Apr 2025 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744475853; cv=none; b=jNpRSg/b5C5Fl+tlQ7r9Psy3lBOEiqYTm7sPTA4GensqdLu6SOroKVCF682u4zxonejZp9gTFnJOF54dXn73V3dtXopkhZXuQW5+NJ9k+60Ww99g1cMmeKLunt/a8DjQ6AaahbN8Fg7uhPQCLAW449+1yi3RERxuRv40FKjinMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744475853; c=relaxed/simple;
	bh=3nlQeqLpakx9VbjVGGaVN/AwOVYMXPCNfTYZtnneuv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ohUqdSrUmtWi/gZIDyyEDjFBfDvlOL5Mm9DRGkFd1W2D1lF+ZXDgW3xUhoaViKsmjDIDFWJmwTiimyvo4kBKisQA215JJSLFR72yaqkdhdl4sLfWN2MecxTIciEk596rBLHMaK2kQ+aMErILFspw37bYQ4wkOkxQRv7Rc46X0Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aX3122rf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aX3122rf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744475849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a3fiFsru6LnJQq9k1qZHmlYdUChXvApej+AwnAQ3uLE=;
	b=aX3122rf5Uz+6gn7UqJCx2yLvSIfwJD3aXAB6X+WhTv35HwlEujgSabicKc+4wRIEm0boK
	D6q3653+tct+KdYBMDnzDoPc/oEqwYRo5CvlcrQK1ilUeZzxdjeywz4YPWLZA+0zC1Sfhk
	z+94tljK5dwI54PKt9S5p3omAyM7HMY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-TTQTo1SgN2mmY0eEZD5HNA-1; Sat, 12 Apr 2025 12:37:28 -0400
X-MC-Unique: TTQTo1SgN2mmY0eEZD5HNA-1
X-Mimecast-MFC-AGG-ID: TTQTo1SgN2mmY0eEZD5HNA_1744475848
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-224347aef79so39207095ad.2
        for <gfs2@lists.linux.dev>; Sat, 12 Apr 2025 09:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744475847; x=1745080647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3fiFsru6LnJQq9k1qZHmlYdUChXvApej+AwnAQ3uLE=;
        b=kpi5ur0wMKpuZp8oNpzLHySzr/uS7Svr2vk+bjY7ikvm+rxQ/coE+j2JD6tVeC/usF
         NUaiyo7fdjIlTKlkKhidYfs5TCe82lkCB90ZYLdDXlVC2/KYkaF9KD0ntmh+1PkPBTHh
         /giWRuApkYpV2vqKUrRfLj2KMqDt70zO5mIn7TPDSYHYt/vzNcDjDYF5zBFSnzvYb171
         IW5c9AzWVygdXX7FyN18kphkRN/XfZXsoynNe0KNJ0kJoaqBZEllr6phlpRAj06UEtfC
         2YIPs1EiSZxlHDr580TWEnR0RMre9rTmtKs+1FNweOh9SlSNqmUBvAD4fbW+UxXFNYjf
         aSJg==
X-Forwarded-Encrypted: i=1; AJvYcCXTa76oJNKwZogj5xf+3E7wZXlNCU2iCqueYjmORIDGUlwwPW46XLV4pV1cN1/Gq1erAW6X@lists.linux.dev
X-Gm-Message-State: AOJu0YzQKTrPxE2q7audS4e95bwksVpKqp3yQu6VLpshoESo+U23uRy8
	4ObP6PSJU7CUYXuEPCfO7wl2mRIOguULWu6uSiowS93phk7PqWqAn6LKTjP/OFXvpQfbmoLNiDq
	Z6eJfyvGvDjH99PUkHKfCUK5MCE++N0ARKOOJTX+xfUGRiSnZpbridI+xWojEvRBYVsyTJR9Vwg
	XwH1cdxLbt4ZaGX84Sim+7cgb3hk/KQ0xXAq1H
X-Gm-Gg: ASbGncvnvWrkAYqcEgUH/ieEhhabU4lSpgaBv+r+1oz20H3DUU64ZZfVVlg5+htyuvw
	0PZMbefq3SIKUrajb69dy6MiPZHvvL3b96SEt0HxsIONvnvZj2oaSuQVkQjQOSlKmjTc=
X-Received: by 2002:a17:903:17c5:b0:223:5ca8:5ecb with SMTP id d9443c01a7336-22bea4efaaemr91129625ad.42.1744475846938;
        Sat, 12 Apr 2025 09:37:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7sLLGDrtrxmDABKermY+/WFSctIXR5dmHRBwVPDD2cHAaEfr8X4dND2BPeABs3RlvZSRMNQ6ofK7p0cF8CSo=
X-Received: by 2002:a17:903:17c5:b0:223:5ca8:5ecb with SMTP id
 d9443c01a7336-22bea4efaaemr91129475ad.42.1744475846684; Sat, 12 Apr 2025
 09:37:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250411173848.3755912-1-agruenba@redhat.com> <c9014d1e-c569-4a7a-aa68-d7c32e51d436@I-love.SAKURA.ne.jp>
In-Reply-To: <c9014d1e-c569-4a7a-aa68-d7c32e51d436@I-love.SAKURA.ne.jp>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sat, 12 Apr 2025 18:37:15 +0200
X-Gm-Features: ATxdqUEc6bK4RDS8nTPgD4dEmZc4tgzp1L5AosoT3RAQjOcAirWwydpqqoRpyIw
Message-ID: <CAHc6FU7XDXCE--4vtH+q94NBZK-ScYSLTmeY4+J9T9YH7BtR9Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Fix false warning in inode_to_wb
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: cgroups@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Rafael Aquini <aquini@redhat.com>, gfs2@lists.linux.dev, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HdzbcMip3xcJWYKckVGSH6qoaMeYCQ7TCe7ZIpopo7M_1744475848
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 12, 2025 at 4:21=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> Please add
>
>   Reported-by: syzbot+e14d6cd6ec241f507ba7@syzkaller.appspotmail.com
>   Closes: https://syzkaller.appspot.com/bug?extid=3De14d6cd6ec241f507ba7
>
> to both patches.

I'm quite reluctant to acknowledge syzbot for this. The bug has been
reported several times by several people, long before syzbot.

> Also,
>
>   -static inline struct bdi_writeback *inode_to_wb(const struct inode *in=
ode)
>   +static inline struct bdi_writeback *inode_to_wb(struct inode *inode)
>
> change is not needed.

Ah, not anymore, indeed.

Thanks,
Andreas


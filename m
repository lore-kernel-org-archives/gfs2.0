Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7182B2D8DD6
	for <gfs2@lists.linux.dev>; Thu,  4 Dec 2025 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764841025; cv=none; b=Y9HVoTNaBXfB8vbBl/Se5vCmLTi648GZEsXuBuqgDrjF+Gc4FlhuvI/HKidnkq2rzh2FFcHK7LdvA1pTyWDIYwcMjVLrcLa0khMa3iI5OIClEUb6l9+CRK/LUMPAQ34UI5qPJbzbWdMRxNypGcj+CKYL0T23VhI+AsWcTft0nGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764841025; c=relaxed/simple;
	bh=qeEjzVz7GQk6EpiDzPclRlc2LVPc/X5pecZGz9q1Q90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fL/EomNXC/ObKdbBwwJdgykERUznWrwxNti8ylAHVxSNfi5sNjZHEnMeqC4eefQg6vdtomPx62wSYMTp9bhsCc1hcDwAwq4dn3oR90jplEwUBzIN9X5c3tPXFMiqdTPzdgk3xQVz6YkiJc3NtVO2edpv107H6xaFCa9+ySy0yaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J9Xg1hNG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9Xg1hNG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764841022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qeEjzVz7GQk6EpiDzPclRlc2LVPc/X5pecZGz9q1Q90=;
	b=J9Xg1hNGgKJjP88Sx51OE4X/POL66noCRL4TOp8zfyt5r0S87yaYlEsZaFCXTn9d7HEudu
	p8V4h9zn+z9NvP99nwlzGjXejKldzFPtjXX2tCy+iphrOE7Zc2jFmAdt6NTxqCTzWi98m1
	cxkdLKadocpvq6QoQCkjbLAyCawE5kU=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-6OEsAn3AOuSXl2OMlBKMcg-1; Thu, 04 Dec 2025 04:37:01 -0500
X-MC-Unique: 6OEsAn3AOuSXl2OMlBKMcg-1
X-Mimecast-MFC-AGG-ID: 6OEsAn3AOuSXl2OMlBKMcg_1764841021
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-78a82709389so11098897b3.0
        for <gfs2@lists.linux.dev>; Thu, 04 Dec 2025 01:37:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764841021; x=1765445821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qeEjzVz7GQk6EpiDzPclRlc2LVPc/X5pecZGz9q1Q90=;
        b=uQ3UIDNmA8OSL7hezp27JiOVguljsKGWZ5nJKEJIZzUgA1g6gLyzd8niKG91vKoj5p
         9s2ue3IDS/VPZ0/o9gwtOHb90V8RKXxxr+d2UKR1/6UNshnnIWunCp+TaHH9E1DmwQQQ
         ko09f6Cm0FpHNcjfkW1taQyd/QAp0QsD58rzqdSdK9CbMDYZGPoBsKSEyc0ChCJ0TjIk
         M+Isdh1N/WwlOsW2F+P8yH1J9vsp1n+zVEdP5GKXFaQl4FjluSBdtoT80pt6qiO271Am
         8LROfj7Yvs9sBYCY7k+GqhZAA6Pe/hsShI80D7Q4Yc0Q8HpcITk807cHpFttafhGHaBt
         t6kA==
X-Forwarded-Encrypted: i=1; AJvYcCV2H8LSK9k+qNm0RtqF7K6SY3G7DIcfNqrIh8lGesqMbeY/ysIbJcoSHwhP6/PQm9SIL+n3@lists.linux.dev
X-Gm-Message-State: AOJu0YwWXQewArKwgrffuV2JHsNVgf0vb8uVn06MGwRsDuUicwuO9tr4
	UNy5HcBRa1M/IYofj4LN8qe5vuCS0XqVg/JcqxDoEhpfCrBwyeDVUf9eib7nShSZV2yZgG5rR+z
	g1BAeTFMLU7Ft6JPsSGJcuT7SVV838gXmd5P5ZEkc6knsO7z6uPf1IyLAX+kRwt6DTY2mLY1v3H
	5Jh9q4pV0qu1yPFIsze8GSgY/XfH/bbA==
X-Gm-Gg: ASbGncsxi8v4u6bJP2DUaRuX8xdQeXEx5OIhFmuav5Y7a8pVFSfo56fQczbKn1+c6j3
	lbSR/U9BluhyLCOEZJFFCas0MCrfT1kJK9yCkPrJMVqiMjT8H4tZCem+yO5Q/4U89DHwWvCVG5n
	P8ZZ/vTiEys77PTfpkobKZ952tXLnRX0iuAMgkES7WiJWoGsDiGGwKQ+SG0CsTWBb6
X-Received: by 2002:a05:690c:6713:b0:786:4fd5:e5de with SMTP id 00721157ae682-78c0c210028mr42666187b3.67.1764841021010;
        Thu, 04 Dec 2025 01:37:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBJRkWOGl554rCJxMS1W+VD+59CzpNDKchBFktxp0UKkP2qgdZoPND338wG5ha+uJ8PPPkfv0dwHOd25ifO9U=
X-Received: by 2002:a05:690c:6713:b0:786:4fd5:e5de with SMTP id
 00721157ae682-78c0c210028mr42666067b3.67.1764841020714; Thu, 04 Dec 2025
 01:37:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
 <20251128083219.2332407-7-zhangshida@kylinos.cn> <CANubcdUtncH7OxYg0+4ax0v9OmbuV337AM5DQHOpsBVa-A1cbA@mail.gmail.com>
 <CAHc6FU5DAhrRKyYjuZ+qF84rCsUDiPo3iPoZ67NvN-pbunJH4A@mail.gmail.com>
In-Reply-To: <CAHc6FU5DAhrRKyYjuZ+qF84rCsUDiPo3iPoZ67NvN-pbunJH4A@mail.gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 4 Dec 2025 10:36:49 +0100
X-Gm-Features: AWmQ_blRRqbIFTY0f39yIA51TqtDoPBldWIhSqZwhzNWbMT5aHjbQPCsAOYEw2M
Message-ID: <CAHc6FU57xqs1CTSOd-oho_m52aCTorRVJQKKyVAGJ=rbfh5VxQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] gfs2: Replace the repetitive bio chaining code patterns
To: Stephen Zhang <starzhangzsd@gmail.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, ming.lei@redhat.com, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, linux-block@vger.kernel.org, 
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qW2FczR6ShTL6G1unRUpFKU1FdAW-4eNR89kA-Zw_5o_1764841021
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 11:31=E2=80=AFAM Andreas Gruenbacher <agruenba@redha=
t.com> wrote:
> On Sat, Nov 29, 2025 at 3:48=E2=80=AFAM Stephen Zhang <starzhangzsd@gmail=
.com> wrote:
> > This one should also be dropped because the 'prev' and 'new' are in
> > the wrong order.
>
> Ouch. Thanks for pointing this out.

Linus has merged the fix for this bug now, so this patch can be
updated / re-added.

Thanks,
Andreas


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBD555884
	for <gfs2@lists.linux.dev>; Wed, 19 Jun 2024 21:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718832826; cv=none; b=APXxaIxiRvtSa+cwVK4E7RMDKQV9XXFrOhGMBMAqgfqmS3Z9v8/YZTqvBPfvjw/TrGmZTB17JGCdy1dJPe+WRCnQkezsV3fzACvWkKbzudid+sZPQMJBE3+aIObqGXzgvipKZyHnl5+9SvYusAlnfL/2jzEm1frOggVu/aSx/r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718832826; c=relaxed/simple;
	bh=FVDoRdh8K7mSFOE/o69xs6jRlJZ4GjAMAILSSsowHPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oOZZhhoSkyZQ6qD53ZvQ4e4n3YsAnStyuz808Q91qPBGXxO9AUBjrtpVcXBxaGAWY6VruPn70XfFSR9Gnjd4vaIjWxHAcq6Q1yNMRk6hywwiOE7f6ZesRvyxKbcKp9ADdU1D1DMNdVio39n2uUZ97fu1dkT5sEO13HdgKWyI9JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EBmiaPd4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBmiaPd4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718832823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FVDoRdh8K7mSFOE/o69xs6jRlJZ4GjAMAILSSsowHPM=;
	b=EBmiaPd466pR1vp6OE3xM6zicotxNOxiTAQYp1N2lCBeKJpBfyuFnNqwMrPHTAed66rgZY
	DO6nKmAnbafLlg4dFQPQCg/PPHVfZH412SbNLadUU45RUOhGhZbGx0w7q4Rm3hxYQiV6un
	4og/YWjsbP74g/6WgIVTuU5Axt7stuQ=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-H-Z5IkB1OqWSagaRczgvSA-1; Wed, 19 Jun 2024 17:33:41 -0400
X-MC-Unique: H-Z5IkB1OqWSagaRczgvSA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ea892f8441so1064561fa.1
        for <gfs2@lists.linux.dev>; Wed, 19 Jun 2024 14:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718832820; x=1719437620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVDoRdh8K7mSFOE/o69xs6jRlJZ4GjAMAILSSsowHPM=;
        b=brENkhvt6Vw4L0sEUDcZ7D8k9Z//RqQiez5uEsk5vGiPNskHlb7S+INhA4Mx9WaiW0
         M890LeUyGmD9Nu77EfhV//xLWKRCzz2AEGfeCqnhaODsHI2XKzxHSyYaxAto+jR/0my2
         1N4XTqnmJWmVUIpqrqWqyEEen1jU+U096NTO7oD+PHbZKXpp7MSiNn+jcI6Xx7Vwg080
         LaV90HhBcUIem9/3U/n9zPVNgP6EKW52TsER7TBebwiPo2raMkse1fRoBuyBpEKeWKGp
         I3Ve6aG2BUVvUE4julkWRf8voGZ34gLdWEMh0x1XC92SWxp8Z+EIcOxe08CdIza/yg72
         eppg==
X-Forwarded-Encrypted: i=1; AJvYcCXSoeB6lRMOVVdvW+TGy3XV/kI5ZxoVCnlSb+4h8gw+bryKkILDt/WFtTLjMNqBM+4mWmWS5E5FOuDnb3RUECkxCpVVSw==
X-Gm-Message-State: AOJu0YwvQ08IgQItDj1rf6Ex5+phOfnXfc14PVjU/5RbOJF2nWojxJQl
	xLGefRj7gVXuu33G1vy49ARyzIGXHMhEe0tFMVKPh+gRHAco+aD1QCOxq6JZqved4JSTpG9uQgF
	3IKGaZl3+xgno3ExlDKknQMbIO/JFZHvaD9nhkKOjIbTnIQfweJ+79yAeYhTwtiBZj7UziNlyqo
	sQeRs3+jwSskW7+8MXw9Y5wbbFiA==
X-Received: by 2002:a2e:9257:0:b0:2ec:27d0:b28b with SMTP id 38308e7fff4ca-2ec3ce9f6d0mr24030071fa.5.1718832820190;
        Wed, 19 Jun 2024 14:33:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsKXGk3yVltT7CT3arRWzPzx62uXtdeT/GyDTGGV35BOQ5Yu4GYQKTenCMS2OPm8GZP1fJnc5D02SNBCQ102s=
X-Received: by 2002:a2e:9257:0:b0:2ec:27d0:b28b with SMTP id
 38308e7fff4ca-2ec3ce9f6d0mr24029961fa.5.1718832819902; Wed, 19 Jun 2024
 14:33:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240619050358.411888-1-lihongfu@kylinos.cn> <78ded683-9bf8-4f2d-9dd4-877aa86e0e0b@web.de>
In-Reply-To: <78ded683-9bf8-4f2d-9dd4-877aa86e0e0b@web.de>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 19 Jun 2024 17:33:28 -0400
Message-ID: <CAK-6q+jPMPoue9w+=_ZtEjE7AohRrbPHN93Fa=CbXtrTOyhicQ@mail.gmail.com>
Subject: Re: [PATCH] dlm: use KMEM_CACHE() in dlm_memory_init()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Hongfu Li <lihongfu@kylinos.cn>, gfs2@lists.linux.dev, 
	David Teigland <teigland@redhat.com>, LKML <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 19, 2024 at 4:54=E2=80=AFPM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> > Using KMEM_CACHE() macro makes the code more concise and easy to read.
>
> Can the three passed name strings matter still for the identification
> of the created caches from this function implementation?
> https://elixir.bootlin.com/linux/v6.10-rc4/source/fs/dlm/memory.c#L27
> https://elixir.bootlin.com/linux/v6.10-rc4/source/mm/slab_common.c#L362

probably only for "dlm_cb" that turns into "dlm_callback". The only
place for me would be /proc/slabinfo, but I usually do `cat
/proc/slabinfo | grep dlm` to get an overview. If you are very strict
and "/proc/slabinfo" is not just "debugging" only and allowed to be
screen scraped (which I don't believe) it might can indeed break some
userspace applications.

- Alex


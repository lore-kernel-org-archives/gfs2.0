Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EC92EAB94
	for <gfs2@lists.linux.dev>; Tue, 17 Jun 2025 19:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750188786; cv=none; b=W1FBigbApyyASci0HWP/2hJ47qz3kdc7gBvsq2N7DnXUPE1ABZ1W8Xj0lTFY3NqZqqMwfX/U7rViDbbFV09QP/zGuGnpoEMq+asYUPq4AE8dqUX99JXd5GqQaN0C8aQd49U9hXuYw0XkCCQzr8YzUmozFfnQaQ4e8xXVyofyvgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750188786; c=relaxed/simple;
	bh=Aah+HSubQPUZAeKPHbnCgcwk4Pv9SienJRhWfGPoXVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KWsLebQpS2haiET7OHa4tKIlpauQVT2mGy5Lckb6VJrthuyRiD1hP0ZzeIl/MOnMdUSO+WaXPaHa+fNOhsr6UB0Kk0rMrLwYbO0iHMuge8vZTaJXzIcgDyq7zsGXlwITwzQO4Qhi3LiZHWmfC2gb4N5wABjUkegUJeY+DikwzLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uar9au0m; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uar9au0m"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a52d82adcaso83649521cf.0
        for <gfs2@lists.linux.dev>; Tue, 17 Jun 2025 12:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750188784; x=1750793584; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbe97D9Jmiian0+4yUZsYXhkQisqb/mr4o3dbA/bJbM=;
        b=Uar9au0m1d6sb24kVfgSsrafwWqHayHa+WQez9cc8NaDDyI+ZH7Mj+SKKeOoJbsAiO
         F9144DQr2fi73eKSvY83CPNrUzjLRQuPfIwMi3YqgVe1FFJ9Q3o5stOfPmmNAMYpwMnp
         4Qh7J/0WvhbTQQx9/6oJx4moeIWr9gN8wW59gbr9wIF1bQswEXhUHqGt3WT0KwsrM2Lt
         G7nEpyh5X5LgVugCwgSf5NCorLkP4K4tQlyZmxlbSDVMHboNodkT4EfB0lRXmzmrvJC2
         qhfIJ5w09Zjf9VlhMgIJvEw95/Tqz1zUs4aLoPfqTWM+dHzLGBu8sXdhS3LwsTOdzmvR
         Mb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750188784; x=1750793584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nbe97D9Jmiian0+4yUZsYXhkQisqb/mr4o3dbA/bJbM=;
        b=cO7z8qpKubPxCdCdBbS/NxyNpQ35LuZ9m08f6ED/MDc6e2FegXs/LdiilqSS16/epR
         VyihliwViAjbeBdGWbTQ+/4Pmh4hHrw9K9ZPP2m2mYuvIWyo49NhbbsjMG8HedVtpT19
         HgKv/Qm6w4FILzG7/Qh63k5jvPXRDWr0ENMzJ5LBlFLEeh4A6pvcj4al+mlQvK0GxUsP
         1mmc03ofJ6PEWtTrKHpWofNnj85Gk28xOkngsdKzU8UsVClkzzfYQ3P/1+bOFjotMe0P
         Nz43svdtSxhdr6D/3ixS1+2cqHDsXolMZ94tvQwNz9KLZtYgBZX0ROd8+XXNLrSdt5v6
         iUNA==
X-Forwarded-Encrypted: i=1; AJvYcCXWuNkx8NEERuXi8uCwPdI7hpngCG25btH+fNuYxFK84YxR5FooL2RipQL+kXF7i2sD/kxa@lists.linux.dev
X-Gm-Message-State: AOJu0YwBLlsrt/KoTNQqKD2hEpNFq0e59vqJgXKdiDQyUmJHWL1aVtgO
	TBbA+0EiLg5CwrpACl1x32q+XLjbAy46tKNvwPdVgRxkzyqG2RfV6J1JyOrH6zfQPv9Nf3RhLDd
	ikesAljIyA3Ce3pY21NS1izNs1DLR1xG4SDrW
X-Gm-Gg: ASbGncsIc5Vjfe6AKFgRxjp4fULx59J+H26gJVpXCiPxjXHoOhSk7/hsRc4zn4RDoWe
	bWZICdxZ7Ptvd2HX93G/Zeq/cVsCM8gUcPREC1lxVfj+i0KaqP2gf7Y1fbucHRN1K/buAoi98S9
	RDv7WDW4cq1lkQf2uMyYfsORN877YMv0iBAIDgfmxx1CR4U4nC5j55Ik3/fiPohWD9ORt9ng==
X-Google-Smtp-Source: AGHT+IFs6szxS2r+gjeGsdqBiGo142lu+0TsxSL7Er/xKXXNedfsriBhcmkChn6VnN0EHL7qZN8FowNXo/P6UdDTHZM=
X-Received: by 2002:a05:622a:1102:b0:477:e78:5a14 with SMTP id
 d75a77b69052e-4a73c484bbfmr241088891cf.3.1750188784164; Tue, 17 Jun 2025
 12:33:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250616125957.3139793-1-hch@lst.de> <20250616125957.3139793-7-hch@lst.de>
 <CAJnrk1YtD2eYbtjxY4JWR3r75h1QyjwHPy+1NQBRUNrDmTUnQQ@mail.gmail.com> <20250617044420.GC1824@lst.de>
In-Reply-To: <20250617044420.GC1824@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 17 Jun 2025 12:32:52 -0700
X-Gm-Features: AX0GCFtRXAXeBs7bZNwJubD_2Slv0ZPzqWieKyeC3F6xMTrYOWwRlJxyDQUIKJ0
Message-ID: <CAJnrk1ZYj0TvoLS=sE46p_8=b+3cZ=VNT1Zvd=HMembWUptHPQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] iomap: move all ioend handling to ioend.c
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 9:44=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Mon, Jun 16, 2025 at 01:52:10PM -0700, Joanne Koong wrote:
> > >  #define IOEND_BATCH_SIZE       4096
> > >
> > > -u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend);
> > >  u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend);
> > >
> >
> > Should iomap_finish_ioend_direct() get moved to ioend.c as well?
>
> It is pretty deeply tied into the direct I/O code, so I don't think
> it is easily possible.   But I'll take another look.

Yeah, you're right. When I was testing this out yesterday it compiled
cleanly for me because I had CONFIG_BLOCK=3Dn set.

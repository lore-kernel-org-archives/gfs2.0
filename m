Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37A922D785
	for <gfs2@lists.linux.dev>; Tue, 24 Jun 2025 22:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750802540; cv=none; b=Oxr21xsC1WFa3fx1TwvMgSpbSOk9FTFPH1JMTJMNK49Ef8p3Vxmiz7TEJoSqAx9z5sdE+Yz1TCV3CDps2BmrOJ55pJcenk6VITPDgpVN8Y32M+yJW+LhqPL+XiXDBtk9IDRfXXHGyNgY89R+Vif1oBjpcH5yEZKIaCmuFRu5X9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750802540; c=relaxed/simple;
	bh=KI6/XmV9em9yxZDWFEWy5ZAZI3Im1BUdkLJpbjnspMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFbAM2Tsd6McVMYxaZaskTSA1zt+QM+KSg5aOK9blb0BUpvEK/24sbskGEoaXCiEBTwIz+X5acH6AKHF/YqpQ4llm3HLfz7KGA17DqCEekN3g9EWURrZaiyS3qibUbklR6+CQEiOThphg29MvT8eL4BGM9alP/gY9BZS0zLpN7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPH30wGE; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPH30wGE"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4a58f79d6e9so12589691cf.2
        for <gfs2@lists.linux.dev>; Tue, 24 Jun 2025 15:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750802537; x=1751407337; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KI6/XmV9em9yxZDWFEWy5ZAZI3Im1BUdkLJpbjnspMQ=;
        b=gPH30wGEvXgOvX/p/FHwAbevWDiHcKyY6Ek9SQIaaz3OYhIQQvgP7vTU5Vr9qTZS/3
         ftbAidIc0B8JnxiAru1EEK++YnN8ipa5I7LaISG6Lm52KAumbNqX49H4zs0YTnpO187o
         l+WwMR8hz6qGT9b1fO34lvdMGRClozzmSYBAfmIM4fdUvmCZj9CIijbkkTxD57+DD3tu
         mrewhVoXxlhdhg8WEfEheSL6MEw1hLQ5pWj1dY4kdMH1lO5UQwGfBmd/s65Dap1A4mHl
         O1lyVfsz8gwLMMImNOABdfMPN8zwRj+d0XJ3NvKnPBUyC2aqkWDAlRizLeOY50dVaoTv
         YYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750802537; x=1751407337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KI6/XmV9em9yxZDWFEWy5ZAZI3Im1BUdkLJpbjnspMQ=;
        b=eQYdX0nkBjN6CT/Yh2ajfTtIMEqlgv8uXhYfT66a4+4auU2YEq8TL0GbZRUzoQqpgD
         dEkmwwuigNSHZhWoThIenjPhuipcRRJt3U+pACFFiNQVSyPOhFawA855qJOyw5lLkBK5
         Cdz6zx4HUZXBZhZ1n60HKe+aePOR8sTVI9dD9EaXid81Btzhm4gQV7uahTNDTgUgeure
         lG256mskwPM5gvBkf3ugDgVqQO6nsTVnFFmTgrwH8e1p8bJENub1CJzkRMwHflYKK3Yu
         2D5Capg9fXSTXqshQ66RROoQ6EcfpUUm28kXlXz2J7TtHbBGU69HAM1UrAL9bybjJALs
         em/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2cFKPW1UyvGqksN/3pl4xBY33Cvv1cunj5e0yNXa7Dr8mxvVloM7S6ETYdJdDaZ71QR7z@lists.linux.dev
X-Gm-Message-State: AOJu0YwUUQa7SRmP+UKRR25tDRXPU1Ouvmy8hCtsxH+OpxSQDgE1te6a
	yOh8VXf/UpvuaD0NsmJzXtZKWhUcTW1yp8sKMelItAA0r2C0RHwGzJAhB1kM+VAhyZZB/bBM14b
	dop+5XsVBRH1NbPIDOdA9acFUj3R4b/c=
X-Gm-Gg: ASbGnct+NQeKFUP/1riTOt4cO6u3FlR9oNe6ZfnivZBMS1Yfcqg+qs9hmFbFpK/PZwY
	cMGX8fU8ZUkXgZYaoiewr2LsrEw3OC+rm2te/mB5y6Y9yZGOUcfcS+Lovy3+SeCYWdu012qHNb/
	ibP8bVbz9iIe9QmEhzbWtgeINDz52mmlKvzR58yXLbx9MBoM0J8/VG5P+/d7c=
X-Google-Smtp-Source: AGHT+IFApJK8qgHNiP15oAq3BEZlkrbkeLkCUqnNVjpYJuoZ4/jjmxsvBbUNxUSjqZ9kQuVJI4zok8KgKMGPbchiCDI=
X-Received: by 2002:ac8:5905:0:b0:494:adff:7fe2 with SMTP id
 d75a77b69052e-4a7c0bbd8c8mr16752751cf.43.1750802537276; Tue, 24 Jun 2025
 15:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250624022135.832899-1-joannelkoong@gmail.com>
 <20250624022135.832899-2-joannelkoong@gmail.com> <783b0f0c-e39c-4f52-90e9-7f7e444d9e84@wdc.com>
In-Reply-To: <783b0f0c-e39c-4f52-90e9-7f7e444d9e84@wdc.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 24 Jun 2025 15:02:06 -0700
X-Gm-Features: AX0GCFsv1OYMTj4vzKRiFaHM3oOY5EQaLukCgNj950jARV6_mnnMOsZzOQUOErY
Message-ID: <CAJnrk1ZQ=wVKmoQS12ixQHDuynMZNEkcu+Z0TgLvXxXRx++eEA@mail.gmail.com>
Subject: Re: [PATCH v3 01/16] iomap: pass more arguments using struct iomap_writepage_ctx
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, hch <hch@lst.de>, 
	"miklos@szeredi.hu" <miklos@szeredi.hu>, "brauner@kernel.org" <brauner@kernel.org>, 
	"djwong@kernel.org" <djwong@kernel.org>, "anuj20.g@samsung.com" <anuj20.g@samsung.com>, 
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "gfs2@lists.linux.dev" <gfs2@lists.linux.dev>, 
	"kernel-team@meta.com" <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 11:07=E2=80=AFPM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 24.06.25 04:23, Joanne Koong wrote:
> > From: Christoph Hellwig <hch@lst.de>
> >
> > Add inode and wpc fields to pass the inode and writeback context that
> > are needed in the entire writeback call chain, and let the callers
> > initialize all fields in the writeback context before calling
> > iomap_writepages to simplify the argument passing.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
>
> Looks good,
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> But IIRC it should also have Joanne's S-o-B as she's carrying it in her
> tree.

Hi Johannes,

I'll fix this up in v4 to include a signed-off-by line.

Thanks,
Joanne

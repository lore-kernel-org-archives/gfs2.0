Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCA413C8E8
	for <gfs2@lists.linux.dev>; Fri, 28 Nov 2025 01:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764293617; cv=none; b=ljqW3nhD1jE8PnyK4vrW9LvsgrYeOm4O9JMUHXlv3C+TrzkLp8/B5/Om86VA2NTFKSFkpogFPSZK9ydacuPSTTvPMjTZatbp0U3b5R7CPllUce1i7qQ41VldymH/ueFFB7T50cjmKzz/NkN1RTDm2ZPtzMFjF0d1h5/nL3fzroU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764293617; c=relaxed/simple;
	bh=uW7r4RZeddBNz8cscDewEXSV9y5trmetenOT44ENLvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/oUFOBGF0D1llvJZARKXyJweJO1JQSHP1LNwefOyQEZ/82L7We3Bv0DjRZcj/L/bGb1wJyPQ8B02cXDVCmu1Y+Esx13OTam/egi984NWydNX9TLbxLKIp7hgx0pi/m6rZ+S6QWYv4evH/B/6X/KYffz8DKgf9kv9IZl5PGN9JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmwZph4+; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmwZph4+"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-88051279e87so14388826d6.3
        for <gfs2@lists.linux.dev>; Thu, 27 Nov 2025 17:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764293614; x=1764898414; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCmoVsJTYhvhdEhqnCuQdxLwDfWSRN4iQRhiwDtzkSM=;
        b=jmwZph4+n4oKfouADQk3j1drbm8X3vhOtmOePTBfSU7BzzRlXZoViy8wJRPY46trB3
         W97B7HSIwzgngO5zL9BbqgwE4k4OtFqwTvkLVncsDPX7pQqS5T+aj5dPF/KS5GDcfSKP
         bhyP/NxztFXkTcngDrMPU5a5x3hfsQEXXsXnOhBamSSWbULkvdSwebozJ24YhHELP+tz
         leGle+AQh6jk7JhLiMSuj2Ez9XoW5P7T7HGMz2QAlB/aK6vEyde10SjlDfWHsoocNvos
         cXgEICNuUau1pOwxiCp9uZUXuDiZTYtK3g6GPv5dA/1mxZDONOGQwfF1GPFhRmkwe4z0
         GUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764293614; x=1764898414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OCmoVsJTYhvhdEhqnCuQdxLwDfWSRN4iQRhiwDtzkSM=;
        b=LOCJRTNW2OjXlHZxeqmjzjxgjwLVjriVb3xXabaqerKyAf8jyKRNh3zbXfoCLPXO3o
         pWXUtT+aE30GDnsaH7iFq+adhO+XNHLCnn01nRXsdPV9SkJkw+V+WtGCtaBRlTDedJKR
         1h+A9OV2juZoiJNtwQlhFSH9rfqii/n6eMzfZ7K8n3uKpa26wpNiaS/ixd8FlAXyNbie
         cfshN6CpscTJ5ikfBMgNnZXNB6KV+P4YAk5KjHAffAwzPS6lz5xbzUorRo4NAVH2R/QD
         ACZ2rH6Ccn4iiYaOqkUEj/Nr4/u+jIyWU7GmWy4QsAHi81V5m/SE6fEuK/HOiwIe4SZW
         y7/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/mK2/a5c9HcTqJT2LChG6kMCwma6mHXklsXam0D5bJ6Ouv98OHC54QwoXS+fAcsc943oG@lists.linux.dev
X-Gm-Message-State: AOJu0Ywb5FzWpZSnZYNoc2GFpioDmpW+L9oQCZcgl5Wdyo6BffjBGXNy
	KKDdGDYoyy24u47xS6JuhAI4NIm3hNpoPJR+u4I2m9YD3pPpfrnfPEzTllmCZWmqDIZlFIBMKF3
	21RNa+PKJCewiVPCSbaedHs30i47EA2c=
X-Gm-Gg: ASbGncuwwFAZ4CqV2nF2qiMGnw/Bp6ewz00NhW4cQz8xj4ZPS8PaELExD8Xtr5joIjY
	2V5iW8Ninma/EaIirUdc6KgohACr0yICdfA1e9nC+GlnjUfNdQyqTxe4uiUTQdQ62fIpIt/sDvO
	yJKws5XYn+vYFFZy2clJKVZPhijBp6V+hQhUvFBbeDiW2BlTyUIfSsYH6JI3Ln7RkECdsI/BUUp
	ItzGsjDImNapCQHneVr59vsReBajW+KyBM97Y1rxz7VjbhPkSqZM3IMMbz5dftgB1kQPWg=
X-Google-Smtp-Source: AGHT+IE6nrHo52NkC3u4arv+NV93c/YfHBRAs+svXfCqzbJAogT20JAMk+GOCyu5yn5XMiOUt3k5WhNEc+/7Yy6kmls=
X-Received: by 2002:a05:622a:1a13:b0:4ec:ef6e:585 with SMTP id
 d75a77b69052e-4ee5894f748mr348305511cf.73.1764293614202; Thu, 27 Nov 2025
 17:33:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <aSBA4xc9WgxkVIUh@infradead.org> <CANubcdVjXbKc88G6gzHAoJCwwxxHUYTzexqH+GaWAhEVrwr6Dg@mail.gmail.com>
 <aSP5svsQfFe8x8Fb@infradead.org> <CANubcdVgeov2fhcgDLwOmqW1BNDmD392havRRQ7Jz5P26+8HrQ@mail.gmail.com>
 <aSf6T6z6f2YqQRPH@infradead.org> <3a29b0d8-f13d-4566-8643-18580a859af7@linux.alibaba.com>
 <aShkWxt9Yfa7YiSe@infradead.org>
In-Reply-To: <aShkWxt9Yfa7YiSe@infradead.org>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Fri, 28 Nov 2025 09:32:58 +0800
X-Gm-Features: AWmQ_bnqkcJ2TfUO_Hy5DulnmQrOor9Eq1r7gxzBzqTjOKvbRCKHxxHaYPQTzc0
Message-ID: <CANubcdWh0zZpOqhBhWtKf0uN1+8Ec-RsHiSCQUFrqYXoux2-TA@mail.gmail.com>
Subject: Re: Fix potential data loss and corruption due to Incorrect BIO Chain Handling
To: Christoph Hellwig <hch@infradead.org>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christoph Hellwig <hch@infradead.org> =E4=BA=8E2025=E5=B9=B411=E6=9C=8827=
=E6=97=A5=E5=91=A8=E5=9B=9B 22:46=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Nov 27, 2025 at 03:40:20PM +0800, Gao Xiang wrote:
> > For erofs, let me fix this directly to use bio_endio() instead
> > and go through the erofs (although it doesn't matter in practice
> > since no chain i/os for erofs and bio interfaces are unique and
> > friendly to operate bvecs for both block or non-block I/Os
> > compared to awkward bvec interfaces) and I will Cc you, Ming
> > and Stephen then.
>
> Thanks.  I'll ping Coly for bcache.
>

I would like the opportunity to fix this issue in bcache. From my analysis,=
 it
seems the solution may be as straightforward as replacing the ->bi_end_io
assignment with a call to bio_endio().

Thanks,
shida

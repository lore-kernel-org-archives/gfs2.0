Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CB2302CB1
	for <gfs2@lists.linux.dev>; Fri,  5 Dec 2025 07:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764920772; cv=none; b=K6iLXyk6jAk3x/jcVZsnsDVOd1Tu1UOpjOpauWIOH6UQSOft08J8BL+RpjrRrc84o+UXkymZtZNLXd8Ttn5fWt7et9zuD4UNfzLTKFQvwQphWwGhvu5dQM7V949jOEIUNBB8EZMZmb8y4VI366F+uXqpfzrbuxSv53LoguQqCkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764920772; c=relaxed/simple;
	bh=HXtSwPAI2lC/ImQNYqZw2xOGmU6O3GtB13oXE7vjpQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FcbDAxxvhKB7ra9O3jhKGkOJ8LbGH+wjHsxlavanex3/2k47BRBA5VudMKdMHoTh9sGOXYRntTuxbRtIv/C7wRpaAnDzhLBTQLpNUWw75V7Xaknvuc8vI5S2oc1uh4M79ZQh4zHZhoyg4cchRsP2QOvhKw2qSUSx3PPp0e59NWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCgeGtSh; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCgeGtSh"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4edb7c8232aso22878811cf.3
        for <gfs2@lists.linux.dev>; Thu, 04 Dec 2025 23:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764920762; x=1765525562; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXtSwPAI2lC/ImQNYqZw2xOGmU6O3GtB13oXE7vjpQ4=;
        b=QCgeGtShn5sQIp+qXD9lLofuqOAz51ym4+jn2ZTqQjC1DsA0OFxxo688aXO2ns0eBc
         yLyjYx17zfKWJxL6qzT+4ZqfSsAaVz4Fa9h76MDikj7QWXiKyPgT7aFkHKpJMls7/5WM
         cuh29v3oRNRFXt7A0540rfSjx0xJ8Sd4/jZXf5WmGrFEFnfWO+UNFlqpJz+1dEFLsJlR
         g+jJL8pdyxyzRghWbcF4CdU/+1Yp4eLSHpVmvjfUwRZmSmXi5BMRYSx75r8wR0SqCs8U
         Z6LJFHRjzy9UHiWZLuDildxw20AkRRErYkmDjWykIJ9tHBDPnxJHveTW+T3meqNPujAL
         MG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764920762; x=1765525562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HXtSwPAI2lC/ImQNYqZw2xOGmU6O3GtB13oXE7vjpQ4=;
        b=bpOVTS/sTQKL70Nu1oECuDhxOY3TO611MKK79gHto9Dt8E8JMcJwuqjubk6hGdHI7n
         J0rUeAWBJoA4jDvtqyoW3rFo7y/hlxAVXMRmLssXd0k+cOKUPFdcAyDlVcJQS83MHiV5
         kHnmWWS/HCTp7LkzOncWzW4RNY1oW+Gmc7vub6LE4KAjlk2TarTMo1FjotAPDxTD77so
         w33Z98AjNpWbX+bZRVhgdKCp/wLfNdQBMod38JpkGL5BWwL8MoFfj9exn9FZQv119Pxf
         V116fQHSCcQL1jNiCY/z/HplBWCXwVpu9p+hSVIfVvSEvnNbnniiC+M55dlUgr8O8C4C
         5yrg==
X-Forwarded-Encrypted: i=1; AJvYcCWG9rmQ/vHgLpX8KUrfZhq/VPbn3o1ayZoFy4OvWztw4j6OkPL67ABjo1LzvMpANE3Gz66p@lists.linux.dev
X-Gm-Message-State: AOJu0YzfW5FGSg+XNtdj1pY0QFLl9mecr50v0BIcYFH6095rsLGUjyOM
	bcwMrDqbRS8DPJGUXEAmDgMElvLZfWoqJFdVYxCMA6kOR4NORcPelwviHXezFk3d33AmS1A+MPT
	eTF36kU0FixG9PC/9XU9j/sfATBbLeUE=
X-Gm-Gg: ASbGnctibPTQjMv6kSUKPhA6iKp3fOAnRPehvtAH0pgo0Lhjbb81cOnaLYujzAttLqL
	/GI/EwkNLXUKhI0oRTvlgAiUrBUtFpRd2WKFpMOOeYTSxbzMEflqP7bz0akNjEbiqBfoOZsnRkU
	XODptCt/j99O2+1XGY/5vuZVot4EFHTHrnyGtUwgPVx9FhBFpdHZP70YjCsYfdqUj3ggLp6FkG3
	w4aWCpudb3sKpG0lzQNifD9kFtO1HH0u2Jh/5HhHKM7z0HspCf2S9KiY5CtHTXAi19GsG3Q6mP/
	4WDoNw==
X-Google-Smtp-Source: AGHT+IGno4YCEk34HtoQAUN6GrFl01k867Kp7tydcNcb8xmuE9aFUTESOSk0G3T3M/y8W6zfCnRmuyMISYmpdGJqEvo=
X-Received: by 2002:a05:622a:5c6:b0:4ed:2164:5018 with SMTP id
 d75a77b69052e-4f01770bf40mr116570781cf.80.1764920762038; Thu, 04 Dec 2025
 23:46:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
 <20251128083219.2332407-7-zhangshida@kylinos.cn> <CANubcdUtncH7OxYg0+4ax0v9OmbuV337AM5DQHOpsBVa-A1cbA@mail.gmail.com>
 <CAHc6FU5DAhrRKyYjuZ+qF84rCsUDiPo3iPoZ67NvN-pbunJH4A@mail.gmail.com> <CAHc6FU57xqs1CTSOd-oho_m52aCTorRVJQKKyVAGJ=rbfh5VxQ@mail.gmail.com>
In-Reply-To: <CAHc6FU57xqs1CTSOd-oho_m52aCTorRVJQKKyVAGJ=rbfh5VxQ@mail.gmail.com>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Fri, 5 Dec 2025 15:45:25 +0800
X-Gm-Features: AWmQ_bnqjBxuauDVJJL96EAzZiNCKi7bmfbcq5aA841m6f5U8UUuamAPefRv5L8
Message-ID: <CANubcdVuRNfygyGwnXQpsb2GsHy4=yrzcLC06paUbAMS60+qyA@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] gfs2: Replace the repetitive bio chaining code patterns
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, ming.lei@redhat.com, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, linux-block@vger.kernel.org, 
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andreas Gruenbacher <agruenba@redhat.com> =E4=BA=8E2025=E5=B9=B412=E6=9C=88=
4=E6=97=A5=E5=91=A8=E5=9B=9B 17:37=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Dec 1, 2025 at 11:31=E2=80=AFAM Andreas Gruenbacher <agruenba@red=
hat.com> wrote:
> > On Sat, Nov 29, 2025 at 3:48=E2=80=AFAM Stephen Zhang <starzhangzsd@gma=
il.com> wrote:
> > > This one should also be dropped because the 'prev' and 'new' are in
> > > the wrong order.
> >
> > Ouch. Thanks for pointing this out.
>
> Linus has merged the fix for this bug now, so this patch can be
> updated / re-added.
>

Thank you for the update. I'm not clear on what specifically has been
merged or how to verify it.
Could you please clarify which fix was merged, and if I should now
resubmit the cleanup patches?

Thanks,
Shida

> Thanks,
> Andreas
>

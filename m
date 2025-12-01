Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C2E1DE3B5
	for <gfs2@lists.linux.dev>; Mon,  1 Dec 2025 02:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764556907; cv=none; b=Nblw/bbueAIGKvl96VZ8UePrNs+QDw3cpPvoXgN0WGfYKkkfYku2xdJptjdmvWYn1jzMWKRJHEm4CKxNzVA8kZHYvVxMnyX+qI/PRtIEisuP04KrQTualo9GHnLJcoGaUM3Ol8HMUpHrKKvC3rQC/LXbwnK/au7nEYmzSjBn2eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764556907; c=relaxed/simple;
	bh=bVTMBZipQSey4Fgvkem7K+oGHQCM1N5D+geGZc1LQG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uPsXoDvjj3UM8d8NdOaPblVv/ggC/8P1kwu4BmHISj6wgcvpeUi87vzStsrgItJFfELXvEWoc06KeW+aXgHq0OlJ54iPjy/3aV5sv2XaE4Bfx/yWFMDNJYfYSQ0Gby0NRCscpXA5xqzoCqBX/bI1Kb0ypPwxmHYmbgi0XhT0aCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVBJb/ZN; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVBJb/ZN"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ed7a7ddc27so31558221cf.2
        for <gfs2@lists.linux.dev>; Sun, 30 Nov 2025 18:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764556904; x=1765161704; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4ueRZDGEmZN3pKdDV+VUbfm/GEWq1+GkEBdKVjZOtc=;
        b=MVBJb/ZNbYpBpPmn+x8rRQWo7uyBfM80KQ568hftL96w5Mocw5ZOzg/eKDIQyvpRS/
         CoTinMdYJsKSARRB9h/QncHaakl76yzdKa6R7h5BrA65vYVHOpam6mcLzAe6AWa3zD/1
         aoL/fQJZNcoueGtm8+a3WvAasVgDJ/DO5dWr1B0Usxbh2NCtHei63cD/uahNZekgInyE
         /7s3Gudt+huMdcyx5eUrpcdCmCD781SWLh3Q8yNbchd5qyFBuFKbI85yJyWaJYtvZ9SS
         C5LWxutDyN3PHmGH3gu2v4kAlBnVu2BVBxs9KQIfd9LbMzs386gAFrlUx67ZMDMurkO/
         MvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764556904; x=1765161704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z4ueRZDGEmZN3pKdDV+VUbfm/GEWq1+GkEBdKVjZOtc=;
        b=WvEXFw1W1DlES4BROh46JXGF4DHpTc/Q+xGiBc5xF3YZM+RC8UyWbz6FtZM5yFDgc2
         vObo2mPiteFwEVNhAA0M6+P67jwcqbXZMlvCRwjHr+74ZmWpWmQ9whXKxLrmB7dAKzKu
         fBU+S+1S1ZnURk41aTM+mFarDUPJYAq0IM+tz5rkZ7h53Q1dnL9fQYl6U31SqTc8nnSd
         QaOPYIX1qBjx8HzCIodI1OIHX1SdNqfvEPJSBo5VKG88AaeaEXYc25vHdG7LTZ2clzNW
         Ub7UbjSjZLsh0/oSygScoEYlWE36wizImhw5XyR0M2UUg/lfMdGZTF77xuIIVb8Sii4h
         HQhA==
X-Forwarded-Encrypted: i=1; AJvYcCWPx7+xMkbWE637LAd7GHA2SAFot6npHC1foBprTQFnjC1Kv6Yih0A/ff1ewJ7PITX9vDIQ@lists.linux.dev
X-Gm-Message-State: AOJu0YypE4DXpw0pbUyHiI/mx1i9UY/E4dS0TT8LOCSvD1DKFbaqdJ9w
	5ClqvSCo8aQD3SGKjIjSzje2aaveR34XNS264HBklXy2ZXJfHJrGtFQkP4M9BsHB0ZVx/kCLj/N
	kXh62DouTJvlR1vM+rRktTf3lXpOJURE=
X-Gm-Gg: ASbGncuMtDwkid/PG2dJ89JuyZZpw8Y+F5P4NRkrfTmOmp5BXjbAX+TiqUoLHnpfnTw
	SEKC3yuGYN2OprwrbsK7Da3ZcFOdmTtbmlANETaP87hp7yDJc3FxYfBR98o0ZYCAwDz21EHG75E
	gWUhcqNaubc5PbIw7SZlgFtv5bXduvvCIzsaWNLDf1BIn7SQyHKNvaDDyquvc/2is5POkxSR5QW
	WxhjQe8ZaaYy5i5owTfAOEb0yXQS/Y/dWSYIiPU8qvBMsLSC28ju+un7OvGP/Lcq1U5EfQ=
X-Google-Smtp-Source: AGHT+IEmvBJytrUYv3PRff54NTqLEiIVWOTOdu8c+jgIKKnb+TW+2xLZqLXPCQhWGcR80rf7EC5pZtRoolK6Jl03Lrg=
X-Received: by 2002:a05:622a:14ce:b0:4ee:ce1:ed8a with SMTP id
 d75a77b69052e-4efbd91573emr353928791cf.16.1764556903722; Sun, 30 Nov 2025
 18:41:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
 <20251128083219.2332407-13-zhangshida@kylinos.cn> <b33b3587-edb0-4f30-a8ee-baaa2b631ed9@grimberg.me>
In-Reply-To: <b33b3587-edb0-4f30-a8ee-baaa2b631ed9@grimberg.me>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Mon, 1 Dec 2025 10:41:06 +0800
X-Gm-Features: AWmQ_blj_C1mdvu7tNb0hVlGGZGM9DWXbWPpg6J4BwD_02XuZ0ipoM_caXqdy_E
Message-ID: <CANubcdWAk2Mh5b9stjTh8N84jq+XAgaR3n2-VYRinU9ERtJLUw@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] nvmet: use bio_chain_and_submit to simplify bio chaining
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, ming.lei@redhat.com, 
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, 
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhangshida@kylinos.cn, Andreas Gruenbacher <agruenba@redhat.com>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sagi Grimberg <sagi@grimberg.me> =E4=BA=8E2025=E5=B9=B412=E6=9C=881=E6=97=
=A5=E5=91=A8=E4=B8=80 07:03=E5=86=99=E9=81=93=EF=BC=9A
>
> Acked-by: Sagi Grimberg <sagi@grimberg.me>

Hello,

I already dropped this patch in v3:
https://lore.kernel.org/all/20251129090122.2457896-1-zhangshida@kylinos.cn/
The reason is that the order of operations is critical. In the original cod=
e::
----------------
...
bio->bi_end_io =3D nvmet_bio_done;

for_each_sg(req->sg, sg, req->sg_cnt, i) {
...
          struct bio *prev =3D bio;
....
          bio_chain(bio, prev);
          submit_bio(prev);
}
----------------

the oldest bio (i.e., prev) retains the real bi_end_io function:

bio -> bio -> ... -> prev
However, using bio_chain_and_submit(prev, bio) would create the reverse cha=
in:

prev -> prev -> ... -> bio

where the newest bio would hold the real bi_end_io function, which does not
match the required behavior in this context.

Thanks,
Shida

Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB7E3A874D
	for <gfs2@lists.linux.dev>; Tue,  7 Apr 2026 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775557885; cv=none; b=WuQVelkrl60mOJsIweusjQ1Ojard6Ue1JlT0IjciaEOAIKcLEEpvqmNnzPNDeqH1p6bsz/EVrk4/dpWDXZ7Qil+sZUOBODa9ephuVrzZAQkoPar/RshxHRdPuR19dfgiRAZXQ4ibgFFxLFo8PPD+Mc5c4T1NifgFttHXlWqHE9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775557885; c=relaxed/simple;
	bh=fse4/mw7XTsgfuHVVQjRFWJVGp1/Euz4A7xNtKxpkIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/O7X22meUCGewwDUXeTh9q0twOkoteuBJzW5kc8CFgW0XA++kFqDmTS4zv2qpfU6TUycA6pc9x7AcqWK1IrU+mk9ZEbR7EBnsuz8DmtmbkZAPsUnDMChzNMH174deY/Per+BBpUKBkgL9M+1cAhWNvKZ03yLqba7gIO9JQOWjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MVOsyp5y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVOsyp5y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775557882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4lD99YtIEAbiLQ1CDFnTyDVFUE3DC9IG6TDfPBqmULE=;
	b=MVOsyp5yugBaZFxy6UqnVhfKE+tbYrWQHLmrmSosEXcH9aReUk++hhAU0wLQaz0rzr+W//
	WnLwR3T/jSsHJJwxutrbofGPc8dGSM0PD1LkyS9oUYESaqKVdJQ4P2fx0HQCuUc+TEsVGP
	TeMrBxoqYFuu98SV+/wlyhaMTpmh2pA=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-iSjHsvUgPHWJOYvr735qlA-1; Tue, 07 Apr 2026 06:31:21 -0400
X-MC-Unique: iSjHsvUgPHWJOYvr735qlA-1
X-Mimecast-MFC-AGG-ID: iSjHsvUgPHWJOYvr735qlA_1775557880
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7900fc7033bso103613227b3.1
        for <gfs2@lists.linux.dev>; Tue, 07 Apr 2026 03:31:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775557880; x=1776162680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4lD99YtIEAbiLQ1CDFnTyDVFUE3DC9IG6TDfPBqmULE=;
        b=oPSIkoPfKvBX2vPWYlr/dvB6gQgiS8Wyhhq8Jfy/s7zJhw6g6dZZ6Fg0Oh3C0kWt44
         8BK0wdL1+++ztvUYGJtS3Mu6GpjVtVl68bsmrfY+IHElabPU+WdnedO6GKkYVxyHHD7i
         EAldf38tbss0Ck5FKziXGxKlQYqOLVbujQycMjWEvhsO4yHoGZR9YpfgfJqET+jZNDN8
         p9zGVnchPqeXZSRIJaZHI19j3uoo5PEP9+QZ3pJKbz4iC5HBnZzRFjGAxlX/MyeqoReu
         UG5sNenXTHXO3y0etw5ilmHdWYIVrlD/yiPxVU46at2IA5J1cO/HrKdWOA92BwhbLrqi
         wBOw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ5cA7jzEqwOqo2UsC+ExLazPN8odMSJLKCb9w/8nBFbfyHm3TOSVXlYHx5QBwFEvs8EVc@lists.linux.dev
X-Gm-Message-State: AOJu0YzdFMxqRs/FIkBjgKp0jCcFh55RPfOZzxVcL8erEdnds/CLihpw
	qTNcr8VzHS6IXnBDA7dDDM9DBwAW6lnYjnimDn08CqunXNYcu/tUI3aq458laefTSvBVGxC+zKA
	mEcTTTo+s9dGLBaMshuE00pivb2FytAA8bIs6UfSapMRNIGb8vMS+mv/ChOf2jyKCkOOVulkbx3
	Frd0UOMO/O26ETVGhRwy6C3yFNzNKOxg==
X-Gm-Gg: AeBDietH9fTcx5En49UUcqIlysBvQHwEP0mckf1bgkTLB/JJMef9DO/iNEZUuPKesVD
	Oyd1H18B1VN6bVHog5Ko+Lc0gTCm/SttZ26lFeCa7RAfuN4i5FldOSG30YJhnbbBXQQp/DcSRYe
	8FnXkP/PHKQy5Zr2IqeRWDg4iGtgwP6q/gjFOJycLFUpjkdRyPJoeu2dOgHlI3ecMlA3sfW6Vw6
	IRcMytPf65g8HL9/2Yijk3y+jwjbn/NkcXOlzYCK6p0W2uoiHi7v/KiJCgntZS9fA==
X-Received: by 2002:a05:690c:6e85:b0:79f:2e53:85f8 with SMTP id 00721157ae682-7a3bb91637cmr145977477b3.3.1775557880323;
        Tue, 07 Apr 2026 03:31:20 -0700 (PDT)
X-Received: by 2002:a05:690c:6e85:b0:79f:2e53:85f8 with SMTP id
 00721157ae682-7a3bb91637cmr145977377b3.3.1775557879897; Tue, 07 Apr 2026
 03:31:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <202604071139.HNJiCaAi-lkp@intel.com>
In-Reply-To: <202604071139.HNJiCaAi-lkp@intel.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 7 Apr 2026 12:31:08 +0200
X-Gm-Features: AQROBzAHSmuavjKTfJb18h0s-6xEF8CD_wSRMBk7UvJQqkGtY5MxkpNgeKukvoI
Message-ID: <CAHc6FU4OnGCUYjcdPB-d84wn074TTgPbt35e63s+WvnbDXcanQ@mail.gmail.com>
Subject: Re: [gfs2:for-next 13/17] fs/gfs2/log.c:1183 __gfs2_log_flush()
 error: we previously assumed 'sdp->sd_jdesc' could be null (see line 1136)
To: Dan Carpenter <error27@gmail.com>
Cc: oe-kbuild@lists.linux.dev, lkp@intel.com, oe-kbuild-all@lists.linux.dev, 
	gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MIjMnHLa1wykujJ6xmiZlqomzUEw797TO29P-BQ7Jic_1775557880
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Apr 7, 2026 at 11:16=E2=80=AFAM Dan Carpenter <error27@gmail.com> w=
rote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.g=
it for-next
> head:   80d71795c17ec98352d1059af856ac084a06109a
> commit: 47af62bd5b63da799ea51f53ff93b5f1a3d19046 [13/17] gfs2: add some m=
issing log locking
> config: csky-randconfig-r071-20260406 (https://download.01.org/0day-ci/ar=
chive/20260407/202604071139.HNJiCaAi-lkp@intel.com/config)
> compiler: csky-linux-gcc (GCC) 15.2.0
> smatch: v0.5.0-9004-gb810ac53

this isn't related to commit "gfs2: add some missing log locking";
it's a pre-existing bug. I've pushed a fix to for-next.

Thanks,
Andreas


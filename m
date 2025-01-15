Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B1F2416B8
	for <gfs2@lists.linux.dev>; Wed, 15 Jan 2025 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736948293; cv=none; b=AEDgZVEA25S2zDFHa1JX+F7IL8QeQPOo/UfKVPnm3udwQv2iYFb3097SUGhM3tMz90ncpY736xc56gGN8M8/p9gXWzoicUOGW4g7/e5ClamF14XdDqdfkGvn8Xn7F5R6Ge3Gr3Wwx3MhBwbOkLJaDcDlrG42UxlvR/ou4FvhtLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736948293; c=relaxed/simple;
	bh=VjQa1OLpSyM90kBGecP1wvm0KvL1YkQqKm7jhQdDLdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZ7DA0loYiPOk4fh6s3Rel8zamXPQrtcsGln5YiLYv3EUff3LreDo8gdInAG1k77BDXiP6+Zt51PCSCA4EE/nwkmJRSFBMaHVYIeRqM0xMWhhRjx1OVRQN9/r6/oOmRCF5aTV9KOEBxpjsnaJc739NQq2Lgujupt77VtMEBHYmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ixQWwKBL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ixQWwKBL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736948289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VjQa1OLpSyM90kBGecP1wvm0KvL1YkQqKm7jhQdDLdo=;
	b=ixQWwKBL8oO+v4WSu2U9s395xImpNBDyeikyxD1XwqFxYBoAxvqKkJx1Tor9iktN6P37ss
	66DiaelZs4v8KE9vmxAqm5hv/ZmkxCJHFVnOOehCgZ4hBdikg+3Vs0A6Vr1ZwZuZPMQRf4
	e0zlonr77sKugQVXGCrUR87gYy7TZ8A=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644--5uiPf71OpypG4xxtQyH2g-1; Wed, 15 Jan 2025 08:38:06 -0500
X-MC-Unique: -5uiPf71OpypG4xxtQyH2g-1
X-Mimecast-MFC-AGG-ID: -5uiPf71OpypG4xxtQyH2g
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-21650d4612eso177333745ad.2
        for <gfs2@lists.linux.dev>; Wed, 15 Jan 2025 05:38:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736948285; x=1737553085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjQa1OLpSyM90kBGecP1wvm0KvL1YkQqKm7jhQdDLdo=;
        b=ai1KqSuIWm8K/vSIPzPUTkgKlCIOszA9FsF+vqLv9r/4Px8tpqg0xydvF1i6ZzxKI4
         VfA8Wkd7EEH2km7eazeO17mRWGpUeJZ+OIMbCTpCqwNxdGMM+wi+y7nzHPw+4emDbHZ/
         nueQyHUTRwlxFxjW5Yk8643YB8oxfA+QvyiOO4vclO1joBq+DUGsWUyG56psXDaap/fz
         NZkNPyakjjShPg8zrkQkQ9BTsjaezfBqppC1+AXvk23cNV5gTy7tZvzqGN6WiFinGdDN
         TUIL2Bw5ZkAIW7VmITEH4qJXeAmwfKXzyoXnx7yqA5KOT7axMOlB+uLLSrX0VL67kbJF
         Stzg==
X-Forwarded-Encrypted: i=1; AJvYcCU57pBNvAHYyII7TJOkmhGnEMo8T7d5/PLn0IYqBwVhSLehx/k8X9/n8bai3gMd83PgA5Sw@lists.linux.dev
X-Gm-Message-State: AOJu0YwoNKC4HXqD7G1mfhjaBMKHRWb++HKg19CVkRrpaCU6I3ReGBOI
	74cYqhKDe+weyckQNgamqkwpei69hxlN51H1heZ/vZKGtmxbECcinZbx6rE0K3FBZxQWEOfsyHu
	Piry1DpXrrIY1s00LcByKuIYR/bIxwlCWVQCpp2aatMwkZ4qJDXZQOkMvyXn6TyBfhWNglVlXxR
	i52XCGKFZJvKPm//D4PFUKaJqxzw==
X-Gm-Gg: ASbGncv7jaKG35HyjqmUwkUjtJuWMMRlps98KTgxRKLYaB8viLxAGLiJyLPV5kcVbfE
	T4Ocz03InycjzOcORDxGB21md8aDTp/gfvtQK
X-Received: by 2002:a17:902:ea03:b0:216:2d42:2e05 with SMTP id d9443c01a7336-21a83f6fa87mr555113785ad.22.1736948285227;
        Wed, 15 Jan 2025 05:38:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErMQnmVTC/5MIwIzeYkaeNX5Ux0e7rhk5lUfGZ2fT2+jhaqfFmt9SGK4LAJYtpbYNeZW4dNZPKHk7XlcaxcZ8=
X-Received: by 2002:a17:902:ea03:b0:216:2d42:2e05 with SMTP id
 d9443c01a7336-21a83f6fa87mr555113515ad.22.1736948284976; Wed, 15 Jan 2025
 05:38:04 -0800 (PST)
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
 <86F5589E-BC3A-49E5-824F-0E840F75F46D@m.fudan.edu.cn> <CAHc6FU5YgChLiiUtEmS8pJGHUUhHAK3eYrrGd+FaNMDLti786g@mail.gmail.com>
 <27DB604A-8C3B-4703-BB8A-CBC16B9C4969@m.fudan.edu.cn> <31f0da2e-4dd7-44eb-95ee-6d22d310a2d6@redhat.com>
 <CAHc6FU63eqRqUnrPz0JHJdenfsCTWLgagX+2zywHNTcFoZA8XQ@mail.gmail.com> <958E28E8-3046-4030-963A-7A0789E8809C@m.fudan.edu.cn>
In-Reply-To: <958E28E8-3046-4030-963A-7A0789E8809C@m.fudan.edu.cn>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 15 Jan 2025 14:37:53 +0100
X-Gm-Features: AbW1kvZhqaGG_k4tyej31nWk7IyisIppO7ylJG-0Gf9Pme9vzez2SCsYE1LPqCA
Message-ID: <CAHc6FU7OjuDqTfdG+rAmEsfi_6LhNRcaAEYcdE+o+HXPywOYMg@mail.gmail.com>
Subject: Re: Bug: slab-out-of-bounds Write in __bh_read
To: Kun Hu <huk23@m.fudan.edu.cn>
Cc: "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>, Andrew Price <anprice@redhat.com>, Jan Kara <jack@suse.cz>, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: C217b6QxpsOQzQpOT7UUOp3iH1cxjz9Yxg7xVaAo87Q_1736948285
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 2:25=E2=80=AFPM Kun Hu <huk23@m.fudan.edu.cn> wrote=
:
> I've posted a fix and pushed it to for-next:
> https://lore.kernel.org/gfs2/20250114175949.1196275-1-agruenba@redhat.com=
/
>
> Thanks for your help,
> Does the patch need us to test again?

That surely wouldn't hurt, thanks.

Andreas


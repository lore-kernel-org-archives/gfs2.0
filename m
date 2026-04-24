Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C5527453
	for <gfs2@lists.linux.dev>; Fri, 24 Apr 2026 22:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777068768; cv=none; b=kBc/BlrwGydT2acAUK4+9vX34KCcsF+vv+/yMv4Zm3FlP31RDDCwM0f9dFJZ9M3e9rLXSOLZweEYZu8DuO7nTHQoT+Y8gVFQNGXKfxTuWf6BnPtGwmx948rDAJwraDbIV5zPVFTQYwPByYLkQw76ti4WLVO99B1ohFYIIQSr2II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777068768; c=relaxed/simple;
	bh=wIaRuK8gLS386f9UQ92xDRFn4p5F59WSxno8IU7xsI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzGy5BUgirrQCHLGG/mY6RThanglIgVNWBI0ySkHFc8YQwX43w0mkbfPNE1O3z7P7rx96BpBJnXUp2wUVZg5O3Mh1yrbABxWSHP906yvh+AatbdhG5yAxgGa0Y0RJhoU9u5ivFFzI5xMjRq735+lTyyerBe+Y7kwAz+JTDDJI3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NRLnyrTL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NRLnyrTL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777068766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0CiVP/phT3FjS7h7YodKuSuIf2r0CER9NTg1CV7qNJE=;
	b=NRLnyrTL6DKAwutN4360ytivqDaNpSWQcWeAUmW6OX7JjptcqqJQ7ClOsLEzG8c4O14Yia
	gREZUierZcVP+h+37UyG+6kXw/6Y9pjJgtq6yAjKrFpBc8y9/gLskQ7ZLK9a72C7vRkTAH
	CveFgFmRxa10p7p9/E8GhsW/8LK9Xbg=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-VAl0bqWnMnW5Oi6PO-iHAQ-1; Fri, 24 Apr 2026 18:12:44 -0400
X-MC-Unique: VAl0bqWnMnW5Oi6PO-iHAQ-1
X-Mimecast-MFC-AGG-ID: VAl0bqWnMnW5Oi6PO-iHAQ_1777068764
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7900fc7033bso222687077b3.1
        for <gfs2@lists.linux.dev>; Fri, 24 Apr 2026 15:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777068764; x=1777673564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0CiVP/phT3FjS7h7YodKuSuIf2r0CER9NTg1CV7qNJE=;
        b=pMN8607VBKXP/qz1zTciHnGk4O2nNjCzBntiB/ldW/CVyZXLaeVQ1yvFe1OW2/9H3L
         lAwH0zBI2E6eudpefjHxMF+lCoXJQj7CDONhvf0wPypytDMFxxj1SxidItq9sPuE3tu5
         vNiGkNSzWqGt1Ot27e2epUT3U3e9YvYNXfG/FcXMuEVlackWkbrwi+pu2SXGpHy9Nukk
         QimR0NXgIYqw22vuc8GhVvJ3N0Ad+EmqSqEwQbrOrDb6XVsUTVjHk6urKV//xCqsQdUW
         /IgparZ20m/hsRJWKcHT0x3SxMA6ijcrCTBnui/6AJeNqtZCnJLlonRvwXCt3akD/2Nz
         n7MQ==
X-Gm-Message-State: AOJu0YxnIaIzbUmVq8h5xh6KbinLkug5m25TRD7PGJZsnTFcNm9GogEj
	rKo4WUWJ1H2BRH8ON27b3u83wukeQcvAl8e6/v65dn+O5zQ2bDxVyoL32WACJMTkFWDVMdorIfb
	FfChoPQZ1bwT634Gyvg33x/42y34dQAb9c3OeAcBtdTIgeI7xpU4ltiIUSyv7fOMcuLEBPFJGKd
	2pX5ijj66NA90SqleCHhAB6cAWQsW4qg==
X-Gm-Gg: AeBDiesG9s9t9eupD1qAJS3gByW2xEzpq+KhP+CcI0xDpJ2ugA90Wo+BT+73W7RwXxk
	PvjNAqc6fc2iRIpAq4/F5SUmdQWtQHFfZ0K9iGdJD+Xkpe80Cg1pl4AQ178CQkzoXgHlXCpjHxR
	Di8NzrVQreeCG0gvHlU1w8SigErwqdLOW4jWYXt+BIaxNndScfHxREUSd78y2RP1cfoSfmt5oHz
	QTwl8S8r6lDIBBNxg3adz/LZzYbMmA+J0muCkll6rJ8FLmQ2otmQw90mzmz7lohK9hNea8+4DB8
X-Received: by 2002:a05:690c:d95:b0:7b4:6f40:639 with SMTP id 00721157ae682-7b9ed3d1a9dmr263127897b3.17.1777068764121;
        Fri, 24 Apr 2026 15:12:44 -0700 (PDT)
X-Received: by 2002:a05:690c:d95:b0:7b4:6f40:639 with SMTP id
 00721157ae682-7b9ed3d1a9dmr263127697b3.17.1777068763642; Fri, 24 Apr 2026
 15:12:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHc6FU5C-qu_mtN8FnXy3nY_jnskDr2EQqESqCrwU4MrDy9_VQ@mail.gmail.com>
 <20260424205130.686-1-2200013188@stu.pku.edu.cn>
In-Reply-To: <20260424205130.686-1-2200013188@stu.pku.edu.cn>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sat, 25 Apr 2026 00:12:32 +0200
X-Gm-Features: AQROBzAxKuaz-dCqlugEvyPHAXm9i6JeYngfxr-1pzXC2B3xo23KNTjhAjjCnxQ
Message-ID: <CAHc6FU5bDO21eusfH9Vcb0E65BWkvbqVSADZ9O41zCX6-1i3aw@mail.gmail.com>
Subject: Re: [PATCH] gfs2: keep per-bio end_io when splitting journal head reads
To: Wxm-233 <2200013188@stu.pku.edu.cn>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sJk4BBXQlf5wHB5qBMmMCPyBgMxpTy-IZHHLNNEEGSc_1777068764
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 10:52=E2=80=AFPM Wxm-233 <2200013188@stu.pku.edu.cn=
> wrote:
> Hi Andreas,
>
> Thanks for pointing me to commit 469d71512d13 ("Revert "gfs2: Fix use
> of bio_chain"").
>
> I had missed that revert. After looking at it again, I agree that my
> patch direction was wrong, so I will drop that patch.
>
> What I can say about the trigger so far is:
>
> - we reproduced this on 6.18.5

Okay, commit 469d71512d13 ("Revert "gfs2: Fix use of bio_chain"") was
added to v6.18.7, so no surprise there.

> - the report came from a syzkaller-style fuzzing run
> - the crash happens during GFS2 journal recovery, not on a normal data
>   path
> - the stack is:
>
>     gfs2_recover_func()
>       -> gfs2_find_jhead()
>       -> gfs2_chain_bio()
>       -> bio_chain()
>
> From the code path, it appears to happen during journal head lookup
> when the read enters the split-bio case in gfs2_find_jhead().

Thanks,
Andreas


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F351CD15
	for <gfs2@lists.linux.dev>; Fri, 22 Aug 2025 12:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755865174; cv=none; b=qJcnpZpB3LHDxWSU3agAeRO7EtpvAJuV9DMpPONGFUkW0qxqNmxetm7yuvcjW0jXHmU1x6fN7dTh7/LCEWFQF5B44c8CXII6UUDIkzOgFZpbL0ynOS8trB1EqO8Be5JthjC/zytqQNfd2pGZMaBNYAKog+R+PSaK1UpBczU4OMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755865174; c=relaxed/simple;
	bh=AHo6zHMKJprCnAHqLp3w9k1VmmN+kLymmxtojJkG1aI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHcKKjWHaZWySi05KIc6PHRXyOBcz3qZtTSCu3Dax68/6OYsEyuMfsfS7EioGtkQrmWbjYQ/LJbKbgGhDpFuOd6VBrRbtdwrVC2zHxnTi+GJxDj2f9uzpR0oCz89ZFBdoxsKbmeIiQJWtbTqys7VckzJXIekZBDqIsWDdGwQ/0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jma2PRnk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jma2PRnk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755865170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AHo6zHMKJprCnAHqLp3w9k1VmmN+kLymmxtojJkG1aI=;
	b=Jma2PRnkM7o3Ln2/g1wyXuuXte69SRbrQK2W0eFiby3RJdU//Cc45g4L+RxCbvEXQ3sdj1
	d6rjpvvKXu/BzvFTaffMAkyY1kRGbqjjq7ccmC6mjoHdnwQScb6ydqdJwPRqcJeag06wZE
	FWbQ0I6C4q7ockRUZ47gHyi+hZQm6Bo=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-avT_mDQmO4-2u7FSxXaVHQ-1; Fri, 22 Aug 2025 08:19:28 -0400
X-MC-Unique: avT_mDQmO4-2u7FSxXaVHQ-1
X-Mimecast-MFC-AGG-ID: avT_mDQmO4-2u7FSxXaVHQ_1755865168
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2445805d386so26236855ad.1
        for <gfs2@lists.linux.dev>; Fri, 22 Aug 2025 05:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755865168; x=1756469968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHo6zHMKJprCnAHqLp3w9k1VmmN+kLymmxtojJkG1aI=;
        b=cfFqiKRm6jHn8cSHJQG2gZKJiOoudRgw3ur9Ln2RQ7XtPTF9iBDNMsh/E8YdH+Xnm8
         A8Z20BDPJq6MOvP0DzXKn4sXBOPdPqiciggcY4e7+L2XJahtGkblyRiJ1YNFX4rN91s7
         MtA6Px2dTOwOaE8ZnBduTXDYF8GeJQ6KKR5dsNdfaWKC0QFdrLiNTewisJg/18Zgc0QL
         pnHxV+a5nN13yLvsxzJrP/sZkQldxAuH/XlyzitfCEZiop9GbjIina/EakPozwn9yW7+
         yHR0LzXGlk/VxEkOtxre12CUoDYwZ9+nqW+os1IFOzCDhssUmA0qiEzncj88fsYJLCbr
         C8tw==
X-Gm-Message-State: AOJu0Yw8vmhOUh/wB+JmxS++vBcQc7MicopvUTxa00DFZwlYlfTo2t/8
	52MIY/iDbdTjEreW/ZkeBsekxGGFiTMu8TxhHi2akOaMGj4fDhua2cfzsoZ32t2jh7eheBAu9SQ
	bjuyQM111OL9thCahrcEVLvBcYnyGbKkCPkVFA/opkqJJOuewRbbF9s8fzoyHZzgTUzfXCjk1Cj
	jhqx/cbIs5YFTvn/serb0ShMjkYLQOvA==
X-Gm-Gg: ASbGnctI+CDgNU3bvbZ/4/UPrwUrTycCBJMU4+cBPoxNm8j/B4NAf6oEtbFi+ESqTEf
	LHZw9pLNB4Z1vPODaaSNMbZG5axGCDZnQMldvIZHvFHLdzkYK1WKGjh6hmaAcsJm/zLFpSQ9hu+
	NKM18z7txw4To1yCAo9Ak=
X-Received: by 2002:a17:902:f68f:b0:240:5c75:4d47 with SMTP id d9443c01a7336-2462eb38003mr44147505ad.0.1755865167611;
        Fri, 22 Aug 2025 05:19:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGltbwVY9rGHjNKK/ksNupWiaO+yYsYdcI6TnLU5vttZmQ+Va1/nvZW4dJUtIf4GuTRs/6KYaAz0AtXNie8hGk=
X-Received: by 2002:a17:902:f68f:b0:240:5c75:4d47 with SMTP id
 d9443c01a7336-2462eb38003mr44147195ad.0.1755865167218; Fri, 22 Aug 2025
 05:19:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAPYKksUjLP-tNuUCC2Vg7uZ9btE6yMkAQQ-7X332522s-jOXOQ@mail.gmail.com>
In-Reply-To: <CAPYKksUjLP-tNuUCC2Vg7uZ9btE6yMkAQQ-7X332522s-jOXOQ@mail.gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 22 Aug 2025 14:19:14 +0200
X-Gm-Features: Ac12FXwt5Y9VW3GNZfjszomz11LcTqVwkh5SQW8rlqo2DUtA9vPw-EHYMaTXB5Y
Message-ID: <CAHc6FU5L8k+BurgqNkb_eCB2av+Te-VS9sabcB7ffbZCKLNmxQ@mail.gmail.com>
Subject: Re: Resource group glock granularity
To: Mark Syms <mark.syms@cloud.com>
Cc: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FcBPkuLvMthJWuO5ETXQ7T50gtRqWhQs6rOJGI-plhg_1755865168
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 12:46=E2=80=AFPM Mark Syms <mark.syms@cloud.com> wr=
ote:
> Hi all,
>
> Sometime back I seem to recall a bit of discussion around modifying
> how the glocks for resource groups are managed, basically with the
> primary objective of making the glocks control node to node
> interaction and deferring node local collaboration to some form of
> more local, and thus less expensive mechanism. Did this ever go
> anywhere?

Yes, we've got the LM_FLAG_NODE_SCOPE flag. That's used for resource
groups, together with
rgrp_lock_local() ... rgrp_unlock_local() for local exclusive access.

> I think we in XenServer would probably be quite interested in an
> approach of this form. We see a number of things, which are at least
> partially, related to our workloads being a bit atypical. We have a
> number of VMs on each host all accessing r/w one or more files
> containing their virtual disk data on the GFS2. As these files grow
> dynamically (they're qcow2) we can hit contention in block allocation
> under some scenarios like start of day VM start up. Being able to
> acquire access to a resource group that is being used on the current
> node without a full demote and data flush would likely contribute some
> useful performance and contention reduction improvements in this area.

You would see resource group demotes if multiple nodes contend for the
same resource group, and no amount of per-node cleverness will fix
that. But if the qcow files are spread out nicely across resource
groups and there are enough resource groups overall, there shouldn't
be too much contention.

Have you looked at the block allocation patterns you are getting?

Have you looked into "chattr +T" for directories which causes inodes
created inside those directories to be spread out across resource
groups?

Thanks,
Andreas


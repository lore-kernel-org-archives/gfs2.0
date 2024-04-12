Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD6DD51E
	for <gfs2@lists.linux.dev>; Fri, 12 Apr 2024 06:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712901669; cv=none; b=sDcg9H2kgH2zk/n8/RuWjjZlciiOH3VlU7+uahdhWIgdg9DL4LPCWcBLfysAMGtwPA4lGQvGRekVDN9LD98nH9dx+VPYop9iYNBb4DPM5bHJoqtFVeTRCPEEtXMrYkUy/B1IpOwoynRDMuFIWj1UzzGQNZqzqIPNi9hdSQLlD4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712901669; c=relaxed/simple;
	bh=wEG6QSytqo1ohq6Juej7jE/IO9BVkMMXEDxw0NB0o/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=aJCJdCWahdg7/jxjSpJh36W1vwWewAt0pYZf/Z72wTkCrkA9Q10fLnype7WiXMOVSVfNkNbB31YY6M48ZHNOtOd9zvC1vl4INwN2tvLRfyS922LwkFp95CWpmeYYaeHrX2FZSgQ97L32Z4HrdE/IUPjj3/iZ6P0GXbFpifqEOgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R8d6y775; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R8d6y775"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712901667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8l0WklzArYiBnL1KkTcJOniBDgTljluKZTXZbEDnKk=;
	b=R8d6y775kHslI7owE4b52mHyM14gSpurRhsXz33Qo1Oa3eZZjLJIAa7CrEBRhNS19zAMAZ
	Xwcr631iIIORStkgl7iGhJRT54MrZTTJ+8xB4QmC1BnbsFkm4ICn1VGhQipHyxYODHAZY6
	MaCTnwZVL9uYnqlubGT8b0wd8d5A/+0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-yi8kjAcwPGaVt3bzxpv4xw-1; Fri, 12 Apr 2024 02:01:05 -0400
X-MC-Unique: yi8kjAcwPGaVt3bzxpv4xw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-29bf071cc04so587855a91.0
        for <gfs2@lists.linux.dev>; Thu, 11 Apr 2024 23:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712901663; x=1713506463;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8l0WklzArYiBnL1KkTcJOniBDgTljluKZTXZbEDnKk=;
        b=HRsl81jZTZyDvtYBSZTCgQ+0TsIBxfNTiutQVR+KQbSNJITMBbv2OxqgAzRQbgoMXv
         ZZyKGDeu95gcbkq3xxGrrNyYwmbhcajNTNLyJYh4N0+enREmn6bO7XGzQPjRVK6ThUs9
         X1uCVzXmcCNKeWtWr1eIKj4NIjCI6ncOB/qhWAIEfmYM2dRbCGg1BL5PfQZdYYA0AarJ
         yFDdIRxxZVCozvi8upUmN78aaU/FNlpjzPKESM4sHM3Kzt+FII1A9JGOi6xeeV/pOmuV
         u+/0M5sB4zVAhvYj/H9LHdMPdnFK6Eyhy4xddOzUTRIXOAQQ6KQrdWgWtaKypjSSc6KX
         NRgQ==
X-Gm-Message-State: AOJu0YysdRUQ/7mDV6dJZlRbmKOHUJiO8n4hAyNFRUbdjzP+DpQQEXX1
	AhLOM6jH0lET7iijRvGcjRpDSlUMj/aGm3fSyMq05ytQoau9rwHWZFt7oIyW4tfBPRBM8wx2ZhF
	CoEKjXwEmaqBYYFOkyitF1NMEU8H+yIIPjSlGQw7OolzX/NUuCtcAhYPI1ArMhH4VJVYJ1vGGda
	mPVNBHmO0vZxS7R6yvQwJHBEnJEVGshFIMHg==
X-Received: by 2002:a17:903:483:b0:1e5:963d:963 with SMTP id jj3-20020a170903048300b001e5963d0963mr1332576plb.68.1712901663488;
        Thu, 11 Apr 2024 23:01:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLJ7N6+iyBzfsX2Sq82FRFRPH3GGexHMxNdyDXQddN5k6icm0fPmp4ya9jUEBQVCqpeOHgVrRlkWHOaRoQoNU=
X-Received: by 2002:a17:903:483:b0:1e5:963d:963 with SMTP id
 jj3-20020a170903048300b001e5963d0963mr1332565plb.68.1712901663141; Thu, 11
 Apr 2024 23:01:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240409164508.79570-1-agruenba@redhat.com> <20240409164508.79570-15-agruenba@redhat.com>
In-Reply-To: <20240409164508.79570-15-agruenba@redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 12 Apr 2024 08:00:00 +0200
Message-ID: <CAHc6FU6H9CL0Z3GpMR6+DDTvtXjR8RszmQd=FaLTwae7xGY=Zg@mail.gmail.com>
Subject: Re: [PATCH 14/15] gfs2: Get rid of demote_ok checks
To: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 6:45=E2=80=AFPM Andreas Gruenbacher <agruenba@redhat=
.com> wrote:
> The demote_ok glock operation is only still used to prevent the inode
> glocks of the "jindex" and "rindex" directories from getting recycled
> while they are still referenced by sdp->sd_jindex and sdp->sd_rindex.
> However, the LRU walking code will no longer recycle glocks which are
> referenced, so the demote_ok glock operation is obsolete and can be
> removed.
>
> Each of a glock's holders in the gl_holders list is holding a reference
> on the glock, so when the list of holders isn't empty in demote_ok(),
> the existing reference count check will already prevent the glock from
> getting released.  This means that demote_ok() is obsolete as well.

This patch only works after a few additional patches I haven't posted
yet. I'm removing it from for-next for now and I'll repost later.

Thanks,
Andreas


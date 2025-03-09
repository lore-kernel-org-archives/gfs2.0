Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE04CDF42
	for <gfs2@lists.linux.dev>; Sun,  9 Mar 2025 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741541645; cv=none; b=da4jsdiLEjUw7kqisAnS+PluP2IXgyGqGTST4izLZY9HV84yVPazcMGwaABIp1K8pW5Pa0Fxh39+s0Pmaa4hA2GRcmEz+rvsQRTIjaVZMj8TEarXgMXgrmSmCC5JCrmYezkEXBU/3hskm8ynmf6BwG8PCEJg2mjTTsSulpD4H6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741541645; c=relaxed/simple;
	bh=fMVKskE7Q8/lZwKf7tiT71cx60kbHkttSCWa1kajUqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r4nzvxrGdE4uBXkfV0Df8AtPuWxBnfpm/JvDXJWJkmxv3h3ETzbHste/ehBkgi14ca+p8+r0+8vUakx8NG86IG5fVi4z/5POiw6YLjoAq929a6e4d/kFBgzwc3x2G/Wm0gzXn0sTbvzbzp8bBoGhhvcZiyq8LxXTlWqktdF8ybQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W31K4KqX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W31K4KqX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741541642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DmLhabO1XEsdw99NpFOA+DWcEKy6BuEgBtPqezHn9J4=;
	b=W31K4KqX95kGVOHXo3zD8j8YUKxCawr4gULX01FFASDcbGdRuOoR6larqsaetNxWkkl9++
	0hsA6p6M8Bxe8fxTRgtiRdJ/6LOIZCSH/JmHf4Sq0Uq933PYA+HZsGEF3Vb+7u8mvTmKlt
	LdvyCdgXY/Ijmwu0se08hGnxHLyorAo=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-TId2AKDMOsmQ8Y22FqUM2A-1; Sun, 09 Mar 2025 13:34:01 -0400
X-MC-Unique: TId2AKDMOsmQ8Y22FqUM2A-1
X-Mimecast-MFC-AGG-ID: TId2AKDMOsmQ8Y22FqUM2A_1741541640
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2254bdd4982so29991935ad.1
        for <gfs2@lists.linux.dev>; Sun, 09 Mar 2025 10:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741541640; x=1742146440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DmLhabO1XEsdw99NpFOA+DWcEKy6BuEgBtPqezHn9J4=;
        b=JxxEtyH8D+U5ZlHXJpTC5/IKmtKTx5SmymfgWZfaNYxf+AfpUC+74Dc/wa3U515vXt
         Bz7lAXMw4gXiGzdFNCg4Q8rLaXr8mEsYpe/jTkHYvSbGhNCPvtERXQ1RwL5eYwXxMniJ
         6yKKbR13g0sW5ZkuSKV57dw1B5lm3i0bNnIQ5gw5yU0m/SUXkEYtXnaimGUe9BmGsBt8
         V/ahO5nnpzE4tDGu9wKmQ1lPNK6kwdc9SSrNrnIgzruNZkp7Xf5B0yY5BsP9vNN0thWh
         X6kKgK7Ogmyr0mQheQm48DVDcaS31F8OJnjGNSwDGR4g/gFZf344QaQPko8e0+OiTLf+
         jrvQ==
X-Gm-Message-State: AOJu0Yw0UKxnhu7nHyXCAZV4s1e30ZSo1LL74Ui90Uj/V9i5CFepSrjz
	cvIH6YsEoS8ziTNzEa2ndmA4/S7InI6tDrHBBNyMgfN1xjxBsntyoQi8b/PgPPpHBLJykcRo1n5
	DXrXad8atmlFT8zEg8z8YzdXVbNumW2oriUzNa0oApep3JBcWyjMnYvZVogqa2COqfSDob9QWkn
	Wt1s+XC5/8ZHRrWVNz4my4WD/iRQ==
X-Gm-Gg: ASbGncu5cqNwv9eUNVBOXx8TVC2QnQjnQ4aZarm8cHnYa3ElXuzb6ZRv31+nKjmMAIP
	jSdAT4wttAKYIvmzJdhJPlN/uOm3agjzK8RfQ4ydd8JMmai4Y7r6ICcNBoCxCNzQ0feJt8tw=
X-Received: by 2002:a17:903:2f8a:b0:220:d078:eb33 with SMTP id d9443c01a7336-22428ab698dmr156278805ad.36.1741541640131;
        Sun, 09 Mar 2025 10:34:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFukraV1Q8JcqSsCUG1/QQFSk+SXDpOogbXDbjBF1ABHjsafIb8pNaLjfD84LDudRXS7nQ/UNEqZ0QXbcjg5IM=
X-Received: by 2002:a17:903:2f8a:b0:220:d078:eb33 with SMTP id
 d9443c01a7336-22428ab698dmr156278635ad.36.1741541639825; Sun, 09 Mar 2025
 10:33:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250210133448.3796209-1-willy@infradead.org> <Z7czYNwTg7l0nu1i@casper.infradead.org>
In-Reply-To: <Z7czYNwTg7l0nu1i@casper.infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sun, 9 Mar 2025 18:33:47 +0100
X-Gm-Features: AQ5f1JqH3j8Oyerl0NbKTVltYL6oMIII_j8bQWKKfIPw26Z02CddhD3WyX4TN6g
Message-ID: <CAHc6FU55LOT6xS9J2kV4hG7bbCx0Ojm+1t7QM85beFXSvJEa4w@mail.gmail.com>
Subject: Re: [PATCH 0/8] More GFS2 folio conversions
To: Matthew Wilcox <willy@infradead.org>
Cc: gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FtcEgqspqARbBhVfxt9CcC2CeoqhfGbaiBdFL9196oQ_1741541640
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Willy,

On Thu, Feb 20, 2025 at 2:51=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
> On Mon, Feb 10, 2025 at 01:34:38PM +0000, Matthew Wilcox (Oracle) wrote:
> > I think this may be the last batch of patches to gfs2 for folio
> > conversions.  The only remaining references to struct page that I see a=
re
> > for filesystem metadata that isn't stored in the page cache, so those a=
re
> > fine to continue using struct page.  The only mild improvement would be=
 if
> > we could have different bio completion handlers for gfs2_end_log_write(=
)
> > when it's using mempool pages vs folio pages, but that may not even be
> > feasible and I like the current solution well enough.
> >
> > This all seems fairly straightforward to me, but as usual only
> > compile-tested.  I don't anticipate the change to buffer_head.h to have
> > any conflicts; removing the last user of page_buffers() is not on the
> > cards for the next merge window.
>
> ping

thanks a lot for these patches; I'm adding them to for-next.

Andreas


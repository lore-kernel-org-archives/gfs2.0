Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10281293454
	for <gfs2@lists.linux.dev>; Thu, 10 Apr 2025 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744312822; cv=none; b=dNbO8CpLtPF+xSDkdev6tGXAjhsKbCAuH+4mS1MmRK7pADUa52ZuFnjZyDeNbSqO3VdP/+0GaQIU+sGfGrBl7xDIn8S0QFy7yT4T2i2m7pa1QN0yBtMoF//bUOcE5yo4Z1JPB6HEM45hpHfeYxi2l4MwtaMZ7z37/RlGt7wGhgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744312822; c=relaxed/simple;
	bh=BUp6dVA/9/DIHAm8btLSsebQGLRoM6QqRKm/vQlyaG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BctU2WcqX6MAz966Qu/R5yH9qdoCqbB7HPeuxRjn4583dB0L6pT3XU3/PvZEIRtHIgUc+2vDCKlS06Ycqn6ZrHcd93Cj36oskCeug+kgAFcxceb+gKD29cp3R0Cv5NcLmPgXAXJEO8RXFATljho4dvSAXuElpdIq4B1vQZwjhNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z+WwOThG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+WwOThG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744312819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7qyuCy71sNM096ptCCI9TtV8xzN/TLmJLvM6k58//nE=;
	b=Z+WwOThGgx4z4zWwd9z0btu8E8uRs06DUMENdvFe57l3vv+a3Lfi4S7VIBnXpUB3WHAvdJ
	7uo5W0hM+mjB8c2iDYQ2oY0Qfp0RowLfnk5YyhBE2Vfq2+m0rbwg2bNcWWEibdeEheJBGK
	KmANNOSr9P0DWXbtpuIfkwC/uaKpaS0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-ROmlc5WAMEKvgb4eqRMaUA-1; Thu, 10 Apr 2025 15:20:17 -0400
X-MC-Unique: ROmlc5WAMEKvgb4eqRMaUA-1
X-Mimecast-MFC-AGG-ID: ROmlc5WAMEKvgb4eqRMaUA_1744312817
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2242ce15cc3so9320185ad.1
        for <gfs2@lists.linux.dev>; Thu, 10 Apr 2025 12:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744312815; x=1744917615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qyuCy71sNM096ptCCI9TtV8xzN/TLmJLvM6k58//nE=;
        b=BC0/u9Y2ylBqSYEwpbke0TwZ5YK2xDo9gCZT3te5EOoS73XUu7JsTa9fkdueGubFqq
         p+JZweOJmSmrubo9uZ3Z9bm3Ts5uZbvuDM9aK51w616a3uU8kYFeVozovFCswJaPzWmq
         0TbmuwgHnPTLgyTIf1euSYZSQjHMlYTwQS85idy0bGUPaNx8A+CFTequjyO7+GHVaV7Q
         YNe2hvz+Sdjx8p74SugSrIpEqoZEbIfVsbni++TondJSDibhasXI9AoHGFNpd/2dhfQr
         U6eSL5OvOMZhEtz7SqFL2Xpjq70Rs+gIZ8rS/ZFMD5d+QytCHpnx+iO7tnWDj21cLFwh
         GAAA==
X-Forwarded-Encrypted: i=1; AJvYcCXgMPntuAJ2D0i9w0zFRb7iuOZuR/CBM8vY3G3ttc88l1YdhEVnhLDbdIDpfZ0vZTpvvKMD@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6jdTlFX7H2BlK5ZLy5+W4tt0yZE1NL2PA2Vsg9iZAtjxvKZJq
	BcqL9aWMwg4dr3b3EgWXRWnzs8ILY0V5knw3psQJynukp3C7TfLUBYA3dAUcQgNw5TdMiJBk307
	kFV1IjD1OPMGsC0dQLdrc4cifx/M0CMUX2yl9vbGJeNb1nOoghh+UbXMu6iiuUd8Z2Gp5xTz7my
	vk/vnHX3j44jbxcHewvriwz1q6nuns9G8PPIiR
X-Gm-Gg: ASbGncv/itT+cRvDkDywHOGDcpq/Jm7H1vJHsc4gGAchPvmRWuFSZ+lqQsqiC+VJdvG
	iMhREoGPBYhOTuCIiTYEq4AXyFdvexHOXFhCArBCM/ZvqGfnsQ86j2XYEIgXd2BlQ6bE=
X-Received: by 2002:a17:902:e88f:b0:223:2aab:462c with SMTP id d9443c01a7336-22bea4ab85fmr71695ad.15.1744312815423;
        Thu, 10 Apr 2025 12:20:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6DNynR3qAzVJ5oYYe87012HehD64MJOEbZmJ5Zs6nbMEMT14kmxUjgfXc/J/nlg5RXQ5jsTdGAdgJRpiy1tQ=
X-Received: by 2002:a17:902:e88f:b0:223:2aab:462c with SMTP id
 d9443c01a7336-22bea4ab85fmr71525ad.15.1744312815145; Thu, 10 Apr 2025
 12:20:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250407182104.716631-1-agruenba@redhat.com> <20250407182104.716631-2-agruenba@redhat.com>
 <Z_eGVWwQ0zCo2aSR@infradead.org>
In-Reply-To: <Z_eGVWwQ0zCo2aSR@infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 10 Apr 2025 21:20:03 +0200
X-Gm-Features: ATxdqUHNINlL-pUTFVGgFjmH-0Yv2T34SdJ_H6wPly98qpm7VaT0OlGqfhHJNig
Message-ID: <CAHc6FU4J6MsEaUFUfp_ZpuYKyXRpZ=FTJE9T=iRQgbByQWZOFA@mail.gmail.com>
Subject: Re: [RFC 1/2] gfs2: replace sd_aspace with sd_inode
To: Christoph Hellwig <hch@infradead.org>
Cc: cgroups@vger.kernel.org, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Jan Kara <jack@suse.cz>, Rafael Aquini <aquini@redhat.com>, gfs2@lists.linux.dev, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UFtl5ld_biI2_e05Ane_mnsBhiWO4ZlDWazKB9BJWxw_1744312817
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 11:01=E2=80=AFAM Christoph Hellwig <hch@infradead.o=
rg> wrote:
> On Mon, Apr 07, 2025 at 08:21:01PM +0200, Andreas Gruenbacher wrote:
> > Use a dummy inode as mapping->host of the address spaces for global as
> > well as per-inode metadata.  The global metadata address space is now
> > accessed as gfs2_aspace(sdp) instead of sdp->sd_aspace.  The per-inode
> > metadata address spaces are still accessed as
> > gfs2_glock2aspace(GFS2_I(inode)->i_gl).
> >
> > Based on a previous version from Bob Peterson from several years ago.
>
> Please explain why you are doing this, not just what.

Right, I have this description now:

    Currently, sdp->sd_aspace and the per-inode metadata address spaces use
    sb->s_bdev->bd_mapping->host as their ->host.  Folios in those address
    spaces will thus appear to be on "bdev" rather than on "gfs2"
    filesystems.  Those "bdev" filesystems will have the SB_I_CGROUPWB flag
    set to indicate cgroup writeback support.  In fact, gfs2 doesn't suppor=
t
    cgroup writeback, though.

    To fix that, use a "dummy" gfs2 inode as ->host of those address spaces
    instead.  This will then allow functions like inode_to_wb() to determin=
e
    that the folio belongs to a a filesystem without cgroup writeback
    support.


Thanks,
Andreas


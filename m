Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF98B6A009
	for <gfs2@lists.linux.dev>; Thu, 16 Jan 2025 05:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737003837; cv=none; b=edCw7oebxVCQVid5o19Qa/9y4bBgeNHXskZ5Xdpa3PgxAORVH1Amq0C2uHDkGplbMBomGnrx105/k1AiSQbGkDxptCpxoo2z2bwmiZk17XQrJwny/gaLE8DRe8mK3YM89AdKzx8ZNiaTmCoWo84t/ucK1mWXJhT14OR5I2v7sJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737003837; c=relaxed/simple;
	bh=wELArgmung28UVW6a1djIOqJloxqOE5PObrjaTGmt24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daC9Hr+bjm/HdxR/HcRZ6fzPnai0h4QJbMZmDHK8PjiOZt2HnMdJCCkhOIIKbWO7jnsg/MexSQyLM1xwcvJN8t+MezzZWTgJWAtSRSxLiturx5RWpusV5/kx1t837UnNlIAVIH9+bjuzfz7Uerl+h4xLJMCpLB9k0vwoX8Anno4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=vZyJNRFa; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="vZyJNRFa"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2164b662090so7691685ad.1
        for <gfs2@lists.linux.dev>; Wed, 15 Jan 2025 21:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1737003835; x=1737608635; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RQtwcz66cRpnEOfOa/HyiuZRqWSGLaKRKp3+zlxh6e0=;
        b=vZyJNRFaI1ucJ01sJ2H16apgUdgR7I28/CPR8vAEVD5e55+MO1MgDOR5p5vNKuuFPF
         zCEVYBzhNH1425IWUg/uWJjFuptx/1Prxa/FT+AX6LMlzbGaMwRLHrfPuIoSVRPJpyCj
         z6du90riUSky9C/z9qQbAFtm+6Z3g9hoTPCuttzJmBA3i9dxxYa+8aeAwehAPv3/w8mS
         qD5mib+kq6BNxOS6FlG/cbugRD0U4MQfG4MuKi/1l/j/68mWG6JJIAUJ+69aMYrqJf8S
         9833bkUYqeC20CDS6OLX9ex6HpYwZComsysE+TrbpQ9pE/J1ArC1GeXHZ3UiCzym/h7c
         NepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737003835; x=1737608635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQtwcz66cRpnEOfOa/HyiuZRqWSGLaKRKp3+zlxh6e0=;
        b=Jr89poJNwxIYpEPu5664zIBkLzs5wMZ5vATEoLWu0NnlzJQqsltaVISjBpZgbCcIuI
         TJ3oM4JQGWv4hNlYHdYAUqson2S1ZFzsrNACke0upuO+ucnLAtjbQmVGc8LQ8auzguXj
         HLu5xVxl25atvZejAkYKiVso2cPNwdw9DFFUKGY1FybaPm8h3gVTG5KMkhvytPEMx7D4
         KXUXGtgF/n/gdJzdgdnekK8/TnLi2HRyZzLxEmixF+cegm2jVGOsMo4yGJDgKDY6fszP
         XKsIJbn1W/3SP+Lo8/xAcMSDszIII12Z2BG5rYKevENKldxFykVBqPFsc4Nal8bZPFAh
         gUSw==
X-Forwarded-Encrypted: i=1; AJvYcCVRUKvg60EdJtsgL0/S8SB484BQzQHpq2KWjfpVzMsGg6aw5McNcZ5c/ITfj6FlI0FS9iUJ@lists.linux.dev
X-Gm-Message-State: AOJu0YwQd6/R2Pc9INAiUVg8er5P/hGJKeI7zThjLQ+NfIp2Y0COvitr
	wQKogjDms2h1WHkuZMIk+tVCEgMmPx7Y0+PtWb1QA4GaSMb7W7oHcVR1IqhjZHo=
X-Gm-Gg: ASbGncuTyTK/hFUKwS5LmaZ1dLO4tKnIbvaA5Q4o4QOAuUXoNFVyNQlAdBCfzH0xAz1
	3fBN17+bnY+c0J7Oe6mKu/hrUmYfpTqWLy1OCNemSQdv+sFXf3+68rlnrHaTUzj/uDlY2O/KJi4
	5z/0H9VqNSegKmIrcFFZpsj5CokbNr5Dn0eEzYf+pG23If9kEhCb1ZqwbKJZz1gndUrrdKWFDEb
	oxUIUoF0sH88q32dxcFQCylfAlYVIR67WOyITL0RewoXwyaHtNVafBoQRgEj08toKxqph5CWqnM
	/IEud+CTyqQ1XFx5eXr1GT8qnNcZsHwj
X-Google-Smtp-Source: AGHT+IGNOhZ2CDB3dC9ypPRx2+QFrztyTh30xO+H1dvtRXfxPIdj2LE0KDNO2Mwf1ivGr5YrWG2u9A==
X-Received: by 2002:a05:6a20:244d:b0:1d9:fbc:457c with SMTP id adf61e73a8af0-1e88d0a4771mr34957994637.36.1737003834927;
        Wed, 15 Jan 2025 21:03:54 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4067f72dsm10406495b3a.145.2025.01.15.21.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 21:03:54 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tYI2p-00000006SjT-2V99;
	Thu, 16 Jan 2025 16:03:51 +1100
Date: Thu, 16 Jan 2025 16:03:51 +1100
From: Dave Chinner <david@fromorbit.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 6/8] dcache: use lockref_init for d_lockref
Message-ID: <Z4iTN86x2SsTVOIY@dread.disaster.area>
References: <20250115094702.504610-1-hch@lst.de>
 <20250115094702.504610-7-hch@lst.de>
 <Z4gW4wFx__n6fu0e@dread.disaster.area>
 <20250115203024.GB1977892@ZenIV>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115203024.GB1977892@ZenIV>

On Wed, Jan 15, 2025 at 08:30:24PM +0000, Al Viro wrote:
> On Thu, Jan 16, 2025 at 07:13:23AM +1100, Dave Chinner wrote:
> > On Wed, Jan 15, 2025 at 10:46:42AM +0100, Christoph Hellwig wrote:
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  fs/dcache.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/dcache.c b/fs/dcache.c
> > > index b4d5e9e1e43d..1a01d7a6a7a9 100644
> > > --- a/fs/dcache.c
> > > +++ b/fs/dcache.c
> > > @@ -1681,9 +1681,8 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
> > >  	/* Make sure we always see the terminating NUL character */
> > >  	smp_store_release(&dentry->d_name.name, dname); /* ^^^ */
> > >  
> > > -	dentry->d_lockref.count = 1;
> > >  	dentry->d_flags = 0;
> > > -	spin_lock_init(&dentry->d_lock);
> > 
> > Looks wrong -  dentry->d_lock is not part of dentry->d_lockref...
> 
> include/linux/dcache.h:80:#define d_lock  d_lockref.lock

Ah, I missed that subtlety (obviously). Carry on!

-Dave.
-- 
Dave Chinner
david@fromorbit.com

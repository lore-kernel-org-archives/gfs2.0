Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82C939A7E1;
	Sat, 30 May 2026 10:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780136771; cv=none; b=PvGEp9432ZCERdpHWk6AFfK77yGDvMjQP1apEOsz0CMQhXbB0SKKvnXkORvkrD8wRzXBF5vx5zA24CFxryJWmx3vI7BHlCOxyK9El18WajOFRE5m7sr54ZuwEx8wXlEV20AA+2nHniIf9uY+Z9v+cPR0ld+LF8FMBWoC6MCGoQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780136771; c=relaxed/simple;
	bh=I1APy0nWCxVtH0Idy7yic1P9oq98orO4OLHjiF7hHJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=koYwZza5ZD67N3NpdjgVT9e7YwfD2M6aVo3whKQV2YGYxwVeMBHaIpSzqcZgf2F6D/2DIdzccifYojo2B3cbFuG+mJtb3dWs8aDpeDOYxyjGwnp2UVYFVWntCe3P+EedOm5VkuhaY5yvCYW8EtugUJEvlcTHbB+qGUgwm8xmaM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8nFO6jF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8nFO6jF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BC91F00893;
	Sat, 30 May 2026 10:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780136770;
	bh=8SsoQMJ2L9qL3dTHMCt7hipvqyVOaqhcGkmfloj8FRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B8nFO6jFHVf/YmV6Y8jjFxEOtGNe99G5VoB2urDhZX+WnyueaS7/WS3MJYqsmbW7Y
	 biWrVI7QtjeTs4QE0PmNepSHpGA/4HDd+F6qoCDUEB8WGaKshBot0b64IYCN01k2er
	 hfhlp/dJiIsZm5ZyOWkj9Drl0s/gBjfNLACMHzcQJ8mkYnxxPx/yebJn0pMqhG3IuG
	 NHnaECcyrpJLaAzVCpiC31kPDjoiD+PyKp1GaASkvgTS9u8rcAnqbEDAD4hQPXx8Cr
	 eJ/pOko3q/zd0LgsC5ZNeN8fCnWHqqQrnWTmcbqcl2L0f2Ld9B8G+UKjwvsFiJio3t
	 2zLUDdlRdPN/g==
Date: Sat, 30 May 2026 09:36:11 +0200
From: Greg KH <gregkh@kernel.org>
To: Alexander Aring <aahringo@redhat.com>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>, cve@kernel.org,
	David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dlm: fix buffer overflow from negative len in
 dlm_search_rsb_tree
Message-ID: <2026053054-democracy-mower-0a5f@gregkh>
References: <20260517020315.1064253-1-joseph.qi@linux.alibaba.com>
 <CAK-6q+jvaQx6y_tOzks3utBWaTRjvVnDWrznBYRfWjTQBcefBA@mail.gmail.com>
 <CAK-6q+iC3AgX7r2fZkvDJHibS0oqTwVCF4ZgV-1OFkV0d=R2Vw@mail.gmail.com>
 <CAK-6q+hPM=+fXkPSbr60Y6S1O_RfYGBUeL3mfVu0H1ymZ0gp6w@mail.gmail.com>
 <2026052626-galley-glitch-dcd9@gregkh>
 <CAK-6q+ibs=hWiCPGKNdELdgiqq5kpmwDfUJdMTQkbrGGP4yHUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK-6q+ibs=hWiCPGKNdELdgiqq5kpmwDfUJdMTQkbrGGP4yHUA@mail.gmail.com>

On Fri, May 29, 2026 at 09:24:59AM -0400, Alexander Aring wrote:
> Hi,
> 
> On Tue, May 26, 2026 at 12:09 PM Greg KH <gregkh@kernel.org> wrote:
> >
> > On Tue, May 26, 2026 at 09:58:32AM -0400, Alexander Aring wrote:
> > > Hi,
> > >
> > > On Mon, May 25, 2026 at 1:39 PM Alexander Aring <aahringo@redhat.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Mon, May 25, 2026 at 10:27 AM Alexander Aring <aahringo@redhat.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Sat, May 16, 2026 at 10:03 PM Joseph Qi <joseph.qi@linux.alibaba.com> wrote:
> > > > > >
> > > > > > commit 080e5563f878 only checks for len > DLM_RESNAME_MAXLEN, which does
> > > > >
> > > > > check with checkpath, it reports an error regarding how this commit
> > > > > reference is done.
> > > > >
> > > >
> > > > This also addresses CVE-2026-43125 [0].
> > > >
> > > > - Alex
> > > >
> > > > [0] https://lore.kernel.org/linux-cve-announce/2026050619-CVE-2026-43125-c9f9@gregkh/
> > >
> > > cc the right folks cve@kernel.org as described in the kernel documentation.
> >
> > For what?
> >
> 
> because
> 
> "If the CVE assignment team misses a specific fix that any user feels
> should have a CVE assigned to it, please email them at
> <cve@kernel.org> and the team there will work with you on it." [0]
> 
> The initial fix did not resolve CVE-2026-43125, there are additional
> changes are required.

That CVE describes the specific issue that that patch fixes.  If there
are additional issues that this patch does not resolve, then it deserves
a new CVE for the new fix, OR you should add the new sha1 to the old CVE
entry.

Where is the new fix?

thanks,

greg k-h

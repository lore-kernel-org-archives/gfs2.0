Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FD7214204;
	Tue, 26 May 2026 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811791; cv=none; b=Z2oe9h9F+nSDmqfZbKz4ZxDtE0SaA3GmOU9fYC+Z08hzytUimKTOH7t+3YL38XHo2BvJiMvgg6/nystdqrirOvivWvmHRkKet1547Z93ntauVye5a6bgLV7HEz/E4E6AljKzGUL/RP1dbQeSjicOkY2K6o7V1xKSkmubgw1ZNkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811791; c=relaxed/simple;
	bh=alzg+CGUFTVXSVDf/V+IkG2KSgNHdPoPB2RbDckbk4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOf5Exw7QMqD/nBNwUEIA3I9oT1OI9+yIPbesirwzoqwPJg1+q8zfvruPDmEqRu3vFXTH73LPEgFaCJnr0RGGeVVoRtezfduNVk+24aXQERKfFxFOHrh+UDqVaN0+ZlrHPtWrTIRwhuniJnkYi4yX9dSMrGVlgXh9k+rknGxuZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJ74KagO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJ74KagO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCDE1F000E9;
	Tue, 26 May 2026 16:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779811789;
	bh=5WEY7EQ9JRJsR4v90BlVRCBMqP7klkosv5ZAOGhJ9nM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lJ74KagOgNgBMmANQLA/M55DZ0tycdDrj4c/6Tb/IIsjQCC5zruetVs5sZj0adRXb
	 6H7QoxMH/r8nBQSQehjNfiMnhK84RB1j9ak2JF3/O9Slkg/EUzjWeGuYIPqEicJBti
	 88nQC3H015sEDKn2rPqQvK5z64GB0cYmjEJY1JjML6dr9lTUftCwImP8LFNl9krr/k
	 osQxXiTl2W0ajjhy0E3vpVJx4bgB33riiX3J6bNj1mxXuolVNZy/Cal5zDah0zcKM8
	 n3rdYH+N0Kltxbox0qyZVSop96j6UHS8KcBfdUxSZHLCPUF/iok9aOhkt2z39080K/
	 Op6b5EXv6asNQ==
Date: Tue, 26 May 2026 18:08:55 +0200
From: Greg KH <gregkh@kernel.org>
To: Alexander Aring <aahringo@redhat.com>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>, cve@kernel.org,
	David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dlm: fix buffer overflow from negative len in
 dlm_search_rsb_tree
Message-ID: <2026052626-galley-glitch-dcd9@gregkh>
References: <20260517020315.1064253-1-joseph.qi@linux.alibaba.com>
 <CAK-6q+jvaQx6y_tOzks3utBWaTRjvVnDWrznBYRfWjTQBcefBA@mail.gmail.com>
 <CAK-6q+iC3AgX7r2fZkvDJHibS0oqTwVCF4ZgV-1OFkV0d=R2Vw@mail.gmail.com>
 <CAK-6q+hPM=+fXkPSbr60Y6S1O_RfYGBUeL3mfVu0H1ymZ0gp6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK-6q+hPM=+fXkPSbr60Y6S1O_RfYGBUeL3mfVu0H1ymZ0gp6w@mail.gmail.com>

On Tue, May 26, 2026 at 09:58:32AM -0400, Alexander Aring wrote:
> Hi,
> 
> On Mon, May 25, 2026 at 1:39 PM Alexander Aring <aahringo@redhat.com> wrote:
> >
> > Hi,
> >
> > On Mon, May 25, 2026 at 10:27 AM Alexander Aring <aahringo@redhat.com> wrote:
> > >
> > > Hi,
> > >
> > > On Sat, May 16, 2026 at 10:03 PM Joseph Qi <joseph.qi@linux.alibaba.com> wrote:
> > > >
> > > > commit 080e5563f878 only checks for len > DLM_RESNAME_MAXLEN, which does
> > >
> > > check with checkpath, it reports an error regarding how this commit
> > > reference is done.
> > >
> >
> > This also addresses CVE-2026-43125 [0].
> >
> > - Alex
> >
> > [0] https://lore.kernel.org/linux-cve-announce/2026050619-CVE-2026-43125-c9f9@gregkh/
> 
> cc the right folks cve@kernel.org as described in the kernel documentation.

For what?

> There is another patch required for CVE-2026-43125 [0].
> 
> Joseph I think for v3 you should cc also cve@kernel.org and mention
> this in your commit msg.

Why doesn't this deserve a different CVE id when it lands in the public
trees?

thanks,

greg k-h

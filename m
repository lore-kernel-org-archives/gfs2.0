Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C6E2C0F65;
	Fri, 28 Nov 2025 06:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764310031; cv=none; b=EZxH9XKzjXTuO1nstjyzFdS0bRci/n+OQSBz0d2PKaiN/ZOuLx3m9U+YmnEVgqaBbqBBywP+Ogk/IhFCoidknn6n+DDFI3WctXt/407eiBMOaNySzFjwsUaExLFImPdjMaaPn+wLqN9U+atr4FR2Vhex1Ip3dBzBHaKwPbKhqSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764310031; c=relaxed/simple;
	bh=+P9BZ0JGSEzbrAkr/kpkHUqAjhStJuoSRqz9Cr4zUxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcRzFQf8oBV89fJOG3dPn+J5J7pEMg7xyXNamrMzhJ+RiVZvIqswNJNqwGQ9hmxwrxPw5PGoDEfSwFws7Log1OQqYZqSRsUTglp0m2U9Rta1TsRwiUtqwXuvf9EwXJEZac7ZRm5IjtbuUdNvYg11ZMEu2+Scr3jevxIKjFAj5pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=pGG9wwn2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i1a9hL7Y; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="pGG9wwn2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i1a9hL7Y"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 0F385EC099A;
	Fri, 28 Nov 2025 01:07:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 28 Nov 2025 01:07:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764310027; x=1764396427; bh=PsuYgVGLPL
	N3KNwS6O4oLB50zFfuXsJi6ZLl8dVAPGM=; b=pGG9wwn2OX0bnfZ6tO9QSSdO8l
	5rNDvz3MCsBL+WkkTgy/HCMITMdQhgjAfWCx/9jONIkNiZYD7mgNnsTZlP0xA5HN
	ibNm5K3QOXQ5CzVASzuA7TTmHlVE13p/Yl3wkacyzUKG9JB5ELRMcuzA8pjH/Bba
	L27xV9YgyadxeDoXdvCFuXwRJ7d+suTwcpF7s7BmmtNomHhP4tibxhznl1z16fl3
	D9gNtnLbtjTFA4qQgwyYsorIiHLffOZsUXuv2fz2fVY9rSNouzakwFAjsyvFOn+f
	098oxtX7VP/5IdYA2theBWLJnZNdMs4ACvWFIkEMoqqPA3aR1x/OjY5AsF5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764310027; x=1764396427; bh=PsuYgVGLPLN3KNwS6O4oLB50zFfuXsJi6ZL
	l8dVAPGM=; b=i1a9hL7YfzrbdAGbluWTI74Pkz1VPUy5hBsdU28nXkkbdKlfaRT
	e4Qrgt+o/UF8vW+ow964DeNTONDlVCSUzc21Y64pPoID/YsVcwPxKb5YMSCdzeOh
	cq9olMdkT2wS1lcUmrgFbcCnQOud+PtIlXhQ7zzbZ0gFYjJ6NjwYo+xM73TzUQFz
	nYK8tuvUhM6vl6PP9s7sVO8KtP4cfgi2BZsch9yXX6vTC5xy0KVFmlUbq+7cvyPw
	qwt53GRESHTk5U4aNBEDA7FcL1pEVw64du6a4uAt4jZeEUvru/sCKf8WQ3RloY3x
	hqzfge3iVb7zXQB19YamZc7yCb7oX0AbM0g==
X-ME-Sender: <xms:CjwpafVikjttXBnABGT10cb8AwUugwI-DEq6HJViJ1-eMMU6G2n_tg>
    <xme:CjwpaerWc1LT3sIz5DSUQGm11DUcYMD5heGaDPc31ft04L7vZBNrHhumHNiOBDcRa
    nUmzKyWk43jBeVRh80Z0FFiM3hqRfHb45fYC0_y4kST0WbdU4U>
X-ME-Received: <xmr:CjwpaTHf6kMznlgI0C5ugGyK8SOEDn_HT-3z6QJAq3Urb2tPDNE2mYs1zPeaoLuI9TV4F_eCfmZ63sHmjVBQFhIbinHmK1oRqRrL0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeeludduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeen
    ucggtffrrghtthgvrhhnpeetuedvvdefjedtgeeikeejhfevleefieejffevtedvfeeuhe
    efgfefkeehvddtkeenucffohhmrghinhepshihiihkrghllhgvrhdrrghpphhsphhothdr
    tghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepudekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsshhrrghnvggpsgdvfeesvggvrdhvjhhtihdrrggtrd
    hinhdprhgtphhtthhopegrghhruhgvnhgsrgesrhgvughhrghtrdgtohhmpdhrtghpthht
    ohepghhfshdvsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhkhhgr
    nheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhdqmhgvnhhtvggvsheslhhishhtshdrlhhinhhugidruggvvhdprhgtphht
    thhopegurghvihgurdhhuhhnthgvrhdrlhhinhhugiesghhmrghilhdrtghomhdprhgtph
    htthhopehkhhgrlhhiugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshihiigsohht
    odgrfhegugehfeehjeeiieelvdhfkeelheeifhguieesshihiihkrghllhgvrhdrrghpph
    hsphhothhmrghilhdrtghomh
X-ME-Proxy: <xmx:CjwpaQvCwfgUlzz5Hxw4nnxHmBfutfCaUoDFQpmd5Ib2RNpFQHWGDQ>
    <xmx:CjwpaWSOs-nlvjaj4HjvzDHkZKXdG-BKahhZx0t7qQw8_FxQJlyfsQ>
    <xmx:CjwpadEpY20swccJoICRofOC93u-rWkNxMd9dGjQyV6DqPCop9xihQ>
    <xmx:CjwpaYeYpRDkBNtF1B0T0SCD6-gcP9eSzW44US_2Iu057cos5bcKcQ>
    <xmx:CzwpaQ1SGmKcRISelUNc5XPfBjIqMeFGn0_ng3xV1QaBLml720l2N1jF>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Nov 2025 01:07:06 -0500 (EST)
Date: Fri, 28 Nov 2025 07:07:04 +0100
From: Greg KH <greg@kroah.com>
To: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Cc: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	syzbot+af4d53576692f8956fd6@syzkaller.appspotmail.com
Subject: Re: [PATCH] gfs2: replace BUG_ON with WARN_ON_ONCE in
 gfs2_quota_cleanup
Message-ID: <2025112811-endorse-unclothed-a989@gregkh>
References: <20251127193247.17030-1-ssrane_b23@ee.vjti.ac.in>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127193247.17030-1-ssrane_b23@ee.vjti.ac.in>

On Fri, Nov 28, 2025 at 01:02:47AM +0530, Shaurya Rane wrote:
> gfs2_quota_cleanup() triggers a kernel BUG when called while the
> journal is still marked live and SDF_NORECOVERY is not set. This
> can occur during filesystem withdraw or error recovery paths,
> particularly via gfs2_make_fs_ro() during a reconfigure operation.
> 
> The BUG_ON was intended to catch unexpected state where quota
> cleanup runs while the journal is active. However, the cleanup
> code is safe in this scenario because it skips quota entries with
> active references and waits for all references to drain via
> wait_event_timeout().
> 
> Crashing the kernel is unnecessarily harsh for what is a
> recoverable situation. Replace the BUG_ON with WARN_ON_ONCE to
> flag the unexpected state for debugging while allowing the
> cleanup to proceed safely.
> 
> Reported-by: syzbot+af4d53576692f8956fd6@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=af4d53576692f8956fd6
> Fixes: 71733b492200 ("gfs2: fix kernel BUG in gfs2_quota_cleanup")
> Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> ---
>  fs/gfs2/quota.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> index 2298e06797ac..13f113d8aaef 100644
> --- a/fs/gfs2/quota.c
> +++ b/fs/gfs2/quota.c
> @@ -1516,8 +1516,8 @@ void gfs2_quota_cleanup(struct gfs2_sbd *sdp)
>  	LIST_HEAD(dispose);
>  	int count;
>  
> -	BUG_ON(!test_bit(SDF_NORECOVERY, &sdp->sd_flags) &&
> -		test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags));
> +	WARN_ON_ONCE(!test_bit(SDF_NORECOVERY, &sdp->sd_flags) &&
> +		     test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags));

You still just rebooted the box if this ever happens (remember
panic-on-warn is enabled on a few billion Linux systems.)

Please fix the root problem here, if this can happen, check it, properly
recover from it, and return the error.  Don't just paper over the issue
like this, this is not a fix at all.

thanks,

greg k-h

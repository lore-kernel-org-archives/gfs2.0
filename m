Received: from valentin-vidic.from.hr (valentin-vidic.from.hr [116.203.65.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C7A12CD96
	for <gfs2@lists.linux.dev>; Thu, 27 Feb 2025 18:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.65.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681951; cv=none; b=g3sx3W/06iDO8Ho2MxiuWYxwQ4jaZ33YRRfXbpQNdgSSC6LxAt2YswKjV1HEl8gEImNyN1mW/VeHuXpvlTHC78y2zBCS9ww0eQj+QnKaRWs+sDoYxfFI10NzkqP6gawuqAs6reagzeCesTr3qRcjlDhenGbqFwUoiydU3Bo0Ujs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681951; c=relaxed/simple;
	bh=xt29f31NzwE7Mf/xZ9luDl34vftgEFHdAJjTcfAylyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMi1r27XhuY+LR8zSqKmLOLEvWlfbpOPjH/BLlVB0k8Qo/Sdqj2VCQlDDHcHybq5Xfjw6fD767jz4Od6Uaex8aFfUug3CUp7ScRd6qqN6IVlFujvQhw9wnpJvZk0xCoEx0xhw/McglKhcN8LY8bnXT6cRhZRVuLwmkO7qdHqYwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=valentin-vidic.from.hr; dkim=pass (4096-bit key) header.d=debian.org header.i=@debian.org header.b=iv0o2WZt; arc=none smtp.client-ip=116.203.65.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentin-vidic.from.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=debian.org header.i=@debian.org header.b="iv0o2WZt"
X-Virus-Scanned: Debian amavis at valentin-vidic.from.hr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=debian.org;
	s=2020.vvidic.user; t=1740681945;
	bh=xt29f31NzwE7Mf/xZ9luDl34vftgEFHdAJjTcfAylyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iv0o2WZtAvNP+CghPmF+Awkk4+nMywxyxvTmeeyyQtqjwelUG6wskk8ZNR2pVB7bn
	 b+BLZ6rO/wURY4k/V474B4SCHrSOU7i3Bh2pFLeWoigVVhD427r6AbMrEWqidV9sqm
	 zadtXIKf4+ke5JMPnOD0h+rP3FHArV0xXymQx7Z1+k8/HQkPgd3eaZ5Tc5aZGSS3/F
	 JFEoOhBhwESbOfU0vhGqJ5aQ4Tz9eDqBTcCs8E8VOlk5X7OBYy6u+pdG6iW3dGqlwW
	 9xHnl1T4gokvxDT/0FpKsNLtmsHoCVgf64PUeZioDZBB0NUBAb0mNSsV8dhzMQkAdz
	 AeY/LpW5PZoYGvcd1DjO7Nf0tsUD4FP0N8Jg8wELZpBLMd2LaqT3a0wkKo0mMrfMGZ
	 Y0xl1z/x7+rFE6DJrZmigcZ4LNy3k25Hhmv5SX8N9LvgezdCDUB1a6wThxB1ZGWi9j
	 ry8D04B6Wv8XnfyfO3CPRpnudvQn/+j8dva4nFvnQYYHPUeZX0OYLFC7HNE5/EdZSG
	 NJPw2s1X46Q0QAeNBh7VIORlHWyXpLxZTFeIN/dIlgjerl1kaTl/UKf29GTyoZR3O8
	 kG+UTUzbiq8di+52UuMec008KvrTQ4rAlhHZKaNdDwxh8pdxDtwPbfZ+ReBK/pzAQ9
	 k6yykqmt+2d8OsL7+zJr7AbM=
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
	id EB9D630A59; Thu, 27 Feb 2025 19:45:45 +0100 (CET)
Date: Thu, 27 Feb 2025 19:45:45 +0100
From: Valentin Vidic <vvidic@debian.org>
To: Andrew Price <anprice@redhat.com>
Cc: gfs2@lists.linux.dev
Subject: Re: [PATCH] gfs2_edit.8: Fix man page warning
Message-ID: <Z8Cy2dYkmzK9Kiw4@valentin-vidic.from.hr>
References: <20250226202955.1936682-1-vvidic@debian.org>
 <b41234fe-c8bc-4dd9-9482-f3f214faaccd@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b41234fe-c8bc-4dd9-9482-f3f214faaccd@redhat.com>

On Thu, Feb 27, 2025 at 11:36:42AM +0000, Andrew Price wrote:
> On 26/02/2025 20:29, Valentin Vidic wrote:
> > W: gfs2-utils: groff-message troff:<standard input>:124: warning: cannot
> > select font 's' [usr/share/man/man8/gfs2_edit.8.gz:1]
> 
> Applied, thanks. Which checker provides these warnings? We might be able to
> add it to our CI tests.

Lintian is the tool that checks the Debian package after it is built.
So one of the tests there is to check if man pages produce any warnings
like that one:

https://salsa.debian.org/lintian/lintian/-/blob/master/lib/Lintian/Check/Documentation/Manual.pm?ref_type=heads#L328

-- 
Valentin

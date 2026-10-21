Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792551795;
	b=O0vmo7P0ofNu0QB3qzxs5cG5ZjUK3pm20P25G1I6BkQBOwKD7eylUIkp0rze6dda9zd/
	 BAG87tXVyOG//M5TRux/vsYYv26sMokQ3n2JJTXO2t6hsvzywkcpmT11OBHRr3spuBuLh
	 JOUAlMOxcyXXCTbCIfxickmP+YzpzzLiZzKA/gz4fCOaqwfVZWoclBjdWoqKY9zbwiRbf
	 TJweVc1wmIFfkWKCiK9b/v+zBij3SILpXUIydXF0pLE1jvXJasl5AS3tBWlntmOwq3fWZ
	 2+8VTfhC0l4wJR4ymrk1f0yAYboSWJvmNgRpIiweC0//ayHOohyRnA4QD+q5O8ptF7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792551795;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=gh0gY3UZi3wHAyM1tcm/tmNNv4fxaBdgK9WxxoAhyqs=;
	b=3TOr8f/fLBajdbobKMeQGnVvw1/8IVk13C5FPOWBoYUuRfrstdWQMwmvpzTrwn+rhHyT
	 rfG1VyQ1gAqwRAveYymxVqSrn7kumtmD4VvUfT+qmZ6mX32nL7ZtE6Yg2GvqzY0X0wjUV
	 wiXno3ZznlNtltGlp8yJAH3JmvNhRsqMd8G9Ugaig2L3YR7CWZb2aA6UYD7/DWuFivZUA
	 dz5c+D1tfAHbeM64SdB7oo9CKRH75viYRIKPfaw4XheWlyRNldLsUkNCpp/tj0X/brkYh
	 uHJ4mk0a3oJbmb/4GOOihlvc8rw0n2FHQC2wZAA6LrMFLg//7sCXv/+2KdAHo4OrB/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rtr5CviL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A83606A31E;
	Wed, 21 Oct 2026 03:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rtr5CviL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1771F000C9;
	Wed, 21 Oct 2026 03:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792551794;
	bh=gh0gY3UZi3wHAyM1tcm/tmNNv4fxaBdgK9WxxoAhyqs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Rtr5CviL0wPqoeSboY5Uhk5T0HlWD98nkDJXltljCYhTsN+5RWrthuA0Z2e4+shlx
	 iRlqDsVBr4ca66CKkgMb2rXdvVxBVs/ASz2mJp1qn0NxqtrimKMzktr5wzyYMdUkUo
	 u1g1im+pea+VJgkmAMUbIyMNTQDYxiLAQ11s6wuPnXJXT2OCaMvVyaPb9GHOpdRkax
	 t1AOqP4L6eobcY7XrxIqVs1CYhnxyugHeqItNitQP1PvJquLxhSTIBGD2+VF6SnBVJ
	 aHuG/fMyAJsk2Fof/EyfW6NHm2RnqhlW0BSQda4zJI+R1MvpEKpBLvfY4QSB+liSGQ
	 XPLGN/9hnSP8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3C23809A18;
	Wed, 21 Oct 2026 03:03:14 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 changes for 7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261019134141.194437-1-agruenba@redhat.com>
References: <20261019134141.194437-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261019134141.194437-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-7.4
X-PR-Tracked-Commit-Id: 2f9efb1efe4e026e44b7693e67f54344ae022deb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 910a00830bc151d6fd8e515c834149080c4c4940
Message-Id: <179255179286.353442.4384454021847430890.pr-tracker-bot@kernel.org>
Date: Wed, 21 Oct 2026 03:03:12 +0000
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list

The pull request you sent on Mon, 19 Oct 2026 15:41:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-7.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/910a00830bc151d6fd8e515c834149080c4c4940

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB6A328260
	for <gfs2@lists.linux.dev>; Tue, 16 Jun 2026 07:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781593716; cv=none; b=fKnm6wmo5vAvm5mxTcnWemIKK2lSf8YIs48JfH1NVmq65xZMPUUWT54Fyt6I+iEFYFWPyC9x8WyiSAN/EtJBeGDCeRczpuRVf84pRvYfQryqsykR5GRYLUNkw2l06vDaafh6zezuQmX+4iJZNWM0e0z0B0AixrxJqGHTOsaFkp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781593716; c=relaxed/simple;
	bh=JKWjGLI+lcCFZG5xQSyI7KDekRS7bfqCVcRa88dIyVs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Wa3eg6+n5tqFb06YKyxp/AQnMdYvmQkF+g0Sx6RPa5aBknjjD+mIRq572wjK+thDB7tiDJ7akXuiTB1RMD4lmm/SGHXMuO42qHc/MKEdIW59W74vc8Pz1fzIddORsgVXnDkvry5TXriz3R0AZuwQp1kXBrjLx/aFAGsNpDPdA2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTLeCaBw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTLeCaBw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D91C1F000E9;
	Tue, 16 Jun 2026 07:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781593715;
	bh=jMZvjRBnNtOcvpa4GQiVetjzpKzw/d+eyPOerV6LGP0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=RTLeCaBwwrfcnpQif3yyw2AfLNL3ynZgfBqrvNQEPYVgVJwC51jTgMlJTWvBWn/Yf
	 UZWyOzlj8Wii6UMdNinSi4lVXhfl4dDo3lv1Lh0Ihb+yR7cITT9Lcqzn1namMjTgAk
	 JdQ/xdO90HnaLcRIjAvehOg+47RLwixNLxyooroDYT8q4VcS04alR7tv1cVdf3D2Js
	 krwAaniGwzoDN9yF6UPvSLRsELW0P0SBJUnplYVnfOkXTfybqezC8ZD2hNBT3KBd9O
	 sZX/R3WgeFLiPW/0/XxUt8rTM8vwnUlGYUFqchntQFz5TU4UhOHQx67zDOXZuoCyER
	 D4aA9KZtP7PIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5692B383BF5B;
	Tue, 16 Jun 2026 07:08:31 +0000 (UTC)
Subject: Re: [GIT PULL] dlm updates for 7.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <ajArvSdW8Js7l72b@redhat.com>
References: <ajArvSdW8Js7l72b@redhat.com>
X-PR-Tracked-List-Id: <gfs2.lists.linux.dev>
X-PR-Tracked-Message-Id: <ajArvSdW8Js7l72b@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-7.2
X-PR-Tracked-Commit-Id: e61113cfcaf71cbdf4c17e3d086d8fb7f92c62bf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 477c122f8c1d5d9f57c4f9c1f7a1631beaa38bcc
Message-Id: <178159371001.494683.5558324030302530543.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jun 2026 07:08:30 +0000
To: David Teigland <teigland@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, gfs2@lists.linux.dev
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>

The pull request you sent on Mon, 15 Jun 2026 11:43:41 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-7.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/477c122f8c1d5d9f57c4f9c1f7a1631beaa38bcc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

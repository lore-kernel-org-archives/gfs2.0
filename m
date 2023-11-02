Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AA728FA
	for <gfs2@lists.linux.dev>; Thu,  2 Nov 2023 18:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmUmRpBW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14F91C433C9;
	Thu,  2 Nov 2023 18:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698950285;
	bh=KGhMRzByxSAbEadCRRCxcmp5V9nQAD0adRDrZgPYNZI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kmUmRpBWjCvm1FrVEoNeErsIWKeDWMB8Yut7uVNpTz03Hta4zefmMO/6aciYgcWvz
	 Qe3f+0sg6GiQ8CxU3GMmO5rh0aRr2Ht3AxYf/S2BZ+2wuvNybKZRWr/gVCWuv4OX4y
	 AeJmI97cuu/c4OMLJwymiHEr3NniAaKRHGvXJGiCgqz84++YuV1bxK/uYy2pP/hZGw
	 +BE7kzuTW/EQoJicJw1118k+E6i8vGBe2SWwECYoi60ffDn3VbMH8OBB3+mNru2f+J
	 6Qt5ITQwdKGQH8G3qMTiQAoPKEwez4bRFBVpcW4Z7tR76Gb0RaHbe4BAELJfx0GRL7
	 UQh766ZedczAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01AB4C43168;
	Thu,  2 Nov 2023 18:38:05 +0000 (UTC)
Subject: Re: [GIT PULL] dlm updates for 6.7
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZUET3DN7wTih6rKm@redhat.com>
References: <ZUET3DN7wTih6rKm@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZUET3DN7wTih6rKm@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.7
X-PR-Tracked-Commit-Id: eb53c01873cab75d0bf42e6d685dc5ef3b68d884
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91a683cdf602a593ea1f7783346a605e0cd470df
Message-Id: <169895028500.19486.13843843292063424757.pr-tracker-bot@kernel.org>
Date: Thu, 02 Nov 2023 18:38:05 +0000
To: David Teigland <teigland@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>

The pull request you sent on Tue, 31 Oct 2023 09:49:00 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91a683cdf602a593ea1f7783346a605e0cd470df

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

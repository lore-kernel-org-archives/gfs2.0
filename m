Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F633E47B;
	Thu, 16 Apr 2026 02:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776308072; cv=none; b=qDJ/srKgbugFAlbwwu3NyBNcjC9f2Gk5SieYvK+d7Qicg+ge2BOI4QzkzfCqgUay88vpGRmxFva1d793FZWM0xeQ7NbrN8rurW/uqUk2gupIzsm+ADMZSN8SYLZERo43J6tmfkRDoQi7/bN8pcUXxsf10lKZ6aspd0hSJsip6Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776308072; c=relaxed/simple;
	bh=++5RHM3i53gNj9fV+W4ANCL2rgu4/Gp6pCBZUL9/33g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=b4cQUfiZyzBVYIfQ0IjeMVU9tsJab8xr8MhxKTc+yoRsgeTaKYpyT777qRcsVQ0/7C3WBMz63zpDp1Iw9L+eb5Pc9kCTN2mE+ppNWaAbQ3w1qkMwKlo6ZnIvJPR4fQYUIV3nKwhQVJkng6FHgnoenEX4scg4cAEmqZJK2EwiNRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RblNiBEs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RblNiBEs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4B2C19424;
	Thu, 16 Apr 2026 02:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776308072;
	bh=++5RHM3i53gNj9fV+W4ANCL2rgu4/Gp6pCBZUL9/33g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RblNiBEscuZfl0t895f/plDRx9xgKH0gCsXgfBoa771kiaTtdyW64kJFSt7cYfGWI
	 k4yjmNpvQJT+Lrh5f3DkRSxlb8vLa8zWPVq9osT24cNY/ve3YA78p+9xCq3tFZ6Nn7
	 ohVcD7FtYVvGDWMMHlPKS2xYEiI2K/ZfUgXrJoWxR1OXIsVYUYoKAcnUfI601r9l2J
	 vZUq7MPy8cByqRw+MGiiRqI1bnz8JRVTNdmGJieli1LbH/B3Nm1BXN2SlumV9taZb0
	 8aX6xteuNpHWE8Oo8jy/up4sQWqW6HxRiTgGd+RBD/lvdCcvNOtEBxSzqQdcd8o2py
	 HPUnPKXNHBosw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF26380A964;
	Thu, 16 Apr 2026 02:54:02 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 changes for 7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260414121908.887366-1-agruenba@redhat.com>
References: <20260414121908.887366-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260414121908.887366-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-7.1
X-PR-Tracked-Commit-Id: 74b4dbb946060a3233604d91859a9abd3708141d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4da0dd95be3b0321bf9687fb1a3c2fed3319c032
Message-Id: <177630804077.2583492.17061721265928570621.pr-tracker-bot@kernel.org>
Date: Thu, 16 Apr 2026 02:54:00 +0000
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>

The pull request you sent on Tue, 14 Apr 2026 14:19:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-7.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4da0dd95be3b0321bf9687fb1a3c2fed3319c032

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

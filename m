Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FDBDF4D
	for <gfs2@lists.linux.dev>; Tue,  5 Sep 2023 20:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 065F0C433BF;
	Tue,  5 Sep 2023 20:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693944842;
	bh=QqBmefe/G4tiF0x0RfuchpxM6KA27P7L6VGkggK7CpE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VPtErLJZCaRUCvW9QuHM65y3cdLJyLpzvFgCYyr8vxEepEMFwvFaQPoK4kLXGAvWa
	 utKZ5hbu3TJt1KliMe4gkKlDwEAM/5bI8pdhR5a2a9o+9oKvM+FmVjOCbtVXpuKPME
	 YmCG5064+Ezi/nXLwu9yF4ob2qfP+jvI8WJH/uLhVKTI8fBtLtjabAoXyU3pumQZfr
	 SFXdLPNbh3EqogtBY/LKo8VRh21VkG8STaswi6iKtZJtqOXzzjawIbopb2bWBkwVye
	 UqFaTczBG7KZ0F2uoEGjRX5UgSB1ANvwRwUPtVqLNItXGTi73V8phJDgA511vb6IXO
	 VFo3uxetUTrug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7F09C04E24;
	Tue,  5 Sep 2023 20:14:01 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20230905161246.2042842-1-agruenba@redhat.com>
References: <20230905161246.2042842-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230905161246.2042842-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.5-rc5-fixes
X-PR-Tracked-Commit-Id: 2938fd750e8b73a6dac4d9339fb6f7f1cd624a2d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 65d6e954e37872fd9afb5ef3fc0481bb3c2f20f4
Message-Id: <169394484194.28658.6576619504433985005.pr-tracker-bot@kernel.org>
Date: Tue, 05 Sep 2023 20:14:01 +0000
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andreas Gruenbacher <agruenba@redhat.com>, cluster-devel@redhat.com, gfs2@lists.linux.dev, David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>

The pull request you sent on Tue,  5 Sep 2023 18:12:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.5-rc5-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/65d6e954e37872fd9afb5ef3fc0481bb3c2f20f4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

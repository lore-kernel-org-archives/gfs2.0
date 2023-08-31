Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E35653AE
	for <gfs2@lists.linux.dev>; Thu, 31 Aug 2023 22:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AAB27C433CA;
	Thu, 31 Aug 2023 22:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693521763;
	bh=xNK06ZKlebzI7R1qR2QLFzbNAoN99c1xJyD8nnE68IA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ps1DhtVGBbxtIPUYUTY1AulztIseEMClmRIDUcalby1OOdp9ixaX/NTd3lGAWrQo0
	 dmpTWoJXa/qVzlLTC8lPGax4q6V1+iDFubBbqI33cmqrmgaqgT0LBEvQC3dzRPvNdi
	 lK36SNdpRo8FEB0bfGm4diMNeoUT2Tf+cwZEnMHgLBoKWUmN74dYzZrs7RP664lWg1
	 BOLEDGJRt1aWv/bzC0Tt3RO07cdFkEPbDuGE7pSMHqmwaj9NBjOZe+NXHLESBYHyBo
	 ko2ZT7FlowjJM9EXw2vh87sSeDNAes4TTy6wU0yPyMZ8BgmNoey5+RZ5OcnKoqVkjg
	 UxqMn8PIixurg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 996D0C595D2;
	Thu, 31 Aug 2023 22:42:43 +0000 (UTC)
Subject: Re: [GIT PULL] dlm updates for 6.6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20230831142152.GA28483@redhat.com>
References: <20230831142152.GA28483@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230831142152.GA28483@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.6
X-PR-Tracked-Commit-Id: 7c53e847ff5e97f033fdd31f71949807633d506b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 659b3613fc635fb1813fb3006680876b24d86919
Message-Id: <169352176362.24475.17137877746163457310.pr-tracker-bot@kernel.org>
Date: Thu, 31 Aug 2023 22:42:43 +0000
To: David Teigland <teigland@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>

The pull request you sent on Thu, 31 Aug 2023 09:21:53 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/659b3613fc635fb1813fb3006680876b24d86919

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

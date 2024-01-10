Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5525025A
	for <gfs2@lists.linux.dev>; Wed, 10 Jan 2024 20:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aohj8jli"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6E74C433C7;
	Wed, 10 Jan 2024 20:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704919122;
	bh=GE4rU3bVWv6l4SowZzKxL0WWn8oYJ8Og3rfzl1A4ymU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Aohj8jli+B5Ts37MdbFsdcKVHKPzqFRFkF0GUoUJfxHEJOkMktmwG2ombFNc4Bo/E
	 tiTJymRlkyg9IvNObQJMUCDcUfqNtMpNg7jrkrSkFEmEvPBIfbEQpPMW7reVu9I3q9
	 xk5WPiNCrYlshLXmzpsz8jPxl/IX70+bDJpeUeftVJSocY/YHYJxjE0HbSue25MbjU
	 JoAwaMozoUxh5J/GcgHrNoQajvnme3dIldOw5lT9w5VKtz1rvOsLwvuz0FeS3RcesR
	 vuz0FxH4H7sMuVh4gO3ykq/IMmATaRgGMbOt+5lgkon/aiHTDxBSzFVQe0rpM/waly
	 /gF7SjoJqXnHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9CD19D8C96F;
	Wed, 10 Jan 2024 20:38:42 +0000 (UTC)
Subject: Re: [GIT PULL] dlm updates for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZZhHN6iFihBSlsZ7@redhat.com>
References: <ZZhHN6iFihBSlsZ7@redhat.com>
X-PR-Tracked-List-Id: <gfs2.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZZhHN6iFihBSlsZ7@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.8
X-PR-Tracked-Commit-Id: 5beebc1dda47719dac85830c53bca1a0ab497d96
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8c8e595dc31fb639bc4f8a202901afaa15bb13f
Message-Id: <170491912261.22036.13786222872360462943.pr-tracker-bot@kernel.org>
Date: Wed, 10 Jan 2024 20:38:42 +0000
To: David Teigland <teigland@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, gfs2@lists.linux.dev
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 5 Jan 2024 12:15:19 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8c8e595dc31fb639bc4f8a202901afaa15bb13f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

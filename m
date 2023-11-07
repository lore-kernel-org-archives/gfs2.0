Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323FF37154
	for <gfs2@lists.linux.dev>; Tue,  7 Nov 2023 20:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2vVLxAO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A124BC433C7;
	Tue,  7 Nov 2023 20:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699389255;
	bh=mnsmi8fXcBcXYZnIcsE/D3fsbOE4Kfi0tznMTM2k0KI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=o2vVLxAOZQaanDjDXT+1uwLNpME8nvdvp3QFu+w/mW6sYNAKvrGurkmx5QyxP4P6T
	 RZvPOMVhx0/39cMbC5y/HxX0sI/saFMjpOUSswPW39gxPHbpw5TqrLgQtrybDjqMS1
	 KZ+hXKAfBxKUS0LzYDRyAK4rvyFv1cgaIOfXPBZjPYgGOV/u4NDGdZ9THIAyjlK3G8
	 mNKA6DXOFEYTGVXfJfalwYz/6A0Xq9fBV+Znx+jJXo1XWm4WiWfiYDgDZkGIQy5XGu
	 jeQ/4yLXFPW6gFOPrngUuVq4YHxPaUh/tdhbUZUlwes37pVIdg1aAF/7zdQk8jN4ug
	 1jKgRA5wUwgCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F2C5E00083;
	Tue,  7 Nov 2023 20:34:15 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231107142154.613991-1-agruenba@redhat.com>
References: <20231107142154.613991-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231107142154.613991-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.6-rc2-fixes
X-PR-Tracked-Commit-Id: 0cdc6f44e9fdc2d20d720145bf99a39f611f6d61
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1a0507d8780e2902c4c17c5a4c45d298bd7048af
Message-Id: <169938925558.27832.12377411515776609324.pr-tracker-bot@kernel.org>
Date: Tue, 07 Nov 2023 20:34:15 +0000
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>

The pull request you sent on Tue,  7 Nov 2023 15:21:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.6-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1a0507d8780e2902c4c17c5a4c45d298bd7048af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871CB210FB
	for <gfs2@lists.linux.dev>; Mon, 18 Sep 2023 20:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A445C433C7;
	Mon, 18 Sep 2023 20:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695068428;
	bh=Rh99Y745HS8tzJUeVNSTiL1/NQWpRhbaUTZcJgozihg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=flUURrwn7KAPig+aDc7k+IjlMfkTnr3ebyeVa7ArcwU1hwo7cKdbZWq8MVgnC+G7f
	 b57jXwvPQov1/1KzZQTnnSROOu8BPYuc8bpEpJl7RzLO7pWByOo7mSAMDGnurWt+tT
	 1dfuB1uzXODALq9tfm5JrsVEi3RPXPvsQsp95XRwi5Y5Bgh8xU2ib5LQ8OZHjFz3zd
	 rD5d19BOdgN4vRCuEHEm6qOCbUounZcP3OiZbQOyznGsII+ikzlhulbiOxgDFiNosd
	 zbJu0jl7P9SvLF8ngfnAJ2sY7M6LNSrVIOCmKuCNXkMALoI/peWiA/R5ZnUPOSCt8Z
	 UAcIXWjlyN97A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC1B6E11F40;
	Mon, 18 Sep 2023 20:20:27 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20230918143438.2739942-1-agruenba@redhat.com>
References: <20230918143438.2739942-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230918143438.2739942-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.6-rc1-fixes
X-PR-Tracked-Commit-Id: fb95d536080e6c1db099f0023f59cd55adcc5d87
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a49d273e579615ed63d0347f94075dd22b9458a3
Message-Id: <169506842795.7829.2519583286587165362.pr-tracker-bot@kernel.org>
Date: Mon, 18 Sep 2023 20:20:27 +0000
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>

The pull request you sent on Mon, 18 Sep 2023 16:34:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.6-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a49d273e579615ed63d0347f94075dd22b9458a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

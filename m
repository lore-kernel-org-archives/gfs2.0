Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89D21D5160;
	Tue, 10 Feb 2026 00:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684610; cv=none; b=gZG+DdWLHw2GKeNmsJE0aqLuSf41CMB9yIG0PTI787Q5Uy+FcYqPQ2CuCshRHBjami3a5hZ8ixEZZ44LspHAKlWY51rxEjkDSctNp0dU3VrKiIXTGHrEvCEBdTGxwRYeuhqFkocrU1qAnrp5pH08R5kl9ShoKVA24Z8BIbktNqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684610; c=relaxed/simple;
	bh=SunXlZGSP9mj+O/UAkssQ9r454Xg5Ttb2DzR3AkXRTU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=epR+4aFtfkIZkMidp6hgAx4b6tTr+KMoNcYhEuC6lObX0D9AG8LtLYhPIBOQohuHwWyfQLQu0GQogh9swMAulWFzNMsuTOOQGhcHMmSaSG2YU9y1OvHX2pNV7SG9kZrTpUIEC4TY4uLLkBftkpswEJ8tN5jxrtvR4SHMHst0fJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aw/we7mP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aw/we7mP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF295C19425;
	Tue, 10 Feb 2026 00:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770684609;
	bh=SunXlZGSP9mj+O/UAkssQ9r454Xg5Ttb2DzR3AkXRTU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Aw/we7mPGcPKymdPZoMn/WLyhhLYhEHQ7ZaS0yVst7cPpS4UNIalEM8op0uAihnvy
	 NnMYP/FwkLHUAy+44XcpWmcDwWqOnBbihrFXwesO6TrziBx9Ozt3gYToqD71t6eu2b
	 fuAcdeChXfl6YtpYm0akmzjhb2Ugh3Y5It3/HYhJ5nV10O+lPSh1GVEYAphyG9h4FA
	 3oJpCydl/SQWXYC4YhY4LrsUEEK+PKKQujKN5r3jwGGw/IkxGaqLFgzydu86NInE9H
	 8gTyagxisBTegYF7EGTS69H4xYEB4WGp4ZKpVHsYWvYbvbfTixy9Po6aJuiIGJHYd+
	 NK2Jqt4ZzCcxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C20A3380AA4B;
	Tue, 10 Feb 2026 00:50:06 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 changes for 7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260209135919.1827410-1-agruenba@redhat.com>
References: <20260209135919.1827410-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <gfs2.lists.linux.dev>
X-PR-Tracked-Message-Id: <20260209135919.1827410-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-7.0
X-PR-Tracked-Commit-Id: e411d74cc5ba290f85d0dd5e4d1df8f1d6d975d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7141433fbed290f4dd42008d3102db2363275035
Message-Id: <177068460572.3270491.525170005492821665.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 00:50:05 +0000
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>

The pull request you sent on Mon,  9 Feb 2026 14:59:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-7.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7141433fbed290f4dd42008d3102db2363275035

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CDF31ED73;
	Tue, 13 Jan 2026 18:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768328128; cv=none; b=MoU5MlqAgZxbFQGcJD3/GbtFkC0kgI55UE+xkKyIurgvvp3sTlWjYHPPDX3c+WdPwBMkBPx06AJLH6ida516+ksd5phjnBNPVoUOS3bCA5sDx92ZeUcEPcr+NAAXZdiBs8UfZGrUSlhM6z0d0hMU379BykoQcTSjmfL28y9DRC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768328128; c=relaxed/simple;
	bh=wxfNs5LfikKP7uDAZQkFVlEx17vJEhx0iEWj5NOvtzs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=P1qf+pC6psPxhofV8IDWUPPFYGjlmhBY8sgU+/usumdUZuiagOZ88nKbONa9BnYZE/VwK9rkutAgji4AXryKfZHL6Wk4KRLV+Dh/IHBMf90UQ/Z9uUea5hXD/zxUdkbtUuFVTlWmc9ZVNPpxOKIwn0LSmjWJkHzt2H3E0/U4+D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cq5vie44; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cq5vie44"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE4AC116C6;
	Tue, 13 Jan 2026 18:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768328128;
	bh=wxfNs5LfikKP7uDAZQkFVlEx17vJEhx0iEWj5NOvtzs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Cq5vie44VBTGRtzbZDLdN+71pIlh7mbUtULjFgthLVLX75CPuSZ2xsgb5UACeoEiN
	 WR7E6JimF1U65X4/eMNJQsqzekFP+sXHBZg8nJMET6gShqNODXeoF21leOSIHgQ75a
	 O/ueJAtVjkOhxc4TrHY/0REo2tyxLhAZlsQbHJYy1E7oaKCQjKW7v7rbDK9JYINffo
	 ZpAlIyUJibDv+BXovmTw2gvDRWdfRtA3/M23XmVvQn0+g64qMv8VSNKHT5WaIsaAas
	 9r/ekhoHMvWaYEx/vsp3ksdnE9habsUKqeMltGN+aA2SBi6AvFfuU2zK8y8af6Swvv
	 /dbchConNdNxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5B3C3808200;
	Tue, 13 Jan 2026 18:12:02 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 revert for 6.19-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260113135123.282418-1-agruenba@redhat.com>
References: <20260113135123.282418-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <stable.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260113135123.282418-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-6.19-rc6
X-PR-Tracked-Commit-Id: 469d71512d135907bf5ea0972dfab8c420f57848
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b54345928fa1dbde534e32ecaa138678fd5d2135
Message-Id: <176832792163.2405565.11904158289995365163.pr-tracker-bot@kernel.org>
Date: Tue, 13 Jan 2026 18:12:01 +0000
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>

The pull request you sent on Tue, 13 Jan 2026 14:51:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-6.19-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b54345928fa1dbde534e32ecaa138678fd5d2135

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

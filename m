Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1487824468B;
	Tue, 10 Feb 2026 00:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684611; cv=none; b=l9zzOnHLLG+dBk1SH93Wh5SQ6WoEehT/ell7wxevvuPZQfl3TB4S5NSAnlzOjN0B4uhAB6CfutRSCxTKqkEe3gclpvOXWYjgYJQAE1r70bs4X9d2tT75QjPP7FazlsMcVT0HZc6v6JTuPZu/NyOTZKlCPTNLWIW53vQaI5Kmqjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684611; c=relaxed/simple;
	bh=a9guLzqRaLkPQpgzRDWJEgf82qhl+gvxtAbS1hc4rHs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AwjcUvvVSLqFQeI6lmlzsYKkZNFm3c6a6AsmDmYkPiPQ6Ibxx5d6kXvQaJ9MAzy1cqd55YTkuZldU5Z6kU2njHGqRXv+I4Dwaj1hJxkPmQJdpXj9BFGGj+1ydZtIhXKlSEj8lDBlw6gf1DhWhVkJpRWAVemGsCB2A36fdNa3kvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbPU56Op; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbPU56Op"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0200C116C6;
	Tue, 10 Feb 2026 00:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770684611;
	bh=a9guLzqRaLkPQpgzRDWJEgf82qhl+gvxtAbS1hc4rHs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CbPU56Opt6JblDTlKXYxA5EVcB0ZFCPVLYTesW4shzH4jusEnca5hVdX/Ih+gNhtF
	 GqgTt1Zs4gECvdFvo1yRn/VSPCu2Nq8m4hOilZ1SlrL21G8Qpn57JPJiN8/VInWFBy
	 +2oNSxid0eJFISuWAPazpFxWLZ44D3HEh7qwOt5BmS335cnlNaFtquWz7PHXcdvje6
	 e5uOAs+kTzkXcS72NdrQ21RnqZmCEmgJ0FctKa6t8LwAhIAu7iGCM6Pz3BsyMBft43
	 GoOQ3XBPrl708USajkc5jcV30rurziFsdiOTKBODbSVNaKBKfq8eTBtBQ5ynARbNS4
	 4GjkAHnx3xCTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E7ED1380AA4C;
	Tue, 10 Feb 2026 00:50:07 +0000 (UTC)
Subject: Re: [GIT PULL] dlm updates for 7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <aYodQumcGQCTCrBK@redhat.com>
References: <aYodQumcGQCTCrBK@redhat.com>
X-PR-Tracked-List-Id: <gfs2.lists.linux.dev>
X-PR-Tracked-Message-Id: <aYodQumcGQCTCrBK@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-7.0
X-PR-Tracked-Commit-Id: 2c3a0b730012ef87aaaf35243e1fbe9880666f7c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: af23fd93fcb27a19764759c9238ef0bf5bd8370f
Message-Id: <177068460685.3270491.2954570654658035303.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 00:50:06 +0000
To: David Teigland <teigland@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>

The pull request you sent on Mon, 9 Feb 2026 11:45:38 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-7.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/af23fd93fcb27a19764759c9238ef0bf5bd8370f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

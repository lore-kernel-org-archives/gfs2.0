Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792551799;
	b=z2E7rffpvKWVwJjo5jdRGbNTHoMqwa7NRWrSIGFOGhIhwF9+WhHzpQPRyHTbjBLWoMz/
	 QuNqANJ8m26urSG+Hre+WI5VhzDylgut/EPWFgbcqcyy3zTjDzDpPfxVe3ORNDsuu0tmf
	 3HSjQGod9LoNgH42gp0wz8ovBN4BArAHLU1fkubYsIKPaWtRWoiZ+X6T3YXvcPIFBE/m3
	 7GdG93hkp4iaTUyGRn9umViLxwxxyMz7c4ct6LUrBAAML6BpHyb//tDFliipwNJ+qvvm1
	 gd/oEevzCzM/+bxz88GweXcAad5NqYJt/622X8eTlRVFL9PliEuIGe85u+qdYFdG5YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792551799;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=BludtMh2mftsnrPYSv0i9MRdODj97wa709JGbICRLPg=;
	b=3qVcbH1jqeVarkKZO8ldnd9FJ3G3JFZvPFn38igulGe/uL2hD7ifZQRisx/6Z33zQ3WB
	 fb5LfeyfCr9/wqv8PhgFskzlgVksVYJ7arcmOc/RwFy9Q2bkxzpSf3s/HNPvArrUFSDTf
	 cjlocgiMs8+aZxzZMxEqPq07wwvFeehvJ1/bMTIBOvYqWBGM9dPZd9RKJJqx+AOF/vNyS
	 wkUQIL4VdQyK6dOMhlU3xthJ1ZWH5lNR1C0C5dTz9T9cVe2+lCGwC85TFc2GVG5deFayv
	 4sTq3jatdDjYVb1ej5T/3944Eu6wSuasj1d78K6CowcSumiCOoiQ3AjYfUMRjfRBrYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dti9KJCn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684A6606A329;
	Wed, 21 Oct 2026 03:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dti9KJCn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059671F000CD;
	Wed, 21 Oct 2026 03:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792551799;
	bh=BludtMh2mftsnrPYSv0i9MRdODj97wa709JGbICRLPg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=dti9KJCnm40WYae9NhSkfUQxhSJiSP40b+wJL2+upo+1AQtQQXYImRtmtQYPhVmft
	 4RAD1Sx7fRINBJZ7SE740AmxwOuKMN2MpuPNf1zlyJOFMei4EsCCmoNSAJ3o7uns4T
	 xRrkIImHkwovAyV2qE+evBWSgLjxwqHcIigSQT9fFwhi6Yn1zGVa7b3XIxDBEgRKz5
	 YkxgNF4rwXZQc78AbF2NvXfJ2jVLTtCVd1YZtV2lbp5jWaae/soh9O/SAgP3v1NmC0
	 NVKqoKveN3sRW3oxjDwqzR6SlGNWRzPgwE9fD84kx4zUWj50q3k/MjHsmn5jLvjKKu
	 Olb4awP4PpfPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F153E3809A18;
	Wed, 21 Oct 2026 03:03:18 +0000 (UTC)
Subject: Re: [GIT PULL] dlm updates for 7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <atZ6sKjlr3SxThCU@redhat.com>
References: <atZ6sKjlr3SxThCU@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <atZ6sKjlr3SxThCU@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-7.4
X-PR-Tracked-Commit-Id: 82bcb7b05ad90de126e9c09a7b46a81be799620e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 72a16bcff25e9f4a1d6d42a243301b1b76db2f32
Message-Id: <179255179755.353442.12738758738758390278.pr-tracker-bot@kernel.org>
Date: Wed, 21 Oct 2026 03:03:17 +0000
To: David Teigland <teigland@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list

The pull request you sent on Mon, 19 Oct 2026 15:16:48 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-7.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/72a16bcff25e9f4a1d6d42a243301b1b76db2f32

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

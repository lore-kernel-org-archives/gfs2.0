Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F87D30AACF;
	Thu,  4 Dec 2025 04:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764823882; cv=none; b=gsBX5xKAMSAoSHjLkRbwaqYz3RL+aVxp/xwYvw+OnhpiOOCzv4yfjvrxCrxNgx7HnBY3t7tqWnBU+/J8dDt166Kq2QlaaQ796MU2Ka7u1QkjUadfR0I76VSINybqbHvdx/VmzoorMHoKas5dHg+uA4+UPaUUJSxYgc7FgX1+rYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764823882; c=relaxed/simple;
	bh=wdm+6nqrbmqF77zg5v7CYpzzSQvHMmzP3g08A6+FKYk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Gr9XRuTnCS9OQG7WAZEtc8XQ469u+Ac7EOW6FoMTe047wcpbPqy0PW5z/ycqBU1MOuAxFfvdwBctDr+qoxbZHqElmWDgCh1lj35maq3aBZPqzzCGyS+5F0OyDVo15G+1YebGjssNN26jLAagkX1EpiTtZ3zlyVNdldAEFjsgoog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bd2fGmqz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bd2fGmqz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70006C113D0;
	Thu,  4 Dec 2025 04:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764823881;
	bh=wdm+6nqrbmqF77zg5v7CYpzzSQvHMmzP3g08A6+FKYk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bd2fGmqztQqJAsp8N4+dthovBamYRFgwQhqypMK3OuPRdfwJZLBGVtdff4YYXANbM
	 Javfx22RgmD13GYRJpP9RqD7IHHrkHIqdHrk3nEmxoi8qZYOCZYXnmyntSWiwM9ctl
	 2zW92Kfm2hZsiqraAwScQLlHmQP/bjt5GlxbfSAMOXDNZkWFknpgBRVDuXFPGnwWzS
	 Cu9TsA/iXZMHl+guwa6rcRIVk2cYN8+pUN1n9sJlDUgDCLLxSFs63tRm8BlO2AxI0+
	 0lhLAOaIO75QUEQbZFLg0EEHa3ExFDZ9a/q16Lh3t4lYs1XjvLJAhe4c9HM9wFs1IV
	 ZsQVGIkGAdXlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B79D3AA9A8A;
	Thu,  4 Dec 2025 04:48:21 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 changes for 6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251202213200.4170687-1-agruenba@redhat.com>
References: <20251202213200.4170687-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251202213200.4170687-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-6.19
X-PR-Tracked-Commit-Id: 8a157e0a0aa5143b5d94201508c0ca1bb8cfb941
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: afcbce74f358a540761aa893939590a667162dff
Message-Id: <176482369982.238370.2967082670426176839.pr-tracker-bot@kernel.org>
Date: Thu, 04 Dec 2025 04:48:19 +0000
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>

The pull request you sent on Tue,  2 Dec 2025 21:31:59 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-6.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/afcbce74f358a540761aa893939590a667162dff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

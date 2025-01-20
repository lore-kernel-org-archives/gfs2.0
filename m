Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D321F03C3;
	Mon, 20 Jan 2025 22:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737412200; cv=none; b=G93ZyTQqSISwkI5kSUFe8B+wHswU9RduAcoXFS0rdZL1xEJi6mxi6XPW2ysKDAkpnHYcj9u+fyHV8N/tci77q0RWTz4HGwzLHGY/SKeaaO8I55WcS30jUwx38do0/N6m2Rho5FVI4CKFuT0UmFK0tacnAfEGgcTu+xWd7EhABeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737412200; c=relaxed/simple;
	bh=MDjtB2rfVIDVPqP6zRJM3L3ba4WWdoyC5GZDFskKULc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JGPxZSWT7bwyrt3vgG6TTK+Hbbs/WbOKGiVwVlGx9Q2w+3ITnRp6nVqJT9q1BvtUH83VMOk/A48F2KVM0d/dIpVZtLZa7KgJB7sTHq7qUgoZ2e/1G5zr4HuTrOM6o0A7VmL0IBPYi0+tG/1kkq2+AeoDADwjs9o3+WPvwAhE3p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOYaXjy0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOYaXjy0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CBDC4CEE1;
	Mon, 20 Jan 2025 22:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737412200;
	bh=MDjtB2rfVIDVPqP6zRJM3L3ba4WWdoyC5GZDFskKULc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nOYaXjy0lhbF3HJEIkr7OI8lvTAHYLn/MrGR2yMhVkSU3AbkHIRwJ+tTPmd916AQ0
	 U88mv0DVWi0LIX9ENZeqDEiFf+bzBOLiDWGQa56DcbiR7rsScD4IN22wMkbP4MdU+U
	 rGqaqw38anxnodk+z/c25+3L3cyRf3yTryDDFv7y+EfIUkWBIwivYhVh0POOKl25e+
	 yuJNq0lVgsr9gxpP9fTeDh8iLgtNHfCh3Wu5ql3VGYvZRLsNhMmvDSaFeISP4rsg91
	 QPW1ycUpYKDQ5CQWh35GuasuUxRUUj7fYk57RTozL+/HmsV3cbY5wFjiJ0bdkfbxf4
	 GDWhlqDlfhOMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB492380AA6C;
	Mon, 20 Jan 2025 22:30:25 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 changes for 6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250120141344.2017385-1-agruenba@redhat.com>
References: <20250120141344.2017385-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <gfs2.lists.linux.dev>
X-PR-Tracked-Message-Id: <20250120141344.2017385-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-6.14
X-PR-Tracked-Commit-Id: 7c9d9223802fbed4dee1ae301661bf346964c9d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1851bccf608a28ac5ec9410764dda9a46828213b
Message-Id: <173741222488.3666340.16774931485637674611.pr-tracker-bot@kernel.org>
Date: Mon, 20 Jan 2025 22:30:24 +0000
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>

The pull request you sent on Mon, 20 Jan 2025 15:13:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-6.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1851bccf608a28ac5ec9410764dda9a46828213b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

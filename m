Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DD53D9022;
	Tue, 18 Aug 2026 03:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787025485; cv=none; b=C7SlR8F2/iJAvhY1S4fo1uXOP1EMgZib4KXawrtMcvzeIxA9ngtdWoIYYVNUsoLl4fH1Y32aXLiM5qVAa0AKbVLNOQp3vcamG7sc/hf3okK/WpZIqUfp1u8iJ4u6Pm6LKoSOP1wKcGKZq0nxNHxBdR59PjuCJHnR3OdE32ZLevs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787025485; c=relaxed/simple;
	bh=FQUAwcfyTcAFKmmV5A80ClQ1LsPOY7TFmJ2Ie37ujgw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=D2f3xZ2adM4EH3/3MGrtEkFZWZlGh/RVoTUC5sen/ghHItoTqnUH7UE3En9tndX8bD4pNehd5VEW31ZF+JVxbVQ3m+MJVwaXYIVQ9w/gifJUR7dB3D46LLKeCsHJREbGoR45vuXXVzzo+6Wov6TlqeMc2GDs8d14xcMjThhZs3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nr43ITr9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nr43ITr9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD15F1F00A3D;
	Tue, 18 Aug 2026 03:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787025478;
	bh=Rri3/Ikyg4xKxGMb3JOPrfQFskrV0tlzvOrdEechIcA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Nr43ITr9ZDglHawGGq+ujoYS40AVECpCzQ8QWBmEuenb1ECpzdYld3JFR8bOx9goH
	 SGAeiNhzpqzESw7kIV3P7/ilqiZfujBLzkVGKJblUph5J/WGPZv7Vn/9oMTbheA9MY
	 apJGAw2zrfOTuv2qmcoNDuukKb246ruzCfOfELWr1n1jGSKehXimr9uTrDr9EMuJwD
	 3NQgVbXc7lPR7U0oHorMrU3nt1+cMG84vlhvGoWWUTJxmaoMCaTTNVh5IetDPoQauz
	 jSKE5XmxauoHaKKDazylXdP94kdopiW0ERJSJypdX4ctus7aoJdf1V4nyMj3hdfYuO
	 YyXmX+sCaCckQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A853926381;
	Tue, 18 Aug 2026 03:57:11 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 changes for 7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260817112647.1203264-1-agruenba@redhat.com>
References: <20260817112647.1203264-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <gfs2.lists.linux.dev>
X-PR-Tracked-Message-Id: <20260817112647.1203264-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-7.3
X-PR-Tracked-Commit-Id: 657e5af4fe0b9696a6c7232da1727a9f37eaa04d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4bb187d6f379c5490e3034b153fe476127308519
Message-Id: <178702543054.1862718.6856563974189972044.pr-tracker-bot@kernel.org>
Date: Tue, 18 Aug 2026 03:57:10 +0000
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>

The pull request you sent on Mon, 17 Aug 2026 13:26:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-7.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4bb187d6f379c5490e3034b153fe476127308519

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

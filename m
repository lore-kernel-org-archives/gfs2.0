Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3DC1F12E2;
	Mon, 20 Jan 2025 22:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737412202; cv=none; b=MefPxdDSf5gyllbSC195BkGdtu7+LztQI6WiA2L4xPmbrZESeJ+cfEEhbwg2fVksr/5pZsMjkS7HSGzj1WWbFIcGueILzDBwxOa8iQHvADtYXsJfHSY7ew4cf7H0jhBxtzazUdS9w0XcTkbTep+LnRgDzvYWCVZfZvU0Gn5tU+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737412202; c=relaxed/simple;
	bh=wALc2r/3vx+1F1hT9mdB3PXl1WzJKfIwL9x4rUCY4s8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YkNXkxkO9st4Ng13LwMFiWUjnURMr1H7ysIPjnWbewj4HwO0EFogz+Ve/tUOUgLKep5W77Zkq+eQkd/RHnfaAAYS4jn/JOxH7OwSn0nGwPl7X/H7RYRWDg0BDc7IcnrUJekZ8NgnE1v/iAtdrXztjUfx5aB2tElyRTaB8JwT6ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a09L+q0Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a09L+q0Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE527C4CEE1;
	Mon, 20 Jan 2025 22:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737412202;
	bh=wALc2r/3vx+1F1hT9mdB3PXl1WzJKfIwL9x4rUCY4s8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=a09L+q0QXD9Tg5wvq5Gqz0Y68VW3M/jxFRLU5ErGjeGOvKmgghUMe8HozLi4LBzMD
	 l1b7cr0PoY+8mkpnEPQDuCdHxEBRGcUwXbPBUWgGJgVOP4AhXLt0tYNn4kASzbOkRK
	 wMOMAcs3AB0ZulXzroXMi15I7hQqmAhoR3eJhp4LgKvDsLBvWuoMtLGT9aKC2y8iWo
	 uOUwkEmB4f3XTV/9m80Lvtwf2FEavJgBoBGOQDS5UUynDG6HObaw3YysRvdc5U3Img
	 qPsf4yECE23ap2WGiWn6NMo/9i1pwn4rXdS4BEkFob7XoA0EHCJHT1fFOTaA7dHlmc
	 LrJxFyzdL3oVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3CC6A380AA6C;
	Mon, 20 Jan 2025 22:30:27 +0000 (UTC)
Subject: Re: [GIT PULL] dlm updates for 6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z46NcGZHZAfkgKF2@redhat.com>
References: <Z46NcGZHZAfkgKF2@redhat.com>
X-PR-Tracked-List-Id: <gfs2.lists.linux.dev>
X-PR-Tracked-Message-Id: <Z46NcGZHZAfkgKF2@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.14
X-PR-Tracked-Commit-Id: 6784ed98fde5b7538fff6b329b686b119ca23d8b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d3a9c8b89d4f8a3785e06ffd15405c670696f02
Message-Id: <173741222614.3666340.3135004555214337696.pr-tracker-bot@kernel.org>
Date: Mon, 20 Jan 2025 22:30:26 +0000
To: David Teigland <teigland@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>

The pull request you sent on Mon, 20 Jan 2025 11:52:48 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d3a9c8b89d4f8a3785e06ffd15405c670696f02

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83E513A3ED;
	Fri, 26 Jun 2026 23:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782517167; cv=none; b=V16t+IBB3pumhpJVfdh3y47MtMN3iBmZfEPr8ZWW/Ox14oP4Ry80f0RY7vC9NnbTFBmWoOQ1wtbKGYS8ken/7xgzWiq5MvwvfaT5QZ79MfrJdDXKB2fb0kA5wkT8qTSpGprjJ20Vw4nPYS8D4LtyIvDEtRfd9zF5NuwRn14L/Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782517167; c=relaxed/simple;
	bh=ZgJwpeGtBUpVHsD5RdoWripJWAs87Lgo8bBuak+SA1k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YQt9mR1jrERYMYTMH+ZQaj94vVTHeFGgVQUftN9FnNrt8S1NcXtgpcumzDah7T4CpdK+xnMr3Tau+zifxBkRtnIQqP3zJnsPZVpIDX1a8PciQileix0ca6NjzwON4lLGyVYAoz9dE2Tl+1hBBC+N1aoVBk1U5Q3X2iYow8k+JkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzeBW11f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzeBW11f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583D21F000E9;
	Fri, 26 Jun 2026 23:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782517166;
	bh=K4OCU99IHp3tjUh64jmlRFTPMcqA1q/Dipe5VwayLIA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=lzeBW11f/YOVwc5ywnuq53YZmwKsjfiS/acZ0KvJhuaJHTZQkhgKkYdRj+40qNouw
	 8H3GUbwVZuLaWHdBUR+4SqNNAj+NedWalTkrWWox2Oku1jm3NxPwlcsTIwE+KVFWBq
	 0EgCLZ9PZqSV0l2dEHNvFIwrVuru+NhxPwEGvM2YrNIzX4uIysmZrYaBAg2DiCY/iC
	 +UPws+EqOOoDLDuSMJxcpHpDXtILmf6HkQ62pgVyyopz0qhte/EsCPBTtLdSjuZDCx
	 SWLzGf6jg71twgh9ag96Xv3zKl2haZr6FmFDrfHrlE19zsbcGEkFctMeL/CIDXoXA6
	 P3sHb35aRnMuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1991A3938C71;
	Fri, 26 Jun 2026 23:39:14 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 changes for 7.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260626150033.568188-1-agruenba@redhat.com>
References: <20260626150033.568188-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260626150033.568188-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-7.2
X-PR-Tracked-Commit-Id: 4982e58669b11c43644efb5fb7435975848b716e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5f80d9113360c08111ae7471f662f3f89f23ce32
Message-Id: <178251715281.1134171.1427587836609681793.pr-tracker-bot@kernel.org>
Date: Fri, 26 Jun 2026 23:39:12 +0000
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 26 Jun 2026 17:00:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-7.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5f80d9113360c08111ae7471f662f3f89f23ce32

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

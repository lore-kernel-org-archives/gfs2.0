Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990AA18E361
	for <gfs2@lists.linux.dev>; Mon, 13 Jan 2025 13:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736773606; cv=none; b=QeNvk+PNFTKfIrrvlTSIInRrG/Xyb9KsowTqAqJDSSL28tnUU3WCA09ty6daE8jPZssbGjY80Wb2brrEpivNoHhBs0JNyI2lAMuiBSLT8dst/so6LCgftv69ls1f52PyMZFzRqnOd96ujX9HO5lHK8VN6R826KOv5/UFOVij9yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736773606; c=relaxed/simple;
	bh=LXYxPU2+V0qVhTGUmhCcNvx0aAN63beIleoToAiYLD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C8yoVr9KctcQ0HoXTLUduyze6csvDwnbtxCm89OQvvLCNM9i69UK1VDWmKqbyt6BwQirpra2fZaTXbjepHARfkgogO9kqRWUgWMPinQ9dhhmSfeNH/0vNgHvsqFOJZpUnanQuOINNj6ZVD8PwbVrodgPGgpEtXG23ob/01tGKtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 50DD6QI7055982;
	Mon, 13 Jan 2025 22:06:26 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 50DD6POn055978
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 13 Jan 2025 22:06:26 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d34005db-9fe2-4b1e-acf6-54976e07d939@I-love.SAKURA.ne.jp>
Date: Mon, 13 Jan 2025 22:06:22 +0900
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WARNING in __folio_mark_dirty (2)
To: Jan Kara <jack@suse.cz>
Cc: Tejun Heo <tj@kernel.org>, Andreas Gruenbacher <agruenba@redhat.com>,
        syzbot+e14d6cd6ec241f507ba7@syzkaller.appspotmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Jens Axboe <axboe@kernel.dk>, Wu Fengguang <fengguang.wu@intel.com>,
        Greg Thelen <gthelen@google.com>, gfs2@lists.linux.dev
References: <CABOYnLwGoNXXzvvn+YmCcjLu6ttAJGGTaN8+O_tNdPqcjHnfUA@mail.gmail.com>
 <20231213-drehen-einquartieren-56bbdda1177e@brauner>
 <CAHc6FU7R+mb3Eh11oOfvDVNg-Zsb-zE9CLEhr4yDKJKU5+ABHA@mail.gmail.com>
 <ebfe4024-f908-458d-9979-6ff2931c460d@I-love.SAKURA.ne.jp>
 <20241203150239.6ibpyziqapxbeenm@quack3>
 <e346d089-7526-47ea-a64a-b75a578d2362@I-love.SAKURA.ne.jp>
 <b3eojhlvvva7jhs5uv2ddf7cltx5ao4aay7p3p6uacdz7kt6ti@pup2xblqsd73>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <b3eojhlvvva7jhs5uv2ddf7cltx5ao4aay7p3p6uacdz7kt6ti@pup2xblqsd73>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav102.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/01/13 20:52, Jan Kara wrote:
> Anyway, your suggestion brought me to an idea how this warning could be
> improved without having to mess with gfs2. Can you try modifying the WARN
> as:
> 
>  #ifdef CONFIG_LOCKDEP
> - 	WARN_ON_ONCE(debug_locks &&
> +	WARN_ON_ONCE(debug_locks && inode_cgwb_enabled(inode) &&
>  		     (!lockdep_is_held(&inode->i_lock) &&
>  		      !lockdep_is_held(&inode->i_mapping->i_pages.xa_lock) &&
>  		      !lockdep_is_held(&inode->i_wb->list_lock)));
> 
> This should fix the warning and without cgroup writeback inode->i_wb should
> be stable and there's no need for locking around it.

Unfortunately, this change did not stop this warning.


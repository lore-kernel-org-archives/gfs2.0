Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFF11C693;
	Wed, 13 Dec 2023 10:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNH49ZWO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8CFC433C7;
	Wed, 13 Dec 2023 10:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702463912;
	bh=mOX0bb/Ghlw3wwfWH5n74d2gryvgQgvS90ps961NIUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YNH49ZWOQmm9gwW0vJZr+Qrvx1puyT4HLTBbfCaztM43gW04j1oWZA8o9q0CU3ICv
	 PVDIhVSpLcJTs87anBZrpEsjfF9HODAy6bf/vAOsyKsX0C23dkOdNBJPR7CNRegrCJ
	 ldKD6iBcF/hCqvFAT/mHjm8axnUiVNGuRj/9LqQO7y2pyUK/C1Y+3g/J4O0C2l3zI0
	 BoHxn2AxyFP0MIekq6I66dwCdnpdqAvGHjAWHUSy0gh/J6pQ3FjddQlluGM2BfJ01h
	 leikwN84SzHR5UiszgPmidW/TVzgawqtq4+jGYITkZr4ObgGByThz5G3hvl1NPgjJA
	 lbBVu9Mijl7Nw==
Date: Wed, 13 Dec 2023 11:38:28 +0100
From: Christian Brauner <brauner@kernel.org>
To: xingwei lee <xrivendell7@gmail.com>
Cc: syzbot+0c64a8706d587f73409e@syzkaller.appspotmail.com,
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [gfs2] WARNING in vfs_utimes
Message-ID: <20231213-drehen-einquartieren-56bbdda1177e@brauner>
References: <CABOYnLwGoNXXzvvn+YmCcjLu6ttAJGGTaN8+O_tNdPqcjHnfUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABOYnLwGoNXXzvvn+YmCcjLu6ttAJGGTaN8+O_tNdPqcjHnfUA@mail.gmail.com>

On Wed, Dec 13, 2023 at 02:35:58PM +0800, xingwei lee wrote:
> Hello, I reproduced this bug with repro.c and repro.txt since it
> relatively large please see
> https://gist.github.com/xrivendell7/b3b804bbf6d8c9930b2ba22e2dfaa6e6
> 
> Since this bug in the dashboard
> https://syzkaller.appspot.com/bug?extid=0c64a8706d587f73409e use
> kernel commit: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?id=aed8aee11130a954356200afa3f1b8753e8a9482
> kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=df91a3034fe3f122
> 
> my repro.c use the seem config and it crash report like below, and
> it’s almost can make sure it the same as bug reported by syzobt.

Uh, can you reproduce this on mainline?
I so far fail to even with your repro.

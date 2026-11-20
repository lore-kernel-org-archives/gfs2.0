Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795175004;
	b=w/gF6jaPB6mGs598LUZglqeRgialpkmCfcB8ZzmsgVE2ShyNQxQPu/+Gktm3RMCNLT1L
	 rxLIRkNRBowTVQubbZ3FYvTPEv+uxWt3P/8HHH0IBO3Uuzog2dsNsDfJ6TYPFKrzIyo3E
	 uV4QI6vzdLR56K3BDQD5v/s9CHVMZm1oN06f55JlxvpKCuWJKBiFns9aOSbFew6TdSgNR
	 q8g3d3p4M1zqIpFu1UyWxEf2T6qFQKo3SQ6aXFyhTRYN/HCAVJvuigmDaMJ0/dOtUnFrC
	 9yVmOfWT3XkfD9iCEZ7/HeQibZjTiLBANFaavJyzte051gXGjvYseN/o1jYtKR3IssQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795175004;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=8HrHU6q7cUwC44mKCqsCYf3Tfsp+5D/gKCLIsZFQVSA=;
	b=LbBX4ZsKGshs2w/JtfG4ynwBKJnef4vRNrEpBo0qZUbqZAqBk5YU5gOBNkz5EZMgXNV6
	 3bGLakZEC9JodBBP4OsMZBHzo0YtYbGhJZVtMRXrN1BcpcEaYVBqRHOPFHaQkr7D3Tixh
	 fsElk1ka9ugZZyRA5jZHUlXGL47Xl1UdWBJ26EVOQ0SRACy+QrHYGnr3UOuUo4QkafpE5
	 itxNkh18eD/1k5mGzpMkLfRWrnaY57R2z7YS5i14nNLqek5H4TNvFQpE1msvMCUIgrC6d
	 02SwMmzB2B5mvJ566fk0cASR8g4uvWC3e05nnz2gQdMkwa/5eoNTyvG4HbFNRxzo1Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29EA606A325
	for <gfs2@lists.linux.dev>; Fri, 20 Nov 2026 11:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C29EA606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jWD3t14szzVcB6;
	Fri, 20 Nov 2026 19:43:06 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jWD3s0Pp3zVcB6;
	Fri, 20 Nov 2026 19:43:05 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 3E53A16E7;
	Fri, 20 Nov 2026 19:42:56 +0800 (CST)
Received: from hsj-2U-Workstation (172.19.24.226) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 20 Nov
 2026 19:43:03 +0800
Date: Fri, 20 Nov 2026 19:43:01 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: Christian Brauner <brauner@kernel.org>
CC: Christoph Hellwig <hch@infradead.org>, <axboe@kernel.dk>,
	<viro@zeniv.linux.org.uk>, <jack@suse.cz>, <zhongyuan@hygon.cn>,
	<fangbaoshun@hygon.cn>, <yingzhiwei@hygon.cn>, <agruenba@redhat.com>,
	<mic@digikod.net>, <gnoack@google.com>, <paul@paul-moore.com>,
	<jmorris@namei.org>, <serge@hallyn.com>, <aleksa@amutable.com>,
	<legion@kernel.org>, <david@kernel.org>, <sandeen@redhat.com>,
	<ebiggers@kernel.org>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<gfs2@lists.linux.dev>, <linux-security-module@vger.kernel.org>,
	<sunjunchao@bytedance.com>, <shijie8@gmail.com>
Subject: Re: [PATCH v2 1/3] vfs: add inode iteration methods
Message-ID: <awAyRVD3URaBPhw7@hsj-2U-Workstation>
References: <20261113115702.586594-1-huangsj@hygon.cn>
 <20261113115702.586594-2-huangsj@hygon.cn>
 <avcBTMvzFWuCkwkn@infradead.org>
 <avqmmP4dbwu4ziKz@hsj-2U-Workstation>
 <20261120-mitverantwortlich-drehbaren-kantholz-241300d20168@brauner>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261120-mitverantwortlich-drehbaren-kantholz-241300d20168@brauner>
X-ClientProxiedBy: cncheex06.Hygon.cn (172.23.18.116) To cncheex04.Hygon.cn
 (172.23.18.114)

在 Fri, Nov 20, 2026 at 12:14:24PM +0100，Christian Brauner 写道：
> On Mon, Nov 16, 2026 at 02:45:44PM +0800, Huang Shijie wrote:
> > > 	struct inode_iter_contex ctx = INODE_ITER_CTX_INIT;
> > > 
> > > 	while ((inode = sb_inode_iter()))) {
> > > 		/* do stuff */
> > > 	}
> > > 
> > How to manage the sb->s_inode_list_lock in this code?
> > 
> > I have no idea how to hide the sb->s_inode_list_lock in this code.
> 
> I think Christoph is right. The lock shouldn't be held across
> iterations. Let the iterator take it, grab a reference to the next
> inode, drop the lock again and hand the inode out. The reference keeps the
okay. 

If we can accept this method, I can change the code following it in future.

> inode on s_inodes so the next call can continue from there.
> 
> This is how drop_pagecache_sb() does it today. Sm like (UNTESTED and not
> nice-ified):
> 
> struct sb_inode_iter {
> 	struct super_block *sb;
> 	struct inode *inode;
> 	bool done;
> };
> 
> struct inode *sb_inode_iter_next(struct sb_inode_iter *it)
> {
> 	struct super_block *sb = it->sb;
> 	struct inode *prev = it->inode, *inode;
> 
> 	if (it->done)
> 		return NULL;
> 
> 	spin_lock(&sb->s_inode_list_lock);
> 	inode = list_prepare_entry(prev, &sb->s_inodes, i_sb_list);
> 	list_for_each_entry_continue(inode, &sb->s_inodes, i_sb_list) {
> 		spin_lock(&inode->i_lock);
> 		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) {
> 			spin_unlock(&inode->i_lock);
> 			continue;
> 		}
> 		__iget(inode);
> 		spin_unlock(&inode->i_lock);
> 		spin_unlock(&sb->s_inode_list_lock);
> 		it->inode = inode;
> 		iput(prev);
> 		return inode;
> 	}
> 	spin_unlock(&sb->s_inode_list_lock);
> 	it->inode = NULL;
> 	it->done = true;
> 	iput(prev);
> 	return NULL;
> }
> 
> void sb_inode_iter_end(struct sb_inode_iter *it)
> {
> 	iput(it->inode);
> 	it->inode = NULL;
> 	it->done = true;
> }
> 
> and then drop_pagecache_sb() becomes:
> 
> 	struct sb_inode_iter it = { .sb = sb };
> 	struct inode *inode;
> 
> 	while ((inode = sb_inode_iter_next(&it))) {
> 		invalidate_mapping_pages(inode->i_mapping, 0, -1);
> 		cond_resched();
> 	}
> 
> Make it a cleanup class and a caller that breaks out early doesn't have
> to remember sb_inode_iter_end() either.
> 
> This will end because new inodes are added at the head and the cursor
> stays on the list. So these assumptions should get
> VFS_WARN_ON_ONCE()-es.
> 
> Walkers that can't take a reference might need different solution.
> I'm not sure if there are any?
I will think about it.

Thanks
Huang Shijie


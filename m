Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795745120;
	b=PJPhwNM1PqIIqboGW8cXKDperRwCDpGw2xm6D7PzNIb1ZZcioFAeisGGCuJJYiRzaD7X
	 Bmjq9GXECRTcR/9wAdZX5Os0E0CBkLVM66U7AHC2PYFpk8xbMJiUutYgE9D9Lw/Pw6otg
	 njIMVhMWg5OpGf5mDakVCJPdteXPmP2JDdOkQC4NY5RcWsh+H116XyqwY9rE0MqpFVbm0
	 XGcSefYSOEjUq2g50XDsjJgQSbbCe4HaQgm+05Uap8UeoyG5yu4L3FU7toidZ34fgmF6t
	 zbeytoiCiYEE09BYJPb2VMGNEb1ewGdAxBARasGNzXKdWuy+YYnRHPufcr1Ps/Fo77g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795745120;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=Vt8/L4ecYvwNmeRLxuD0Q0YLKG91gPCwqmvKaWbtGcE=;
	b=aGF+QHYFnJpyggNt2GCxFi1U5D+WyQt8iu8TDjZZKunGn38LQbN0OnDu6Ny1Thi+b0le
	 +7qsNJ3K3VAzpU5mb0jRxaXkvTl7qF3hqf3TcOYOmt7ZwU9MDKIXff3B2oD+Cnaa9GOy2
	 nRtQCuWE0BHhvXJbvZWrIJx7G1dz6DJeLx39zXPdzZQENIy0ixh1z+ePSe1FPuxWom/FD
	 Lc5Um+I0mM9oAsHk3y3/zfuWZMjUgSzXLr5hu44f6gCt4xkHnxyzb8bH2lRPrxStGaHAe
	 4PHxLBB1UzgZ/NGtq8ityqnXnxEbBHg6G9PIbyfmOGYEAqUyxBTFMBw2Fbauzo1lidQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5689E606A31C
	for <gfs2@lists.linux.dev>; Fri, 27 Nov 2026 02:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5689E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jbGvf4vHdzg1cV;
	Fri, 27 Nov 2026 10:05:02 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jbGvd6sBVzg1cV;
	Fri, 27 Nov 2026 10:05:01 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id 40151300B6ED;
	Fri, 27 Nov 2026 10:03:47 +0800 (CST)
Received: from hsj-2U-Workstation (172.19.24.226) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 27 Nov
 2026 10:05:00 +0800
Date: Fri, 27 Nov 2026 10:04:58 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: Andreas Gruenbacher <agruenba@redhat.com>
CC: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<hch@infradead.org>, <mic@digikod.net>, <axboe@kernel.dk>,
	<gnoack@google.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <legion@kernel.org>, <aleksa@amutable.com>,
	<libaokun@linux.alibaba.com>, <ebiggers@kernel.org>, <djwong@kernel.org>,
	<sandeen@redhat.com>, <zhongyuan@hygon.cn>, <fangbaoshun@hygon.cn>,
	<yingzhiwei@hygon.cn>, <wujianyong@hygon.cn>, <shijie8@gmail.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-block@vger.kernel.org>, <gfs2@lists.linux.dev>,
	<linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v4 00/11] vfs: add inode iteration methods
Message-ID: <awjlSpzDdAXAt2-k@hsj-2U-Workstation>
References: <20261125091157.1822521-1-huangsj@hygon.cn>
 <CAHc6FU4h-FRvLkO_0ouTey9MbX=n61t3abt4hPNFOthsRGG9mQ@mail.gmail.com>
 <awgi6a0Hayug7RJH@hsj-2U-Workstation>
 <CAHc6FU4KLxzoQ6NJQUnFfcbKufqwqdhfcGhva9V44K=J7HCXRg@mail.gmail.com>
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
In-Reply-To: <CAHc6FU4KLxzoQ6NJQUnFfcbKufqwqdhfcGhva9V44K=J7HCXRg@mail.gmail.com>
X-ClientProxiedBy: cncheex06.Hygon.cn (172.23.18.116) To cncheex04.Hygon.cn
 (172.23.18.114)

在 Thu, Nov 26, 2026 at 03:32:08PM +0100，Andreas Gruenbacher 写道：
> On Thu, 26 Nov 2026 at 13:20, Huang Shijie <huangsj@hygon.cn> wrote:
> > 在 Wed, Nov 25, 2026 at 11:25:12PM +0100，Andreas Gruenbacher 写道：
> > > Huang,
> > >
> > > I have some thoughts ...
> > >
> > > On Wed, 25 Nov 2026 at 10:18, Huang Shijie <huangsj@hygon.cn> wrote:
> > > > This series adds a superblock inode iterator and converts the open-coded
> > > > sb->s_inodes walks in the VFS to it.  The design follows the cursor-based
> > > > construct proposed by Christian Brauner:
> > > >
> > > >   https://lore.kernel.org/all/20261120-mitverantwortlich-drehbaren-kantholz-241300d20168@brauner/
> > > >
> > > > and is the same direction as Dave Chinner's patch set:
> > > >
> > > >   "vfs: improving inode cache iteration scalability"
> > > >   https://lore.kernel.org/all/20241002014017.3801899-1-david@fromorbit.com/
> > > >
> > > > The caller owns the iterator state and drives the walk itself:
> > > >
> > > >   CLASS(sb_inode_iter, iter)(sb, eligible, priv, flags);
> > > >   while ((inode = sb_inode_iter_next(&iter)))
> > > >           /* do stuff */;
> > >
> > > The pattern should be:
> > >
> > >   for (CLASS(...); ...; ...) {
> > >       /* ... */
> > >       if (/* end iteration early */)
> > >           break;
> > >       /* ... */
> > >   }
> > >
> > > so that the iterator goes out of scope immediately when the loop ends.
> > > Hide the details of the loop header in a macro and that this becomes:
> > >
> > >   for_each_inode(inode, sb) {
> >
> > The fs/jffs2/build.c has used this for_each_inode.
> > Maybe change to for_each_sb_inode?
> 
> That's the least of all problems; just rename the jfs macro.
> 
> > >       /* inode is referenced and unlocked here */
> > >   }
> > >
> > > Use that to convert the simple cases.
> > >
> > > And then we've got preconditions that are checked while the inode is
> > > locked. Those can probably go in an expression:
> > >
> > >   for_each_inode(inode, sb, expression) {
> > We still need add flags here.
> >
> > In evict_inodes() and hook_sb_delete(), only the expression is not enough.
> 
> I know, these are the two cases that check i_count before the inode is
> even locked. Leave them as they are for now; we can get back to that
> later.
okay.

> 
> > How about add a raw code like this:
> >
> >     for_each_inode_raw(inode, sb, expression, flags) {
> >     }
> >
> > And add a macro for_each_inode:
> >   #define for_each_inode(inode, sb, expression)  for_each_inode_raw(inode, sb, expression, 0)
> >
> > Most of the cases, we can use the for_each_inode.
> >
> > But in the evict_inodes() and hook_sb_delete() we can use the for_each_inode_raw.
> 
> No. Convert the simple cases first, with iterator constructs that are
> as simple as possible. Later, worry about the more complicated cases.
Got it.

> 
> > >       /* expression was true */
> > >       /* inode is referenced and unlocked here */
> > >   }
> > >
> > > This unfortunately cannot be implemented on top of the
> > > sb_inode_iter_next() pattern, at least not in a reasonable way, so we
> > > actually shouldn't use that pattern.
> > >
> > > The locked iterator would look like this:
> > >
> > >   for_each_inode_locked(inode, sb) {
> >
> > I tried this way today.
> >
> > The macro for_each_inode_locked is complicated.
> > When I tried to add more hooks to super_operations to implement the
> > procfs issue, the for_each_inode_locked becomes more complicated.
> >
> > BTW: the procfs issue see the link:
> >   https://lore.kernel.org/all/20260920072811.2064247-1-huangsj@hygon.cn/
> 
> Introducing reasonable inode iteration constructs is a completely
> separate problem from introducing per-super block inode iterators.
> Please keep those issues apart.
okay.

> 
> > >       /* inode is locked here */
> > >   }
> > >
> > > This doesn't cover all existing cases, but that's okay. Don't force
> > > things into this pattern that are not a match.
> > >
> > > We can always extend things further if it makes sense.
> > >
> > > > The lock does not span iterations.  sb_inode_iter_next() takes
> > > > sb->s_inode_list_lock, takes a reference on the next inode, drops the lock
> > > > again and hands the inode out; the reference is what keeps the cursor on
> > > > sb->s_inodes so that the next call can resume from it.  As the iterator
> > > > is a cleanup class, a caller that breaks out early does not have to call
> > > > sb_inode_iter_end() explicitly.
> > > >
> > > > Two optional channels let a caller keep its own state instead of filling in
> > > > a shared context:
> > > >
> > > >   - iter->eligible is called with inode->i_lock held, so that a caller can
> > > >     reject an inode before a reference is paid for.
> > > >
> > > >   - iter->status carries an error out of the walk.  Setting it to a
> > > >     negative value makes sb_inode_iter_next() return NULL.
> > >
> > > Nobody needs that. Just break out of the loop.
> > >
> > > > Most callers just want a referenced inode and use no flags at all.  Three
> > > > flags cover the walks that need something else:
> > > >
> > > >   - %INO_ITER_F_REFERENCED restricts the walk to inodes that still have a
> > > >     reference, preserving the "only handle referenced inodes" rule of
> > > >     landlock's sb-delete walk.
> > > >
> > > >   - %INO_ITER_F_NOREF hands out only inodes whose reference count has
> > > >     already reached zero, and %INO_ITER_F_NOIGET suppresses the reference.
> > > >     Neither keeps the inode alive, so the caller has to make the inode
> > > >     unclaimable itself.
> > >
> > > No flags.
> > If we do not add flags, we cannot convert the evict_inodes() and hook_sb_delete().
> 
> No flags.

Okay. I will start the V5 right now.

Thanks
Huang Shijie


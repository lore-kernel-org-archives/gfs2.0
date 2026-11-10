Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794277987;
	b=BF0s3BlY+OSsb1sFv6H8ZtzrA9l5gm9XPBTFqLP9ZHfUhAlX3qfktlI5qwXdzIEeKU+4
	 xlMlGLwfxKRxrEZQdb012SrTFwr+DH09TBhzVWO6t9IR/g/K+V4sjiT+xFeNIewCu8i6U
	 +q0yjtXZSSdm6Rcrf38sqhOta6qaPDfaPBgadI57O2RmU/ytUwRXELetw44z4qGV1WGyp
	 EZz8M2ACpzShFF3oZ12aWcZNaCSd5yYuNzZAg+jThU8mt4kpIVzXAG1fV0B6zoJgwc48u
	 NUQLCAOMwzPsW9FsMuVrFNOzJcbOTKl+s4MK55hFAcBXwA9FzhqNn5PvawyYK1k91Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794277987;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=9dgmceogV8A29X7A/g9/D+jZBOgcl/3xennCOoQQw9A=;
	b=YBsXzIoaJu2HOcZYnhsIQqdozaqbaWkkwQmOrxltffDPDLtRqqYOuEhneIbRVgav6NBr
	 C2m9haCs7uOACOxA7Stw++pGgafdhP79v9eE7xCxw9G7iGQvAJALn4PlkGoHnYq2Ta1mm
	 7FmKGhP0BVcnvE1le+0lhNEm7stWJyFdG0QBDfogNkxnm0MheLKtIEC9CJijim8NEyouS
	 TE7sy0NgYTnUGImC2o7ZPhutq3uQc3Kcw28iVzPcjVcykOnxmW5seMM6Ly3Kn9Bxv7cOS
	 jYUGjtD0VlxGYOTK+rUlfFsuniHxT1hek/vCr9maUD1yozZevWWQA26J8DeDHdRAmwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB78F606A330
	for <gfs2@lists.linux.dev>; Tue, 10 Nov 2026 02:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB78F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jNrKY4YTyz9j2Jw;
	Tue, 10 Nov 2026 10:32:49 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jNrKX11Lwz9j2Jw;
	Tue, 10 Nov 2026 10:32:48 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 48EDEDC08;
	Tue, 10 Nov 2026 10:32:44 +0800 (CST)
Received: from hsj-2U-Workstation (172.19.24.226) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 10 Nov
 2026 10:32:46 +0800
Date: Tue, 10 Nov 2026 10:32:44 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: Jan Kara <jack@suse.cz>
CC: <axboe@kernel.dk>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
	<zhongyuan@hygon.cn>, <fangbaoshun@hygon.cn>, <yingzhiwei@hygon.cn>,
	<agruenba@redhat.com>, <mic@digikod.net>, <gnoack@google.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<aleksa@amutable.com>, <legion@kernel.org>, <david@kernel.org>,
	<sandeen@redhat.com>, <ebiggers@kernel.org>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<gfs2@lists.linux.dev>, <linux-security-module@vger.kernel.org>,
	<sunjunchao@bytedance.com>
Subject: Re: [PATCH 1/3] vfs: add inode iteration method super_iter_inodes
Message-ID: <avKCTDUKe3DucSY4@hsj-2U-Workstation>
References: <20261015093854.2082600-1-huangsj@hygon.cn>
 <20261015093854.2082600-2-huangsj@hygon.cn>
 <wepk7b6hw44k7aodwmk24mt4ied25jl5zzdyd5dfx3pjop6omq@bvld6lyzbetm>
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
In-Reply-To: <wepk7b6hw44k7aodwmk24mt4ied25jl5zzdyd5dfx3pjop6omq@bvld6lyzbetm>
X-ClientProxiedBy: cncheex06.Hygon.cn (172.23.18.116) To cncheex04.Hygon.cn
 (172.23.18.114)

在 Mon, Nov 09, 2026 at 10:58:43AM +0100，Jan Kara 写道：
> > +int super_iter_inodes(struct super_block *sb, ino_iter_fn iter_fn,
> > +		      void *private_data, int flags)
> > +{
> > +	if (flags & INO_ITER_F_UNSAFE)
> > +		return generic_iter_inodes_unsafe(sb, iter_fn, private_data);
> 
> Since unsafe iteration is a separate function anyway and we advertise it as
> an "internal VFS" function (which I agree with), I'd just have
No problem.

I will change it in next version.

> super_iter_inodes() for the normal iteration and super_iter_inodes_unsafe()
> for the unsafe iteration which won't be exported to modules (so we really
> get the message across this should be VFS internal function). 
> 
> > +
> > +	return generic_iter_inodes(sb, iter_fn, private_data, flags);
> > +}
> > +EXPORT_SYMBOL_GPL(super_iter_inodes);
> > +
> 
> ...
> > +/* Inode iteration callback return values */
> > +#define INO_ITER_RET_DONE		0
> 
> Maybe INO_ITER_RET_NEXT? DONE looks too much like the loop should finish.
okay.

Thanks
Huang Shijie


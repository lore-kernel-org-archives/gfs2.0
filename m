Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794292192;
	b=SfNG+DmXkzCwp0CS6iHO5gMLdJC0kq/TZgzjHXs+7zNgmN8yJn/Omc8xo9N2Efk2ipg1
	 zlaP040VjPbES6imXC2yo0eiFsvjT42FA7QzafNBnN8ZS2mTFlS1O9RD9Q1ed7F/Z4NSE
	 yP8LEmTC6Z4EUYWk4FVxKjOsk/jezd4FddAgeRvEiur1BHmq2XPh8UINJoIawNv8OW3/o
	 hpK7CKf08wpJv3qDwV2S6R6YCNKb7XMamUV/DgoRVf+ySoyzyHY6Cy3Oo5/6vsWAfbj0E
	 ockBmlBksjs1HtJbX339ouLQk6UOWADi07xCPxpYjML315B8XUuUUUJdR3SHBwlGZcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794292192;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=mgKCRgRdNiIKmHGzM5jiXbcVj17jpTU0EAW2FbfsR2g=;
	b=emJuuulEucfFBDo2zuE1e6u/ZfIdBUy4d2a5ZRYahnB9iw50WKKoWbXKMF+fhyVILnwc
	 rQHYuDZOixtpVpf84Mc5FYW5vOvp1Sxd9junPITFobglSSYKN3dkv8FZ5EMGtmhbrkqmP
	 0uL4KLCGvV7SL2VPJP9gp1N9yzlcdvTeA2/qoNn8uG926suTLTeuDmPMys5MFvja2fW8y
	 F5dJsynJKOuG3EtTng6+GGYIExs0+msl5oXlLiQmGOl1RibRBsRevq4ZGju0YMaK0Wf/I
	 yzBO6D/LcO8vhzBpM4xdr81i8tkTqgiYjkx6vvBYFPIdtCCWXSkIcEyhL5mO3NRTRhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FB1606A31C
	for <gfs2@lists.linux.dev>; Tue, 10 Nov 2026 06:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3FB1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jNxZh5z6fzBCqx8;
	Tue, 10 Nov 2026 14:29:32 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jNxZf5vhYzBCqx6;
	Tue, 10 Nov 2026 14:29:30 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id E35FE30A6439;
	Tue, 10 Nov 2026 14:28:45 +0800 (CST)
Received: from hsj-2U-Workstation (172.19.24.226) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 10 Nov
 2026 14:29:28 +0800
Date: Tue, 10 Nov 2026 14:29:26 +0800
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
Subject: Re: [PATCH 3/3] vfs: convert sb->s_inodes iteration to
 super_iter_inodes()
Message-ID: <avK5xg_TYW66t2PE@hsj-2U-Workstation>
References: <20261015093854.2082600-1-huangsj@hygon.cn>
 <20261015093854.2082600-4-huangsj@hygon.cn>
 <wrknznlm52ffratfpdoe3otqhkgyd45vgmvtjkixrvurwpplyu@sfpz3yiwhidy>
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
In-Reply-To: <wrknznlm52ffratfpdoe3otqhkgyd45vgmvtjkixrvurwpplyu@sfpz3yiwhidy>
X-ClientProxiedBy: cncheex06.Hygon.cn (172.23.18.116) To cncheex04.Hygon.cn
 (172.23.18.114)

在 Mon, Nov 09, 2026 at 11:31:41AM +0100，Jan Kara 写道：
> > +static int sync_bdev_fn(struct inode *inode, void *data)
> >  {
> > -	struct inode *inode, *old_inode = NULL;
> > +	struct block_device *bdev;
> > +	bool wait = *(bool *)data;
> >  
> > -	spin_lock(&blockdev_superblock->s_inode_list_lock);
> > -	list_for_each_entry(inode, &blockdev_superblock->s_inodes, i_sb_list) {
> > -		struct address_space *mapping = inode->i_mapping;
> > -		struct block_device *bdev;
> > +	if (inode->i_mapping->nrpages == 0)
> 
> Seeing these various checks iterators are doing before actually paying the
> cost of grabbing (and dropping) the inode reference, I'd add a
> ->elegible(inode) function to the iterator which will get called under
> i_lock after other checks pass and can decide inode is not worth bothering
> with and put the checks there. If it is NULL, the behavior would be as
> currently.
Okay.
I will add the ->eligible() function to the iterator in next version.

Thanks
Huang Shijie


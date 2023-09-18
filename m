Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD311CA8E
	for <gfs2@lists.linux.dev>; Mon, 18 Sep 2023 12:00:00 +0000 (UTC)
Received: from [78.30.34.192] (port=34322 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1qiCuq-009r2A-JV; Mon, 18 Sep 2023 13:59:50 +0200
Date: Mon, 18 Sep 2023 13:59:47 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Alexander Aring <aahringo@redhat.com>,
	Network Development <netdev@vger.kernel.org>, kadlec@netfilter.org,
	fw@strlen.de, gfs2@lists.linux.dev,
	David Teigland <teigland@redhat.com>, tgraf@suug.ch
Subject: Re: nft_rhash_walk, rhashtable and resize event
Message-ID: <ZQg7s8MtByk4kfzP@calendula>
References: <CAK-6q+ghZRxrWQg3k0x1-SofoxfVfObJMg8wZ3UUMM4CU2oiWg@mail.gmail.com>
 <ZQUjD0liUnH+ykKY@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZQUjD0liUnH+ykKY@gondor.apana.org.au>
X-Spam-Score: -1.9 (-)

Hi Herbert,

On Sat, Sep 16, 2023 at 11:37:51AM +0800, Herbert Xu wrote:
> On Fri, Sep 15, 2023 at 10:05:06AM -0400, Alexander Aring wrote:
> >
> > My question is here? Is that allowed to do because a resize event may
> > change the order how to iterate over a rhashtable.
> 
> Walking over an rhashtable should be a last resort.  There is
> no guarantee of stability.
> 
> If you skip entries after a resize then you may miss entries.

One more question: this walk might miss entries but may it also
duplicate the same entries?

> If you want a stable walk, allocate an extra 8 bytes and use
> a linked list.

I will work on a patch to update netfilter clients for this code to
use a rcu linked list.

Thanks.

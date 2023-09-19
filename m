Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3F08480
	for <gfs2@lists.linux.dev>; Tue, 19 Sep 2023 03:24:43 +0000 (UTC)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1qiRLi-00Fmxi-TJ; Tue, 19 Sep 2023 11:24:31 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 19 Sep 2023 11:24:33 +0800
Date: Tue, 19 Sep 2023 11:24:33 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Alexander Aring <aahringo@redhat.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Network Development <netdev@vger.kernel.org>, kadlec@netfilter.org,
	fw@strlen.de, gfs2@lists.linux.dev,
	David Teigland <teigland@redhat.com>, tgraf@suug.ch
Subject: Re: nft_rhash_walk, rhashtable and resize event
Message-ID: <ZQkUcXtwSLtC/OLV@gondor.apana.org.au>
References: <CAK-6q+ghZRxrWQg3k0x1-SofoxfVfObJMg8wZ3UUMM4CU2oiWg@mail.gmail.com>
 <ZQUjD0liUnH+ykKY@gondor.apana.org.au>
 <ZQg7s8MtByk4kfzP@calendula>
 <ZQhButkhI8K6cduD@gondor.apana.org.au>
 <CAK-6q+jLe_WnsMrkASv_AB722YARP=f7j=Je2VZYOKjfYUKcuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK-6q+jLe_WnsMrkASv_AB722YARP=f7j=Je2VZYOKjfYUKcuA@mail.gmail.com>

On Mon, Sep 18, 2023 at 08:38:09AM -0400, Alexander Aring wrote:
>
> To confirm this, redo the whole walk means starting at
> rhashtable_walk_start() again?

According to the documentation:

 * Returns -EAGAIN if resize event occurred.  Note that the iterator
 * will rewind back to the beginning and you may use it immediately
 * by calling rhashtable_walk_next.

So you shouldn't have to do anything other than keep on
iterating (if you wish to).

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

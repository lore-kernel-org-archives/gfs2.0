Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B97C1CFAC
	for <gfs2@lists.linux.dev>; Mon, 18 Sep 2023 12:56:47 +0000 (UTC)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1qiDJf-00FVXX-Bq; Mon, 18 Sep 2023 20:25:28 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 18 Sep 2023 20:25:30 +0800
Date: Mon, 18 Sep 2023 20:25:30 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Alexander Aring <aahringo@redhat.com>,
	Network Development <netdev@vger.kernel.org>, kadlec@netfilter.org,
	fw@strlen.de, gfs2@lists.linux.dev,
	David Teigland <teigland@redhat.com>, tgraf@suug.ch
Subject: Re: nft_rhash_walk, rhashtable and resize event
Message-ID: <ZQhButkhI8K6cduD@gondor.apana.org.au>
References: <CAK-6q+ghZRxrWQg3k0x1-SofoxfVfObJMg8wZ3UUMM4CU2oiWg@mail.gmail.com>
 <ZQUjD0liUnH+ykKY@gondor.apana.org.au>
 <ZQg7s8MtByk4kfzP@calendula>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQg7s8MtByk4kfzP@calendula>

On Mon, Sep 18, 2023 at 01:59:47PM +0200, Pablo Neira Ayuso wrote:
>
> One more question: this walk might miss entries but may it also
> duplicate the same entries?

It depends on what happens during the walk.  If you're lucky
and no resize event occurs during the walk, then you won't miss
any entries or see duplicates.

When a resize event does occur, then we will tell you that it
happened by returning EAGAIN.  It means that you should start
from the beginning and redo the whole walk.  If you do that
then you won't miss anything (although, you may never finish
if the table keeps getting resized).

But obviously duplicates will occur if you take this approach.

> I will work on a patch to update netfilter clients for this code to
> use a rcu linked list.

Sounds good!

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

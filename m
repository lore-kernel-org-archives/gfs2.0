Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794452024;
	b=H6Fj0jVWKsOIh8lZC0p2v/+5QiUPfP7i/tfevLVyhG03oiw+l4wTKwMOglbNGyVPm+PB
	 XlnnZwNUAH+aIx4Flc3DcFMEmoy1IjC+VPwNINsVIBy8x7SG2GsqLUIt9SNjIdfx6ggIC
	 gy5HZorARm5Yvnr8gNyYJAxXonUwJSAepTK0Kr71GxRcRinm+pKpYf9I8kSuvxeL3aYBK
	 Ad320QbFHTp6LTwcDRgE0SbHlJzB3rq1F5Zyn0TBw+Odq2ETlRqyGwXOwY4z/5HZa0UiA
	 wcYZ/I3vVRO+NDf+SdyJGl61Cm9YUETFLzbvMKSwcw8WNbOFm/B3a0C9WKFB57MoSgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452024;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=/cOEvzfTmLtCNzwUoH+WlzB71QyL8D0I1pIinOCRzTI=;
	b=1o568vseaQMUG+xfnx/U7JbVQlNi9HGzXIz0TZeZKMOTXxcc7vWQIrbn1VPwxCz3vqBd
	 ISB4ZMCpFsrg8izYPTFb1c5PYbi8pIva6QV2ctkkZSTk4Q1bdpdhr5zrE88L/ikbOvNj7
	 UdJitRtQy4laarTPvRysEVCQqCfh0zM9K5FJjnPKig5+RUVUKNOPUSOn33R+9qmjk+7lG
	 Y6MWPKe5paUQ9Vyg08XBu+7pKzWIidjvfbubS+Iw39Ev3emUTE9d7wjpV1Ljj46ydI33r
	 DJ8BPVzXBxc7JuOad0yfawmpQEDL/hgrYmqtksaso0ggLudmTZteRaBdp0owLSCBXqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GwRr4NbL;
	arc=none smtp.remote-ip=115.124.30.111
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8650E606A327
	for <gfs2@lists.linux.dev>; Thu, 12 Nov 2026 02:53:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8650E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GwRr4NbL
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794452015; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/cOEvzfTmLtCNzwUoH+WlzB71QyL8D0I1pIinOCRzTI=;
	b=GwRr4NbL92PaE9dXiYqpfaEQmojlJoXCfa6qSp6fbxgp5NX9teVBnzg2EdupgfFdX/jj8Xbcz0FSRE0EUfnSfOvhd+nDcg0Qi3N+PJhFrljLap0oDnbRZu18Sf0icb9sQbHGslxknnSpCDuzDsrCQOP/3WNYmL8C492jwTifXvM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0XEaSnJV_1794452014;
Received: from 30.221.145.78(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0XEaSnJV_1794452014 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Nov 2026 10:53:34 +0800
Message-ID: <c5d699e4-12cd-4321-9b23-7d340ea8e959@linux.alibaba.com>
Date: Thu, 12 Nov 2026 10:53:33 +0800
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] gfs2: release the statfs glock when
 gfs2_clear_beyond_eof() fails
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261105054609.2759418-1-joseph.qi@linux.alibaba.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261105054609.2759418-1-joseph.qi@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Ping...

On 11/5/26 1:46 PM, Joseph Qi wrote:
> gfs2_file_buffered_write() acquires the master statfs glock before
> writing to the rindex and releases it once the write is done.  The only
> error path in between used to be the failure of that acquisition, which
> gfs2_glock_nq_init() unwinds by itself, so the cleanup code at the end of
> the function never had to deal with a held statfs glock.
> 
> Commit 4982e58669b1 ("gfs2: page poisoning fix") added a call to
> gfs2_clear_beyond_eof() right after the acquisition and made it jump to
> out_unlock on failure.  That path only drops the inode glock and then
> frees statfs_gh, so a failed write to the rindex leaves the master
> statfs glock held exclusively and frees a holder that is still linked
> into the glock's holder list.  The GL_NOCACHE demote is requested by
> __gfs2_glock_dq(), which is never reached, so the glock stays locked for
> the rest of the mount, and the glock and pid references taken by
> __gfs2_holder_init() leak as well.  Walking the stale list entry later
> on, for instance from do_promote() or from a demote callback, is a
> use-after-free.
> 
> gfs2_clear_beyond_eof() zeroes the space beyond eof, which for the
> rindex ends up in adjust_fs_space(), so the call cannot be moved out
> from under the statfs glock.  Release the holder in the error path
> instead, guarded by gfs2_holder_initialized() so that the paths which
> never acquired it and the one which already released it are unaffected.
> 
> Fixes: 4982e58669b1 ("gfs2: page poisoning fix")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/gfs2/file.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> index 1efd0679badd9..2452d3ecf09c7 100644
> --- a/fs/gfs2/file.c
> +++ b/fs/gfs2/file.c
> @@ -1087,6 +1087,8 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb,
>  		goto retry;
>  	}
>  out_unlock:
> +	if (inode == sdp->sd_rindex && gfs2_holder_initialized(statfs_gh))
> +		gfs2_glock_dq_uninit(statfs_gh);
>  	if (gfs2_holder_queued(gh))
>  		gfs2_glock_dq(gh);
>  out_uninit:


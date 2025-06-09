Received: from mail-108-mta122.mxroute.com (mail-108-mta122.mxroute.com [136.175.108.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375AC27442
	for <gfs2@lists.linux.dev>; Mon,  9 Jun 2025 00:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749428655; cv=none; b=QO+0NC7ACUsKkGsxcMWNDpDDHSxJiZ7ABTPBSVv3vL7xnEglo7lgkr/I8zq7ZL3+Ctxng+evPHjSVsbcoCcRkmkMo4PhWnB1dUt1fB+1v6qFRFkXRHmwj0+1lWI+nFmnkBjFdD4d60tVkgXVrzlmVEnLm3SU7WuOhMnx0SAztfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749428655; c=relaxed/simple;
	bh=IgFvthWo1yWiwSboYXxEfhc4Z/WilVOjB4MeQZjsFX8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mj1VuWCUcHZBEPURUVVrWOZMIBBsbwHGhgO218GX8KCs3tGRvLvp7n801f7casi9oRUHY3LvEpByBqembRDuSua+CYqP1e7YUtT60XBqXz1+fKuiLYJRrL7GonZb8s5FVbyQQZleZGVmTte4LkGNxRqZUIXhoaWHX9qz+K4fDzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damenly.org; spf=pass smtp.mailfrom=damenly.org; dkim=pass (2048-bit key) header.d=damenly.org header.i=@damenly.org header.b=sBEFPaDf; arc=none smtp.client-ip=136.175.108.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damenly.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=damenly.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=damenly.org header.i=@damenly.org header.b="sBEFPaDf"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta122.mxroute.com (ZoneMTA) with ESMTPSA id 197520e067e0008631.002
 for <gfs2@lists.linux.dev>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 09 Jun 2025 00:19:00 +0000
X-Zone-Loop: fc5b77eac9aa9b9a3bcc870af320e717905e4319bf1a
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=damenly.org
	; s=x; h=Content-Type:MIME-Version:Date:References:In-Reply-To:Subject:Cc:To:
	From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=KQXRaTQ8T5tHP12OZ7l5V4aX0xsxuQjpDS5cJmN594w=; b=sBEFPaDf5iOx
	EhX+eznhot/K3FMB4CJQvQBILPrWk499fw73SoIN8z7laffiuVeMv1nik3njeWIRsiEa5JTso6Buy
	AN2lrz//75qJEY7/UOxwUySdclzg4GRKom3MnfvDQesYLd+eo9iYC9J1wBK1c46n8NK+WgNPiLkff
	jzetapH+YGuk5ioTRA+G5b/8KN2gHr3CMfk5jn8n0pHL+CaFA0s8QlddoQZpiB3y/H2VCJpBjf9H+
	+gtYUxvBNH0Ogb+v1cYEySaNv0O+iofrx5HFflIcvtwhhsRDsRPFdwvbaB7OQgA9EiCC2DBMDd9fp
	CHgMfKG3Sz+vxLSjVCKTsA==;
From: Su Yue <l@damenly.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Su Yue <glass.su@suse.com>,  gfs2@lists.linux.dev,  agruenba@redhat.com
Subject: Re: [PATCH 2/2] gfs2: do not call gfs2_jdata_writepages for jdata
In-Reply-To: <aELevNcGGuS5lSSI@casper.infradead.org> (Matthew Wilcox's message
	of "Fri, 6 Jun 2025 13:27:40 +0100")
References: <20250606094756.95958-1-glass.su@suse.com>
	<20250606094756.95958-3-glass.su@suse.com>
	<aELevNcGGuS5lSSI@casper.infradead.org>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Mon, 09 Jun 2025 08:18:51 +0800
Message-ID: <5xh5zs0k.fsf@damenly.org>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Authenticated-Id: l@damenly.org

On Fri 06 Jun 2025 at 13:27, Matthew Wilcox <willy@infradead.org> 
wrote:

> On Fri, Jun 06, 2025 at 05:47:56PM +0800, Su Yue wrote:
>> +++ b/fs/gfs2/aops.c
>> @@ -138,6 +138,46 @@ static int __gfs2_jdata_write_folio(struct 
>> folio *folio,
>>  	return gfs2_write_jdata_full_folio(folio, wbc);
>>  }
>>
>> +/**
>> + * gfs2_write_jdata_folio - Write folio
>> + * @folio: folio to write
>> + * @wbc: The writeback control
>> + *
>> + * Returns: errno
>> + *
>> + */
>> +
>> +static int gfs2_write_jdata_folio(struct folio *folio, struct 
>> writeback_control *wbc)
>> +{
>> +	struct inode *inode = folio->mapping->host;
>> +	struct gfs2_inode *ip = GFS2_I(inode);
>> +	struct gfs2_sbd *sdp = GFS2_SB(inode);
>> +
>> +	if (gfs2_assert_withdraw(sdp, ip->i_gl->gl_state == 
>> LM_ST_EXCLUSIVE))
>> +		goto out;
>> +	if (folio_test_checked(folio) || current->journal_info)
>> +		goto out_ignore;
>> +	return __gfs2_jdata_write_folio(folio, wbc);
>> +
>> +out_ignore:
>> +	folio_redirty_for_writepage(wbc, folio);
>> +out:
>> +	folio_unlock(folio);
>> +	return 0;
>> +}
>> +
>> +int gfs2_write_jdata_folios(struct address_space *mapping, 
>> struct writeback_control *wbc)
>> +{
>> +	struct folio *folio = NULL;
>> +	int error;
>> +
>> +	while ((folio = writeback_iter(mapping, wbc, folio, 
>> &error)))
>> +		error = gfs2_write_jdata_folio(folio, wbc);
>> +
>> +	return error;
>> +}
>
> The great thing about using an iterator pattern rather than a 
> callback
> pattern is that we don't need this stupid extra function.  So 
> you can
> drop patch 1 and just do this:
>
Thanks. That's what Andreas wrote in his patch 5a90f8d49922  :)

--
Su
> +	struct inode *inode = mapping->host;
> +	struct gfs2_inode *ip = GFS2_I(inode);
> +	struct gfs2_sbd *sdp = GFS2_SB(inode);
> +
> +	if (gfs2_assert_withdraw(sdp, ip->i_gl->gl_state == 
> LM_ST_EXCLUSIVE))
> +		return -Ewhatever;
> +
> +	while ((folio = writeback_iter(mapping, wbc, folio, &error))) 
> {
> +		if (folio_test_checked(folio) || current->journal_info)
> +			goto ignore;
> +		error = __gfs2_jdata_write_folio(folio, wbc);
> +		continue;
> +
> +ignore:
> +		folio_redirty_for_writepage(wbc, folio);
> +		folio_unlock(folio);
> +	}
> +
> +	return error;

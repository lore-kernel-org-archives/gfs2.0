Received: from mail-108-mta165.mxroute.com (mail-108-mta165.mxroute.com [136.175.108.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A848717597
	for <gfs2@lists.linux.dev>; Mon,  9 Jun 2025 00:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749428770; cv=none; b=MnUo6V1sqvfRigQ0Uyz1gcVqTCXD8aAhnq/BzzQ/9opApP6p7R9yavcf7iSID3E3yQJE6dlslSliWLqyLKeZFu9+pAJXg81it9MV7e/Tzj/lf35rqiALskkrbadsz0umG11OJ9yiBJvTJ7If2EQbiaFt6ORsXeM+URUfX/LtM2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749428770; c=relaxed/simple;
	bh=xTlwBFJxu8rMzmGD3br7gNiCGSPjmxhvVqLBA4OmD1w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jD893D6TYnkgFJ6N2Rtf/5POZ1UofNe56Zt/MAMcMbUoGON6J8gSfIUbIGwWZ1BMHokB+L7AG/wCb90DqDHF7Edjdv4UXBpKKepbyISdSjA2qjhc8LMxOgwTJc2r39rngvIK7dhXmH7ZC81UGLmwZH70FmuSOW5nwV1psePR12o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damenly.org; spf=pass smtp.mailfrom=damenly.org; dkim=pass (2048-bit key) header.d=damenly.org header.i=@damenly.org header.b=FF7ePFmA; arc=none smtp.client-ip=136.175.108.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damenly.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=damenly.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=damenly.org header.i=@damenly.org header.b="FF7ePFmA"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta165.mxroute.com (ZoneMTA) with ESMTPSA id 197520fd0330008631.002
 for <gfs2@lists.linux.dev>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 09 Jun 2025 00:20:57 +0000
X-Zone-Loop: b40604f67da64ddadbb9e0ce645fce0b19a8d67369db
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=damenly.org
	; s=x; h=Content-Type:MIME-Version:Date:References:In-Reply-To:Subject:Cc:To:
	From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=hoWcgiNtGiEgNC9JIfs0X10kzqvgtOdvpqPEFdgK69w=; b=FF7ePFmA/Tk7
	lutmfukDDWjuM+kd7VCIB6cIyWeoX/KhsVSp3x3M5XJp2JViFB4AgYfUSW4VxtX/ii2PuNB/7gnY0
	x4voQv861ey5WmZNPW/IcPLoe8skZGzFEoEuoghqlQjRzU0D7ou4YGUvLVgTTnnrRVjbEP2QlSMsc
	YmDBnLQwX+lybfUkHdJHKmINGLDPGUgGNFs+66qh5SWydSq/lZh0ItO3FRFczdjOharwalBBgoRoN
	kIDM2CipZkeFxTWgr889wFYUNrA9yCoi9mf1WKuyO2sgP1SauQSuwU+D7m8Rf+MGutZoYqRnzVCaO
	F+JGsJIXZSDXIiXR0YDyOw==;
From: Su Yue <l@damenly.org>
To: Su Yue <glass.su@suse.com>
Cc: gfs2@lists.linux.dev,  agruenba@redhat.com,  willy@infradead.org
Subject: Re: [PATCH 0/2] GFS2: Fix wrong call of new trans for jdata
In-Reply-To: <20250606094756.95958-1-glass.su@suse.com> (Su Yue's message of
	"Fri, 6 Jun 2025 17:47:54 +0800")
References: <20250606094756.95958-1-glass.su@suse.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Mon, 09 Jun 2025 08:20:51 +0800
Message-ID: <zfehydcs.fsf@damenly.org>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Authenticated-Id: l@damenly.org

On Fri 06 Jun 2025 at 17:47, Su Yue <glass.su@suse.com> wrote:

> Patch 1 is trivial.
> Please see commit message of patch 2/2.
>
Please ignore the patchset. The issue was fixed by
commit 5a90f8d49922 ("gfs2: Don't start unnecessary transactions 
during log flush").

--
Su
> Su Yue (2):
>   gfs2: rename gfs2_write_jdata_folio to 
>   gfs2_write_jdata_full_folio
>   gfs2: do not call gfs2_jdata_writepages for jdata
>
>  fs/gfs2/aops.c | 46 
>  +++++++++++++++++++++++++++++++++++++++++++---
>  fs/gfs2/aops.h |  1 +
>  fs/gfs2/log.c  |  6 +++++-
>  3 files changed, 49 insertions(+), 4 deletions(-)

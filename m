Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059BE248171
	for <gfs2@lists.linux.dev>; Wed, 15 Jan 2025 09:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736934583; cv=none; b=EHa4sjLNtTek1YFF6aWKEAJoW3bn/bFsnoGjQM/LOC33jyRUleU5JLXLNBwGcr0JBIdY2WUzJPEGJPX6uKmrX83iD+3akNu/RnmUguMf9wwjAOVgn0qjAXCQsNgeqozWWKVfQxH1+0jdOWoPa8Of+jvf7WXF7267/STXk94uhiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736934583; c=relaxed/simple;
	bh=aP/jyLm67IBTt8+C+kox9ul5wBpAnUnLPZmm0zKs5o4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pH4VQUroGo7ltAeoc7Dq+FuJl386i5VDUzL6awB6KKKCm0lA1kg70efxo86WvW3BwB71/V8SQMRwWQsqX8dWsd6HLb6t+Wzx1bQiOcNvtq3qfkbWDSRYtkLnqDuRqGiJ5QL6ueTkjboMVaytqgkRvwaa2TvqtSmUQ1s6lp82VMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KfmC+hAH; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KfmC+hAH"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736934572; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=aP/jyLm67IBTt8+C+kox9ul5wBpAnUnLPZmm0zKs5o4=;
	b=KfmC+hAHCt+cTGzkrloNrR8JCsR4Ir5KCZfZgBcBf9kSbTpxXgzdPNpMbN0kU0LuU0YO4Y8r47WVwq6hGuGDGDImUSHzhCLsoo756ADl3Ngcu4HoIw5I46gW0vpoUomxFgxRA++j+bW+FQ1iSTRy7gyuD77mWlOL5VO/RKC2sj4=
Received: from 30.221.130.98(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNi52po_1736934569 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Jan 2025 17:49:30 +0800
Message-ID: <cfdaa8ac-07f6-4474-94fd-a22426a7047c@linux.alibaba.com>
Date: Wed, 15 Jan 2025 17:49:28 +0800
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] erofs: use lockref_init for pcl->lockref
To: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Gao Xiang <xiang@kernel.org>, Chao Yu
 <chao@kernel.org>, Andreas Gruenbacher <agruenba@redhat.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, gfs2@lists.linux.dev
References: <20250115094702.504610-1-hch@lst.de>
 <20250115094702.504610-8-hch@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250115094702.504610-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/1/15 17:46, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

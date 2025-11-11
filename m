Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0762848B4
	for <gfs2@lists.linux.dev>; Tue, 11 Nov 2025 05:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762839701; cv=none; b=SsDSNMNWGMx+9nPUbPCFAzpab9Y4cjpnDxcjMKFqN3Et+jtvXA44nFrpEKFEDytRTyLMBx8JaGuRrh0CRlV6oYB967RcBGPgHRrQLHY8x+l+kzfncEDiKd3yTzN/I3bOelqKOJTIEqd37oQRDYWmjK7MS1YotO4u1sSZNzT/jEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762839701; c=relaxed/simple;
	bh=OtHB60otof8Ib6WXAVLkc2DNl5es41ACdONUKvBmt5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=oowkM9hdS1ZVrqawtTsXVL1KEIa0JAsHMrqfCnm6f1krsIc2rJzAS3u6OX7hkMDyB934VwT140cYDp1ed3NwfSKbqWxwXtF44cgMvsyI7Iw13RcftUR3XsZ0yRJQKtjTKJT7AWg8duKMZDFa1K0+z+8Zx8I90kSelo8cMgvtn7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=dzkz4SMG; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dzkz4SMG"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20251111054136epoutp03d84c33cfc03ac4384c22af6ef94ed15c~23V0x3ISE1573915739epoutp03R
	for <gfs2@lists.linux.dev>; Tue, 11 Nov 2025 05:41:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20251111054136epoutp03d84c33cfc03ac4384c22af6ef94ed15c~23V0x3ISE1573915739epoutp03R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1762839696;
	bh=ef0RDZCWoK3lvtiD9fAfX9+MmhcguTfmbAAtnNupmPs=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=dzkz4SMGWoa+X2wPgIyjI16jRtOo/FcrxblhLH/gDESsRNTwlNoEdxA6USFbcFcuv
	 O7w2sr+2TQuqXN9wpmZU2LIIGrFGxiAFBmtio9TgGknllbajhUARdXSkOozHkgSx8f
	 ml85fpLcWwsJujGvI6FWUL/Z9iw7tdZuksYYUMGM=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20251111054135epcas5p1d15ca46bbaf565fb7c66295f670d762c~23V0NCthE3166631666epcas5p1V;
	Tue, 11 Nov 2025 05:41:35 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.90]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4d5FlL51stz3hhTJ; Tue, 11 Nov
	2025 05:41:34 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20251111054133epcas5p20b40bd8e7a3f97b9291d974346022f8b~23VybX4aU0629806298epcas5p24;
	Tue, 11 Nov 2025 05:41:33 +0000 (GMT)
Received: from [107.111.86.57] (unknown [107.111.86.57]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251111054129epsmtip241c0542d0446455b092d644d9c07434f~23VukFjr81175011750epsmtip2P;
	Tue, 11 Nov 2025 05:41:29 +0000 (GMT)
Message-ID: <38aa0903-24e6-4c9c-987c-86f6e7634f87@samsung.com>
Date: Tue, 11 Nov 2025 11:11:28 +0530
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] Parallelizing filesystem writeback
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner
	<david@fromorbit.com>, jaegeuk@kernel.org, chao@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	miklos@szeredi.hu, agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org,
	akpm@linux-foundation.org, willy@infradead.org, mcgrof@kernel.org,
	clm@meta.com, amir73il@gmail.com, axboe@kernel.dk, ritesh.list@gmail.com,
	dave@stgolabs.net, wangyufei@vivo.com,
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, anuj20.g@samsung.com, vishak.g@samsung.com,
	joshi.k@samsung.com
From: Kundan Kumar <kundan.kumar@samsung.com>
In-Reply-To: <20251107133742.GA5596@lst.de>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251111054133epcas5p20b40bd8e7a3f97b9291d974346022f8b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251014120958epcas5p267c3c9f9dbe6ffc53c25755327de89f9
References: <CGME20251014120958epcas5p267c3c9f9dbe6ffc53c25755327de89f9@epcas5p2.samsung.com>
	<20251014120845.2361-1-kundan.kumar@samsung.com>
	<aPa7xozr7YbZX0W4@dread.disaster.area> <20251022043930.GC2371@lst.de>
	<e51e4fb9-01f7-4273-a363-fc1c2c61954b@samsung.com>
	<20251029060932.GS4015566@frogsfrogsfrogs> <20251029085526.GA32407@lst.de>
	<91367b76-e48b-46b4-b10b-43dfdd8472fa@samsung.com>
	<20251107133742.GA5596@lst.de>

On 11/7/2025 7:07 PM, Christoph Hellwig wrote:
> On Fri, Nov 07, 2025 at 02:54:42PM +0530, Kundan Kumar wrote:
>> Predicting the Allocation Group (AG) for aged filesystems and passing
>> this information to per-AG writeback threads appears to be a complex
>> task.
> 
> Yes.  But in the end aged file systems are what will see most usage.
> Fresh file systems look nice in benchmarks, but they aren't what
> users will mostly deal with.
> 
>> To segregate these I/O requests by AG, it is necessary to associate
>> AG-specific information with the pages/folios in the page cache. Two
>> possible approaches are:
>> (1) storing AG information in the folio->private field, or
>> (2) introducing new markers in the xarray to track AG-specific data.
>>
>> The AG-affined writeback thread processes specific pages from the page
>> cache marked for its AG. Is this a viable approach, or are there
>> alternative solutions that could be more effective?
> 
> Or maybe the per-AG scheme isn't that great after all and we just
> need some other simple sharding scheme?  Of course lock contention
> will be nicer on a per-AG basis, but as you found out actually
> mapping high-level writeback to AGs is pretty hard.
> 
> 
Thank you for your insightful comments, Christoph. I'm considering using
folio private to incorporate IOMAP type and predicted AG information.
The prediction for DELALLOC, using pagf_freeblks etc., and for UNWRITTEN
and MAPPED, using the actual location of allocated blocks.

Subsequently, schedule all writeback threads for the inode. With all the
necessary information, these threads will be able to filter AG-specific
folios and focus on those marked for the corresponding AG. Although this
approach may seem complex, it should effectively address various use
cases, including aged filesystems, filesystem fragmentation, and locking
concerns.

We tried CPU and inode based sharding, CPU based sharding increases
filesystem fragmentation, and inode based sharding results in AG lock
contention. We adopted AG-based sharding to resolve these issues.


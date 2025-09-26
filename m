Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD682773E6
	for <gfs2@lists.linux.dev>; Fri, 26 Sep 2025 05:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758865103; cv=none; b=UWG5T3DSYHqj6K52YodJeacFG23wf4bpBkEc2iskyPZ1EblMZKP+0aMYk/smCB5V47HklQpkChbnQoMBf80P0evs4Za12IQBEHbbOcqvbixhtxYlRek2bNPsQvSENGwq8isuC+hy79nvqGBmcNCL1AyitwxFnsUZw00L7z61Y2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758865103; c=relaxed/simple;
	bh=KkD9rL7YGHlVwvQ0Osh0V5e+ZCSLwP1ZFtxpHOBoGdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PHtgPvB4chu5jyqpsVP7Wi0ETOzn7fkHwNvoCLef+O4PG4wAzDk1YCZxWrcjohwfHT17HZFRsleSLCujGsQ4M8DAyFsJ8bOKeSRPqgM5gkH++jM/ZN3y0Ege3tX7Hm5t60Dr54SHZnj1rHophSSlHjEI+tyFQOySoLmFYuwO0hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rPBMwcqE; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rPBMwcqE"
Message-ID: <ae2db4c3-3769-4945-97bc-2407a260886b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758865095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KkD9rL7YGHlVwvQ0Osh0V5e+ZCSLwP1ZFtxpHOBoGdE=;
	b=rPBMwcqE0ZoiuFdUzLDekJ6XZGa1QzTbhtw7WQI+f6DsBkq5Jxsbk2kF+pxjbMN6RcXAES
	xksuCplfb+zpTtmaG4g2rGQRuwPrgG0HO1jbNZG2kXqTQBA7VwIw0ZALQhwgbqvv0UkE1s
	qoh/Dp9VdcT9Y/SLmLftiUvDs4PoBTQ=
Date: Fri, 26 Sep 2025 13:37:34 +0800
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH] gfs2: Move i_nlink checks from gfs2_{link,rename,mkdir}
 to VFS layer
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev,
 linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
References: <20250926025604.500713-1-youling.tang@linux.dev>
 <20250926044854.GD39973@ZenIV>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <20250926044854.GD39973@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/26/25 12:48, Al Viro wrote:

> On Fri, Sep 26, 2025 at 10:56:04AM +0800, Youling Tang wrote:
>> From: Youling Tang <tangyouling@kylinos.cn>
>>
>> vfs_{link, rename, mkdir} will check i_nlink. When sb->s_max_links is set,
>> set sb->s_max_links in gfs2 to simplify the code.
> For gfs2 you are going to run into a problem - link count is not stable until
> you take gfs2 locks; checks in vfs_link() et.al. will be inevitably racy for
> cluster filesystems.

Thank you for pointing out this important issue. Let's discard this patch.

Thanks,
Youling.

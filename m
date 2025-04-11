Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D3C2110
	for <gfs2@lists.linux.dev>; Fri, 11 Apr 2025 05:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744349580; cv=none; b=l/O8FKXuOPTFVCo/wKfu3ereRKUJHW9oYI1Ls0gdY+F6MGgu1xbgL3uRKdqYBKhCLDHxbm9o90LbwpjZUBGOy4BtfKvO1xrj4xWtUrROD61YcBRrf/LaOuWQKRySEpmwT3pTVMio74dKOnwfE6pLPr0PozZpSi+A8LsDP5HFCbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744349580; c=relaxed/simple;
	bh=KhPrm8XyahyVbFlpHI6m2PqCRHGiHtQ54MWHiG3zMT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPICuOzCb0lGnzKhM98TIQy3EAcD/Nl9I5RAuJySaerN41KJZ0x213gyOSn2leTeaiyjkhXMnfDqf9C+QrKzn7wi6s11NAy4WqIwIvixJdsM3+9Z4o+VSHVel3pd7VQa7XEk1Q9Xr/M2N2WjmzzdaD807iN7tJ9QYCuBJg5KpR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a/LNWbBR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/LNWbBR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744349576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eV9HHQ33i381Mk3q6cMz9Mtvb8+NGnQQmK94vGUH1lk=;
	b=a/LNWbBR58sKVvMEbwi/P/jz4PFskBwd5LHnsMVr6J3oCUYOgJ5nLjp1WAFpmiaRYHIcVM
	h2tbyhOzidywBbKY4A42it4GeGYJsMaXN5IiXD9M3V1gXsfVjvQBta78ZyJ1llt3qt2iju
	9Lah0XhxkGztsxzq1tBOE4hpqOIljGU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-RCPu-0a1NIiKeWtWpjlvMw-1; Fri,
 11 Apr 2025 01:32:52 -0400
X-MC-Unique: RCPu-0a1NIiKeWtWpjlvMw-1
X-Mimecast-MFC-AGG-ID: RCPu-0a1NIiKeWtWpjlvMw_1744349571
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DEA53180034D;
	Fri, 11 Apr 2025 05:32:50 +0000 (UTC)
Received: from localhost (unknown [10.72.112.38])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F34FD180B493;
	Fri, 11 Apr 2025 05:32:48 +0000 (UTC)
Date: Fri, 11 Apr 2025 13:32:44 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>, agruenba@redhat.com,
	gfs2@lists.linux.dev
Cc: linux-mm@kvack.org, david@redhat.com, osalvador@suse.de,
	yanjun.zhu@linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] mm/gup: fix wrongly calculated returned value in
 fault_in_safe_writeable()
Message-ID: <Z/ipfCofBe99Ie+7@MiWiFi-R3L-srv>
References: <20250410035717.473207-1-bhe@redhat.com>
 <20250410035717.473207-2-bhe@redhat.com>
 <20250410204338.4b2101afdf18d8898390ef58@linux-foundation.org>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410204338.4b2101afdf18d8898390ef58@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 04/10/25 at 08:43pm, Andrew Morton wrote:
> On Thu, 10 Apr 2025 11:57:14 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> > Not like fault_in_readable() or fault_in_writeable(), in
> > fault_in_safe_writeable() local variable 'start' is increased page
> > by page to loop till the whole address range is handled. However,
> > it mistakenly calcalates the size of handled range with 'uaddr - start'.
> 
> What are the userspace-visible runtime effects of this change?

I see it mainly affect gfs2_file_direct_read(). Not sure if GFS2 people
can sense any exceptional behaviour caused by this code bug.

> 


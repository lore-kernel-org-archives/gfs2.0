Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5947B21883E
	for <gfs2@lists.linux.dev>; Mon,  9 Feb 2026 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770659143; cv=none; b=R4+CURWKeVv78n74q8UiZwmawYoSjWG037/XpIJI52rJITlZ7i5dATXBTP9nJGdbYB7mW8vqu6r4UXc18h6lqQcyiunlfpAJ+0hc2F1US58Y03a9iTydCm9iuxuXCxHwiYgns1bCRga2/FXds8YpgxfkCBzoYESrvaJezFfLnQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770659143; c=relaxed/simple;
	bh=JZB4qXfHAGEV4a9T/dAHEuWzRPC4lGmh6Z6UvwaYAew=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ahL134Blphjv91o1K5pBmm56xy0r2pprRgUmRsDL8Uy4BsCx/1XVVKQ5Sh9pexhJ247ilgt1nPJeJQ+baIxLKku2sH+BjfMzD17hYRK8b+pbZqgt4catr44NOrZ5tCyHx8CqbXMO82gepbK2n74t+lAYo57XfYEjiaTMFhIpNOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wpl1P+0e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wpl1P+0e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770659142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=UO1AmvJiS8+e592iZcNdoJ7SNNcIkwKCqD9DbP9xmrQ=;
	b=Wpl1P+0e+OqP/mK/k/k+wtALW8Zme7IRZA4eIhmbWWO/SRW+HhxO68f0/kldQa7L8qlI8o
	QRrVt3TEpYwks2TDW2iUvwTwj6NJ6vtWhG07UGBEL8C1eDNVh8q6TKcawdt5hhkiJf5ut0
	Tqv9EyhdhT5vi7OKBod7fe2YLtMKgZg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-HGC5PNs8Oq2lEtbvdqvCAw-1; Mon, 09 Feb 2026 12:45:41 -0500
X-MC-Unique: HGC5PNs8Oq2lEtbvdqvCAw-1
X-Mimecast-MFC-AGG-ID: HGC5PNs8Oq2lEtbvdqvCAw_1770659140
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8bb9f029f31so2003510785a.2
        for <gfs2@lists.linux.dev>; Mon, 09 Feb 2026 09:45:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770659140; x=1771263940;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UO1AmvJiS8+e592iZcNdoJ7SNNcIkwKCqD9DbP9xmrQ=;
        b=jLgY055M7N+wLJ+Sapl0GMCh488Y7bUVXprJ1P+JlQzIU0G706z95vN/qgqWqRv1hc
         Dnd11Cq/1PkxOAUYOc650gvymjNgNPys9iNwFePycc4losmpITx+3Apv+kwvHPY3t4wp
         dGUfH9lau8WgcU4oLSnxJOy2WpFgSjURnJ5qOWQJcKiRKcpvd6q9NHwiYz3q8TqXXnIS
         QsrZEsCwK7GZ7iuYva0eOK2eyQv7iG0qWXkSz3Hfd+WoI1EivbeAkSIskj6OtWRqXTg6
         3b7eCDMwwzrtLTAhoexZQisRK/S08DXfQYkNPfkvAf6/VFi6VaU5INe/IUFS87DgyUQD
         Hw0g==
X-Forwarded-Encrypted: i=1; AJvYcCU7kiNosb0KmQq8GtCvd2KysZV0Gvmhd7AEhhI8GpvqSGlSNI35p1uggbVwjRWFmUv0qtfF@lists.linux.dev
X-Gm-Message-State: AOJu0YzE+F5OlNKtbcTkyk8cRJwe6dc1QT9g8YqPEwmury0LZHpx8dZv
	9jne8+oRo78Q4tPy+/YAbnSWlSU4KUAwJ5HB/t2K8FuIVbvL5url5G01B9+h/3Gt4VwX6Zki46q
	RjR92NKn8MWhmf0BBFUBXn8czf4JUTPrDBXORxSTEulq/rPxdN42zbiSIGW1oIn8=
X-Gm-Gg: AZuq6aJWgqAWak2jeaWhiHMcnO4bJ2WRaHUJFKXx1/a2zpGFDmU8yVUVceI+BOFLV/g
	kjZ/EAP5ZTEC7HuRbwIfay3N02v40gsJFsG6+ZWL3gHETH7JlbPG+IPZI43JwTsGoD57X2dJNHW
	T9NNzjv1SdXkT79uXaU5E9/oZNLzCcWAcL/bygt/swpijgLMY1zwKpJPVEdpz12IHqnveUjF/Er
	awWn0LDAcB8/DJ6gYWvGvkyvC1SiRcMc/Kro8LlQWLc6fw4skeNi8L1WAPEMI6o83A2wgh1//Fo
	WhIGaRXPRRM5eHUcdaYturDyUQ3d2/8K6zA7eVpnR6jiku8azPThgyBpqt9vb2JH
X-Received: by 2002:a05:620a:1a85:b0:8ca:4444:26e8 with SMTP id af79cd13be357-8caf1307daemr1500126185a.63.1770659140469;
        Mon, 09 Feb 2026 09:45:40 -0800 (PST)
X-Received: by 2002:a05:620a:1a85:b0:8ca:4444:26e8 with SMTP id af79cd13be357-8caf1307daemr1500121085a.63.1770659139878;
        Mon, 09 Feb 2026 09:45:39 -0800 (PST)
Received: from localhost ([2600:1701:430:16b0::10])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf79f7dc3sm865396485a.13.2026.02.09.09.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 09:45:39 -0800 (PST)
Date: Mon, 9 Feb 2026 11:45:38 -0600
From: David Teigland <teigland@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Subject: [GIT PULL] dlm updates for 7.0
Message-ID: <aYodQumcGQCTCrBK@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LqG7bWJySFoSxl_zTWhigvGx7p7SxJ0keTQ7N6Rg0eg_1770659140
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull dlm updates from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-7.0

This set includes several minor code cleanups, and one notable fix
for recovery of in-progress lock conversions which would lead to a
the convert operation never completing.

Thanks,
Dave

Alex Shi (1):
      fs/dlm/dir: remove unuse variable count_match

Alexander Aring (1):
      dlm: fix recovery pending middle conversion

Christophe JAILLET (1):
      dlm: Constify struct configfs_item_operations and configfs_group_operations

Ezrak1e (1):
      dlm: validate length in dlm_search_rsb_tree

Gustavo A. R. Silva (1):
      dlm: Avoid -Wflex-array-member-not-at-end warning

Shaurya Rane (1):
      fs/dlm: use list_add_tail() instead of open-coding list insertion

 fs/dlm/config.c       | 16 ++++++++--------
 fs/dlm/dir.c          |  6 +++---
 fs/dlm/dlm_internal.h |  4 +++-
 fs/dlm/lock.c         | 22 +++-------------------
 fs/dlm/member.c       |  6 +-----
 5 files changed, 18 insertions(+), 36 deletions(-)


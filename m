Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7881BEF85
	for <gfs2@lists.linux.dev>; Thu, 30 Jan 2025 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738245398; cv=none; b=cpUHuVkYdIjniep7Sk5qKKgurazp/tpNATj4U7O5V3Z5FGYY8Lbldic/r7qhYRNwZA8ChqH6Q7fhgvcdjbbnHyPOjezlS8iHHboe3Etu+COe865JBQAYazcCTiJGkHJIZk8ZT4IzHmsCYj65oClqReb9cCZul8UZpB1vh0hVe1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738245398; c=relaxed/simple;
	bh=bPoIq//z21qw6s1/O0ZRMVTIepzisSDoitAj8KYqC6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fqt8+leIu1nYqY2u8qmTmGI1bumVJiy1AmeSVRoweLhfXBDHAr1sFF06fvld0T9Nsyd9BYYgwBm0Cap/lzOtUFISZ7Mwct6IxyOJh6nYjnEo94a4GWgknZ5gd+BbxSJP+UsUavdBKZJaDWbqBAoONRQgUZvQrzXM4A6vsEK0IkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BzeUM9pu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BzeUM9pu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738245395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9g1rRnReI13fX6Jcb3HqPbz4o52VybxcfSlzB9roo5M=;
	b=BzeUM9puMg7bl+ik1/4Lmb3BChNEVEkRyBCPKtCn9/vYecMXyWqQ4LTqgELIRCYrdr+Eo5
	cpk2eEi3hfJnlKAuUULhuGg+2cUir1vLP5ludsWIZSY4iNGOsHKz49g/tzPzncanxO3UBG
	51MqtI8alKrQruhvdzfcjMHmcZyX4Jc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-iSzbDDAZNHOl3fZQzt1bAQ-1; Thu,
 30 Jan 2025 08:56:32 -0500
X-MC-Unique: iSzbDDAZNHOl3fZQzt1bAQ-1
X-Mimecast-MFC-AGG-ID: iSzbDDAZNHOl3fZQzt1bAQ
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1238818009D9;
	Thu, 30 Jan 2025 13:56:28 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.234])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9C2D21800268;
	Thu, 30 Jan 2025 13:56:25 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] further lockref cleanups
Date: Thu, 30 Jan 2025 14:56:20 +0100
Message-ID: <20250130135624.1899988-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Here's an updated version with:

* An additional comment saying that lockref_init() initializes
  count to 1.

* Reviewed-by tags from Christoph.

Thanks,
Andreas

Andreas Gruenbacher (3):
  gfs2: use lockref_init for gl_lockref
  gfs2: switch to lockref_init(..., 1)
  lockref: remove count argument of lockref_init

 fs/dcache.c             | 2 +-
 fs/erofs/zdata.c        | 2 +-
 fs/gfs2/glock.c         | 2 +-
 fs/gfs2/main.c          | 1 -
 fs/gfs2/quota.c         | 4 ++--
 include/linux/lockref.h | 7 ++++---
 6 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.48.1


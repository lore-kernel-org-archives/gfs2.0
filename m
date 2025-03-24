Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A93025FA3A
	for <gfs2@lists.linux.dev>; Mon, 24 Mar 2025 17:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835832; cv=none; b=KlBQhRzqC5GJBVneTY817ACWwL1KIXiH1HbzcEm2Gdcfc2UAIUshWpScbRZDE3NTh1zL0fnWzObchanwW4g0XarlSOwa2g6gblvpSh13Di+sp5d1ri++7WPk8mpT+DrsUgUmEyb17sDqfQrl1K6ktd8j7WKyh1ffi5WG8M5Dks8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835832; c=relaxed/simple;
	bh=Fhymql5LrqYvf7WCwoI6ll3vFidOMHuqPT4bj9qwPS4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DnUBpFaqNLg3Co3c1SssKaEeT0wB7mBnLuwJWAx1nDH+I2RR/7FXzhSHORHzltfNs6RKKglAfUu5HwhVIhc230sUsX0uBHvwjOPnaX69k19/bsTlkqTGWR1KDheyXkASXV4iUo30H94SBkOMgp/zHqq7u4SeWkhadEEwh/TO0Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XNelncI4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNelncI4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742835830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=WJBEzIEgkwg9EgWyF2dr13gaP+P0+1At/o/fBqLpVSg=;
	b=XNelncI4uXgJoMwDFezNDyDJ+wgd8AZTMEa+yIhnIwxxgoxM/qZdBJ2Lk6EZ27pPy2fhZO
	gOh8XTGlsauy/yTW3/u2id4YVFtsfegzN8ByC5HrckiT2XWTmRToEMKn7WZt8SDwiYjv7q
	ycA9DhUnAwmpuF2rB4qzLk7H7SNgNbY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-BNKKAnTsMQCZ9nQMlKRSCw-1; Mon,
 24 Mar 2025 13:03:48 -0400
X-MC-Unique: BNKKAnTsMQCZ9nQMlKRSCw-1
X-Mimecast-MFC-AGG-ID: BNKKAnTsMQCZ9nQMlKRSCw_1742835827
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9AEE71809CA6;
	Mon, 24 Mar 2025 17:03:46 +0000 (UTC)
Received: from redhat.com (unknown [10.22.66.35])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD5EE1801750;
	Mon, 24 Mar 2025 17:03:45 +0000 (UTC)
Date: Mon, 24 Mar 2025 12:03:43 -0500
From: David Teigland <teigland@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Subject: [GIT PULL] dlm updates for 6.15
Message-ID: <Z-GQbyqwct3BVdiH@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Linus,

Please pull dlm updates from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.15

This set includes:
- two fixes to the recent rcu lookup optimizations
- a change allowing TCP to be configured with the first of
  multiple IP address

Thanks,
Dave


Alexander Aring (2):
      dlm: fix error if inactive rsb is not hashed
      dlm: fix error if active rsb is not hashed

Heming Zhao (2):
      dlm: increase max number of links for corosync3/knet
      dlm: make tcp still work in multi-link env

Thadeu Lima de Souza Cascardo (1):
      dlm: prevent NPD when writing a positive value to event_done


 fs/dlm/config.h    | 2 +-
 fs/dlm/lock.c      | 2 ++
 fs/dlm/lockspace.c | 2 +-
 fs/dlm/lowcomms.c  | 4 ++--
 4 files changed, 6 insertions(+), 4 deletions(-)


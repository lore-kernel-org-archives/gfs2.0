Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB8838F99
	for <gfs2@lists.linux.dev>; Mon, 18 Sep 2023 14:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695047685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LEt+aOCH+NJxKysD6ybSjGWUVqM+LPVA1IYSdCJ4bi4=;
	b=UCeIOED/lsdTmGVWQ4th4MPmvxdeMpboYR0xi7ssS8vFqDGqxYBnXc+RwnWcskn1MdrCxg
	zyh2R36+4xKkbIvmKdchqTlU+Y/X1xFgAK7licPEwigQEua7FfxgmaS1d5VPc5Gbvp9X9F
	ptyflpAIgKx5/noAPnK7aBogDdMhPvc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-auOuSAFcP3e2-wILCT6xgw-1; Mon, 18 Sep 2023 10:34:40 -0400
X-MC-Unique: auOuSAFcP3e2-wILCT6xgw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4295858296;
	Mon, 18 Sep 2023 14:34:39 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.226.29])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DD88340C2064;
	Mon, 18 Sep 2023 14:34:38 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 fixes
Date: Mon, 18 Sep 2023 16:34:38 +0200
Message-Id: <20230918143438.2739942-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1

Hello Linus,

pleae consider pulling the following gfs2 fixes.

Thank you,
Andreas

The following changes since commit 65d6e954e37872fd9afb5ef3fc0481bb3c2f20f4:

  Merge tag 'gfs2-v6.5-rc5-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2 (2023-09-05 13:00:28 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.6-rc1-fixes

for you to fetch changes up to fb95d536080e6c1db099f0023f59cd55adcc5d87:

  gfs2: Fix quota=quiet oversight (2023-09-18 16:26:24 +0200)

----------------------------------------------------------------
gfs2 fixes

- Fix another freeze/thaw hang

- Fix glock cache shrinking

- Fix the quota=quiet mount option.

----------------------------------------------------------------
Andreas Gruenbacher (1):
      gfs2: Fix another freeze/thaw hang

Bob Peterson (2):
      gfs2: fix glock shrinker ref issues
      gfs2: Fix quota=quiet oversight

 fs/gfs2/glock.c | 4 +++-
 fs/gfs2/glops.c | 9 +++++----
 fs/gfs2/quota.h | 3 ++-
 3 files changed, 10 insertions(+), 6 deletions(-)


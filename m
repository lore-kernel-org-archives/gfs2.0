Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792441016;
	b=DJZR31PTkvK/KvGSoZLTd/c6b8fQSxMJO6zeoGyWQKS9glbC5PxaJ3euSeHqbzYo5oCr
	 pJChUoaBlNoraYHH9Qh2nX7Z1aWOEQF1pPqWsgIiXAg5fWCAbmLRdJbWpZRdvWYHcomMC
	 k6jXojUBrPzdpVYvRx2N6FymATCeMaT4hXqL2drs19IagwMu7GOZgggeJRTas88diG2SN
	 X2SxV1eVloQvK9/gtsujdnE7JWqG3iIdWKHgaieQfyJjBOqHch/uux1Ueu4T1efZ4LMnP
	 2b+Mc8/Fr1UQ5jlDnX3Z7w2KjWdbXdSm2WRwNJRHPjQeeXvLTDKSNb+gND7m0nOfNkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792441016;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Disposition;
	bh=T8NDS9TBcsxfGLpdye5MNhtdRD4fWL/RdION8FfvRn8=;
	b=aw3eXFHZCldIELVVjdmbFAu64X8GO77s4lv23wKz7DbLqdZNhMnt4shPbWG8ZfLooyk9
	 tDBHIE3Sk21JdcjqrzZfObzU1k6rJG/tmsXU+JDNx3GjUvhZhIRpGr6nl9UDX7XPMdtO6
	 1/WwblJ51LHbPVJxH6L7l8vLo7U9954EGm2P1lBvVRSrSckOvfMkCOBFHlSM2JhO7CAB+
	 Sog0tpIOrw+j+PwONlb/ZNAqMVke3sGDw2yEOq5xggBCPZ/G8DuQlI8MFgZ8YEMnfHltg
	 OU1OrCSf4QGk4hQwNwCeoe4YGTQOp3/0VIRFtfiL02AjHiheA97Qg8Av2sA5F1zM8rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fx6fEuc0;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8A4606A31F
	for <gfs2@lists.linux.dev>; Mon, 19 Oct 2026 20:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F8A4606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fx6fEuc0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792441015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=T8NDS9TBcsxfGLpdye5MNhtdRD4fWL/RdION8FfvRn8=;
	b=Fx6fEuc0w7eETLAdwPkjPTV7ynfe+7iZKEWOpMD7ealI78DfXJ6FO6NOvqIxOcMm2C3TUO
	uBP5rqRE7dXNpzcSfvzAfUxDNw9YCHZlkaNlRvuusBTNafCmEB9FWYyUjL7LVKirVYXBEY
	6xgcc6EjblyjUIqDBFqrIMjLIy4zDm0=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-t8nLKElsNa2ZRPrO6DGNeA-1; Mon, 19 Oct 2026 20:16:51 +0000
X-MC-Unique: t8nLKElsNa2ZRPrO6DGNeA-1
X-Mimecast-MFC-AGG-ID: t8nLKElsNa2ZRPrO6DGNeA_1792441011
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8acc7fe346cso28870667b3.3
        for <gfs2@lists.linux.dev>; Mon, 19 Oct 2026 13:16:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792441011; x=1793045811;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T8NDS9TBcsxfGLpdye5MNhtdRD4fWL/RdION8FfvRn8=;
        b=Oe+H7XQ5HZqNSwN8NTeHTToWFxt87Lvro9SWHLRS8/gyUcwK3s5eMbwMamZJ0NVoUQ
         wXozWsbwehTD6BVoHjV8gJM+YWqmqv2olMLtEgqGkxT1SZlC7S5eulw8Fcqp1bAg1M1g
         f5qvtXCqzi3ewF/fxCO0Kb8z7ubuS367fWVqguGbW6fWO5ZTW9a7yxtExFJe+v1mIqIf
         DUEk7Et0gYHb45IgATZPA+yT9Zgp1QsQENZjtTCWsb8vGCfx2qE2Aj9Qh6RdERKIrPG8
         em3ZY7gzB1IwzaSQKNO1AfvIa0SjFYeAcktMy1aPnei7U8hIiaytcdpMWeA1PMDWjJOd
         ivFg==
X-Forwarded-Encrypted: i=1; AKwUvBzrU41oYsazl54Zd1oAIzRGDLuJJZYuKApkpqte5dipmEfR+zLKThr9mKCn1I1HvlgVmW1e@lists.linux.dev
X-Gm-Message-State: AFq9FYJXpVsd68GQD6n2eYPycxwIC+1JPEaSpQRC1qwc53U8HXYuWu7c
	vaEgAHlrnj/r2nLKw2Aue87kqjBMVQ1/h33SlmTWSusvVcp/xAMyBmtRR4D/RepLdXNzRwrwfzw
	vpjH5SBdsVB0swgUdit7GcePuvdT0xp0RYyf47G9SXmOqnwZ3L1cnwcw=
X-Gm-Gg: AYBFou1k+a8Gl5YBqGB/T2P+ts+D9jC86Nytx3eqUKQjt8YsPM1xPGeTrRUOWLMKAa/
	YrCbzAI9MOjlJn9VktUpDTna/br9PaGk1zOaTfg94K+Mmo7MwxLON4Dw0H7WppyfOQWft4gNDfe
	o61ZS9WAJp4T6zme0QBMu7RGvUdI60aLH6nAiiQCgb3DVidqotK6Gekhiw+7L6y17d15WYVifS+
	YYm8d2n5DsSdbD5qBiYXG+tqyDashQUNCW8cS0j1FsfjnY07c1f9A4SSlkG9eaid9zHL2n9wM5F
	LaqxmnSqIPX07Lp/2bwXv+hdT8LJaEH2fOA2RKS4C2s/ozE8MxiAUjMNv5d86XKZtBQ+eJxsg2O
	zNYlhuP4dbzS+vZtB66gdkg==
X-Received: by 2002:a05:690c:6509:b0:8ab:a473:fde8 with SMTP id 00721157ae682-8b0f21c879amr30941847b3.54.1792441010760;
        Mon, 19 Oct 2026 13:16:50 -0700 (PDT)
X-Received: by 2002:a05:690c:6509:b0:8ab:a473:fde8 with SMTP id 00721157ae682-8b0f21c879amr30941787b3.54.1792441010100;
        Mon, 19 Oct 2026 13:16:50 -0700 (PDT)
Received: from localhost ([2600:1701:430:16b0:65aa:a2f5:8fab:cae6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b11b3f49d5sm4874647b3.0.2026.10.19.13.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:16:49 -0700 (PDT)
Date: Mon, 19 Oct 2026 15:16:48 -0500
From: David Teigland <teigland@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Subject: [GIT PULL] dlm updates for 7.4
Message-ID: <atZ6sKjlr3SxThCU@redhat.com>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OQbQIr5BcroQ1Gc53yH5C-YBEn1GrCH61XT9Ftrj0Q4_1792441011
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull dlm updates from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-7.4

This set contains several fixes for bugs found by static analysis,
fuzzing and code review. They mostly involve invalid input, e.g. from
userspace, configfs or remote nodes, and are unlikely to be seen in
normal usage.

Thanks,
Dave


Alexander Aring (1):
      dlm: fix variable key length lookup

Dan Carpenter (1):
      dlm: clean up a type in waiters_read()

Danila Chernetsov (2):
      dlm: validate lock modes in recovery messages
      dlm: fix NULL pointer dereference in dlm_dump_rsb_name()

Haofeng Li (2):
      dlm: gate dlm_plock device on CAP_SYS_ADMIN
      dlm: require CAP_SYS_ADMIN for dlm-monitor device

Hemanth Selam (1):
      dlm: fix typos in comments

Joseph Qi (1):
      dlm: fix buffer overflow from negative len in dlm_search_rsb_tree

Qing Ming (1):
      dlm: validate node weights before building member array

Samuel Moelius (1):
      dlm: validate userspace lock resource name length

Zqiang (1):
      dlm: wait for outstanding SRCU callbacks to complete in exit paths


 fs/dlm/ast.c          |  2 +-
 fs/dlm/config.c       | 39 ++++++++++++++++++++++++++++++++++++---
 fs/dlm/debug_fs.c     |  3 ++-
 fs/dlm/dlm_internal.h |  5 +++++
 fs/dlm/lock.c         | 20 ++++++++++++++------
 fs/dlm/lock.h         |  4 ++--
 fs/dlm/lowcomms.c     |  1 +
 fs/dlm/member.c       | 17 +++++++++++------
 fs/dlm/midcomms.c     |  1 +
 fs/dlm/plock.c        | 14 +++++++++++++-
 fs/dlm/user.c         | 23 +++++++++++++++++++++++
 11 files changed, 109 insertions(+), 20 deletions(-)


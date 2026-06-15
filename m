Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8ED3AE712
	for <gfs2@lists.linux.dev>; Mon, 15 Jun 2026 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781541827; cv=none; b=kdUvWz7DwCm55el1oApcsFhm3Pjmu/9itmsUw63XKh8rMo3SL64lELC8MYIe1cxX4Myaf/I3TD6CFnsNyYMgMJhtqc4fEQcD9L/ONlEdcSkLwdiV1Ru5bE133P3cxD6wvUaTZ/Z/itmW+HT7inKydZSl6PxzIVaYgiVhtrwttQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781541827; c=relaxed/simple;
	bh=8c8kE+ZPCk0Jd78d4afQmqz8QMU25AmlF0S288P22eo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nvk9D/z3Eox96i6pJFqrIhvIz1E3NQU9ACur7te0n50Ifgd1jgk11Xzls+l0ZXhugo6ft7ijYuotYdoOP2Exax+iccsXooxSJYu/Wv6g6tVA8me4Yd2jSLrNwR6+BRtAM0CVocyTq4yiFdICVlMaaSVLNrAN99av5fCyNpnqLY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LnoQnBqq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LnoQnBqq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781541825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=PVQ3mIoUhNcM3wT2FhEmDgBtviQgMiFXD7ZO1ju+/S8=;
	b=LnoQnBqqaciZi86Se7/SKUkaXNNoUlOAzt3Qse8Ce0reSUj5ILfW9VOhvwZzvgsdMz7BMd
	m6s7X/vZmbapLMZ1g6CmSbeZYKhVBpRib8xjumlTE/S123AuTy5nrlQv0lvh0TiSgpvQjv
	gNZ+70J7cWN7mLFDt+/WwpPizNO9PCU=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-ePWThScRPOqRDnfL1zd88g-1; Mon, 15 Jun 2026 12:43:43 -0400
X-MC-Unique: ePWThScRPOqRDnfL1zd88g-1
X-Mimecast-MFC-AGG-ID: ePWThScRPOqRDnfL1zd88g_1781541823
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7dcd01ca614so56478067b3.0
        for <gfs2@lists.linux.dev>; Mon, 15 Jun 2026 09:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781541823; x=1782146623;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PVQ3mIoUhNcM3wT2FhEmDgBtviQgMiFXD7ZO1ju+/S8=;
        b=K9noiK9yWhFhxe/pdOb5YWW3x1z+4CkZOR51uau0VpJ5IOcMK1BPqLETsAT2NggeTL
         5iPPtLpb7KuLrqO46MzIRKKIrmsPWQ0DlllzwdtR7S/vJ9ioJEyWsPM8YiYaE+a/ujBc
         aAqxfMoW86erUv8TW66XAJgBprwscJvp6hGmGzixkRZ3GoXE1ZuxlboSajVaSaJF59pA
         IQa0kR04k2eUZv4pB/NfeNxp0P6N6m2vd/VH5A3mHX1TelZlj9dBMa7khNgXvWTP59EI
         R7rOWB5Xf6CdD4aj3z5Yve3dZhe+lKOgxroCIDwPlg/fsnugSNQhhGhniRpvF5cXNh0F
         JTig==
X-Gm-Message-State: AOJu0YxXFhW/oB928Hp3EuFDd3eOgE887y4E4hs/TSEVaOiOiiAIhweJ
	q+iCPf7alXL1cum3rv6TlN92PsIAO2fqFWa8O9GBLrkxHTDcEGv4/OdchpDQRHJRTbdj8y3umgm
	Db7F9sq5sVZl2qFkgWTYi4pTh/DBW3a8bNjaELcwSGXs8ihKFpwR9Jok=
X-Gm-Gg: Acq92OEhE1iAakXKHm7vLoRY14hHMwUH/lZbIKOXq7WfBUN1i3lkVoD337PUeM1k4C0
	I2ZRXRUAQgjlGe5/NbdFIwSa+Bo98eSz5GQ1wzBPPkiYzloLRPW/ITYRT7/eHt9EDQhBbXiaLw4
	bXy2YYq4O91jjz34/ZJ/XE2i6t62B0Jwe/gFVt2PqtRJNYJCRzO35L1UZN4627O0Eyn7Q4/F8VT
	priCNYNMHylzd99w32mjND4k7yytjcrFl7DZUoVNgacAuqcl6OVDbF0XJv8pvKYoZbUnauZiR5d
	pTkZrJ4f/ucsCCZF/0QW/ud3v5PWekhJfBFsyI2TMuF70Cg9lImsz5XonSesBiMYwpFV9AZH9Ri
	f
X-Received: by 2002:a05:690c:67c6:b0:7dd:3ed9:10dd with SMTP id 00721157ae682-7f7b822c399mr144961207b3.27.1781541822636;
        Mon, 15 Jun 2026 09:43:42 -0700 (PDT)
X-Received: by 2002:a05:690c:67c6:b0:7dd:3ed9:10dd with SMTP id 00721157ae682-7f7b822c399mr144960607b3.27.1781541821935;
        Mon, 15 Jun 2026 09:43:41 -0700 (PDT)
Received: from localhost ([2600:1701:430:16b0::25])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7fcd346d7e4sm1875587b3.41.2026.06.15.09.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 09:43:41 -0700 (PDT)
Date: Mon, 15 Jun 2026 11:43:41 -0500
From: David Teigland <teigland@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: gfs2@lists.linux.dev
Subject: [GIT PULL] dlm updates for 7.2
Message-ID: <ajArvSdW8Js7l72b@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5aGBTnWnYXBqPaccVTIk7EzN8JAHQ3lfODpacJYyB-A_1781541823
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull dlm updates from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-7.2

There are four fixes/cleanups in this series; none are likely to be issues
in real usage:
- improve debugfs error exit path
- fix sequence number ordering in an artificial test case
- fix usercopy_abort for lvb data
- use hlist_for_each_entry_srcu for srcu lists

Thanks,
Dave


Alexander Aring (2):
      dlm: fix add msg handle in send_queue ordered
      dlm: init per node debugfs before add to node hash

Li RongQing (1):
      dlm: use hlist_for_each_entry_srcu for SRCU protected lists

Ziyi Guo (1):
      dlm: add usercopy whitelist to dlm_cb cache


 fs/dlm/lowcomms.c | 12 ++++++++----
 fs/dlm/memory.c   |  4 +++-
 fs/dlm/midcomms.c | 21 +++++++++++++--------
 3 files changed, 24 insertions(+), 13 deletions(-)


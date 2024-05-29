Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48872A55
	for <gfs2@lists.linux.dev>; Wed, 29 May 2024 17:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002239; cv=none; b=bMHKqvAnV9msn9FrDVaasoUNBqErJ4AdJrTl8Zwojgq+I/EmuGNq1i9IBAo65lzrWwi+ZQ/FhENCkVBwNjATPJ1C2gQyBKeYogZOkpSaO7MOlKI0CfptADDVAkuph7e27LjhyJ3FQQDpFuZunFNz92N+/sGDW1EVSmdP0aVeL9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002239; c=relaxed/simple;
	bh=XD+L08fbP+5oZLIHaguZttIMCilrlG/ay7TGSLmVjck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ph9bYvv0v5FAZHzYBW0lFA6mFRVhx92Iew4wWsKcC3cdyrlanWbm93643nTxbfA7Yc5PIORkYw22JYhCZyLL2jcGT61mGjwKv08xWHxduKqSMD18hLbfJLu3wNcFzi+ehgPBLRRekLbb3rKmX6YowhbZw+TrgrBInmRX4eygBJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wm/h4Bsc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wm/h4Bsc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717002236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4gnJKup0fpxyOmsnj688+tOn4+oIRz+qcrKaEYxc1pY=;
	b=Wm/h4Bscw1nM2kvDBUl/HajFMU9OcJU0iA/VjZM7SMTbjZazcWXl//BtyaGyxOO7T1oSCb
	FTUMtbqnrWH09udAPzeFo/Y2ZTHKDL4+0Cd7k+bSv0vgsPdv2rfTM/XYyZUrsQXixUqU2P
	dBeSL0nVwhcL2IfZZ77Zb5dN2yGkW0s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-BVaD2TZEOt2IErxCVwp2eg-1; Wed,
 29 May 2024 13:03:54 -0400
X-MC-Unique: BVaD2TZEOt2IErxCVwp2eg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3552F3C025B5
	for <gfs2@lists.linux.dev>; Wed, 29 May 2024 17:03:54 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A8CCB492BC6;
	Wed, 29 May 2024 17:03:53 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 00/15] gfs2: Revise glock refcounting
Date: Wed, 29 May 2024 19:03:37 +0200
Message-ID: <20240529170352.571141-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Here is a patch queue for the next (6.11) merge window.  After a number
of cleanups, the glock reference counting model is modified so that the
number of references no longer depends on whether or not the glock is
locked.  This allows to eliminate the go_demote_ok() glock operation.

Thanks,
Andreas

Andreas Gruenbacher (15):
  gfs2: Remove unnecessary function prototype
  gfs2: Remove useless return statement in run_queue
  gfs2: Rename GLF_FREEING to GLF_UNLOCKED
  gfs2: Rename GLF_REPLY_PENDING to GLF_HAVE_REPLY
  gfs2: Rename GLF_FROZEN to GLF_HAVE_FROZEN_REPLY
  gfs2: Rename handle_callback to request_demote
  gfs2: Update glocks documentation
  gfs2: Remove outdated comment in glock_work_func
  gfs2: Invert the GLF_INITIAL flag
  gfs2: gfs2_glock_get cleanup
  gfs2: Report when glocks cannot be freed for a long time
  gfs2: Switch to a per-filesystem glock workqueue
  gfs2: Revise glock reference counting model
  Revert "GFS2: Don't add all glocks to the lru"
  gfs2: Get rid of demote_ok checks

 Documentation/filesystems/gfs2-glocks.rst |  55 +++---
 fs/gfs2/glock.c                           | 215 ++++++++++------------
 fs/gfs2/glock.h                           |   1 -
 fs/gfs2/glops.c                           |  42 ++---
 fs/gfs2/incore.h                          |  11 +-
 fs/gfs2/lock_dlm.c                        |  28 ++-
 fs/gfs2/ops_fstype.c                      |  12 +-
 fs/gfs2/super.c                           |   1 -
 fs/gfs2/trace_gfs2.h                      |   6 +-
 fs/gfs2/util.c                            |   6 +-
 10 files changed, 171 insertions(+), 206 deletions(-)

-- 
2.45.1


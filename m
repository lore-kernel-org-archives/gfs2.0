Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E4E57899
	for <gfs2@lists.linux.dev>; Fri, 19 Jan 2024 21:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705699264; cv=none; b=cUvG+tXS3OETqVd1MvMIm4aIcH9k6jK+F+x9Y9W/TxChObBwdnFZ1SjyDuU642999jV7gNLfd9cSfdVR40COWViiXzjm10uBWePKsVPOA5B+zqWUH7ScNGYba0WxBq8q/lKSvrlXs7uZBCaONImOA7/vlGwkMjKUPILBXlmCBKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705699264; c=relaxed/simple;
	bh=ZBAqbdhGIgpMIrdtwE53HndGraexhm6hkYgjyzTZOZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oc1BYal2jX4odomwBr5QOTgUfVuQ8BG+URprFVkhJsQvABMEZHJmj8IZVBuikOaKwbUDXD6pYYAD6TIm+CT+sTxuaYbHPGs/wlzxw0JWziTvePEeKDnVC3h0Gy56hHJFNsHhQ4SGLLi8n0MTTkwwha8qtmwsGaqHgOxCYG/hokU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DPappRi0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPappRi0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705699261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FKXtz5Br3ccJyNyeaejyrGGoYV5KDeTeIprGgd3KI0A=;
	b=DPappRi03YozWUugLpMzbxrkRMQhV/EUnGJgaBIWbAQQ0gu8XJ7pfTRPFo/O9Yf/WoQCgz
	3sb7kE7TuvvA34OdqWw0OosH8co/wKoRP8LxoG/pfeALtAite4OhQw9KihMxPT3ijfpkm2
	fWdnve573qfKMbrvCx4nXGDUjz/FlUg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-2WiLEU5fNESjBfZiJuil8Q-1; Fri,
 19 Jan 2024 16:20:57 -0500
X-MC-Unique: 2WiLEU5fNESjBfZiJuil8Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 836DC1C05154;
	Fri, 19 Jan 2024 21:20:57 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.226.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DCB5D40C1430;
	Fri, 19 Jan 2024 21:20:56 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 0/9] gfs2: Bugs in "Use GL_NOBLOCK flag for non-blocking lookups"
Date: Fri, 19 Jan 2024 22:20:47 +0100
Message-ID: <20240119212056.805617-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Hello,

Al Viro has reported issues with commit dd00aaeb3432 ("gfs2: Use
GL_NOBLOCK flag for non-blocking lookups"):

* First, parent can now be NULL and dereferencing it in
  gfs2_dir_check(d_inode(parent), &dentry->d_name, ip) isn't going to
  work;

* Second, gfs2_dir_check() can still sleep, which breaks LOOKUP_RCU
  mode.

These patches should fix both of these problems.  We'll either need
these fixes added, or commit dd00aaeb3432 reverted for now.

Thanks,
Andreas

Andreas Gruenbacher (9):
  gfs2: Fix gfs2_drevalidate NULL pointer dereference
  gfs2: Pass FGP flags to gfs2_getbuf
  gfs2: Split gfs2_meta_read_async off from gfs2_meta_read
  gfs2: Add FGP_NOWAIT support to gfs2_meta_read_async
  gfs2: Pass FGP flags to gfs2_meta_{,inode_}buffer
  gfs2: Pass FGP flags to gfs2_dirent_search
  gfs2: Pass FGP flags to gfs2_dir_check
  gfs2: Minor gfs2_drevalidate cleanup
  gfs2: Fix LOOKUP_RCU support in gfs2_drevalidate

 fs/gfs2/aops.c       |   4 +-
 fs/gfs2/bmap.c       |  21 ++++----
 fs/gfs2/dentry.c     |  32 ++++++++-----
 fs/gfs2/dir.c        |  52 +++++++++++---------
 fs/gfs2/dir.h        |   2 +-
 fs/gfs2/file.c       |   4 +-
 fs/gfs2/glops.c      |   2 +-
 fs/gfs2/incore.h     |   1 -
 fs/gfs2/inode.c      |  10 ++--
 fs/gfs2/meta_io.c    | 112 ++++++++++++++++++++++++++++---------------
 fs/gfs2/meta_io.h    |  15 +++---
 fs/gfs2/ops_fstype.c |   4 +-
 fs/gfs2/quota.c      |   2 +-
 fs/gfs2/recovery.c   |   2 +-
 fs/gfs2/rgrp.c       |   5 +-
 fs/gfs2/super.c      |   6 +--
 fs/gfs2/xattr.c      |  17 ++++---
 17 files changed, 173 insertions(+), 118 deletions(-)

-- 
2.43.0


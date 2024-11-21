Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31D616F0CA
	for <gfs2@lists.linux.dev>; Thu, 21 Nov 2024 16:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732205014; cv=none; b=oIEsJevjyjOjXz1Rt1DuZygeXoma3bAw4KDU9VjXPoBQwKWgbpNqUfJf6m56PdVIb61cEVdsGUfpqapRBP6JodmrUH2ED7RHU4sABsgOJftXxaBu7BPKjKWQClKq11ykhiPVdCbGvTkv1P74WUIbUQt+r1ZrcQavujcJ9KpyDnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732205014; c=relaxed/simple;
	bh=C8vJ8qggLtWzD+4pWCb0BepOavKWkMVHadcpxi6E8SI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=E/1kFatRyTR8mLQwPeNFKJ6LcO5eB8Fhb6fI8MiuaFcFl44TSRY+c41iv/67cLMUh3L5/Kdzd8T6bFES1UoxgB+PUf03yEoyqUhPmLMWhRCl7evILuqMiDoDETkOmGzusRhuHlMtERFWAJFltLC3Gprm+ifGbPUjgDDH6x9REoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SPUtoa53; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPUtoa53"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732205011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ikxJGaHMDVtELpb2AD5zG6Lr+OC44aX1EesfMQD2K0E=;
	b=SPUtoa53vAPKA6eSoupcekuiS9Ee07ek06YcDn8czsfxDLRnzaEfoxGoGoRCyczE5rKHOe
	S7kxfg3Iyt5sVw5tW9btJqt3THMGfzOEem28wpnKbVHaOZlZY2FJ8YWLBWOENQotkMU3Yi
	ZP7QQszNBHPsJQQk5RROQoJv14INslM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-CTo-EI5dNBW7-cdnyn7IfA-1; Thu,
 21 Nov 2024 11:03:27 -0500
X-MC-Unique: CTo-EI5dNBW7-cdnyn7IfA-1
X-Mimecast-MFC-AGG-ID: CTo-EI5dNBW7-cdnyn7IfA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FF8A195395F;
	Thu, 21 Nov 2024 16:03:26 +0000 (UTC)
Received: from redhat.com (unknown [10.22.82.7])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 960E51956056;
	Thu, 21 Nov 2024 16:03:25 +0000 (UTC)
Date: Thu, 21 Nov 2024 10:03:22 -0600
From: David Teigland <teigland@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Subject: [GIT PULL] dlm updates for 6.13
Message-ID: <Zz9Zyoho_wbCImkJ@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Linus,

Please pull dlm updates from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.13

Summary:

- Fix recovery of locks that are being converted between PR/CW modes.
- Fix cleanup of rsb list if recovery is interrupted during recover_members.
- Fix null dereference in debug code if dlm api is called improperly.
- Fix wrong args passed to trace function.
- Move error checks out of add_to_waiters so the function can't fail.
- Clean up some code for configfs.

Thanks,
Dave


Alexander Aring (9):
      dlm: fix swapped args sb_flags vs sb_status
      dlm: fix possible lkb_resource null dereference
      dlm: disallow different configs nodeid storages
      dlm: handle port as __be16 network byte order
      dlm: use dlm_config as only cluster configuration
      dlm: dlm_config_info config fields to unsigned int
      dlm: make add_to_waiters() that it can't fail
      dlm: fix recovery of middle conversions
      dlm: fix dlm_recover_members refcount on error


 fs/dlm/ast.c      |   2 +-
 fs/dlm/config.c   | 170 +++++++++++++++++++++++++++++-------------------------
 fs/dlm/config.h   |  26 ++++-----
 fs/dlm/lock.c     |  73 ++++++++++-------------
 fs/dlm/lowcomms.c |   8 +--
 fs/dlm/member.c   |   2 +-
 fs/dlm/recover.c  |  35 ++++++-----
 fs/dlm/recoverd.c |   2 +-
 8 files changed, 165 insertions(+), 153 deletions(-)


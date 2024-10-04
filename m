Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2D11D9A60
	for <gfs2@lists.linux.dev>; Fri,  4 Oct 2024 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728054831; cv=none; b=l0yeenlJkQVkSpP1jrXriSBEkYfBSK7Bh8WXY5rDF0LYITHsHUbqmXBn4GfJ5cWbCRsE9B1Qco+DEDTyvvx22EC+sNKuZTC1qHOI8SZZ4X5Hb+s1DNoRGAKuLYNzZ8WgyugI3o+Pz1u8M4UEkOrXAazlMlsTJ1dqbdVOdSYnhlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728054831; c=relaxed/simple;
	bh=3XHVJJ0999rkh1qN2NXL84aUQAIHMUJvBxXW4dVpGso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hdr6g+v3/mOoNBFuc9Wvb1/jNEt6qQkgqpPWSFl3K2M+IXO5056yvvMtEMk1i1yOBW/5xeunluc6fp2Kde7fAPe5vzsk4B+CkoWni3eSXpVZbcADsfCSBhU+6nDTSrMtx2Him1xZ+jGxy1P4Bx+k64IyBNb/033UOCvv67g+DUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gj01uaN1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gj01uaN1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728054829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4tvj3FI+0HmZn2iYOoxrvOcULQbEhme57Q2KoN9epqg=;
	b=gj01uaN1Seo0hhUBUbvbAKcQ+Slhj9/RJrfedNfFamY4kAs56G862N9Uak6Y+wyMVgGakD
	wAcJAhJ04ezIwQEuM+Vly+O5i6a7SG5KjPZT93nrNbYAUcpNXOENwJnFkG5JEiKQtIBmbg
	PJKEWyOuu5CHVnAHJD0LjmYFqysRB1A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-jl6l-4NtOQiFRIF4bwhpUA-1; Fri,
 04 Oct 2024 11:13:47 -0400
X-MC-Unique: jl6l-4NtOQiFRIF4bwhpUA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7DF0A19560B0
	for <gfs2@lists.linux.dev>; Fri,  4 Oct 2024 15:13:46 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C091D19560AE;
	Fri,  4 Oct 2024 15:13:45 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH v6.12-rc1 0/7] dlm: tracing, config and null-ptr fixes
Date: Fri,  4 Oct 2024 11:13:36 -0400
Message-ID: <20241004151343.3952937-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Hi,

those pending DLM patches are taken out of the current pending patches
of patch series:

https://lore.kernel.org/gfs2/20240930201358.2638665-1-aahringo@redhat.com/

and

https://lore.kernel.org/gfs2/20240827180236.316946-1-aahringo@redhat.com/

as I need more time to change the strategy how to bring those patches
upstream. The patches are independent from their original patch-series
functionality and there should no problem to apply them in this merge
window.

Thanks.

- Alex

Alexander Aring (7):
  dlm: fix swapped args sb_flags vs sb_status
  dlm: fix possible lkb_resource null dereference
  dlm: disallow different configs nodeid storages
  dlm: handle port as __be16 network byte order
  dlm: use dlm_config as only cluster configuration
  dlm: dlm_config_info config fields to unsigned int
  dlm: make add_to_waiters() that it can't fail

 fs/dlm/ast.c      |   2 +-
 fs/dlm/config.c   | 170 +++++++++++++++++++++++++---------------------
 fs/dlm/config.h   |  26 +++----
 fs/dlm/lock.c     |  53 +++++----------
 fs/dlm/lowcomms.c |   8 +--
 fs/dlm/member.c   |   2 +-
 6 files changed, 130 insertions(+), 131 deletions(-)

-- 
2.43.0


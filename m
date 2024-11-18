Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D19B4086A
	for <gfs2@lists.linux.dev>; Mon, 18 Nov 2024 16:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945721; cv=none; b=j7cmS7GHO3+LWVvt+mRcHpVX0XBA5PETp7/oAMQgRiW29fq+LOARrjxi2hS3IS8BqGeJ/e4sgrBcw1kkmVEAnSHXdPv7+1FgxSdhX80LanSbwqhvPD/sDR0BafJf/51Q+G8w6lQWr95MBpJTRS6vJUw3mgl0KZAru6urIfuVVog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945721; c=relaxed/simple;
	bh=xmfCxg7y0l4lx4QC5BNzaC81vd7epQ74qG5C2l9zObc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z6SHZUGX8MfAPHOayLi0nn144fneiz/WZo8lJYkoBl2yBsrUcmlAOVJoIHoXRFu8IKU2uNRGe+kwOo2ahlzvs4HIOOsU4+UNfR1LbfJDyAIdCkOICTuYczep+tx91JlKwV6Zvm5oWSZE05gZ45/KdgXBinRRXl+2/aa2Ktc7iN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vw1vZeeR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vw1vZeeR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731945718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M0kY7IpdB8DL/DBN9Loen+BQb/imNoLj9FcchEXEyBs=;
	b=Vw1vZeeRqM2g8SfXCAWOZ5by9qG0RWIk0+ys3t4CcqCJ16r4aXO2BN0YMSo1n1Rg3eJOCS
	uw0XMD1kWjKwJZ7x9sT8DB8l6t/OdCZ90J0YXGLvNubtqctEUgfS59sUx3VyJiZgCrpgMw
	ruB6C00dO6mejPkrvOjcKWmdrfe4l4w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-hDO8tjYmO5W4Q3q6FiwjiQ-1; Mon,
 18 Nov 2024 11:01:56 -0500
X-MC-Unique: hDO8tjYmO5W4Q3q6FiwjiQ-1
X-Mimecast-MFC-AGG-ID: hDO8tjYmO5W4Q3q6FiwjiQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E9C431955EA3
	for <gfs2@lists.linux.dev>; Mon, 18 Nov 2024 16:01:55 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0DABA19560A3;
	Mon, 18 Nov 2024 16:01:54 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next] dlm: fix dlm_recover_members refcount on error
Date: Mon, 18 Nov 2024 11:01:49 -0500
Message-ID: <20241118160149.734231-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Y5CxF_NjqqwxsdFo9WqUE209DwAnGI4z2Wf_SHm-GC4_1731945716
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

If dlm_recover_members() fails we don't drop the references of the
previous created root_list that holds and keep all rsbs alive during the
recovery. It might be not an unlikely event because ping_members() could
run into an -EINTR if another recovery progress was triggered again.

Fixes: 3a747f4a2ee8 ("dlm: move rsb root_list to ls_recover() stack")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/recoverd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/recoverd.c b/fs/dlm/recoverd.c
index 34f4f9f49a6c..12272a8f6d75 100644
--- a/fs/dlm/recoverd.c
+++ b/fs/dlm/recoverd.c
@@ -151,7 +151,7 @@ static int ls_recover(struct dlm_ls *ls, struct dlm_recover *rv)
 	error = dlm_recover_members(ls, rv, &neg);
 	if (error) {
 		log_rinfo(ls, "dlm_recover_members error %d", error);
-		goto fail;
+		goto fail_root_list;
 	}
 
 	dlm_recover_dir_nodeid(ls, &root_list);
-- 
2.43.0


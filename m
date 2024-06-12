Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127A8175A5
	for <gfs2@lists.linux.dev>; Wed, 12 Jun 2024 21:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718226966; cv=none; b=Zb21SVgA+xNHZSJAiw3X7TqYPtzM9sp6jylzQz+giNUEA5y8EFk7C9P6G7R/Qu0bAlqTz2x9Fb/t9pAv3V+fp28BArjAQyYrgLw2eeoxYylzbVPA94HGkoKl7BWOzyhP/0v3NOi2cw2s0Nd8vPv4a22j5NCIMVn07AnsiM9XC0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718226966; c=relaxed/simple;
	bh=g72ti1yIsLXYl89T+UD2NjTGWOqS23FpiobuB6rxjdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K9uqTH/PdOxNNBzPbjs5VrJFbykZsV96QytkEsTa9RZ9cObD5J+bSS1iJAo2M1GlW1KU1gbGV5y6YMQVGLHzE7jdGx/gTIaFqM+KQghu0Z5YduMG2OXddE4cKVLzjL0dhiXY+jI1ZZlrI8u6noxI3G8j90N7GwKZlTtgsAAYidI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KVmBdMHa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KVmBdMHa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718226963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iRviJC7KbfnutAvHLaeB9vB4Zxu7ogspktt7BB+WUrk=;
	b=KVmBdMHa51/131LYGtTWoNzRBj/OLHbWqAIlRlf/56HEpmujfzi7Ks+qX5XgSBnzdmfUHL
	ilpKa9uUH2/lNWDyZF8Au71hOydvCuDdzSgyS0R4nSRAUc7aQlga5nWQoFlJmCz2xOzc4q
	eCDYiVBPqfCcCnaebLMSqs9ndsKzK5A=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-X3VMwR_LOOqTM4PUu-WXbQ-1; Wed,
 12 Jun 2024 17:16:00 -0400
X-MC-Unique: X3VMwR_LOOqTM4PUu-WXbQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6809C1956096
	for <gfs2@lists.linux.dev>; Wed, 12 Jun 2024 21:15:59 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CC84D19560AA;
	Wed, 12 Jun 2024 21:15:58 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next] dlm: remove DLM_LSFL_SOFTIRQ from exflags
Date: Wed, 12 Jun 2024 17:15:56 -0400
Message-ID: <20240612211556.3539617-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The DLM rcom handling has a check that all exflags are the same for the
whole lockspace membership nodes. There are some flags that requires
such handling, however DLM_LSFL_SOFTIRQ does not require this handling
and it should be backwards compatibility with other lockspaces that does
not set this flag.

Fixes: f328a26eeb53 ("dlm: introduce DLM_LSFL_SOFTIRQ_SAFE")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lockspace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 7c4f45ad2245..1848cbbc96a9 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -413,7 +413,8 @@ static int new_lockspace(const char *name, const char *cluster,
 	/* ls_exflags are forced to match among nodes, and we don't
 	 * need to require all nodes to have some flags set
 	 */
-	ls->ls_exflags = (flags & ~(DLM_LSFL_FS | DLM_LSFL_NEWEXCL));
+	ls->ls_exflags = (flags & ~(DLM_LSFL_FS | DLM_LSFL_NEWEXCL |
+				    DLM_LSFL_SOFTIRQ));
 
 	INIT_LIST_HEAD(&ls->ls_slow_inactive);
 	INIT_LIST_HEAD(&ls->ls_slow_active);
-- 
2.43.0


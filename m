Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA540319870
	for <gfs2@lists.linux.dev>; Tue, 20 Jan 2026 15:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768923325; cv=none; b=iiLulWHO0cniRH74rHy6Oz2jEwXnSwE7O0V28BnUjYmLafqsYaSJlRYBrQcYgaChIkyJGseQAXgJRgbDGy1jBqiYF/8gi2KbrCMAmn9kHVIE95jv5PQOZ7oQC24G1qyScL9SwZIty/aEmw7rhthqehHP5uM3lfbmNdpFZ/SfG6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768923325; c=relaxed/simple;
	bh=86g88At/3gS+pw0Av8UXgYYgfivoii+WujqQ3HIpEPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=jIUWjmOc5a2lvc/Sh4Js3jXxFgptyQaqnSmls/6BpAd6PRw0K3rxk4TPVCl557GO5sionKXTgFij0ZZrbqRBj17q2mHEPk3c4EkAxzsP0CuAe/JMqKlCrJ/lst5E5IEAMbyOb0efFQyf/EvJgUnW1VPC9prhaZUF53eyNnC+5D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BPROIARt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BPROIARt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768923322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DaouPAtehDl3dSHLUF5yeGcJ6fo/wUuS2kTo8OOSdVk=;
	b=BPROIARtejQXsTXD8Jkr/3FFfEtJ2w0sZqL2cdi6kNBdfk4ZQQsUibwADKCU/l/aS0Lukc
	vzRxDgnz/h74bX4Ae0dJzOfDkAoFDHue+1zcpcrrmeJdQPREUKicipxfcxAgXIVF3cSdbr
	CvxY7/rp/LJ+LhnR4seQWoaiu6pW0iY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-4Zr85GLKM_aJ66xWoZVmpA-1; Tue,
 20 Jan 2026 10:35:21 -0500
X-MC-Unique: 4Zr85GLKM_aJ66xWoZVmpA-1
X-Mimecast-MFC-AGG-ID: 4Zr85GLKM_aJ66xWoZVmpA_1768923320
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E719A19560AF
	for <gfs2@lists.linux.dev>; Tue, 20 Jan 2026 15:35:19 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E2680180099C;
	Tue, 20 Jan 2026 15:35:17 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH vv6.19-rc6 2/7] dlm: validate length in dlm_search_rsb_tree
Date: Tue, 20 Jan 2026 10:35:06 -0500
Message-ID: <20260120153511.2201392-2-aahringo@redhat.com>
In-Reply-To: <20260120153511.2201392-1-aahringo@redhat.com>
References: <20260120153511.2201392-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5PC9AbJ7Ljc86e8FtQ6WV3u56X6cPGIxgGgg7DQkqyg_1768923320
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Ezrak1e <ezrakiez@gmail.com>

The len parameter in dlm_dump_rsb_name() is not validated and comes
from network messages. When it exceeds DLM_RESNAME_MAXLEN, it can
cause out-of-bounds write in dlm_search_rsb_tree().

Add length validation to prevent potential buffer overflow.

Signed-off-by: Ezrak1e <ezrakiez@gmail.com>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index c01a291db401b..a393ecaf3442a 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -626,7 +626,8 @@ int dlm_search_rsb_tree(struct rhashtable *rhash, const void *name, int len,
 			struct dlm_rsb **r_ret)
 {
 	char key[DLM_RESNAME_MAXLEN] = {};
-
+	if (len > DLM_RESNAME_MAXLEN)
+		return -EINVAL;
 	memcpy(key, name, len);
 	*r_ret = rhashtable_lookup_fast(rhash, &key, dlm_rhash_rsb_params);
 	if (*r_ret)
-- 
2.43.0


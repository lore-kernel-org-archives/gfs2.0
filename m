Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F092221B8F8
	for <gfs2@lists.linux.dev>; Thu, 14 Aug 2025 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184945; cv=none; b=RKzw5dc9E4iM/sL9YG0s6GfxxhvsZ4uNcdXDDPoRAEzgTbhqt2GjvSIS/g7fyQ5N6as5sMPv8tzpOAlJ9GCNFYE2rvZT8pQGcj+YTRHCXOmyecKjyFvbtzOXNHVLutWvMoS7OBOb1/vv7IuZnPIQV41HECBA2Eg828EH2gBv78o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184945; c=relaxed/simple;
	bh=dXMbaGII6HVbBzg3uON5YUfPv7Xl5S1hA3uG0473JOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=K4qVGY5ySz5V6x5tKeRArWsOGmNcFDS/IwvxXm0Dm4FiPUcgX2zINeEhKL7haQceZQGH0yxi/LHM9TzmDM7BjrinbGVA5NekhyoapdktDa1HrmGfG5MR0SvqHA98lFe6hqW6qMM6atLGri1YfzNsiB53mHe6VofiMOWYdgbZoTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OoyB+0Z8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OoyB+0Z8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755184942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hzPuFM4MbsHjS9dm7FQnXS9zzgvpsEkCBvawu2fI5Fc=;
	b=OoyB+0Z81r154kJ6+zkFKH2O6nJ4opD4WI631xzy+JCejm3bQFFIEmEGvFB+6ZYcjxrsXK
	5UaBuIvsonzk0NxTSrnHrrNI74pobf1dzaPAVKV8yKbj3AUG6kC0AMynnJVRLyim+LKWav
	5Evr0BlQsxjByNJidhkAq443E6NWUvA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-bQh4NGx_Pom7pe70ZZhopw-1; Thu,
 14 Aug 2025 11:22:21 -0400
X-MC-Unique: bQh4NGx_Pom7pe70ZZhopw-1
X-Mimecast-MFC-AGG-ID: bQh4NGx_Pom7pe70ZZhopw_1755184941
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE28B1955D48
	for <gfs2@lists.linux.dev>; Thu, 14 Aug 2025 15:22:20 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2C2B830001A6;
	Thu, 14 Aug 2025 15:22:20 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next 1/4] dlm: handle invalid lockspace member remove
Date: Thu, 14 Aug 2025 11:22:11 -0400
Message-ID: <20250814152214.946153-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8GwvwFXWrM5Z-ntb_xESVeAippLpjp7_n0wchZ0CTw0_1755184941
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Since commit de7b4869b4ecf ("dlm: add new configfs entry release_recover
for lockspace members") we are moving lockspace members into a gone list
before removing them to get additional removing attributes from
configfs. There is still a very unlikely possibility when
find_config_node() returns NULL, then for some reason the node wasn't
marked as gone but it was removed. We will just handle this case and drop
an error to observe if this case can ever happen.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/gfs2/aJ2Ssuh8xlsTutrA@stanley.mountain/T/#u
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/member.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/dlm/member.c b/fs/dlm/member.c
index 356337102015e..c0f557a80a754 100644
--- a/fs/dlm/member.c
+++ b/fs/dlm/member.c
@@ -571,7 +571,13 @@ int dlm_recover_members(struct dlm_ls *ls, struct dlm_recover *rv, int *neg_out)
 
 	list_for_each_entry_safe(memb, safe, &ls->ls_nodes, list) {
 		node = find_config_node(rv, memb->nodeid);
-		if (node && !node->new && !node->gone)
+		if (!node) {
+			log_error(ls, "remove member %d invalid",
+				  memb->nodeid);
+			return -EFAULT;
+		}
+
+		if (!node->new && !node->gone)
 			continue;
 
 		release_recover = 0;
-- 
2.43.0


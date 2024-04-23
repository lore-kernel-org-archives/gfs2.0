Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BA784DE1
	for <gfs2@lists.linux.dev>; Tue, 23 Apr 2024 12:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876759; cv=none; b=NsOtyEutD59MZSWFH1/Thf7D5bhu0OwP/CvkNqQ28ATa779uuBVD9kH+T6s0frsof9WtN0BFiiu33YEu0axJMIH/g7ExJZrZjLRRfHevHl4BOjPECidg4ZT31GN3MzoO5TE2/Ywpmp3gNTaHke/Xiz/jXEZUuX0s6oW9hOfDhB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876759; c=relaxed/simple;
	bh=oL15Slvjv3wRTRivnzoGi+6RB15YPdvoOsfeuFePJNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZAhZK1pfdF3ybxqDs6C2+ZrEjuF46tLUf+q3CmkMhC6DmETL12YlI6IrnQRLy/bchC3NPaF8M9NRIah5K+zlo2h/iW7hTTyC1rIsjovnxjd2xO7DMtSquXxrdebSlsli63Xeolcvm7O0pm6ok32nbXa5yjaGXlk1py2yyO+dTIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c8yeHTct; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8yeHTct"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713876757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=70xarBjAhKVvCgCx18IjA736nOfqmwKPEwQvgPqfi+M=;
	b=c8yeHTcty82v0OtyGeGmhDKrAhHuG1U3Piq3GqF5xPrHFKl9XrNZR3e45663+i7uZPYC8C
	uTc6PhCABTiYbTr1jJX7BGQvYqCDZHyROJjtzlBnrJQ1enKGOGMAzkZQBxzIFmi8kvObHU
	+ciDQEEU1R03AQyx68wuDvG4k5O6miI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-kEbwHS-XOpKKmYhjrMTZIw-1; Tue, 23 Apr 2024 08:52:33 -0400
X-MC-Unique: kEbwHS-XOpKKmYhjrMTZIw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4E3C189AC22;
	Tue, 23 Apr 2024 12:52:32 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DB7FC2166B31;
	Tue, 23 Apr 2024 12:52:32 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	dan.carpenter@linaro.org,
	aahringo@redhat.com
Subject: [PATCH dlm/next] dlm: return -ENOMEM if ls_recover_buf fails
Date: Tue, 23 Apr 2024 08:52:31 -0400
Message-ID: <20240423125231.1158771-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This patch fixes to return -ENOMEM in case of an allocation failure that
was forgotten to change in commit 6c648035cbe7 ("dlm: switch to use
rhashtable for rsbs").

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202404200536.jGi6052v-lkp@intel.com/
Fixes: 6c648035cbe7 ("dlm: switch to use rhashtable for rsbs")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lockspace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index ed23787271b1..475ab4370dda 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -482,8 +482,10 @@ static int new_lockspace(const char *name, const char *cluster,
 	 * might send less.
 	 */
 	ls->ls_recover_buf = kmalloc(DLM_MAX_SOCKET_BUFSIZE, GFP_NOFS);
-	if (!ls->ls_recover_buf)
+	if (!ls->ls_recover_buf) {
+		error = -ENOMEM;
 		goto out_lkbidr;
+	}
 
 	ls->ls_slot = 0;
 	ls->ls_num_slots = 0;
-- 
2.43.0


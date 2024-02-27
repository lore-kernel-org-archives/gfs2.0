Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9A015D0
	for <gfs2@lists.linux.dev>; Tue, 27 Feb 2024 01:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998563; cv=none; b=Fw7uvEpVz3AXczxQwLPEN0zf0xsjAK5mXJ/VyPN7G2QAfUTqC0Oj9Lmu64/u5AhVsbWB3My8pYYWnHS203mfI+KYVSY4hAzmjxQx5A9NkigQF/P/oAzDTAKy1bElIzUSg6YQgPYNIgl14e4aADBF/IizRYLSvuOQx9AdI7xvm1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998563; c=relaxed/simple;
	bh=iyBvwhELja2y+yRVzVMSiZ0CVQErn+LYW9HsduvAXzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jfAoqt2pmuCAd92GVWZNI+D/Bbx3d6XNK7TSzIS0uKuikjY8IJR1srE89qWU9fa8Nd+lka7GFtjXoqQxs95qtNYC9OK9QMKvqtjwsA6b+5Eg4fh0Uh69VWiulgiN7TrJZkkaBLinu3xCoA+SN4PguPjtlRH2xicfwaTjpkaycuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AGB8IbkA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGB8IbkA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708998560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4iX/8snRRtPLd/X3lr2jbgEqwwnGAt+KGXT8PlS7oho=;
	b=AGB8IbkAk546c1GXNOe4EjxK8aTArLn3MBm+TBDtyZGmE3aTDZd51UAyjaQkFiQoqxcPXd
	KK4pXm7nGTlcxhOz22la2WDFSZ35ItO9JW/vJ90QHeXpzsdH1qBlBNmpVjIIIVpTnXxoh6
	I/ev/pujBEyVoSmXDLJLHqWmNZOvt5c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-kkG1j91iPWOi5tOcsr1l_A-1; Mon, 26 Feb 2024 20:49:19 -0500
X-MC-Unique: kkG1j91iPWOi5tOcsr1l_A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A3CF862DC2
	for <gfs2@lists.linux.dev>; Tue, 27 Feb 2024 01:49:19 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.fast.eng.rdu2.dc.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 00FF82166AE8;
	Tue, 27 Feb 2024 01:49:19 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv3 v6.8-rc6 03/18] dlm: fix off-by-one waiters refcount handling
Date: Mon, 26 Feb 2024 20:48:54 -0500
Message-ID: <20240227014909.93945-4-aahringo@redhat.com>
In-Reply-To: <20240227014909.93945-1-aahringo@redhat.com>
References: <20240227014909.93945-1-aahringo@redhat.com>
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

There was a wrong conversion to atomic counters in commit 75a7d60134ce
("fs: dlm: handle lkb wait count as atomic_t"), when
atomic_dec_and_test() returns true it will decrement at first and
then return true if it hits zero. This means we will mis a unhold_lkb()
for the last iteration. This patch fixes this issue and if the last
reference is taken we will remove the lkb from the waiters list as this
is how it's supposed to work.

Fixes: 75a7d60134ce ("fs: dlm: handle lkb wait count as atomic_t")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 652c51fbbf76..c30e9f8d017e 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -5070,11 +5070,13 @@ int dlm_recover_waiters_post(struct dlm_ls *ls)
 		/* drop all wait_count references we still
 		 * hold a reference for this iteration.
 		 */
-		while (!atomic_dec_and_test(&lkb->lkb_wait_count))
-			unhold_lkb(lkb);
-
 		mutex_lock(&ls->ls_waiters_mutex);
-		list_del_init(&lkb->lkb_wait_reply);
+		while (atomic_read(&lkb->lkb_wait_count)) {
+			if (atomic_dec_and_test(&lkb->lkb_wait_count))
+				list_del_init(&lkb->lkb_wait_reply);
+
+			unhold_lkb(lkb);
+		}
 		mutex_unlock(&ls->ls_waiters_mutex);
 
 		if (oc || ou) {
-- 
2.43.0


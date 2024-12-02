Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B0E209F27
	for <gfs2@lists.linux.dev>; Mon,  2 Dec 2024 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153216; cv=none; b=QQnwwjy3/BSZi60QEvzOOScjBzyemEiSlMEkwqO4AO9BnML3qiyZoyXNZkHhYu3CHZukeZ1Vj7fAukmkpHOoIkluoIlkW8lSX9ujVi54qjdeAchqTDQs1W2Gi2RnjfEZnIu2/hkA17IRCJplYyh83veFu0jhgKqG10O++5CJPB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153216; c=relaxed/simple;
	bh=IigblxMSHqOURdnzShkganYuFyrmBYQnO7hQMHJR8s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=V433vcgnUZtwM/Ys6OQpspWV/Erp6VVXof7MwazHZtNVMRfadDSM5u6vQL7b315hDE4Bcc8xVJgvoVhbvNNZhRu8stIdML62bSYiOsQQE6+r/dRMWt9ymoVj1opUJH/+QgyWCvKoI/r7geHY4I88B3aJ60ULzHqDUNbOylH+v8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hglhHX5a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hglhHX5a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733153213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pVqPUdygbjmGow6c4TKLr8qafXyg+ddsbIGOt/H9UnM=;
	b=hglhHX5aArxfjZ3CUd6o54MWuC4jABNLPGxbOxoGl1OtlRGoEwWAZnHP3L6BM6yF2gALly
	mfOBpw6OaggGmcemV5k80LHeOWOi+mOTgr/HKWUz/mA0rhUWvp62VBXBkdIeQOx2M2z2Jk
	srkCBNWvBSEKZs6TyhE0Fc1j5XpYKUc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-3HJmJ0GaPVGzQs0iSqL6Wg-1; Mon,
 02 Dec 2024 10:26:52 -0500
X-MC-Unique: 3HJmJ0GaPVGzQs0iSqL6Wg-1
X-Mimecast-MFC-AGG-ID: 3HJmJ0GaPVGzQs0iSqL6Wg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43654195422B
	for <gfs2@lists.linux.dev>; Mon,  2 Dec 2024 15:26:51 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 87F6530000DF;
	Mon,  2 Dec 2024 15:26:50 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH v6.13-rc1 4/5] dlm: make sense out of force values
Date: Mon,  2 Dec 2024 10:26:40 -0500
Message-ID: <20241202152641.3395369-4-aahringo@redhat.com>
In-Reply-To: <20241202152641.3395369-1-aahringo@redhat.com>
References: <20241202152641.3395369-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IkQvZMWC_-kPINZXOL766Uot9UiQ0PoLK6pWiV1ntUE_1733153211
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Currently users e.g. gfs2 calling lockspace_busy() with 2 which seems
not to be specified but it is specified as the rest of force value
meanings besides 0 and 1 which means: do check nothing. That makes no
sense as we can never introduce any new force value to have a specific
new meaning for it.

We just switch now to have 2 as meaning as do check on nothing and the
other values will return -EINVAL if somebody calls
dlm_release_lockspace() with them. This might break API but it totally
makes no sense to not use the other values of the force parameter.

All kernel users, gfs2 and md-cluster uses 2 as force parameter which
has the meaning: do check on nothing and let recovery deal with it.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lockspace.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 8afac6e2dff0..1a216a8b6ca2 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -691,8 +691,10 @@ static int lockspace_busy(struct dlm_ls *ls, int force)
 				break;
 			}
 		}
-	} else {
+	} else if (force == 2) {
 		rv = 0;
+	} else {
+		rv = -EINVAL;
 	}
 	read_unlock_bh(&ls->ls_lkbxa_lock);
 	return rv;
@@ -703,6 +705,8 @@ static int release_lockspace(struct dlm_ls *ls, int force)
 	int busy, rv;
 
 	busy = lockspace_busy(ls, force);
+	if (busy < 0)
+		return busy;
 
 	spin_lock_bh(&lslist_lock);
 	if (ls->ls_create_count == 1) {
@@ -730,7 +734,7 @@ static int release_lockspace(struct dlm_ls *ls, int force)
 
 	dlm_device_deregister(ls);
 
-	if (force < 3 && dlm_user_daemon_available())
+	if (dlm_user_daemon_available())
 		do_uevent(ls, 0);
 
 	dlm_recoverd_stop(ls);
-- 
2.43.0


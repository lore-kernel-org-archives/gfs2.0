Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B95322E
	for <gfs2@lists.linux.dev>; Thu,  7 Nov 2024 20:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731012391; cv=none; b=C6+hGtStDTkWI5yunuUBVqskqlimNa/HGbUNbqU8oEvtdhjnPFQajh3oVadclDm8KvzaQzeTwgRmCsSG1niPYaQ5NAr95n4HrF4rD4DlResLBxJXdWoTz/y6JIYa06xgHsz18aAe8p8mtJyZNBqZtD1FztGkSfrE6i5XCeYz74Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731012391; c=relaxed/simple;
	bh=Mfg/cJYXQG7UV+GalNMWi42zttRB5j79JFQq2reEmog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dSSYNyiwR3gLrniS6uq58fXXj2k1+M9ZkpfYLjNqKBzaqTsMqX54nxTKQBPM/7HVfupmA4VQV9F4D76wGgLpmtKcsMyhkIyVR55Lwawlk0kQ+PLMXQaegquJqhWw7cdit8xr5oeiWeP0pIkIECmSPACEWsNW7a2tH88cRYpiejc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IilX5CQJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IilX5CQJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731012388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vuX9pVcw/jHhQb2PWXrnvcd/S4ncNbZOhGTw9ZRTXWE=;
	b=IilX5CQJK7Rlfad051123yN9WR+3ccfcyNMrKqYi6lOxiJXTsT0G3+AAG1YomMn2H3Elmh
	d/QXdesK1SkJ1XSmz3PlZSBaOfRbGLeT3Kl9nzKLj6krKM0SUgMEWD3Zb7v9SH2ae3gbKE
	UiBZnjl8itnpqThWipHgORZaSS0pMb8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-odUH9O9lOtSM5BR9BvaTiw-1; Thu,
 07 Nov 2024 15:46:27 -0500
X-MC-Unique: odUH9O9lOtSM5BR9BvaTiw-1
X-Mimecast-MFC-AGG-ID: odUH9O9lOtSM5BR9BvaTiw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6DFAE1955EE7
	for <gfs2@lists.linux.dev>; Thu,  7 Nov 2024 20:46:26 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CE01E300019E;
	Thu,  7 Nov 2024 20:46:25 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [RFC dlm/next 06/11] dlm: track reference for lkb_rsb_lookup
Date: Thu,  7 Nov 2024 15:46:12 -0500
Message-ID: <20241107204617.147842-7-aahringo@redhat.com>
In-Reply-To: <20241107204617.147842-1-aahringo@redhat.com>
References: <20241107204617.147842-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iV6FeerTrfP3XSCZOU78CKkbR2MGvHP78exIhlRxvt4_1731012386
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

We don't track the reference for lkb_rsb_lookup list. This only probably
works because _request_lock() is sending out a request to a remote node
as this is the lock master as we don't evaluate the return value of
_request_lock() for a potential -EAGAIN. Future patches introduce a new
reference counting model for lkbs that does not require evaluating of
_request_lock() for a potential put. There might be potential issues
because recovery could interact inbetween and changing the lock master.
However we track the reference now if an lkb is part of the
lkb_rsb_lookup list and drop it again when it is deleted.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 1f4f2d24bef4..b570e9f7cc6f 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -2658,6 +2658,7 @@ static int set_master(struct dlm_rsb *r, struct dlm_lkb *lkb)
 	}
 
 	if (r->res_first_lkid && r->res_first_lkid != lkb->lkb_id) {
+		hold_lkb(lkb);
 		list_add_tail(&lkb->lkb_rsb_lookup, &r->res_lookup);
 		return 1;
 	}
@@ -2700,6 +2701,7 @@ static void process_lookup_list(struct dlm_rsb *r)
 	list_for_each_entry_safe(lkb, safe, &r->res_lookup, lkb_rsb_lookup) {
 		list_del_init(&lkb->lkb_rsb_lookup);
 		_request_lock(r, lkb);
+		dlm_put_lkb(lkb);
 	}
 }
 
@@ -2734,6 +2736,7 @@ static void confirm_master(struct dlm_rsb *r, int error)
 			list_del_init(&lkb->lkb_rsb_lookup);
 			r->res_first_lkid = lkb->lkb_id;
 			_request_lock(r, lkb);
+			dlm_put_lkb(lkb);
 		}
 		break;
 
@@ -2904,6 +2907,8 @@ static int validate_unlock_args(struct dlm_lkb *lkb, struct dlm_args *args)
 				   args->flags & DLM_LKF_CANCEL ?
 				   -DLM_ECANCEL : -DLM_EUNLOCK);
 			unhold_lkb(lkb); /* undoes create_lkb() */
+			/* for lkb_rsb_lookup */
+			dlm_put_lkb(lkb);
 		}
 		/* caller changes -EBUSY to 0 for CANCEL and FORCEUNLOCK */
 		goto out;
-- 
2.43.0


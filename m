Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795204856;
	b=vbf3F7Pkzcf6U/Q1fajOG+F4PLGZPIMagBw+YAU1odeSZ3OcOfS6e2pvJyuZ4AXKGIsC
	 GqeYGGCII4lAe2fLseXtwhrM3Intp8+NnQr/zFrcaaisFatZqSDL8Q0qKlME7JfAcNsvb
	 6LAq4moIVaGjgRQ7ts7TKvd9wTPK94oy5YiQnn1b7+oaSjZFBXkm3PtA4KVwi5+oB/paA
	 jYwRyBcRG1icmjzf9E8abDlaKppn3u05iCOZ16mf7aU63g8IqxTBN21wcE3oJC6ku2n31
	 ePInucDxFTWSKs411dR+URM6O7azgT04fCEceUhcPH5+UQQXjg54ZFfwKTY7AhAYITw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795204856;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=5Es2ZmcY3dDrLm3TXSrs5K0ywF3os6aPf7OW/bcN/ck=;
	b=AOpAwVNEdhaJ/N0F7rCRuawWPPmVfONGMD6oW4bBFoeAwQcNen8kqUGUQ7vWtbY2QPWY
	 EYHd3s4KMNUUYJ6QOV1AAYYY93WFqtNbEG/h6HbBYZ5OITfBLZLjcQBtf2E54KHQMK3yP
	 L02b4pRxRKsYJlXJ/K+hn6UZvKfHJaCakmmrCw5nf0i15wV1JZN/J26/iNGjDVwCyL2Zw
	 NrcQ13UImznXKdj6dD0N5lfSCnS74/3KdchPwhZ8VOTnG98WxiwoQpAdkRJ09PNNpCowx
	 YhZUoqzc2rL/x7klzODPax3PGNf2edzGlA6DnTGnn+udAojeh2DK4Dzi9uhs5nFJoLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bbkzf2ei;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC1B606A6C3
	for <gfs2@lists.linux.dev>; Fri, 20 Nov 2026 20:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AC1B606A6C3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bbkzf2ei
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795204852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Es2ZmcY3dDrLm3TXSrs5K0ywF3os6aPf7OW/bcN/ck=;
	b=Bbkzf2eiiu/wm0aRi7WPhAI7DSS88Orj0nhoSpuLMqOf6avJl91In+DZfSUZhczBraBkkk
	QO5acUaK7Ys7tapEP9y0q/gJ6oobRBBa9cYebR9oYf1wxDwyBF3S5lFzLb/6EAE1eUckN7
	O6LOg31jY/PVS0Xtw3FGnLDOXubLIb8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-1mbAGobgMfu0TXjg4FkXOA-1; Fri,
 20 Nov 2026 20:00:50 +0000
X-MC-Unique: 1mbAGobgMfu0TXjg4FkXOA-1
X-Mimecast-MFC-AGG-ID: 1mbAGobgMfu0TXjg4FkXOA_1795204846
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73BD819541A8
	for <gfs2@lists.linux.dev>; Fri, 20 Nov 2026 20:00:46 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DE812428;
	Fri, 20 Nov 2026 20:00:45 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCHv2 RESEND v7.4-rc3 5/5] dlm: fix memory leak on active leaving member
Date: Fri, 20 Nov 2026 15:00:40 -0500
Message-ID: <20261120200040.257152-6-aahringo@redhat.com>
In-Reply-To: <20261120200040.257152-1-aahringo@redhat.com>
References: <20261120200040.257152-1-aahringo@redhat.com>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: K7FweMhbdDhF9-IK8DvK3OHaL5hEUrC1tYBUJHl9TZo_1795204846
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When a node calls dlm_lockspace_release() locally, it does not
subsequently run recovery. Commit de7b4869b4ec ("dlm: add new configfs
entry release_recover for lockspace members") entry began tracking
leaving members to perform optional post processing, such as invoking
the slot callback. Because a locally leaving member does not execute
recovery, it never invokes dlm_config_nodes(), leaving the allocated
tracking entries uncleaned.

This issue was detected by kmemleak.

unreferenced object 0xffff88811d68bcc0 (size 32):
  comm "dlm_controld", pid 406, jiffies 4294749992
  hex dump (first 32 bytes):
    03 00 00 00 00 00 00 00 08 bd 68 1d 81 88 ff ff  ..........h.....
    88 bc 68 1d 81 88 ff ff 00 00 00 00 00 00 00 00  ..h.............
  backtrace (crc be1c20bb):
    kmemleak_alloc+0x85/0xa0
    __kmalloc_cache_noprof+0x2ac/0x380
    drop_node+0x73/0x550
    client_drop_item+0x83/0xe0
    configfs_rmdir+0x735/0x910
    vfs_rmdir+0x24a/0x820
    filename_rmdir+0x3a3/0x4a0
    __x64_sys_rmdir+0x42/0x60
    x64_sys_call+0x1e8d/0x1fb0
    do_syscall_64+0x87/0x490
    entry_SYSCALL_64_after_hwframe+0x76/0x7e

A local node executing dlm_lockspace_release() does not require additional
recovery handling, such as invoking the slot callback. Fix this memory leak
by freeing the resources allocated in drop_node() when the lockspace
configfs entry is released.

Fixes: de7b4869b4ec ("dlm: add new configfs entry release_recover for lockspace members")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/config.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/dlm/config.c b/fs/dlm/config.c
index 6ebc0fa9a2fa..5e41f795366c 100644
--- a/fs/dlm/config.c
+++ b/fs/dlm/config.c
@@ -533,9 +533,18 @@ static struct config_group *make_space(struct config_group *g, const char *name)
 static void drop_space(struct config_group *g, struct config_item *i)
 {
 	struct dlm_space *sp = config_item_to_space(i);
+	struct dlm_member_gone *mb_gone, *mb_safe;
 
 	/* assert list_empty(&sp->members) */
 
+	mutex_lock(&sp->members_lock);
+	list_for_each_entry_safe(mb_gone, mb_safe, &sp->members_gone, list) {
+		list_del(&mb_gone->list);
+		sp->members_gone_count--;
+		kfree(mb_gone);
+	}
+	mutex_unlock(&sp->members_lock);
+
 	configfs_remove_default_groups(&sp->group);
 	config_item_put(i);
 }
-- 
2.43.0


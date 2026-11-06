Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997645;
	b=VSXe6QxVXFMIme1ekrw/LRELxuK6osfLDjax20Ck5sgjXXH7+wFeiq88sIfjZeuB5vjn
	 4NoNPw67jFMdzHxyLH71bP1H/7tLNS8N3shZEBr/cI9CMDyf1BxS8b4t91WlaqwIf44qS
	 sIYKXAlfqdV6ADyNUuKeSBuS0SaMdX4AM1R0rfONQl3w5sEMriPBvUGYrRdT6IepaZ85I
	 dw8IaaY7sVOytZEguvKZ8xzk4AjRevojnvqfSBJRsyc3n3lzYXStxmIu78cWaKCDDoe2n
	 2GYTb1R/4YJ004boYsVl4+XK9NqTkJnIfkuOPa+ACuiOFlz0YzfiTvM1yB0iWy9k28A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997645;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=5Es2ZmcY3dDrLm3TXSrs5K0ywF3os6aPf7OW/bcN/ck=;
	b=cpWCCaieJ4mwLQb3P1fTXq0nBfFNu+EVAZD2Yxv15Be7nHf56dZ0uV8yXuR3HrOl7PDo
	 aJBaNMUpvSLz+1Jutyc3zUp/+Lct+aqwrI/ZhDzCU0wMNNWXi1+v768wE3X5vvoEF/VhB
	 Qv2cA9T09KGbrLFy3gbJV3Bm7U9RTmhV4TOebc5o+NA6jrFu1efvyOmjl3UAT+v5fRuf8
	 /AiLRWYvZNYHEiYpBfCSmfQTeflQKZzWY/5zzmjiRGPmMsZkcEZ3v0AvA7Qhv1ON8chSq
	 tTgSzjndAsM1LZhQGMV+C/mF0H8PKqQdTyy63zs6TbUcISLKxWdZtErcYWcp/agx78Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=imHqQi4a;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF168606A329
	for <gfs2@lists.linux.dev>; Fri,  6 Nov 2026 20:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF168606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=imHqQi4a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793997644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Es2ZmcY3dDrLm3TXSrs5K0ywF3os6aPf7OW/bcN/ck=;
	b=imHqQi4afQpJ24Jd9hNwpNU724C+vaki3LqtDotCUQqV4HOpN7wr6fTWlvSDaNF7hBWKuR
	wqU4+lpjANXS5nxdrrShR86Fa3PuDDp4aqtivzGR25SBdmMlPcCVFZpAPpuDQf+K6zks9r
	V+F1kj4bOJqlD4RGl45awt8u+Nc/FOY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-19wwPBNZNbq8mkhIDvX6_Q-1; Fri,
 06 Nov 2026 15:40:42 -0500
X-MC-Unique: 19wwPBNZNbq8mkhIDvX6_Q-1
X-Mimecast-MFC-AGG-ID: 19wwPBNZNbq8mkhIDvX6_Q_1793997641
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C73421944AAB
	for <gfs2@lists.linux.dev>; Fri,  6 Nov 2026 20:40:41 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 54FDD1956044;
	Fri,  6 Nov 2026 20:40:41 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH RESEND v7.4-rc1 4/4] dlm: fix memory leak on active leaving member
Date: Fri,  6 Nov 2026 15:40:35 -0500
Message-ID: <20261106204035.3794411-5-aahringo@redhat.com>
In-Reply-To: <20261106204035.3794411-1-aahringo@redhat.com>
References: <20261106204035.3794411-1-aahringo@redhat.com>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OBXOTn0bH_0whg4nPCXH0CKiZ1HcKdMnKundxueAl-4_1793997641
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


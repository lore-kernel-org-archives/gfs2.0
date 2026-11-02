Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657492;
	b=M8IaFuV0g7hz+maBxY5jc/4CgHX0ZGOL7xUs07vDJ4DNOwPU8eh9/AGn+RoO20G6Jdcl
	 mFx4IiTx0uX9ryUpD6VQUBqU9WJfXa+/ZhuKC8zVYl9UWtDj0hzLC99AMkvDmeQCRkj6V
	 /iatYV+ZuON6BwXBWS1okzFe/U20EvhFf1tXiegXyDgyiZQ4zf623msyjiwblZ8IDuGyf
	 kFybxrIPVPnSNkT8yx7ErjXY1aOfON7hHg3fXbHS4D9zdYKQBVxe3cS6ewZ+YYxV7ynNu
	 +LDcJ08o/CUUhYZZR2Eg++biwTTXwWRWT6k4qzP2XCUs90CDnjScmlvNcmO2hcBC0Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657492;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:X-Scanned-By:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=5Es2ZmcY3dDrLm3TXSrs5K0ywF3os6aPf7OW/bcN/ck=;
	b=zEvbiuYBy8/lLVpw9NP+bl2UPhZAOBF63dxcZTQbi1YbeEcvdU+my8Z39Y1aBhj2B9no
	 7ZEBtDW1aP9+kesw8rXcbukXeoUFl4R1jhA5mGKGVdrPK6hcUIuLEb7G01MTlHt5ZgwjC
	 K6tEi6xho+twZQz6ZUZHi1EVkQ5P61vAentZQGZ87LP0w7NPuAwRrARQo4QMAD/8tYeLP
	 U9pmrohnt3VNPbUTJ5EP+OJo9rsIHOzN+OxQMsZwmunzaV40DCpDlzwyzkVxr41MKpyBp
	 QfZdDmh9PVnvrh9J7dn1WgmrpNIlgnz9T2kPZIDdryb+fS6e8moi+wo66EPek71Vi4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HuWpZboO;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F942606A324
	for <gfs2@lists.linux.dev>; Mon,  2 Nov 2026 22:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F942606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HuWpZboO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793657491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5Es2ZmcY3dDrLm3TXSrs5K0ywF3os6aPf7OW/bcN/ck=;
	b=HuWpZboOH5pVozQIGEIeW2TdSfmj7URcD5/DlN7b4XRKxEJ18GowpgJIwt2nosX/DmAXgc
	wRnYCtyXX8g6QoOxF57pbx5C9UdHrJMsWeiHTvjU6KmQUrEMoJptwBOfqDphl5RDccEImP
	kq0GFeIOTtsf6zqMmzJLkCTAavItvog=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-jRQDoBv6PtOzHvtokaUjTg-1; Mon,
 02 Nov 2026 17:11:29 -0500
X-MC-Unique: jRQDoBv6PtOzHvtokaUjTg-1
X-Mimecast-MFC-AGG-ID: jRQDoBv6PtOzHvtokaUjTg_1793657489
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1A911955F34
	for <gfs2@lists.linux.dev>; Mon,  2 Nov 2026 22:11:28 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 476491956040;
	Mon,  2 Nov 2026 22:11:28 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH] dlm: fix memory leak on active leaving member
Date: Mon,  2 Nov 2026 17:11:19 -0500
Message-ID: <20261102221119.3209992-1-aahringo@redhat.com>
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
X-Mimecast-MFC-PROC-ID: XBWHcjVpAvlP9Z--0Q2-nEM4NUgmWTFLeZYcPiQ2KaA_1793657489
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


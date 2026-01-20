Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED958287511
	for <gfs2@lists.linux.dev>; Tue, 20 Jan 2026 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768923322; cv=none; b=WjEE24tDhM535eitmVStI4p3mjMw7Cyemz6eAQSvnqtnxqIswPxKZsdqvvcS6Q9S/3FWjdKW2P1Zh5dTN4uTT+p+9hYZwDodKueWeRwAFS+HGfetDDDwUqicjht8HdeU916xCha2LDMBUGpudbJ9WPcxoPrBPgUZYc8b1S4S4iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768923322; c=relaxed/simple;
	bh=Ii4P1QNZs08qYlvOtTPD1seSmShP1H/CJcqCfJ+7i2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=Kdg4dqZCSmu3ZdDs6tb4AFlfBijGaBWciD/qKBuLNTMYQFy94VCQo5yDP7M384RdQjkWzp6vHG0sAAOkNSC9LR+7ChRb/YRx0xl3bq4+hGmo/0pa3MGSuAAa929+eFLvoTfDU3dR+hDVdNDCQ6ExU6FEzii5PrMNFSH0S8Jcpjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AqjcR3ld; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AqjcR3ld"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768923320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hQGbxhKZRfEdi1AnFXsubZ/UiUAoSyoLz14IRTe+6CM=;
	b=AqjcR3ldr9gcTnU83dI0Eqdc/61o+584+IsRlnI1qasTe88fkaRdrdNph8CCpmEbrAIMap
	hku0XaxwkSMAT8fHHscdyIuUUpJ2foQ7QRjVOS8G0ywx8zl4iKC9RC+i8Am89zKDBsBXCD
	d+VWrKULeyZ/blUKxBfc80n2OsEyPYo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-a7VTd11MNlS4JBQ4lNNieA-1; Tue,
 20 Jan 2026 10:35:18 -0500
X-MC-Unique: a7VTd11MNlS4JBQ4lNNieA-1
X-Mimecast-MFC-AGG-ID: a7VTd11MNlS4JBQ4lNNieA_1768923318
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE0271800372
	for <gfs2@lists.linux.dev>; Tue, 20 Jan 2026 15:35:17 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 434A71800665;
	Tue, 20 Jan 2026 15:35:16 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH vv6.19-rc6 1/7] dlm: fix recovery pending middle conversion
Date: Tue, 20 Jan 2026 10:35:05 -0500
Message-ID: <20260120153511.2201392-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GCIIal3h9p8CPod-gWHj1PmkX70P21enVud6tjVaE8k_1768923318
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

A workload involving PR <-> CW conversions and triggering recovery can
end in a so named "conversion deadlock" situation that is signaled by
"dlm: WARN: pending deadlock 1e node 0 2 1bf21" in the kernel log.

Under normal circumstances such conversion deadlocks are solved
immediately, in this case recovery created such scenario that was not
solved immediately. This scenario that two locks ending up on the
convertqueue with the conversion PR -> CW. In normal circumstances one
of the conversion will be rejected with -DEADLK as CW cannot be granted
when one lock is helding still PR. Usually one of those conversion will
immediately rejected and the rejected conversion need to convert to a
compatible lock mode. If such situation is created on the convertqueue
we don't solve such conversion in the expected way by the user.

The situation is created by recovery when a pending middle conversion
will be recovered and signaled by:

receive_rcom_lock_args 2e middle convert gr 3 rq 2 remote 2 1e

In this case recovery will remove waiting for the pending message and
force the lock being on the convertqueue without checking if there
is another incompatible conversion going on like PR -> CW which was the
case as the mentioned above "WARN pending deadlock ..." occurs.

This state is difficult to reproduce as it is requires a pending PR ->
CW conversion, however we automated a test scenario that fences randomly
on PR -> CW conversion and we was able to hit it.

The proposed change in this patch changes to not "force" putting the
pending middle conversion on the convertqueue and just handle it like
every other message to resend it later to the new lock master. To using
the existing convert functionality we will immediately reject such
conversion if a incompatible mode on the convertqueue is detected.

Long run with the automated randomly middle conversion test showed so
far we don't run into a "WARN: pending deadlock ..." situation again.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index be938fdf17d96..c01a291db401b 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -5014,25 +5014,8 @@ void dlm_receive_buffer(const union dlm_packet *p, int nodeid)
 static void recover_convert_waiter(struct dlm_ls *ls, struct dlm_lkb *lkb,
 				   struct dlm_message *ms_local)
 {
-	if (middle_conversion(lkb)) {
-		log_rinfo(ls, "%s %x middle convert in progress", __func__,
-			 lkb->lkb_id);
-
-		/* We sent this lock to the new master. The new master will
-		 * tell us when it's granted.  We no longer need a reply, so
-		 * use a fake reply to put the lkb into the right state.
-		 */
-		hold_lkb(lkb);
-		memset(ms_local, 0, sizeof(struct dlm_message));
-		ms_local->m_type = cpu_to_le32(DLM_MSG_CONVERT_REPLY);
-		ms_local->m_result = cpu_to_le32(to_dlm_errno(-EINPROGRESS));
-		ms_local->m_header.h_nodeid = cpu_to_le32(lkb->lkb_nodeid);
-		_receive_convert_reply(lkb, ms_local, true);
-		unhold_lkb(lkb);
-
-	} else if (lkb->lkb_rqmode >= lkb->lkb_grmode) {
+	if (middle_conversion(lkb) || lkb->lkb_rqmode >= lkb->lkb_grmode)
 		set_bit(DLM_IFL_RESEND_BIT, &lkb->lkb_iflags);
-	}
 
 	/* lkb->lkb_rqmode < lkb->lkb_grmode shouldn't happen since down
 	   conversions are async; there's no reply from the remote master */
-- 
2.43.0


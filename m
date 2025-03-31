Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ECC1C32FF
	for <gfs2@lists.linux.dev>; Mon, 31 Mar 2025 23:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743462222; cv=none; b=ObaEVsDC8YqnMzclDoMwXQeR1WwNBUqem1yCQUQaOXgSOAALk171UQ2/ZDkp/UVtZxPnv2Ab8ZZYhtLRyoXCJsz8Z6EwEMUmjYhR09P6j9Jz10O/tBQslD4uuCxmknZNzBfiJwHf9VInc59VK9KULvhe/Nskuay7VKseF2EH1ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743462222; c=relaxed/simple;
	bh=7XDEm3xnBMabMie0X+xQgILFf2Y46w1GaIYi4jDRVmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CPUhbV4COh2nm8q2Tfv3D9f5z23WFShadDZOBkVUbx9r//m6yG5swf2fuwQlBIwXzOdiWfHNWjRNCV9ZMgV5zMO59KF5mISqy3o3FMhBX7CbnQpBCjD4bcqD4e/JywBnbIc0YcNvMcPKN5C+UKj7sBQfUnycVuAq0aXuVWZG0vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TgaPMSvN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TgaPMSvN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743462218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Zt6kHulVIbJ3+AveafgybtfOEriW75akq2NhkMrNTrI=;
	b=TgaPMSvNVSSdjre//2mFcXLA08ZCvVZdLfm+Lea43gEY1Jb9Xp94IF9TwytakB2cgE+FN2
	1OoevoC+DtJYN3zAarpiTSw1fhPfXhJ2biMOG5ADqFhNA8xqgEiLQb+w5rmrBQgg30czDC
	bKHGXk8NefJXU/jJ6g0zPZDqG5hIVr4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-2CXXsHeKOKGrbEFlm0lUGg-1; Mon,
 31 Mar 2025 19:03:35 -0400
X-MC-Unique: 2CXXsHeKOKGrbEFlm0lUGg-1
X-Mimecast-MFC-AGG-ID: 2CXXsHeKOKGrbEFlm0lUGg_1743462214
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E889E1955BC9;
	Mon, 31 Mar 2025 23:03:33 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E0F9F180B488;
	Mon, 31 Mar 2025 23:03:32 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: agruenba@redhat.com
Cc: stable@vger.kernel.org,
	gfs2@lists.linux.dev,
	david.laight.linux@gmail.com,
	aahringo@redhat.com
Subject: [PATCHv2 gfs2/for-next] gfs2: move msleep to sleepable context
Date: Mon, 31 Mar 2025 19:03:24 -0400
Message-ID: <20250331230324.1266587-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This patch moves the msleep_interruptible() out of the non-sleepable
context by moving the ls->ls_recover_spin spinlock around so
msleep_interruptible() will be called in a sleepable context.

Cc: stable@vger.kernel.org
Fixes: 4a7727725dc7 ("GFS2: Fix recovery issues for spectators")
Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
changes since v2:
 - move the spinlock around to avoid schedule under spinlock

 fs/gfs2/lock_dlm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index 58aeeae7ed8c..2c9172dd41e7 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -996,14 +996,15 @@ static int control_mount(struct gfs2_sbd *sdp)
 		if (sdp->sd_args.ar_spectator) {
 			fs_info(sdp, "Recovery is required. Waiting for a "
 				"non-spectator to mount.\n");
+			spin_unlock(&ls->ls_recover_spin);
 			msleep_interruptible(1000);
 		} else {
 			fs_info(sdp, "control_mount wait1 block %u start %u "
 				"mount %u lvb %u flags %lx\n", block_gen,
 				start_gen, mount_gen, lvb_gen,
 				ls->ls_recover_flags);
+			spin_unlock(&ls->ls_recover_spin);
 		}
-		spin_unlock(&ls->ls_recover_spin);
 		goto restart;
 	}
 
-- 
2.43.0


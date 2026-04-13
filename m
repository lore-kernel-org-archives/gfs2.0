Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E767D3E0239
	for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776091958; cv=none; b=lRbyG9WGmDi9IatPFEMqAYxB+phllIshXXrAjrMZj+qqV8A72sAaPcsw9DuoGFSI9cu7XjAny9RmtckQOMvU53pP2/LQgJZYz05CYdGxDxXrIyr4a30+nKxppVEA0SmRI1tENarhx+ryk4771DuhUuM0koqb3Ivvdy31XKx2ngk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776091958; c=relaxed/simple;
	bh=SLgcwqylLIqFTSoMLpBDNOe2GqsU3ZwyyRXXT3T/TeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=RX5Y16EqEL/fm2cC9GL0NT9N6nFr4IBMJQsZp4wJhk1EAOo/vX7drelZyKLwLNgd7uG0ni+85o7DmKY0FDpltS9FXiTSuPWVRE+WnLBEdy6zLoFiPcgfdwGWNokkP+O7E4QUqxt24hb7VVtCLoRrPPo7J3aKi4E/6COfKJEqiFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MYTQEJaj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MYTQEJaj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776091956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P2/kvD3d1HDE7uzjfEjxYkY6GcEMELT4SquULmOIS/c=;
	b=MYTQEJajQ2zn84C6ySEc+1x+WnYeITrkKOfv9LqxSSd3aXKk428JnElZkUrPPRZA3NIz9i
	pFiyZFOEnIF8oLGiIJkGOs5GV/wVfcbert6aruejMptOaiuYBDg9J2qGpQUcSheRlXLmZx
	vvRPQUGGTVxOel4z0Xqodh9J7R948l4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-Wg4FdAyDN2SW47jtqrzDgg-1; Mon,
 13 Apr 2026 10:52:31 -0400
X-MC-Unique: Wg4FdAyDN2SW47jtqrzDgg-1
X-Mimecast-MFC-AGG-ID: Wg4FdAyDN2SW47jtqrzDgg_1776091951
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E0683180035C
	for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 14:52:30 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.156])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DD15819560AB;
	Mon, 13 Apr 2026 14:52:29 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 11/18] gfs2: drain ail under sd_log_flush_lock
Date: Mon, 13 Apr 2026 16:52:04 +0200
Message-ID: <20260413145211.881752-12-agruenba@redhat.com>
In-Reply-To: <20260413145211.881752-1-agruenba@redhat.com>
References: <20260413145211.881752-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tX1ytcAEwKpV_cK3_WfgHm9jKdRxOnKkrWuKRB3Yg0U_1776091951
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When a withdraw is carried out, call gfs2_ail_drain() under the
sdp->sd_log_flush_lock.  This isn't strictly necessary but should be easier to
read, and more robust against possible future bugs.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/util.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index 02603200846d..83b8bb6446e5 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -123,9 +123,8 @@ static void do_withdraw(struct gfs2_sbd *sdp)
 		return;
 	}
 	clear_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags);
-	up_write(&sdp->sd_log_flush_lock);
-
 	gfs2_ail_drain(sdp); /* frees all transactions */
+	up_write(&sdp->sd_log_flush_lock);
 
 	wake_up(&sdp->sd_logd_waitq);
 	wake_up(&sdp->sd_quota_wait);
-- 
2.53.0


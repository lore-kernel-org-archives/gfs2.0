Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCBE27F747
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599058; cv=none; b=p3Yaf1mxCuiRn1uJkPZqiZai7kig7LFEsKE+ZZCpAUmMRUhZ/B2SaUbsiNvS2i8ciPmwBqWxOdLnsSWvdCTauApihghsJaG67cvEuVoMx6QEWiseYlYVX6pVfUa0tAPkKTVht4GSkoxTJyGX3bWOYY3MmD3WlUQSRqaK+EqIDXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599058; c=relaxed/simple;
	bh=spB/E6WHNGMCvz2PguuyTI0/DyMky9BCYhOmCFDcWvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Oy2862MCaFjlESbsE1vdvkVBOlNEX2P3VKqVSBmUzl/ZnZx3eJMh5SE4IXKkly0S+1TrYgtTmUhHiGTI1WUW/PnYMsOfoTDs3m0VLPdVLtx+vwJcIuOp6x/EYsYJjOHx3C9zMRufDyDgty5UggKhMIk9c4SnpaxgeZ7kmB2Qr9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XXnmjWLg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XXnmjWLg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757599055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqV8xWgyMgutYKxb9eHxZGcK5u8l6aO4JQD5c/lxyCs=;
	b=XXnmjWLge/cOTa4EirJO8l5Bxo+5Ink8GnY5F5kjS7xjWsdV3cWhUhakOuK8p2vVDDwa4o
	ZIC93zBKMITmiN6uUoec7rfxM5exABxPjBEkIQPNHtoljmHqL2Uv89K3utpm67249O18LB
	yibU8ckBpMPEn8jkRvp6KR8EkPc++Oo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-5fLzkcVePsSqrJgzXYB5Ow-1; Thu,
 11 Sep 2025 09:57:33 -0400
X-MC-Unique: 5fLzkcVePsSqrJgzXYB5Ow-1
X-Mimecast-MFC-AGG-ID: 5fLzkcVePsSqrJgzXYB5Ow_1757599052
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 865B41800366
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:57:32 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.31])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 51BBB19560B1;
	Thu, 11 Sep 2025 13:57:30 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 02/20] gfs2: Remove unused sd_withdraw_wait field
Date: Thu, 11 Sep 2025 15:57:07 +0200
Message-ID: <20250911135726.657575-3-agruenba@redhat.com>
In-Reply-To: <20250911135726.657575-1-agruenba@redhat.com>
References: <20250911135726.657575-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PYowz3Hp8OKVWN1YYMu74DqvVWv8pC6ey2m_CQKZNNQ_1757599052
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This field was introduced in commit 601ef0d52e96 ("gfs2: Force withdraw
to replay journals and wait for it to finish") and never used.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/incore.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index e3a8a28acb99..78a00239e384 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -822,7 +822,6 @@ struct gfs2_sbd {
 	atomic_t sd_log_in_flight;
 	wait_queue_head_t sd_log_flush_wait;
 	int sd_log_error; /* First log error */
-	wait_queue_head_t sd_withdraw_wait;
 
 	unsigned int sd_log_tail;
 	unsigned int sd_log_flush_tail;
-- 
2.51.0


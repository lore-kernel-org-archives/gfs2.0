Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE10727F747
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599055; cv=none; b=bzq/+AsWmLFActBbXP8CG6LktWos0cLHDJad/qQUAwpE6BxomNnx1extg0JK1vxHXUP8nKp1a+Ii+WuUY6ipatagVnMN/jMILXkBVU0n9ygrRbR58Nehx2AvIjodC9L157+0HRYF7QjG0mSKT83if89Q57vtMmsOtZseQUa401E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599055; c=relaxed/simple;
	bh=WAMgOltpTG9AnffBTUmrxKtuafwBRSqLGzfllQUwXvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=gfeRt7/Stp2899b5uguc7GRGZKBv9CBZXhG74z8T8zg4jB7GDZspPlZbSrjCqjVU7wKiYOSUo3s7Cand2e1Jk04a5yuh7zKpZX/NkJ2rsYzBTwSnsy+7xALeF/pEPscjHIIsFohBCBI60lVOGHh/VvCOfx1VqDfIRVi40mN79zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OrpLwbo8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OrpLwbo8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757599052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yyB8biRnCVLhYLllajrB/LCvo47NibdhxSAFvh3S/9k=;
	b=OrpLwbo8LQfxbbQ4oWMlv4T+vs+qg9hK9KVMM67BtqHnadH9FgxFhjdJHsx3v48nJ6TMWO
	VHh1bqcsMqQ9j1hLegVcLWNTQrH1h/nb1HXWR5U6sogCH1ilAkQoAasmsNjPr2kuU6gzCP
	kKuggZfq1g0bSW2iZdShFW7Yu1ZrE00=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-EesRSyobNCGbds7f-KrlMA-1; Thu,
 11 Sep 2025 09:57:31 -0400
X-MC-Unique: EesRSyobNCGbds7f-KrlMA-1
X-Mimecast-MFC-AGG-ID: EesRSyobNCGbds7f-KrlMA_1757599050
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94782180045C
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:57:30 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.31])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5741019560B1;
	Thu, 11 Sep 2025 13:57:29 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 01/20] gfs2: Remove unused GIF_FREE_VFS_INODE flag
Date: Thu, 11 Sep 2025 15:57:06 +0200
Message-ID: <20250911135726.657575-2-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: Bf6ectgkPWq7s_PlL886w7kHGhVD0JorVKtZuFx8KOs_1757599050
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Since commit 38552ff676f0 ("gfs2: Fix and clean up create / evict
interaction"), the GIF_FREE_VFS_INODE flag isn't used anymore.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/incore.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index d4ad82f47eee..e3a8a28acb99 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -376,7 +376,6 @@ struct gfs2_glock {
 enum {
 	GIF_QD_LOCKED		= 1,
 	GIF_SW_PAGED		= 3,
-	GIF_FREE_VFS_INODE      = 5,
 	GIF_GLOP_PENDING	= 6,
 };
 
-- 
2.51.0


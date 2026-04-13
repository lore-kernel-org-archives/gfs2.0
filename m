Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A243DDDDD
	for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776091961; cv=none; b=RqFhIJ4bMUnpu/CF/qSucuuGN6MEtb+odB0gw23xouE4Yk1i966wWdKdamyXVFIZuQ1f6W8mUqBd1MEI2JcfWQI627V9Xl0FOaL7PVO0uyXsmtwsAmh3F192N1VPCL9Sva6rRMVEXgObd8r0QCqEC4SHKRqzGJX37+vfkFoSbok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776091961; c=relaxed/simple;
	bh=WlDu/lkBdjhtb/hHbPdDiF30qsc7e6haHoXwFf9h3yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=uNDAKTfhAWwAuWJV8vjeTJw33v1UlFZkzcCBAaTcPwESHA4A0CAr0onnGn01WCgQiPYYY/9AVuOU60i7dlJGaWfAADaLv3p4p+6HfQE5Md0TLa4pA6eMVK1dWXBLowaz8IGjIeT28YJvJz3CgnHEnEuzNn04ofhV8zFoA8Xt7C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FcWbvv6S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FcWbvv6S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776091960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RgXZE03y641KP+NXIMxfrR0GwgDQo2utYEN2HkolrQc=;
	b=FcWbvv6SwvXDYHcsX7MXrXly7+uv83HGBs8vDaWGmlUimg460HcKV6X7lRFGxR2cfaJ/zQ
	RfLHHZ25OndnFKYo46jUaUA8RybGlWSet8wePMopwDBOPc6Kzr8Kyl6FmUzaOZMxh2rMIm
	1xShQmyqzPXUiU37BUa2780oFQMHPvM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-SZmDTWSqO3elpZkfOzpY2Q-1; Mon,
 13 Apr 2026 10:52:38 -0400
X-MC-Unique: SZmDTWSqO3elpZkfOzpY2Q-1
X-Mimecast-MFC-AGG-ID: SZmDTWSqO3elpZkfOzpY2Q_1776091958
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB6BD1800BC1
	for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 14:52:37 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.156])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DF7F819560AB;
	Mon, 13 Apr 2026 14:52:36 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 16/18] gfs2: wait for withdraw earlier during unmount
Date: Mon, 13 Apr 2026 16:52:09 +0200
Message-ID: <20260413145211.881752-17-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 6SFR_eQKANxnQ_9QIP9ZvwGg0pB_Pfp0g8mDaBkcvNQ_1776091958
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

During an unmount, wait for potential withdraw to complete before calling
gfs2_make_fs_ro().  This will allow gfs2_make_fs_ro() to skip much of its work.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/super.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 83b5bab56377..b0b0bc5c9d20 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -596,6 +596,9 @@ static void gfs2_put_super(struct super_block *sb)
 	}
 	spin_unlock(&sdp->sd_jindex_spin);
 
+	/* Wait for withdraw to complete */
+	flush_work(&sdp->sd_withdraw_work);
+
 	if (!sb_rdonly(sb))
 		gfs2_make_fs_ro(sdp);
 	else {
@@ -605,8 +608,6 @@ static void gfs2_put_super(struct super_block *sb)
 		gfs2_quota_cleanup(sdp);
 	}
 
-	flush_work(&sdp->sd_withdraw_work);
-
 	/*  At this point, we're through modifying the disk  */
 
 	/*  Release stuff  */
-- 
2.53.0


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF99A27F747
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599060; cv=none; b=GZ3/1Ew+MPjZ+/wHskidoKtqqAx82KfE24Uv3EUmIQOwBbTbndmqqME+DL71/9KAa05Kqge7v5eGTGa7T8iGtkESDJ4s/Ixs1T5pU2dCzsNqU5mCJuPG26F8c+xvH29lS69r6XmjysbuDZmhYdImrIQ2snpZ6X/HmAKBZ9UABVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599060; c=relaxed/simple;
	bh=BpieImeuxJb6bgS1DdoslFAKy1Bjm6pTpkHkzat+Jwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=c4WH7TOoH62ojo5TyZ13D9C3VGFlIchSe9137PHnM2RQd4vGL/TrLkqVRaGujno/jwGO+BM6Ou1HtiiYmGA6AlIJxhTode8ZeU/imi8ZQRsdBiBSqMswdwgLdXOxmzGq50P+NfJArld3EUVnxt4zzFi5wk/clxFc/PnhKzQWskk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OJvkXWhg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJvkXWhg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757599056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r492HFCB8mCCKpifybuTBp56f+42rCe5hXXNebWGwIk=;
	b=OJvkXWhg6TV53thJYkRbG1UudMqUcfLssLEWcTJN/+OdK05SMyYOxPj83USHyjUsE5T1sK
	d979RG0kGMp3rUNjXAqrzYgrs0T5beNqNYVvlUVha3WvGSiIYhSvkNGGAkNdKId2Omf6/M
	oO55T35V76z4ZBl8kP1aeF9bR847x9k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-TcmN3hm_M5K4IqiVlSTkBw-1; Thu,
 11 Sep 2025 09:57:35 -0400
X-MC-Unique: TcmN3hm_M5K4IqiVlSTkBw-1
X-Mimecast-MFC-AGG-ID: TcmN3hm_M5K4IqiVlSTkBw_1757599054
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A1C4180034F;
	Thu, 11 Sep 2025 13:57:34 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.31])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2222519560B1;
	Thu, 11 Sep 2025 13:57:32 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 03/20] gfs2: Remove space before newline
Date: Thu, 11 Sep 2025 15:57:08 +0200
Message-ID: <20250911135726.657575-4-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: l8HiIf8QRNErVr7_MzbRu7W7UVNfFY165Fhlt6Q8DXc_1757599054
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Colin Ian King <colin.i.king@gmail.com>

There is an extraneous space before a newline in a fs_err message.
Remove it

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index b6fd1cb17de7..09af1fe12503 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -733,7 +733,7 @@ __acquires(&gl->gl_lockref.lock)
 		 */
 		if (ret) {
 			if (cmpxchg(&sdp->sd_log_error, 0, ret)) {
-				fs_err(sdp, "Error %d syncing glock \n", ret);
+				fs_err(sdp, "Error %d syncing glock\n", ret);
 				gfs2_dump_glock(NULL, gl, true);
 			}
 			spin_lock(&gl->gl_lockref.lock);
-- 
2.51.0


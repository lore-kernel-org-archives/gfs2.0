Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA2927F747
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599078; cv=none; b=eKs5t177/K5CypSavP0tD0XV4PYF1XmhiOmuKvgwq+fswnyRPP6kiERtXi2giJm5u43fH32Zr/dOd2BHHPNMYiklGmUe4RrHURDv1uCWG/PU1oOUnvgJ5bW/YdTrEdehlkSyZQ2CcUctTCas/dx5HUvbWRSgJMxpxSWb7r03USI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599078; c=relaxed/simple;
	bh=KVjCQrRJM9aYqmbP9PO61TnP86J7T42C7Hl3ABPQFQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Zbnzhji69u3AwnuIFFKNYZNhzRbNMN8TbRyfZIcoSOdF8m3TAVepxXMEMeR1YhzM3DYtAocq2P4QiQuOQL3WeN1PnvtlcJdimNoTAGnPXJIehhvQ9Hm955CzXWS6Kpoz/CdgHB00093ShxXdyl5zMmTPCOj2KkwruI9jhCJNSFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IMD5kFQG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMD5kFQG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757599076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=34wlzICWdNuVIXONh/q1r/yveS04qmxI0EhA3Cs8qog=;
	b=IMD5kFQGoaXZOU1lqVE0ck0N8kZtfsxZVC7yO1FMQs6r+y0bFCDBCtlROyGzJEphX0OCyD
	aJozFunlRbnrs8dWrueYVVt3/LMvK2dbY1iNOS3bPijto1vHADASp/DIQfTZ1N7AZ+ohGg
	RY7XpmE6GtnSqRLTj5w4EHKIV4xt44w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-RNUkY8IsMgulCNLRMvBRzA-1; Thu,
 11 Sep 2025 09:57:55 -0400
X-MC-Unique: RNUkY8IsMgulCNLRMvBRzA-1
X-Mimecast-MFC-AGG-ID: RNUkY8IsMgulCNLRMvBRzA_1757599074
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A39D6180048E
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:57:54 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.31])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 654F119560B1;
	Thu, 11 Sep 2025 13:57:53 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 14/20] gfs2: Fix GLF_INVALIDATE_IN_PROGRESS flag clearing in do_xmote
Date: Thu, 11 Sep 2025 15:57:19 +0200
Message-ID: <20250911135726.657575-15-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: jugdf7v5v9E-_Pk6LqTRSJSxaawSXIOZWs8cKwHYKBU_1757599074
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Commit 865cc3e9cc0b ("gfs2: fix a deadlock on withdraw-during-mount")
added a statement to do_xmote() to clear the GLF_INVALIDATE_IN_PROGRESS
flag a second time after it has already been cleared.  Fix that.

Fixes: 865cc3e9cc0b ("gfs2: fix a deadlock on withdraw-during-mount")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 15a90ab8a979..5361a2641cdb 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -797,8 +797,6 @@ __acquires(&gl->gl_lockref.lock)
 			gl->gl_lockref.count++;
 			gfs2_glock_queue_work(gl, GL_GLOCK_DFT_HOLD);
 			return;
-		} else {
-			clear_bit(GLF_INVALIDATE_IN_PROGRESS, &gl->gl_flags);
 		}
 	}
 
-- 
2.51.0


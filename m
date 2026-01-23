Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC891FFC59
	for <gfs2@lists.linux.dev>; Fri, 23 Jan 2026 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769182287; cv=none; b=byX7OoQ0axl6u/ARtJZUelouPeRqgKblO6s6ygyLJZifr6gmgNpsT+LRaAidXQ60HcCcP+mrmTc7/ztZ6sJIYQh6RAU6wQhBghlQ30lZoiju/mqjSMSnPAgN10+hKCMSABVcjZ7KlYk5C9r3jXwK5rD9d8PuC9UjSnjTruIa5UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769182287; c=relaxed/simple;
	bh=FKjHEBO49aKqnePMBWRGZMTa0/3nPOa3U2gRaOoHUe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Y//9GhmseQgulMpWAUlU3ppGmAgvyvMhlqohwyaNSSJV95POgrGqL8XlI8HH2frKadoz4FB5XfBd6bCeMX6m3/6vTzOhxchm9yMrRJye0GP3VrtqFpqejQtDiP/qaH2KSk9uR0RUXiIhTy6Ds13FcCaaWolDd7ZBK87wjSotvq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OTEsR2Vg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OTEsR2Vg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769182284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SpfUbJtFBxMYh4Ett23Mdz0J7FU98Kdl5JxdcY7VBK0=;
	b=OTEsR2VgpaaRHjy7NUT5kASvg3W1mY3jqxN+uROuCSTrzbvoONeonlWAHZ4DCY19jW5j9u
	9m6NE743VvlCMpZgkaDBxcEMOWpWFiJxI8KJI0sQY8tbn6wFFktHYQNA4Vr7doqKucslZ2
	YzV5BPgK3gSjMdNqxCfDBgFbEOATVjU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-jPhHHmdrMlCPTn8qh9Gd0Q-1; Fri,
 23 Jan 2026 10:31:23 -0500
X-MC-Unique: jPhHHmdrMlCPTn8qh9Gd0Q-1
X-Mimecast-MFC-AGG-ID: jPhHHmdrMlCPTn8qh9Gd0Q_1769182282
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D71218002C5
	for <gfs2@lists.linux.dev>; Fri, 23 Jan 2026 15:31:22 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.52])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9FFAE30002D1;
	Fri, 23 Jan 2026 15:31:21 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 10/13] gfs: Use fixed GL_GLOCK_MIN_HOLD time
Date: Fri, 23 Jan 2026 16:31:00 +0100
Message-ID: <20260123153105.797382-11-agruenba@redhat.com>
In-Reply-To: <20260123153105.797382-1-agruenba@redhat.com>
References: <20260123153105.797382-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9nmno8nDWc1MpqF7CSpJHbyv5BX7jITYw2NoYMjeXjM_1769182282
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

GL_GLOCK_MIN_HOLD represents the minimum time (in jiffies) that a glock
should be held before being eligible for release.  It is currently
defined as 10, meaning that the duration depends on the timer interrupt
frequency (CONFIG_HZ).  Change that time to a constant 10ms independent
of CONFIG_HZ.  On CONFIG_HZ=1000 systems, the value remains the same.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/glock.h b/fs/gfs2/glock.h
index dccbf36b8cb1..26f967aa0e99 100644
--- a/fs/gfs2/glock.h
+++ b/fs/gfs2/glock.h
@@ -126,7 +126,7 @@ enum {
 
 #define GL_GLOCK_MAX_HOLD        (long)(HZ / 5)
 #define GL_GLOCK_DFT_HOLD        (long)(HZ / 5)
-#define GL_GLOCK_MIN_HOLD        (long)(10)
+#define GL_GLOCK_MIN_HOLD        (long)(HZ / 100)
 #define GL_GLOCK_HOLD_INCR       (long)(HZ / 20)
 #define GL_GLOCK_HOLD_DECR       (long)(HZ / 40)
 
-- 
2.52.0


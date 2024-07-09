Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB0318A932
	for <gfs2@lists.linux.dev>; Tue,  9 Jul 2024 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720533417; cv=none; b=Fna9GC18aaNG8vuM/5xkQ7mmOatasd6HSmzOz4Ftgmy1L+WS/JDMJTFISAEMsK/o+yvwOLkbNO9vGR23HJH/HuNE/ynDTPOXI57cUnhNQcuSo39WDNzn/xjy1l+KmKb93m3J3v/4MhP2YFbNPzOMiVO3fe3JF8WciJ1L+Sz449o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720533417; c=relaxed/simple;
	bh=ndc/MQAgz/VBpmEiDtJ/xVS3tWuAoFNOy7XpvWzk2SU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=smkouJnT/4HrDK4yPnQ0kjXPriyEHEGiHolgIOF5TlcmKsGKsM4mCVk9E9cTpUbS+Pe9qRYA4a6vcOfhOKfICO1LhLI6MLY5e1rtjdO7PJyYAjtYdTx6ssidLdRowaTMPmoeUOpT/byEhf2qeLV+QjEmIxf2bQvR2GQyG+lhg8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XLUuGfJL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XLUuGfJL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720533415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ca88xXkuQWO9sx7DbKYb9vv5SbyC+c+3trt0eZS9DCo=;
	b=XLUuGfJLCKKjhXxkTyNbZykJOpnWM17VoysK4JJpV9Kbj/GRLD5yuKSlbxq8qDmfwZimAO
	QJxG+ujPFNk0tLhFHK5bR9lbDEfPSQhJKXTRhZVZM7HDspssirNgWLf8Y06stsEYv4BD/v
	qoWGdwzEGbXU280jpL8HacA4Ga0itjc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-oJ_aO2OtNFGpOaMt6vUjKQ-1; Tue,
 09 Jul 2024 09:56:53 -0400
X-MC-Unique: oJ_aO2OtNFGpOaMt6vUjKQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3DFC18EB187
	for <gfs2@lists.linux.dev>; Tue,  9 Jul 2024 13:56:47 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.226.14])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D622B1955E7F;
	Tue,  9 Jul 2024 13:56:41 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] gfs2: Clean up glock demote logic
Date: Tue,  9 Jul 2024 15:56:40 +0200
Message-ID: <20240709135640.32362-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The logic for determining when to demote a glock in glock_work_func(),
introduced in commit 7cf8dcd3b68a ("GFS2: Automatically adjust glock min
hold time"), doesn't make sense: inode glocks have a minimum hold time
that delays demotion, while all other glocks are expected to be demoted
immediately.  Instead of demoting non-inode glocks immediately,
glock_work_func() schedules glock work for them to be demoted, however.
Get rid of that unnecessary indirection.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 7f68e3d217e6..12a769077ea0 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1091,11 +1091,13 @@ static void glock_work_func(struct work_struct *work)
 	if (test_bit(GLF_PENDING_DEMOTE, &gl->gl_flags) &&
 	    gl->gl_state != LM_ST_UNLOCKED &&
 	    gl->gl_demote_state != LM_ST_EXCLUSIVE) {
-		unsigned long holdtime, now = jiffies;
+		if (gl->gl_name.ln_type == LM_TYPE_INODE) {
+			unsigned long holdtime, now = jiffies;
 
-		holdtime = gl->gl_tchange + gl->gl_hold_time;
-		if (time_before(now, holdtime))
-			delay = holdtime - now;
+			holdtime = gl->gl_tchange + gl->gl_hold_time;
+			if (time_before(now, holdtime))
+				delay = holdtime - now;
+		}
 
 		if (!delay) {
 			clear_bit(GLF_PENDING_DEMOTE, &gl->gl_flags);
@@ -1106,8 +1108,6 @@ static void glock_work_func(struct work_struct *work)
 	if (delay) {
 		/* Keep one glock reference for the work we requeue. */
 		drop_refs--;
-		if (gl->gl_name.ln_type != LM_TYPE_INODE)
-			delay = 0;
 		gfs2_glock_queue_work(gl, delay);
 	}
 
-- 
2.45.2


Received: from forward204d.mail.yandex.net (forward204d.mail.yandex.net [178.154.239.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC0F4315A
	for <gfs2@lists.linux.dev>; Tue, 14 Apr 2026 16:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776183554; cv=none; b=MQmrIOdBrn5wec+EKLRw/c3PFfmVVz9YyiqTdkA9WGWiqVFiabBuy6kqpjtmhayZvszz7Hj1FztsKiST3Kq0VeiEJPAGLr59309FwSJ1VE+hDk8OAgi6/pMiG0jF3K6KuusedTrPXxRxtmcQWM9HhsmGPzr7X9mOZmmt/rQe/mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776183554; c=relaxed/simple;
	bh=nQlwfmuDoldyr+XJfJT1XJVthyxQmJJP2XA6v1HFGb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N7+NxymIzmXBViMUAkTzePbAtX7FzUvpW0qAx+qylsHNsXgMjtJU91HfY746o7xQob2/aTmyvW7pKYS3aUqkeAVnSYh+bMYBfouyGemvOaC3ziRAagfwEKmGl6E+Fcq6J+RHbY5/5Tt4wPHYUkyl5kAjzSldXMqHLS/enJjCaMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=C7Jyh42q; arc=none smtp.client-ip=178.154.239.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="C7Jyh42q"
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d101])
	by forward204d.mail.yandex.net (Yandex) with ESMTPS id E092B87B4F
	for <gfs2@lists.linux.dev>; Tue, 14 Apr 2026 19:19:06 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:2646:0:640:add0:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id F15BCC004A;
	Tue, 14 Apr 2026 19:18:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id lIO02G3S6Cg0-bXaZUNMc;
	Tue, 14 Apr 2026 19:18:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1776183538; bh=E6a+1RGZQe2ALLwYoJZ/0O44zvlsSlIJIiTjC046SNQ=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=C7Jyh42q7MgEFXMnKjrewle7li7DXNYykPqAdAnOEIfmFMYdV7MUM0zu3RJkY5MNI
	 HD42NXNawxa9ph+blU0t58VZkOBRpfV1Qgl7tygOVd+xUaIFrsyqg61GVxjThzRqPk
	 7xTX2qwaozpnWbt3BLjw0tZPRlvzROqGWQerjFDs=
Authentication-Results: mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Nikolai Kuznetsov <niku.csmsu@yandex.ru>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Nikolai Kuznetsov <niku.csmsu@yandex.ru>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] gfs2: Remove unnecessary sd_jdesc NULL check
Date: Tue, 14 Apr 2026 19:17:49 +0300
Message-ID: <20260414161751.10012-1-niku.csmsu@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 35264909e9d1 ("gfs2: Fix NULL pointer dereference in
gfs2_log_flush") added an explicit NULL check for sd_jdesc
to avoid a race with unmount.

Note that the explicit NULL check alone was insufficient, as other
functions e.g. log_distance() still dereference sd_jdesc.

However, gfs2_log_flush() checks for SDF_JOURNAL_LIVE bit and bails
out if it's not set. During unmount this bit is cleared in final
shutdown flush which is called in gfs2_make_fs_ro().

Filesystem becomes RO firstly and only then sd_jdesc is assigned
NULL in gfs2_jindex_free(), so the race is not possible. The
explicit check is redundant, remove it.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 35264909e9d1 ("gfs2: Fix NULL pointer dereference in gfs2_log_flush")
Fixes: 74b4dbb94606 ("gfs2: prevent NULL pointer dereference during unmount")
Signed-off-by: Nikolai Kuznetsov <niku.csmsu@yandex.ru>
---
 fs/gfs2/log.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 78bba8cc10b8..0b91f3e0928a 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -467,7 +467,7 @@ void gfs2_log_release(struct gfs2_sbd *sdp, unsigned int blks)
 {
 	atomic_add(blks, &sdp->sd_log_blks_free);
 	trace_gfs2_log_blocks(sdp, blks);
-	gfs2_assert_withdraw(sdp, !sdp->sd_jdesc ||
+	gfs2_assert_withdraw(sdp,
 			atomic_read(&sdp->sd_log_blks_free) <=
 			sdp->sd_jdesc->jd_blocks);
 	if (atomic_read(&sdp->sd_log_blks_needed))
@@ -1137,8 +1137,9 @@ static void __gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl,
 	lops_before_commit(sdp, tr);
 	if (gfs2_withdrawn(sdp))
 		goto out_withdraw;
-	if (sdp->sd_jdesc)
-		gfs2_log_submit_write(&sdp->sd_jdesc->jd_log_bio);
+
+	gfs2_log_submit_write(&sdp->sd_jdesc->jd_log_bio);
+
 	if (gfs2_withdrawn(sdp))
 		goto out_withdraw;
 
-- 
2.43.0


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067E448422C
	for <gfs2@lists.linux.dev>; Tue,  1 Sep 2026 17:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284847; cv=none; b=LaxA38R31x4Br56MowEH40Z/Y+fxmMCqsMY6cw2wfiNrMHVlj0yGyS2sN3bMuYkzwrjRc948wCRpeNk+PjfELVcd6NMokkPpanvi6kmhkDQiunSPCQkGY+j3ndO0fp9DLgtgYtfbwxxNwXrEH7z4g/asDSt06S8l17cKt6uLDYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284847; c=relaxed/simple;
	bh=Rd3ZRZG+5xHpsq+qs9jqfdAbAUvBng154wEzMkHv3wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b5lMI6lR+zyVHAl1SQpRO9yLHvRqQJpCJiBlL7pFIz6VNzNDdUJp9vjFIzyhGVHCm+jwS+U9Jmm8jCxmIp0cRZf15akCwTF46JIgK8qHHQh/ciyzuxIFqersQ1fsbgdl7EiJnMDzTHVh98DnA4JTz+Z0LWgWTtL/2Xx3wXw3u1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=glx+SvfG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="glx+SvfG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788284844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6DpjiVhN2ZQy/6t/AfvFIOh7rwgPJd5/RwYeKIAIoH4=;
	b=glx+SvfGbWJOS1NmOcjSXB5vQCfe0a9MyyXCKSjvTE7TK2OHsovzVMl8n6nGiWZWscIayh
	Q3Z0EL5K7kzG/o4w4IbnOxKYsf2La8MecckXoO3BumHrzNeV/zemJWsw3a/BSsIL1NIuVU
	YfGUMIRpRhmSZjy1FcMqP2h7M8/46xc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-g48qRzC4OgCas-IcxHKnEg-1; Tue,
 01 Sept 2026 13:47:23 -0400
X-MC-Unique: g48qRzC4OgCas-IcxHKnEg-1
X-Mimecast-MFC-AGG-ID: g48qRzC4OgCas-IcxHKnEg_1788284842
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8AAD01944DCF
	for <gfs2@lists.linux.dev>; Tue,  1 Sep 2026 17:47:22 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 190D218005BD;
	Tue,  1 Sep 2026 17:47:22 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH RESEND dlm/next 2/8] dlm: require CAP_SYS_ADMIN for dlm-monitor device
Date: Tue,  1 Sep 2026 13:47:09 -0400
Message-ID: <20260901174715.3825582-3-aahringo@redhat.com>
In-Reply-To: <20260901174715.3825582-1-aahringo@redhat.com>
References: <20260901174715.3825582-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kzZza9o9AkRs-Re4VOqAAJq1UDCkSIsegQYV7FxgNnQ_1788284842
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Haofeng Li <lihaofeng@kylinos.cn>

monitor_device_open() in fs/dlm/user.c performs only
atomic_inc(&dlm_monitor_opened) and sets dlm_monitor_unused = 0; it
does no capability check.  monitor_device_close() does
atomic_dec_and_test(&dlm_monitor_opened) and, when the count reaches
zero, calls dlm_stop_lockspaces() — which stops every lockspace on
the node.  The miscdevice is also registered with no .mode field.

Attack chain (when the device node is reachable by an unprivileged
opener — see mitigation note below):

  1. attacker open("/dev/dlm-monitor") with no cap check; the
     global counter goes 0 -> 1
  2. attacker close(fd); atomic_dec_and_test reaches zero again
     and dlm_stop_lockspaces() runs -> every DLM lockspace on the
     local node is stopped.  Other cluster members then observe
     the node losing its lockspaces (membership / recovery side
     effects), so the impact is not strictly local to GFS2 /
     OCFS2 / lvmlockd / cluster-md workloads on this node.
  variant: attacker holds the fd open indefinitely to suppress
     the intended stop when dlm_controld later closes its own fd
     (inverse abuse — recovery / shutdown stalls)

Mitigation: devtmpfs creates /dev/dlm-monitor as 0600 root:root on
a stock kernel, so unprivileged open is blocked by the node mode,
not by a kernel cap check.  The gap is real wherever the node is
reachable (udev MODE=0666, container bind-mount, fd via SCM_RIGHTS,
or any setup where dlm_controld shares its monitor fd).

Reproduction (kernel 7.2.0-rc3, dlm loaded, no live lockspace):

  # ./exploit_h3   # as root
  [*] lockspace devices present: 0
  [!!!] AUTH BYPASS: opened /dev/dlm-monitor, no cap check (fd=3)
  [VULNERABLE] monitor open auth bypass demonstrated

  $ setpriv --reuid 65534 --regid 65534 ./exploit_h3
  [OK ] open denied: Permission denied   # node 0600, not cap check

The destructive close path is opt-in in the PoX
(--i-know-it-stops-lockspaces); we did not drive it here.  Driving
the close path on a node with active lockspaces would stop them;
on this throw-away node there are none, but we keep the opt-in gate
so the same PoX is safe to re-run on production-like clusters.

Fix: gate monitor_device_open() on capable(CAP_SYS_ADMIN) and set
.mode = 0600 on monitor_device, matching the dlm_controld-only
intended usage.

Acked-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: Haofeng Li <lihaofeng@kylinos.cn>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/user.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/dlm/user.c b/fs/dlm/user.c
index a8ed4c8fdc5bd..cd7e142ca670d 100644
--- a/fs/dlm/user.c
+++ b/fs/dlm/user.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/miscdevice.h>
+#include <linux/capability.h>
 #include <linux/init.h>
 #include <linux/wait.h>
 #include <linux/file.h>
@@ -910,6 +911,10 @@ static int ctl_device_close(struct inode *inode, struct file *file)
 
 static int monitor_device_open(struct inode *inode, struct file *file)
 {
+	/* dlm_controld is the only expected opener; last close stops LS. */
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
 	atomic_inc(&dlm_monitor_opened);
 	dlm_monitor_unused = 0;
 	return 0;
@@ -958,6 +963,7 @@ static struct miscdevice monitor_device = {
 	.name  = "dlm-monitor",
 	.fops  = &monitor_device_fops,
 	.minor = MISC_DYNAMIC_MINOR,
+	.mode  = 0600,
 };
 
 int __init dlm_user_init(void)
-- 
2.43.0


Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CC63AFAED
	for <gfs2@lists.linux.dev>; Thu, 16 Jul 2026 07:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186527; cv=none; b=iPvQ6ZCIZbuQ1mnNpWVJt0j/L4znEGRSq4j+8G+q/aY92mF1bgt+i5Q2R1nEyHGLJn1o+/zjGVuJ2wyF792ilPaQgf1tknT1iiIJQ3FgtFb4TmkBXvszi7GscuIMyocWZoEU7Ts9UQy6C/ODqw1YlsBdW0Aobo9vmUDZSe5qc1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186527; c=relaxed/simple;
	bh=qizhEZaqPEQFBRoCJ2kjVTe4C6XQZBS8qGx5Db+TomI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iWdCHykKMUs5qRzWzlw9JuH2wangHjRI7567v7Vx/IHU2IK3wxuKhwmMc4xWQ9e+J9bIgjBAci8AU5n+eb63y9hKNiBhfUhtLeMqxidWo2VE8WCoEOIXnWRMU9Zqd1TvfHvPmfzF0pWYpo7OZrZ2ngWyY8vHk17asVPhGMvpmIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 072d4c2e80e711f1aa26b74ffac11d73-20260716
X-CID-CACHE: Type:Local,Time:202607161511+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:790099af-de38-4e23-bd3a-d8d38218dcfe,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:5026b3d9e88eb68b1fa06eb1c6f46296,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|865|898,TC:nil,Content:0|1
	5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 072d4c2e80e711f1aa26b74ffac11d73-20260716
X-User: lihaofeng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lihaofeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 694100958; Thu, 16 Jul 2026 15:21:57 +0800
From: Haofeng Li <lihaofeng@kylinos.cn>
To: aahringo@redhat.com,
	teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Haofeng Li <13266079573@163.com>,
	Haofeng Li <lihaofeng@kylinos.cn>
Subject: [PATCH 2/2] dlm: require CAP_SYS_ADMIN for dlm-monitor device
Date: Thu, 16 Jul 2026 15:21:52 +0800
Message-Id: <20260716072152.326803-3-lihaofeng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260716072152.326803-1-lihaofeng@kylinos.cn>
References: <20260716072152.326803-1-lihaofeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

Signed-off-by: Haofeng Li <lihaofeng@kylinos.cn>
---
 fs/dlm/user.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/dlm/user.c b/fs/dlm/user.c
index a8ed4c8fdc5b..cd7e142ca670 100644
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
2.25.1


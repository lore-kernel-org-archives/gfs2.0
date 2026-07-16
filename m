Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D893AF662
	for <gfs2@lists.linux.dev>; Thu, 16 Jul 2026 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186528; cv=none; b=PqUCZFIgFZbp1JMMyhwoDkY9u6uEjNinAroKRlW5yuZ2EgInwUJA3H2WrYSQ9iJqI/Ar6sq3tvs7POJgqU4PMIIZILsBErIo2RXfYdRdsI/jUpaAd7+XY+QmSmaRXdfuNZ0OUzAhbfbglxf/8r0foNKwcz27/fp4D4zBM82+vb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186528; c=relaxed/simple;
	bh=T9asGJUk/B7ooYJrTYe7NLGzmEhQvhlSajtKOW+pouE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YeEcpXRxrIRNj1eXnZz0tasJz0/lAUz+fA/2lBbpg522aRzYjJEeS1ZrHPQVyR1DMmZmtVOijHPrpGu+0Nmui7xL0lsCmfKf6epDpalw8zlvtZyQ4vBVjaJrABOQ5IfGDThPcfu/ABHoaXj9znQN9MOv1SR9qg77pubNR75+h00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 06e2d68080e711f1aa26b74ffac11d73-20260716
X-CID-CACHE: Type:Local,Time:202607161511+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:d5627d7f-4e89-44bf-97a7-ae01d2013e3c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:b73c612305126364857bceaa785b845b,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|865|898,TC:nil,Content:0|1
	5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 06e2d68080e711f1aa26b74ffac11d73-20260716
X-User: lihaofeng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lihaofeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 364802631; Thu, 16 Jul 2026 15:21:56 +0800
From: Haofeng Li <lihaofeng@kylinos.cn>
To: aahringo@redhat.com,
	teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Haofeng Li <13266079573@163.com>,
	Haofeng Li <lihaofeng@kylinos.cn>
Subject: [PATCH 1/2] dlm: gate dlm_plock device on CAP_SYS_ADMIN
Date: Thu, 16 Jul 2026 15:21:51 +0800
Message-Id: <20260716072152.326803-2-lihaofeng@kylinos.cn>
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

fs/dlm/plock.c registers /dev/dlm_plock via a miscdevice whose
file_operations has no .open callback and whose .mode field is unset.
The kernel therefore performs no capability check on open, and any
process that can open the node becomes an unprivileged plock daemon
with full read+write access to the pending-plock queue.

Attack chain (when the device node is reachable by an unprivileged
opener — see mitigation note below):

  1. attacker open("/dev/dlm_plock") succeeds with no cap check
  2. dev_read() drains pending plock requests straight to user
     space, leaking dlm_plock_info fields: fsid, number (resource
     id / inode), start, end, owner, pid, ex, wait
  3. dev_write() matches an attacker-supplied dlm_plock_info
     against a pending op on recv_list (matched on fsid+number+
     owner+pid+start+end+ex+wait) and memcpy()'s it into the
     in-kernel op, including a forged .rv == 0
  4. when a matched op exists, the forged result is then applied:
     for async ops (op->data != NULL), dlm_plock_callback() runs
     posix_lock_file(); for sync ops, the requester wakes and
     proceeds as if the cluster had granted the lock.  Either way
     the requester ends up holding a POSIX lock without a real DLM
     grant, or sees attacker-chosen rv that breaks lock correctness.
     With no pending op on recv_list, dev_write() still returns
     sizeof(info) but does nothing beyond a pr_debug ("dlm dev_write
     no op ...") — so a syntactically accepted write does not by
     itself prove an applied grant.

Mitigation: on a stock kernel, devtmpfs creates /dev/dlm_plock as
0600 root:root, so steps 1-4 are only reachable where the node is
exposed to a less privileged principal — e.g. udev MODE=0666,
container bind-mount of the node, or an fd passed via SCM_RIGHTS.
The in-kernel capability gap is real regardless of node mode.

Reproduction (kernel 7.2.0-rc3, dlm loaded):

  # ./exploit_h2   # as root
  [*] node /dev/dlm_plock mode=0600 uid=0 gid=0
  [!!!] AUTH BYPASS: opened with no capability check (fd=3)
  [!!!] FORGE ACCEPTED: kernel accepted forged plock result (rv=0);
       pending ops are grant-forgeable
  [VULNERABLE] open + read-leak + grant-forge demonstrated

  The "FORGE ACCEPTED" line means dev_write() returned sizeof(info),
  i.e. the write path is reachable and the version check passed; it
  does not by itself mean a grant was applied.  Demonstrating an
  actual forged grant requires a concurrent plock op on recv_list to
  match against.

  $ setpriv --reuid 65534 --regid 65534 ./exploit_h2
  [OK ] open denied: Permission denied   # devtmpfs 0600,
                                         not a kernel cap check

Fix: add a .open callback that requires CAP_SYS_ADMIN, and set
.mode = 0600 on the miscdevice so the explicit expectation matches
the devtmpfs default and survives future defaults.

Signed-off-by: Haofeng Li <lihaofeng@kylinos.cn>
---
 fs/dlm/plock.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index e9598b3fe5d0..711e8bc3a46a 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/capability.h>
 #include <linux/filelock.h>
 #include <linux/miscdevice.h>
 #include <linux/poll.h>
@@ -477,6 +478,15 @@ int dlm_posix_get(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 }
 EXPORT_SYMBOL_GPL(dlm_posix_get);
 
+static int dev_open(struct inode *inode, struct file *file)
+{
+	/* Userspace plock daemon is a privileged cluster component. */
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	return 0;
+}
+
 /* a read copies out one plock request from the send list */
 static ssize_t dev_read(struct file *file, char __user *u, size_t count,
 			loff_t *ppos)
@@ -598,6 +608,7 @@ static __poll_t dev_poll(struct file *file, poll_table *wait)
 }
 
 static const struct file_operations dev_fops = {
+	.open    = dev_open,
 	.read    = dev_read,
 	.write   = dev_write,
 	.poll    = dev_poll,
@@ -608,7 +619,8 @@ static const struct file_operations dev_fops = {
 static struct miscdevice plock_dev_misc = {
 	.minor = MISC_DYNAMIC_MINOR,
 	.name = DLM_PLOCK_MISC_NAME,
-	.fops = &dev_fops
+	.fops = &dev_fops,
+	.mode = 0600,
 };
 
 int dlm_plock_init(void)
-- 
2.25.1


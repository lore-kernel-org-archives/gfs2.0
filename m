Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0EC48CD52
	for <gfs2@lists.linux.dev>; Tue,  1 Sep 2026 17:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284846; cv=none; b=US+fjnvioop6BdVbanb8RmpkPuOneCsUT1a7cvcBatBPFvF6odooBVEq2NE6J3yiNAcvMKGtXV48RrIfBrxZHq5tYsYhqX68Hk4NW4ApA685ZzI+zO0wIehZFqa4TXkG7zKEAgIE2x7kaLC692vAflWvYRiu8h0NBKTC32Q8AEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284846; c=relaxed/simple;
	bh=GaTCQZCuQM8wSGBo6pu6TWQ+OwUpbHhDPW+prtJ8Sd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mTY2VP20SO4q9CZVpdzN0f0aU2b7EeVMWK1PRs0lvCoPdYeea5quHAbzNiMen/hG7SEGKqKNKPs0HtJ+6/IiFdYH4NtY2BBLr//aUaKymvMR/lX33D3HNDzAJXFKqCTmk0U2a8V6FHqSB/1HX3xHYK/6cbn4DKXgr9jUdh8N4ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZtzeqkIB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZtzeqkIB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788284844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q7wjkWDp2RE25zdhZOvMkmMYJPwJjxYnHgNESZMr27o=;
	b=ZtzeqkIBxh5EQBqr0htRcC+oJwfOUJ5esv9iq+9YzHgdYYuDVainEy+M1n/eSV6eNoM0Fe
	TcBVB+vraLp3u1C09IgJjqkJPBxz02eB8Qy0FHDNk4Xk7nzNkeW/4b/M3uQSp2mTMPPNaz
	aErHMpz9A+6iWhS4+rirxv4xCQyxRyc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-Vln5sjTEPA6Gv1Gj3WSpGg-1; Tue,
 01 Sept 2026 13:47:22 -0400
X-MC-Unique: Vln5sjTEPA6Gv1Gj3WSpGg-1
X-Mimecast-MFC-AGG-ID: Vln5sjTEPA6Gv1Gj3WSpGg_1788284842
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E662C1806D28
	for <gfs2@lists.linux.dev>; Tue,  1 Sep 2026 17:47:21 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 50B941803A5D;
	Tue,  1 Sep 2026 17:47:21 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH RESEND dlm/next 1/8] dlm: gate dlm_plock device on CAP_SYS_ADMIN
Date: Tue,  1 Sep 2026 13:47:08 -0400
Message-ID: <20260901174715.3825582-2-aahringo@redhat.com>
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
X-Mimecast-MFC-PROC-ID: ViZds5kKKSIoO8Okya8CEYO8F92OL3sVFePcKOOaunI_1788284842
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Haofeng Li <lihaofeng@kylinos.cn>

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

Acked-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: Haofeng Li <lihaofeng@kylinos.cn>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/plock.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index e9598b3fe5d09..711e8bc3a46a6 100644
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
2.43.0


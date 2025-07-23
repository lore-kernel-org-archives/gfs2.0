Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CD01C5D46
	for <gfs2@lists.linux.dev>; Wed, 23 Jul 2025 15:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753284715; cv=none; b=p+y6bVNTxpfiooHHFkz96vJuAqjjpkygoCIRVuFn86lK8mm8pOBS+DRjBgjUUSoZDUvd/8oJYDCJFJeWBSCPcLBKS/GaP+fVRSAzRec67vHSWj46V0wduooVk4nVEm/ZabCWxfZDDH8S49NB2Vlof0tJbD6X9Bjo2AoRX8VLqUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753284715; c=relaxed/simple;
	bh=ODAliieRQTAX2TfotFdP26MxM9jdUBV22Perqkz7Kk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=SkA1PyWqZsHzX5KrhuTXYCBEW65eqarMe8NyjywEFb6EKKO+9unpqnVVaqkCzrMNDUqUV1wudxZvzMGBMxjwZI/ELdzv/7DhBYLJ945M76aZv17kGpPe0jIqHPgbtDsnzXjV/3GfjGSyE+yDnRG4zLN67va4qBGWkI9lzfEf7fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O8qUuR9z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O8qUuR9z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753284712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q1W2blzQ8kSCCo8epaMkjDE2VQKQBKbjHzuIsoTMMks=;
	b=O8qUuR9zf1rI4idFZOPIPjBu3gF2AJ/COHiWHmSsBldGKcTWtfRIZQ4s1t1V9eyi9TTYwm
	zaM2apZwkzUw3sFG2tXZThIm+1L0v2fHp6TLy3FFNwK3nG/QRAXZ5eaXUljp/GB0R70amb
	u+PE48nIoTZRn5X2DrznsgyrJ6CLTfY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-qnZuJW1mPqu8lD4zrbTTtA-1; Wed,
 23 Jul 2025 11:31:50 -0400
X-MC-Unique: qnZuJW1mPqu8lD4zrbTTtA-1
X-Mimecast-MFC-AGG-ID: qnZuJW1mPqu8lD4zrbTTtA_1753284710
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19A2E197730A
	for <gfs2@lists.linux.dev>; Wed, 23 Jul 2025 15:31:50 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 555BB30001A4;
	Wed, 23 Jul 2025 15:31:49 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: agruenba@redhat.com,
	gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm-tool] dlm_controld: handle RELEASE_RECOVER event env
Date: Wed, 23 Jul 2025 11:31:44 -0400
Message-ID: <20250723153144.2989172-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4NnzOjR5k9lQCS1dc74U6KfoN2NgO0TZk2-z8gJtyp8_1753284710
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Newer kernels might sending an additional attribute for the leaving lockspace
event "RELEASE_RECOVER" to tell other nodes from the release lockspace
initator to call the recover_slot() callback in their recovery handling
as a membership update triggers in-kernel recovery.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 dlm_controld/action.c     | 33 ++++++++++++++++++
 dlm_controld/cpg.c        | 72 ++++++++++++++++++++++++++++++++++++++-
 dlm_controld/dlm_daemon.h |  6 +++-
 dlm_controld/main.c       |  4 ++-
 4 files changed, 112 insertions(+), 3 deletions(-)

diff --git a/dlm_controld/action.c b/dlm_controld/action.c
index 10f0f673..b73beea9 100644
--- a/dlm_controld/action.c
+++ b/dlm_controld/action.c
@@ -211,6 +211,39 @@ int path_exists(const char *path)
 	return 1;
 }
 
+int set_configfs_member_release_recover(struct lockspace *ls, int id,
+					uint32_t release_recover)
+{
+	char path[PATH_MAX];
+	char buf[32];
+	int fd, rv;
+
+	memset(path, 0, PATH_MAX);
+	snprintf(path, PATH_MAX, "%s/%s/nodes/%d/release_recover",
+		 SPACES_DIR, ls->name, id);
+
+	rv = fd = open(path, O_WRONLY);
+	if (rv < 0) {
+		log_error("%s: open failed: %d", path, errno);
+		goto out;
+	}
+
+	memset(buf, 0, 32);
+	snprintf(buf, 32, "%u", release_recover);
+
+	rv = do_write(fd, buf, strlen(buf));
+	if (rv < 0) {
+		log_error("%s: write failed: %d, %s", path, errno, buf);
+		close(fd);
+		goto out;
+	}
+	close(fd);
+	rv = 0;
+
+out:
+	return rv;
+}
+
 /* The "renew" nodes are those that have left and rejoined since the last
    call to set_members().  We rmdir/mkdir for these nodes so dlm-kernel
    can notice they've left and rejoined. */
diff --git a/dlm_controld/cpg.c b/dlm_controld/cpg.c
index 32aad924..507a5121 100644
--- a/dlm_controld/cpg.c
+++ b/dlm_controld/cpg.c
@@ -1063,6 +1063,23 @@ static void receive_start(struct lockspace *ls, struct dlm_header *hd, int len)
 	memb->start = 1;
 }
 
+static void receive_release_recover(struct lockspace *ls,
+				    struct dlm_header *hd, int len)
+{
+	uint32_t release_recover = hd->msgdata;
+
+	log_dlock(ls, "%s %d: len %d release_recover %u", __func__,
+		  hd->nodeid, len, release_recover);
+
+	if (hd->nodeid == our_nodeid)
+		return;
+
+	/* try to set members release recover setting before removing to
+	 * tell other nodes the release recover option from the initiator.
+	 */
+	set_configfs_member_release_recover(ls, hd->nodeid, release_recover);
+}
+
 static void receive_plocks_done(struct lockspace *ls, struct dlm_header *hd,
 				int len)
 {
@@ -1176,6 +1193,43 @@ static void send_info(struct lockspace *ls, struct change *cg, int type,
 	free(buf);
 }
 
+static void send_release_recover_msg(struct lockspace *ls, int type,
+				     unsigned long release_recover)
+{
+	struct dlm_header *hd;
+	char *buf;
+	int len;
+
+	len = sizeof(struct dlm_header);
+
+	buf = malloc(len);
+	if (!buf) {
+		log_error("send_info len %d no mem", len);
+		return;
+	}
+	memset(buf, 0, len);
+
+	hd = (struct dlm_header *)buf;
+
+	/* fill in header (dlm_send_message handles part of header) */
+
+	hd->type = type;
+	hd->msgdata = release_recover;
+
+	dlm_send_message(ls, buf, len);
+
+	free(buf);
+}
+
+static void send_release_recover(struct lockspace *ls,
+				 unsigned long release_recover)
+{
+	log_group(ls, "%s %d: counts %u release_recover: %ld", __func__,
+		  our_nodeid, ls->started_count, release_recover);
+
+	send_release_recover_msg(ls, DLM_MSG_RELEASE_RECOVER, release_recover);
+}
+
 /* fenced used the DUPLICATE_CG flag instead of sending nacks like we
    do here.  I think the nacks didn't work for fenced for some reason,
    but I don't remember why (possibly because the node blocked doing
@@ -1648,6 +1702,10 @@ static void deliver_cb(cpg_handle_t handle,
 				  hd->type, nodeid, enable_plock);
 		break;
 
+	case DLM_MSG_RELEASE_RECOVER:
+		receive_release_recover(ls, hd, len);
+		break;
+
 #if 0
 	case DLM_MSG_DEADLK_CYCLE_START:
 		if (opt(enable_deadlk))
@@ -1815,12 +1873,24 @@ int dlm_join_lockspace(struct lockspace *ls)
 
 /* received an "offline" uevent from dlm-kernel */
 
-int dlm_leave_lockspace(struct lockspace *ls)
+int dlm_leave_lockspace(struct lockspace *ls, const char *release_recover_str)
 {
 	cs_error_t error;
 	struct cpg_name name;
+	unsigned long release_recover;
 	int i = 0;
 
+	if (release_recover_str) {
+		release_recover = strtoul(release_recover_str, NULL, 0);
+		if (release_recover == ULONG_MAX) {
+			log_error("failed to parse release recover: %s",
+				  release_recover_str);
+			return errno;
+		}
+
+		send_release_recover(ls, release_recover);
+	}
+
 	ls->leaving = 1;
 
 	memset(&name, 0, sizeof(name));
diff --git a/dlm_controld/dlm_daemon.h b/dlm_controld/dlm_daemon.h
index c902228f..95076b44 100644
--- a/dlm_controld/dlm_daemon.h
+++ b/dlm_controld/dlm_daemon.h
@@ -247,6 +247,7 @@ enum {
 	DLM_MSG_RUN_REQUEST,
 	DLM_MSG_RUN_REPLY,
 	DLM_MSG_RUN_CANCEL,
+	DLM_MSG_RELEASE_RECOVER,
 };
 
 /* dlm_header flags */
@@ -381,6 +382,8 @@ int set_sysfs_control(char *name, int val);
 int set_sysfs_event_done(char *name, int val);
 int set_sysfs_id(char *name, uint32_t id);
 int set_sysfs_nodir(char *name, int val);
+int set_configfs_member_release_recover(struct lockspace *ls, int id,
+					uint32_t release_recover);
 int set_configfs_members(struct lockspace *ls, char *name,
 			 int new_count, int *new_members,
 			 int renew_count, int *renew_members);
@@ -405,7 +408,8 @@ void set_opt_online(char *cmd_str, int cmd_len);
 void process_lockspace_changes(void);
 void process_fencing_changes(void);
 int dlm_join_lockspace(struct lockspace *ls);
-int dlm_leave_lockspace(struct lockspace *ls);
+int dlm_leave_lockspace(struct lockspace *ls,
+			const char *release_recover_str);
 void update_flow_control_status(void);
 int set_node_info(struct lockspace *ls, int nodeid, struct dlmc_node *node);
 int set_lockspace_info(struct lockspace *ls, struct dlmc_lockspace *lockspace);
diff --git a/dlm_controld/main.c b/dlm_controld/main.c
index 6fb6dffe..a4beb312 100644
--- a/dlm_controld/main.c
+++ b/dlm_controld/main.c
@@ -50,6 +50,7 @@ enum {
 	Env_DEVPATH,
 	Env_SUBSYSTEM,
 	Env_LOCKSPACE,
+	Env_RELEASE_RECOVER,
 	Env_Last, /* Flag for end of vars */
 };
 
@@ -58,6 +59,7 @@ static const char *uevent_vars[] = {
 	[Env_DEVPATH]		= "DEVPATH=",
 	[Env_SUBSYSTEM]		= "SUBSYSTEM=",
 	[Env_LOCKSPACE]		= "LOCKSPACE=",
+	[Env_RELEASE_RECOVER]	= "RELEASE_RECOVER=",
 };
 
 static void decode_uevent(const char *buf, unsigned len, const char *vars[],
@@ -769,7 +771,7 @@ static void process_uevent(int ci)
 			goto out;
 		}
 
-		dlm_leave_lockspace(ls);
+		dlm_leave_lockspace(ls, uevent_vals[Env_RELEASE_RECOVER]);
 	}
  out:
 	if (rv < 0)
-- 
2.43.0


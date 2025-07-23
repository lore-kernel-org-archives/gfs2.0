Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F942EE97A
	for <gfs2@lists.linux.dev>; Wed, 23 Jul 2025 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753284128; cv=none; b=OY/Lse/LSmW1OpFwbgC4SFtSGdE24sQ2TNL7NStHTHtqk3/6sejlp+Hz3yCPp4fNlPuSkHb4GAcUlDbP2k5bl1i6Qgm38/v39r78ttvOsvI26jjeHFTmUCR6OzHWRYedIbRcnfQvfwXSs5gFD2Nz7+ZgszGODkNReqU8dSotkTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753284128; c=relaxed/simple;
	bh=ZMa21gX//TbbqM1ffZSngCMkK7mJaveE6U8FGgeQJQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=M17p+FzwKj90Tr80IaNY6b8DJIVL6g/V5lNHlfq6RvAGRhfTYKPffsn1+1inNp3hpwwTz/aInMeoKL/3GZjJmGNrLuzFB2bKtR9pNbEY5Kmt80zRWkVlSX+ki0PoVEO4SnU5w09cjwF82lNFactta+EMPt7T/IVkoL2eTWN/VFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aLo6R37F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLo6R37F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753284124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dkbEbZpoWQDYLUTJkPwZOGW815iriUB27ZtYagVuEcQ=;
	b=aLo6R37F35VSKuRTRx+NI8/NZv06M0b4+lVQPxooimo+tJXM2EeL1u6v/pY4RB2MmGzzvm
	MYjF95mtrqLrcXo2xNXHkUkpY/B9VnxR0OOBdw1NF8e8tdtZhrmMWtgRhPCipJAbOf4UZQ
	jGQTTetfzGuI/7mh5ONOaZwbl3Z9wiY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-ywZMEjzyOR6EuD91UtF8kA-1; Wed,
 23 Jul 2025 11:22:03 -0400
X-MC-Unique: ywZMEjzyOR6EuD91UtF8kA-1
X-Mimecast-MFC-AGG-ID: ywZMEjzyOR6EuD91UtF8kA_1753284122
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61CBA1800A33
	for <gfs2@lists.linux.dev>; Wed, 23 Jul 2025 15:22:02 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9A2181955F6B;
	Wed, 23 Jul 2025 15:22:01 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: agruenba@redhat.com,
	gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH v6.16-rc7 3/5] dlm: add release recover attribute for leaving event
Date: Wed, 23 Jul 2025 11:21:54 -0400
Message-ID: <20250723152156.2988833-4-aahringo@redhat.com>
In-Reply-To: <20250723152156.2988833-1-aahringo@redhat.com>
References: <20250723152156.2988833-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: D-OhOtyJF5TylV5zOZrKt1Bu0shdCxPxibTvSqSXVPA_1753284122
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

We add a attribute to the leaving lockspace event to tell the user space
about an option when doing the lockspace release. Later when we
introduce a new release option it can use this feature to set such option.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lockspace.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index be8dbf4822295..6ff666a511c7a 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -186,12 +186,17 @@ static struct kobj_type dlm_ktype = {
 
 static struct kset *dlm_kset;
 
-static int do_uevent(struct dlm_ls *ls, int in)
+static int do_uevent(struct dlm_ls *ls, int in, unsigned int release_recover)
 {
-	if (in)
+	char message[512] = {};
+	char *envp[] = { message, NULL };
+
+	if (in) {
 		kobject_uevent(&ls->ls_kobj, KOBJ_ONLINE);
-	else
-		kobject_uevent(&ls->ls_kobj, KOBJ_OFFLINE);
+	} else {
+		snprintf(message, 511, "RELEASE_RECOVER=%u", release_recover);
+		kobject_uevent_env(&ls->ls_kobj, KOBJ_OFFLINE, envp);
+	}
 
 	log_rinfo(ls, "%s the lockspace group...", in ? "joining" : "leaving");
 
@@ -575,7 +580,7 @@ static int new_lockspace(const char *name, const char *cluster,
 	   current lockspace members are (via configfs) and then tells the
 	   lockspace to start running (via sysfs) in dlm_ls_start(). */
 
-	error = do_uevent(ls, 1);
+	error = do_uevent(ls, 1, 0);
 	if (error < 0)
 		goto out_recoverd;
 
@@ -592,7 +597,7 @@ static int new_lockspace(const char *name, const char *cluster,
 	return 0;
 
  out_members:
-	do_uevent(ls, 0);
+	do_uevent(ls, 0, 0);
 	dlm_clear_members(ls);
 	kfree(ls->ls_node_array);
  out_recoverd:
@@ -733,7 +738,7 @@ static int release_lockspace(struct dlm_ls *ls, int release_option)
 
 	if (release_option != DLM_RELEASE_NO_EVENT &&
 	    dlm_user_daemon_available())
-		do_uevent(ls, 0);
+		do_uevent(ls, 0, 0);
 
 	dlm_recoverd_stop(ls);
 
-- 
2.43.0


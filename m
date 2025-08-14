Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDBD42AB0
	for <gfs2@lists.linux.dev>; Thu, 14 Aug 2025 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184948; cv=none; b=aE+maW0M7/aRC/scH8mzftp8VSM5dsJq1cimigWKWTTRMT+MsGfxSkf7ml1hSIaFMpTPDRiU+VeQcwcHh3aD1SOMNvIkxxhMX+3LRSFqJDUpT2Esxe3JJSmbCCDkFSM39py2Dq5mpkz9eckPXk4Xk6jDz42rUq0H27TuAa+6smQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184948; c=relaxed/simple;
	bh=7XB9myky1butrNP168fb/3sckVfWWOlnPSkRAMWtM6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=n3CnOuEHzDwVIJFyz0bZQa9fYRn9wyWloQjNZ0PkrTRtxRsk7skt1XhtmNEqQktfeBZuXHH2gy2s3hsoB5hz4FsE3WwkBGOooYXUe/2iYNruSmvjmLJgP0RhIyXtBETzMAQomfEA9L5lcu0j/pMP7X95IUz/97lHaV8PYFY8Dgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aLWn5+aW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLWn5+aW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755184945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bLKPRM21forN8e8Zt/jvbWkMjUg6274J+WzdOjZVYgU=;
	b=aLWn5+aW7uHpoDlTma9mc+PDmbq3wasPFdljNssLhSrZBXE73vmETDPTsZIoCiOna0zjpT
	g33VduJwhefeIMAG8TOUcRMt+1IX6W5Wz4AU8DkjFoXCiNjtfFRP/Rz70dbsITUEz5pnIp
	+R7gJOIP5ZCWwNItxXPiToe2kR069Ks=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-fzqkIg29Mw-7C9lfy7U9fA-1; Thu,
 14 Aug 2025 11:22:24 -0400
X-MC-Unique: fzqkIg29Mw-7C9lfy7U9fA-1
X-Mimecast-MFC-AGG-ID: fzqkIg29Mw-7C9lfy7U9fA_1755184943
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B54AC1800289
	for <gfs2@lists.linux.dev>; Thu, 14 Aug 2025 15:22:23 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0BB8230001A6;
	Thu, 14 Aug 2025 15:22:22 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next 4/4] dlm: check for undefined release_option values
Date: Thu, 14 Aug 2025 11:22:14 -0400
Message-ID: <20250814152214.946153-4-aahringo@redhat.com>
In-Reply-To: <20250814152214.946153-1-aahringo@redhat.com>
References: <20250814152214.946153-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: em27znvGdKS3subbudzYfbPN_WjEJIH11FgglP91-l8_1755184943
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Checking on all undefined release_option values to return -EINVAL in
case a user is providing them to dlm_release_lockspace().

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lockspace.c  | 3 +++
 include/linux/dlm.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 8eadbf0fdf179..ddaa765587068 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -797,6 +797,9 @@ int dlm_release_lockspace(void *lockspace, unsigned int release_option)
 	struct dlm_ls *ls;
 	int error;
 
+	if (release_option > __DLM_RELEASE_MAX)
+		return -EINVAL;
+
 	ls = dlm_find_lockspace_local(lockspace);
 	if (!ls)
 		return -EINVAL;
diff --git a/include/linux/dlm.h b/include/linux/dlm.h
index 34015a008b801..7e7b45b0d0970 100644
--- a/include/linux/dlm.h
+++ b/include/linux/dlm.h
@@ -113,6 +113,7 @@ int dlm_new_lockspace(const char *name, const char *cluster,
 #define DLM_RELEASE_NORMAL		2
 #define DLM_RELEASE_NO_EVENT		3
 #define DLM_RELEASE_RECOVER		4
+#define __DLM_RELEASE_MAX		DLM_RELEASE_RECOVER
 
 /*
  * dlm_release_lockspace
-- 
2.43.0


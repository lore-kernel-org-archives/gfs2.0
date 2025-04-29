Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C322A261362
	for <gfs2@lists.linux.dev>; Tue, 29 Apr 2025 20:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745958568; cv=none; b=rv7T0yW3CN3IUDz+54wN+duuIOJbLyNT5Bfu8KasVVbT5DUqeerLVZm26vuzOIQ9QUteYMv93Casq+zKofH3LUxKtLmp81H6r0uCy+dcaWN7wCX9rWXLNkDKLJzgs2o2tVoZZ0ZENJnZZmSDT5CVLkW7TDwUqTebjOVvz1iooh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745958568; c=relaxed/simple;
	bh=SSErC4I8ycVhTjxKvPWpSK1Eh1jyo+eJViPKGDrkqdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=aArEn2Af8q2qMpgeQCHfIs37suw2vr8ohlCEi5CR3D51Ptn8vyDIN3JX/xghPV91nZmh53uZ1a3sI8/Q9u5z805scaxAaT6iX8yHpmh8Ey/1bsOjYYdbweOrHuexIVZWzSG7mIrYh1MLJ+gVgbBXQxJVmqETnFjb7yGZnJreX2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BzZobnoH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BzZobnoH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745958565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IBFP0dYZWfVlP7yQ/yq6QcctISoZKkfVhALBUS6sea4=;
	b=BzZobnoH4aGvSkjOgEJcynr0xYeth0iwjrdS1IhLeuuttBAMDB1WEFnFPJskwq/6PSZdn0
	TZyQvc4x/ASK7NuJXHGr5k8hhr/9U4CIFG+hjmZXu+BGCKGjclOvGQiedGuwwd4tiU2pxm
	+lfptMemvu3gNNPnrQHg+myQNhvXyvI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-c2YK_wXtOrGT_FH0rii4XA-1; Tue,
 29 Apr 2025 16:29:24 -0400
X-MC-Unique: c2YK_wXtOrGT_FH0rii4XA-1
X-Mimecast-MFC-AGG-ID: c2YK_wXtOrGT_FH0rii4XA_1745958563
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2DA301956048;
	Tue, 29 Apr 2025 20:29:23 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5D7FC19560AF;
	Tue, 29 Apr 2025 20:29:22 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	glass.su@suse.com,
	heming.zhao@suse.com,
	lidong.zhong@suse.com,
	aahringo@redhat.com
Subject: [RFC PATCH dlm/next 4/4] dlm: drop SCTP Kconfig dependency
Date: Tue, 29 Apr 2025 16:29:13 -0400
Message-ID: <20250429202913.2908521-4-aahringo@redhat.com>
In-Reply-To: <20250429202913.2908521-1-aahringo@redhat.com>
References: <20250429202913.2908521-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6k19uweSHFwE9_T7RPQhhWw3biOM4D0sW8VLhtyRmQ8_1745958563
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

DLM does not use any exported SCTP function. SCTP is registered
dynamically as protocol to the kernel and can be used over the right
protocol identifiers on the socket api. We drop the SCTP dependency as
DLM can also be used with TCP only.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/dlm/Kconfig b/fs/dlm/Kconfig
index f82a4952769d..b46165df5a91 100644
--- a/fs/dlm/Kconfig
+++ b/fs/dlm/Kconfig
@@ -3,7 +3,6 @@ menuconfig DLM
 	tristate "Distributed Lock Manager (DLM)"
 	depends on INET
 	depends on SYSFS && CONFIGFS_FS && (IPV6 || IPV6=n)
-	select IP_SCTP
 	help
 	A general purpose distributed lock manager for kernel or userspace
 	applications.
-- 
2.43.0


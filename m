Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232EC24C09E
	for <gfs2@lists.linux.dev>; Tue, 29 Apr 2025 20:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745958569; cv=none; b=ApcXjpTMoqgn9EvrTSgM55AefKvVveXM0gBZGODRb2l77JQE/VmmaL3PYBdZeTw6odIee0JQFlYMH50BXhePNXksQrz7Uc6JUscvrwgfjLN2VcTFIhFmaEVFfpRUbdB2Db0lN4YikJ+uJCjHYuyT1HgFCqV0n45eMYC7DqioGw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745958569; c=relaxed/simple;
	bh=N/yEKKUPsOYaRxVa0FlVEMSIBY7f/YELDVpJ3v+qDhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=kP8cHpAwSwGIy3n1VC5b/KO7UIdTLEH9L5LaNfKFIZjv0X3uOoN8vZQPwGoS1rFobJIj/cPMQR5n2BCQ63Abyraz94qI5nDtrqKyvVmBE53rVPO07uvnguH0REEiLKka5ugcDPXutDhXw7MtGWzm7S1Bfz5xpcX+5/6rcCixfnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fqnL8sYs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqnL8sYs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745958566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cRQ6XSmsIRXHAsQk1Wj4dq9RMgXgEXUgV1TVRWiA+xY=;
	b=fqnL8sYsYxrGXAZDHaKJwGABCscM6/X4zsX1Y+E/DGTpQ3q/10dEVsfSjI+2mgfgltAggA
	gifGMoHC554gfFadd3q3rLCzQeEd6SCrO+huMY4zWEvgJHlJ1l+XUaSpTmCVLXEwdJUj3h
	zHk//Plbc4Od9AiX/ag0/qOfBOYcqIk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-tAHi4OkrO9qVUcFMSY4s1A-1; Tue,
 29 Apr 2025 16:29:23 -0400
X-MC-Unique: tAHi4OkrO9qVUcFMSY4s1A-1
X-Mimecast-MFC-AGG-ID: tAHi4OkrO9qVUcFMSY4s1A_1745958562
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 632721800877;
	Tue, 29 Apr 2025 20:29:22 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 64B6F19560A3;
	Tue, 29 Apr 2025 20:29:21 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	glass.su@suse.com,
	heming.zhao@suse.com,
	lidong.zhong@suse.com,
	aahringo@redhat.com
Subject: [RFC PATCH dlm/next 3/4] dlm: reject SCTP configuration if not enabled
Date: Tue, 29 Apr 2025 16:29:12 -0400
Message-ID: <20250429202913.2908521-3-aahringo@redhat.com>
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
X-Mimecast-MFC-PROC-ID: sZ7_okBNJ5QanDkNBGMX3rZ0wL-UvvZ5zN92-CQPIy8_1745958562
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Reject SCTP dlm configuration if the kernel was never build with SCTP.
Currently the only one known user space tool "dlm_controld" will drop an
error in the logs and getting stuck. This behaviour should be fixed to
deliver an error to the user or fallback to TCP.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/config.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/dlm/config.c b/fs/dlm/config.c
index cf9ba6fd7a28..a23fd524a6ee 100644
--- a/fs/dlm/config.c
+++ b/fs/dlm/config.c
@@ -197,6 +197,9 @@ static int dlm_check_protocol_and_dlm_running(unsigned int x)
 		break;
 	case 1:
 		/* SCTP */
+		if (!IS_ENABLED(CONFIG_IP_SCTP))
+			return -EOPNOTSUPP;
+
 		break;
 	default:
 		return -EINVAL;
-- 
2.43.0


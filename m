Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993A648C8C1
	for <gfs2@lists.linux.dev>; Tue,  1 Sep 2026 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284851; cv=none; b=a4fybys8VXprPq3g3Wt8plGuNPeWDQ4HGtZ3D8cQ30wVedx8kyuYwTzO1Hi1alltwnfSHELZ1Pzcp6XTlxohZ0zqoKsTcKULk7QStOH2vp8kK9UOl5q2sYOiuobc68n0jILiZxXiqPPpP5wFxNyR6RjQgFmwY1duVznKuL12XQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284851; c=relaxed/simple;
	bh=MJ4zCs4a0Bgp/+zuATDsOarU6CqOdQA221uh+/GY0LA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=mIZfteJkXEEomp/TK1zbDJJmBgW2alXnQ5bSo+3ei5hviHo19PFZFr7cHRmupboLs4Ac5bVIcDiwUh288nZ937hYxba+fYzo1DEDejaeeaZKKANQmkH/5bytoPKsJCElMvMVxlsdLAaFwJrIEFSsvoNztzPirwBE8IzlN8752TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VZKuDpoK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZKuDpoK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788284848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V+FB76eR90BdcJY2Zkq0vav8OCvugG4x9QXaawU7KzY=;
	b=VZKuDpoKjRWTIE0NOu4QXFptrteC749aV3Dj7L0RDjb0xFhCtYir8Y+HDOw5eWIxd5u1Z9
	DVJ9hXvJ8KxsdboJ1nQ77QvlAUnLHKZXpKbE4jCaPzoIrI7UUyAaqKMY6bMXX4hjSbxDRg
	UisWA5o8Ga/+K6RYbMfvSjWWecNaDKc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-oMmzFNliNqS51aKvUhd2mA-1; Tue,
 01 Sept 2026 13:47:27 -0400
X-MC-Unique: oMmzFNliNqS51aKvUhd2mA-1
X-Mimecast-MFC-AGG-ID: oMmzFNliNqS51aKvUhd2mA_1788284846
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B0451955DE8
	for <gfs2@lists.linux.dev>; Tue,  1 Sep 2026 17:47:26 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1962218005BD;
	Tue,  1 Sep 2026 17:47:26 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH RESEND dlm/next 7/8] dlm: wait for outstanding SRCU callbacks to complete in exit paths
Date: Tue,  1 Sep 2026 13:47:14 -0400
Message-ID: <20260901174715.3825582-8-aahringo@redhat.com>
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
X-Mimecast-MFC-PROC-ID: yCLTrCyJJY9eSpdygHsFSz2GxAq5lTSzSdO_BNDAmCs_1788284846
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Zqiang <qiang.zhang@linux.dev>

The dlm_lowcomms_exit() and dlm_midcomms_exit() iterate over the
srcu protected connection and node hash tables and hand each
element to call_srcu() for deferred freeing (connection_release()
and midcomms_node_release()). call_srcu() is asynchronous: the
callbacks are invoked only after an SRCU grace period, which may
happen after the exit function has already returned.

These exit functions are reached from exit_dlm() on module unload.
Once they return, module teardown continues and the module text
may be unloaded while call_srcu() callbacks are still pending. When
such a callback finally runs, it executes freed module code and
touches the static SRCU domains that are being torn down, resulting
in a use-after-free.

Add an srcu_barrier() after the call_srcu() loop in each exit function
to wait for all outstanding callbacks of the respective SRCU domain to
complete before returning. In dlm_midcomms_exit() the barrier is issued
before dlm_lowcomms_exit() so that node callbacks are drained prior to
tearing down the lower layer.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Acked-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lowcomms.c | 1 +
 fs/dlm/midcomms.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 2aff1c7c17de4..ea8353c4638d0 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1984,4 +1984,5 @@ void dlm_lowcomms_exit(void)
 		}
 	}
 	srcu_read_unlock(&connections_srcu, idx);
+	srcu_barrier(&connections_srcu);
 }
diff --git a/fs/dlm/midcomms.c b/fs/dlm/midcomms.c
index 8964164600d2d..0454315244945 100644
--- a/fs/dlm/midcomms.c
+++ b/fs/dlm/midcomms.c
@@ -1178,6 +1178,7 @@ void dlm_midcomms_exit(void)
 		}
 	}
 	srcu_read_unlock(&nodes_srcu, idx);
+	srcu_barrier(&nodes_srcu);
 
 	dlm_lowcomms_exit();
 }
-- 
2.43.0


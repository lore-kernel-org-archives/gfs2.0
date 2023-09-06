Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5C920EA
	for <gfs2@lists.linux.dev>; Wed,  6 Sep 2023 14:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694010754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYLBBJzk+buJaOnWkJ+zsROKwXPb/2zKnwXPGU6basQ=;
	b=XHUymlOknXPUTavqv633JtgSvhTGN/6Lsj50OiLwAIpSq/D+MaX03wWazS3oWIKg9j/1zt
	4oA/9lgGfpnYRVj5TDkzLD+scfGQW9AoayRFmyvUgb+o72x8i8foo7XXEJ4TPM3c7ucV4a
	cQGxHI0zvLrxkALa5L0DLqY6D4NIejo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-73-3q9UPbiUOGKoMMzCjOCKTQ-1; Wed, 06 Sep 2023 10:32:33 -0400
X-MC-Unique: 3q9UPbiUOGKoMMzCjOCKTQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25DFC1825487;
	Wed,  6 Sep 2023 14:32:33 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EDD31140E950;
	Wed,  6 Sep 2023 14:32:32 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: cluster-devel@redhat.com,
	gfs2@lists.linux.dev,
	aahringo@redhat.com,
	stable@vger.kernel.org
Subject: [PATCH dlm/next 3/6] dlm: be sure we reset all nodes at forced shutdown
Date: Wed,  6 Sep 2023 10:31:50 -0400
Message-Id: <20230906143153.1353077-3-aahringo@redhat.com>
In-Reply-To: <20230906143153.1353077-1-aahringo@redhat.com>
References: <20230906143153.1353077-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7

In case we running in a force shutdown in either midcomms or lowcomms
implementation we will make sure we reset all per midcomms node
information.

Cc: stable@vger.kernel.org
Fixes: 63e711b08160 ("fs: dlm: create midcomms nodes when configure")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/midcomms.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/midcomms.c b/fs/dlm/midcomms.c
index 4ad71e97cec2..6bc8d7f89b2c 100644
--- a/fs/dlm/midcomms.c
+++ b/fs/dlm/midcomms.c
@@ -1405,10 +1405,16 @@ void dlm_midcomms_shutdown(void)
 			midcomms_shutdown(node);
 		}
 	}
-	srcu_read_unlock(&nodes_srcu, idx);
-	mutex_unlock(&close_lock);
 
 	dlm_lowcomms_shutdown();
+
+	for (i = 0; i < CONN_HASH_SIZE; i++) {
+		hlist_for_each_entry_rcu(node, &node_hash[i], hlist) {
+			midcomms_node_reset(node);
+		}
+	}
+	srcu_read_unlock(&nodes_srcu, idx);
+	mutex_unlock(&close_lock);
 }
 
 int dlm_midcomms_close(int nodeid)
-- 
2.31.1


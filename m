Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E016D3F
	for <gfs2@lists.linux.dev>; Fri,  8 Sep 2023 20:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694205986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PeMTXPCYptSjwCoAJ8B3ThddmP+gLHY2FpqvtYa2hEg=;
	b=R0EU+6fqQWSXxF6sX1i/LUqnOIHsOyLcYyJFtUk9s3/Yrz6J94JsX7/7qLehINzi0ieumQ
	zfykBv/O0nmTjR5bi4SlSg8vizzN6ebGOQdYxlDcCg/bIY6qExqUsNDM4pT5kgllp0C11n
	TftC7WfEalt1qmaAgDtRtxfqL0BFPgg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-211-EC77_FHNN5OHgJ_THfX0pg-1; Fri, 08 Sep 2023 16:46:23 -0400
X-MC-Unique: EC77_FHNN5OHgJ_THfX0pg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E93798164E0
	for <gfs2@lists.linux.dev>; Fri,  8 Sep 2023 20:46:22 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C13FD21EE56D;
	Fri,  8 Sep 2023 20:46:22 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: cluster-devel@redhat.com,
	gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [RFC dlm/next 03/10] fs: dlm: remove explicit scheduling points
Date: Fri,  8 Sep 2023 16:46:04 -0400
Message-Id: <20230908204611.1910601-3-aahringo@redhat.com>
In-Reply-To: <20230908204611.1910601-1-aahringo@redhat.com>
References: <20230908204611.1910601-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This patch prepares to switch some locks to a spinlock. In this case we
need to remove some explicit schedule points when a spinlock is held.
We might have less scheduling points to try to serve others, we need to
see if this still makes problems when we remove them and find other
solutions.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c         | 2 --
 fs/dlm/recover.c      | 1 -
 fs/dlm/requestqueue.c | 1 -
 3 files changed, 4 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 970b8499b66f..61eb285c613c 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -4979,7 +4979,6 @@ void dlm_recover_waiters_pre(struct dlm_ls *ls)
 			log_error(ls, "invalid lkb wait_type %d %d",
 				  lkb->lkb_wait_type, wait_type);
 		}
-		schedule();
 	}
 	mutex_unlock(&ls->ls_waiters_mutex);
 	kfree(ms_local);
@@ -5218,7 +5217,6 @@ void dlm_recover_purge(struct dlm_ls *ls)
 		}
 		unlock_rsb(r);
 		unhold_rsb(r);
-		cond_resched();
 	}
 	up_write(&ls->ls_root_sem);
 
diff --git a/fs/dlm/recover.c b/fs/dlm/recover.c
index ce6dc914cb86..752002304ca9 100644
--- a/fs/dlm/recover.c
+++ b/fs/dlm/recover.c
@@ -543,7 +543,6 @@ int dlm_recover_masters(struct dlm_ls *ls, uint64_t seq)
 		else
 			error = recover_master(r, &count, seq);
 		unlock_rsb(r);
-		cond_resched();
 		total++;
 
 		if (error) {
diff --git a/fs/dlm/requestqueue.c b/fs/dlm/requestqueue.c
index c05940afd063..ef7b7c8d6907 100644
--- a/fs/dlm/requestqueue.c
+++ b/fs/dlm/requestqueue.c
@@ -106,7 +106,6 @@ int dlm_process_requestqueue(struct dlm_ls *ls)
 			error = -EINTR;
 			break;
 		}
-		schedule();
 	}
 
 	return error;
-- 
2.31.1


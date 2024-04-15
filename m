Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA358154BE2
	for <gfs2@lists.linux.dev>; Mon, 15 Apr 2024 18:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713206389; cv=none; b=cz3yN6EL3ASSY0weUe7T+CEUSchZ3dGvw8GaYkVKqdp0R246flkhfAIoZ3B3zcHkMn86O7u8aLHkZfxRkVV9Dm02+2k6NzcZpi2xrE8GuAihIvgWlZNWmxgLXD8VSXywnz0hKXIzdyM2BH18cLQ2/4RWY1eWy7EATcFLR9LU6d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713206389; c=relaxed/simple;
	bh=Hpw2x4PDhC0cmRXnLUxDvqPvBWqf2BALXJ8FR4zQMF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQKfpIGGgqzmYK2d+AT7JEPc9VY8FJJFbm7cDu/JHhrirJZwPHTWF7SxEh73mwHz0YoXSBNSTmWL/xjxZlxVt2OdtNBcnlK52yDfhdoKvd41vZKnqnlBIcymwZwOYs748l3AmfPJ5Tzphw/HhaOWeFZROSRDAwxsaggQ6HNU0Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PSs5t/LU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PSs5t/LU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713206386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ut9l6BCtaDYDLicUspYSQ9tkmAb7g5kWdhtJRhXJ3yU=;
	b=PSs5t/LUK6QIFr385KCQxfRAoI6mpQTGvSXTSQ4n/hgGawHEfo9YeBVEkJqaMNMCE0zSFC
	bnBLlEZbua9lL/FC0TIrlQkex1eMhBdET3mujeC0r3M/hErIk0tadlZFpWyT3bF4ThsqNg
	z4ngNxwcwcASW4BPI/IzCVnJT47kkyk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-wK5i2t6aN3aPJvBQybDcww-1; Mon, 15 Apr 2024 14:39:45 -0400
X-MC-Unique: wK5i2t6aN3aPJvBQybDcww-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB5CD80A0D5
	for <gfs2@lists.linux.dev>; Mon, 15 Apr 2024 18:39:44 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C1155C13FA2;
	Mon, 15 Apr 2024 18:39:44 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv2 dlm/next 1/9] dlm: increment ls_count on find_ls_to_scan()
Date: Mon, 15 Apr 2024 14:39:35 -0400
Message-ID: <20240415183943.645497-2-aahringo@redhat.com>
In-Reply-To: <20240415183943.645497-1-aahringo@redhat.com>
References: <20240415183943.645497-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This patch increments the ls_count atomic value that is used as a
reference counter in find_ls_to_scan(). An additional
dlm_put_lockspace() is necessary in dlm_scand() to drop this reference
again.

This handling is necessary because release_lockspace() calls
remove_lockspace() that removes the lockspace from the global lockspace
list. It only does that when the lockspace is not in use anymore
signaled by the menitoned ls_count atomic value. Currently dlm_scand()
can be executed when release_lockspace() is freeing all lockspace
resources. As example:

1. scand timeout occurs
2. find_ls_to_scan() returns ls A - lslist_lock is not held anymore
3. dlm_scan_rsbs(A) does its job
4. release_lockspace(A, 2) is called by the user. User has no control of
   dlm_scan_rsbs(A)
5. lockspace_busy(A, 2) returns 0, it's not busy
6. dlm_scan_rsbs(A) iterates over the whole rsb hash bucket, sometimes
   triggers send_remove()
7. release_lockspace(A, 2) does not stop scand because ls_count was >= 2
8. remove_lockspace() will ignore ongoing scand because scand does not
   hold a reference as ls_count is intended to do so
9. release_lockspace(A, 2) cleans up everything while 6. can occur

Point 8 is a problem because both access the same resources and
release_lockspace() frees them.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lockspace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index c3681a50decb..731c48371a27 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -255,6 +255,7 @@ static struct dlm_ls *find_ls_to_scan(void)
 	list_for_each_entry(ls, &lslist, ls_list) {
 		if (time_after_eq(jiffies, ls->ls_scan_time +
 					    dlm_config.ci_scan_secs * HZ)) {
+			atomic_inc(&ls->ls_count);
 			spin_unlock_bh(&lslist_lock);
 			return ls;
 		}
@@ -277,6 +278,8 @@ static int dlm_scand(void *data)
 			} else {
 				ls->ls_scan_time += HZ;
 			}
+
+			dlm_put_lockspace(ls);
 			continue;
 		}
 		schedule_timeout_interruptible(dlm_config.ci_scan_secs * HZ);
-- 
2.43.0


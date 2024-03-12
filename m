Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7DD137C5A
	for <gfs2@lists.linux.dev>; Tue, 12 Mar 2024 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263119; cv=none; b=IUYiYkq9/tYgPgVVZGjPTFoHyovPG/JLA9+mlHyb/RmrOEjRRbBwd+ybPxvCJsH9Fjujjpoy5Avm+fFraYXM+f+BLJVd66t6GnuWZ8zq9CLYWXWxeKLoaSbVwgMfYzrFkObeHkQMYqaTcZKQAKgKQzI09IPIFYIAjEAYniL/ZBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263119; c=relaxed/simple;
	bh=FpGGoai7DNK6irPwWweU7smsElWX+YZYVqwv2KqX5zA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LUX5SHYhISWF5Kf7kxHYnrCytgzLE9Al1Xu/0FuA7mGChKZYa39DTnLDEZtd07zfDk8IBuPeJ1mE325kCV0Z1drz+pn7YyjrP/Jf8idAXfDvrR6BANBWW9ZOqHEsBi247TSr+PE2e224V8DuuQ/EhEp1FASNxhfsIdjQOUaW2EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TekhfDAG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TekhfDAG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710263116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DTiJINJiqUIAbUyJO5OqzGjXdkixQWAhmjERranx3Nk=;
	b=TekhfDAG2vRgVNzhLQkwB1Hi4lmRcrf3z+zNztRdHN1NUdKNNiHdZlWvfmAJgL0xKkH7sV
	xok/cni/kUdmRiLYRgZuEKZjyNnKe4cySvkmFm9QidS6PYewXZzSHz2PlQ3qPnsZunIV5x
	e9ueRzpegac4DlqFPWRqTayLBCu/RIs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-_MnekdL5NFCCAMlTZbrjzw-1; Tue, 12 Mar 2024 13:05:11 -0400
X-MC-Unique: _MnekdL5NFCCAMlTZbrjzw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B7E9485A58B;
	Tue, 12 Mar 2024 17:05:10 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.fast.eng.rdu2.dc.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6B6C7C017A3;
	Tue, 12 Mar 2024 17:05:10 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	stable@vger.kernel.org,
	vvidic@valentin-vidic.from.hr,
	joseph.qi@linux.alibaba.com,
	ocfs2-devel@oss.oracle.com,
	heming.zhao@suse.com,
	aahringo@redhat.com
Subject: [PATCH 1/2] dlm: fix user space lkb refcounting
Date: Tue, 12 Mar 2024 13:05:07 -0400
Message-ID: <20240312170508.3590306-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

This patch fixes to check on the right return value if it was the last
callback. The rv variable got overwritten by the return of
copy_result_to_user(). Fixing it by introducing a second variable for
the return value and don't let rv being overwritten.

Cc: stable@vger.kernel.org
Fixes: 61bed0baa4db ("fs: dlm: use a non-static queue for callbacks")
Reported-by: Valentin Vidić <vvidic@valentin-vidic.from.hr>
Closes: https://lore.kernel.org/gfs2/Ze4qSvzGJDt5yxC3@valentin-vidic.from.hr
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/user.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/dlm/user.c b/fs/dlm/user.c
index 695e691b38b3..9f9b68448830 100644
--- a/fs/dlm/user.c
+++ b/fs/dlm/user.c
@@ -806,7 +806,7 @@ static ssize_t device_read(struct file *file, char __user *buf, size_t count,
 	struct dlm_lkb *lkb;
 	DECLARE_WAITQUEUE(wait, current);
 	struct dlm_callback *cb;
-	int rv, copy_lvb = 0;
+	int rv, ret, copy_lvb = 0;
 	int old_mode, new_mode;
 
 	if (count == sizeof(struct dlm_device_version)) {
@@ -906,9 +906,9 @@ static ssize_t device_read(struct file *file, char __user *buf, size_t count,
 		trace_dlm_ast(lkb->lkb_resource->res_ls, lkb);
 	}
 
-	rv = copy_result_to_user(lkb->lkb_ua,
-				 test_bit(DLM_PROC_FLAGS_COMPAT, &proc->flags),
-				 cb->flags, cb->mode, copy_lvb, buf, count);
+	ret = copy_result_to_user(lkb->lkb_ua,
+				  test_bit(DLM_PROC_FLAGS_COMPAT, &proc->flags),
+				  cb->flags, cb->mode, copy_lvb, buf, count);
 
 	kref_put(&cb->ref, dlm_release_callback);
 
@@ -916,7 +916,7 @@ static ssize_t device_read(struct file *file, char __user *buf, size_t count,
 	if (rv == DLM_DEQUEUE_CALLBACK_LAST)
 		dlm_put_lkb(lkb);
 
-	return rv;
+	return ret;
 }
 
 static __poll_t device_poll(struct file *file, poll_table *wait)
-- 
2.43.0


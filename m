Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703E01591FC
	for <gfs2@lists.linux.dev>; Wed, 29 May 2024 17:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002248; cv=none; b=lBFr9wXEa0fJTcKjFRTjS752NdVW2hGaTz7iT1hkxCN03oM0/HJSwrHOFu1qgd1qIP/jAAP6XDOq6iVrt32IfCZ64jKp+8VJUu8Jlw0lArLr+oOhNEN2n386s5rlCaChpkAkDf/Spox/6MidZIQDj5m/WrYOqH9vv7YWarRK0Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002248; c=relaxed/simple;
	bh=0JEA8pZIs/TN6ayz7tPXyeTTwZ0jMIZyq8ay7ow0eS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sjYk7XkC7iEJm6CkYWBkj4LZJxtUIhNAI1J1Dco8NZt2czB3Gp7Apa4KXctG59QngAeellR1aW9onAOU+mLvCOGX4NhFLg6J515aYBhn8EAUqdYo8PxU127IQbOsSQjQAQk5aQWAh0pzmjhHTyvDVNcYYuflKPqSKlGZ/MHEVt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EwjeYM3F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EwjeYM3F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717002246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LYRep3eoIaPw1ZsxFEHslEyYf8UbxvuMaxBhrrKttkc=;
	b=EwjeYM3FvsciDhjdlyYMB+G2xQ1YI6wnoiiAQAOj43xFCUp43HMuNIRIW72BY//r5In4u3
	UfRBXE6DtRxRJMqcxouC+9slgklNvimiGXkDnOyPDFumZuCUZHDFAMmkNaZCYVh+eFLuwZ
	Y3X5xIb3uo6yJAXcJnPUEmN9IGa+VPs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-RVoh3ZQhM2W389np6EFhUQ-1; Wed, 29 May 2024 13:04:04 -0400
X-MC-Unique: RVoh3ZQhM2W389np6EFhUQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2FE6800CB0
	for <gfs2@lists.linux.dev>; Wed, 29 May 2024 17:04:04 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 25C80492BC6;
	Wed, 29 May 2024 17:04:04 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 14/15] Revert "GFS2: Don't add all glocks to the lru"
Date: Wed, 29 May 2024 19:03:51 +0200
Message-ID: <20240529170352.571141-15-agruenba@redhat.com>
In-Reply-To: <20240529170352.571141-1-agruenba@redhat.com>
References: <20240529170352.571141-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This reverts commit e7ccaf5fe1590667b3fa2f8df5c5ec9ba0dc5b85.

Before commit e7ccaf5fe159, every time a resource group glock was
dequeued by gfs2_glock_dq(), it was added to the glock LRU list even
though the glock was still referenced by the resource group and could
never be evicted, anyway.  Commit e7ccaf5fe159 added a GLOF_LRU hack to
avoid that overhead for resource group glocks, and that hack was since
adopted for some other types of glocks as well.

We now no longer add glocks to the glock LRU list while they are still
referenced.  This solves the underlying problem, and obsoletes the
GLOF_LRU hack.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
(cherry picked from commit 3e5257c810cba91e274d07f3db5cf013c7c830be)
---
 fs/gfs2/glock.c  | 7 -------
 fs/gfs2/glops.c  | 8 ++++----
 fs/gfs2/incore.h | 1 -
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index e2a72c21194a..19f8df91b72e 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -239,11 +239,7 @@ static int demote_ok(const struct gfs2_glock *gl)
 
 static void gfs2_glock_add_to_lru(struct gfs2_glock *gl)
 {
-	if (!(gl->gl_ops->go_flags & GLOF_LRU))
-		return;
-
 	spin_lock(&lru_lock);
-
 	list_move_tail(&gl->gl_lru, &lru_list);
 
 	if (!test_bit(GLF_LRU, &gl->gl_flags)) {
@@ -256,9 +252,6 @@ static void gfs2_glock_add_to_lru(struct gfs2_glock *gl)
 
 static void gfs2_glock_remove_from_lru(struct gfs2_glock *gl)
 {
-	if (!(gl->gl_ops->go_flags & GLOF_LRU))
-		return;
-
 	spin_lock(&lru_lock);
 	if (test_bit(GLF_LRU, &gl->gl_flags)) {
 		list_del_init(&gl->gl_lru);
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 39bb6758a2a0..7bc7f6785abd 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -727,7 +727,7 @@ const struct gfs2_glock_operations gfs2_inode_glops = {
 	.go_held = inode_go_held,
 	.go_dump = inode_go_dump,
 	.go_type = LM_TYPE_INODE,
-	.go_flags = GLOF_ASPACE | GLOF_LRU | GLOF_LVB,
+	.go_flags = GLOF_ASPACE | GLOF_LVB,
 	.go_unlocked = inode_go_unlocked,
 };
 
@@ -751,13 +751,13 @@ const struct gfs2_glock_operations gfs2_iopen_glops = {
 	.go_type = LM_TYPE_IOPEN,
 	.go_callback = iopen_go_callback,
 	.go_dump = inode_go_dump,
-	.go_flags = GLOF_LRU | GLOF_NONDISK,
+	.go_flags = GLOF_NONDISK,
 	.go_subclass = 1,
 };
 
 const struct gfs2_glock_operations gfs2_flock_glops = {
 	.go_type = LM_TYPE_FLOCK,
-	.go_flags = GLOF_LRU | GLOF_NONDISK,
+	.go_flags = GLOF_NONDISK,
 };
 
 const struct gfs2_glock_operations gfs2_nondisk_glops = {
@@ -768,7 +768,7 @@ const struct gfs2_glock_operations gfs2_nondisk_glops = {
 
 const struct gfs2_glock_operations gfs2_quota_glops = {
 	.go_type = LM_TYPE_QUOTA,
-	.go_flags = GLOF_LVB | GLOF_LRU | GLOF_NONDISK,
+	.go_flags = GLOF_LVB | GLOF_NONDISK,
 };
 
 const struct gfs2_glock_operations gfs2_journal_glops = {
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index 5ee46af1f4bd..f75982d45635 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -230,7 +230,6 @@ struct gfs2_glock_operations {
 	const unsigned long go_flags;
 #define GLOF_ASPACE 1 /* address space attached */
 #define GLOF_LVB    2 /* Lock Value Block attached */
-#define GLOF_LRU    4 /* LRU managed */
 #define GLOF_NONDISK   8 /* not I/O related */
 };
 
-- 
2.45.1


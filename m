Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DC184055
	for <gfs2@lists.linux.dev>; Fri, 12 Apr 2024 13:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929407; cv=none; b=J2NlJlmxFSt05GiU1VwQNle7Rn2PTJA7LurVh7z9ItCljiFaE/+SN/zHZ98QPyliJmsOxI0cpf1AvpZBH+00M/5/M3071l2G4kpUKapONfM4N8oS0G1AXbgKlg+PXqsKHoWz0DgjisgCGIquaS8lXB9JWV5r67X+YIk0a4nK0no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929407; c=relaxed/simple;
	bh=oIB3SWBbiaOEVl7Vg50Y+SJr7jipZ4HSXTBwRunTN5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KRT2GCLEOi07meJz5+LPgsUbw+Gyiug6YE+4H+tvMsMDNjvsaasFuAWIg1l8jYbIa9eGHfoQfI+azuazBeduEjpzO4yUwzUipajKnl35XofEi750BzP1VemodtqVKBZYk5oGnUeoEKecwa57LWwofuC0xH8ZBKyLyt+biBBksd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PskJz9Up; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PskJz9Up"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712929405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7tG5z+0KJ+kdtryysSw+vcMMAD/i/vs0LMKRXaLMMeQ=;
	b=PskJz9UpLimE6HQld63DVc8IuYSglPeRTk3ujOSD2awvIPk4bYI11H79V4LzDI1fXvOskh
	F9BsqHed2fdTLfzXLf8lbJaNjLfMIb8dohu6R/JJhI5v8DZzxovWEgK4RpGrGvhCE3b9iD
	KSmKNQuhtRJG11mNU8R4FUTqblD9qHc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-Y4yX5ystNMK5pQbRjIFDYQ-1; Fri,
 12 Apr 2024 09:43:23 -0400
X-MC-Unique: Y4yX5ystNMK5pQbRjIFDYQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7DAE33C3D0D5
	for <gfs2@lists.linux.dev>; Fri, 12 Apr 2024 13:43:23 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7537A2166AE5;
	Fri, 12 Apr 2024 13:43:23 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next 6/9] dlm: remove refcounting if rsb is on toss
Date: Fri, 12 Apr 2024 09:43:11 -0400
Message-ID: <20240412134314.173067-7-aahringo@redhat.com>
In-Reply-To: <20240412134314.173067-1-aahringo@redhat.com>
References: <20240412134314.173067-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

In the past we had problems when rsb have a reference counter greater
than one when they are in the toss state. A rsb in the toss state is
not "alive" anymore and should not have any other references holding
than just the last one keeping it on the rsb hash. It is a delayed free
as kind of garbage collection with an additional handling to move the
rsb into the keep state thats alive again.

The reference counter should only be used when the rsb is not in toss
state (keep state), if the rsb isn't used anymore in keep state it will
be moved to toss state where it can be freed on the right time. The
release() function of the keep rsb will therefore set the RSB_TOSS state
and does not kref_init() at this state as toss rsbs should never deal
with any reference counting. If the rsb got alive again then the
RSB_TOSS flag will be cleared and the kref_init() will be called to use
reference counters when the rsb is in keep state.

There are warnings introduced now that will be triggered if we ever use
any reference counting when a rsb is in toss state. All before
kref_put() in toss state was only a sanity check if it ever wasn't 1.
This will be removed and we directly free the rsb when it should be
freed in the toss state. If there are still references around it is a
bug.

This WARN_ON_ONCE() should hopefully find maybe more cases where we hold
references of a toss rsb which we should not have as receive_remove() in
the most cases requires to have the rsb in toss state. Otherwise we can
run into problems when e.g. the directory rsb wasn't removed and the
directory node tells the master node in case of a lookup message.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c    | 61 ++++++++++++++++++++++++------------------------
 fs/dlm/lock.h    |  1 +
 fs/dlm/recover.c |  2 +-
 3 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index defb90b56b72..fee1a4164fc1 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -325,6 +325,8 @@ static void queue_bast(struct dlm_rsb *r, struct dlm_lkb *lkb, int rqmode)
 
 static inline void hold_rsb(struct dlm_rsb *r)
 {
+	/* rsbs in toss state never get referenced */
+	WARN_ON(rsb_flag(r, RSB_TOSS));
 	kref_get(&r->res_ref);
 }
 
@@ -631,6 +633,11 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 
 	list_move(&r->res_rsbs_list, &ls->ls_keep);
 	rsb_clear_flag(r, RSB_TOSS);
+	/* rsb got out of toss state, it becomes alive again
+	 * and we reinit the reference counter that is only
+	 * valid for keep state rsbs
+	 */
+	kref_init(&r->res_ref);
 	goto out_unlock;
 
 
@@ -765,6 +772,11 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 
 	list_move(&r->res_rsbs_list, &ls->ls_keep);
 	rsb_clear_flag(r, RSB_TOSS);
+	/* rsb got out of toss state, it becomes alive again
+	 * and we reinit the reference counter that is only
+	 * valid for keep state rsbs
+	 */
+	kref_init(&r->res_ref);
 	goto out_unlock;
 
 
@@ -1112,8 +1124,6 @@ static void toss_rsb(struct kref *kref)
 	struct dlm_ls *ls = r->res_ls;
 
 	DLM_ASSERT(list_empty(&r->res_root_list), dlm_print_rsb(r););
-	kref_init(&r->res_ref);
-	WARN_ON(rsb_flag(r, RSB_TOSS));
 	rsb_set_flag(r, RSB_TOSS);
 	list_move(&r->res_rsbs_list, &ls->ls_toss);
 	r->res_toss_time = jiffies;
@@ -1129,16 +1139,20 @@ static void toss_rsb(struct kref *kref)
 static void unhold_rsb(struct dlm_rsb *r)
 {
 	int rv;
+
+	/* rsbs in toss state never get referenced */
+	WARN_ON(rsb_flag(r, RSB_TOSS));
 	rv = kref_put(&r->res_ref, toss_rsb);
 	DLM_ASSERT(!rv, dlm_dump_rsb(r););
 }
 
-static void kill_rsb(struct kref *kref)
+void free_toss_rsb(struct dlm_rsb *r)
 {
-	struct dlm_rsb *r = container_of(kref, struct dlm_rsb, res_ref);
+	WARN_ON_ONCE(!rsb_flag(r, RSB_TOSS));
 
-	/* All work is done after the return from kref_put() so we
-	   can release the write_lock before the remove and free. */
+	/* check if all work is done after the rsb is on toss list
+	 * and it can be freed.
+	 */
 
 	DLM_ASSERT(list_empty(&r->res_lookup), dlm_dump_rsb(r););
 	DLM_ASSERT(list_empty(&r->res_grantqueue), dlm_dump_rsb(r););
@@ -1147,6 +1161,8 @@ static void kill_rsb(struct kref *kref)
 	DLM_ASSERT(list_empty(&r->res_root_list), dlm_dump_rsb(r););
 	DLM_ASSERT(list_empty(&r->res_recover_list), dlm_dump_rsb(r););
 	DLM_ASSERT(list_empty(&r->res_masters_list), dlm_dump_rsb(r););
+
+	dlm_free_rsb(r);
 }
 
 /* Attaching/detaching lkb's from rsb's is for rsb reference counting.
@@ -1611,15 +1627,10 @@ static void shrink_bucket(struct dlm_ls *ls)
 			continue;
 		}
 
-		if (!kref_put(&r->res_ref, kill_rsb)) {
-			log_error(ls, "tossed rsb in use %s", r->res_name);
-			continue;
-		}
-
 		list_del(&r->res_rsbs_list);
 		rhashtable_remove_fast(&ls->ls_rsbtbl, &r->res_node,
 				       dlm_rhash_rsb_params);
-		dlm_free_rsb(r);
+		free_toss_rsb(r);
 	}
 
 	if (need_shrink)
@@ -1680,19 +1691,13 @@ static void shrink_bucket(struct dlm_ls *ls)
 			continue;
 		}
 
-		if (!kref_put(&r->res_ref, kill_rsb)) {
-			spin_unlock_bh(&ls->ls_rsbtbl_lock);
-			log_error(ls, "remove_name in use %s", name);
-			continue;
-		}
-
 		list_del(&r->res_rsbs_list);
 		rhashtable_remove_fast(&ls->ls_rsbtbl, &r->res_node,
 				       dlm_rhash_rsb_params);
 		send_remove(r);
 		spin_unlock_bh(&ls->ls_rsbtbl_lock);
 
-		dlm_free_rsb(r);
+		free_toss_rsb(r);
 	}
 }
 
@@ -4180,18 +4185,12 @@ static void receive_remove(struct dlm_ls *ls, const struct dlm_message *ms)
 		return;
 	}
 
-	if (kref_put(&r->res_ref, kill_rsb)) {
-		list_del(&r->res_rsbs_list);
-		rhashtable_remove_fast(&ls->ls_rsbtbl, &r->res_node,
-				       dlm_rhash_rsb_params);
-		spin_unlock_bh(&ls->ls_rsbtbl_lock);
-		dlm_free_rsb(r);
-	} else {
-		log_error(ls, "receive_remove from %d rsb ref error",
-			  from_nodeid);
-		dlm_print_rsb(r);
-		spin_unlock_bh(&ls->ls_rsbtbl_lock);
-	}
+	list_del(&r->res_rsbs_list);
+	rhashtable_remove_fast(&ls->ls_rsbtbl, &r->res_node,
+			       dlm_rhash_rsb_params);
+	spin_unlock_bh(&ls->ls_rsbtbl_lock);
+
+	free_toss_rsb(r);
 }
 
 static void receive_purge(struct dlm_ls *ls, const struct dlm_message *ms)
diff --git a/fs/dlm/lock.h b/fs/dlm/lock.h
index 33616d4b0cdb..b56a34802762 100644
--- a/fs/dlm/lock.h
+++ b/fs/dlm/lock.h
@@ -18,6 +18,7 @@ void dlm_receive_message_saved(struct dlm_ls *ls, const struct dlm_message *ms,
 			       uint32_t saved_seq);
 void dlm_receive_buffer(const union dlm_packet *p, int nodeid);
 int dlm_modes_compat(int mode1, int mode2);
+void free_toss_rsb(struct dlm_rsb *r);
 void dlm_put_rsb(struct dlm_rsb *r);
 void dlm_hold_rsb(struct dlm_rsb *r);
 int dlm_put_lkb(struct dlm_lkb *lkb);
diff --git a/fs/dlm/recover.c b/fs/dlm/recover.c
index c21ef115123b..d43189532b14 100644
--- a/fs/dlm/recover.c
+++ b/fs/dlm/recover.c
@@ -889,7 +889,7 @@ void dlm_clear_toss(struct dlm_ls *ls)
 		list_del(&r->res_rsbs_list);
 		rhashtable_remove_fast(&ls->ls_rsbtbl, &r->res_node,
 				       dlm_rhash_rsb_params);
-		dlm_free_rsb(r);
+		free_toss_rsb(r);
 		count++;
 	}
 	spin_unlock_bh(&ls->ls_rsbtbl_lock);
-- 
2.43.0


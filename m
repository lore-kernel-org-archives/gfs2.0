Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9079A26D4F8
	for <gfs2@lists.linux.dev>; Sat, 30 Aug 2025 10:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756548866; cv=none; b=Ivo6yF7hHUqNAgLL76aegDG53MnnS9DELWC4wIKKG5h2g1yBc1zmT/MuhAI37P+Db+4Blypv1WT2UjmGctppo+dfwX2LlrrteUTPCictIJp34n+iCGLGfrQSeTTthuI4y+yn/kJ5v4bk6j/8P60os7wKoWV8zzGXWmW1OXk4LYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756548866; c=relaxed/simple;
	bh=aATSn8vh783r9DV4HOZ2ASkf3VBSIHEvlcYxuZlwIHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AdMEktcST/ihWXWo5pcIzZNAPw/UJd0kKXAYANE5F3k7dVkIdbQUNoKpeJhB2vVGlM3zB29zbpqO3GJ2WCpMOVEBfM1hnFNyw0j95an9sw/KCc0Yx+7UGGrl6WtBkOt1oDmR2B7rxfN5RxJt9vBPBIgwetoXBsGwq3QkBErAPlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGypKA2+; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGypKA2+"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3c8fe6bd1a2so864601f8f.1
        for <gfs2@lists.linux.dev>; Sat, 30 Aug 2025 03:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756548862; x=1757153662; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJJ9dbaqcQk9C+0KF8vYvnTTC9CJJz+LYDRwKiKuKVg=;
        b=aGypKA2+n89YYJ1H4FbqB7X2mRLWcAQHLj/zrDu3Qhc/4fwvD0aHBmM9lvYycBX8qC
         Zd29Ys+kIOmMaQEvF/tMilrVKHL9D22YyQE4JtnPs48FHfhd6fepMFLHT3ycMyiCCkAq
         gLSggkwYmf9IyUaGwicAVdC1aCzclskJMm0FCSTEhoyyROioiIjZMPrUp3ZfnTdL+An+
         gBokWiwx5W73b+x47uOS5Nwkby0c+Cu6dgEUOCbQjeG2qxjnJcbVuXWV0HTAtTh8waQP
         dASnaN9pdRJvNlUeLCKucS19qLe4S0UqZi+s8hvZiA5sJ1kPGz3hf1Lg1/uM0o9e+/Fl
         bRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756548862; x=1757153662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJJ9dbaqcQk9C+0KF8vYvnTTC9CJJz+LYDRwKiKuKVg=;
        b=o/yGkiXrrbM8CExG7DRAcaJzolHyoi5/c1t8Fj5OEm2okTSyJOjyXvmGAqMm5WFuS5
         k6uprgVst/1p7GFvlo8SeDijBj+mgKx+LLoczSZ+of2NJ9wJ3dKWy/VbG6GzlHcaXha7
         +JwYdmoRq2F4YmdMfdFSpqQHrto4KXR4617HvrHChV5+jNBhwGJXs3ULBxgVa0nANQN3
         eL1b48mPWtgxRlueXoGBfvnNBnBQzSer2BSH8Ot/C3zKXglwDEzfYRf2IID7fWtj06in
         8pLlu+ZdEww2xDSISPCuuJzUJvjLvNCNkGTxkoZyslMxj6S/IuzpK+TLTTolol1R07qK
         0h3Q==
X-Gm-Message-State: AOJu0Yz9aCobQR4eSrwaaWLQw/Pk1pYay8twFFrPgGQR1LBVSM0NbD4n
	xvYKjQr7Xq4okLPa9OQcL3Yo6BLlnZT5EoNaqLHSsuWgiLokHUJDZ+H6LkjqMZ1V4QWbpw==
X-Gm-Gg: ASbGncuq1OM5F2KTdOD+GKgdmqtv1U+N1zgQ3dgsa4xtbGAmUEMoPxsYuknRw+FKd3g
	MvB/qMxHT/7KlkynOfFWqvr/6BozIEUbhXcAMFvO74i5N3QTRJz6SG+ewkKMCOd7yoR818lB/I5
	Ev6AUPg8ZzttSKUo7gJz9VK/yfBsF3+hAVrg98PjectwhGolgIXRlgMnpl1Hal8TVuVFMlGrlco
	FS+chJ9s5yXfCow0okZKcyqHxFWkhUs8a5X5w+4bBIWLalbeSKERpHPc57s5rtxmlZaB5kyUyWa
	ZQkWgyMFUMjqa69HzUpz1iq9bfIZ3rav6szZJxk/msvvboXYbIGLGOjha47+mDdr5qWe/PWniph
	BWXPv/NpDOw+jzjR1p5q/EWVcFjkN3m0xgvgKV/53nSGjqSIkuwm9K1Du8Xq9Y+JtAGAaHnezz9
	rjXq0d6mOd6Gv82q6ZB0gl0p4aHurnT97LwySgXh6I8Mk/bB1xIguBGh7601JW0wQB2RLCsr3Zm
	y4qjrRgUSBcFCBIeFM=
X-Google-Smtp-Source: AGHT+IELIv6EcAmvuORiLX+6fjp5oy1NzXie/tgLW4mUGFvASuTDpPqQf3FYsv8jlxia0l8T/N20Rw==
X-Received: by 2002:a5d:5f8b:0:b0:3d1:d425:6a06 with SMTP id ffacd0b85a97d-3d1df34d73emr1067282f8f.55.1756548862156;
        Sat, 30 Aug 2025 03:14:22 -0700 (PDT)
Received: from local.station (net-93-148-93-71.cust.dsl.teletu.it. [93.148.93.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf275d2717sm6758790f8f.15.2025.08.30.03.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 03:14:21 -0700 (PDT)
From: Alessio Attilio <alessio.attilio.dev@gmail.com>
X-Google-Original-From: Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
To: gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	aahringo@redhat.com,
	teigland@redhat.com,
	Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
Subject: [PATCH 03/12] refactor: unify active/inactive logic in find_rsb_nodir
Date: Sat, 30 Aug 2025 12:14:04 +0200
Message-ID: <20250830101413.602637-3-226562783+SigAttilio@users.noreply.github.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250830101413.602637-1-226562783+SigAttilio@users.noreply.github.com>
References: <20250830101413.602637-1-226562783+SigAttilio@users.noreply.github.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 fs/dlm/lock.c | 355 ++++++++++++++++++++------------------------------
 1 file changed, 141 insertions(+), 214 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 0165b3b7e36a..c62ec235c047 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1068,269 +1068,196 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 		list_add(&r->res_slow_list, &ls->ls_slow_active);
 	}
 	write_unlock_bh(&ls->ls_rsbtbl_lock);
-
  out:
 	*r_ret = r;
 	return error;
 }
 
-/*
- * rsb rcu usage
- *
- * While rcu read lock is held, the rsb cannot be freed,
- * which allows a lookup optimization.
- *
- * Two threads are accessing the same rsb concurrently,
- * the first (A) is trying to use the rsb, the second (B)
- * is trying to free the rsb.
- *
- * thread A                 thread B
- * (trying to use rsb)      (trying to free rsb)
- *
- * A1. rcu read lock
- * A2. rsbtbl read lock
- * A3. look up rsb in rsbtbl
- * A4. rsbtbl read unlock
- *                          B1. rsbtbl write lock
- *                          B2. look up rsb in rsbtbl
- *                          B3. remove rsb from rsbtbl
- *                          B4. clear rsb HASHED flag
- *                          B5. rsbtbl write unlock
- *                          B6. begin freeing rsb using rcu...
- *
- * (rsb is inactive, so try to make it active again)
- * A5. read rsb HASHED flag (safe because rsb is not freed yet)
- * A6. the rsb HASHED flag is not set, which it means the rsb
- *     is being removed from rsbtbl and freed, so don't use it.
- * A7. rcu read unlock
- *
- *                          B7. ...finish freeing rsb using rcu
- * A8. create a new rsb
- *
- * Without the rcu optimization, steps A5-8 would need to do
- * an extra rsbtbl lookup:
- * A5. rsbtbl write lock
- * A6. look up rsb in rsbtbl, not found
- * A7. rsbtbl write unlock
- * A8. create a new rsb
- */
+/* During recovery, other nodes can send us new MSTCPY locks (from
+   dlm_recover_locks) before we've made ourself master (in
+   dlm_recover_masters). */
 
-static int find_rsb(struct dlm_ls *ls, const void *name, int len,
-		    int from_nodeid, unsigned int flags,
-		    struct dlm_rsb **r_ret)
+static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
+			  uint32_t hash, int dir_nodeid, int from_nodeid,
+			  unsigned int flags, struct dlm_rsb **r_ret)
 {
-	int dir_nodeid;
-	uint32_t hash;
-	int rv;
+	struct dlm_rsb *r = NULL;
+	int our_nodeid = dlm_our_nodeid();
+	int recover = (flags & R_RECEIVE_RECOVER);
+	int error;
 
-	if (len > DLM_RESNAME_MAXLEN)
-		return -EINVAL;
+ retry:
+	error = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
+	if (error)
+		goto do_new;
 
-	hash = jhash(name, len, 0);
-	dir_nodeid = dlm_hash2nodeid(ls, hash);
+	/* check if the rsb is in active state under read lock - likely path */
+	read_lock_bh(&ls->ls_rsbtbl_lock);
+	if (!rsb_flag(r, RSB_HASHED)) {
+		read_unlock_bh(&ls->ls_rsbtbl_lock);
+		goto do_new;
+	}
 
-	rcu_read_lock();
-	if (dlm_no_directory(ls))
-		rv = find_rsb_nodir(ls, name, len, hash, dir_nodeid,
-				      from_nodeid, flags, r_ret);
-	else
-		rv = find_rsb_dir(ls, name, len, hash, dir_nodeid,
-				    from_nodeid, flags, r_ret);
-	rcu_read_unlock();
-	return rv;
-}
+	if (rsb_flag(r, RSB_INACTIVE)) {
+		read_unlock_bh(&ls->ls_rsbtbl_lock);
+		goto do_inactive;
+	}
 
-/* we have received a request and found that res_master_nodeid != our_nodeid,
-   so we need to return an error or make ourself the master */
+	/*
+	 * rsb is active, so we can't check master_nodeid without lock_rsb.
+	 */
 
-static int validate_master_nodeid(struct dlm_ls *ls, struct dlm_rsb *r,
-				  int from_nodeid)
-{
-	if (dlm_no_directory(ls)) {
-		log_error(ls, "find_rsb keep from_nodeid %d master %d dir %d",
-			  from_nodeid, r->res_master_nodeid,
-			  r->res_dir_nodeid);
-		dlm_print_rsb(r);
-		return -ENOTBLK;
-	}
+	kref_get(&r->res_ref);
+	read_unlock_bh(&ls->ls_rsbtbl_lock);
+
+	goto out;
 
-	if (from_nodeid != r->res_dir_nodeid) {
-		/* our rsb is not master, and another node (not the dir node)
-	   	   has sent us a request.  this is much more common when our
-	   	   master_nodeid is zero, so limit debug to non-zero.  */
 
-		if (r->res_master_nodeid) {
-			log_debug(ls, "validate master from_other %d master %d "
-				  "dir %d first %x %s", from_nodeid,
-				  r->res_master_nodeid, r->res_dir_nodeid,
-				  r->res_first_lkid, r->res_name);
+ do_inactive:
+	write_lock_bh(&ls->ls_rsbtbl_lock);
+
+	/* See comment in find_rsb_dir. */
+	if (rsb_flag(r, RSB_HASHED)) {
+		if (!rsb_flag(r, RSB_INACTIVE)) {
+			write_unlock_bh(&ls->ls_rsbtbl_lock);
+			goto retry;
 		}
-		return -ENOTBLK;
 	} else {
-		/* our rsb is not master, but the dir nodeid has sent us a
-	   	   request; this could happen with master 0 / res_nodeid -1 */
-
-		if (r->res_master_nodeid) {
-			log_error(ls, "validate master from_dir %d master %d "
-				  "first %x %s",
-				  from_nodeid, r->res_master_nodeid,
-				  r->res_first_lkid, r->res_name);
-		}
+		write_unlock_bh(&ls->ls_rsbtbl_lock);
+		goto do_new;
+	}
+
+
+	/*
+	 * rsb found inactive. No other thread is using this rsb because
+	 * it's inactive, so we can look at or update res_master_nodeid
+	 * without lock_rsb.
+	 */
+
+	if (!recover && (r->res_master_nodeid != our_nodeid) && from_nodeid) {
+		/* our rsb is not master, and another node has sent us a
+		   request; this should never happen */
+		log_error(ls, "find_rsb inactive from_nodeid %d master %d dir %d",
+			  from_nodeid, r->res_master_nodeid, dir_nodeid);
+		write_unlock_bh(&ls->ls_rsbtbl_lock);
+		error = -ENOTBLK;
+		goto out;
+	}
 
-		r->res_master_nodeid = dlm_our_nodeid();
+	if (!recover && (r->res_master_nodeid != our_nodeid) &&
+	    (dir_nodeid == our_nodeid)) {
+		/* our rsb is not master, and we are dir; may as well fix it;
+		   this should never happen */
+		log_error(ls, "find_rsb inactive our %d master %d dir %d",
+			  our_nodeid, r->res_master_nodeid, dir_nodeid);
+		dlm_print_rsb(r);
+		r->res_master_nodeid = our_nodeid;
 		r->res_nodeid = 0;
-		return 0;
 	}
-}
 
-static void __dlm_master_lookup(struct dlm_ls *ls, struct dlm_rsb *r, int our_nodeid,
-				int from_nodeid, bool is_inactive, unsigned int flags,
-				int *r_nodeid, int *result)
-{
-	int fix_master = (flags & DLM_LU_RECOVER_MASTER);
-	int from_master = (flags & DLM_LU_RECOVER_DIR);
+	del_scan(ls, r);
+	list_move(&r->res_slow_list, &ls->ls_slow_active);
+	rsb_clear_flag(r, RSB_INACTIVE);
+	kref_init(&r->res_ref); /* ref is now used in active state */
+	write_unlock_bh(&ls->ls_rsbtbl_lock);
 
-	if (r->res_dir_nodeid != our_nodeid) {
-		/* should not happen, but may as well fix it and carry on */
-		log_error(ls, "%s res_dir %d our %d %s", __func__,
-			  r->res_dir_nodeid, our_nodeid, r->res_name);
-		r->res_dir_nodeid = our_nodeid;
-	}
+	goto out;
 
-	if (fix_master && r->res_master_nodeid && dlm_is_removed(ls, r->res_master_nodeid)) {
-		/* Recovery uses this function to set a new master when
-		 * the previous master failed.  Setting NEW_MASTER will
-		 * force dlm_recover_masters to call recover_master on this
-		 * rsb even though the res_nodeid is no longer removed.
-		 */
 
-		r->res_master_nodeid = from_nodeid;
-		r->res_nodeid = from_nodeid;
-		rsb_set_flag(r, RSB_NEW_MASTER);
+ do_new:
+	/*
+	 * rsb not found
+	 */
 
-		if (is_inactive) {
-			/* I don't think we should ever find it inactive. */
-			log_error(ls, "%s fix_master inactive", __func__);
-			dlm_dump_rsb(r);
-		}
-	}
+	if (error == -EBADR && !create)
+		goto out;
 
-	if (from_master && (r->res_master_nodeid != from_nodeid)) {
-		/* this will happen if from_nodeid became master during
-		 * a previous recovery cycle, and we aborted the previous
-		 * cycle before recovering this master value
-		 */
+	error = get_rsb_struct(ls, name, len, &r);
+	if (WARN_ON_ONCE(error))
+		goto out;
 
-		log_limit(ls, "%s from_master %d master_nodeid %d res_nodeid %d first %x %s",
-			  __func__, from_nodeid, r->res_master_nodeid,
-			  r->res_nodeid, r->res_first_lkid, r->res_name);
+	r->res_hash = hash;
+	r->res_dir_nodeid = dir_nodeid;
+	kref_init(&r->res_ref);
 
-		if (r->res_master_nodeid == our_nodeid) {
-			log_error(ls, "from_master %d our_master", from_nodeid);
-			dlm_dump_rsb(r);
-			goto ret_assign;
-		}
+	if (from_dir) {
+		/* want to see how often this happens */
+		log_debug(ls, "find_rsb new from_dir %d recreate %s",
+			  from_nodeid, r->res_name);
+		r->res_master_nodeid = our_nodeid;
+		r->res_nodeid = 0;
+		goto out_add;
+	}
 
-		r->res_master_nodeid = from_nodeid;
-		r->res_nodeid = from_nodeid;
-		rsb_set_flag(r, RSB_NEW_MASTER);
+	if (from_other && (dir_nodeid != our_nodeid)) {
+		/* should never happen */
+		log_error(ls, "find_rsb new from_other %d dir %d our %d %s",
+			  from_nodeid, dir_nodeid, our_nodeid, r->res_name);
+		dlm_free_rsb(r);
+		r = NULL;
+		error = -ENOTBLK;
+		goto out;
 	}
 
-	if (!r->res_master_nodeid) {
-		/* this will happen if recovery happens while we're looking
-		 * up the master for this rsb
-		 */
+	if (from_other) {
+		log_debug(ls, "find_rsb new from_other %d dir %d %s",
+			  from_nodeid, dir_nodeid, r->res_name);
+	}
 
-		log_debug(ls, "%s master 0 to %d first %x %s", __func__,
-			  from_nodeid, r->res_first_lkid, r->res_name);
-		r->res_master_nodeid = from_nodeid;
-		r->res_nodeid = from_nodeid;
+	if (dir_nodeid == our_nodeid) {
+		/* When we are the dir nodeid, we can set the master
+		   node immediately */
+		r->res_master_nodeid = our_nodeid;
+		r->res_nodeid = 0;
+	} else {
+		/* set_master will send_lookup to dir_nodeid */
+		r->res_master_nodeid = 0;
+		r->res_nodeid = -1;
 	}
 
-	if (!from_master && !fix_master &&
-	    (r->res_master_nodeid == from_nodeid)) {
-		/* this can happen when the master sends remove, the dir node
-		 * finds the rsb on the active list and ignores the remove,
-		 * and the former master sends a lookup
-		 */
+ out_add:
 
-		log_limit(ls, "%s from master %d flags %x first %x %s",
-			  __func__, from_nodeid, flags, r->res_first_lkid,
-			  r->res_name);
+	write_lock_bh(&ls->ls_rsbtbl_lock);
+	error = rsb_insert(r, &ls->ls_rsbtbl);
+	if (error == -EEXIST) {
+		/* somebody else was faster and it seems the
+		 * rsb exists now, we do a whole relookup
+		 */
+		write_unlock_bh(&ls->ls_rsbtbl_lock);
+		dlm_free_rsb(r);
+		goto retry;
+	} else if (!error) {
+		list_add(&r->res_slow_list, &ls->ls_slow_active);
 	}
-
- ret_assign:
-	*r_nodeid = r->res_master_nodeid;
-	if (result)
-		*result = DLM_LU_MATCH;
+	write_unlock_bh(&ls->ls_rsbtbl_lock);
+ out:
+	*r_ret = r;
+	return error;
 }
 
-/*
- * We're the dir node for this res and another node wants to know the
- * master nodeid.  During normal operation (non recovery) this is only
- * called from receive_lookup(); master lookups when the local node is
- * the dir node are done by find_rsb().
- *
- * normal operation, we are the dir node for a resource
- * . _request_lock
- * . set_master
- * . send_lookup
- * . receive_lookup
- * . dlm_master_lookup flags 0
- *
- * recover directory, we are rebuilding dir for all resources
- * . dlm_recover_directory
- * . dlm_rcom_names
- *   remote node sends back the rsb names it is master of and we are dir of
- * . dlm_master_lookup RECOVER_DIR (fix_master 0, from_master 1)
- *   we either create new rsb setting remote node as master, or find existing
- *   rsb and set master to be the remote node.
- *
- * recover masters, we are finding the new master for resources
- * . dlm_recover_masters
- * . recover_master
- * . dlm_send_rcom_lookup
- * . receive_rcom_lookup
- * . dlm_master_lookup RECOVER_MASTER (fix_master 1, from_master 0)
- */
+/* During recovery, other nodes can send us new MSTCPY locks (from
+   dlm_recover_locks) before we've made ourself master (in
+   dlm_recover_masters). */
 
-static int _dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
-			      int len, unsigned int flags, int *r_nodeid, int *result)
+static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
+			  uint32_t hash, int dir_nodeid, int from_nodeid,
+			  unsigned int flags, struct dlm_rsb **r_ret)
 {
 	struct dlm_rsb *r = NULL;
-	uint32_t hash;
 	int our_nodeid = dlm_our_nodeid();
-	int dir_nodeid, error;
-
-	if (len > DLM_RESNAME_MAXLEN)
-		return -EINVAL;
-
-	if (from_nodeid == our_nodeid) {
-		log_error(ls, "dlm_master_lookup from our_nodeid %d flags %x",
-			  our_nodeid, flags);
-		return -EINVAL;
-	}
-
-	hash = jhash(name, len, 0);
-	dir_nodeid = dlm_hash2nodeid(ls, hash);
-	if (dir_nodeid != our_nodeid) {
-		log_error(ls, "dlm_master_lookup from %d dir %d our %d h %x %d",
-			  from_nodeid, dir_nodeid, our_nodeid, hash,
-			  ls->ls_num_nodes);
-		*r_nodeid = -1;
-		return -EINVAL;
-	}
+	int recover = (flags & R_RECEIVE_RECOVER);
+	int error;
 
  retry:
 	error = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
 	if (error)
-		goto not_found;
+		goto do_new;
 
-	/* check if the rsb is active under read lock - likely path */
+	/* check if the rsb is in active state under read lock - likely path */
 	read_lock_bh(&ls->ls_rsbtbl_lock);
 	if (!rsb_flag(r, RSB_HASHED)) {
 		read_unlock_bh(&ls->ls_rsbtbl_lock);
-		goto not_found;
+		goto do_new;
 	}
 
 	if (rsb_flag(r, RSB_INACTIVE)) {
-- 
2.48.1


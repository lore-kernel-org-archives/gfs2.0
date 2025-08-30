Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B555726E6F0
	for <gfs2@lists.linux.dev>; Sat, 30 Aug 2025 10:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756548867; cv=none; b=gQiKjrq73LlDT4tqbi9Gu8mV9gvijNZG6m/PKUQjuIHq842rRN4cJf2Z/g9g07b4WDGp3XTlimIUJWpbeXJDjSBiGbhn2lnYci0lAwkIceaCFBzMr9NvcngJLRiqpYOM8VTBk9xGR4RXTjDzraiJ15zZUVqXHpH9yjT3MtV3ryY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756548867; c=relaxed/simple;
	bh=0H8upeMCBiIlgPWCih17kcD59k9Wc8/nlE7Rf2FKpjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sN+7OQdYnp4SwKvaMYuMsniDJ+E8fAAy7RUjDE7bqPL8pdNZRuz7i6yo7ONool60KIRR3W+N8AHA8qtfaIuU0Tii46zNdDG2CDVnaNaNGmyrbKCmGy5XqeCf1uq3zRPbjFjPEYn5JfQ2BNo9BiJ5Ce60YXBKC2dX33nTWvd3DR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKTRF8gu; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKTRF8gu"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso2248747f8f.3
        for <gfs2@lists.linux.dev>; Sat, 30 Aug 2025 03:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756548863; x=1757153663; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeY1cTx0A9tt639AWyhl3UrwoNAsYdIDU0iO9qjGd+Q=;
        b=jKTRF8guEz27vT+1kn++aUxgVZMapoUHWb4QfDg7sY7YIm1jUtI8EZ9YsNpZM1L2o/
         lfTGPBBsN11dj4voiZAOI1TBZYaVgsTAFeggcOew+1IhT+8KDBvdrIXlVlryBsDK+wwt
         w6w6ghBIbzNW8OkwDCcbNuF++lR9Oy+w3D/2Dfrgz5NL/Zl0xiFSXX6X4pd7R1cveNgu
         +H8lI/33jdu37wU7DQSm81NN+2OLbf+PJ22BDMRJ1n69hNLeUClA876NQvfMCElE7em6
         R4iVGKle5vGs1sYVZUuXwt3j9MXMaC/9H3jZMRhobN52rDk+njV3zZjlx4bTt+WZ5te4
         4WSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756548863; x=1757153663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EeY1cTx0A9tt639AWyhl3UrwoNAsYdIDU0iO9qjGd+Q=;
        b=npV3R/CN7HYaeFEEwIPE+W0L+YOG6SKi9cCGz0OISsBN1GldTOQsLUHPMi+8ntbElY
         YQSCKYKHk1Qjvma5VdFZX6N87DPoJGAI2UiHK01Gwgzggev5oyGFha0PFxu6t49zxcpB
         dhDzIgwy1DdPVCFMeYmbE55iu0DNJpPyyV5EJiNsnt07Xy+PfCSjEnjJEvljHGO4p70Z
         yKb/jVYLJhqLyFhFMGwjqvuqbX/A9vx12njBiNdxgI2HapwA/9R9wpA7kuGoSx3DhjTp
         dhSVg6jkTBCXGSyhpKMEBysAeeaJmuHVayTKAHjAIM4UBl13R40Y4oNPwXk1XBUQ2Met
         2LRg==
X-Gm-Message-State: AOJu0YzEFCaZfCH5h0LSow+rC38GTfr7IEO2P4RwShjge7rSrboyKldh
	kg+K4PLZDdLL4O37Q7KRQwL+gtXeIblYtmpiZYRdgqDDsM/PVDM87BIyipAg1eceWoeFBg==
X-Gm-Gg: ASbGncse3zBMrs/ezJmqirfZmHVvrdDfH2jyUI58ZRUcc40QnKnkUwQ82GVRCoRbweg
	6kyY1qHzPQG3G11CCQkoRakDvVLSL2Knbtqz/Q+HPZ3dgVZjxestmAiUR+qK/wrpVtZPgUuuasS
	fjotLHv48i4ZZiRevdi+X2Yx39moIMVmKOqnLcSp83Ns+YDDZpYHbxqXKQmEJuGGLZ+sdXdd90G
	7ibfGkqgNKk3qybh0iz0NVNfr2euBZ+tKWdLxDkJSkETOO2vadUjFDNuNNAqAqCJ6aGVXKL4EN5
	2Zzf/Hc/8LXxoWF4FwMgdtqQjhPUepd9Ak2F0WHAVBharLMpeGeyyTVMU/xEpk7ucB6aNin7ySr
	uH9yaYqtCRULO/nnErxwUOhP1l210uohT9reKH8u7YEJO824lFHgi4/3ikLgQIJr2ucDHJ9qi69
	HuF/V9+NkUfpz6vJHSsmR1LURhc9fQUizDAfuz8ccLQ+7nlEcdz3p0ZUzE3vOZ4/PkKMUoHaWab
	zE+BOwkf0lTKN40Lr89d9nKf7ZISA==
X-Google-Smtp-Source: AGHT+IHa9vtUH8SZHOCaW16YYswy/rsRTCPtSre+83Oyx/za744bIPxfAlah5IEXb/vFgUJLZYCFvw==
X-Received: by 2002:a05:6000:26cb:b0:3ca:3206:29f with SMTP id ffacd0b85a97d-3d1de4bc29emr1144928f8f.40.1756548863061;
        Sat, 30 Aug 2025 03:14:23 -0700 (PDT)
Received: from local.station (net-93-148-93-71.cust.dsl.teletu.it. [93.148.93.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf275d2717sm6758790f8f.15.2025.08.30.03.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 03:14:22 -0700 (PDT)
From: Alessio Attilio <alessio.attilio.dev@gmail.com>
X-Google-Original-From: Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
To: gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	aahringo@redhat.com,
	teigland@redhat.com,
	Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
Subject: [PATCH 04/12] fix(find_rsb_nodir): corrects the management of inactive rsb and the creation of new rsb
Date: Sat, 30 Aug 2025 12:14:05 +0200
Message-ID: <20250830101413.602637-4-226562783+SigAttilio@users.noreply.github.com>
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
 fs/dlm/lock.c | 118 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 84 insertions(+), 34 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index c62ec235c047..de77a0e9e2db 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1265,69 +1265,119 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 		goto do_inactive;
 	}
 
-	/* because the rsb is active, we need to lock_rsb before
-	 * checking/changing re_master_nodeid
+	/*
+	 * rsb is active, so we can't check master_nodeid without lock_rsb.
 	 */
 
-	hold_rsb(r);
+	kref_get(&r->res_ref);
 	read_unlock_bh(&ls->ls_rsbtbl_lock);
-	lock_rsb(r);
-
-	__dlm_master_lookup(ls, r, our_nodeid, from_nodeid, false,
-			    flags, r_nodeid, result);
 
-	/* the rsb was active */
-	unlock_rsb(r);
-	put_rsb(r);
+	goto out;
 
-	return 0;
 
  do_inactive:
-	/* unlikely path - check if still part of ls_rsbtbl */
 	write_lock_bh(&ls->ls_rsbtbl_lock);
 
-	/* see comment in find_rsb_dir */
+	/* See comment in find_rsb_dir. */
 	if (rsb_flag(r, RSB_HASHED)) {
 		if (!rsb_flag(r, RSB_INACTIVE)) {
 			write_unlock_bh(&ls->ls_rsbtbl_lock);
-			/* something as changed, very unlikely but
-			 * try again
-			 */
 			goto retry;
 		}
 	} else {
 		write_unlock_bh(&ls->ls_rsbtbl_lock);
-		goto not_found;
+		goto do_new;
 	}
 
-	/* because the rsb is inactive, it's not refcounted and lock_rsb
-	   is not used, but is protected by the rsbtbl lock */
-
-	__dlm_master_lookup(ls, r, our_nodeid, from_nodeid, true, flags,
-			    r_nodeid, result);
 
-	/* A dir record rsb should never be on scan list.
-	 * Except when we are the dir and master node.
-	 * This function should only be called by the dir
-	 * node.
+	/*
+	 * rsb found inactive. No other thread is using this rsb because
+	 * it's inactive, so we can look at or update res_master_nodeid
+	 * without lock_rsb.
 	 */
-	WARN_ON(!list_empty(&r->res_scan_list) &&
-		r->res_master_nodeid != our_nodeid);
 
+	if (!recover && (r->res_master_nodeid != our_nodeid) && from_nodeid) {
+		/* our rsb is not master, and another node has sent us a
+		   request; this should never happen */
+		log_error(ls, "find_rsb inactive from_nodeid %d master %d dir %d",
+			  from_nodeid, r->res_master_nodeid, dir_nodeid);
+		write_unlock_bh(&ls->ls_rsbtbl_lock);
+		error = -ENOTBLK;
+		goto out;
+	}
+
+	if (!recover && (r->res_master_nodeid != our_nodeid) &&
+	    (dir_nodeid == our_nodeid)) {
+		/* our rsb is not master, and we are dir; may as well fix it;
+		   this should never happen */
+		log_error(ls, "find_rsb inactive our %d master %d dir %d",
+			  our_nodeid, r->res_master_nodeid, dir_nodeid);
+		dlm_print_rsb(r);
+		r->res_master_nodeid = our_nodeid;
+		r->res_nodeid = 0;
+	}
+
+	del_scan(ls, r);
+	list_move(&r->res_slow_list, &ls->ls_slow_active);
+	rsb_clear_flag(r, RSB_INACTIVE);
+	kref_init(&r->res_ref); /* ref is now used in active state */
 	write_unlock_bh(&ls->ls_rsbtbl_lock);
 
-	return 0;
+	goto out;
+
+
+ do_new:
+	/*
+	 * rsb not found
+	 */
+
+	if (error == -EBADR && !create)
+		goto out;
 
- not_found:
 	error = get_rsb_struct(ls, name, len, &r);
 	if (WARN_ON_ONCE(error))
 		goto out;
 
 	r->res_hash = hash;
-	r->res_dir_nodeid = our_nodeid;
-	r->res_master_nodeid = from_nodeid;
-	r->res_nodeid = from_nodeid;
-	rsb_set_flag(r, RSB_INACTIVE);
+	r->res_dir_nodeid = dir_nodeid;
+	kref_init(&r->res_ref);
+
+	if (from_dir) {
+		/* want to see how often this happens */
+		log_debug(ls, "find_rsb new from_dir %d recreate %s",
+			  from_nodeid, r->res_name);
+		r->res_master_nodeid = our_nodeid;
+		r->res_nodeid = 0;
+		goto out_add;
+	}
+
+	if (from_other && (dir_nodeid != our_nodeid)) {
+		/* should never happen */
+		log_error(ls, "find_rsb new from_other %d dir %d our %d %s",
+			  from_nodeid, dir_nodeid, our_nodeid, r->res_name);
+		dlm_free_rsb(r);
+		r = NULL;
+		error = -ENOTBLK;
+		goto out;
+	}
+
+	if (from_other) {
+		log_debug(ls, "find_rsb new from_other %d dir %d %s",
+			  from_nodeid, dir_nodeid, r->res_name);
+	}
+
+	if (dir_nodeid == our_nodeid) {
+		/* When we are the dir nodeid, we can set the master
+		   node immediately */
+		r->res_master_nodeid = our_nodeid;
+		r->res_nodeid = 0;
+	} else {
+		/* set_master will send_lookup to dir_nodeid */
+		r->res_master_nodeid = 0;
+		r->res_nodeid = -1;
+	}
+
+ out_add:
 
 	write_lock_bh(&ls->ls_rsbtbl_lock);
 	error = rsb_insert(r, &ls->ls_rsbtbl);
-- 
2.48.1


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792435746;
	b=atI7jrtwHuGtpM0tlE/RPWED8O9bWmte9C2ZHIZrvKgLxFqiBbSOdyjUv2KRrnUsN8AL
	 Z718eZiD024wMgNGTg9mrN64TOwzkDARE6nAwrJYRN+w/dQHJ52t6QMMNAQ++VCOYBmCE
	 MOYRGhbfNZqLGt1Kh/TgM2tvkoaHT9I+tlj+PN87VuuMCSONdJJeihtwtuHFITzkXo6z1
	 awoYqFQgG71V8vVAyJD/V8hXvIRCMy5ZB/P5iBuuW71T+/QsTPHcNW04G35Z0mwHEmhBv
	 ARwUPck9qxuJtvfGboKWbbHtfFq7J91sHBG1VWlxlAm0SdO35mT8K7Cb7fG3RzY4Skw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792435746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=GAXZCV5m9JMQykLn0Ukn1ebbST4LlX+DTEB51yMeYSo=;
	b=DrIYWmHqumKVMxeAmi3SxgLmkYD+MdjVCMyh3GH19qMG6NAbUBB2o7y1NTd/APU2CNpX
	 j5nOFdk1hIiiGYN5djRpi4Cs4fCFEi455Y5GGJH7teMMp+I60/8cg1Jd8ZI1yX+ELy2zP
	 X/FL847XKQ35vdYkItjHV64JpH7hRjF0tUvarjrM4YVPiFnYZuYlartOdT2d1PDKIsfrP
	 +UgY8YuA0fArKAX29pa5rhE7FagHUXy5oT5tSQGmGDcXKaMHWorMPGslYl8yMBtF/0CnI
	 RzGZr26lGw2FlmnnBykQwMyiDpeY9YhMmFYebvi9s8Wmmx3GRuD9KtDcq236Va1gotQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c1t2BzQI;
	arc=none smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D446606A319
	for <gfs2@lists.linux.dev>; Mon, 19 Oct 2026 18:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D446606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c1t2BzQI
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9906110d39cso48050241.1
        for <gfs2@lists.linux.dev>; Mon, 19 Oct 2026 11:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792435745; x=1793040545; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GAXZCV5m9JMQykLn0Ukn1ebbST4LlX+DTEB51yMeYSo=;
        b=c1t2BzQIQ3tzI7bRG4exvekSaurndbJS6tSCgtrj7T1l4b8Lam4ALf/lXzb7KS/uTT
         C4Cd4qYz5CA81oVUkMIHgPBSoe3rkT3V1QYzPYsFxQlL6/62DG+/pVfTE4VBFvsE/SLq
         x2Srk+V+/9HXluE5Gq5hXbOds6aa9uA6GSsbaulQ0GHhzdmF3NrDixEPgefK00CShs9h
         b3vAfl+nT3xAAphw4OphpFsjET/xN1f183dTjyT5WvrneVIdM2hrwv7DnlyYgwQMspBh
         YM404bdEcm4Z/c85hCByCdre0GHDqEB90ZzAW4tmwA1k2YRyk/5Va8qgC7lL5G1aO5cS
         eMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792435745; x=1793040545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GAXZCV5m9JMQykLn0Ukn1ebbST4LlX+DTEB51yMeYSo=;
        b=vg5PJ5XJGZoZvmWi0xebHJEFJpFc7u5mLEVFLph3b4ZwRQz2qGe02iI3wJz3xcl70M
         80XH4HS3M/Inza/ucUBB/lLIsT/sEta0PhtBK3wVDZKQR1BPgeK3Samprcnvi8W+RH0+
         xjZYSZ22WkxBod0QnmD12qV+j1Vd3bU5u/VVfdLes3x4soHHJvEj/8+OL73TllkeF3zc
         yznppmtbn65eg/Rfr8ohV5QBaQg3/kwwqPG+XoY1A3stKQnAhfLeYSyaxjt8TLaap2OI
         tspFx1WqJYFqI22Vra/2uR2SONuFQvAdG7wFbUTHUZKyQebpdoud0HxSg/Lbp8OyMvJX
         Ryqg==
X-Gm-Message-State: AFq9FYKZbHBeA6TKvNZlvGTPLk24rjqYxkCsjW41UrinNJr8SxrMOP9N
	QNgsnp0IAoRE2XyW+kcC1Kx87vYZ/fbOfGfcYLCLjacdhmijHIl7hVq6
X-Gm-Gg: AYBFou32VEIC8kRzk8IabhEfhFPMba/c9yWgfmxN5DofupfsrjVOvmjRMSvSNI+kIwi
	ATFSQjNouroj20+7gVORbo6TJpJbo96lKdct5pMF27dtJ8umLfvfV8P7+Z52Wy//q1wLU28WE33
	nytIJ4Y7EFhfWPECl5J/4ubR+8sjWWRkBeLMZyP4PP2AlIeS0JW6m4V6Z4mbHF04RfNEOaFb6kg
	Xt0ShsgIJq1zSffIqVU3Gej/VoVhmFbiyDlqZw6UgtmpPuStTxARQ+N+My8Cl9jlpuLGMDGm3fc
	PBlw0oiQ1GggxPUHhT3gTCneU7Akg2y8flBeHzMqKLa7/4NP/qjZ3jmJZsAl3goMSJyPp6m2ZaA
	Z3puI4GzFH9Tt0UCI5D1GgGCykQPHkeiKSuGYWG8/aP8BufkzQDanpp8k0k8Yaq4C6cSFBlubTH
	WNzQ0CWjM0MLKp5fD5zqTYbobRioRcH6ymn8xY6EAm+yWYXnTOuC3pgwpO+hlxPkDHkjVHak0Q6
	f+vOocpUDE4/cFbBfilf0W6upMZM/I38XIuF1OzMr2EZcqJ3wyST9VtZq5YEoV1bjUA9gnMulTN
	29B9AFbZl4Z8H/p30HU=
X-Received: by 2002:a05:6122:8107:b0:5ea:b7b5:454 with SMTP id 71dfb90a1353d-5eab7b5070bmr1354058e0c.1.1792435745253;
        Mon, 19 Oct 2026 11:49:05 -0700 (PDT)
Received: from localhost.localdomain ([132.170.205.109])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea9b53cfdfsm10488632e0c.15.2026.10.19.11.49.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Oct 2026 11:49:02 -0700 (PDT)
From: Sanan Hasanov <sanan.hasanou@gmail.com>
To: Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+b2b8d04ec4914f618d23@syzkaller.appspotmail.com,
	Sanan Hasanov <sanan.hasanov@ucf.edu>,
	stable@vger.kernel.org
Subject: [PATCH] dlm: don't put an uninitialized lockspace kobject on error
Date: Mon, 19 Oct 2026 14:48:49 -0400
Message-ID: <20261019184849.24422-1-sanan.hasanou@gmail.com>
X-Mailer: git-send-email 2.48.1
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanan Hasanov <sanan.hasanov@ucf.edu>

Commit 8a4cf500f1dd ("dlm: drop kobject release callback handling")
dropped the do_unreg flag from new_lockspace() and made the out_lsfree
error label call kobject_put(&ls->ls_kobj) unconditionally. But ls_kobj
is only initialized by kobject_init_and_add() after the callback
workqueue and dlm_recoverd have been started, so every failure before
that point puts a kobject that was never initialized:

  dlm: ls_6035_1: can't start dlm_callback -12
  kobject: '(null)' (ffff888027a28088): is not initialized, yet kobject_put() is being called.
  WARNING: lib/kobject.c:736 at kobject_put+0x66/0x550 lib/kobject.c:734
  Call Trace:
   new_lockspace fs/dlm/lockspace.c:617 [inline]
   __dlm_new_lockspace+0x1714/0x1cd0 fs/dlm/lockspace.c:638
   device_create_lockspace+0xc7/0x350 fs/dlm/user.c:414
   device_write+0x872/0xed0 fs/dlm/user.c:606
   vfs_write+0x296/0xba0 fs/read_write.c:685

syzbot hits this by sending SIGKILL to a task creating a lockspace
through /dev/dlm-control, so that alloc_ordered_workqueue() in
dlm_callback_start() fails to create its rescuer thread. The same
happens if rhashtable_init(), the ls_recover_buf allocation or
dlm_recoverd_start() fail.

Bring the flag back so the kobject is only put once
kobject_init_and_add() has been called. Since the kobject no longer
frees the lockspace, kfree(ls) still runs on every error path.

Fixes: 8a4cf500f1dd ("dlm: drop kobject release callback handling")
Reported-by: syzbot+b2b8d04ec4914f618d23@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b2b8d04ec4914f618d23
Cc: stable@vger.kernel.org
Signed-off-by: Sanan Hasanov <sanan.hasanov@ucf.edu>
---
 fs/dlm/lockspace.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index a9c98b4f37..443421e945 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -364,6 +364,7 @@ static int new_lockspace(const char *name, const char *cluster,
 			 int *ops_result, dlm_lockspace_t **lockspace)
 {
 	struct dlm_ls *ls;
+	int do_unreg = 0;
 	int namelen = strlen(name);
 	int error;
 
@@ -567,6 +568,9 @@ static int new_lockspace(const char *name, const char *cluster,
 	wait_event(ls->ls_recover_lock_wait,
 		   test_bit(LSFL_RECOVER_LOCK, &ls->ls_flags));
 
+	/* ls_kobj must only be put once kobject_init_and_add() ran */
+	do_unreg = 1;
+
 	ls->ls_kobj.kset = dlm_kset;
 	error = kobject_init_and_add(&ls->ls_kobj, &dlm_ktype, NULL,
 				     "%s", ls->ls_name);
@@ -614,7 +618,8 @@ static int new_lockspace(const char *name, const char *cluster,
 	xa_destroy(&ls->ls_lkbxa);
 	rhashtable_destroy(&ls->ls_rsbtbl);
  out_lsfree:
-	kobject_put(&ls->ls_kobj);
+	if (do_unreg)
+		kobject_put(&ls->ls_kobj);
 	kfree(ls);
  out:
 	module_put(THIS_MODULE);
-- 
2.34.1


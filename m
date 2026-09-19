Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014C8282F0C
	for <gfs2@lists.linux.dev>; Sat, 19 Sep 2026 17:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789839475; cv=none; b=cdqjU0oIDEThvWzA1BFQ/16Ae59d1QV/3vzKmE/kwY6XvtGW7NsNHOsKINL0Ik/7CXewP9//APBX1/krdelOoZGsllLZuQe0yfPAjUrFm2XXRGSI4vCqTuszN5RW7DNwsLSauKEXLQOYazcgWyF3L8EJ0XX8u/72SvFMqCCRMS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789839475; c=relaxed/simple;
	bh=A+LU2lOUO2STiPMwRjdZHK8qHreRR1b/wRLSvRu1GUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kVEImVRHRg4KpHkN4Jb3AMm9npbE1hN5ctpdG8V8yCuYVd0KDl+hvX+kuCI/cZBDY39Ui1Mq493m/5sMcc6Iyne/I2fXxRgmaEdbP81nOp05x2nLO7NZ2qFwqet3cflxIBVITCf3wjnSLg9TFQ0shE8JjtxMxXC3hFU8Vif8xxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDHPYO1Q; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDHPYO1Q"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b9184fa80so1639877a91.2
        for <gfs2@lists.linux.dev>; Sat, 19 Sep 2026 10:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789839473; x=1790444273; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/+svSdwCuLzAYpRiv4o3QatmA9OQccLmNnyQlBGEnHs=;
        b=IDHPYO1QBkRhLbiLX1VFbpkpJOUN/qN3wB1ncb5pYybpblZiIG1KNmU7ZWwv4Vnnlk
         bdwmHcDw9fokHzagZ5PEzw9MUL46Il63ADhqvxWCzgjjwxiSSa2bxtSwclpldRoFFVmc
         9R/BnzKaO/6w/nS/EVAI6pbmgDX3cvSLlTdiBeDmUoqc3DybZLlCC7A09lRvrUWrVl+j
         tCKYEohWLpWh/6JfKbwH07FT2nXGE7XDiaE2V2WoULm9C5LgGirjFqMw8nfPBICvKXUH
         OMhWsF8ykc0+35HWxL9zt7NkpKncsqccrsFofhP1zy6KIRIwdVQqoXlNWkLZoJEROFDm
         Ptvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789839473; x=1790444273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/+svSdwCuLzAYpRiv4o3QatmA9OQccLmNnyQlBGEnHs=;
        b=C6FG3OZCY/eNCvICIHpHJB79y2MJLDWNXEg6pPENO42etUOMJWT8n9DW1BM+C3veQ1
         A6zQM2d/mnFmcLVrriHTdwOcOghmpv+x7WFHxu6oGdVdmCwLo2/r9mVjOrc2x5sQKPAp
         dMvyyV4jI3u0oFxsnDayuGcpOxni5vrl1THFyF5hXoSt6yoIhTjnzf+y7KGlJA/Et/r0
         aY0lTN4qYS+VnMUm/Qis0QjI4D+haLeTrAOuZsnzKhbJQC48ihrNcQG5DUfCjiSVaPR1
         50Yi4PeRrMPjYARp0245eyqib/iZSeuB9K77ZgA1MeVXhzluWsu1v2ZT1Ubnx/DyVq40
         HdoQ==
X-Gm-Message-State: AFuF++m19srKNIb32eSHKDRNV6IGzFB7u9nMCtr2U/Qit/C5k8UP7f58
	uoEfrhoo861OYineulpwKke3Zbqn/Ekf8ZFjqZcAp/gq8T+8W8iOJxAH
X-Gm-Gg: AYBFou3KZ+a9bHR+UQU17ivw08rOJSTdq3wV9I2Qsm3YIbZZH5A0P1rmqPP/AQFNO9t
	62/tUxdUKJ2AwDva7pVuvwfVJeyRkADSftQ5ZfVGi6MwjOG++O9cPrucox/e2q9Sy9FyRTe7KIG
	aMw+D5espNeWrilltcl9mer6UhvpJ7xjY5CcGgZZJigbtuZ9KsuBN/zhxLXpioLi0NuTPrYsAdc
	U2KemuR4l4qq0nN55acJ0na1+mU4HhGnwtKosns8rDwGkahECUllmS2vva2358ZFsSj/EldL+wO
	CtiSR1x5CSg74mmRFB1b1/u6mncsP8MaSs0PeA4m4gc34K3I7L+A2vUoA9PQkN9IMsnT2w9B0Vj
	7hzdoZkuBOWWO8Bhcq5dPcf7JsB6zeTMt+u9j+ScNlalEjfKn62wput+caoIlMPr8jqHKa6DSJg
	wnxquilt7McVmoq5uUPaVkT4/6a7Hfg9fKG9o8OtTh2nuIb4+dNeC7jfFtdXC2PueqLNz8nN0zi
	8bp3cr1AjZ5sqOi
X-Received: by 2002:a17:90b:2b8e:b0:39d:efa9:cd25 with SMTP id 98e67ed59e1d1-39e54c59c74mr17536897a91.2.1789839473321;
        Sat, 19 Sep 2026 10:37:53 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:814e:e9d3:767e:9a2a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c3145e5sm5820981a91.5.2026.09.19.10.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 10:37:52 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	syzbot+b114bbe890d76037877c@syzkaller.appspotmail.com
Subject: [PATCH] dlm: make lockspace join wait killable
Date: Sun, 20 Sep 2026 00:37:47 +0700
Message-ID: <20260919173747.327963-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

do_uevent() sleeps uninterruptibly until dlm_controld answers the
ONLINE uevent via sysfs. If the daemon is absent or stuck, a task
creating a lockspace through /dev/dlm-control blocks forever in D
state, cannot be killed and trips the hung task detector.

Use wait_event_killable() for the join event and return the error to
new_lockspace(), which already unwinds through out_recoverd. The
leave path is left alone as it must not skip teardown.

Reported-by: syzbot+b114bbe890d76037877c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b114bbe890d76037877c
Fixes: e7fd41792fc0 ("[DLM] The core of the DLM for GFS2/CLVM")
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
Problem: syzbot reports "INFO: task hung in do_uevent"
(https://syzkaller.appspot.com/bug?extid=b114bbe890d76037877c).

Cause: creating a lockspace through /dev/dlm-control ends in do_uevent(),
which sends the ONLINE uevent and then sleeps in wait_event() until
dlm_controld writes the result to the sysfs "event_done" file. With no
daemon (or a stuck one) the writer sleeps in TASK_UNINTERRUPTIBLE forever:
SIGKILL has no effect and khungtaskd fires after the timeout.

Fix: use wait_event_killable() for the join event only and return the
error to new_lockspace(), which already unwinds through out_recoverd. The
leave path is unchanged, since it must complete teardown.

Testing (x86_64 QEMU/KVM, lockdep+KASAN, hung_task_timeout=20s): a static
repro configures a local comm in configfs and writes DLM_USER_CREATE_LOCKSPACE
to /dev/dlm-control with no dlm_controld.
 before: task stuck in D, hung task splat, still D after SIGKILL.
 after:  no splat, task exits on SIGKILL, no KASAN/lockdep reports.

Open question: a late "event_done" write racing with the error unwind is
safe because kobject_put() removes the sysfs entry (waiting for active
users) before the lockspace is freed; happy to add an explicit kobject_del()
if you prefer.

 fs/dlm/lockspace.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index a9c98b4f378f..5d6a752e6650 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -190,6 +190,7 @@ static int do_uevent(struct dlm_ls *ls, int in, unsigned int release_recover)
 {
 	char message[512] = {};
 	char *envp[] = { message, NULL };
+	int error;
 
 	if (in) {
 		kobject_uevent(&ls->ls_kobj, KOBJ_ONLINE);
@@ -203,8 +204,16 @@ static int do_uevent(struct dlm_ls *ls, int in, unsigned int release_recover)
 	/* dlm_controld will see the uevent, do the necessary group management
 	   and then write to sysfs to wake us */
 
-	wait_event(ls->ls_uevent_wait,
-		   test_and_clear_bit(LSFL_UEVENT_WAIT, &ls->ls_flags));
+	if (in) {
+		/* don't hang forever if dlm_controld never answers */
+		error = wait_event_killable(ls->ls_uevent_wait,
+			test_and_clear_bit(LSFL_UEVENT_WAIT, &ls->ls_flags));
+		if (error)
+			return error;
+	} else {
+		wait_event(ls->ls_uevent_wait,
+			   test_and_clear_bit(LSFL_UEVENT_WAIT, &ls->ls_flags));
+	}
 
 	log_rinfo(ls, "group event done %d", ls->ls_uevent_result);
 
-- 
2.43.0


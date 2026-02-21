Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B38156677
	for <gfs2@lists.linux.dev>; Sat, 21 Feb 2026 15:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771686030; cv=none; b=VQMYfyqoMjfrQHrafmiYsqzMKlCOgGw4yCdoi2FQVXOLkqLH5OYICtuIpcQrZ5/qMEo6MsKkU+yXQqAyUpFfMLrmYfcRUPproTO9FmzFOUIKr1WpckSKV+RP2tfGZ5OJr668cZlvIxV1/8GN5vk5y+a2UgkMGKhh6OFEp3Vc2bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771686030; c=relaxed/simple;
	bh=Q9dm8LTnk+DFIEJAAB7tpFWixf8EizWYmak8EK7I1tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gFHoQH5lwZFCzzwu/pcmkhlfx4X7O5sOGnNA9Z/2ekjpwphSNiFxTqu5fLEYkLgDHInWoreL49tKVm3A/7gFe3sYX4Erj/xZ5ZtINe9woWpIMUahJuosL+95KwAHO7ebmqIgaq43wMAmhAf19kOHodDgqfvmc7vOOpLj1QF1xpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvGOVJXZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvGOVJXZ"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ad22a5e245so20703925ad.2
        for <gfs2@lists.linux.dev>; Sat, 21 Feb 2026 07:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771686027; x=1772290827; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4HfR25bhfBsIe8RbNyIL8PstGgybd8nsB9r91rb4k4=;
        b=UvGOVJXZjb33obihmsl96oNUMCqdXHrkl3P0BJ8zHfl6a2PMel/LxqRQ0I8L8tO9wq
         plciI/qcfuMmwQrW7SpWVdIB2tZKe1IeyF1G+AvYQDdUqWhU0xlrojixN6+xGXH7K28Q
         eeSJZszZLcsAVZk1OVINVbuJjcGkSfdruH1cKUsk8hnp8TKaeR0TWJXvfPy53wFB0Bg6
         R5gcmu1QXtR0efxuLE01zjdAIKqU4ElZkWXITz2YG8nTFtAh8Da4eXmp70/i7ZnB7pBA
         V2Uu2ks0hiZ+/uzGYT2gdm1FwL5cURjEbeHoSI3H9I9M2l1c27SR2kI1LEQ8iy3VVDRb
         Kuug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771686027; x=1772290827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q4HfR25bhfBsIe8RbNyIL8PstGgybd8nsB9r91rb4k4=;
        b=oTXJk/Y0vx+m86Siwicg9XZbsFs4DNXHWOQ1cxZJg4qQvBc8GOd/ZX+Cv9+IjNHnGB
         LykDxiTb+y+4n0huLU6ZGGmSbjc1CcbWMzzy1AzLhYemLG6ymGBabVMwQTr245i/+5gd
         i1WZKugKU1+xkx0M4Oscldid+ShptcR8vMDjBg6mgT1N2uZYHrjPfpUDDe/R+vtsgJp0
         j68GP8QrJZB5HEW2MKAPenOB2clW8N+XSJodqwKaKgdsiklFfKrcglBWyWu/lABcHyye
         SyvbVbhaQJAJkFSaaofQiNPvVBob5x0IDfWzP5F28Y8hA53nTef9sy76S3JBsv0tRnuW
         TSeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBjvs5YkJN+aqDJVpZxWYvN3EpKOPrVoMbEncq/6QMeFVDqU3OwJ0I6WE32ZNxG5o7T+6v@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4TR/0F1vhuCJvJDHfvwtVIR0HI7nVPacY+PH/Q2WTQN166eLH
	O9scALJeIQAxnMJWg6DVbphrPBAbqeJTuCEDYng42DpG4kT00klU+QnE
X-Gm-Gg: AZuq6aKE3iIKqL3sAj38FjeGbuZ8m1Wgr7ikIMDyE1rEF4gCR6WmgRSktLpMJ76jEqw
	EfCS1qsFJI+Ufd2tyh/GyL6olDSZcHu+NkDExkGi12EAvK/7/9XMhOv7aGJogSSpAbn9ArOpK+P
	7Tk6uLKucB3+lP+XnxmFqCiWfeQ62AvFr9xrXsR00XqpSouokAhgaWeWz3Ru8WSu0RA/eteuaGB
	UHptfoQmBFuU85nXnFutQbheC94KpmyIp7RhCU/zlkAkBdMud1OD08JJ26JcF7akXi6BF0d4vO2
	tGWyTUEb60TxSMCmAy/9+kWLxKTFlEKnzN9rAxI0W2wK0OaW1RBoAxPtISthBAMMTn0cCTEpAmO
	g+/5biHPxLlMHQOpOZitXDZ1+F/MtqIEqbb7M8LvTxn10BnDi1pP7MW8iSApD20LBQCtlT3/SUb
	8ftuaii/dGcNX/Ahoy+Evdr9fUjKg88gGJ4XfvB6ztw962x4Ka6HsF7uQ=
X-Received: by 2002:a17:903:3510:b0:2a0:fb1c:144c with SMTP id d9443c01a7336-2ad743fe17amr28627765ad.5.1771686027291;
        Sat, 21 Feb 2026 07:00:27 -0800 (PST)
Received: from toolbx ([103.230.182.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7503f4a4sm23730205ad.79.2026.02.21.07.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 07:00:27 -0800 (PST)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	chuck.lever@oracle.com,
	alex.aring@gmail.com,
	arnd@arndb.de,
	adilger@dilger.ca,
	mjguzik@gmail.com,
	smfrench@gmail.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	tsbogend@alpha.franken.de,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	davem@davemloft.net,
	andreas@gaisler.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com,
	agruenba@redhat.com,
	trondmy@kernel.org,
	anna@kernel.org,
	sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	shuah@kernel.org,
	miklos@szeredi.hu,
	hansg@kernel.org
Subject: [PATCH v4 3/4] sparc/fcntl.h: convert O_* flag macros from hex to octal
Date: Sat, 21 Feb 2026 20:45:45 +0600
Message-ID: <20260221145915.81749-4-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260221145915.81749-1-dorjoychy111@gmail.com>
References: <20260221145915.81749-1-dorjoychy111@gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following the convention in include/uapi/asm-generic/fcntl.h and other
architecture specific arch/*/include/uapi/asm/fcntl.h files.

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 arch/sparc/include/uapi/asm/fcntl.h | 36 ++++++++++++++---------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/sparc/include/uapi/asm/fcntl.h b/arch/sparc/include/uapi/asm/fcntl.h
index bb6e9fa94bc9..33ce58ec57f6 100644
--- a/arch/sparc/include/uapi/asm/fcntl.h
+++ b/arch/sparc/include/uapi/asm/fcntl.h
@@ -2,23 +2,23 @@
 #ifndef _SPARC_FCNTL_H
 #define _SPARC_FCNTL_H
 
-#define O_APPEND	0x0008
-#define FASYNC		0x0040	/* fcntl, for BSD compatibility */
-#define O_CREAT		0x0200	/* not fcntl */
-#define O_TRUNC		0x0400	/* not fcntl */
-#define O_EXCL		0x0800	/* not fcntl */
-#define O_DSYNC		0x2000	/* used to be O_SYNC, see below */
-#define O_NONBLOCK	0x4000
+#define O_APPEND	0000000010
+#define FASYNC		0000000100	/* fcntl, for BSD compatibility */
+#define O_CREAT		0000001000	/* not fcntl */
+#define O_TRUNC		0000002000	/* not fcntl */
+#define O_EXCL		0000004000	/* not fcntl */
+#define O_DSYNC		0000020000	/* used to be O_SYNC, see below */
+#define O_NONBLOCK	0000040000
 #if defined(__sparc__) && defined(__arch64__)
-#define O_NDELAY	0x0004
+#define O_NDELAY	0000000004
 #else
-#define O_NDELAY	(0x0004 | O_NONBLOCK)
+#define O_NDELAY	(0000000004 | O_NONBLOCK)
 #endif
-#define O_NOCTTY	0x8000	/* not fcntl */
-#define O_LARGEFILE	0x40000
-#define O_DIRECT        0x100000 /* direct disk access hint */
-#define O_NOATIME	0x200000
-#define O_CLOEXEC	0x400000
+#define O_NOCTTY	0000100000	/* not fcntl */
+#define O_LARGEFILE	0001000000
+#define O_DIRECT        0004000000 /* direct disk access hint */
+#define O_NOATIME	0010000000
+#define O_CLOEXEC	0020000000
 /*
  * Before Linux 2.6.33 only O_DSYNC semantics were implemented, but using
  * the O_SYNC flag.  We continue to use the existing numerical value
@@ -32,12 +32,12 @@
  *
  * Note: __O_SYNC must never be used directly.
  */
-#define __O_SYNC	0x800000
+#define __O_SYNC	0040000000
 #define O_SYNC		(__O_SYNC|O_DSYNC)
 
-#define O_PATH		0x1000000
-#define __O_TMPFILE	0x2000000
-#define OPENAT2_REGULAR	0x4000000
+#define O_PATH		0100000000
+#define __O_TMPFILE	0200000000
+#define OPENAT2_REGULAR	0400000000
 
 #define F_GETOWN	5	/*  for sockets. */
 #define F_SETOWN	6	/*  for sockets. */
-- 
2.53.0


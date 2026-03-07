Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C211C6FF5
	for <gfs2@lists.linux.dev>; Sat,  7 Mar 2026 14:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772892524; cv=none; b=P5L/v0jmuMEdL1KM36Ix5JIJHhB4OEIoZTqUcXlM/c5X6KIh+l3X+MIYYpqfHYO2b3z8IUMCUSLW99xBmYjtztvT5uFlS5OXnRpVoPyWlr8viDess2eoVxQdLFLFwXZxUd8pBnVBa5de3Ii19rhQQ1IoKQu7RxsGMoPV3XQH6jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772892524; c=relaxed/simple;
	bh=Q9dm8LTnk+DFIEJAAB7tpFWixf8EizWYmak8EK7I1tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DESjpAxHLuf4rTZN/57tCnLo5LBnawYVEHs2Pp+vKTZ2Xo0exmJSS3P8SMpeY4eDDKbY3CXPs9TOaLBHH13aNRfGjAncjSYBbMJSUf/LF+Zg2Ak7Pl8PGHaPWMFZlP4YmPJSUa7+imHXE8y7eutPKfgpr5JwHWLx+/5vahOvEec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feunjqa5; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feunjqa5"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-829865a8471so2913962b3a.3
        for <gfs2@lists.linux.dev>; Sat, 07 Mar 2026 06:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772892522; x=1773497322; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4HfR25bhfBsIe8RbNyIL8PstGgybd8nsB9r91rb4k4=;
        b=feunjqa5SqixYJykvzWlC6oJFDZn/716ZgxsSUAZuQ3Uz6paEtPkWZ67/XkHulmMlT
         RoWgLw7tFZz0A5OK2G4PngBxvHu+Un8Y18Qgj5xKXE4nkMG7riNZeYimH4DLrQv54DrN
         utxvKulRdYMiQU4YEXvz6YE6qRNNzOG+G7y5MYYQ9RH+4JKslGeqxGdU9hUx6z9Q9+aO
         fSS2jnJ1TCtKZLf+SeXvf/SXyprNY7ffMLval1pIV9yZ6LxAfEhydsH6ZF6kCvFok694
         foHzGqs57iEz7CHZzQvrZbo6mGA5Br65uac2eV5QMp8L1nG2I4zNP4fiTAJZNfhYOZgz
         97dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772892522; x=1773497322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q4HfR25bhfBsIe8RbNyIL8PstGgybd8nsB9r91rb4k4=;
        b=RFdvJ9WPNpZ+L40TcHfZxdEe2M8fDuY3Ft69TONui3iX2Ak//3+5cGAfe0n8hQaiA4
         mo+L0WF5OOvMUjs+sexIGbUu2kgBaOkbpmEClGpc4rPcDpnn5gPiXwVNEyVXJdmCQYHJ
         n95SukFbQLTQgM1nUbBhYFepjtes+j55Ry6v+rHZOXBfgEqlcYcTNCsT7BiLwCMFIvYF
         SQezv9p8FbFr1bNfTR/RcIFXyWrFlLA4v9/czUauPdC9XLht8/ndTCegZem7aE3hgUyz
         9bGwDTfqOaxGcbh7WJRsZcqUQSS4MlJ1bhNma+cenRCCtFcM6+cENe5XvwHswu1gMkW4
         1Gjg==
X-Forwarded-Encrypted: i=1; AJvYcCUDCUIOvnxPGQ0z4p6HPfRgQTwDP5TBpzdOHvAuWSt2mwnhN23tBQOFEUiEK8pwjaMMEnbM@lists.linux.dev
X-Gm-Message-State: AOJu0YzeOlKpdsf+QpKCyvZTuOnW8bWvxW1n4wGAvAqC4NKklI7PerAF
	SDxFPzbkO3ARn3J0ppHD5jxSXNdzRUtrUwep/pqX4qqrmyfZp4a/Amca
X-Gm-Gg: ATEYQzwIni7mBsBHWqtl0JyltqjfIGYfzQqJFmoGWG9fW+dDCDx1KzX43vvE2DTyL2T
	0PWKtihPWZg5axvoLv0cN79jjya6Szv46wOLvxDbLOIGWX7cIQd+gdZ8q5ebogWCKlLS10M3r7Z
	zktYoTAQwoslLhMtsNvYXEmxEPgVVesPUaewGQSWemuzZN//kyUHhDa5VauP40Lc3Om2a93ghaA
	dBvZFGwwLk70P8wrosYUhjPIjQKtj3eeQt4o3S5C+eHK4bPnHj2Er7QvaLhhDb35uPz7101eCOc
	kIf6iFNpfGbpS7+DlOXUhYgJROxtFWJfzhFhY0u2A/hw2oGHRn+W0k5OZ5Tqyfd2G1h0ZUgUIi3
	OVlixbFRC11n0gqGgXLYg4/d6l7cSpkunbBiKEI1sPXlVCXW5scj22WqUh6+RPpSy38ArBSG3dw
	S8VJr9qNlkZzPIW7iyMfbnH1U8BUiqAreuQf5ysyDDD36l+thPcr+sl20=
X-Received: by 2002:a05:6a00:7586:b0:827:2a07:231d with SMTP id d2e1a72fcca58-829a2dbaa39mr4250553b3a.17.1772892522295;
        Sat, 07 Mar 2026 06:08:42 -0800 (PST)
Received: from toolbx ([103.103.35.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48ddd18sm4747313b3a.56.2026.03.07.06.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 06:08:42 -0800 (PST)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
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
Subject: [PATCH v5 3/4] sparc/fcntl.h: convert O_* flag macros from hex to octal
Date: Sat,  7 Mar 2026 20:06:45 +0600
Message-ID: <20260307140726.70219-4-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307140726.70219-1-dorjoychy111@gmail.com>
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
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


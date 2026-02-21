Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB7F1C4A24
	for <gfs2@lists.linux.dev>; Sat, 21 Feb 2026 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771686043; cv=none; b=kgEPtg8NmpCUQB4Ac6MIapZIA6LGo9675//P5zpYoZMyAXvzjZ8PL4i3KrzEoSZJroYCw0hZs5pGNPQXTr0Dl0us6s5bzDy8LSYTo2jpz9epcwkmhc6ikDIfBFsHw8GI7Oe8dpoRzUjaNuykCd7yntdpMXA/PaGObcuZkIEpWuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771686043; c=relaxed/simple;
	bh=EKC+gjybz5QCo3/A2SoLkAdJ9dHzP8glwvLLU31BmCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3QE5U2HQKUHiLHSYjyyv0h28CI20uAiujzwq7x5N/1g/IJXv/P8VSGl33nTPXH41tKGVU/ZEK1XEbPFQ3bzlOzGgNbh8fRXmzlFTmcoAy7Cymu7CUjrPj6YbkpogJ+cU9LwFAcH9U0ZQgYaRg1JAJ8C0fyMXqslhehk5avfbTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rv2TuFCE; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rv2TuFCE"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a9296b3926so20320155ad.1
        for <gfs2@lists.linux.dev>; Sat, 21 Feb 2026 07:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771686042; x=1772290842; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cE+gTqS6Acm3OjdFoCwcpAog50aFpqNiNU85af164dY=;
        b=Rv2TuFCEkvBsAn1du8o+jP4ccwsKwkLmicBWWecAcalNVUpF0VX2iXWB7DRWVYKhLD
         uw+qD4S3JBrW+ylIBkS72LSdFopY7tvBYav7F2fdonE1ClMJBOAwfcNrI84+DAzgOXNg
         /Usarbf6F1rjn8qoQS/0q1AIeG1Ph18VlxfPGi5j3RpIAPlC2jvgH8mpm2xvYWUoXQxR
         AtoyY56lLeOCVS+Me8ILmXj3liKSA0U0KNAFt5LvDICZFjGt4YFLtxXhKlYDHZewub69
         TlHCoGYxp7C6yEYSg7gB7Czi2aL2z/Kz4TlZ522JcwXozYbUsILArrodn5a6EgIPDkHQ
         NyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771686042; x=1772290842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cE+gTqS6Acm3OjdFoCwcpAog50aFpqNiNU85af164dY=;
        b=D+ORSiva4TYo+2hdxKVKAYyWupUTEstgaCMCM0ZeqhkYXNHJSzY+djyCSnWYHsyiCl
         JE5K6+q3/WlxulCzBcQvXQcX2/2MHwY8xtT3/S5MoKWRCnl68FlK6ZGstoNlqk2dAh2B
         5DMCKs6v8LY0J1YUEjy0aER7XqIRCV67LNMiZyp/6LThNweD6Fsd/BK38dy5i2ma9rL2
         CRq5VtUEizKY6MObV5aVBuvw+btwjPZ5l52VfhWoWEEjguabJFakOwbf21bcKfINOyql
         l0GJoItMv87wk8SjsKK82y2yPziir5etc6hwui7nCBse1xh+cmQjM8Q1C6SO9//s47X1
         NO7g==
X-Forwarded-Encrypted: i=1; AJvYcCVxFRu3TUg14u8/9e34zgd9aRP8OazOJpL+8QqE1+M0mmCnTE9DNmqRRSzGeQ0P6Bh6/C2R@lists.linux.dev
X-Gm-Message-State: AOJu0YwrGWHz/sWPh7qZdkuyF5Pj4ccf81UFWEcCc2h6GfysrPBu1yQX
	A68vmTVx2NRj0mX97gaOzG5Quw5/Le0koKmjbSCOC1AqasL5bhwwm9G8
X-Gm-Gg: AZuq6aLwCu3ndejfqlvaqv1SOrvX7NSwO5J8NvgXLnJ2DonvAFl08lutUuu2InPeWfh
	sTXOox0ntvUzwkcO7tx3M9jE7Od2mlMem8cKbRwASxj2zqVQZVu53DTBLkCkzdO1OcwXUpOpiFd
	BEPr9UmCXlBvglFJjTN3rvvoP3oRyDTkraqZXWIlkvPjNtlG0+AqT4sFUvAPOIwWDIy3EkrgzXH
	KbcdI7ulFxnZXtM0Ox7/tGUwvVx/dOBgXzzVxC8bw5a2aQJUBPeXy1MlTK6IyHde1sPDo2WyJnh
	ZVZF8OlhW+dFcQqcOlkpYFpOvjCFsb2WLcHsEMjYu0S9Umkci0nm9OguhtKIRNE3+RtRV+aMGXm
	Eh0eMvvFvVpFU5MiL67HQOmMCVY69zDEmCLYRoFKD+evICUAh8CeBDBxhVApb+rYBOwo+0EXanD
	ncWxmtL9JAar/hX6JLAa6IOKWbfi/bjlWcx6nJOiBgp5Wg8wkVMetuGJU=
X-Received: by 2002:a17:902:ce90:b0:2a9:5b28:94c0 with SMTP id d9443c01a7336-2ad744e13bemr26077275ad.27.1771686041931;
        Sat, 21 Feb 2026 07:00:41 -0800 (PST)
Received: from toolbx ([103.230.182.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7503f4a4sm23730205ad.79.2026.02.21.07.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 07:00:41 -0800 (PST)
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
Subject: [PATCH v4 4/4] mips/fcntl.h: convert O_* flag macros from hex to octal
Date: Sat, 21 Feb 2026 20:45:46 +0600
Message-ID: <20260221145915.81749-5-dorjoychy111@gmail.com>
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
 arch/mips/include/uapi/asm/fcntl.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/mips/include/uapi/asm/fcntl.h b/arch/mips/include/uapi/asm/fcntl.h
index 0369a38e3d4f..6aa3f49df17e 100644
--- a/arch/mips/include/uapi/asm/fcntl.h
+++ b/arch/mips/include/uapi/asm/fcntl.h
@@ -11,15 +11,15 @@
 
 #include <asm/sgidefs.h>
 
-#define O_APPEND	0x0008
-#define O_DSYNC		0x0010	/* used to be O_SYNC, see below */
-#define O_NONBLOCK	0x0080
-#define O_CREAT		0x0100	/* not fcntl */
-#define O_TRUNC		0x0200	/* not fcntl */
-#define O_EXCL		0x0400	/* not fcntl */
-#define O_NOCTTY	0x0800	/* not fcntl */
-#define FASYNC		0x1000	/* fcntl, for BSD compatibility */
-#define O_LARGEFILE	0x2000	/* allow large file opens */
+#define O_APPEND	0000010
+#define O_DSYNC		0000020	/* used to be O_SYNC, see below */
+#define O_NONBLOCK	0000200
+#define O_CREAT		0000400	/* not fcntl */
+#define O_TRUNC		0001000	/* not fcntl */
+#define O_EXCL		0002000	/* not fcntl */
+#define O_NOCTTY	0004000	/* not fcntl */
+#define FASYNC		0010000	/* fcntl, for BSD compatibility */
+#define O_LARGEFILE	0020000	/* allow large file opens */
 /*
  * Before Linux 2.6.33 only O_DSYNC semantics were implemented, but using
  * the O_SYNC flag.  We continue to use the existing numerical value
@@ -33,9 +33,9 @@
  *
  * Note: __O_SYNC must never be used directly.
  */
-#define __O_SYNC	0x4000
+#define __O_SYNC	0040000
 #define O_SYNC		(__O_SYNC|O_DSYNC)
-#define O_DIRECT	0x8000	/* direct disk access hint */
+#define O_DIRECT	0100000	/* direct disk access hint */
 
 #define F_GETLK		14
 #define F_SETLK		6
-- 
2.53.0


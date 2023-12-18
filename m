Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163066AA3
	for <gfs2@lists.linux.dev>; Mon, 18 Dec 2023 05:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nabuzc0F"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-67f296ecb2dso11765906d6.0
        for <gfs2@lists.linux.dev>; Sun, 17 Dec 2023 21:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702877771; x=1703482571; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Z0lSdAr+HfDM1BWWl2obVqBUEKJ0kES72a8H5uXbOE=;
        b=nabuzc0FSSFjzcOXxtcB25g5v3NFZ1xgXd1R7r7Jj8M+T+jFbQNnTjRjBEmJDbRswg
         cYd/KEy2oVExSRS0bUQOF69UUqYmzoJ9jGDFDbdCjtTwgz8lPbCFhuOTDtqIbLzKL+JC
         GY5AQ6hmdkwCcSn5Tw5n+ruv5ofysmnUZFEWWolHOeGvVx+7fxHMUjeFwMC2ISz4XrS/
         B+adablgu5v8/0g14YPC6FDEoVfcBqICcexLs+rudHv8H4AlJfn/D29qsLF8z1vBR3wj
         7C9bJUI/RIWGn5PdArXND6bDGgl+QJYsozPOLjdqwGpoqbZ+bdvLYor8T52q3mi7Zucu
         25MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702877771; x=1703482571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Z0lSdAr+HfDM1BWWl2obVqBUEKJ0kES72a8H5uXbOE=;
        b=kFLB7sBeYd3Bqh0RRXvvFxCSzXDTkgF2Bi5Vl/+7V5Hgtb+lY/frMTQZJdau8p42Lg
         fwDU2Qh5f2ALFPtro5fT1YyOC+Z5e7fubERsQkV8lQd6p9C2nFJlH6kI7+Th8j3G67jo
         Q0T8UWBa/RpTjxk6rg8YUT8JIHxJwy7DNojVMAqYSdmLhErT1tcaaNwH7mrZYw82bh/R
         IiVk2HQRx+JUorrteCIu0/PmisH+8JWgnETwWVxvrrBIVXV1fb014qeGbuAlWHODczU8
         yPsGICoz7IKHC7CWIhgdl0LwVXoMHa1WzTLXmancvCaA1KNp2La7Yq1gqX0PuJFe/UQo
         JAUA==
X-Gm-Message-State: AOJu0YxEV5S/GXVXag5i0q26+8FgtBO54sUDetomrnrzQatqVyisLhAu
	/IEFq8ByWlW6TjU4bDe5Gtw=
X-Google-Smtp-Source: AGHT+IHUibel7rxbK8s/rSA9T1vt87vkes80EtKVbaeJswjgau3nAEXe67Ut/utpAo2ZBjLY2lTrhQ==
X-Received: by 2002:a05:6214:1941:b0:67f:309f:256d with SMTP id q1-20020a056214194100b0067f309f256dmr5017822qvk.7.1702877770840;
        Sun, 17 Dec 2023 21:36:10 -0800 (PST)
Received: from pek-lpggp6.wrs.com (unknown-105-121.windriver.com. [147.11.105.121])
        by smtp.gmail.com with ESMTPSA id o14-20020a056214180e00b0067aad395037sm2430271qvw.60.2023.12.17.21.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 21:36:10 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 1/2] gfs2: Add missing set_freezable() for freezable kthread
Date: Mon, 18 Dec 2023 13:35:57 +0800
Message-Id: <20231218053558.1200822-1-haokexin@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel thread function gfs2_logd() and gfs2_quotad() invoke the
try_to_freeze() in its loop. But all the kernel threads are no-freezable
by default. So if we want to make a kernel thread to be freezable,
we have to invoke set_freezable() explicitly.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 fs/gfs2/log.c   | 1 +
 fs/gfs2/quota.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index e5271ae87d1c..a268b69bb636 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -1297,6 +1297,7 @@ int gfs2_logd(void *data)
 	struct gfs2_sbd *sdp = data;
 	unsigned long t = 1;
 
+	set_freezable();
 	while (!kthread_should_stop()) {
 		if (gfs2_withdrawn(sdp))
 			break;
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index fa47824acf13..173581736a6e 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -1583,6 +1583,7 @@ int gfs2_quotad(void *data)
 	unsigned long quotad_timeo = 0;
 	unsigned long t = 0;
 
+	set_freezable();
 	while (!kthread_should_stop()) {
 		if (gfs2_withdrawn(sdp))
 			break;
-- 
2.39.2


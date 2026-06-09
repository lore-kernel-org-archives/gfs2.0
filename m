Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C694071DE
	for <gfs2@lists.linux.dev>; Tue,  9 Jun 2026 00:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780964196; cv=none; b=pJE8ncnNPDgczUacT2DFjGywcHvVlY6P6Pgr/BBJGueZWx/7ZBSqjc1Y0qjHFfxRhbYGpcs9mXtnD8aqYh8Didu0LTEW1/+lsegnwywKna7XK25KmUz+hSLSvNTJDO6d8Eu0YUIarsvHeD9nKXOSOUWr8tBmb+NaCCjnzboSFtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780964196; c=relaxed/simple;
	bh=5o+mmGxAO44qkT5zAs8rUM3kK4gwSWAOBVe+MYaaAuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N0M0tPkaqEVa02Ul0toykxQY7MXQysIoFcF3SYCl28qgdgmmPi53xOsuirmHhI/ey5P15gz/1G4mF5Bk9SWJvgQ3AYNbYessV+QzKd/X6CADYSeXLIDOPQwSPXXgg10bpqHbxQiNftpK6UGidKWetzA548Yh9kVjxiwVdFU9YNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=YIpu99OH; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="YIpu99OH"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-915bf8800a2so279523085a.0
        for <gfs2@lists.linux.dev>; Mon, 08 Jun 2026 17:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780964194; x=1781568994; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mVzi6kVKWqrswrr7dI9LgvPOeuZkBiCyiPO701KNxfc=;
        b=YIpu99OHKXA/MAERSAED+hd8LSE6qOXJpsvovyQyRcNdK7ALpVKt1rOfk+ZZjbO6Wh
         h/sl6b3IFGxhXG5o1JzCk/X8iBBXIlg6W+QAiflPCo9a4UTqUbMGVK4Cp3UfdZLkSeZI
         sjt7ifmdZsskWp+R1jWTxFwm8ifDDjjtzp1iRqEz+NZma+g5AYQewxh+erTvoUwihf7v
         fmHtKsrY9QcqMzkexfexXB4uAwbBnDW+1J7GhyJ4VyS7SsGSHS9vJ7UIFrL0timHoxk5
         lgxkDrQYDuINlNQEb+vS0J2n2vbB2Ip94vBP9H4dpZgbXgyWfV7PTZJ8vNguU2vGe41p
         mhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780964194; x=1781568994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVzi6kVKWqrswrr7dI9LgvPOeuZkBiCyiPO701KNxfc=;
        b=Pj4ngSGuL8cS9Ni/+NrWFiTtMw2v4d9Uyc3dP9kjLpLWaoQu9uT3Z5o0LPmmCxq9Xe
         HB0H3G1kyoWx7q1gk5DKzRoFGVkyGiviue2jEDJEqfgYAILmCeZFYE1x7s7cn9OrqMLd
         n/zlffwXlxvl0YOOY7bKc+d5xXef4zHtJCyJPAfqy60MMc2lXTnGgnLuM3UMCemFoEXZ
         6mW1l9vtF/L+I7AclqvX14iKqtSrlFIjCGionMwxXXb6xo4yRy9EITTxxKpGzUyxx4Bp
         nfZ4WVfdDNAmvVzM/68kCwzuahcBtORxBCQNFDdiXTI715OLNyfAlZlDTInVe4uCIU3h
         cbOA==
X-Forwarded-Encrypted: i=1; AFNElJ8qPUUzbiYSTlNK5+9RtGS+oHnNm95XfzKLUtCKTVbrc9cX2xCbUlLguzrgQSdQ+7nIijBi@lists.linux.dev
X-Gm-Message-State: AOJu0YwV0s2aYOlcjoema7rtBwd4ZDfwuhQmNJjcAE3VSzOQaKhjg6db
	fw+qalFDEj8LGFpTGAsylDwsMh5AYnQCD3nXwXRPilJxlbQPCTc3JbaM37A//zCMFQ0=
X-Gm-Gg: Acq92OHltGgdWsGEZOqaWIzNxX7GTu2byQCmnABZwH/KQ6OBaTopQhut9AmCWAHlvq+
	jMrVV2SVhecl6qU6qacli79aVyT7axnxyCZZ+9hNsHzUOuR9NkSFpZELaQlVjcZPLI/19lOzmad
	oiM49Asz++xEua0BjimgZH6OmCYJKQyh0fYhaDkLm8iP2rQ5nvwHjOuKSiH3VHBp9VXXsUjmDPh
	QBOxQtpb2K0oihpFY8lR7fHq4kz7T2OpGNo8xg9qStbmkCmWuFBSTVVTS6KAL63o1Oo4yeFqFXz
	cQMmywLgPajDf3w2ou3T39/BV/dR10MVixZRuBC4cX/vduwdzfOFq6O2wzjQ1jH7al2iDAdH6DH
	NpeuckgxiYzG/KaFBZzNJ/t67Yz4ljc/mMWvKoTt55mR1hH65z+9/P9d/GyBYtZTGBH2+t1wTHa
	saqRYa/SGi82b6lO+6i8aw+WqG5Tt77PGrTHtPocKrxickaTMP
X-Received: by 2002:a05:620a:800f:b0:915:db15:4e3d with SMTP id af79cd13be357-915db155b5cmr700851985a.21.1780964194197;
        Mon, 08 Jun 2026 17:16:34 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-9158a411333sm2013631585a.46.2026.06.08.17.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 17:16:33 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Alexander Aring <aahringo@redhat.com>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	David Teigland <teigland@redhat.com>,
	gfs2@lists.linux.dev (open list:DISTRIBUTED LOCK MANAGER (DLM)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dlm: validate userspace lock resource name length
Date: Tue,  9 Jun 2026 00:16:29 +0000
Message-ID: <20260609001538.1235326.296e93c4065a.dlm-user-short-lock-name-oob@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DLM userspace device accepts a flexible resource name after
`struct dlm_write_request`.  `device_write()` bounded the total write
size, but did not verify that `i.lock.namelen` was covered by the bytes
actually supplied by the write.

A short `DLM_USER_LOCK` request can therefore claim a full
`DLM_RESNAME_MAXLEN` resource name while providing no name bytes.  The
request path later hashes and copies the claimed name length, reading
past the `memdup_user_nul()` allocation.

Reject non-conversion lock requests whose claimed resource name length
exceeds the flexible name payload supplied with the write.  Valid lock
requests with complete names are unchanged.  Track the payload length
before compat conversion so 32-bit requests keep using their own request
header size.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
 fs/dlm/user.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/dlm/user.c b/fs/dlm/user.c
index a8ed4c8fdc5b..205364329ce3 100644
--- a/fs/dlm/user.c
+++ b/fs/dlm/user.c
@@ -511,6 +511,7 @@ static ssize_t device_write(struct file *file, const char __user *buf,
 			    size_t count, loff_t *ppos)
 {
 	struct dlm_user_proc *proc = file->private_data;
+	size_t name_payload = 0;
 	struct dlm_write_request *kbuf;
 	int error;
 
@@ -544,6 +545,7 @@ static ssize_t device_write(struct file *file, const char __user *buf,
 
 		if (count > sizeof(struct dlm_write_request32))
 			namelen = count - sizeof(struct dlm_write_request32);
+		name_payload = namelen;
 
 		k32buf = (struct dlm_write_request32 *)kbuf;
 
@@ -560,7 +562,13 @@ static ssize_t device_write(struct file *file, const char __user *buf,
 
 		compat_input(kbuf, k32buf, namelen);
 		kfree(k32buf);
+	} else {
+		if (count > sizeof(*kbuf))
+			name_payload = count - sizeof(*kbuf);
 	}
+#else
+	if (count > sizeof(*kbuf))
+		name_payload = count - sizeof(*kbuf);
 #endif
 
 	/* do we really need this? can a write happen after a close? */
@@ -570,6 +578,15 @@ static ssize_t device_write(struct file *file, const char __user *buf,
 		goto out_free;
 	}
 
+	if (kbuf->cmd == DLM_USER_LOCK &&
+	    !(kbuf->i.lock.flags & DLM_LKF_CONVERT)) {
+		if (kbuf->i.lock.namelen > name_payload ||
+		    kbuf->i.lock.namelen > DLM_RESNAME_MAXLEN) {
+			error = -EINVAL;
+			goto out_free;
+		}
+	}
+
 	error = -EINVAL;
 
 	switch (kbuf->cmd)
-- 
2.43.0


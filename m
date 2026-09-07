Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23E738E8B4
	for <gfs2@lists.linux.dev>; Mon,  7 Sep 2026 06:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788762124; cv=none; b=p7JlFQUxUaqgreQ1j+auEWygCy834y60DNJpsr+Mgr39xbeB28PhmR2BZ+mVGEpyGvytoZZ1udgSnmFQcYOVhcPY6fRjdvizLtsAvIdhpLVuYTvXA5nwMfOCRGZDC4tPpJ0R6Zlg7E8QDBaiWuRlkNVY6lHT3PWWPt/rZ1QQ8kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788762124; c=relaxed/simple;
	bh=MeRW5bXEGeIEkp5gf8eUoDyMZ6P61cTaAQ2l91fGwJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kBX/pCvY6c/qpfLWaYOHlcTJqgBTYIcirpTfW5Xk2XvrNYbpZAJrbpw52hhvLyzVHbGgWl4ojci+HBJaeHRdcPPyn/YnRYBBpKAcumUhI07sylu+RUlHje/DwiVy2dLQVdqBY7CXZmXPbWQ5E6MISDrF/iaMHY6vJZvYd33IgLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oMdtQXYi; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMdtQXYi"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cace91f112so25914115ad.0
        for <gfs2@lists.linux.dev>; Sun, 06 Sep 2026 23:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788762122; x=1789366922; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pgQmB11lwCyevM+5cq0InhbT0EBZhc/NlddXm3mSXGc=;
        b=oMdtQXYiBtM2Y1pp8r9pQSQsGFTTSJq87LhjsPnJO4npM9Fv/AyMRtA4lgUkVFVkOa
         tQSZh1MNzFh0NSWWTPcsR024PnUO4MCUuMIcpVQ4iB2g41SbjMj/MGxly7GVgUxfogJx
         vIJEA1/mgR6SsfMPkY8n5pShkg06d07zNv62FUNHIEHfSU9Twn3f3pD54mTQI01bD0jd
         qDKPTYqNOzkpj9Jfm9Ip2SfTnb8pKZL27vuRIDrH/mEJFGtXHKTNQnBb0Xo0bsWQh6zG
         EGyT3ysg1qVOkABT+IMA8HeTobgTLQpejGodqgIXKk/NSgkMwSmG47qb8ABIELEPxR4e
         nsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788762122; x=1789366922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pgQmB11lwCyevM+5cq0InhbT0EBZhc/NlddXm3mSXGc=;
        b=pkX8g0lr1YFUtcV2K1jHdm0AjUyX4xrkxsSMXmeAz8o3lkrE2jQyx8b2YcQGl+XBtw
         5i66PotrcYanNg7n+LIOfJnMbTkDqMRTJ9osrPL2uqdxn4O0iM1oThih71IvNCtqakeZ
         kdWNdjkwio4dCbvFWLmt0ybe8Bu98tank87kcHCbpkVFyCQpOmcSP9CGUigk/u6kh4Sl
         0YyefOSdiPqi10IllxMMADikRVxC+1jKJWdjcn6LHOknYvOQSGdRs+Q/uRtSBeRW+50n
         pdgGEOFQTyrwYEsWDx+X1TqCaXpCcIRTHqLscBCjtqL/cSDwyesXlvJohTh+ws77uu6O
         Ww+Q==
X-Gm-Message-State: AFuF++kHbRRbrRDpTV7XsfR5sb/BGTS8CmZNubp8YixiFV5Ihd9d38C1
	uV5dXaDSAZL6KBGJqhl6Fbx0aradQtTMzL3f29a4wDICSHSbQTRI7osh
X-Gm-Gg: AYBFou3crmu/L4y0PoB7E2/wAhoCQg1KFqgfkPZgv6DKqfkxHYaOxeT5HKhidy7BHQ3
	DxI9L6JOie1kzReOUnu6ic+kgLpDq/CHRTjXhEM+gTMWvsyH8mJCog2PO/LWT2nWS1LqU7f3INB
	8wcJI11ys1ElOZsdBwRt7x7XZLeIhhbnpVle4PhKjF3oBWNm2m0BXZn7xidE0ESdBZrzn+Wk1qB
	mFnOrWbR4glMyip5rapscLUGyQSg8+LgBiDlSxPWnEDzKnjxSjS29BnX3189qGqpGldoNNNxAcO
	G/GalTgKz9jlOHBfj5kvAQbXrdMpVagOEOcKCBib9v6U7evtUcEoOFvSrL5c6xvr19GzSs54iKT
	wljHf+PQG2JHWn8cdAknUFMYf6m2DB2p44WCRhs4qpFkJMogdD48SXA6KuUx+BDEHdxdZ8NKK7b
	hhnRk/XPU8Z5/7moeQNGqiWpA+Vvnfom0h5Md6XzGHruj9rw/+XxkaE6BZJlxCz+gKB+h1rnr4I
	+gT5+SFBYjDLbIRKCbfRK6V
X-Received: by 2002:a17:90b:580e:b0:398:c3c9:d0ae with SMTP id 98e67ed59e1d1-39b25ee242bmr29928116a91.0.1788762122144;
        Sun, 06 Sep 2026 23:22:02 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432441f5f2sm27532996c88.15.2026.09.06.23.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:22:01 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dlm: fix typos in comments
Date: Mon,  7 Sep 2026 11:51:57 +0530
Message-ID: <20260907062157.8474-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 fs/dlm/ast.c  | 2 +-
 fs/dlm/lock.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/ast.c b/fs/dlm/ast.c
index 0fe8d80ce5e8..7dd38e15bd25 100644
--- a/fs/dlm/ast.c
+++ b/fs/dlm/ast.c
@@ -81,7 +81,7 @@ bool dlm_may_skip_callback(struct dlm_lkb *lkb, uint32_t flags, int mode,
 		 * Suppress some redundant basts here, do more on removal.
 		 * Don't even add a bast if the callback just before it
 		 * is a bast for the same mode or a more restrictive mode.
-		 * (the addional > PR check is needed for PR/CW inversion)
+		 * (the additional > PR check is needed for PR/CW inversion)
 		 */
 		if (lkb->lkb_last_cb_mode != -1 &&
 		    lkb->lkb_last_cb_flags & DLM_CB_BAST) {
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index c381e1028446..1e1dc1909733 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -92,7 +92,7 @@ static void do_purge(struct dlm_ls *ls, int nodeid, int pid);
 static void deactivate_rsb(struct kref *kref);
 
 /*
- * Lock compatibilty matrix - thanks Steve
+ * Lock compatibility matrix - thanks Steve
  * UN = Unlocked state. Not really a state, used as a flag
  * PD = Padding. Used to make the matrix a nice power of two in size
  * Other states are the same as the VMS DLM.
-- 
2.48.1


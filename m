Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BD241A553
	for <gfs2@lists.linux.dev>; Tue, 15 Sep 2026 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476972; cv=pass; b=D/6xQ9BdZtknw8D91gaYmg+NtngJ2EDsdYb7vJq/IwfJKBLaSxi6VKlM3kiE2Mt1dGi5VtA0KIVg6kX3bWvwLugJuefkBSxX9MNTmuuJNlheIS36IE0C+UMnvM6SyRjGhszzhCM7DDxVcRnQ2/nIJ30USxqEOkRbClW/3Q75dDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476972; c=relaxed/simple;
	bh=82wWhP4rEM+x/+bm+lKDGPNs+18llqOUTyZQ8tZ5h8s=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=Gxawmpk/UhAL5au6QvqBAvOEkirVG/S4bl/T05+8QvLLc6OZwSUtYnyQMGaaf6wXFjSfCa0VjZONSGRsd8XPp/jRttD2c0eEoZgXGDKEal0yNMvnV1mTYgzSH7H/5Ph8HxhMd+8bEcfIR9yaurWpdmOaTGxEHe7XimdZcrDytvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnRHIhkX; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnRHIhkX"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843378fb37so1540525f8f.3
        for <gfs2@lists.linux.dev>; Tue, 15 Sep 2026 05:56:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789476968; cv=none;
        d=google.com; s=arc-20260327;
        b=o2vTyVEn9BQam4n7emTN4BO9oawULcdwhPkIObFDxcTbTbdkuFnky5GLTuIOj0htD3
         qHP61ougBnBJ1wmVHwyPCiOXLiA28O4kYeoe2BfXURHVgktsURf+A8iqQRhXp7XW84mZ
         DDZ4MTJnFcD+xl7Mt2JmUh5VN0EjaV5A2FpeQdhPs/ch9W79ksGOgIQWGLyIuTq4+nc4
         Zfh2uUtkbcUy5Ix4upPaBjAeG3bIphOjo1kPkoUKrIO4yf5qUKqq7Rhclq1EKxrEjxz7
         sxfWrq/ea/vfW5KXKZmHJIjgyhQdbQ6rWeK4TYBpWPUiPici18YNd+4u+b5rxKslU/ca
         hlYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=BGGUtAFGUlVFMt0b9VHMyyf0YKtTCRveMamYZRai+1k=;
        fh=77lnbYOGGkV6sBP0ZX/D9qd7836n12y9meOmiEMo5Pk=;
        b=mfSpmDdWtPNQSTQEoz0mTAVUAsQ6Z43fQOJVqBYZkMsrImBv8HCku5X3xoXJdrCVY4
         ltATj365vRdZB7CeYgDFEAJMTw4Ikqv+eBDCKopbS1b/T+xm7+kYVi++SKz2ofNfemRi
         WiA1iB3W9Y1RIIWXmzxOjHPwWkuviUhsHsmEnEZN6ByfMUzQnCVeH1LuaMZC43teCnQm
         5mGS1CmmzwZmyAkZ12Hrgxp65MJZ2UbE8VZ19A9c2x54VAxAtxSsNA+oyFZYIir4iS9l
         v+DeDfqunASzrSg/pbHZIxwi/gH607ESYq4lW5BYliaX09XY3YG4JMX60RKQnfKPiD7s
         wphg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789476968; x=1790081768; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BGGUtAFGUlVFMt0b9VHMyyf0YKtTCRveMamYZRai+1k=;
        b=BnRHIhkX/oQ9mJXtzaTfqTjM8/CcCABUmzlODRdcqrRATfZIGniBuYzy31eq8SuUN4
         JeLuC8mFwgSU52DVrxjyvufVGVW7qoTIT+lAiTlQkW9NUp0n2/2y3tfkAGGiHJhfnMx0
         LeDO0XlicNkFL0bPqD4c6KLL4rZMcX8dnNuDIJf6rlgnWsTZhc9BNz+Fl68totoV/i/s
         s55+T/PnWmzoQT0CTW+JVqb06e+i2F8O5hw4U/QXUQ9DzdOwvSr0MTM9TZHPucaJRwNS
         42Q84betlYu0PUMuim8K/kiduFvETt09maRsM8SuGrbvWRby6voMHA8huHKLersn7WHw
         6jpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789476968; x=1790081768;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BGGUtAFGUlVFMt0b9VHMyyf0YKtTCRveMamYZRai+1k=;
        b=UYZ7rPZD6y2Wx/BqfsagPAFL/wFr/p+6HYI+J/MjcEIC9Y9ENNY5LwTml0amhqKQH5
         d6a0H1pLv73bP7ggzojvd0Bbv5D3WaZhvEVgXxui6w3MTmrbwNiX1FPXmZRzY3HBFLvZ
         oWSbNU3FpbkylfoO2D81caXHXVKpLAFAEAgVyZ4ezYIxXLHaTEZ6027eFTzM0TT9hW/x
         wpppVxsmOup92AFN3uoWbOFy3IdnWnUbmb1UiQMNGqyiIrRUt4hETjE9h1Fx1yCIUMAg
         0oC4Gtz4eX0JXIQBzD4/49N3KlBnYtjMHNwLFjWrpAaqw0EI8didWh6dc5fNGbZDwXnN
         Afbw==
X-Gm-Message-State: AFuF++mzHeg+TvpKMwRMRkdRDHZch7P3g0JO/UDuWaJMjp5XNFeZ6oVi
	I2l6+wHKMTX2abHDj9gx2+dlJOAZTZE49jNxo/GquA8hjF/OWYAl8J1P9ppVyQ0J5E3uxKSYFUR
	sKDOlAWy+DD/a6TeXXvm3ubFaFuXJZeF3C2KEbWayPG0+
X-Gm-Gg: AYBFou0d3WScUhRyUMUvZrpJmGDrktBraXa68iaXqedEYdwD0pUP8v8DIQTw80NegjE
	asaoX+10s9KGgkF8TJh+1xdYEb85fHctmikz4lK1v1uy8ilnFO2xNcy0mia1XXTWv14KeY+ZbmI
	RzsXYUqJ73sVfoOffl/lyx6aRWTQCZiQWCUpwP9JHI/49HhTpvaReM27Y09qoPxAezcDTPNpmp3
	IK+i47Cfvopoi56a5Y4ikxfALMJfRv9n6D/awS/dMzopcNhfhTmFx1F9d7fCcf773qarLYXV9TN
	gw5p0pVqukQsTBSydR0swyi9J32Hid6ViLHRoIU1YWmUoHPIOGy3Rg==
X-Received: by 2002:a05:6000:468a:b0:487:360:a78e with SMTP id
 ffacd0b85a97d-4870360a7cbmr5439768f8f.2.1789476967708; Tue, 15 Sep 2026
 05:56:07 -0700 (PDT)
Received: from 830778650420 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Sep 2026 05:56:06 -0700
Received: from 830778650420 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Sep 2026 05:56:06 -0700
From: Ruslan Vagner <rusya92266@gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Tue, 15 Sep 2026 05:56:06 -0700
X-Gm-Features: AcwNN1Vl6Nrad57fBwWUIGbD-6SRQP2zbtbKEKHFqoXAQucxIPguX8GoBGBvxdM
Message-ID: <CAF9RqJ7jNhNNr1oYOeqpNiPGWEf0xWysz-D8N_yLVgmcJW17+Q@mail.gmail.com>
Subject: [PATCH] gfs2: fix comment typos in lock_dlm.c
To: gfs2@lists.linux.dev
Cc: agruenba@redhat.com, Ruslan Vagner <rusya92266@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Fix the spelling in comments. No functional change.

Signed-off-by: Ruslan Vagner <rusya92266@gmail.com>
---
 fs/gfs2/lock_dlm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index cef4bdee92a8..47eec0c13025 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -431,7 +431,7 @@ static void gdlm_cancel(struct gfs2_glock *gl)
  * 10. gfs2_control sets control_lock lvb = new gen + bits for failed jids
  * 12. gfs2_recover does journal recoveries for failed jids identified above
  * 14. gfs2_control clears control_lock lvb bits for recovered jids
- * 15. gfs2_control checks if recover_block == recover_start (step 3 occured
+ * 15. gfs2_control checks if recover_block == recover_start (step 3 occurred
  *     again) then do nothing, otherwise if recover_start > recover_block
  *     then clear BLOCK_LOCKS.
  *
@@ -809,7 +809,7 @@ static void gfs2_control_func(struct work_struct *work)

 	/*
 	 * No more jid bits set in lvb, all recovery is done, unblock locks
-	 * (unless a new recover_prep callback has occured blocking locks
+	 * (unless a new recover_prep callback has occurred blocking locks
 	 * again while working above)
 	 */

-- 
2.54.0.windows.1

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792669370;
	b=bG9S/fLYAHhLklbDpaxd2k4Xgd5K6uq3SGx+zUKgE8eLp/Eh/SpeqdsvIF2cDWQTbZZj
	 OUSB6Y9Xutq0CvdsePsxBuQjTUaTQNk3JS1BDRz3TShSk2JrTbCYS/smKKR3Pp1NHnA+F
	 tDUH5/8/7c2eLxXUeX40OGiCSdCJgE6aaCLL+FxfnvLE21qI4/DNnYhaAfVpKTJScpeN2
	 OmDE5GwCpSgJS7+ajbNqFo2s5pI97uZ2G3jVmGdjaWA+XUSeTpXVxsvOoAn/PbsW45vFd
	 MDx0QttCzhJJBpmi3U9vnH3hBfbWLWnOLwAi8hhvZHyoyZyh604VSZdnL7Gz4+7J0lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792669370;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3C+/zJHk6WbojkSaRVu1xcp7XcfcDsCBGR+H6V7CTEk=;
	b=w4fInnzIhwOKSGybmy1qXcHWTCSAk7lLIUfvqQ77+c1+0RvdEtmP6KMUOzIcdtPqgAK2
	 La9Wd0BNlMdoWp9hzBwlL+R+GMaYxcxk9Xde/uj8KEQgkCrOi+t+hoXzSUMCyNqLaRzEt
	 1ecDz5IKVsXdhqDeJdU29uHujqB1DuulA0ucKuo0rly5glN6Ck6HtcqXtgzqjEC1H5GOs
	 1qRGzLoRFYGuUNnZFe4Y3gNoP78BP4RneSJOdQpaGCbkdkxRYCTVHOHl+LwtsOqYTKKKr
	 1FeOduJTIzfdvXvCIzXx1kGOw47w2R6myMEF3sqeQYfvvFYO5IFbaRkVqS5UPj8uJbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OpRKxcPE;
	arc=none smtp.remote-ip=209.85.167.41
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C10606A31A
	for <gfs2@lists.linux.dev>; Thu, 22 Oct 2026 11:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90C10606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OpRKxcPE
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5be3dd6f636so173368e87.1
        for <gfs2@lists.linux.dev>; Thu, 22 Oct 2026 04:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792669369; x=1793274169; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3C+/zJHk6WbojkSaRVu1xcp7XcfcDsCBGR+H6V7CTEk=;
        b=OpRKxcPEM7GFUlAAPVkXvngbB9bs6LHiJhSm27ZqV+9f7XEq7W0sgMZ3P/5Acm/E+t
         EJJUKSnzp5otGHcTYgGQFtuqAx5cMClq++57in/m9eSsioKtEnoPsNTd+Ik7GM33TCkE
         LESmUdcDb5Dye4fcF8cN2/aTFw0CquYcnqDBlHSeW7PJKGMgNECgxbEDOBs2AoNiXkHe
         7X8p+6NTWASLuw4abepHwUPZiWU8juzGy+cllPUwLjdNwgcs3FkGpUJatsXNAHggVanK
         0wBXxmeYyeAzAEL+7HEI4bP5UFBiZsAjhEY0NiSFJ4AKM7SMeqJgvRgEAGvi59qrcRmq
         ZmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792669369; x=1793274169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3C+/zJHk6WbojkSaRVu1xcp7XcfcDsCBGR+H6V7CTEk=;
        b=PsFAUTFoqTaCWWpQzSv+lGGPicXZ5Vv0wbtWcR3TxzLxngS1GsFXU/AY5EBRWhVR2V
         D1gS5wEniBPuZREg0jZVEt96C3a/uHk5+FhjgvLH6/Vk1llURmsdiLlEzIpEJU+Pc95l
         nhgiSUbXQIRj6F3vgR4ixvGQf9UtDzPlblVZ/937HsLh+0gi8N04IaKPJLaPRSP/dpcT
         VW3kHH3378RXJmOQa2wlzlRts4s7HrSTVKwNigbdxVbY7rovOXLtMeN4orEBjD5ZDGh9
         7FAbVeO+H7X50GrtpOh1ZD2Iap8gj6QbVnClrb29TBGJn1Tq4dUrYlMgFJUuJMu/d45G
         TQjg==
X-Forwarded-Encrypted: i=1; AKwUvBwcbhPNVxgk6vi2BzWQh3ENCwD9NSPtui4ck8yMM0bfHn0IzLpjArYtOyCB2i0PwTsj5/E2@lists.linux.dev
X-Gm-Message-State: AFq9FYKlZWy/mj7YiK/CEhwCI2cMc5t6Mt+VsnlrgJD2nc3+xO1aj/jl
	LgVZhgbKTW0zpzEVMj2mrrLoo88zchUxnWmgm5ixqTKojapOGYPWjQ6o
X-Gm-Gg: AYBFou3d0kTuOLlSi51RaQctBCqu/qg9m5uX2Yq2qwY/eEIdrYPm4VNGuHB983BZo1s
	8WeKVz/erLrBVdOh05wQerIVVFxrC7VgnyRXQjpN2U2aJKJXmin3Woy3vLxOC/eeL4uI14CRN35
	a7arN0/WiY0alpvqAfOK45Ee7fa6Ehp3cJvyekkQnd7N9T/RLZSjfshX1Nck8SF0WbDhvWvSaQN
	Rt4lkLBv/BKdOrTZDZq8iq8FuYcJ9RI+Sfc4sQDKnv33/Bh3lneP6Y87wn5MiUOedwU0nQuWEjl
	5vXSwI1e0qzhEpaXRv29Y6t5C+1xE3P57qdIb63uFbfiF2lOW5Riyy9kiAaIOqIWtJGSWUlCwHM
	68agmK8Nj38yuJpGbJkbTwykwzjWhRomON5REel+sbiFmCPKRyJstfNUBJEBGzW4i8ezNSUwiWV
	gUfrhznyc42MShTF7iz9GHL79FG3Yx9HfVd8l072Wi0dzxlI7r2mFw2UQEb9HbLi4W8u9an6tCn
	siQGOCF5DqvU6ruPQ3QHDCW5zLwEMYLQqxZUy4R636BDDkdIa5MSALA/fLC+pg/FAloMQ==
X-Received: by 2002:a05:6512:34c8:b0:5bf:a221:ef39 with SMTP id 2adb3069b0e04-5bfa221f3d3mr1123072e87.0.1792669368241;
        Thu, 22 Oct 2026 04:42:48 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfa1b94eb2sm987157e87.45.2026.10.22.04.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 04:42:47 -0700 (PDT)
From: Dmitriy Okunev <dokunevdmitriy@gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: lvc-project@linuxtesting.org,
	David Teigland <teigland@redhat.com>,
	Steven Whitehouse <swhiteho@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] gfs2: Check gfs2_metatype_check() return value in revoke_lo_scan_elements()
Date: Thu, 22 Oct 2026 14:42:36 +0300
Message-ID: <20261022114236.122037-1-dokunevdmitriy@gmail.com>
X-Mailer: git-send-email 2.53.0
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

revoke_lo_scan_elements() calls gfs2_metatype_check() on every log
block except the first one, but does not check its return value.
gfs2_metatype_check() verifies that the block magic and type match
GFS2_METATYPE_LB and, on mismatch, calls gfs2_withdraw(), which moves
the filesystem into a terminal state (SDF_WITHDRAWN).  The function
revoke_lo_scan_elements() keeps parsing the block as a valid
log descriptor, passes the garbage it reads to gfs2_revoke_add(),
and continues with the remaining blocks of the journal in the same
way, eventually returning 0 even though the filesystem has already
been withdrawn.

Check the return value gfs2_metatype_check() and in case of an
error bail out with -EIO.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: b3b94faa5fe5 ("[GFS2] The core of GFS2")
Signed-off-by: Dmitriy Okunev <dokunevdmitriy@gmail.com>
---
 fs/gfs2/lops.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 6dabe73ad790..2aacd3f774ab 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -936,8 +936,12 @@ static int revoke_lo_scan_elements(struct gfs2_jdesc *jd, u32 start,
 		if (error)
 			return error;
 
-		if (!first)
-			gfs2_metatype_check(sdp, bh, GFS2_METATYPE_LB);
+		if (!first) {
+			if (gfs2_metatype_check(sdp, bh, GFS2_METATYPE_LB)) {
+				brelse(bh);
+				return -EIO;
+			}
+		}
 
 		while (offset + sizeof(u64) <= sdp->sd_sb.sb_bsize) {
 			blkno = be64_to_cpu(*(__be64 *)(bh->b_data + offset));
-- 
2.53.0


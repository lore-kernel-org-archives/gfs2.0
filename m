Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB13326D4C0
	for <gfs2@lists.linux.dev>; Sat, 30 Aug 2025 10:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756548864; cv=none; b=Bp1HhEd3Md7dShqoWcHN5sPJmPgZ1GvKehBFTDt2NE4uxuUA/FbIncypnsMy2mJoZ1SDomETUWrt6nyjPGhR+nvjfqEdSx4UvdPtPL/NrBtHGi1J9lVjyYwaD7eNHucG4eA80R9lqodSLBG+STOtpPTtuqyDmVpPB4tXbNbLUuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756548864; c=relaxed/simple;
	bh=pO6DONoaS0lUyRJJDY3ZV79rV05t11cx8Uegm3HkqmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kzKC5UrFJUF5MTOhnaw7tV5YsFbNeITvbMbkLKEzw6BcPmpRLkcZr6zrt438oRKVPMMr7YnieKrMKjU/UfSVpwVN6uPrY687ufAHNmgO5f49QRDijGHHaIHQ0KZytTEKMFHZwh4qFwDsfIuV/vhhw6v2qjfssn8LDN3HrCCM+bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRkQDnc4; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRkQDnc4"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3cd59c5a953so1896394f8f.0
        for <gfs2@lists.linux.dev>; Sat, 30 Aug 2025 03:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756548861; x=1757153661; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y4Cxt9YYRfml0wt2z5MSpLo70bk672E7ota6Kaf5Kl8=;
        b=PRkQDnc44WwbLD9WLkdHB3XYaNkquYG6K+oLSHPLUB4czmbxFTKdjt821hq/nZtKCP
         CgpAC0qz9vTYv/lLq2z3etDBRoTwcNeLa7A4CPNqw24qls3aANz05sPK0MEoJaW7XLdn
         /jXuh3jmgna7JtUOyLasdjrp7/51axN+ECuRlvU5a6hyMyxzONx4URqzepU8xIqtAiyD
         ldEkRX5tCVgjoBSejTZCVI8KNqcj0gmK0VXZyI0m8mIjdariVPYZlPeJZyEz26gSkXns
         yX7stNlyV5dSGnJ+WzN7lWKgZ40DlgmrDKQGEMjlrg6B4s5w2P8hQqQyiz+O9VFjirUU
         5xfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756548861; x=1757153661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y4Cxt9YYRfml0wt2z5MSpLo70bk672E7ota6Kaf5Kl8=;
        b=T/oPslDCzYTNgyM/+WY4+TtqMbbe8kStIMpRUNEj6DodksaYMJTaeTaPnA6K9xypvy
         loSou5CrvvWUPMveBsVFmM6pnvxApdHOaCkkgl27JSsO8Nin9xGIiTEigCuFaycnbK3g
         ud/NPtzyCBwH3qjZ4KLJQR3o0+r/hw5nycw74e+LN/9rt0InPIuOkvMlsaLlu1H1kxvy
         8ae1FcIuQ8e+ghkwUKk1KLfllgtBUoXwF+ZlyhnOFHckWgj6Ej1p2a4FS5MNBqlTp9vR
         pjkTlvdEV4Z7ARylTtmsdxMf7XC951yHJ1cwh9Ysi/qdXrIRHOF5FEJtxoQF3g2p7tQt
         EjxA==
X-Gm-Message-State: AOJu0YwCVkPP+RQfXnRLF5aVUaBdYMoJxzCfmwz7H6hne3/44jJPa/sC
	8ft/LBHmfmRExfeq/LO6j0ZlJW/4bs7Wo8D0GpO/bvQDmXMLiUKwC6z1Q+5Xyj0jHIoHtA==
X-Gm-Gg: ASbGncsmxi3EMiRJQEDkiCPHAryOa/1NiRMk2Es+S3ny4nkf/5tom0DF37ylEYL4ONs
	62pz73FNjpVTB0WKIKHum9JBqtELCGNstUdBA+QdK6k9iYVY/Wqu+m6ufX3+En2P86T+92RTjaX
	HNoRtOsGHrqYrXxtK5Fjiurs+OgUUYytlSm46/vytBHRoRyKqAQHEJkZHsA9UfnPm1mkAvGrTCs
	YelNro1JbIcgSroalpXmKBze8AIXMo6loGTPv5EZuQQgOIQow4Ai7Zd25v0oN3D7FfZXO/jDMXT
	72XRQ6tLmb1P4lyPeYW3CTDT/UHPStwaZzJnsdN0Hl6SbGSK+BZYhb24EJxd5JIRyD9Z7s8Oi7+
	ZeSpib49E/XMHDHhJvM5vqMluAvLFnMrKWaGVW+hcm0XdmPFKXhcbvUjhdx+6ZOnhkYKosKJFZk
	AwwNNBHmWUzi3jWRzcU0glcY/RDN0qmlHwcLIawL/js7Am7EIJAcVyEggpb/XnNRkVoprlQ1kVG
	pzpaV7w7vwHwtAanuw=
X-Google-Smtp-Source: AGHT+IEuB+qTKZ68oNvpjelOrU62bKL76ax/mQjCMq5CUuR0hkRBu3vLx+fF5cxD3tju/FNQGcUTsA==
X-Received: by 2002:a05:6000:2506:b0:3cd:5815:68cb with SMTP id ffacd0b85a97d-3d1def66c22mr915099f8f.52.1756548860501;
        Sat, 30 Aug 2025 03:14:20 -0700 (PDT)
Received: from local.station (net-93-148-93-71.cust.dsl.teletu.it. [93.148.93.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf275d2717sm6758790f8f.15.2025.08.30.03.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 03:14:20 -0700 (PDT)
From: Alessio Attilio <alessio.attilio.dev@gmail.com>
X-Google-Original-From: Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
To: gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	aahringo@redhat.com,
	teigland@redhat.com,
	Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
Subject: [PATCH 01/12] refactor: remove the call to  in
Date: Sat, 30 Aug 2025 12:14:02 +0200
Message-ID: <20250830101413.602637-1-226562783+SigAttilio@users.noreply.github.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 fs/dlm/lock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 6dd3a524cd35..5af1840f98d8 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -977,7 +977,6 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 		   request; this should never happen */
 		log_error(ls, "find_rsb inactive from_nodeid %d master %d dir %d",
 			  from_nodeid, r->res_master_nodeid, dir_nodeid);
-		dlm_print_rsb(r);
 		write_unlock_bh(&ls->ls_rsbtbl_lock);
 		error = -ENOTBLK;
 		goto out;
-- 
2.48.1


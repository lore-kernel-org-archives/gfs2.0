Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCD3191F7E
	for <gfs2@lists.linux.dev>; Fri,  6 Jun 2025 09:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749203294; cv=none; b=FThHwcbCOqMxkW61WCmvgJfI931JgV4qwg2GD95/dGCiN+1LxD+QvFD1407u5kbY8V/L1lo4gplMwiVvrm74oxzaP0zxRkurNELSisXEv8q9+k8p3L8saITUJRUGwsEvq9BRtEazBmvmrS2oo+iUUzDS4RSgG8WYBDB122D41As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749203294; c=relaxed/simple;
	bh=Nr7gzNHhzK6SfN3GZps/CnAQT24yQRdzgt96cNLYlhk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ez02K0h0Fn0hhk+x9vwgKTyRBHRUn+jyCibqJhbHSrBOQFYs3kWfpj3jOeuutMOAtHHWDerAl0wTyZKpP9nWaH9ZaeQGjh2DC1/LOyVBQsm4EjqyG8+moHjZQzb4eCOer1XR/geMmGHt+lAtEPy9QY3iiFJD25bbGXURy8x5mG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=c/8DoPIi; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c/8DoPIi"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a4fea34e07so1103776f8f.1
        for <gfs2@lists.linux.dev>; Fri, 06 Jun 2025 02:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749203290; x=1749808090; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b6a/wWgv4z2Lf260+pM0ndSkZUt47yMOOYzLX3ZbOmY=;
        b=c/8DoPIiaaelyeAegCxj4GttugPRLDm17maHh35Nqyrw1Y8AU8gH7mk0bDYgrdscoh
         qJ95S6rMMA+IYrm37IvjyxuO0UiQD3RO96sueQ7CVQQEq42IzwM9iW8/DvIA/NjqM+Q7
         2mGkkx9pZ4drgH/pBoTaf78KhJk4zJbmWQwMvf3Xlbo2RFpHaJ/iQPSaYMut7SastP12
         KZRUGUjzd6fjSiox2vspiANssrmSNhVyy9PXFEHlcMpNaNNxJNMj5ByiDCIux/FLm+6e
         +LHyHSOAJNmli28s0+XLgb7j0ygfXuARPfyseZUH06arNm2SMuMzxM6dPNUQvnZ8MQLl
         OH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749203290; x=1749808090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b6a/wWgv4z2Lf260+pM0ndSkZUt47yMOOYzLX3ZbOmY=;
        b=L1vSk5iLMOWeY1SPNsl+mrgUEAcNfGvI4RxxuN2eQwf5TMM1Hz4y/Ooq5ZWrk+zHvF
         +c1gVmIuSoJ5YdBoNzOjFOGnf1rBYvPA/mtMe9IkhfYh6N7mK8wfsD5eMY8ONLq9EdmK
         W5UXHNqPQH5KK2S8YMEKUD5WNLflb1rM64d6bNqa1n4CMDCm51QyziFYLubsDiMVh/k0
         0K7q5gozYxX2QiJf7EfKOnJdAFS9GjZlpX1WKTefpWg+HkGuoOfYlXsJfuQTryopA76L
         0bOW+TGuWqfDXZjkitWb0CvnGFw/bPIeSze3eXMto4pg1F0h+iDICMcsw15aZqXE+iJN
         Nu3A==
X-Gm-Message-State: AOJu0Yzq5wDS0iMflEUQk75aUmi/RXKH+B4+ySnqnxEu+wMPklPLP6HP
	SCZVre2ZbyAa0yofq9cagFLFqxOqAHO92CtT8WULdnKnfR05dtJ0KGpDBRnQ2wQS0I1U6hEg/KW
	Pu7T8BGQzgxdd
X-Gm-Gg: ASbGncvglhPcGCe06OwEFMLCT1wvbo2xCpi9hK5BYeHFvEQ6jPg1m3QE0lB1pszZo+p
	o8ZK33jFmBB69nDCVmujNbZL3LsaZjh0wynm6rCbt7W5WqehmNsDR3k4eImOtnOpROIWkjfui02
	/EqV0ERczxiJ2Cubg/3YDWohd4m5z4MuN+QEKMGqhB+mVkrmYhSbK7sY22HRzV+yfkaEy5qPnnO
	KJNn21BR3sLmjG3mHaOQdQLc9KbdAeNUu2RIU8JbMbYMh9qi4I/KgXGlARU5SwEKnPooUcYwW3B
	V0RzRsPFzrxIhZjHcdCk7jSz9Sfbzwte4z5i8gPC4Njn3/xZDCQ=
X-Google-Smtp-Source: AGHT+IECCCjnriN9rju+WeXUfQRiCCgCiMiVRvDj+tqQ2UCo0oswROZKa5wwz+TMXK+hAouXLIOKRQ==
X-Received: by 2002:a5d:5f53:0:b0:3a3:7077:ab99 with SMTP id ffacd0b85a97d-3a531cad91emr1665154f8f.45.1749203289963;
        Fri, 06 Jun 2025 02:48:09 -0700 (PDT)
Received: from MacBookPro.lan ([5.255.111.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482af3859csm936348b3a.36.2025.06.06.02.48.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Jun 2025 02:48:09 -0700 (PDT)
From: Su Yue <glass.su@suse.com>
To: gfs2@lists.linux.dev
Cc: l@damenly.org,
	agruenba@redhat.com,
	willy@infradead.org,
	Su Yue <glass.su@suse.com>
Subject: [PATCH 0/2] GFS2: Fix wrong call of new trans for jdata
Date: Fri,  6 Jun 2025 17:47:54 +0800
Message-Id: <20250606094756.95958-1-glass.su@suse.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 is trivial.
Please see commit message of patch 2/2.

Su Yue (2):
  gfs2: rename gfs2_write_jdata_folio to gfs2_write_jdata_full_folio
  gfs2: do not call gfs2_jdata_writepages for jdata

 fs/gfs2/aops.c | 46 +++++++++++++++++++++++++++++++++++++++++++---
 fs/gfs2/aops.h |  1 +
 fs/gfs2/log.c  |  6 +++++-
 3 files changed, 49 insertions(+), 4 deletions(-)

-- 
2.48.1


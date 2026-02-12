Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C0070818
	for <gfs2@lists.linux.dev>; Thu, 12 Feb 2026 03:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770867778; cv=none; b=Xcj4y3RTn+aujbaqPInanEwVtmHUwSFTxQ+iWsQ/OPPHwjD73iktLMNIJ/67wLPZUDH0Ov4FRKAUOudYBcPIt4VsqUdmtbmtG+APV+NljR/5Cmpsi8W42XflP0u6G1F7Kw4sih//aUbej9gYHanlmNn683giwdvEtMDiuEzzWV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770867778; c=relaxed/simple;
	bh=nNp4Wp+vu6RPgm0Gr+xltF6IUuc5nM/Ab5qww+8kGhE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YwJ5Ek6iTO+Rtk3zghFINLylIApMZ78gBHsymynyS56FamiQUMve+bTucyj+NzJlOGD92HXtRCwbKXdH/yjCsuPPQs1WVJ9pBMiQqodlo6tVrHx+eQ4/ddqXZgNPCA8LEjii9mQboqAInojYnK17sVZcN/TjEMLoKwIUiJiVvro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=kfEjPtyl; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="kfEjPtyl"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8ca01dc7d40so280485785a.1
        for <gfs2@lists.linux.dev>; Wed, 11 Feb 2026 19:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1770867776; x=1771472576; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=seO+5nAucO1bceqmeu6GxIOrO5iVYQCSjl/bvIVFZJk=;
        b=kfEjPtyla0qADOzo276nc9gazQhTL413+O0T7FYWlKsmKgaFV17Kz+YXgYD+HlvV7N
         M7RB4mJ8VRCREqSNENlxUpuTWa4m1hQ5ZTN2L8dHWxUbvy23uc1g5amOT7BjitOx+hFr
         U2pAXMjtcBNWXI+fIyXIxcL6RocET+b3IOyfxL0Zs4h7zojhGsJm5oiFTCyjmZnAR+jm
         i5QdcpZriapehOLVLva3+yC3AYGO9QCxstfeCPcOagqN4n04D8h7K1m+rKgqTLkWer1W
         j0N4exLAhm4e+RIBoebpu7D49t9msB7gUcCf9tf9W8qKlE4iIo+OWbm0LHGw6atB31qt
         yq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770867776; x=1771472576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seO+5nAucO1bceqmeu6GxIOrO5iVYQCSjl/bvIVFZJk=;
        b=J/hdyrWxnqwBLZEItJA4iLySUFuqXAaDSHJg9fQ/3aJm0ai1kktLrU6ntyMGMAYuxU
         iSfn2ShsYug418qRtysy2LV/jCnfXfqcaSRKnzzyPAhIRwuI8sRno1iP9mn9DXTNMsTN
         E+Yyn0oryYXckFgxQDLcNXI+7MpObtjHMUilZTsy6pHsBwMVZBkHfuCpAru0ar4+hDSp
         JN5Lcni4fOb0O9CARw4pINJnsuZJdSLS29ksiAMrKJV+x6wiJ/hsDz+coRBuT1A+Ax33
         c0AectrllOFWjuiO9DXSf0oRgOvUBNQ7OFnJL6A8iYT2wTu/QHrywa3Ab6OKSHGEDYp3
         T1VA==
X-Gm-Message-State: AOJu0YxUwFwr+e04qJ0t8VsU+JxPIlG8VYBD0PKM1KmvyPYYPK80cRkj
	iy/CjEIrrxYf8uRfVhPYzRKg6wZM0M+LlnCNO5fb9xiQTA4+cFSrzo/qkeElIQMi5iI=
X-Gm-Gg: AZuq6aIeYa5qLv76z3/+ZqyEp1BEEjkYro3FDY/HN2AlmfFCl6+XUCHhMFmCi/OGQyg
	hCqP5Pe5lcqiXupFXMFPlJsA9upn6beTDnsp41/d8vuoQSUa29ZgrVHNYZdqsgRhEOJzHdM3PCw
	qfnyRdP8pOwZPngemsJjKmSHd5Cm7wwxYWei/FUwkXZVtbsBE0PjMmng8oDZ8KBC3jfyRiN0zTj
	rCeXP/vlFHH6wjDsiKCmYzeTcgb2yrJcrot2twJS1N++phVonFlOrS019GxdCuxsMgzKSlZRcdy
	7+AzET+2XdZ4AFrwKJWqIiFlAHbL9EI4tfYItRlVoJ7jjzhjDeU7zEmSiWBcaxVTXHYwYdFnvN1
	bTN2+nUg9BXdeBEmKkZ2nOJpKTyROAIuTtLackHJPRM2bCYNJnQ0uI9YP8akvEv/xaiqSq1re5H
	P15+NQfvIJDI1Ek9T3z/4qO6sUdry6wW1O2CNZKFMm4FSP1SLvtc75uZXUBtQ9xLbprSXVnIlUE
	KJ2AxvqVrmqPOjiDv59Rmz0zzQ31dDvpyAbCF8Y3dg=
X-Received: by 2002:a05:620a:1708:b0:8b2:d26f:14b0 with SMTP id af79cd13be357-8cb3505b753mr86208985a.3.1770867776256;
        Wed, 11 Feb 2026 19:42:56 -0800 (PST)
Received: from security.cs.northwestern.edu (security.cs.northwestern.edu. [165.124.184.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cc7f2a5sm29182356d6.11.2026.02.11.19.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 19:42:55 -0800 (PST)
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
To: Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ziyi Guo <n7l8m4@u.northwestern.edu>
Subject: [PATCH] dlm: add usercopy whitelist to dlm_cb cache
Date: Thu, 12 Feb 2026 03:42:54 +0000
Message-Id: <20260212034254.2864235-1-n7l8m4@u.northwestern.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dlm_cb slab cache is created with kmem_cache_create(), which
provides no usercopy whitelist. When a callback carries LVB data,
dlm_user_add_ast() copies the LVB into the inline lvbptr[] array within
the slab-allocated struct dlm_callback and redirects ua->lksb.sb_lvbptr
to point to it. copy_result_to_user() then calls copy_to_user() with
this pointer. With CONFIG_HARDENED_USERCOPY enabled, this triggers
usercopy_abort().

Switch to kmem_cache_create_usercopy() with a whitelist covering the
lvbptr field.

Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
---
 fs/dlm/memory.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/dlm/memory.c b/fs/dlm/memory.c
index 5c35cc67aca4..ee55994ce90d 100644
--- a/fs/dlm/memory.c
+++ b/fs/dlm/memory.c
@@ -48,8 +48,10 @@ int __init dlm_memory_init(void)
 	if (!rsb_cache)
 		goto rsb;
 
-	cb_cache = kmem_cache_create("dlm_cb", sizeof(struct dlm_callback),
+	cb_cache = kmem_cache_create_usercopy("dlm_cb", sizeof(struct dlm_callback),
 				     __alignof__(struct dlm_callback), 0,
+					 offsetof(struct dlm_callback, lvbptr),
+					 sizeof_field(struct dlm_callback, lvbptr),
 				     NULL);
 	if (!cb_cache)
 		goto cb;
-- 
2.34.1


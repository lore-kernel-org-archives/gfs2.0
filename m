Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795673300;
	b=VozqDFSJfhZ2wbIf1BXtAEN0lfY7hTSfsapdfCSi7TTgSKHQ2OvxOvJjYTAoM3Z8Z5qF
	 WVGnwdv5HphmSUd9VpNLZIf5YVgpcI461e5HeFAdOOiadwIVhTxZDqCRrO12h2sgJE9Mx
	 v39xYSUfFUQJhgOkUE7owKNpJ3k7MM7pKmtjS9QscXIMG29U5t0o7iETXwktnuyWjAXa8
	 wDTIOZ6Etvl+3MO008TB4567Ybq4K+QNyEvFaNvQzOv20dKqPIY8iJn4CCHxI20eNQDeq
	 zLh9frYGaVCoOtEDyXZkIAC/Zioby7+L06jCryjfP4b2YqOu7bXt+0M45z0k7IsXLYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795673300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=DZH/wi6uV2Gi/BYsBvky+dhyis2kpdwF5WMhDFiOwFk=;
	b=4JAloQydiqPV+ip19PYiOa2a12oUZ7AZSL4LstR0+0k+TGXY3ms9DGe+HxDqPqnTYGnU
	 evLNpC3JWOx/OG0+N9sF8EzJzfhD/MSCl9FBkM2IohoIPFdjZVq2uIQNbkVpadlvO2qyX
	 IghBHfpGxDWloWDuTbFAXuqssRCesBObgxK7Mu8z3gxffrSTnL/FzuFDVKbaPnRmvHPhl
	 cKn03NYDkzeoNamnK2bJkIQ5VEfnfhSbM2laqaAz4xvzqE5uWbiZJT1V4KdleIhc1G+xp
	 ePMnmXhW4nf6hLsS6ajqyTat72/za3Kc8Qu8GJuZPQAzh4wmDiWp7uR/jFLrzvcXoBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="xdm/hdCX";
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E924C606A321
	for <gfs2@lists.linux.dev>; Thu, 26 Nov 2026 06:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E924C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xdm/hdCX
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2f0414c1062so40714035ad.2
        for <gfs2@lists.linux.dev>; Wed, 25 Nov 2026 22:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795673299; x=1796278099; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DZH/wi6uV2Gi/BYsBvky+dhyis2kpdwF5WMhDFiOwFk=;
        b=xdm/hdCX0L0nU4o1IZ8u90sOsFm7iq7yJQ2guNLSpeIOBuyyyUEBw9Gh1IBJD2U5Yo
         N5TiRdqPoThJUDFuDo3cu5/1FYY248NUab0MpuEoYJli5ZnIAnlbY3TL9qS35YxxAhky
         t8QZjXLzyGEf4KqC7DEKmrM8ZIB1VODP02k6gnGXRlKE5G2igNi8IaKJjE3fpkH6yfvT
         zfaUHzrpRYWA4ITiDScRogvE/1VHv0ehjl2AfS20DrJdEwdfq5T6noECGJBEnGSGrlfG
         OoswccEcko2zFDivu7lcoUeorKeawVHWmhs8j4OjhnP/l9MRrLUyKZEUnVhGzZNphlp+
         0FZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795673299; x=1796278099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DZH/wi6uV2Gi/BYsBvky+dhyis2kpdwF5WMhDFiOwFk=;
        b=j0ydX1rfzzBlBM5zyhGCZjGhETTq/yG6FCYT4hZXiKzStxhk5+gnEpTDdd55TNZCzK
         An3uoevIQlUfvKDycg9QeTuAJduyOync1rOLXP70GweLCTdfJ2/lHVN0fccELOIcdMR6
         MDoxQYugb4d7Mwl0VgYBSBR+Y3jGGkjEsnKrm7VLKVjfhqVAf1GYiFjWF1TLIbgbWgzC
         uzGE4o69IMFhiifOq5U6luafPEVQb1qhKGTsfs1EOZMSGhH8KfTkpWaW3yRWOnOIpkrY
         gDdfx1cRr6/23Lxf2lzO2L17WPVsnlCjMFvwNFqJ0n12IsHbQHf8e0LobRT+PnnTf9ZE
         v/IA==
X-Gm-Message-State: APuU4Z+N6vA4aMAZmBTnVyysVUHpB+kVKjtKM/ppjIIr9Ld7SXyIQSve
	/PvXs1+/VMkd1LWA5/Z6CoBCUkpTqZu9R3TkHxRs/PY/yleMfoWVKhC/t7DFLqNQzgKfnqFcmVc
	=
X-Gm-Gg: AZFdTZfCRZbLoplLFMnxHEOtouwdJ6xc1Q802U7guSEV0ey3AaNJ7cOYvTtPlcyR6Gp
	0rxtqDi+nkyrYrRaKXKNFhJcygQXPw8fYZagZGGeWMYIVKJ7melHlsaRtMAD68RWrxKs+NRAhkw
	pD9FjIcmJebWApTH0XA1OUOTZv/0t6ioCnirsHpUY7BmTxJxVeJeOn2X5ukIlFZG4wB9Z2q9s9S
	45S1uwx1ePPtVVYbY7M64S8kRFeM+vKe7gw4no7D9YZuiYqGdflE1C54bf/JEORIkGtuCDOu237
	WBCAlhZLmVP7NQYSjqCUDahfqWssEXuwV9Yv4HIf9aojLydYZZJ3wEdw5dM+sDD34cVuRLT9R+l
	xnOX6GZ2RMRrNlDhiv8wI+xQBzE4o4E4Y2t+dhuxXOcCvQxhT3b49sS9OjPtdiunsJGSmGH0N9O
	I5zRxjXolBehP2eX5m8nyD0B+gEATjQOoLvNfV5JJNKx16k98fqzVNlnxphUFlwqqw5K8HBlRLS
	T9FWcmI1zPtpCBFNZHypDM6oDztdK55UA/jBFx+mX/7zh/LpaCu2N5We4fUNFNgflR9xAG9dLK+
	1rtcrFPpb0eSEMGgQor64abDe6Q/XrPwJ1zOdQnuxqhdIV8JmFusxqghcD5bik8mWK0gUGHLMK8
	4wO0Nxb5L4DdAgmjEirDvf37L5/3R4e7URv8kg6omTKCijYgQ43ex8H7vxTCYUS8nZQIPAO/yqn
	7qhsNBWwM6TrUhSG+CSS8wyb9D35FIPcycIdpXZZeOtA==
X-Received: by 2002:a17:90b:2f8f:b0:3b0:ad59:7199 with SMTP id 98e67ed59e1d1-3b41c942629mr17539691a91.32.1795673299196;
        Wed, 25 Nov 2026 22:08:19 -0800 (PST)
Received: from LAPTOP-3B99V33A (ec2-3-38-183-164.ap-northeast-2.compute.amazonaws.com. [3.38.183.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b420e1307csm29928050a91.7.2026.11.25.22.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 22:08:18 -0800 (PST)
From: "Bin Luo (University of Electronic Science and Technology of China)" <luob87709@gmail.com>
To: aahringo@redhat.com,
	teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dlm: validate lockspace under ls_lock in dlm_release_lockspace()
Date: Thu, 26 Nov 2026 14:08:12 +0800
Message-ID: <20261126060812.2028-1-luob87709@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.1
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

dlm_release_lockspace() currently calls dlm_find_lockspace_local(),
which dereferences the raw lockspace pointer to increment ls_count, and
immediately calls dlm_put_lockspace() before acquiring ls_lock.

When two callers concurrently release the same lockspace (for example
via concurrent DLM_USER_REMOVE_LOCKSPACE requests through
device_remove_lockspace(), which also drops its lookup reference before
calling dlm_release_lockspace()), the first caller can enter
release_lockspace(), remove the lockspace from lslist, and queue
ls_free_work to free ls before the second caller dereferences ls in
dlm_find_lockspace_local() or release_lockspace().

Since lockspaces are only added to and removed from lslist while holding
ls_lock, move the lockspace lookup inside ls_lock and verify that
lockspace is still present on lslist under lslist_lock before calling
release_lockspace(). If it has already been removed, return -EINVAL
without dereferencing the pointer.

Fixes: e7fd41792fc0 ("[DLM] The core of the DLM for GFS2/CLVM")
Signed-off-by: Bin Luo (University of Electronic Science and Technology of China) <luob87709@gmail.com>
---
Found by code inspection. Compile-tested on x86_64 with W=1 and KASAN
(fs/dlm/lockspace.o); not runtime-tested on a live DLM cluster.

 fs/dlm/lockspace.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index a9c98b4..37ccb96 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -800,12 +800,18 @@ int dlm_release_lockspace(void *lockspace, unsigned int release_option)
 	if (release_option > __DLM_RELEASE_MAX)
 		return -EINVAL;
 
-	ls = dlm_find_lockspace_local(lockspace);
-	if (!ls)
-		return -EINVAL;
-	dlm_put_lockspace(ls);
-
 	mutex_lock(&ls_lock);
+	spin_lock_bh(&lslist_lock);
+	list_for_each_entry(ls, &lslist, ls_list) {
+		if (ls == lockspace)
+			goto found;
+	}
+	spin_unlock_bh(&lslist_lock);
+	mutex_unlock(&ls_lock);
+	return -EINVAL;
+
+found:
+	spin_unlock_bh(&lslist_lock);
 	error = release_lockspace(ls, release_option);
 	if (!error)
 		ls_count--;
-- 
2.43.0


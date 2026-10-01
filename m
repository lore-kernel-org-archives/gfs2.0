Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F206E486B99
	for <gfs2@lists.linux.dev>; Thu,  1 Oct 2026 06:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790837103; cv=none; b=smigjPBPm6u1hBjYWyykCfDln3LaU7Bk+NhzuUrL9DtTIHsX38TyuShMGJk/fwy4QomWkgtnLu1Zi+PBBTBFnHOo4SV23+9yVdAXcwBLAyxuE4AwxsGtWmA3eAm0y4JWP9D2GDcoVaaTLxOmmEthGWxS9K7G0KKti1ajfwkftrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790837103; c=relaxed/simple;
	bh=votCEGmz1dBqut4kLOHSiZQ1DnWpjQ6Ww8QiJ9avmvI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r7DXQnRwqh3MCs3+HBjsf1TnZG0wEPuqeeeLHMQPG6bN3znoq7dF6XlaYbS4mA+EUEOd8L7MMrrM/uLWDteYfXfvQGgR+4vre/WG518v09rM/XR/0ktJcH6jzWBf8vnIJmo+Teu57f7oX1IytwCkF9J4ldmS77EOWZfxrqeZuXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcYckM9c; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcYckM9c"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffed768deso15430135e9.1
        for <gfs2@lists.linux.dev>; Wed, 30 Sep 2026 23:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790837100; x=1791441900; darn=lists.linux.dev;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D/97GcaHqO60C3xOpYaJJL73vz2EyjukQ0UgEJCJAEY=;
        b=KcYckM9cv3z0Qd/6pA/Ta1TPKFakGwUHGGSmjbpNpCfgg/PdYUd9ym0QkRYYz30h1u
         NQIpiOnJnE7rPh5SyalEh2arngJBOpiGs4QfKmrBWY4PAML1k3GFjfjwFtRxZDvrMtjT
         0LXEoPpw4oIYpDjmKWXzI7EupNHjJLpj7JoXi7OKbwewxn5dxiIoUBgL0w0ZJJr7Amgm
         v+fhGQE1yXl5rPL9jMXlTiYw+R/iz6x3bPynKu3Ff5NhaZZJE+34kLy77QQOYuE0xLeN
         XLNzHpFPDmfz7nE1hL6UJJS1jfbi04p9WXiFQ4Ru9Zsx0fpq4/Ab9NKQlf79v735ZJpI
         afgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790837100; x=1791441900;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D/97GcaHqO60C3xOpYaJJL73vz2EyjukQ0UgEJCJAEY=;
        b=XS/eKTgJzlYZ2XnKcjO8hufbmBBoK3RVsQ2/SGSpNG2teDCYMiupmJvpUAUttVzcAq
         AYo/bjFhTSaj59coDxcakmzgJnxnAv1mTBAWWqMtvvZrEtOpv4WhhW35jDid6Egv8UXS
         3wl6srtgOLS/mpMRbfejs+WLTCB+MMvvjT+LJYiCKMEC5SFtNjLQM4sAb2nOJ7Q4dG+1
         RpKbntRopdyr6Erc3oQaOCuXsZ7fqcEhXRN57T2M+ZddzPzUuHza/PEwMWJjAP9vUgPz
         TBzZkvG8Ab5XWaWUR429J4xWsYiKk09e5JPb3pUXwOKN7pAtrn8FiD+ftA2Qs6twK3h/
         JHxQ==
X-Forwarded-Encrypted: i=1; AKwUvBy0M4cxAeyaIZHzW7KJ7OOe1ePV2gDBM8Nf2oxVA56X5FlzwBgV5nd53CABCY2E0qGgM+ni@lists.linux.dev
X-Gm-Message-State: AFuF++ljSpinN3Y7rk/g56Ut24/oHebMU8EMeZRwDSe9PAhFjhXTnokP
	yErrDBeBS7ysqY4xqyQkFDnTYAd7xtiO4UY598rI6vTRDUiP6Mszx4xL
X-Gm-Gg: AYBFou0wZAzOXani2s2PNy4yY+ZXIbyM4Fu2XPJParua2OwuhjmhAfi1L0y8GiuRHVa
	fSll4380gixf+PdHE5GQ6cmnkJqK7ZL79mCIT9lZR5CftY2bocm0aMk+IyXVA8UtKJ7l5LmtkZZ
	aHCT0QhuNL9ksDVUUc6w/yHr2s4Yea7X9/7gdX1wHSeDIwkAs/Y38PIVvDamD4uw/GmKYD6JcbD
	aKAYXrFepx+7zZMQq/vDTEllp5Iiby72pr4KGSJ4uQhid9iOzV/ADAUMp1DLxDvrcLHO929TlZr
	rTXirHLV12ftNXymxGwU+jmA9WGXrjB/jlUrTzukVIZKOzgkaQwOoaBQh4bVHvlrV3LfItZ5l9x
	CGPyoeeZMJyYVHp9Luc1QokguSskoeg52oWb70AuHP/PvnbhZNFtpzrKMFNfGBZozmMpYkJr4Gq
	ct0lBq2RjiGRiACOZgnBx7lmQVVK2gOhdjWckpUuNSHxlTxqqGK9ZwaENn6NMomq4LobxX
X-Received: by 2002:a05:600d:864a:20b0:4a0:ec5:46d9 with SMTP id 5b1f17b1804b1-4a01eaafdb4mr22604095e9.0.1790837099925;
        Wed, 30 Sep 2026 23:44:59 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f99a332sm86476875e9.12.2026.09.30.23.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 23:44:59 -0700 (PDT)
Date: Thu, 1 Oct 2026 09:44:55 +0300
From: Dan Carpenter <error27@gmail.com>
To: Alexander Aring <aahringo@redhat.com>
Cc: David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] dlm: clean up a type in waiters_read()
Message-ID: <ar4BZ26gjQEjZgIa@stanley.mountain>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This doesn't affect runtime but "rv" stores error codes and so
declare it as ssize_t instead of size_t.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 fs/dlm/debug_fs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
index 700a0cbb2f14..f52a51b1382a 100644
--- a/fs/dlm/debug_fs.c
+++ b/fs/dlm/debug_fs.c
@@ -596,7 +596,8 @@ static ssize_t waiters_read(struct file *file, char __user *userbuf,
 {
 	struct dlm_ls *ls = file->private_data;
 	struct dlm_lkb *lkb;
-	size_t len = DLM_DEBUG_BUF_LEN, pos = 0, ret, rv;
+	size_t len = DLM_DEBUG_BUF_LEN, pos = 0, ret;
+	ssize_t rv;
 
 	mutex_lock(&debug_buf_lock);
 	ret = dlm_lock_recovery_try(ls);
-- 
2.53.0


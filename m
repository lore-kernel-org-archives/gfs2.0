Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8839319B5A7
	for <gfs2@lists.linux.dev>; Sat, 21 Feb 2026 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771686015; cv=none; b=Dp91kEb/YZt8gLWbUbLBXh2A3Olfv949KuxrixzsIbRp0vWQoJOXqT1PGimGjkxJX06orTjwyjm63EHLyyk4og7DUKAd3+2vVr3w+//HyK0j3I8WfTXqk8ICmalpfbkY6zv6YE6TUOHc9n0/i05M3zTrGQfVagMdRUldPZ9aGfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771686015; c=relaxed/simple;
	bh=QvKBTacd5z2P43CbYauz1u/x08KHhA7f2Nkz0BaL8og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prhgsRp/Gw5Gbvifi+1v2JRoH7CEzV964xAKQvEF/tKcDAxW/g8a3y2xcA3eO4vt+8BnKr1eO0RcwCtDpJ9h5ylD8Yhvv+i+rjbeSkY5/kiaFlNfL3N4ctu48uxoujMjaTi2B+UbV/pihgHoJVHEu9akiiYifUvCcP1EqWxbWv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNCCeRMu; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNCCeRMu"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ab077e3f32so12518725ad.3
        for <gfs2@lists.linux.dev>; Sat, 21 Feb 2026 07:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771686013; x=1772290813; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Vj99fOR8e2nvanig9cWTi+niKOe1ygt4TyyqPTa8nU=;
        b=XNCCeRMuyqePWSwM6QDXEhpQgu6PLC7k1WpzzCCFfo4nnTEKjmajTDp0jvX4raQ+GR
         HMt5haSQj6FmgCoj/Znelt5/t3ycUDljLdM/cH3nE7sUFkt+otvzbkWXxD9jIK7vjGR/
         Daw8yP0pxlZBgGB9fTkLHrcyfVOFeMxJ9WNfY786wOl5yQn5KEZzuRM/FuAfN2lOOz1+
         NvxALA4YIMlmvs3wHACHS3yFXcjD7aE3hpcf7rAckRFVdfPNRgKU0pJM7FvW0ohxrXht
         uULlzBVxpMUm9WBIEYKIv5U1SM+J+hxC0tPwuaGWA1uTGP9PQHbu/4OWXWANeVrFLf36
         DWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771686013; x=1772290813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Vj99fOR8e2nvanig9cWTi+niKOe1ygt4TyyqPTa8nU=;
        b=kAu7IhdRLT8OnuY7YpoR1qfYU0gfWtLtnapunplhTjAggJUUCQa/aNoHoxyFDW6AnP
         bhdXGQj5nSyKQXUTKYD1zPPzdY0CQ7bd9LVBMMl/BxPkCRpOL1sIRBIQz6OvCxXQaMZd
         kxddXhhsybaRkBTKg+aoBbZ+kZqKCWxEQ1Ij39XE/NXgv64ZF0AIlO02Pw2ds6u/oXqq
         h588L9vetF++6if+WqqrfsN/H0TrZEAOEmzM1X4Lw+/oZkhOxZM5zNuwBb7ma9vgYA7x
         TFQSkIj2n+kjIxUQjkJMUtB+Ogfb8gT3vBsbB2O4XoqkM0P3T/qjBmEr6F07gv75AZ0G
         yjYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVTBAhcg3qmb2TjIDtRo1c9n6NHF8fYYZwoDkJHsK4mIpnGxqiJaCpFBBKipSnCYLurETp@lists.linux.dev
X-Gm-Message-State: AOJu0YxnugPGdA9kBREnImGSxuHn8cAvla5ehgusxzVWkwFYPkjFOysz
	TCzeVdv2Pr6qyeNQ84UDEYSgzEOrleDimHsq+Jt7CSCV9ETUxfCafFTy
X-Gm-Gg: AZuq6aKYCkMI9FvpaVbKL4TE0JTkM2C3qx1VDnkE5f2PFKPEcitEBGtCNcF0WvH55gb
	WpnJkc3JCGmqW7CxfzDxrsGo4yiiEpEAc9Xpa8tnEEegf7bNIBAbWuWx0CM0YMBj2hdTSvghmFF
	qAupC1QMP5Y3iwWQieBs/dLQtIMo3xgCrkS4wkT/fAbIpmJKg4hW//Sq4NQbIKSugFhPHp7n0Ao
	KqzyNBpkK3veJlZYHdRa0/lrrI8M/R27hNz0piRvmuV6HAbroZmAKbToHROBVnhDQt2e5qa7IDb
	g5CkeWo2ZuesvxyWWu62v/h3DbTraZC7N/iTB1Rgn04H3otawqc+ZoTlUUeE+o2rk86RMjUPtXe
	9NpAUusqCjSLt1JJNHUtxdFoqNs1v24L8aQ6KpJjYevqy3qElIBKh/V7wVVokrO3VPp2KYNICK+
	0hbqCryTb5U9h0AdliqSn2XO4s5f5y1kPi5cjXFGU9ArrHfYRGKDjru8Y=
X-Received: by 2002:a17:902:cf07:b0:2a9:322e:2473 with SMTP id d9443c01a7336-2ad7457e58dmr34715235ad.48.1771686012796;
        Sat, 21 Feb 2026 07:00:12 -0800 (PST)
Received: from toolbx ([103.230.182.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7503f4a4sm23730205ad.79.2026.02.21.06.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 07:00:11 -0800 (PST)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	chuck.lever@oracle.com,
	alex.aring@gmail.com,
	arnd@arndb.de,
	adilger@dilger.ca,
	mjguzik@gmail.com,
	smfrench@gmail.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	tsbogend@alpha.franken.de,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	davem@davemloft.net,
	andreas@gaisler.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com,
	agruenba@redhat.com,
	trondmy@kernel.org,
	anna@kernel.org,
	sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	shuah@kernel.org,
	miklos@szeredi.hu,
	hansg@kernel.org
Subject: [PATCH v4 2/4] kselftest/openat2: test for OPENAT2_REGULAR flag
Date: Sat, 21 Feb 2026 20:45:44 +0600
Message-ID: <20260221145915.81749-3-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260221145915.81749-1-dorjoychy111@gmail.com>
References: <20260221145915.81749-1-dorjoychy111@gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just a happy path test.

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 .../testing/selftests/openat2/openat2_test.c  | 37 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index 0e161ef9e9e4..e8847f7d416c 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -320,8 +320,42 @@ void test_openat2_flags(void)
 	}
 }
 
+#ifndef OPENAT2_REGULAR
+#define OPENAT2_REGULAR 040000000
+#endif
+
+#ifndef EFTYPE
+#define EFTYPE 134
+#endif
+
+void test_openat2_regular_flag(void)
+{
+	if (!openat2_supported) {
+		ksft_test_result_skip("Skipping %s as openat2 is not supported\n", __func__);
+		return;
+	}
+
+	struct open_how how = {
+		.flags = OPENAT2_REGULAR | O_RDONLY
+	};
+
+	int fd = sys_openat2(AT_FDCWD, "/dev/null", &how);
+
+	if (fd == -ENOENT) {
+		ksft_test_result_skip("Skipping %s as there is no /dev/null\n", __func__);
+		return;
+	}
+
+	if (fd != -EFTYPE) {
+		ksft_test_result_fail("openat2 should return EFTYPE\n");
+		return;
+	}
+
+	ksft_test_result_pass("%s succeeded\n", __func__);
+}
+
 #define NUM_TESTS (NUM_OPENAT2_STRUCT_VARIATIONS * NUM_OPENAT2_STRUCT_TESTS + \
-		   NUM_OPENAT2_FLAG_TESTS)
+		   NUM_OPENAT2_FLAG_TESTS + 1)
 
 int main(int argc, char **argv)
 {
@@ -330,6 +364,7 @@ int main(int argc, char **argv)
 
 	test_openat2_struct();
 	test_openat2_flags();
+	test_openat2_regular_flag();
 
 	if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)
 		ksft_exit_fail();
-- 
2.53.0


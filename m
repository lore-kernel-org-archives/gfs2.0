Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2302DC765
	for <gfs2@lists.linux.dev>; Sat,  7 Mar 2026 14:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772892507; cv=none; b=swlbEfUBXs+uiETEyUTDzLz+rKMGbAmi7RriOiIEAyM74Bwip3HaNebWoRyGYF6ioZk3hWeRQ0R63ebAIEq0AK/Zp4SlzatjZVmYGK2l1quX81JmQKiW5PXW8LTWz3I7gpMYwnzMzsIhSRs+SdAp4WruvlDrwV4cDKFsdShqn7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772892507; c=relaxed/simple;
	bh=QvKBTacd5z2P43CbYauz1u/x08KHhA7f2Nkz0BaL8og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auNqHAs5jAq8E0Y4gCPGrVi2xW9IxUNn9AHUjeb/FMVzamErd0DomL9DJQr7GIgrYlaFdiF+6h9NaQhX3jr71Nvm97+lLkdjgN1q9ug+m8sMSaZ+oHGEKRAXP08cN10IDLtBJs7eappDXy3iI4TZ5Abd6J2eCSfqDwLTYUbpFHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOZA0C4F; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOZA0C4F"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-829a9c03780so1344051b3a.1
        for <gfs2@lists.linux.dev>; Sat, 07 Mar 2026 06:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772892505; x=1773497305; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Vj99fOR8e2nvanig9cWTi+niKOe1ygt4TyyqPTa8nU=;
        b=AOZA0C4F02yX5PIYxowjwqRfbsjlU4Fhv0OCCLaKbzMWjZG5AJv0RRW73j0++zSpBz
         rn4k31PI2hwZl37YHBeOBx4h59/5t5v+CZlWrdQzemF5zucUezECeo7QzvMdXSbxYV1y
         Dh283kN0wYkZq1BHX7x7hZS8hhPmWuIv9kIR7wcyWRgJ6dwtVSo5q5Y18FntiL5+qGDz
         etmBkCD1Nr2mfO9jqOVH/OWJZ5zGUqerSeSr8gw7J7yOqgA4PIhBNtyfIiTV57vYYs5y
         OCApbHrf8ZgIMC/FVXC0oYYw3CzxhWKQlhMdnM0qD2SiNa7ze4ntLjOWkCIDeWOk8gRA
         xl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772892505; x=1773497305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Vj99fOR8e2nvanig9cWTi+niKOe1ygt4TyyqPTa8nU=;
        b=PbnogoxyWt6dEq4scSBtSV8Uz1q2L3Vm+YfSdRvMVexTcif6HeT25tllnkuHT3EMfy
         nMZuOZ/2GxJsfrtBR4C4zgltdzao7wJFLWPlG7nV7ZjrPg7T5T3+83i3Pt/y37v+x6rf
         UvMDIc7YDaqMEaTTgMrNBQtdfVX6q/XTGAFUxADfJo8sEJPCHxgmjadaSQip3CCsT2e/
         dg3ajLQNMNHHjnJE+DXF8n1PY2Qh2tXsRLJ9f9AMO3FkcsDMOzULj0spj35+fangbDXD
         Y2K5GsSzugEgIKALQjFpAmULaRgE1ChPnkbbQ9je1ZU4dJy6AKYhKKbUUaLTrXc6+0lF
         Uk6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/V3aFBkJD//T7tZM/ZSndwCEm+LbKqKRzrUaOJb7G4qkmo09vaKxJdjE82ASq81RGdA/e@lists.linux.dev
X-Gm-Message-State: AOJu0YyQdh9yxDfaPyxdqUKiuRA4IS9tufnqSWhe9/aqUm1KEaG2kQT0
	XjvFxYvkppGVgvqdF3Ue5H0172Qb4uWrDaLxDh96dWTgFlCFmxyOauYc
X-Gm-Gg: ATEYQzwVxb3NYHYMCjCRi+wZwzPDwLx+KSIycBdKcKxaEV+dKeONl6ZkXQ8XlmwdcaS
	xttvlcBLAOUt31qvOKMLK3kl+L4h0X+PJPeS27ewWH5gTxyu+FPdaCb4hkdoMI1TTluvX1FlyOa
	WP6yd1m8H/DNGY9CSLzThFwnbsz0P7JPKto6TDLZFH6yQA/xkLEsJO8usK/4FltqtS4dNQODosw
	JAG5zUHF2jS5+yoz7q77TQhuY67BOVSlRhlIugw/EPStPUTfDDpkkPyC7V6x5u7QlyWyqVSEx9E
	65WGaReBp6gKW4RmG19HRSYCRi+ksQe0YwUU0eAgyJ2zggXcQmeFEvpEWY3HlU8YDvuDbIyG385
	PunqRBxZ2/yDTSmVLiiH+hPZkdYMAN+/nSZICJuYceW6VWG0WmUdhETj1dHKaKICmSpLIuxJbai
	zuupSNCIZ2eOqBiHMfK2tSyO6t7fj6Cx1kSmmpNUqTDUpQKuUpb8BJq+I=
X-Received: by 2002:a05:6a00:1c87:b0:81e:d7c3:2f3a with SMTP id d2e1a72fcca58-829a2f5a754mr4767475b3a.46.1772892505338;
        Sat, 07 Mar 2026 06:08:25 -0800 (PST)
Received: from toolbx ([103.103.35.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48ddd18sm4747313b3a.56.2026.03.07.06.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 06:08:25 -0800 (PST)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
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
Subject: [PATCH v5 2/4] kselftest/openat2: test for OPENAT2_REGULAR flag
Date: Sat,  7 Mar 2026 20:06:44 +0600
Message-ID: <20260307140726.70219-3-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307140726.70219-1-dorjoychy111@gmail.com>
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
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


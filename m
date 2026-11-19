Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116366;
	b=tDL4vMB8bWhFxW1VA2C7Ru6maAjVt2fGUVC4B4kvpJFQbgyqHYL1/NAVwl8Xis2whYBL
	 0trMnjomXk00IYvf9uHOM3AdIwL4YvhFSqoe7eiSztlfjQi0IMck+y5dq8gQfjOgO4OXa
	 SuFNpfGlNQnFVAUx+G89+0cEN2t7fkImwAquoCquYX4igexbk4WPrPuf0HdC6CFZ6Yuzo
	 Ha3imgo0/BCW8kwQ7H61ZKBAZLHptAfHRHYACPHYm573VeDmuTAxvg4oNXjnvRFZ6lDs2
	 014X2bRNrzm5XHMsWJ2SevIgLs5bPzljsnP51iRvvhRtf9IxYSXL51YFmeJ/9oX3QNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116366;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=CSDEU43/2Gwf+VbjlCClZWJ4rTvHhhRb4YqVFYZr7ik=;
	b=Nwpb3wAB36K2CUbPMU0qkvvOs3+MR9usGrwBHOn9xe+cYAtIEuz/rNFI4aQPI6+XN2ki
	 I9xJdJCa70LABLNVBGeqd79cO8hZuIQiEeKDvuW0ko0vdPpTe/I4SUH8j+8TU0iq4gx2k
	 yGU2Kx1apTsPg7ehNePkD+hbpBVrdlby0EC29nmrb2mFK70yOaDsRA7vle2M9/NEUA9V4
	 dez7gS3/ltWKCV3Fsynk08Pfn5vobc1WU74oV3s9gfUbfrp255VkYFUDVhwzRlxrKutJh
	 8KTXvFatUjDKAe1y2EIGdC18xZJb71nufP2QDpm7XpZeaTqbZBpFASEArlQLBh1FPHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gY86kYgS;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE75360A260B
	for <gfs2@lists.linux.dev>; Thu, 19 Nov 2026 19:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE75360A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gY86kYgS
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2eaf3f829b3so727155ad.3
        for <gfs2@lists.linux.dev>; Thu, 19 Nov 2026 11:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116365; x=1795721165; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CSDEU43/2Gwf+VbjlCClZWJ4rTvHhhRb4YqVFYZr7ik=;
        b=gY86kYgS2PkhFb/9Gs6/XUd8easSHPNYgpphvmK3mh/weZRUrK4LQ8v8v8IJfHfz7k
         mzjBM3yzmST/vyNX7fQZL0deO/r3r8qv/lyh7HZ/EWG1TEuG/GXidYkHaurdjwx1ZF7O
         q24X8wwMC/Cz+/UcOOjaPYSKHWGJ8pRSS/cSLH5i9RSJqJZSgkboRdbvfZ0alcywoIy1
         KIS/IazRrTSq7XBUXQWqa5X2KBp2IPjbXMylIRj8oUKyKvFE8r8S97RtLkpmhEcJ3rOf
         2fR3xzSTsiPy5w4OeCfvhLqH/5iutUoDoYFQ9fSX+w7JNefxA5P1dJbcNFICjwP4ovW3
         KvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116365; x=1795721165;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CSDEU43/2Gwf+VbjlCClZWJ4rTvHhhRb4YqVFYZr7ik=;
        b=ZOw8l+UpSbrABQtNgLrB5cXoK2BWT06ZP7nXYr+7fc7GL555bI/R434DhOJuFu7DgZ
         daeu0sT7EhhiJBD6psQYqYuEwNcPTBoxnGJgIbAmcEyt9r9oDVL5W1B4lOzEsUfDmDwq
         Q3auUTSv3JvuTrBnMZIms9D+iUvRfirqr/T1YKHfEDCm2sOKrE5q3zHcFtOd3Wn3WDkm
         pfGkN5/fXnFDNORNi+iloeTJ71HQAEwjWP5GVxS1fWnWjQlc0aonDk/uE8rq3qthWgdY
         Jq2F8Lb51rzpFIskHzjJJrZ1suPjxVsGa6Kdx1C9+TIB8ibxFQA+/up7W1ML6UomosPP
         IG0Q==
X-Forwarded-Encrypted: i=1; AL+hErFZIYJSdv0bJBe+/wtxQ3Xmr9RfmjbI+SfdpTJFKjVd/vaKLksHRBwWT8sdluAVVKK+RYEx@lists.linux.dev
X-Gm-Message-State: APuU4Z9waRVyOd1FhZk+7rcma8qSvVR+7fUUJ2vJzdJ7X5rz4gVv6z7v
	drdFlOuZAx19Nd++EFUGvwHNkyHt7BCOu/HJpllIclgfrfbisydcuX1HfQ70PZK6QMOmI7H/dgH
	ILgmXmYZTXA==
X-Received: from pjbsk16.prod.google.com ([2002:a17:90b:2dd0:b0:3b3:ada0:c008])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c03:b0:3b4:1bf1:988f
 with SMTP id 98e67ed59e1d1-3b41cb138f0mr288962a91.54.1795116364835; Thu, 19
 Nov 2026 11:26:04 -0800 (PST)
Date: Thu, 19 Nov 2026 11:25:18 -0800
In-Reply-To: <20261119192520.1983406-1-irogers@google.com>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261119192520.1983406-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261119192520.1983406-8-irogers@google.com>
Subject: [PATCH v4 7/9] ubifs: sysfs: Use kset_create_and_add() for ubifs_kset
From: Ian Rogers <irogers@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Srish Srinivasan <ssrish@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Alexander Aring <aahringo@redhat.com>, 
	Felix Kuehling <felix.kuehling@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

ubifs_kset was a static struct kset using a custom ubifs_ktype that
had no default_groups and no .release callback. With
CONFIG_DEBUG_KOBJECT_RELEASE=y, unloading the ubifs module while delayed
kobject release is pending causes a use-after-free on the static kset.

Replace the static ubifs_kset and empty ubifs_ktype with a dynamically
allocated kset via kset_create_and_add().

Fixes: 2e3cbf425804 ("ubifs: Export filesystem error counters")
Tested-by: Zhihao Cheng <chengzhihao1@huawei.com>
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 fs/ubifs/sysfs.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/fs/ubifs/sysfs.c b/fs/ubifs/sysfs.c
index dbf967dcf26e..e20931e3a62f 100644
--- a/fs/ubifs/sysfs.c
+++ b/fs/ubifs/sysfs.c
@@ -80,13 +80,7 @@ static const struct kobj_type ubifs_sb_ktype = {
 	.release	= ubifs_sb_release,
 };
 
-static const struct kobj_type ubifs_ktype = {
-	.sysfs_ops	= &ubifs_attr_ops,
-};
-
-static struct kset ubifs_kset = {
-	.kobj	= {.ktype = &ubifs_ktype},
-};
+static struct kset *ubifs_kset;
 
 int ubifs_sysfs_register(struct ubifs_info *c)
 {
@@ -107,7 +101,7 @@ int ubifs_sysfs_register(struct ubifs_info *c)
 		goto out_free;
 	}
 
-	c->kobj.kset = &ubifs_kset;
+	c->kobj.kset = ubifs_kset;
 	init_completion(&c->kobj_unregister);
 
 	ret = kobject_init_and_add(&c->kobj, &ubifs_sb_ktype, NULL,
@@ -139,18 +133,14 @@ void ubifs_sysfs_unregister(struct ubifs_info *c)
 
 int __init ubifs_sysfs_init(void)
 {
-	int ret;
+	ubifs_kset = kset_create_and_add("ubifs", NULL, fs_kobj);
+	if (!ubifs_kset)
+		return -ENOMEM;
 
-	kobject_set_name(&ubifs_kset.kobj, "ubifs");
-	ubifs_kset.kobj.parent = fs_kobj;
-	ret = kset_register(&ubifs_kset);
-	if (ret)
-		kset_put(&ubifs_kset);
-
-	return ret;
+	return 0;
 }
 
 void ubifs_sysfs_exit(void)
 {
-	kset_unregister(&ubifs_kset);
+	kset_unregister(ubifs_kset);
 }
-- 
2.56.1.708.g77570a6a1d-goog


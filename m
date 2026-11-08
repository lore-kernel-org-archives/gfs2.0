Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177596;
	b=tlq0dgZ3Rm0OllRxvtnGgH7Uc+2q5b0v+/vMubdv959UMF6IMWloa5f4lMxfHoZxhz4b
	 yhYOKjVx8A+PY0d6So5iuXRbaLWpYeOAang5P3JytlIX8/9mJum8s/+PsopaSt0lTL71+
	 8jou+abFk29Qnox0FIhhrVuTNnkUCQxiy4Hau+fnI0+7tmOuks2y1k8g+zECoCuKnAYma
	 Rhj+3d0QxwmiqXkVMC7mhwBEtGCn/3Ky8ULnQvAkISguYaXqOAsvxS+Y7rltG0OmmmjMS
	 NULxotTAM36MQJOdTf6N7ZqyIGsjxK+BBLXqRAfvjLhuy4SUt7vxKR9y2tRbDKF5iiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177596;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Vy7610mZpT38CbXCq7RNEhhWWcPldBtQplNazUNUwLE=;
	b=R6UiI8CX7Puze/fikYj4R+LcYuFYycM7jhnCcQelJOexhQBmAW+AQ56Y+q0J4yEYGkKf
	 svPNyWf+k6CJffkgDguuv2tSpOW/myKYsEm3AXUhVYRB4aYj2140asxdSM9R3LUaNAoM3
	 a0kQsq59yyFOSxbAuQkOmPKhD4fKjG7QCKrPXiXpR0pI7XdYRmuKbsCGGO3jfEAL0sgiI
	 GIZF8XNBy31dw7MCjmjVimM45fqMzVBnrM5GG8HtR3TjHaxtZbRQb1GSMsFgohed5mkqt
	 bv3BFBV24ru8Sk6oyWkZFAPmystcEeNAkHfpUKnmT2IIYdiofT8ahlCjBm0BbL9MR6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WcUoK9yY;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38DF606A33C
	for <gfs2@lists.linux.dev>; Sun,  8 Nov 2026 22:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B38DF606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WcUoK9yY
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36ecd5db581so237313eec.0
        for <gfs2@lists.linux.dev>; Sun, 08 Nov 2026 14:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794177595; x=1794782395; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vy7610mZpT38CbXCq7RNEhhWWcPldBtQplNazUNUwLE=;
        b=WcUoK9yYKh+DDiSpxOb7MYsgQe/XcbUoawTIQfsAHz4OApFQdLOSkvBZ2M+nPrSLP8
         MyvEBrPCjeyD3wt0Rjw1R5jUtGwevIFLIIHehk94nzVj4TgECcga4X4DKYuIpNUzl+wx
         iNOL6G8fs29K2M8rywDO4AZahUl6ft3si9Dp64qpYOt7xOfKJbionm3lwLkkMHXOsJse
         ypQLDaY+bgvulwXsGvp7/UTmE+vn2UdBOSgArlvJnEcyJo0ytB86Y5gIr1easn/vqIZs
         xmmEmFU9gw4V4SpvdZvpkhRXcZCNdNJ1QmUURkRwydtykeOfcoU+rt3i7iZbUfkngY77
         yu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177595; x=1794782395;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vy7610mZpT38CbXCq7RNEhhWWcPldBtQplNazUNUwLE=;
        b=l2eCXi2lZM/lg0mJYWj4G3WG/+yHcP5iZKFyHxpakxPWPsBOJ5MCm5SYB5jL98wsBm
         fhC61aszqNR/CNwznyDc2NwLQ6hI5e3sg+mazQzBKUzL6bK0MqRYq2cm9LdWDB7hMpW+
         J8XJN3p0a75SnqcnI5oMDGhu95VBoQXmxC/7ZS7wVJeQx1c+EZvDTYMeZoYpO/X6ZIhf
         6/B4bO/rwn6Zw+jRd9eVzTmhDh+VR1sbPfRHlJVxOmhugeEnSkTRfvok6/vbEG4CwFc2
         PtYm+b7JRE+msgELiEar86fs4nB+yq9CnTrI84N7RXqNENFU9F03LHH1hRc7OambbvnD
         uUjA==
X-Forwarded-Encrypted: i=1; AL+hErEm/R32XAyiqojRC+e63Gi4g+mZkC1NyDXuBy3D5pp3CyFGSo0FxSf9WfyPlff2II9oTpEG@lists.linux.dev
X-Gm-Message-State: APuU4Z9DAH5IPwHA04JKTwY8hx1gEI0OjMi3ceGVoa6Hi0o8MqWkD0e6
	he4G78OkLNDxobeJjfhxUxfjU/bja8zHr9QPYN9lQ7rHMVdkcyGgj95MnbwFh5vugDeJEaZXKew
	8c/t813QdQw==
X-Received: from dyblf39.prod.google.com ([2002:a05:7301:a27:b0:373:6c70:7c9c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d584:b0:36c:9f1a:30b8
 with SMTP id 5a478bee46e88-3725661520amr5331882eec.31.1794177594363; Sun, 08
 Nov 2026 14:39:54 -0800 (PST)
Date: Sun,  8 Nov 2026 14:39:11 -0800
In-Reply-To: <20261108223913.3624571-1-irogers@google.com>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261108223913.3624571-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261108223913.3624571-8-irogers@google.com>
Subject: [PATCH v3 7/9] ubifs: sysfs: Use kset_create_and_add() for ubifs_kset
From: Ian Rogers <irogers@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
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

Fixes: 203a55f04f66 ("ubifs: Fix memory leak in ubifs_sysfs_init()")
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
2.56.0.455.g6c5a503b38-goog


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140771;
	b=zlE9Sl3k/yf9w0VA5RSz4VgaKFwydxRkLcIATQIfPVxkuJREJb9YyZ8vQ5cRFkfTAM2K
	 2383xUKdhw7PXyA9p/ytl1My+9GGnHIgtWiaaXG9Z9nXuifPWorZ7ctA/CdwkbbtM40dg
	 v/tnssTGa2toLo0pk7c1AvC0gOdtnsrq2GT2bLTV7aTeldCdIlbZl8kbbZdud+uQqyCIj
	 xJg6DcI/4h8hc9nhkIBWhg7cbgvUHyJJsxQ/fJLvlHT+8Kfa7HA5aRM9q19Rb25Tue3bu
	 x//CEAIEuGStxvAaQU7+4zj9S1Zwi7ieeYQ/n7WnfdAX4sAaaVT9f8Tir10C/vyUtNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=aItLXVgOXAbsJZn2OZIWl+3TQwb1N1Woum6UsPYCRPI=;
	b=JHrHSc3Ypspevbt3msBey62aR87fd8B0QQlaku46Tivg+n8z8nJge9nZsUkYQ4zwk1JR
	 BZf/MUJwa7uex7tarXbeLYWs8STOQwO15ExbVFjs+OB9GodAna5jZD1+UM2u55OYblmx8
	 W8JQDBKHUQ8xVoGK52Lvss7/3v2laQdQYuk3kBbEI7Wp09aG4sYXrfIKKkpO1YGcfmrfE
	 gs4nUhIgPbcrxWzBqH7BvinicMFp7BTugs+knNo3AzWCwaPuwZceB9LTTaxabneClfxO8
	 +7ZyX0LPSm/SIGHUA/YX9Hn+qcHTBHkjanwMpqZToSEI7+E+5o6zgnQuNAJRwnzlFyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HKssj83b;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6A060A5BCC
	for <gfs2@lists.linux.dev>; Tue, 27 Oct 2026 22:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC6A060A5BCC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HKssj83b
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1a71dd190b0so299089c88.1
        for <gfs2@lists.linux.dev>; Tue, 27 Oct 2026 15:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793140770; x=1793745570; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aItLXVgOXAbsJZn2OZIWl+3TQwb1N1Woum6UsPYCRPI=;
        b=HKssj83bKsGqonD+JCmyfI28Vt2PijKRfIyCUNVd1m4pmjBhLj2+jg3roP+RYIKlYq
         jjjX8wsUPR1nG7Sw428VdQepE5oVcygjjf3GbPmxJND2Dr5DIuRbKTdNYbxOtRnIyjBL
         adBIiNfWb7uV8aY0mUlaRGNHcYjcZuU3LgyfEoY5nfOGqJ5qQTQKY4jg6vAaAIzg8Pge
         UGDuduHZx6eU8Tp3ovZXG89IhyyzWFrM4WHnYzjiYph5jPmzuVLHvKc3X/bEdWePVO/J
         A0AHRhqDLisvyD8R8+60NBFhRohuTzxH2cyjzwvs610jSCbrkeA7YXyPKoU8ImQY2ax/
         55Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140770; x=1793745570;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aItLXVgOXAbsJZn2OZIWl+3TQwb1N1Woum6UsPYCRPI=;
        b=nEbAaWuIdg4QSceq3CyCTsdbCvtI+GwoVhFoR4fuckUG5LlLwpK6xb9cAiu9cY71q6
         /NFiwmoMVqtVCExwNdc9k6irfJXpNzT9L+vTaOPpFT9fgd2UiCPR1BncQWM4uIPSKJkY
         YO1IHHdIuqv7/FNwqrXIWiuHUHAKF/vQhCeJG+BYj+ZkxopxyKivIF4RwuWX5AwTpdhv
         RU+i6wzpepja3KZxslAppdZkmHXjtVmIMbgths32WT3hGpx3BR5i1OdfjNxKNRiftRn7
         gk6tGmacr1jhTPhwtDIXRM0RDFWAn+bd4nOdYsbxGpA0iq7dPbysyxNBa0QBT4QEjRt9
         dp4g==
X-Forwarded-Encrypted: i=1; AKwUvBxnubsDQ8ZB+0SgBx5pc8/Yy4oT4SiH7fcm8MBcoalPr+KF1rU6fiyGAcoG5VEHLR5bhsdv@lists.linux.dev
X-Gm-Message-State: AFq9FYJ1b3T086SHFMCh79TSqKyTTyNdduaAs6GPcukEBoFxaNJuideg
	tq6KciF8BVlHZoqqqymk7KpeP+lhyd7K0EVVWWvgLAPFPA79yGhwmey4MEwjpPPY5C1OWkpmfKe
	um2hFh8SAZg==
X-Received: from dld12.prod.google.com ([2002:a05:7022:30c:b0:191:45cb:f8d3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:607:b0:166:af48:a2ba
 with SMTP id a92af1059eb24-1a6c2c71125mr1317138c88.0.1793140769446; Tue, 27
 Oct 2026 15:39:29 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:38:42 -0700
In-Reply-To: <20261027223847.652884-1-irogers@google.com>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261027223847.652884-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261027223847.652884-8-irogers@google.com>
Subject: [PATCH v2 7/9] ubifs: sysfs: Use kset_create_and_add() for ubifs_kset
From: Ian Rogers <irogers@google.com>
To: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>, 
	Richard Weinberger <richard@nod.at>, Liu Shixin <liushixin2@huawei.com>
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
2.56.0.313.g2479322e68-goog


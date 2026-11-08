Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177585;
	b=IX3DMRKtuGW5SIxvz8JsVrs6AkYt+bzBC6LiOsR0tjbtYlc9WVNhyxTSqgZO+BPDJEhg
	 VW1CUPaTaGC/8VeZP6VJ+wuFkeAkj+BuYpdRcEQ4LvOOXMLwUeGq5fgBT4DpZf7AzMOZy
	 Y6wffSOkjTK5YuFR5onWq1oYRcbTepfhU3syDxrLGEEcMJTasfUjJRxiYLb3sRUSLxNzi
	 qHlAYkk0YbWNekhq9+vsNjUyGCTudy1GQDAIGe7sYC3DgZz75hsQDaYKOTjjQNtpnhQZM
	 oENHvWFNGWdM4J+TErk5VC5HVHLNgOI6KNRma3n1OBIEmGAhtTwE2+q4nMzmHXZM9FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177585;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=4kX4Ed3A+P912IudIYmkHnIS6SHmJhWXUKLWP4ZNJ5k=;
	b=U8f3l2wAK2XR2zfsi2LbOKEuXrU4Q/K1DswtMS2+OOFJl0lpm07HZyJCG43z+EgIHsxR
	 oc+mfFMub7rqI0P/1ARJFQAy7xggFqMGSrY60dYH5iZm5IFJoIIrXOpQiWLJa7iL8r4wg
	 u5n3FcpbN72yHXOMwnQeJxVqMhkM3PEk2WimFe1ouTgEkO46AieYntKF2qlvwbHNt2UO0
	 iVuasvlR9rvgVwavdnjbY7JmGF3k7s/x18kt1UFjJm4xGcQB0ScPuB2nKoe7kzVcIdFSj
	 Vwm2wi5yRYydrNEJzSLZdHz4g7VNq7vCM0BkiswCjkjqG9dGCfx5bx05x63T0v77g7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CPoDPQa0;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A399606A331
	for <gfs2@lists.linux.dev>; Sun,  8 Nov 2026 22:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A399606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CPoDPQa0
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-154e9d2d94fso923191c88.0
        for <gfs2@lists.linux.dev>; Sun, 08 Nov 2026 14:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794177584; x=1794782384; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4kX4Ed3A+P912IudIYmkHnIS6SHmJhWXUKLWP4ZNJ5k=;
        b=CPoDPQa0wuL0eNdjELBwZmbVyllrfVfdzCUczJ6XOQ8uadHBJD6VU+YftI9ItrO9ht
         kqpa6U6YBxaE9kcuzfBPhEhE6XOz8TcpTPIlmOdQebkHcRSq6W1BTv3CEwcLC5YJxv4T
         m3drqCoChPFfeRe6RlyjnUJl/HTaGVYGVlyBe8DOMb9DoVSIYb4pZLFLZ3ykAc6yc5rq
         +rBO0BhWM9S24I1dUT7CCGgMuY79+vKQ7oOYFqOJbqh7P7vlAJTHTl/JsNOZ0BWiG1J1
         LOt0szfYRdSZa6Fu5P5vaMZfNtXCUR9ILTDPTr0GgTxdauJqXQ4TBaNfeeH7Fsc0b5vt
         9Z6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177584; x=1794782384;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4kX4Ed3A+P912IudIYmkHnIS6SHmJhWXUKLWP4ZNJ5k=;
        b=IF7E37j+yvzEP6wpCdZOTKb6G6MOIMrYBnSEq4credtreaWQvPVkfLvuo7nUMnp1sC
         O1N4z/6gseLYIiVfq3Eml2a0YyI7hkvvrun+Kyc92iH6S1ZRyOuZsmmluf5jUAe01Cgj
         NCUz2hY6ON3qp22ppZ2RchKj6+60l9xc1bDagZjvBPV4uk4kBh7WaVQWdipVdMTntF0r
         i+IPI19xL1WR4jGA2h1r/97NWcQ6ypOo1du7Ro2GODtg8/qCZx7QrCzA13bM4WTlGBUE
         S+x7XBuZm58DnXSczBG+K5z0O8oOPlk4StVT5am1BCocSkVpwdJb6IIgrbyh1fnNJjgM
         V3Sg==
X-Forwarded-Encrypted: i=1; AL+hErFXl8IJBnZuJbJzdi6SEWHUkEIGttuOIZKxkHSCOVH66tATWwKkVAKO9CFrsP1gnsIiU8oC@lists.linux.dev
X-Gm-Message-State: APuU4Z97Ob3eGGjGXG1I722KSdmA+IWJzg9pnnweimx6x6+9qqdKiYIw
	UNYMvr7wLD5zwfbYHNbbig9p+QbClxIj9JTY6bSItoM2Mafzr40Z5WpjL3w74RJ1utuBJd85SJI
	xwDZ+mwsUrA==
X-Received: from dlad1.prod.google.com ([2002:a05:701b:2201:b0:1b2:6421:f4fb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ea8a:b0:163:bee9:b250
 with SMTP id a92af1059eb24-1b39fedbec2mr3348910c88.22.1794177583902; Sun, 08
 Nov 2026 14:39:43 -0800 (PST)
Date: Sun,  8 Nov 2026 14:39:06 -0800
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
Message-ID: <20261108223913.3624571-3-irogers@google.com>
Subject: [PATCH v3 2/9] powerpc/secvar: Add missing kobject release callback
 to secvar_ktype
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

In add_var(), a struct kobject is dynamically allocated with
kzalloc_obj() and initialized with secvar_ktype. If kobject_add() or
sysfs_create_file() fails, kobject_put(kobj) is called to clean up.
However, secvar_ktype does not define a .release callback, which results
in a memory leak of kobj (and a pr_debug warning in kobject_cleanup()
when CONFIG_DEBUG_KOBJECT_RELEASE is enabled).

Provide a secvar_release() callback that calls kfree(kobj).

Fixes: bd5d9c743d38 ("powerpc: expose secure variables to userspace via sysfs")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/powerpc/kernel/secvar-sysfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
index 395399bbab2c..f3f6ac25ea78 100644
--- a/arch/powerpc/kernel/secvar-sysfs.c
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -126,7 +126,13 @@ static const struct attribute_group secvar_attr_group = {
 };
 __ATTRIBUTE_GROUPS(secvar_attr);
 
+static void secvar_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static const struct kobj_type secvar_ktype = {
+	.release	= secvar_release,
 	.sysfs_ops	= &kobj_sysfs_ops,
 	.default_groups = secvar_attr_groups,
 };
-- 
2.56.0.455.g6c5a503b38-goog


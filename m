Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116359;
	b=LuQgc/f0Y+0CnYRzknxLRPgw0wTV2MCvS63pLW7JFjEGrhVHNeYWv/oGGJ/hcjwFfgKK
	 I7YYlbUqO7FHjyjFTAbv0Vp1yvWpZuJSKGLX43ff/sPnHSZSXlFCJPPkBBJxgock1OZCv
	 EV0SdY1EG+i5jrOJntZvjbLTn+1Tvkh/I7IIW846vnszszLLZS+5L/2g3iIwX032C9daw
	 32FjCiciLfRY46QcbWHNmAsvDyg7JOooUJczwDzbFiaDCCmZqALcNX2rGTx08NfqzfxWN
	 jIvXu7Wcth+3oVs1aO0Tl9fOSbdvsGhid3TgldRUu97V+hOVHZPgt8A3OepmzH22w5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=MCKguj/vcFyjyUsBFpEVwvA/Ew8DwdobaKTpU+d8I2Y=;
	b=X1lVjmIkFXkYU5HU58G6M9RIQgPrjFWwY+d8yPSSK0gE2U3Ng04Y3350weUkOKLViqW/
	 iGa4V+QlA+pBfFvblZuZaszSvCf+rhz7mgGlR7Hif2f0c75XVIm6DL6raQaW5T5QLLdPp
	 tfQNEoHhzIE3cAQSACvVHE6IRr3d2+kUT5isDoMh5YtXdcm130Icm95PtW6vGHlDurZeC
	 QnXnkcPpvnuvaaB31dtkaAS1QErVNOxRxeYCqXCf30fD6t4lFPAFyvnPglDK/tId5bIeE
	 Ta17YwOU9NYSrkTfiCJ8CNSLcht3dWLArrRHZKYEr/A7qRBmnoPV8NQaiNzT7c5MKdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NliGLqR3;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEBB60A261F
	for <gfs2@lists.linux.dev>; Thu, 19 Nov 2026 19:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AEBB60A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NliGLqR3
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a0522cdaf3so128908b3a.0
        for <gfs2@lists.linux.dev>; Thu, 19 Nov 2026 11:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116359; x=1795721159; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MCKguj/vcFyjyUsBFpEVwvA/Ew8DwdobaKTpU+d8I2Y=;
        b=NliGLqR3pByLlVP6O2fHa7Esdt5sLj4kLONzeh7NpjW4XDN8iHaY7YyiHv/iiXhcl8
         1vmjzf28LEu7sOrVmVdhAAMOdxmHIrJAniEbaK2Ge4RzC4zsmEQFP78txij4gXkjPAQC
         TzJDgSxtnYJExMaAUoxKDFnheMSLrnAktKlfwa/hook4Yvj4jy9815ZGB0hFOVlTMDk0
         pzGV32R3Udp884DOwyGinuqizr8FipPEg54oOFGKiD4UFFRw7sESp3fygaF1AsL1dihA
         mAN6DojcvDfaQlI6LwWYMwIFyHUuLaDuCecJYivnNtZtFmuBxs1Qi82HyhU8KCcnpF/p
         soTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116359; x=1795721159;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MCKguj/vcFyjyUsBFpEVwvA/Ew8DwdobaKTpU+d8I2Y=;
        b=oH4mwCaFy7g9zc0duGrO5z5M460d/x/zVXMHWeVwYbcxduYLp7DYNTrf/D9js2+GNr
         nBmBbEO06bNtCWHKHlVwFXsQ7o2IeXCE0z9ONRd+J7JX2PXR8k9htySfdsPb1xfWD2K2
         1PNA6Q3ODayygwfiZypu0DYjjjxgQiaEwl7feZflhn3N9oY1GgklPFxf2Ad73KPcIw+E
         IEldcacWo4s6FBA3dt5fSKvquA0W3WTkaeSr0duAu2Q75PBIs9OyJw7AgYKQAGp2Xf8B
         r7Pjba+IPez2wGRYcWlb0+VVS/7lEjydYCZA5hOLEOxLfrWnIZBELcFMk+Qhq6iV3Mws
         YkaQ==
X-Forwarded-Encrypted: i=1; AL+hErFL6nIS4fA6vjXlJEd6NTYXY2aBDe8WJQN2+tSGGyWtY9NdfrOFI1Gb+pTFprtNJpUY5FG+@lists.linux.dev
X-Gm-Message-State: APuU4Z802UjyHLZrVy968ytXpsUPJxUinTl35wkg/5K1j4mcNCxKI5vi
	rdZXOcBTPLajH/tUBVjYykjkI1XfodboFRBGnJI6fr9+iAEmbc48Y94pej7SZVrcX52Uthw+JA+
	ReeJXzbO+Ng==
X-Received: from pgjk11-n2.prod.google.com ([2002:a05:6a02:81cb:20b0:cd6:1fc4:6199])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9191:b0:3fb:1bfb:ff29
 with SMTP id adf61e73a8af0-4014e74d624mr589862637.69.1795116358583; Thu, 19
 Nov 2026 11:25:58 -0800 (PST)
Date: Thu, 19 Nov 2026 11:25:17 -0800
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
Message-ID: <20261119192520.1983406-7-irogers@google.com>
Subject: [PATCH v4 6/9] xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type
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

hypervisor_init() in drivers/base/hypervisor.c creates hypervisor_kobj
with kobject_create_and_add() (which allocates a dynamic kobject using
dynamic_kobj_ktype), and hypervisor_subsys_init() in
drivers/xen/sys-hypervisor.c then overwrites hypervisor_kobj->ktype with
&hyp_sysfs_kobj_type, which had no .release callback.

Add hyp_sysfs_release() calling kfree(kobj) to preserve the dynamic
kobject release behavior.

Fixes: cff7e81b3dd7 ("xen: add /sys/hypervisor support")
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/xen/sys-hypervisor.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.c
index 91923242a5ae..0e8a2cd69fd6 100644
--- a/drivers/xen/sys-hypervisor.c
+++ b/drivers/xen/sys-hypervisor.c
@@ -659,7 +659,13 @@ static const struct sysfs_ops hyp_sysfs_ops = {
 	.store = hyp_sysfs_store,
 };
 
+static void hyp_sysfs_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static const struct kobj_type hyp_sysfs_kobj_type = {
+	.release = hyp_sysfs_release,
 	.sysfs_ops = &hyp_sysfs_ops,
 };
 
-- 
2.56.1.708.g77570a6a1d-goog


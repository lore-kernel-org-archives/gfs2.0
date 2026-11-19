Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116342;
	b=uduwP/FSu2ddMk2NojUKK4IZI9ki3SLmfx5Fw3dNdME17d10x1ejbg/vFle36mQRfIZe
	 7BxJPpjEAh5x4c0P4hfzj+2kGSBjT9HEedAbwrLfU3xrKhhHDLCuIvMmn2/aNDKlE1AI9
	 xEF5/M5Xhdx2NG4Wda5Ki5zmftcfDJhAc5gxyE5tVp2mEuz60KEOHl20wC1z/vSWgJwDw
	 hBjx2C0ZihLd8x/TMj0/IMTK5sCxBFmKYW5tflQrL7EzO5F6sYaIof4DQrsXBKSN+obdl
	 6xiOVO3CAwV6Nh13LdndNmwqUq5JVxM3t041OUJBPihrbIZj4P4/wnuknCpydPt37rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ALLBk8MdTkFwcPZqYQO+ZVSicu8jJEanZFGqZFoBPVY=;
	b=OSqIJyFIZxx7KjspflObwHQxqvQHXibBDXS0+ge6wTQ0+BZj4BvobxS8+JrNEu3QJi1M
	 JyNay4hZFNAJRRfBw9YufFOkbCtz45pVJ9kjFAaYLaUucgp/Rdtwf1sNrsViH8X1bnFyk
	 T3HPQR0FZ1VnvDCYVXZdWAg+2/sXzzaRwIn1QUmBkAPkMO6Fu/MWCRu1o5BPUMI+fJdHF
	 n+4P2CxBg4Yq4FXHJGCuIEmIp/tydYDuPnsLncoA0KoInK5/CbYcTWma7CGcmi3dwMmwm
	 i94trrziOhcYJ6dj/EGHpXgb2B7uiCypRPCuIgCLk4cpQs8bediAbQkK8lD/ePtTK6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mpXAv5bq;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0326160A2626
	for <gfs2@lists.linux.dev>; Thu, 19 Nov 2026 19:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0326160A2626
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mpXAv5bq
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2f0381f07a0so434595ad.1
        for <gfs2@lists.linux.dev>; Thu, 19 Nov 2026 11:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116341; x=1795721141; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ALLBk8MdTkFwcPZqYQO+ZVSicu8jJEanZFGqZFoBPVY=;
        b=mpXAv5bqYApX6ypwPk8eAHqRcGIsXHopmncKcik6Xj7H/NDLc1vp67RC4lIPu5sfnZ
         SHyikXWPtgDu0IY/I9UVMyIzu6AqELYB6LcGGFNdllfx04519afVqG8cAYjIq8calyqN
         hndI+15X5H7CdtEyurdVV4FA3QuTx8LxRmi0bsKMO+n6FIYg3M9DJVm3Sz3F2Hj9BxrJ
         gZqAbXmdpM+CUqYqof4rVHhDBv1myGNNVsvy3b+Xxs5Np+0zEKeEKVnYA2k58boGsvEY
         0Ih7Z8tUHQQjb2Z4sfAmuXl+wjO/ZDjG7YD+lSScTMDJvrCmFS/1815tpkPZDc54DC8A
         kJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116341; x=1795721141;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ALLBk8MdTkFwcPZqYQO+ZVSicu8jJEanZFGqZFoBPVY=;
        b=peSo/w9TxH6YwBnzeEylWtFyDmF0yOnNznrMgUH03MBLua1PbVHjo2n7QbDASoF9Nl
         gITVgcThWgWRzwpUwr4QQX74plpN09LD8zPFrasfvGSFgEBQlQ2h7pgSiMDLZ7MOPfc1
         YioeXrT7KERtPNPW7At8UAmUysIDCi7Fqd94LmKkc2zaAN6Zkpkd6eURLPrVncpttFdI
         cPumrgvKbxga1jCQQxKuKlLQgszkiGcFfMZCsdnsr47lgcyJ+Yjc4V3m5gKmSTbWD9N0
         p6cgQZ6596+LKfFEvC9MioPLs4WV28L+FkmiGFVR/EqITqmFP8cvPOy7N0DlUEpZYRpI
         NtiQ==
X-Forwarded-Encrypted: i=1; AL+hErFhCI5so6AYwDUWecBg5kbu1I6H+LIY+KPDqho9q3AFNLd2tRAFPhQDjM0cqX8EP1dqSXbR@lists.linux.dev
X-Gm-Message-State: APuU4Z9tbYkCbigiPq+B5BEOMuM4wU+llVnI8o55HC/kRopxd3aIiQON
	Brh4prJLsOCR1Gkf/udIJd2CWU8+4Syp6Z9BkcZzMq7SxnzRuCZu93TMI/2xwoJzehB6FwnUC2H
	/mpSLEm4GTA==
X-Received: from pleu15.prod.google.com ([2002:a17:903:41cf:b0:2ef:d860:1c85])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fda5:b0:2ed:fb0:bfd6
 with SMTP id d9443c01a7336-2f031e08699mr15736045ad.11.1795116341051; Thu, 19
 Nov 2026 11:25:41 -0800 (PST)
Date: Thu, 19 Nov 2026 11:25:14 -0800
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
Message-ID: <20261119192520.1983406-4-irogers@google.com>
Subject: [PATCH v4 3/9] sh: sq: Add missing kobject release callback to ktype_percpu_entry
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

In sq_dev_add(), sq_kobject[cpu] is dynamically allocated with
kzalloc_obj() and initialized with ktype_percpu_entry. When
sq_dev_remove() calls kobject_put(kobj), the kobject is never freed
because ktype_percpu_entry lacks a .release callback.

Provide a sq_kobj_release() callback that calls kfree(kobj).

Fixes: d7c30c682a27 ("sh: Store Queue API rework.")
Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/sh/kernel/cpu/sh4/sq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/sh/kernel/cpu/sh4/sq.c b/arch/sh/kernel/cpu/sh4/sq.c
index 908a8e09113b..f33864958487 100644
--- a/arch/sh/kernel/cpu/sh4/sq.c
+++ b/arch/sh/kernel/cpu/sh4/sq.c
@@ -331,7 +331,13 @@ static const struct sysfs_ops sq_sysfs_ops = {
 	.store	= sq_sysfs_store,
 };
 
+static void sq_kobj_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static struct kobj_type ktype_percpu_entry = {
+	.release	= sq_kobj_release,
 	.sysfs_ops	= &sq_sysfs_ops,
 	.default_groups	= sq_sysfs_groups,
 };
-- 
2.56.1.708.g77570a6a1d-goog


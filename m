Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140767;
	b=G5XvG+yr6YkR9ijqhns4UbrhnfiiH/TkGCGxepcDwgO9Al55pr635YtbACI/vBfT5QeB
	 z08ZmgEf1Qt4c/8MKZOBmClnLDK0vMiUAkzM8yeTCjJEGq97unT61O7ZezDI+gy4HCeaQ
	 3oqblTwpnSKskdP2ahBf7b+Dt8XmoGObg+6TRVAAVB5IKhDePDP60NhNsphn0SJyrUJr4
	 xbDuN1SPCyMVOgGfYubFXjqW5I0Sp7VwMuHFMg71CRQThFletkG+HKeMYWOEG+Bsk9+HI
	 LSaCYWV4qlIwYt78fdwHLjJRKZxigKFklt6RMDzkLzVOumhZvhWudVIXSjFI81vP2Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140767;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=4zou/7CSV4h/YwAlF7A1OL9kEnFb2HIoLHCAQS8LrD8=;
	b=fVF6QPPjL0YdZL0Jo2wjpPnCoi4K5aPyRBuF7ldk39fsEDpvkmEnAUUUwFqRrF/QDEoD
	 ratj9JcTxtABCz2pgJms9GeEp2HeON5RQkXgUJLpkWQY20K/RAGEQyyeyfgW2s+SeGPBy
	 RTIC+tjr9XWXUoDkw3JiC+Rp3qdrsItVJkClOGRpQJeJTQU4em0UFRbIMqFrYdq5vHEzZ
	 8s0SaQ9awJAo0KCwPC2o+MtL/qwgkzYg1t3WyELBsSmi6AghcOkh2cTmxgb1c82MJWsBn
	 /nHsnY0V0DNeAMqSMmNWnqO7eo2bjWmDXKIlfhB9Okcit4jVHVKN4dy/Z3Raam1Fzrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FUdgB38B;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D36060A261B
	for <gfs2@lists.linux.dev>; Tue, 27 Oct 2026 22:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D36060A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FUdgB38B
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-139b62317d0so1025591c88.0
        for <gfs2@lists.linux.dev>; Tue, 27 Oct 2026 15:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793140767; x=1793745567; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4zou/7CSV4h/YwAlF7A1OL9kEnFb2HIoLHCAQS8LrD8=;
        b=FUdgB38BIOt8V1W765ijEyVAUzNN5JjGfNtnPR1irAvs/uWy/qSKDXK3KNJGLzGYXb
         lStqDta+kKWc6U4dKmtLUjzTVUXaKcQa7K35q9/uKs/JpEgVmSVMLMkr4T/IVlySki+B
         U3TSkv7xyiwWQQwgqNbsKwyCf+0qC63YIQhjW2D9dolgLxVSrdGgyZJDDT8RVH65pm9S
         D1p02DGkSflsNKzlA1ecIKVGRHqA/mFyiaCKalt2A+O2lqP3XU6m64GszgIwrR7D4Wux
         Syq32UNahYJJZ8fgC5/FmT2sOS77AI0Rqq2Fi3eAK8/4o0Z3N13ymPFjwaugIh+NWtdH
         qMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140767; x=1793745567;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4zou/7CSV4h/YwAlF7A1OL9kEnFb2HIoLHCAQS8LrD8=;
        b=DoD6sCF3azfYarZLu2klWRfn6U3CYEASa876Z9iExw95R9vS6uToGb2Rlsyb93XPXY
         BZs00+jMOv8hXGIHmrct+q1XZGBf9vw+YSBO1e1yAR9HTvJYls+qJJIO2Fz+qBjxw6i8
         AI+ac0jsb8BD4jJtcpl/CAFovTdN2AecGBH5bt4XPP7qQFT/VoYtYDPd/0aAtwfJnd8x
         Sh1KUx12V9WsyvQL3ks04VBMWz/pU9uPOHsJVcVR0xNohiSmmDBCv9DVkVT2UJPs2IIE
         LhZMOAKjqYLNE9ecaSkajc6nCBmj93YgtNzSKy2gPvt1jDw+a0v10PWUMlAEkzZjK1QQ
         ZTmw==
X-Forwarded-Encrypted: i=1; AKwUvBwhi43PIcMdB7BB2u2UeTVos0Ni4vFK6CJxJGAigAFogWr+Xd3ESZ0ANfxkS704g9i4sX+Q@lists.linux.dev
X-Gm-Message-State: AFq9FYIckYXPAJk3T4cPr2JFJJRnhEw3wzmN6PWYfKqzN8/KmkO98abj
	V8f1w4mrNv9Bf+N/8/dCYMWq4EU5Fm1QiPHqtBQh+QHZRmKDph2XM3w/Wi7i7IU49D3BNixrztq
	dupDp1I3NkQ==
X-Received: from dlbqq10.prod.google.com ([2002:a05:7022:ed0a:b0:1a0:a0b4:204c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f115:b0:1a3:6040:bf78
 with SMTP id a92af1059eb24-1a6cc34d07bmr917417c88.11.1793140766453; Tue, 27
 Oct 2026 15:39:26 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:38:41 -0700
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
Message-ID: <20261027223847.652884-7-irogers@google.com>
Subject: [PATCH v2 6/9] xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type
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
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
	Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
Content-Type: text/plain; charset="UTF-8"

hypervisor_init() in drivers/base/hypervisor.c creates hypervisor_kobj
with kobject_create_and_add() (which allocates a dynamic kobject using
dynamic_kobj_ktype), and hypervisor_subsys_init() in
drivers/xen/sys-hypervisor.c then overwrites hypervisor_kobj->ktype with
&hyp_sysfs_kobj_type, which had no .release callback.

Add hyp_sysfs_release() calling kfree(kobj) to preserve the dynamic
kobject release behavior.

Fixes: cff7e81b3dd7 ("xen: add /sys/hypervisor support")
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
2.56.0.313.g2479322e68-goog


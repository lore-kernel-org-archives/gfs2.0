Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177594;
	b=Tf72T+rZICVVwXN0cyXuDFxC64JGFdJ3BEugmAEFfTy+kmz2VjFTfyVjWA0EuLOVpufQ
	 Gfi9lM9YqHdjy88YKYzwHVYQjn5GUPMKD/2OL5O4rXM++4x5a0WwKYofCE/rzrDJAQITJ
	 Khn28xK2P/z0ET6cQh/Zk/V4lo0Fr6pwCPnUM5bApMeYisFOaJK6T6OE6RmLwxaSgDnCf
	 BgKwsl/NdVKQZCP3eYgOpXGIhvfGKAZ4Xl9GbAQI3QKbiW+RfA2WUuWX+PqeFG+TPSjDo
	 2cPaqPqISEK7od+i5oq06rxglpxm6csp8RURk4F703uAvvgU/+rwi6eD+HiSlNRjNCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=noN8ey05POi7MkRY5IldCk9pju5ZMENfN/kneqqJ3/c=;
	b=1w0A3JIjRAZamkFefzwK3jxHCCYh/29zSIM1P7jRSreKZ5abl7bpR1jzMuyZMtEKfsbe
	 6e7lRFNgkBSIPMqn9IG84WuDkt3IBReb1iZNirnmdiMLjGGLU1jnB4lNAO7JaMZHtYOqP
	 sHUdyNyTGGU8fFv8ArFoft1Ew/io8kmObep768zZhRuyNdPs9gbhIeq9uJ2Kn/Lk8QAQo
	 8gCSKVaDbAFp5Ph5EYAZBWWN4GOuSTcmFczHaDNqn/4tTBAk1ZmRQ3T/DXAPd9FGc6aiK
	 wg7zrKG861XF11VcIF0v+PBTX+EhMbmkli3xNzpop/1h9NpbwtIMGIjs2N103tTxIZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oRwpm0Ae;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58D6606D823
	for <gfs2@lists.linux.dev>; Sun,  8 Nov 2026 22:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C58D6606D823
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oRwpm0Ae
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1ac19c6bc71so293004c88.0
        for <gfs2@lists.linux.dev>; Sun, 08 Nov 2026 14:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794177593; x=1794782393; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=noN8ey05POi7MkRY5IldCk9pju5ZMENfN/kneqqJ3/c=;
        b=oRwpm0AeMBeuz+uwk/SScXYdUV9FjfHSkaA+8EymCFnKPpZ+8uBypl9pX7mf1XQMyJ
         x27Js4Yde77wTsomG4sUPRnlcsAvIiwdHvJ+Bn47KtEz2SeyuOq81ujcpJdauWUbVDcP
         ex20Sn93Q0DYhXIPHUa/Z1KzEPiiBP6sOuCXFRq8PIb2NbG9h/4aicL+k7EMSHsPhwrk
         JKJRXF9Kdm3iFAXs121DCGjYsyCtJDEL6ThzN0RyPXZyEPzwCDw8qz6Z5WCGRHsUBw83
         DQoRJwyE7usHhHQqGQFr5zu4BDx92KcdfxS3YYxMNav1zOQAW230wXhXo7YiB7kYZ7UK
         3Z7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177593; x=1794782393;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=noN8ey05POi7MkRY5IldCk9pju5ZMENfN/kneqqJ3/c=;
        b=d+WgBAfEPMBjbMYPJ5zu9y4XmWSQ1yCVTsAeQRu/OKRhRnv61ZswffBojf45CK2jAU
         9KWPfuT0E5/7E6Qzo5cRnUb2K73iZzTTIdyP2ztGHdb2cFZfjomPMXmqASIPnRGs9mwx
         aFbIUOL1m6Zi7ivQmFpgDMI08TE3Cxd3MaJPobWr4ytv2EobYw/Sk0U7FrOQhkAfkW57
         xns1t1VRLDUfkSqaI0DrVt3J9w3Nnz+gPA3seFksuADuEX9AUnMb/Bj597Gpu5nneuZz
         sbGhYEKx0WXN+1ten+L24jUIoTfktN+0I5R5XvLc28Zeha0exRBisYRZ5+3DzRuOar/c
         8O8Q==
X-Forwarded-Encrypted: i=1; AL+hErGiJ8T8UtLr4wHQjuZNrhXAuiWlGuC8Z6isX9/3zic66xAqh0qBaNZhz1mFu/9MvCocjb6A@lists.linux.dev
X-Gm-Message-State: APuU4Z//yWJBh6AmGDHbRjc3KtQAmOS1Ul/qDRpAT7nPtrbuRdPBdPZF
	KtE1Yvhp98uhAmDGEkhpY8BQNfSOg3x8dlHOfX9ccp0t8woy+ug/fF3fMw6Y6wCWvVLKhXmlg7T
	sVuSoeD+DJw==
X-Received: from dlam9-n1.prod.google.com ([2002:a05:701b:2089:10b0:195:beb6:14cc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:28b:10b0:1b0:430d:d81c
 with SMTP id a92af1059eb24-1b39feab6a4mr3897188c88.25.1794177592505; Sun, 08
 Nov 2026 14:39:52 -0800 (PST)
Date: Sun,  8 Nov 2026 14:39:10 -0800
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
Message-ID: <20261108223913.3624571-7-irogers@google.com>
Subject: [PATCH v3 6/9] xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type
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
2.56.0.455.g6c5a503b38-goog


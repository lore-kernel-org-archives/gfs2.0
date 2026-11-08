Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177587;
	b=o+TcPulRCCVLoGUqJMnc99zTKHL6xCnhCziVZmW16z8ZG0++fuppNFe4HUdTL5rGour+
	 EOaSx6hx66EKUdb2mcD7UuhgLILYOFJIv2aGAXGjC/7iOSq/znJIxG/4Ix70tdgPieEpx
	 FA+ZKJagNYlFY9lgzHjs5h8eZ2vVe8POCEB2z3xUuLC5m3C2ZxAKrD4USdhZpdI5hvcCe
	 k4A/zy+AP1iO/ba+JKUOOccJ90vaiksQYr0hnUtX6C45Q29emTOxi03egrVt6a4wi5Z49
	 GKGuDHNpxFahYeyC+CJ48JE5NvCsovSKNX1DQNmrLMARkjJfsTUwYA/8CZO4kNzUo+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177587;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=xwXDua19Tz/IicJklctcGTeEqQvEHLiE8QZruqc+WN4=;
	b=e457uHqwTbBnzPHetVHULckPnVpQCXLq65gGP0qPhQyD76dwzKQpCLLTQ/DmI/pw+Flo
	 s0RZqJzavjbzHBJTbZnepcoCO+4SatNGoP4BIgVTkNE4hiPlYmEGd4MOfOniFM/8PKdJS
	 RrcCYLiYGv6T6aArJG0HPbYi8ERatEBd+xS9kEmbXmFc8lcXoXLzqf8LOYGBZPqETtbCq
	 CylhHjeWwlOVjTSny3B8A68YRq+/Wg7ggSu80Ti8zq7ISSMzushxFCFQ1XMhFpx1CrFza
	 aRhVhioZuzPNtBRsIYsU5hJy3UfSoh3C3RYS1eaHt4eRp7jdzKyXeT+dVOnCV/c7EzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cvv5QKOW;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0558D606EE88
	for <gfs2@lists.linux.dev>; Sun,  8 Nov 2026 22:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0558D606EE88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cvv5QKOW
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3724667bc16so320745eec.1
        for <gfs2@lists.linux.dev>; Sun, 08 Nov 2026 14:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794177586; x=1794782386; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xwXDua19Tz/IicJklctcGTeEqQvEHLiE8QZruqc+WN4=;
        b=cvv5QKOWsf4hEQ9G/q4ttZFG9cRIh2GFz946k74cojNAKh3tqac98gkZyIbMw6YQU1
         7RBsNVsqgaBYsZF9gr7GyWnWVJMrKQxqvFGFa6Jpm6XjO2+WKxRovh+b3embsqgW8mnO
         +hJ97L4FDmcb06RYhhx5nEOkBGsZomUdE61CUr6s4l26vdrBaW6jwD9uQbggvby+NDNj
         kCf17zh90asA3Dt4pX6cNhXgegMdqTv0+cFlOyD+JQ8HWIpxBQPzXsq3d7R8IoHAtug1
         mbymw4nsq3ozYjrWEDRurBC5t0wWpvJm6SSNbDQg/K5CVnTOmssdfj9wjgbKihdS81ry
         bTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177586; x=1794782386;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xwXDua19Tz/IicJklctcGTeEqQvEHLiE8QZruqc+WN4=;
        b=EzqYLOLvc2khbWexhdTbNfjwdp87K8CspitbNwLZFeR3yOYzxkYryAFAzV6yTMNLu7
         Nz/YZX5DoIQllnq4psKU3IEp6ofc5gch6eaXWLlW4UIvTuaUHpa1YUPFUXT5UgeQgo4Q
         RiKAoyAtY/AbxJV3Ynu+AadiUrnV/4czflv5z3O4etbpbhtfXWZ4JOI3nQSIY8nwWE4q
         nGhPbLh3HqwFxR6L7ooEBXZYQwfcCs1vrhTSsPz363X1FMoRLSxMHAlSWR9Oj6ZHGbJU
         s2qrIQsL0BJ3qN4qG2M97rYF1UGjpItWz5FErkAvd7AhxB3viEieuiO4wENIvjbaOWIN
         iocQ==
X-Forwarded-Encrypted: i=1; AL+hErF7F0T+kQsLjKx+G0aSoPkYqmSVpmNC+Ns59Z2eVPfyA/y4yhCnn5uAb/DTiDx4pb3FLHmd@lists.linux.dev
X-Gm-Message-State: APuU4Z8AdcMMf0OkPM+JHfycwtMUM9YHoZpfumYNjzxWOBgDV/cVEP1G
	lesi0JqXCewZcE+IHWE08EUNXC/ODytgW8Z8h60Tf9TlEfVDvr+gn5Oj8SQs/IuR/8RnE21evBU
	svaYt7bFFFg==
X-Received: from dyx10.prod.google.com ([2002:a05:693c:820a:b0:36a:eec:f68c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:c00c:10b0:36d:dcdb:70c5
 with SMTP id 5a478bee46e88-370f7b8f918mr9710009eec.20.1794177585797; Sun, 08
 Nov 2026 14:39:45 -0800 (PST)
Date: Sun,  8 Nov 2026 14:39:07 -0800
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
Message-ID: <20261108223913.3624571-4-irogers@google.com>
Subject: [PATCH v3 3/9] sh: sq: Add missing kobject release callback to ktype_percpu_entry
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

In sq_dev_add(), sq_kobject[cpu] is dynamically allocated with
kzalloc_obj() and initialized with ktype_percpu_entry. When
sq_dev_remove() calls kobject_put(kobj), the kobject is never freed
because ktype_percpu_entry lacks a .release callback.

Provide a sq_kobj_release() callback that calls kfree(kobj).

Fixes: d7c30c682a27 ("sh: Store Queue API rework.")
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
2.56.0.455.g6c5a503b38-goog


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177592;
	b=gPahqbh4K37CqbyACSXPcFnGIkhVbOQICKsd2gsjtemyF57bOzGza19sm/uh9TyAu6qe
	 3gfFCJvMWNN+CpCkz1FBVs7X6dp0zu3OqI1mqwBSswRwj6T2X2AXt9AlPhnuXXQLZQYXU
	 3LtOW9l5cs0VK9zqNoYM6GEJbsNfGiMsKKMdNLgGHeAVBM46T7TYCWGFXNkGhuzaPMXWp
	 lvL14isnpK6w3mbqUiku/3PbOKDFIGqIp+abk+JyVDoUHs+9uScKV5lfUSsuBBGMXvKAe
	 X8LP4NprZHreNgt8Dd/sJMN1z2dzUseqN3yg8t9QMYxtMNIEj1vSI7+Qccg+g3HYYig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177592;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=JYLCMT9RKWWGiMVjfcLUv6CQmbQfnx4zZhBsCcC3dY4=;
	b=0oHIzDY0UsRGMQQ9zQbqRrqyICIiiKOuztZ9eGwP12cuh9x7Yc9myTtXX0DfE+lwQsdu
	 YKO9c7EA4/YkHTXyAg+THkFCxerOc+paKs3BJCDhj+DwNTwvEzzxZ6tIqNa1UC/bvAqXD
	 NrOhPOw3mtaTHsYAJ+zyPIaOnukSYqVzBa2PTlQearUIvOkmhI5zUYlkolOVu1YYeitFr
	 FUrhNflUgeS/nuxZhxLXJnWmkZferS42YIySidYmB/JcdVTDkIPHZCZe6RFIkUj5+SxCi
	 v0Zi0OaztLyi2Qym/n/B3A0UVPd9iaUbkOK9uxDUCqeQ/6NqlIP7ZuoXWdmKnX5EIfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="dThGaS/w";
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAC0606EE9F
	for <gfs2@lists.linux.dev>; Sun,  8 Nov 2026 22:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CAC0606EE9F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dThGaS/w
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1383723dfddso396990c88.0
        for <gfs2@lists.linux.dev>; Sun, 08 Nov 2026 14:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794177589; x=1794782389; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JYLCMT9RKWWGiMVjfcLUv6CQmbQfnx4zZhBsCcC3dY4=;
        b=dThGaS/wqHf+/XgIILZttY5RnVnZnArqPdcGV+Z3cAvTiN7kqxgNXDFvsYZuSJdy5E
         qx/TBOvwpOeUZYLA5hK0I+0fJdkURQ3E0lru92RGZqy+OenlBcKFggxJFwhGSSecn1LK
         BfE+vtIqlALdz5OEhdB14pZtV0O2ZDIc+uMNtX1SMWSra/8Xw7KZ+QfzQ5l7EAt0y5CD
         bbFm4sLNHOnei//MCzCwenPfAoPzilaZ6aTHReko7H6FdoPpFva0dPUprC0n+NB515My
         rUg1Ghh6P9yzQgzkg3yszIlKWJFzIwXG+KAE6EHpGiRW8tlz7n3OYA+e3euEJatPZXxb
         N37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177589; x=1794782389;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JYLCMT9RKWWGiMVjfcLUv6CQmbQfnx4zZhBsCcC3dY4=;
        b=wY6hFkAXuZ+VjdZWkyJiZSB0XHbJrGAMWrIQ76jt4twVmGZVKhqEhqzg000xG73SDG
         BG4gcQRv+0TMbvI2m3cLQByD+k+Cm2QPbKptpnnHcfBFkwcKgJitR0jnDgqBhiIYdN8F
         t6taIoMOq9GYwmzF5Tn/gfoD1W7lS5G/H4djBpZjOumt7ANjNABcXoZWvcVleDtQYG5J
         uqrfbfxQCQqgyrsu5ZNwmDqTK4mIzTEZLlKBAhBz/kNpKKw90qqngaRRHKQ5WX/WXbGy
         08skmgdA2dXuRvfVojWwGFKuD1ElzgKwv8KzUnt73Q0YuiyBn5sIdOqhG6vlbzZzfmq1
         X1RQ==
X-Forwarded-Encrypted: i=1; AL+hErHamc809Hxxr/jbO7KOF/DpEsaai4YhrB+xO8kJrGLqJ2sn3X78iPXifWedh3oiTn2AIuvC@lists.linux.dev
X-Gm-Message-State: APuU4Z/qOv6R8J2Ko635Z/pRdjb0F8kcNlKl0LH7WsiSSJpqLOeGCN5a
	UPVxh8RJVE5mP7rsg0Ou/ukO2S3lKW2S0d7aVDl9nQaThw+6Lt7uJ2p3uYtaZYLnUIrSSWTnxN4
	5y3CWc9OBbA==
X-Received: from dlec20-n1.prod.google.com ([2002:a05:701b:4294:10b0:1a4:c892:b166])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ef16:b0:1b3:a26b:8b97
 with SMTP id a92af1059eb24-1b3a26b8c4bmr3821391c88.41.1794177588129; Sun, 08
 Nov 2026 14:39:48 -0800 (PST)
Date: Sun,  8 Nov 2026 14:39:08 -0800
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
Message-ID: <20261108223913.3624571-5-irogers@google.com>
Subject: [PATCH v3 4/9] cpufreq: governor: Initialize kobj_type release
 callback statically
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

Export cpufreq_dbs_data_release() and initialize .kobj_type.release
statically in the ondemand and conservative governors instead of
assigning it at runtime in cpufreq_dbs_governor_init().

This prepares for annotating struct kobj_type::release with
__must_init.

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org> # cpufreq
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/cpufreq/cpufreq_conservative.c | 5 ++++-
 drivers/cpufreq/cpufreq_governor.c     | 4 ++--
 drivers/cpufreq/cpufreq_governor.h     | 1 +
 drivers/cpufreq/cpufreq_ondemand.c     | 5 ++++-
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 02bfd46543e9..146a2353b1a2 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -318,7 +318,10 @@ static void cs_limits(struct cpufreq_policy *policy)
 
 static struct dbs_governor cs_governor = {
 	.gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
-	.kobj_type = { .default_groups = cs_groups },
+	.kobj_type = {
+		.release = cpufreq_dbs_data_release,
+		.default_groups = cs_groups,
+	},
 	.gov_dbs_update = cs_dbs_update,
 	.alloc = cs_alloc,
 	.free = cs_free,
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index f3bd3dbe7c41..f8b5aca09b6b 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -419,7 +419,7 @@ static void free_policy_dbs_info(struct policy_dbs_info *policy_dbs,
 	gov->free(policy_dbs);
 }
 
-static void cpufreq_dbs_data_release(struct kobject *kobj)
+void cpufreq_dbs_data_release(struct kobject *kobj)
 {
 	struct dbs_data *dbs_data = to_dbs_data(to_gov_attr_set(kobj));
 	struct dbs_governor *gov = dbs_data->gov;
@@ -427,6 +427,7 @@ static void cpufreq_dbs_data_release(struct kobject *kobj)
 	gov->exit(dbs_data);
 	kfree(dbs_data);
 }
+EXPORT_SYMBOL_GPL(cpufreq_dbs_data_release);
 
 int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
 {
@@ -488,7 +489,6 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
 	policy->governor_data = policy_dbs;
 
 	gov->kobj_type.sysfs_ops = &governor_sysfs_ops;
-	gov->kobj_type.release = cpufreq_dbs_data_release;
 	ret = kobject_init_and_add(&dbs_data->attr_set.kobj, &gov->kobj_type,
 				   get_governor_parent_kobj(policy),
 				   "%s", gov->gov.name);
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 806d8fb4dff1..1026712bb79b 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -150,6 +150,7 @@ static inline struct dbs_governor *dbs_governor_of(struct cpufreq_policy *policy
 }
 
 /* Governor callback routines */
+void cpufreq_dbs_data_release(struct kobject *kobj);
 int cpufreq_dbs_governor_init(struct cpufreq_policy *policy);
 void cpufreq_dbs_governor_exit(struct cpufreq_policy *policy);
 int cpufreq_dbs_governor_start(struct cpufreq_policy *policy);
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 9942dbb38dae..7386d043c665 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -374,7 +374,10 @@ static struct od_ops od_ops = {
 
 static struct dbs_governor od_dbs_gov = {
 	.gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("ondemand"),
-	.kobj_type = { .default_groups = od_groups },
+	.kobj_type = {
+		.release = cpufreq_dbs_data_release,
+		.default_groups = od_groups,
+	},
 	.gov_dbs_update = od_dbs_update,
 	.alloc = od_alloc,
 	.free = od_free,
-- 
2.56.0.455.g6c5a503b38-goog


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116372;
	b=Q7/FOPkxNOJKzoh5hLF6AVk2tQwzq0avXTjo/NDwKyONE6559yojjG2XEnq+ZcShMbfJ
	 gIlWod9xniIdE2u2jDvjSndsAGevsu1XaDWR9y5/Wsc2aqVEZFVp2+oh04Spyj1kUs3Yu
	 idHlOQ9ddbliE/lSSr0Ts/XNMfDTZtkHn0w2UW4ir2f5lcbwb3E2IBk2HFZpBaYZwdowR
	 qOgHlY48b3zyozQrPbKckIPuAUkTL3dZytV/92o5vufNKakG3W5tL7ysFUDl8Ru3pokY1
	 Tpdtd1aXhUJgmXWLr/NNstqqfI5mueYRnQONC2Whgj+FTn38ZEnoCkaXu1/z9LdOTZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116372;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ed6ZuPWwDHIYUoQ+FZI+Wi1n/4SIGbM4V5gI4MqacGo=;
	b=SpitJHuIKbHvXojf/ma8IzkiNds0uc+DPUtr8fzC5XfaLnWQIyh8C2PV0QWkmqKiuqax
	 bYI9YMktpMTAaWZBQ43gwqqDOX9qK484NtWbBlMijF+BmDrCrpIPSIHiNG5rPkkcexWXa
	 kSHcZgZ6RMiCVM8sfjcRvZiMFcAjUUoEsWRZNQS7wu0nrXLv/lqMME6XO56KDOe1fwqG4
	 zeTJ+RfBZ2MrrHbLWhc8eUzI46sTYtcS3fc1MYxLwHpZ+0TJmDEv2ENO2Vkj8pqDH9BZ3
	 5BW+Fcn3U4fQooUZ1XEkkWJ0YNf85mJLrldbqifgp0LNZOWSP+rHzUDCRi5mUBhvzUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mwAxfws8;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD24606A325
	for <gfs2@lists.linux.dev>; Thu, 19 Nov 2026 19:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AD24606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mwAxfws8
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-383f2d05c73so196784eec.0
        for <gfs2@lists.linux.dev>; Thu, 19 Nov 2026 11:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116371; x=1795721171; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ed6ZuPWwDHIYUoQ+FZI+Wi1n/4SIGbM4V5gI4MqacGo=;
        b=mwAxfws8TPJTiiZNy2fVZnfAwRKxs2HgwlOGtAApCvHO/Bt9vgm1KY174DxNNWpbZR
         UzUEpxxN0apGR+8hRLY/qigFtegUTInsxV2EEitPkLOjsVsTfgE+N1xbg7gPqVW+t9t6
         uJA0LH1iEy3yBfy9GCfySBsoINZ6tq3OHHw7yOAw8CXm++8XSN8g6D6UfDDv77lr30Vf
         rrk3aVssMjc5PEjFiunzVogh4wyPJn+ZRlczIGhNPZ7oC0qJwAEu0RoChtISDb344CKI
         MLotYEZxCoMms0ULQVKsvrGMn9mBWrruRWsaqE9jtb7xOPmoqukp0Hb0ixoqjZZPPMbN
         bSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116371; x=1795721171;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ed6ZuPWwDHIYUoQ+FZI+Wi1n/4SIGbM4V5gI4MqacGo=;
        b=X7GV0CAnk+C/uOG2oZwk0Hwd9TealfwvOVRyjhuya1OuFu29GEL5CCcF3zcksEmpLT
         kQnQJ9pfr82H0TCsfCcPME8bVn2dU9hGWbOtsT2QPAFjlcheKBa7Qv4kmSgHzR39YGNJ
         BgVXdupnFVZO5ra0//ECJ4i4ehqOzOhIhmmI3PXaAe4ImF47GsnwD2w0bIlhzjdfyG2k
         n/az4vu+TY8tH4OM0j+vzG5GzGSE67snu3utc33Lz/JmyAFXGVHpXONStzMVGJYa66Xl
         pr+SRimcS9ERB7MgQC7qG3DMYIh2yXV2eBEPPyL7rJ5f8i1OXS0SZSy8A8WxQbWA4SgV
         ilKQ==
X-Forwarded-Encrypted: i=1; AL+hErHfun/4gaVSfC8U5lZqREWP/CcqxhQuEw2CD0HSMOwQjtc+Gz6N68aBjZNAFI4nPrb6si9U@lists.linux.dev
X-Gm-Message-State: APuU4Z+o39KHJswKryCY72Zz/7zBSy5nqXHHbVg+AY4IYJrY+3BUGETh
	s7A/MsroxTPo73g1dXYliySl6A/fPTGsz0nL7J4dqfyNLkj829oDbfG+peGvcpCLIWtxS7F0Pv4
	MU1BEfcsOvA==
X-Received: from dyhd22.prod.google.com ([2002:a05:7300:8296:b0:381:d3ca:9f05])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6018:b0:381:9593:9984
 with SMTP id 5a478bee46e88-3857151d6abmr284926eec.37.1795116370935; Thu, 19
 Nov 2026 11:26:10 -0800 (PST)
Date: Thu, 19 Nov 2026 11:25:19 -0800
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
Message-ID: <20261119192520.1983406-9-irogers@google.com>
Subject: [PATCH v4 8/9] drm/amdkfd: Free queue in procfs_queue_type kobject
 release callback
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

struct queue embeds a struct kobject (q->kobj) for procfs entries, but
procfs_queue_type had no .release callback and uninit_queue() freed q
immediately after kfd_procfs_del_queue() called kobject_put(&q->kobj).
With CONFIG_DEBUG_KOBJECT_RELEASE=y, this causes a use-after-free.

Add kfd_procfs_queue_release() to free struct queue from the kobject
release callback, change kfd_procfs_del_queue() to only remove the
kobject from sysfs via kobject_del(), and drop the final reference in
uninit_queue() via kobject_put(). Check q->kobj.state_in_sysfs before
calling kobject_del() in kfd_procfs_del_queue() to avoid warnings if
sysfs creation previously failed.

Fixes: 6d220a7e7971 ("drm/amdkfd: Add queue information to sysfs")
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 12 +++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c   |  5 ++++-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 6663718fb83c..b349e0d8d47b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -512,7 +512,15 @@ static const struct sysfs_ops procfs_queue_ops = {
 	.show = kfd_procfs_queue_show,
 };
 
+static void kfd_procfs_queue_release(struct kobject *kobj)
+{
+	struct queue *q = container_of(kobj, struct queue, kobj);
+
+	kfree(q);
+}
+
 static const struct kobj_type procfs_queue_type = {
+	.release = kfd_procfs_queue_release,
 	.sysfs_ops = &procfs_queue_ops,
 	.default_groups = procfs_queue_groups,
 };
@@ -552,7 +560,6 @@ int kfd_procfs_add_queue(struct queue *q)
 	if (ret < 0) {
 		pr_warn("Creating proc/<pid>/queues/%u failed",
 			q->properties.queue_id);
-		kobject_put(&q->kobj);
 		return ret;
 	}
 
@@ -697,11 +704,10 @@ static void kfd_procfs_add_sysfs_files(struct kfd_process *p)
 
 void kfd_procfs_del_queue(struct queue *q)
 {
-	if (!q || !q->process->kobj)
+	if (!q || !q->process || !q->process->kobj || !q->kobj.state_in_sysfs)
 		return;
 
 	kobject_del(&q->kobj);
-	kobject_put(&q->kobj);
 }
 
 int kfd_process_create_wq(void)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index cd41b10e0873..636cc894223d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -83,7 +83,10 @@ int init_queue(struct queue **q, const struct queue_properties *properties)
 
 void uninit_queue(struct queue *q)
 {
-	kfree(q);
+	if (q && q->kobj.state_initialized)
+		kobject_put(&q->kobj);
+	else
+		kfree(q);
 }
 
 #if IS_ENABLED(CONFIG_HSA_AMD_SVM)
-- 
2.56.1.708.g77570a6a1d-goog


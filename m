Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEB9563FBF
	for <gfs2@lists.linux.dev>; Tue, 13 Oct 2026 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931233; cv=none; b=GW+/+ALeMuStiYlYxNUZqVEAYlIxE3U3QAGsMr8F7BdEL+gQK9wxOM4Y9YoSfyA+e/m5SK/zQOd42G0IIVSpPWPa9NO4xQo3ypVR7AocicnSx/wQVKwEgL5ohIdGGSIPIeFNMrvsOabHm3crw9yMhUiRtfscjoRPmaQ9kxvDwok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931233; c=relaxed/simple;
	bh=CtncMESqzMmhRbpylMpIrDVzOLt3AaDiHb77RK2NC2U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DuxqiShMC4bVgkkx+1+UbYhpvqUaHxRxESCg1R9XNhLUgvUKWNItSokUD+6eA8iIMPU7IvhCBeJ6mr/4e8VF1eYCE0TLWh5LJmlPAvYrfPY6yCZ+A89cTbDiAQ/GmG4f0XkYVhqHeTqKuNHPy1f5GTAi4ydDs+kDDhTmGybB1aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lVheBYo8; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lVheBYo8"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso7840566eec.1
        for <gfs2@lists.linux.dev>; Tue, 13 Oct 2026 15:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791931225; x=1792536025; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wbjJdHqZPRkvVZnH2yPkFa6V1wQ6/MdT39yYoogCQX4=;
        b=lVheBYo8L9X/LDfGtxNlus4jAb7RnxSdGgohEfM5mbFR+gwui0ve4WJSzug+H3Dj0E
         odVQvZJJbwFBJioCYkSJwMPb1VNn47vNntZ+ovvRBmlehwd67gJq1wHheN7l+i9If4en
         NiXYI62t705AuR9mzVPFhzh+RnOyvnACeTG4Ayhw/fTM2dbNAp2muX24snZhG894kWIy
         33+Z0BrawhUDq4UQYUnDvGr+tloXtPSMzwfswVOEOR5pIzr96TvCem7K4BK5yQNuvaac
         3+yKncySJd7bwxI2g6qti+hI+GoeVBmFshmGBROArXwNsLceBzYYaIDGRN4LYCDRU6VW
         /uGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791931225; x=1792536025;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wbjJdHqZPRkvVZnH2yPkFa6V1wQ6/MdT39yYoogCQX4=;
        b=dgJ2F9N8f3HQ9s+3xgTX8UuGtWa603l8Szst37Vx0YOZEJwTRN5oKvLxHkfaCSMGo6
         /KGJ8TRd5pzSxmhPeECcvji769C+ST5pWY5KVBiM/xp3SpY1/eCsSLSsrcB9TC1uyo8U
         O96l2uMCaTQDW66EfwcEzlmDJE9Mg3enFppRpV7eW7pUzCFagHCuHILaS0sYZcpXRtnF
         xNj8G+UkY6XbQr/X29dovPweQCKE1jy3jLDrFBeLUdzEtqmAWltSqr7CvMpKLzqLdOwo
         zcHqVm/beUzocHySatMmLCbov8tU4UwWPM0mbXJAFHc7zF8L/LolfvJ7yPnk4Idm7f2g
         Hjog==
X-Forwarded-Encrypted: i=1; AKwUvBzyhAQ+mUVCn0k/SN4c9c2L3vCaQclHHzqozmVKD+Cg1K8Eic8IzgjQvisQP82+PcY7rUjX@lists.linux.dev
X-Gm-Message-State: AFq9FYImv8WrY5zQRg2ZnM1QnRBXuJqr2eby0mBFVnwvLvB1iN2pDLhV
	krYzmZrFW9t9sfUk6RPpXEyDtmLYDOmrszX04rEsVCOVguWpOOS7sTDf3y4o0nfqqRfK6EYYzfL
	9lny/My8MPQ==
X-Received: from dyr27.prod.google.com ([2002:a05:693c:401b:b0:359:e5f1:14fb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:470e:b0:35c:73ca:a1e0
 with SMTP id 5a478bee46e88-35c73caae65mr4317399eec.15.1791931223446; Tue, 13
 Oct 2026 15:40:23 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:39:40 -0700
In-Reply-To: <20261013223946.1836757-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013223946.1836757-6-irogers@google.com>
Subject: [PATCH 05/11] ACPI: CPPC: Free cpc_desc in kobject release callback
From: Ian Rogers <irogers@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Viresh Kumar <viresh.kumar@linaro.org>, 
	David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, driver-core@lists.linux.dev, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
	linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

cpc_desc_ptr embeds a struct kobject that is registered in sysfs via
kobject_init_and_add(), but cppc_ktype lacked a .release callback and
acpi_cppc_processor_exit() freed cpc_ptr immediately after kobject_put().
With CONFIG_DEBUG_KOBJECT_RELEASE=y, this causes a use-after-free when
kobject_delayed_cleanup() runs on freed memory.

Move the sys_mem_vaddr unmapping and kfree(cpc_ptr) into a new
cppc_release() callback on cppc_ktype, and initialize the kobject on
allocation so kobject_put() handles cleanup in all paths.

Fixes: 158c998ea44b ("ACPI / CPPC: add sysfs support to compute delivered performance")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/acpi/cppc_acpi.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index fef54fcd00b7..2a80404f85d3 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -297,7 +297,22 @@ static struct attribute *cppc_attrs[] = {
 };
 ATTRIBUTE_GROUPS(cppc);
 
+static void cppc_release(struct kobject *kobj)
+{
+	struct cpc_desc *cpc_ptr = to_cpc_desc(kobj);
+	unsigned int i;
+
+	for (i = 2; i < cpc_ptr->num_entries; i++) {
+		void __iomem *addr = cpc_ptr->cpc_regs[i - 2].sys_mem_vaddr;
+
+		if (addr)
+			iounmap(addr);
+	}
+	kfree(cpc_ptr);
+}
+
 static const struct kobj_type cppc_ktype = {
+	.release = cppc_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = cppc_groups,
 };
@@ -799,6 +814,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 		ret = -ENOMEM;
 		goto out_buf_free;
 	}
+	kobject_init(&cpc_ptr->kobj, &cppc_ktype);
 
 	/* First entry is NumEntries. */
 	cpc_obj = &out_obj->package.elements[0];
@@ -1001,11 +1017,9 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	/* Plug PSD data into this CPU's CPC descriptor. */
 	per_cpu(cpc_desc_ptr, pr->id) = cpc_ptr;
 
-	ret = kobject_init_and_add(&cpc_ptr->kobj, &cppc_ktype, &cpu_dev->kobj,
-			"acpi_cppc");
+	ret = kobject_add(&cpc_ptr->kobj, &cpu_dev->kobj, "acpi_cppc");
 	if (ret) {
 		per_cpu(cpc_desc_ptr, pr->id) = NULL;
-		kobject_put(&cpc_ptr->kobj);
 		goto out_free;
 	}
 
@@ -1013,14 +1027,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	return 0;
 
 out_free:
-	/* Free all the mapped sys mem areas for this CPU */
-	for (i = 2; i < cpc_ptr->num_entries; i++) {
-		void __iomem *addr = cpc_ptr->cpc_regs[i-2].sys_mem_vaddr;
-
-		if (addr)
-			iounmap(addr);
-	}
-	kfree(cpc_ptr);
+	kobject_put(&cpc_ptr->kobj);
 
 out_buf_free:
 	kfree(output.pointer);
@@ -1037,8 +1044,6 @@ EXPORT_SYMBOL_GPL(acpi_cppc_processor_probe);
 void acpi_cppc_processor_exit(struct acpi_processor *pr)
 {
 	struct cpc_desc *cpc_ptr;
-	unsigned int i;
-	void __iomem *addr;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, pr->id);
 
 	if (pcc_ss_id >= 0 && pcc_data[pcc_ss_id]) {
@@ -1056,15 +1061,7 @@ void acpi_cppc_processor_exit(struct acpi_processor *pr)
 	if (!cpc_ptr)
 		return;
 
-	/* Free all the mapped sys mem areas for this CPU */
-	for (i = 2; i < cpc_ptr->num_entries; i++) {
-		addr = cpc_ptr->cpc_regs[i-2].sys_mem_vaddr;
-		if (addr)
-			iounmap(addr);
-	}
-
 	kobject_put(&cpc_ptr->kobj);
-	kfree(cpc_ptr);
 }
 EXPORT_SYMBOL_GPL(acpi_cppc_processor_exit);
 
-- 
2.56.0.385.gd3acb90ef8-goog


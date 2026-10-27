Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140751;
	b=EQoPqfFrc46r6iWZ7oWt9G8VyFx/TgTd9m7kavgkfHPMn55dRmkGcykNv9QulOWbrFlj
	 2Z4LgSRXS/WlL4IDeqO2CP1cwce0OnetDDg75PlttLtSIVL0EqrNzEVZdEEvOIoqT2Ud0
	 q9n3Oi8MSxpd+rNNWmdP/nFarH4VHL3vrlWckHHCDBOdaAakqBoJLiBmtZZwyzY84YoQu
	 JWrJzUI/BoUpk9VSMmLZJGcwGfkwUWvHnYSr792BZroY7mYXUfLAMpo5Jbz+x2NefT3MN
	 AGZyVDwJRT0GcyGx6MqWcb5PSISGhdA0IvBOn3lVqM6AOj8iWruKh69cxCOgzCW0qjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=pEmx5PL3tlnBiGr2rjVOl0G+YHkBW7VB5cziBEiH9l0=;
	b=l86pQDG5DFF5ChMbN+aXhOD4CoXEEk1vT7p+WcniVys7yCR9Jmtq+tQwL3BKLmQMGwhG
	 kSb5O+2Ze+G6T+JvIfhfMBIiZjqxh5AvFdphOpD3H39YSv+GAezX3j+yXRGpXV0jcZzis
	 kWv5KRqSTswp5oqTBQtFOnSFocefbGs+2LJ+mcQqsPRBcAy3REqagjfVLgmQukfR91ASC
	 teq4fYfpxhqDhZwM12sL2drPoE1RVT1tZYJ8bCPLmmQD8thp+AVPjaO4LhGtS/CSZuNrx
	 QFPx2umW16WHrHGmTDLr78LLJ0MKO1UFEFHVW3tyc0Lz++IIlbqyiAgb4A5WGqWf+dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XJaJkdhg;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B06606A31A
	for <gfs2@lists.linux.dev>; Tue, 27 Oct 2026 22:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38B06606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XJaJkdhg
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso579219eec.1
        for <gfs2@lists.linux.dev>; Tue, 27 Oct 2026 15:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793140749; x=1793745549; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pEmx5PL3tlnBiGr2rjVOl0G+YHkBW7VB5cziBEiH9l0=;
        b=XJaJkdhg84MLpX8NxKKJxamSxHst5QbgFMJp7i+SzxoMRLRHDOHuYTvYQFkPmtugtQ
         alVv7aiCD7yW6CWvl3x+VvG/cmEoG8IkPp0F/QQ93J4XG0jbOa3MEvuT0keoH9i+ejG1
         faTbzJUrfdbTeHyBs/Q5UkIVM97x26I+QWyFRBNVtBEwQj5BvSbigBQWtt49ffr3/CXc
         ypIClmIjN/6OM3frPT0mayS6UGTn+dBDptUIPzBmjezlFSA0PbPy4KOmYcdnl0MGL6iI
         PLjcc1YYbYOT66g/XVc/9UWm8XsCtpxdzudeZoLv1C+fvijjrGH5zyzIAO7g1XaWDcuC
         rVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140749; x=1793745549;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pEmx5PL3tlnBiGr2rjVOl0G+YHkBW7VB5cziBEiH9l0=;
        b=ofQJOXukKeYSm3YvZu+1p6HBrxtIst7sVypVVFvHPvJhBIfQ4A++gn0hSI6ZNnF7Rl
         +M7dyrr4509/9fTai+Kw7zfHdF/APgXxD8O4mBnC23D40yh2I7mmwmfiqmRKOB2WEIfB
         7LRuyfhB0+lPS+DPQrHiqlNOdukcnDdD/g6BzP7sd3NcEds99afc5MZCdw6rJgh6Wk8s
         CCX5utKKRufhyTlxvfkjbsT+geUcB5eJk913kqqcSjDGAW+LoX/MLUi11EhCmocF/G49
         svaS3rmeSYF9Dw7Ih+2YjYlIX0riNFvWhO6Cu+DMvWINFUT1pzoZt0BwttHL0R+C8ftZ
         z6vA==
X-Forwarded-Encrypted: i=1; AKwUvBzXaoRFSaPOtFbuANbUe6isI7Ps+o8d/PtGt0upaRgMa+KB8zU2peUVfQkMl2IwBur7PHuq@lists.linux.dev
X-Gm-Message-State: AFq9FYJFLnZgyXXT50V/aKm41k9KNDpq+S0A++kNG7Se8mi4yfw1YO1e
	imvkeU1zhdV1V+r/19eaQzmDibuzBhWmORSigZCzSACqA61NkHWzzKFf6ZMjVcxU4FFpl0kl6NY
	DxBnV/D33oQ==
X-Received: from dli9.prod.google.com ([2002:a05:7022:289:b0:1a1:da78:f9b9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6989:b0:165:90af:a25f
 with SMTP id a92af1059eb24-1a6cfa0c447mr941563c88.41.1793140748444; Tue, 27
 Oct 2026 15:39:08 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:38:35 -0700
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261027223847.652884-1-irogers@google.com>
Subject: [PATCH v2 0/9] Add __must_init and require explicit kobj_type::release
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
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Clang supports the 'require_explicit_initialization' attribute on struct
fields to enforce that the field is explicitly initialized when an
aggregate object is constructed, emitting -Wuninitialized-explicit-init
(enabled by default) if the field is omitted.

Following discussion at the Linux Plumbers Conference [1], patch 1 adds
the attribute to include/linux/compiler_attributes.h as __must_init. In
v1 it was called __require_explicit_initialization. Kees picked up that
patch with a first seq_file user [2], and in that thread Greg suggested
the shorter __must_init spelling, which Kees and Miguel agreed to. As
the attribute did not land in the v7.4 merge window, Kees asked that
this series carry the renamed attribute. The Acked-by/Reviewed-by tags
on patch 1 were given for the original spelling; the rename is
mechanical.

As Documentation/core-api/kobject.rst notes:
  "One important point cannot be overstated: every kobject must have a
  release() method, and the kobject must persist (in a consistent state)
  until that method is called. If these constraints are not met, the
  code is flawed."

Annotating struct kobj_type::release caught struct kobj_type definitions
across the tree that omitted .release:
- Patches 2-8 fix struct kobj_type definitions where dynamically
  allocated kobjects, ksets, or enclosing structures were either leaked
  on kobject_put(), freed prematurely before kobject release, or missing
  proper static initializers.
- Patch 9 annotates struct kobj_type::release with __must_init and
  explicitly sets .release = NULL (with explanatory comments prefixed
  with "Pre-existing:") on the remaining legacy struct kobj_type
  definitions whose kobjects are static, per-CPU, permanent firmware
  structures, or embedded in devm- or parent-managed structures.

Note on tool use: An LLM coding assistant was used to help audit the
compiler diagnostics across the tree, draft the fixes and changelog
descriptions, and verify builds and review feedback.

Changes in v2:
- Rebased on v7.3-16928-g83f32c773255 (v7.4 merge window).
- Patch 1: Rename __require_explicit_initialization to __must_init per
  Greg Kroah-Hartman; document the Clang >= 20 requirement per Miguel
  Ojeda; note the Clang gap for file-scope objects without an
  initializer reported by Kees Cook; add tags from v1 and from Kees's
  posting.
- Move LLM assistance attribution from Assisted-by tags to this cover
  letter per commit 1e035297ffda ("docs: remove Assisted-by
  references").
- Patch 4 (cpufreq): Use "cpufreq: governor:" prefix, drop Fixes tag,
  fix typo, and remove the redundant runtime assignment in
  cpufreq_dbs_governor_init() per Zhongqiu Han.
- Dropped v1 patch 5 (ACPI: CPPC), already fixed upstream by
  commit 27954e29d7de ("ACPI: CPPC: Release CPC descriptors through
  kobject").
- Patch 5 (dlm): Call kobject_del() before dlm_recoverd_stop() in
  release_lockspace() and the new_lockspace() error path, and wait on a
  new ls_kobj_done completion before freeing the lockspace or dropping
  the module reference, avoiding races with delayed kobject release.
- Dropped v1 patch 8 (s390/sclp_mem) per Sumanth Korikkar: the
  /sys/firmware/memory/memoryX kobjects are permanent, so sclp_mem.c is
  folded into patch 9 with .release = NULL.
- Patch 7 (ubifs): Add Tested-by and Reviewed-by from Zhihao Cheng.
- Patch 8 (drm/amdkfd): Check q->kobj.state_in_sysfs before
  kobject_del() in kfd_procfs_del_queue().
- Patch 9 (kobject): Cover sclp_mem.c and the new amdgpu_ualink.c
  ualink_xcp_info_ktype, fix the overlay-sysfs.c comment, and prefix
  legacy .release = NULL comments with "Pre-existing:".
- Patch 9 (kobject): The ioat, kunpeng_hccs and omapfb display comments
  now say that the existing teardown can use-after-free under
  CONFIG_DEBUG_KOBJECT_RELEASE (reported by Sashiko). Fixing those
  drivers is left to follow-up patches.

v1: https://lore.kernel.org/all/20261013223946.1836757-1-irogers@google.com/
[1] https://lpc.events/event/20/contributions/2392/
[2] https://lore.kernel.org/lkml/20261014225811.i.852-kees@kernel.org/

Ian Rogers (9):
  Compiler Attributes: Add __must_init macro
  powerpc/secvar: Add missing kobject release callback to secvar_ktype
  sh: sq: Add missing kobject release callback to ktype_percpu_entry
  cpufreq: governor: Initialize kobj_type release callback statically
  dlm: Free dlm_ls in kobject release callback
  xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type
  ubifs: sysfs: Use kset_create_and_add() for ubifs_kset
  drm/amdkfd: Free queue in procfs_queue_type kobject release callback
  kobject: Require explicit initialization of struct kobj_type::release

 Documentation/conf.py                         |  1 +
 arch/arm64/kernel/cpuinfo.c                   |  5 ++++
 arch/powerpc/kernel/secvar-sysfs.c            |  6 +++++
 arch/sh/kernel/cpu/sh4/sq.c                   |  6 +++++
 drivers/acpi/sysfs.c                          |  2 ++
 drivers/cpufreq/cpufreq_conservative.c        |  5 +++-
 drivers/cpufreq/cpufreq_governor.c            |  4 +--
 drivers/cpufreq/cpufreq_governor.h            |  1 +
 drivers/cpufreq/cpufreq_ondemand.c            |  5 +++-
 drivers/dma/ioat/sysfs.c                      |  7 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c    |  5 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c       | 10 +++++++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 12 ++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |  5 +++-
 drivers/infiniband/hw/hfi1/sysfs.c            |  5 ++++
 drivers/infiniband/hw/usnic/usnic_ib_sysfs.c  |  2 ++
 drivers/parisc/pdc_stable.c                   |  5 ++++
 drivers/power/supply/ab8500_fg.c              |  5 ++++
 drivers/s390/char/sclp_mem.c                  |  2 ++
 drivers/soc/hisilicon/kunpeng_hccs.c          | 21 +++++++++++++++
 .../fbdev/omap2/omapfb/dss/display-sysfs.c    |  7 +++++
 .../fbdev/omap2/omapfb/dss/manager-sysfs.c    |  5 ++++
 .../fbdev/omap2/omapfb/dss/overlay-sysfs.c    |  5 ++++
 drivers/xen/sys-hypervisor.c                  |  6 +++++
 fs/dlm/dlm_internal.h                         |  1 +
 fs/dlm/lockspace.c                            | 26 ++++++++++++++-----
 fs/erofs/sysfs.c                              | 10 +++++++
 fs/f2fs/sysfs.c                               | 15 +++++++++++
 fs/ocfs2/cluster/masklog.c                    |  5 ++++
 fs/ubifs/sysfs.c                              | 24 +++++------------
 include/linux/compiler_attributes.h           | 12 +++++++++
 include/linux/kobject.h                       |  2 +-
 scripts/checkpatch.pl                         |  1 +
 tools/lib/python/kdoc/xforms_lists.py         |  1 +
 34 files changed, 202 insertions(+), 32 deletions(-)


base-commit: 83f32c773255720a661aa45d83e36278135f23f5
-- 
2.56.0.313.g2479322e68-goog


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140760;
	b=o1jzT/vlFsgkQ00yOCj3ALJFYI7+i7O2Y7lt/8BYDN5EhJ/fmFlM9WCh4k358r7al64g
	 UU3y4GPgh5jorHXPXzU68nBV5JfksOWyL9/DeP+2Hv/9Mg6EZpE2PeJlEOYToH2JFFEKl
	 FA6gvQmuS0u9wVaGQYYFEGr/IaQLn0GZkdh4MDdl94U8x6ox7cxyLIIFAsN81bn0pvm3z
	 B5p9SxzCeHEZAD2xPEpMVaxV93D4HQE+exVEQ3Mlc2dpVLdDKi5tWV+MBVwb53xujwgFa
	 BVzQfzAf7n4HTwdQY89irQnrusgR+M4t9q7at6metawJHk3MpAnIGLQl4niS5zCQWTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140760;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=beIsynJTUoVVYUibNrHvS9xq2J3rMWzpCblr3XGPomY=;
	b=2+T8xAI5aMcz8rwJk69kjhjqvaMc5a8JFY2RR+1s5PpI6lVl7dKj9TBjbGWHn60KvyY/
	 qbDk1WRdmFbhaHLsGhpsGnniOvA7mX7XkMPxi8bBGEje3hea4XMDFq7JqVRdSdBzRHtVM
	 gLhoQyWf6Yl7OysCLVjZ9Y0qfr5igNi4UdiAwzg4ibdKHrEA8DNrD2xHI8ds7J8w2tOFh
	 uON9xnV/Lblzt8/j0MYt5AzvaVEE6aej1vICUF6rE91WzAlCxRADZgkP6jeIWV0av9LLx
	 E9B2D6J7H+3AAwnevvrNYkdTWAx01UGGKkW/AZy6WX+byh7pPuRgsJBcX6mbCtd826g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CEPbCgzd;
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5962E60A260C
	for <gfs2@lists.linux.dev>; Tue, 27 Oct 2026 22:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5962E60A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CEPbCgzd
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8a05c820ecbso551611b3a.0
        for <gfs2@lists.linux.dev>; Tue, 27 Oct 2026 15:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793140759; x=1793745559; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=beIsynJTUoVVYUibNrHvS9xq2J3rMWzpCblr3XGPomY=;
        b=CEPbCgzd+lTjshmnoA51ZLAGxWXXJ0MjiwZ6jMsTpXIlRN0qFbm+61zLAHuollDRrq
         NRZ8ELGdDPIzjKxGmPM89+pSHxM9Mnor8QV6Fi5ySAk1UcWH+mB9f6WYdlH3StFwEMj+
         NcvdQZ+kNvWt2RSyhynvOaD5yWTOAfC+0GaGTatxaCzXiV78V03fg9B1c6tjmWuyHyDj
         qBw31cF8bZD0w6FRALP9XWaecHjAkSkBCOP+mNoT8E51I3rNR01dLYtn2uBI8M/UIv5A
         b50C7QctzF4uZfjjNQQCS8LX+AChP8iBrZvqw6qjdSrxo8IVcCeptCO2N9j7D9iCFwHq
         08wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140759; x=1793745559;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=beIsynJTUoVVYUibNrHvS9xq2J3rMWzpCblr3XGPomY=;
        b=EEVnF/UmGrnvyDV+F3shxSWWKgTEt+2ghjCm2p3W0eDWdhgU5Dcvh1Pu5BE7rsUoDp
         RTAFR58zwZ6RS3qSgN6xpS4CLM5DM+ZoOhP8KwlNlif5zNDB44+dAYLF0QDFx5iJQjmX
         IvTGpnhbcBfZunxTi146NfFKMGSRWDxBInwYanIFq/iZMEXpEHYp/1DCjZyo5uJL3oXY
         peNQwhx2gjlaNXJ1ldmi/nhGAEv+COBmwCiHEXQF0nQegGGvHHsZSWxiYoNgfmJJ60J6
         c1xuCVluuXb/n9yvmZs5Yh2NMQ1oSdjd4C3ORy2ut73wH2yFpDWwaVDD3P4rE/0BSxPJ
         Az3A==
X-Forwarded-Encrypted: i=1; AKwUvBxBLSasr4pvz9+2o3b5y0IUjTQhElE0HmJTYd5sWSDglh7e/9M6MDr5BUDmSEj/1uc9aGAv@lists.linux.dev
X-Gm-Message-State: AFq9FYIx4P6NWCkkNV7TeoqNG+0mfUVjiqlQOJxE+4o6vIgp+gXu2XY2
	Hq4K/GTKc41Vg2WVQfXijm63TdbK/VlgTDEhP3iTRO1lzPY6dUSbx5kiQgv/xN38dD0L0/pKi0N
	OHUmCxM9/AQ==
X-Received: from pfbdw21.prod.google.com ([2002:a05:6a00:3695:b0:89f:827e:eb47])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4293:b0:876:194e:b8fe
 with SMTP id d2e1a72fcca58-8a6e70e832amr492696b3a.26.1793140758450; Tue, 27
 Oct 2026 15:39:18 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:38:38 -0700
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
Message-ID: <20261027223847.652884-4-irogers@google.com>
Subject: [PATCH v2 3/9] sh: sq: Add missing kobject release callback to ktype_percpu_entry
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
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Paul Mundt <lethal@linux-sh.org>
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
2.56.0.313.g2479322e68-goog


Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB49563FA7
	for <gfs2@lists.linux.dev>; Tue, 13 Oct 2026 22:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931225; cv=none; b=PxbV5AOTwT11BG9qte2FtqGLHQnV20UZW4wqbxB05zkkqW5Ic9rCKhPhuQ2Z41F9+Fe4h58AAqVWwaKA7cWCX9NOYR9p1TJ2X7hV4+wy0TMBLRTD4O8oOwTy+zOoe5DAQV6rp83zpeHJ+WJzVk6Ni7eADjFFDT3R2B28tOpK6kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931225; c=relaxed/simple;
	bh=1NEN+Scbgml9ozAbt8aLROD/kvCT+P1eXcLOXmgikX8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y6zeEvekWPxj91b9HG8VGft7QASvO8EycJkFHZnPzvJV8cCokEt4hAqHWmkye/VpMtiUyJcKNtEVg1IKUE5+XkQxVJXb1nF05MrhY1ghTLljqWr9cB66OIboYz+o9b9ws+WcDH5BAXsP1uhBf6lGGau8XWrqQKCCvv08FDV2JiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aAKEJdBW; arc=none smtp.client-ip=74.125.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aAKEJdBW"
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-351788121cfso4936563eec.0
        for <gfs2@lists.linux.dev>; Tue, 13 Oct 2026 15:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791931217; x=1792536017; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qdtOvNbLAOJ9idJnmqNXkxs2lXj3bNW1pL8KRmE6mUU=;
        b=aAKEJdBWs1tKWAHxlyxQ299RX0yDXKUJFfAzhVcuFe1I7jqt29obPecNCDNm7O5VuN
         NDWwFGJsHVs3e+sHcAk3OUIIpiXXQwMATFDS1yEC1imCdGnFBaTLvP+mjuv9secx4ifT
         MADrEtrGqVcGNPxwOi71zBt7asWu0sASBLVTPdsPahO7QhVhpyq5B/6wlLRlNSgYyjeN
         YpgsmskUVTPLpjySsvp1e0TewjofpohUFiZMfZww8ayPPRIdDpj2zTHkj8J2BoWZhbCA
         M5F+IXq2HfsgJkDRb7gcdSh7xL9waEBxgVRg8l0mXTbO72dnXUxM+vX/uQXtmleUoIgy
         1FXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791931217; x=1792536017;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qdtOvNbLAOJ9idJnmqNXkxs2lXj3bNW1pL8KRmE6mUU=;
        b=bqw+d+LNHh8WNwTVrt5YYTyM1i3ptrjcAni6Ss0V1Fw4aT73zuL2hgXgp+aXAlpd25
         euLy7SN2b39RwL9dlaSnMqWRWOPMu7lIG3sv4VzKpBe/ucbYgSwE+p7JOPP04ApFs6zI
         npg1Hg2LXKmbjsUuB5TEKjpQEYhv6s16EuvWyZdhGquCt7jT4kizgGsy8+eqaQ/65bP2
         1c76Anj+nUQtZLylap7SxlQzVYBJ9ijLU2V90rx7oIN44XCEecPzvyyBDX/U36wlO+fI
         sLZLP8Va/7E0tmr15PRd3ycyyC7u6gPzvayw25bXJHOZa7QZu5EezVAySBSkhlTpa7Er
         oMgA==
X-Forwarded-Encrypted: i=1; AKwUvBym06DSGsrdZM2r5jgBHW5MGUDl6nh3/GkI2poEqzdiFPr5XM9V1fuF1LNuINw48ziF/nS5@lists.linux.dev
X-Gm-Message-State: AFq9FYLxfp8A4THUVJpxz45vfwhmmBWh5xJ4LFJYvmFUof+PcGo2Kvea
	Tse4SbN+A8Gqq1Bze2cqkFQZjYriobeSU4EK478JkaAGVEXNXJWsZpSbMwPKEPem+lq53vmPT/K
	gzRuJQD1gjA==
X-Received: from dycrm16.prod.google.com ([2002:a05:693c:2a10:b0:358:f250:485f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:4141:20b0:35c:8d1f:5634
 with SMTP id 5a478bee46e88-35c8d1f58e8mr4713972eec.12.1791931216820; Tue, 13
 Oct 2026 15:40:16 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:39:37 -0700
In-Reply-To: <20261013223946.1836757-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013223946.1836757-3-irogers@google.com>
Subject: [PATCH 02/11] powerpc/secvar: Add missing kobject release callback to secvar_ktype
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

In add_var(), a struct kobject is dynamically allocated with
kzalloc_obj() and initialized with secvar_ktype. If kobject_add() or
sysfs_create_file() fails, kobject_put(kobj) is called to clean up.
However, secvar_ktype does not define a .release callback, which results
in a memory leak of kobj (and a pr_debug warning in kobject_cleanup()
when CONFIG_DEBUG_KOBJECT_RELEASE is enabled).

Provide a secvar_release() callback that calls kfree(kobj).

Fixes: bd5d9c743d38 ("powerpc: expose secure variables to userspace via sysfs")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/powerpc/kernel/secvar-sysfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
index 395399bbab2c..f3f6ac25ea78 100644
--- a/arch/powerpc/kernel/secvar-sysfs.c
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -126,7 +126,13 @@ static const struct attribute_group secvar_attr_group = {
 };
 __ATTRIBUTE_GROUPS(secvar_attr);
 
+static void secvar_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static const struct kobj_type secvar_ktype = {
+	.release	= secvar_release,
 	.sysfs_ops	= &kobj_sysfs_ops,
 	.default_groups = secvar_attr_groups,
 };
-- 
2.56.0.385.gd3acb90ef8-goog


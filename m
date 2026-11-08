Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177584;
	b=aZiRk3s1WETn49kMkBQkjUxodwfsEvhLaC3+zjliiLZAsvrMeSWaNKxuOHB1wj7TAOZO
	 ICVAlCFtBofgTPZM/3JWdGQlMUAd4T6ccW75of9km97Bf0SowV6qG0MNPDifW1qC2uUFJ
	 a2nL0lCkKuUCtoB6EC7oQQR8Hj6iSEr6BlslDL9Um+NdLNrp++RpiSHixYGK5YIJNagD3
	 uR0muQ06CdwFYSgr3JnLBBsoFIRj7FDxq4JQJX1JRl2LIyE7FSiTILo+nAButrxIhYxBU
	 x21tbdc7s9UXhxbMPtnLTl4Od4taFablII7pMLCz0DzK5OcfWOF++jATB7QFmDdt7CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177584;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=AHLMqwM6/67Zcd/LOxQ2+hhUbtfPU/BOw3z2THUGUxg=;
	b=c3CyA1GBOM4XA84emWbCRlLA0OUTuXLbLL9N2fus7N5f8APRcGcL+r50NzhHNDXU/7em
	 t3110mIrpuzm2+OGhk/JyIfv2dwOgeFUcfMPDkHRu4iB6edmLj5xu/9PyGxKTmCmtxU01
	 5N9vyYMfgso0P1oIjJJtymB4Ar7GrQ/d4IbywROw5bxqT6CVpWr24N4Ph1s4DWC+Dob6I
	 6zRGC3PwKsNiQaqshhnhGfvL8ZTvio+4cn6fh4bQi9lalFmtjM2SwBBPHkRpskccBMbLD
	 qkwaMCvTCOJ9cqzBG+nMygyyto5y7XQMjKXJFZlJe7czUf1kivZLHQKWPbDHaM0Sc1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Tdcnz24P;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406C2606A325
	for <gfs2@lists.linux.dev>; Sun,  8 Nov 2026 22:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 406C2606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Tdcnz24P
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-370230d93efso689747eec.1
        for <gfs2@lists.linux.dev>; Sun, 08 Nov 2026 14:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794177582; x=1794782382; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AHLMqwM6/67Zcd/LOxQ2+hhUbtfPU/BOw3z2THUGUxg=;
        b=Tdcnz24PHztVxw12Leq6QUZSi5dimpv9JTLJwf4OoLKLBLpLPEyHDimHRJin0jVCm4
         RyzqY6ZPEVs203WojVG0ADzdtaHyhkkaOISm6qPt2xaKyNd3DQWr9E4XLctvMrVb/TAl
         qyhgBSDXHRRDXvuiLw1Nym2Dk7zkWbt6GWc7J86SMsK845r9cDbJQofOgoNcFSQF8zWc
         Y36fWGcHeMW2UJCRUqNNmZ5zhIjWq4ltFuU7grtUq8rvmmzoLa41s8GDawM87AhoOPCI
         BokjO2GMuV8BeS+hZuSETfvodGbe1J26kOiFhZ6CtrxvuWuSaSLE+M8BVgyZVkIGCqPO
         nbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177582; x=1794782382;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AHLMqwM6/67Zcd/LOxQ2+hhUbtfPU/BOw3z2THUGUxg=;
        b=Kw5apQoPU55w0J27u8OZF0G9xNk7lTFewONa50KBwZ8iG+i1ogfexOP5JOtcToHjOR
         p1wAr1dqqGFoT7NBBC7uURJFTuRQabl2L+so+BHWO3Ing0p0xKT6j/pm5e0xjgvkPJpZ
         q6fVjyJivKDdGSOsasTnJNjfMRcjUV+cjP2d84txtG16o4adnfbekMxXXIirQjGPaSEB
         JZP+hR4Yd8Yago/QdS47rxOIO4fZP7qBR9C6E7upKLAzakth/EXzTKFOL1QzoQOPzgxs
         nlcy8z/gdITERO/7LMpKbUYbPMxptYYwuqxSSDV50QRxvxOiNUUuxBJEtDgBjvS/UC9D
         StBA==
X-Forwarded-Encrypted: i=1; AL+hErHHAHM4r7XdmiUSL6BmhwbXxVHkjuByHWlkFsrt8iPamRMsBW89598M8VzkTCBg21gnv0Iv@lists.linux.dev
X-Gm-Message-State: APuU4Z+zOyoPtCwDIXAbtOKbM46d6EOZc/23fa+GySOsgPEqZ7Tkeka4
	WTuNWHMce1tSzEPay4sS5ZRomPA9hptc6NeReZZJTpu69hhqYNaZ+hbhnXaXvofkn+jDKhP86kj
	sHTpy2a0IRQ==
X-Received: from dlbox21.prod.google.com ([2002:a05:7022:1215:b0:1ab:fb55:f657])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b884:b0:1b2:695b:79f0
 with SMTP id a92af1059eb24-1b39fef03f3mr3576923c88.32.1794177581955; Sun, 08
 Nov 2026 14:39:41 -0800 (PST)
Date: Sun,  8 Nov 2026 14:39:05 -0800
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
Message-ID: <20261108223913.3624571-2-irogers@google.com>
Subject: [PATCH v3 1/9] Compiler Attributes: Add __must_init macro
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

Clang supports the 'require_explicit_initialization' attribute on struct
fields to indicate that a field must be initialized explicitly by the
user when the object is constructed. When an aggregate initializer or
uninitialized variable omits an annotated field, Clang emits a
-Wuninitialized-explicit-init warning (enabled by default).

Add the __must_init macro to include/linux/compiler_attributes.h (which
is included by include/linux/compiler_types.h and
include/linux/compiler.h) so kernel structs with error-prone
initialization (such as mandatory callbacks or cleanup handlers) can
enforce explicit initialization at compile time, as discussed at the
Linux Plumbers Conference. The shorter __must_init spelling, rather than
the attribute's full name, keeps annotated struct members readable and
was suggested by Greg Kroah-Hartman.

Note that Clang versions prior to the fix for
https://github.com/llvm/llvm-project/issues/232483 do not diagnose
file-scope objects declared without any initializer (initializers at
file scope that omit the field are diagnosed).

Also teach Sphinx (Documentation/conf.py), kernel-doc
(tools/lib/python/kdoc/xforms_lists.py), and checkpatch.pl about the new
attribute macro.

Link: https://lpc.events/event/20/contributions/2392/
Link: https://lore.kernel.org/lkml/2026101532-fantastic-deafness-e04c@gregkh/
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 Documentation/conf.py                 |  1 +
 include/linux/compiler_attributes.h   | 12 ++++++++++++
 scripts/checkpatch.pl                 |  1 +
 tools/lib/python/kdoc/xforms_lists.py |  1 +
 4 files changed, 15 insertions(+)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 5ab26ce89daf..baaa4035258c 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -203,6 +203,7 @@ c_id_attributes = [
     "__noreturn",
     "__packed",
     "__pure",
+    "__must_init",
     "__section",
     "__always_unused",
     "__maybe_unused",
diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 476c4c560d17..b9c0b56dd22e 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -322,6 +322,18 @@
  */
 #define __pure                          __attribute__((__pure__))
 
+/*
+ * Optional: not supported by gcc
+ * Optional: only supported since clang >= 20.0
+ *
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#require-explicit-initialization
+ */
+#if __has_attribute(__require_explicit_initialization__)
+# define __must_init __attribute__((__require_explicit_initialization__))
+#else
+# define __must_init
+#endif
+
 /*
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-section-function-attribute
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-section-variable-attribute
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b8b64f720191..6a091c45b1a1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6888,6 +6888,7 @@ sub process {
 				"noreturn"			=> "__noreturn",
 				"packed"			=> "__packed",
 				"pure"				=> "__pure",
+				"require_explicit_initialization" => "__must_init",
 				"section"			=> "__section",
 				"used"				=> "__used",
 				"weak"				=> "__weak"
diff --git a/tools/lib/python/kdoc/xforms_lists.py b/tools/lib/python/kdoc/xforms_lists.py
index db23fb650ea8..42956b98aae3 100644
--- a/tools/lib/python/kdoc/xforms_lists.py
+++ b/tools/lib/python/kdoc/xforms_lists.py
@@ -36,6 +36,7 @@ class CTransforms:
         (CMatch("CRYPTO_MINALIGN_ATTR"), ""),
         (CMatch("__private"), ""),
         (CMatch("__rcu"), ""),
+        (CMatch("__must_init"), ""),
         (CMatch("____cacheline_aligned_in_smp"), ""),
         (CMatch("____cacheline_aligned"), ""),
         (CMatch("__cacheline_group_(?:begin|end)"), ""),
-- 
2.56.0.455.g6c5a503b38-goog


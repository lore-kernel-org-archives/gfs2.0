Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140759;
	b=3wQF2YoBm+88oJdK1yLnvEMtZpq/Yk2YfvMrGg3MdZ1o1bOlqLXLbqi/FuyPnyvKsjBd
	 +U4oGwuy5GC5falzNQtRYQoavrSOQp7D7IGl04h/j8w3z2P+nQH+1MR1/AVYWkMOwqIB2
	 Sf7nDuU9pBhHMpShPojxlmQcRnhL0jTf8ggGjoNun+XZgtOhSOQX24yuXJyY/GNx7dhGB
	 rsFZZyhdtNK/AazJ09/Le7Uo9PPE6kAQhRaf7I+WDi2mNcOCcA60q9gh2hM1gCbKuMzzP
	 6MtjxDk+5e/y9wdJ9fvf4EwpP3uyc6EAurYKfKjWx0+ce3u/t0WmmyjCi45JCz9aAhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140759;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=kZ/TSWTZAJNbAAfYXfetESQgQ8bp7xksXUAoJHJHiFs=;
	b=wW2Mc7XybZ5sfj73P0pZjMX2LjmcyyQmJwb68U2nt33uNjMVkQpkpIIDeRgCbnSGOT5H
	 Dk+IVvdA6/ae6E4SUDLO5BEC53wWNDrC/1bH1DaL/kj5aCKTp/RABrC1/0yQKdNXEKQiW
	 y90lLIOnPoz076YEBCUtwruVd8UTtJsTss7FaHtn7MnI2TxEEsd+eMA+DRaKhbYWWLJaO
	 ombH0e43Qcs2WYejg6LLbfdemDBqfqvwKRQfLYlkPKnoNZyqwm35xu1Fqsd4QH6QcjDLR
	 +DcWQxwehHNic/GR9OWsenWynlE2SkZHyjDLfLWDIu/q0NsRRGJYyERRjLuz6Mat8vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Mg6i1pcx;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F82606A336
	for <gfs2@lists.linux.dev>; Tue, 27 Oct 2026 22:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79F82606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Mg6i1pcx
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-341eff9e381so708229eec.1
        for <gfs2@lists.linux.dev>; Tue, 27 Oct 2026 15:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793140756; x=1793745556; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kZ/TSWTZAJNbAAfYXfetESQgQ8bp7xksXUAoJHJHiFs=;
        b=Mg6i1pcxLVos2Lz2AQvsWhyoWlHAPD1tLMeApQyyTjo8+j5X1nx6d3efs48c0yVA9D
         1TjgzEsvQSxo3hBzmNkAUVVIvqglstrF2JWeAYFzDJ3wOOOK0UynajVQE0ZUU4C/M9xq
         KySAiFJmtpT6yCnNGZBdYdhJ+imNl0cOwYhJ+L+HAJuAabbFl17Ih9eY2sXOk0hJBlRP
         AfHFZ+sYwwVTPNoUS6/is+1mCX2JH8/PDH9pBo68NJfrL2V09w0/HQ9aOIInQlqDQ0/D
         R8tYEDPKQREvf93smv9l43QPftKFMFZoBRbpu+Kt45FS2y6MQR5En1csjlmFGIUk9ozh
         dWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140756; x=1793745556;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kZ/TSWTZAJNbAAfYXfetESQgQ8bp7xksXUAoJHJHiFs=;
        b=FQjL8azJ1GAIJDi7dn9jbuI2kVeD5jZDtJqaRdCJ+04chZxUJ2iKavvl51vgtkwKye
         m7uVcVjs//8JGRr5BPSVMUX5kgLK5XwvkGa9cghWj7QgCjRcYbb5O40UnsXWEg7oz9lS
         B2oJlO+IrOlJr6QQKCcth3N7pKkrp11+myCrVaCMys69dukEyl91xRTS0ySzDTzMarD9
         ON/g8gdwomFMi61diwAW+lk4kyRR+fWL2KsGkkWpsU5RxmCSrdAHg6ImddDOQXCL9BN8
         WEEu5fvT4rsY7CHqpgX/nyALfKhaQjidd0sg3xZU1bTYQOAQsvPngNm4aDVwD9Ztm9dF
         FX9g==
X-Forwarded-Encrypted: i=1; AKwUvBwojhTZvT0fHv2HScnspHRPVuouBOckzSYiNqt34SnalAasbW5hoonizhvpYIYsxErOcHsp@lists.linux.dev
X-Gm-Message-State: AFq9FYJEk0dqtR/Y216Xg1Wpa5wD9ZxjcdxJfzTwIV0n4owUXfh9c+H0
	4uu+gvIU+2WlNguLl5c6TH8lq2j8cGI9Cs+uhkkLXiXP0CYagV0QMeI+Z0dxOA2kF3aGmzC2uX+
	nbKXY+QgrJg==
X-Received: from dlbrl28.prod.google.com ([2002:a05:7022:f51c:b0:192:91:5cc4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:618:b0:19f:527d:96da
 with SMTP id a92af1059eb24-1a6cdd3e006mr1194989c88.33.1793140755024; Tue, 27
 Oct 2026 15:39:15 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:38:37 -0700
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
Message-ID: <20261027223847.652884-3-irogers@google.com>
Subject: [PATCH v2 2/9] powerpc/secvar: Add missing kobject release callback
 to secvar_ktype
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
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Nayna Jain <nayna@linux.ibm.com>, Eric Richter <erichte@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

In add_var(), a struct kobject is dynamically allocated with
kzalloc_obj() and initialized with secvar_ktype. If kobject_add() or
sysfs_create_file() fails, kobject_put(kobj) is called to clean up.
However, secvar_ktype does not define a .release callback, which results
in a memory leak of kobj (and a pr_debug warning in kobject_cleanup()
when CONFIG_DEBUG_KOBJECT_RELEASE is enabled).

Provide a secvar_release() callback that calls kfree(kobj).

Fixes: bd5d9c743d38 ("powerpc: expose secure variables to userspace via sysfs")
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
2.56.0.313.g2479322e68-goog


Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06FE5616BB
	for <gfs2@lists.linux.dev>; Wed, 14 Oct 2026 16:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996274; cv=pass; b=OVYQk5ywIxu7Qfy2I0VsOMTRU0iG5zU0vBIOA+8vjQTPE6uX029lxjeu0034E/QC3er+piUxHN2n6dQz4QQDgAmOsRGTAJt9Puz8dF/y2ZSRh9VYf+cZg48o83LMxAiRZpUVvxiJlHLlnS70QFSjcn/DrAiZqUvKqMVV3XYQ6NU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996274; c=relaxed/simple;
	bh=lG5fR4/c9rTkKwB+dH11HXxHn5DhiwcqDirk4k17QlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBDomy56JEj/XYTvkoab6gapc5MTyaHl2+H8UD3EJi86JVzxmOxNMAUYGAqrBlhaj30CNaDYcwv2RTJXSJE0j/11xITf9XmsZsVBOMZF1hmkMXXe2gK+rBg7mZFjGrFZ5uOnb0ZICl+iJIdITfWrG8xtxYaLB3vwPEmisJSk0LE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBS4jdS5; arc=pass smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBS4jdS5"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-33e623bd651so514493eec.0
        for <gfs2@lists.linux.dev>; Wed, 14 Oct 2026 09:44:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791996272; cv=none;
        d=google.com; s=arc-20260327;
        b=d0fNj8Sec2rMBnyNPcIOU+9wgrWliWr+Hui4eV3JxWlfO5WWzZWsRXqYCsb2UpPr4V
         GWCMbxfeTlcVxN2+Lckq79cQVfRMn3JX4B+RmmN00MrFI0QZDUtKc1QtOf2tWIZKbUHx
         foKf0/QoshH3Vq2uDBw3Gvh41ahWOa+S94sDo8rw7LIi63qBQhJ3JLA07hJaB93kJfQX
         XrCsTbVS06yMImwjdhQLMaVR1RjdGxljXopiciTkVPYD8E+lhwqgcT+5x5aVOBbmTaaM
         c0AFMilkB9NTj68J9DCTjqstHL38HdamTAWiP4Pxpn9N4Vs1Q0W7nKscU/Gl9dVTnyrj
         c0cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lG5fR4/c9rTkKwB+dH11HXxHn5DhiwcqDirk4k17QlI=;
        fh=uCjwE+3sca3vOXnSsYCxnFyvEFhG3HReO8RvEnUxJUQ=;
        b=Sn8a7l34W9FKAus0SDlsATsJ6DH9vl2Jynd+MtHjcHCFr/bE3wLeBaMK1c2Py2mQap
         CUtJEm9GO52MGm8gdmfovgayZWJ3wvDGDL/ypqF6ops8MGeYBD99uRyiuzMArhRy5pb2
         bBdIu57g84RKWGW8FMv4csX2yYzCYK8eSFDWAASzXHwKqvfv3cgmYOMUubu39lmEqr+B
         g45YAsb7wjhItB5VqEXIdW3/BQcGvEW2JkLmi+rl/C3dfBeSWfRvZo0EYqOQMstSE3SF
         OivR/BYAI8koIfCNyZpFrLSV2P9L3YU4eURVpYPvKZIHCNRzD8kwUSAQttKfbjXXhkOC
         a2FQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791996272; x=1792601072; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lG5fR4/c9rTkKwB+dH11HXxHn5DhiwcqDirk4k17QlI=;
        b=VBS4jdS5WV9790zJVyEB8TzU8ZrMJfWBiLp2perKzjibEIRElf2PVgFKxBoWwkE1Tr
         27FPX8tZDhOTxCKppFz28Z8JIQb8PCiQWJNMWrZrKt7bCIj2a83pUxT5fmw1A9bQl6yH
         gu0emcSoJdxQ3pCdzmMYyxw5ehsbV6OYL6ac9/dSUIEUb0hQBys28MvZfV+HrrNvwBDr
         aBw/eBi6vRxFl26eH3stZ0PpclqWzDkVc8kbAvKiFkKVg6xjKCv7UbFlfdh7/etwxY8j
         m3ifU41cSiLL6+6wT6CHtBo/p18D87qZ7R4Ko0TOj3RiPFB0y2oOkOxadlZmbRSSgAws
         +EXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791996272; x=1792601072;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lG5fR4/c9rTkKwB+dH11HXxHn5DhiwcqDirk4k17QlI=;
        b=dbsTwtegVCAEeNdv37bjxPSSJ7P8g7ljfdWb3ZVz1p5qDi4qJ0uJQUj8u/KUr625gt
         pqCpM30XAu0oyEnLaQGG+M2S2bRN9aMdMRuSLdh87ZWUfjOdc1KMiJAnxjx1nAaN37jp
         d+dRBjiozYtrtVA2LQw/yTPEzXC7wzw5y9BQ0ROfylMILUgUhW5OzDeiZUL/NcTEiQZH
         ZHQiUpAwjrV1fhOEDt0tzD/amdummN3PLzj++i866XTbOt8RGxgeE44H8EOw/CPMvDW7
         nVaSzpTAcUXZy//N48RdsLsOqK77K6XYvcwEnS6Ee658bt9tHAgumlcu9ozrTfUPsjC6
         zTtA==
X-Forwarded-Encrypted: i=1; AKwUvBxJX0WeuFnogtw4dpOVBiZ2e36W5ikCf6NWZ9Hik+DGRCJqvnjG607/D361lt4MrpSJE0ix@lists.linux.dev
X-Gm-Message-State: AFq9FYK6JpPFK6+J99PMhnptHyiYKQuyi19x1mNkJJPPETTBeCxnCgqz
	8vp2baX78tS3EpUVs5BeWn4F07QEsWvEdHeyixNnrprnmHz7WmXH49lJzfJ92/WOW/FkVXz22+g
	a77/pcFyqMmPKQ58MVCs67h02Gtb1rzU=
X-Gm-Gg: AYBFou2ficntkQV+IMW2j3gmMaOpNEUB4PvZIlbX2tYdltW7jJ88+3pshw9aLO0xY6N
	SoR+v+356S2iONVFTyO1xxvoP+jkHNquxriOCwniHytPJurUT7hAADAyAvJhbG1h6YHK+Q9IP4B
	/JRyiUUKu1M+9NHDTYFJJ1UzkDbXCdnqjS8vn1uPgPGUxLOhuGTUnJGoI1nxct33Ic3pLOHEXvQ
	KwnFGq1yjKgwaW9IqWbGQZCCGv57dd+fMHXVEgSCTfAr97NDeehP3N+Y7TxfMr2c+RZ4syry3XK
	BPiCGFUilJLsru/83lvOBONNXrWP05aArw/BmDbOzGJCRH1G1ViXruDN7jjJ4gksFp8yB9bQgaX
	zdua6kk2k5JCIHlRW2Iwwi2XsyvB99d/INx0UelH04yPhMCiF3zASJ9xlBXk5bvj4PQuOJt0OFO
	2wr8zIARXCZCo+Je7osQiMJDRXOA6xdYjY8Ije0vMPtn3IDudFAK4=
X-Received: by 2002:a05:7301:5413:b0:358:c9f3:b055 with SMTP id
 5a478bee46e88-358c9f3b260mr28158500eec.1.1791996271702; Wed, 14 Oct 2026
 09:44:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com> <2026101425-why-boring-4f2d@gregkh>
 <202610140932.5F9CFCE5@keescook>
In-Reply-To: <202610140932.5F9CFCE5@keescook>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 14 Oct 2026 18:44:18 +0200
X-Gm-Features: AclHuK_d31yoge0njHjovdIQh7JfJY6W-PLjzMLBq14NjY-schAqigzEJUAQwG8
Message-ID: <CANiq72=4WQ1B1oCSW=69u_Z=FFLE56hYCqDwWr+poQdzSTS31A@mail.gmail.com>
Subject: Re: [PATCH 00/11] kobject: Require explicit initialization of struct kobj_type::release
To: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ian Rogers <irogers@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Viresh Kumar <viresh.kumar@linaro.org>, 
	David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
	linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 6:37=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> I'd really like to have the attribute available, and I've got at least
> one user I can apply today that don't require fix-ups (seq_file), so
> if Miguel is okay with it, I'd like to snag patch 1 and send it with
> my seq_file "first user" for this coming merge window so it's available
> starting with v7.4-rc1, and we don't end up needing to wait 10 weeks for
> other subsystems to be able to use it. And the kobj fixups can continue
> in parallel. Does that sounds okay?

Of course, please feel free to pick it up (with the small tweak I
requested) if you have a user.

And if you don't pick the user, I could still pick the first patch up
through the compiler attributes tree if you and other folks want to
use it after -rc1.

Greg: adding the attribute itself should be safe and would unblock
others that may want to "protect" themselves, without having to wait
for every potential user to get fixed (but of course I agree they
should get fixed -- we should not forget about them, if that is your
concern).

Cheers,
Miguel

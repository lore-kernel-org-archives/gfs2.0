Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793652799;
	b=meepMdn8KavlGEfOt3ubZjflOQDFdVBU1UGlXI2FoidkOWHjmY/iXbvFIx2t5PuVeTzk
	 TiIso84xr2E31l5VJwk2ict9Gs/5mxFf7Gk/hoPj7q1yJDMJLMM+hBwcA/kaHuvbRJC4V
	 yYprijwhJVR2+8w3GnpJSvn79MkNRUyP67J5TziTtJmuhv/Yef7yZDwgIKOvUM32ff3DU
	 U1gxvwz1tOogKSKxj3fn2iUFvJPwggrC67tLOMf04IxGiC7DBToFDC8dUwNwLmFDYTwIS
	 Z+u+loRm94hqnKqr/yRFTMtQl9dG5hTKAiSO3bNybP5mKIQWSSRIVc+oTZQ6qaGfgug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793652799;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=117yBiLwKENKL+3PiWG/U5OMCVmGd5cgD5S+cpkVimE=;
	b=FAqZNKgGM6vsU2SexTuW0TRDV3NlYKV63romJ1cJd7Ubng+e+gVsboXR2C7+VFJmTIOh
	 GQu8nRZBKWlsDMhipeLvIBGETDlYE6So3IpWZNMYKqg/zBjAemIXQybT/03y1HZH2DZoT
	 x7mXwwHPGwsY+rYRiBsinQWRj9ZWobvA2SR8+lN1wJviQhfAtGiROmlS1e6giDKdHxdKB
	 FQkWcEvcR7TEsztjWyoyITho8XK5ySlPK5ZsUo2fogdhFwuN8/qe5zZX0DcbKXJz5F4oD
	 t93LWZ9y1AXOujeRdBPunX+qJHOGze/YwmkgNmz3/C4i7mmJkmiZzLEFR99HDPlWP6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JrjqNRqP;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FFA606A32E
	for <gfs2@lists.linux.dev>; Mon,  2 Nov 2026 20:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21FFA606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JrjqNRqP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793652792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=117yBiLwKENKL+3PiWG/U5OMCVmGd5cgD5S+cpkVimE=;
	b=JrjqNRqP10lz+xwTaT1N5hOMraQMewbNcL6ZPtYs/6qBeMDZq5lyggz1hz5TUE2wvCqKwM
	IXQbQRbVn/7mLpXXty1C0A86MwLFP717upzSrzHF5Nt1PiF43MqFrw00/Vf94oFs2+EMGE
	o+EsfhfOm9/h5ijPwHR98WSryq3gxtk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-q3iazR8DO3eNbdkJMb5xoA-1; Mon, 02 Nov 2026 15:53:09 -0500
X-MC-Unique: q3iazR8DO3eNbdkJMb5xoA-1
X-Mimecast-MFC-AGG-ID: q3iazR8DO3eNbdkJMb5xoA_1793652788
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-3ab3fc6e459so290201fa.0
        for <gfs2@lists.linux.dev>; Mon, 02 Nov 2026 12:53:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793652788; x=1794257588;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=117yBiLwKENKL+3PiWG/U5OMCVmGd5cgD5S+cpkVimE=;
        b=Fkh4t7lvXYsRb4VQioKBTfwAAiXoXtRKsRTVnuVmh9fFZLh6W7cz5gjwWxoKmtvP/h
         iYJBTIVkBUKvgDL7itZhGDy1ktEM/vGu42zLKBuaADEl06bxgvqDpedqdqjxqWmPjo6t
         SM4LAUYcEr0lB+LB7R0G4S0/wXrwcF3zH+PLH07zFQOBeeefXD39ubvh3BrwtM8TS7aG
         eissAa0rtwaXKauvwHokkmgAzqLfd1m82SSkCcSiC0IJlFAw0zZj8gGbciAF3MhgNVyV
         aVdowdKobSYw5whItx+CR293YUjJ21j9Z6QG0iaC9KI7rs0UZsPQ3CXDuccmpeJi3eaT
         6THA==
X-Forwarded-Encrypted: i=1; AKwUvByxyBRmZKySWNp9uzocBAgs3wGgitKViaeh9mCweQjCsjjDrHajkHEa2F5fz5KsVsw6reaq@lists.linux.dev
X-Gm-Message-State: APuU4Z99bI25NcFzTjvDX2PaFX/ELhkpAJ/Q8evFYW/O6NHkQfv4PidW
	ImVjDuKpXoOd0cHWTjrPjFI6fJErdVYXDhb/ff4xAI/AxLX9ItmSkYZ0SOIqsFkwtnz4wkVaS9Z
	TDVoV/QQ0Eq0kjgTyjk6X5pOz1E0pRHDjUYTDyp3orpD+Pk9jJLS5FOWOgCLzCcMYhYkEl7IIcG
	fEfFO6mXxRcqxGdYGFjIUlgyM+UFUnsQ==
X-Gm-Gg: AYBFou3tF6n5q0ZT3iRaS5+Yon4httO0njCWnLIFf2KY+RyV/Ckxjeew63lcEDzgqiY
	OWP6scVpwIm8zgQ/GKQe1iFC21ZuLJrYMudZfuMeSBSqhW6dXbR2ebvN9AMn/9wUp/w7gR3+K0q
	hH8HL4OJNq4jzbt0ILRzVIQMRILehqBnBl8Lb6ydv2MKfSihT6a3B1TAxP
X-Received: by 2002:a05:651c:a14e:b0:3ac:4b79:573b with SMTP id 38308e7fff4ca-3acb7aa83b1mr20499341fa.13.1793652788291;
        Mon, 02 Nov 2026 12:53:08 -0800 (PST)
X-Received: by 2002:a05:651c:a14e:b0:3ac:4b79:573b with SMTP id
 38308e7fff4ca-3acb7aa83b1mr20499011fa.13.1793652787872; Mon, 02 Nov 2026
 12:53:07 -0800 (PST)
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261027223847.652884-1-irogers@google.com> <20261027223847.652884-6-irogers@google.com>
In-Reply-To: <20261027223847.652884-6-irogers@google.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 2 Nov 2026 15:52:55 -0500
X-Gm-Features: AclHuK8pGzNf4aGPekLa6NQcs521xOugw8djA3E8ZMCjZ7yn89XzG5j_wIaQNFk
Message-ID: <CAK-6q+j-MS_5St04YFU11LG_Cjf1jOuS3q33qk_iK=7TE-iuBg@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] dlm: Free dlm_ls in kobject release callback
To: Ian Rogers <irogers@google.com>
Cc: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, David Teigland <teigland@redhat.com>, 
	Greg Kroah-Hartman <gregkh@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ohi1sTbVHF_DSwQDzGaSjz2D7suG90AXYn9PGEt4qDM_1793652788
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 27, 2026 at 6:39=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> struct dlm_ls embeds a struct kobject (ls_kobj), but dlm_ktype lacked a
> .release callback and dlm freed the lockspace structure directly via
> kfree(ls). With CONFIG_DEBUG_KOBJECT_RELEASE=3Dy, freeing ls before the
> delayed kobject release runs causes a use-after-free, and unloading the
> module while the delayed release is pending results in an instruction
> page fault.
>
> Add a completion ls_kobj_done and dlm_ls_release() to complete it when
> the last kobject reference is dropped, waiting for it in free_lockspace()
> before kfree(ls) and in the new_lockspace() error path before module_put(=
).
> Also delete the kobject via kobject_del() before stopping dlm_recoverd
> to close the window where concurrent sysfs writes could wake the stopped
> recovery task.
>
> Fixes: 3514faca19a6 ("kobject: remove struct kobj_type from struct kset")
> Signed-off-by: Ian Rogers <irogers@google.com>

A somewhat "big change" for just a debug functionality. Althrough I
agree we shout call "kobject_del()" early to avoid additional sysfs
changes during removal.

Acked-by: Alexander Aring <aahringo@redhat.com>

Thanks.

- Alex


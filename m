Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C7945F63
	for <gfs2@lists.linux.dev>; Fri, 22 Sep 2023 20:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695412994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zU1ePHAefeFxTXZM8u/psnUpZJDPZqr4P4dFF5GIDXg=;
	b=Kez8XWCZ83vUbz0HiC2DwpOpjNvEagNJ6kjrLOrpiYXupCsFlA3WWU+5H55VFoF+p4ZJb/
	spQhxFXKCA/WaXdAaMW2e4C9CYKA2GzuLL+Cf+ur0uaHftoWFun4vSXdebt/37LcNSPgML
	1XA5hWtakEQG407PMr37ykql1nat6K8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-eGP6GQ6aOa-noAI9sA6L0A-1; Fri, 22 Sep 2023 16:03:13 -0400
X-MC-Unique: eGP6GQ6aOa-noAI9sA6L0A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30e3ee8a42eso1688714f8f.1
        for <gfs2@lists.linux.dev>; Fri, 22 Sep 2023 13:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695412992; x=1696017792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zU1ePHAefeFxTXZM8u/psnUpZJDPZqr4P4dFF5GIDXg=;
        b=H2Z8/SeVbLl28wXE7KNTl6rdepjotH6tr3/IHlKsfmSMjmmUUkC3qv5N9DYvE+FgXu
         AywVpW8Ee1bmSQ2z6yCzfYs/XtBjQecwlXgbICo1ToQ/rMD1vVoWs2uRKemf0xJqaZpI
         y+5N2YSuiJHhNOMX5eq2WrDGE2q8/AAqgq4QvuURLUoB7lZ1bnEGXDbM7U+u3QZm6p1g
         lKx/0vEcp8/MqN/gs1EmEKI6T9wzWAXsVsugFBWO3WK3+qZW+jloCcKjbKVWL8IAHXRy
         R/HdDduhpxMbakdQssn4JAQg1uElLF95iIry8AMiGwnHnnzwba9EtgXJWzibWrQPQGTE
         mfJw==
X-Gm-Message-State: AOJu0YzDdmwYdWBh5FbnPq0ErP1/gROP9XuTO0HQZs/bej7MZAC3S73H
	lYkjxLOGIZeL1zujU2UZdC/znYBGlmNOtinDnlXJeWIm2Q+Fb1N8XPXTGpMDVTPHRGPJEQtRWTF
	pnBobSz0DXXthKQbMt0TWsWgop9ufjw==
X-Received: by 2002:a5d:634f:0:b0:314:15b7:20a5 with SMTP id b15-20020a5d634f000000b0031415b720a5mr527254wrw.54.1695412992193;
        Fri, 22 Sep 2023 13:03:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTZl6rkhr/PiUOUiLr+kSFy/3mY+COZ4tNEWDsl/U+LxS1XkQWhOSTYt8+bj43ud44/d0uOrILQ7qwJNK57cg=
X-Received: by 2002:a5d:634f:0:b0:314:15b7:20a5 with SMTP id
 b15-20020a5d634f000000b0031415b720a5mr527243wrw.54.1695412991901; Fri, 22 Sep
 2023 13:03:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1695403360.git.christophe.jaillet@wanadoo.fr> <6083c5d6e7e4eb567bf6f5cbb5bdf6b0286cee45.1695403360.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <6083c5d6e7e4eb567bf6f5cbb5bdf6b0286cee45.1695403360.git.christophe.jaillet@wanadoo.fr>
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 22 Sep 2023 16:03:00 -0400
Message-ID: <CAK-6q+ifLNmM_nT5MGy9SPAmx61=AogkyNsGw=yPdYPsUsFcyg@mail.gmail.com>
Subject: Re: [PATCH 2/3] fs: dlm: Fix the size of a buffer in dlm_create_debug_file()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Christine Caulfield <ccaulfie@redhat.com>, David Teigland <teigland@redhat.com>, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 22, 2023 at 1:38=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> 8 is not the maximum size of the suffix used when creating debugfs files.
>
> Let the compiler compute the correct size, and only give a hint about the
> longest possible string that is used.
>
> When building with W=3D1, this fixes the following warnings:
>
>   fs/dlm/debug_fs.c: In function =E2=80=98dlm_create_debug_file=E2=80=99:
>   fs/dlm/debug_fs.c:1020:58: error: =E2=80=98snprintf=E2=80=99 output may=
 be truncated before the last format character [-Werror=3Dformat-truncation=
=3D]
>    1020 |         snprintf(name, DLM_LOCKSPACE_LEN + 8, "%s_waiters", ls-=
>ls_name);
>         |                                                          ^
>   fs/dlm/debug_fs.c:1020:9: note: =E2=80=98snprintf=E2=80=99 output betwe=
en 9 and 73 bytes into a destination of size 72
>    1020 |         snprintf(name, DLM_LOCKSPACE_LEN + 8, "%s_waiters", ls-=
>ls_name);
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~
>   fs/dlm/debug_fs.c:1031:50: error: =E2=80=98_queued_asts=E2=80=99 direct=
ive output may be truncated writing 12 bytes into a region of size between =
8 and 72 [-Werror=3Dformat-truncation=3D]
>    1031 |         snprintf(name, DLM_LOCKSPACE_LEN + 8, "%s_queued_asts",=
 ls->ls_name);
>         |                                                  ^~~~~~~~~~~~
>   fs/dlm/debug_fs.c:1031:9: note: =E2=80=98snprintf=E2=80=99 output betwe=
en 13 and 77 bytes into a destination of size 72
>    1031 |         snprintf(name, DLM_LOCKSPACE_LEN + 8, "%s_queued_asts",=
 ls->ls_name);
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~
>
> Fixes: 541adb0d4d10b ("fs: dlm: debugfs for queued callbacks")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

there is a similar patch [0] already in the queue for dlm.

- Alex

[0] https://lore.kernel.org/gfs2/20230906143153.1353077-5-aahringo@redhat.c=
om/T/#u


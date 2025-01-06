Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA33145A03
	for <gfs2@lists.linux.dev>; Mon,  6 Jan 2025 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736180092; cv=none; b=K3z0Y9eIxWYeRKKCFtZ8iGzPwYtogoS20N8sFzdHUTB2r4AfiA2gCqZUG04bGhan9NhjYzuQmGrOgp8vGn4O5Uad8akEKs5fUzkr57AKoI1SkH4NcIx61s3AmMLsyvlx/9qKCe9FFIDABJ4sK+eeRxbxTf5raomFOGt882IkpgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736180092; c=relaxed/simple;
	bh=4gH5vg5bB5wTfW1M64h2FddmzPq8PIpvlukgOc+ckoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HU5YuqRpuy5zs/rQU0wQ6EmhMAUFip78u7Q48FTLpS7fnD/zHr/J/Y3+tGhPajXuG/96Jt+iN78GHRgHRPEZVhUKXVUGRsY6DYp+tRJc4Ap0Nn11/iV7sETRh19uhXGuXx7hKoTDtAo3xZo1gJzKAG/T2ESq0j70bA1xYmqZIiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cx99+8tt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cx99+8tt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736180089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4gH5vg5bB5wTfW1M64h2FddmzPq8PIpvlukgOc+ckoQ=;
	b=cx99+8ttRCJfvvwCp4x7xgkf+PM5wCzM29+f6N3WPB6AK3ICHelM45Mt3D0M9iZ1dPpqqf
	RqdG7QIghgWVYCF5eHUjS5g/vGpq6jMg9VbgnnSBdhfGXaLa9cb4SpCiGYbc+phz95pAaJ
	pTVtLYAWBMSsSgWRWHODSe2HZI67/Hc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-ObFidHzTP2C2lAPbu3WEGA-1; Mon, 06 Jan 2025 11:14:48 -0500
X-MC-Unique: ObFidHzTP2C2lAPbu3WEGA-1
X-Mimecast-MFC-AGG-ID: ObFidHzTP2C2lAPbu3WEGA
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-30041b60c83so75818421fa.0
        for <gfs2@lists.linux.dev>; Mon, 06 Jan 2025 08:14:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736180087; x=1736784887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gH5vg5bB5wTfW1M64h2FddmzPq8PIpvlukgOc+ckoQ=;
        b=YHqD+TdFVMxTI35+rRLiZmDNcQVuwrX1LlLbEnWhPizBNRxETBFLMwSNxvKeoeG77K
         2RswjBR+6R37XZdOHTXjRC0Lds2gn201Sa3nBbmw5ZZZ71lNhNUKGyuuvEEz+oID53D6
         5vskl9YKkGDrkckqgcSvgYUUgoiWNhkWp8031J2XXf0tDYk5EuBnTrtm7nVn90n3CZpy
         d5Yg3JzDoVmijGkNBcAEsGJ3TFoZOp9pU37mZyA7mpZpig25hUinUcYV/yO5kDEc03Q0
         EoaI6FEWHe+I4ak8c7YhPmD1NWEyjkIKuOIwI7RE7oD+khQ2WP8BQUNSCXooqufDQ6a+
         VE3Q==
X-Gm-Message-State: AOJu0YzIoci7C8bV7qQSysJtrTlgJxtU27FVa91vUEHhvCLul+mNlYRC
	zMbTpjNTMBavBnyzAeVx/AqnmR9JRgKuWF5stwtnlAmbmJCVgOIeDaB8j1Bpqq8rVAhEoXHQIsp
	nuP5beSraUxYJqzNEoA/6YU5Z7E6++xIJZD7DlT8mW17xTcgDIvgyNRi0+YgwaKmrloWUS2358E
	v4Qwa85gLq0C4O0NSHzIeqNU7kDQ==
X-Gm-Gg: ASbGnctvIPHJer+OEFN3Urs4pu21yj0gOfdSQKlsZGIAcfd/9zRTF0sIz8xfleYdfSX
	+b3O9KaIIHNgvqwpleju4Kp2R1oJkj6LE429k6bwDnhDczJM8AgevsJ0BTzw2JpoVedvqR7Yf
X-Received: by 2002:a05:651c:1a0a:b0:300:3a15:8f1f with SMTP id 38308e7fff4ca-304685c2ef9mr230346741fa.32.1736180086880;
        Mon, 06 Jan 2025 08:14:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlUF5JEED51prd/SIzEeG1h4Gi82C+XcVG7Sam65NRHkSbEm9m0LL2aZKcyOnjlk0KXyuLbQxsxP9S8WAbxSg=
X-Received: by 2002:a05:651c:1a0a:b0:300:3a15:8f1f with SMTP id
 38308e7fff4ca-304685c2ef9mr230346651fa.32.1736180086499; Mon, 06 Jan 2025
 08:14:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241220141913.1346301-1-cascardo@igalia.com>
In-Reply-To: <20241220141913.1346301-1-cascardo@igalia.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 6 Jan 2025 11:14:35 -0500
Message-ID: <CAK-6q+hV41=KuZfFUpmJgm8YX8GVxoWZKiA_gGNHWXopt2VpBA@mail.gmail.com>
Subject: Re: [PATCH] dlm: prevent NPD when writing a positive value to event_done
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: gfs2@lists.linux.dev, David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org, 
	kernel-dev@igalia.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZqZS6ALudAvi2x0apk0gMqRcSHpj20rrDC-8UrLCBKo_1736180087
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 20, 2024 at 9:28=E2=80=AFAM Thadeu Lima de Souza Cascardo
<cascardo@igalia.com> wrote:
>
> do_uevent returns the value written to event_done. In case it is a positi=
ve
> value, new_lockspace would undo all the work, and lockspace would not be
> set. __dlm_new_lockspace, however, would treat that positive value as a
> success due to commit 8511a2728ab8 ("dlm: fix use count with multiple
> joins").
>
> Down the line, device_create_lockspace would pass that NULL lockspace to
> dlm_find_lockspace_local, leading to a NULL pointer dereference:
>

This issue starts to be an issue since commit 4db41bf4f04f ("dlm:
remove ls_local_handle from struct dlm_ls"). Before
dlm_find_lockspace_local() was then returning NULL and
device_create_lockspace() returned -ENOENT as it wasn't found a NULL
lockspace handle, see [0].
After the patch it dlm_find_lockspace_local() will end in a
null-pointer dereference because we don't do this lookup of pointers
when we already should have this pointer already.
This behaviour is kind of weird (as it makes no sense to lookup NULL)
and yes, I didn't see that when I wrote commit 4db41bf4f04f ("dlm:
remove ls_local_handle from struct dlm_ls"). Just this commit signals
us we do something stupid with the error handling.

May I ask you which user space software do you use? As for
dlm_controld I can't see that there is a positive number case for
telling the event_done attribute. [1]

Your patch is fine anyway as a positive event_done should not be
handled as an error (so far I can say that from the current DLM UAPI
spec). We might need to review the whole error handling here again as
the caller is only interested if it failed or not. Even kernel
lockspaces clear positive error codes to zero whereas user space (our
case) doesn't do that.

- Alex

[0] https://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git/=
tree/fs/dlm/user.c?h=3Ddlm-6.9#n431
[1] https://pagure.io/dlm/blob/main/f/dlm_controld/cpg.c#_1811


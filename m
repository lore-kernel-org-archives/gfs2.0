Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A100C1ACEDF
	for <gfs2@lists.linux.dev>; Sun,  8 Feb 2026 12:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770555330; cv=none; b=h9Ir6kKTUAYTzicUtStm2sNBrTpoyPTF1iB3ZM6VkleqkDWixXx2bgA5tzZJVGeyjinPUrbTCXOxzonbngIqkV7LU2WQCwVnfhWigMw16dx6zC/lmG+fOgPlnvlXXCG2snUl6H7sxdqzIU/DJCcehdM92KEacv8j+6uCKLvyU8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770555330; c=relaxed/simple;
	bh=lbwpZDiJ0RubAEN4iV6JVLxvcDGJBPXS1t6V3HXk+cQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GcILsf3T4iyNatCSGDYnwnRoW56RTMx76p+ioxYXxm9/kq8fJAtwfe+bt/LyP7Xi31seNELgVik+R9aiY2Qeex7Y6ZNNSEzXtXZok04q+EZbfmG4O3MOs53kf7QqhMVuMEL9q9XkfR59VN5ecZ1h8YLpu08FeOapO7tD8+aUksg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KKvFUSAv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KKvFUSAv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770555328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lbwpZDiJ0RubAEN4iV6JVLxvcDGJBPXS1t6V3HXk+cQ=;
	b=KKvFUSAvK4pD/ANAo+/IZDqJB5YTtOzHFFukV4fTSafx7ZfKC/Pv8iAcAJcUstY2kkquo2
	OHQqOnGmhT6gEQbey+B6GIBWpsaHD3RDGIglcv7r/aCfZTU5TInI1G14d5fezrCW9YLmv8
	8RPYjOa1NnkGuHlyY12kG3auROCosY8=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-1oyzAeFBOaijMygN_OG7Pg-1; Sun, 08 Feb 2026 07:55:27 -0500
X-MC-Unique: 1oyzAeFBOaijMygN_OG7Pg-1
X-Mimecast-MFC-AGG-ID: 1oyzAeFBOaijMygN_OG7Pg_1770555327
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-64ad4fd4257so2066215d50.3
        for <gfs2@lists.linux.dev>; Sun, 08 Feb 2026 04:55:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770555327; x=1771160127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lbwpZDiJ0RubAEN4iV6JVLxvcDGJBPXS1t6V3HXk+cQ=;
        b=H2wv4431VIZsGk8+DA3IzUjicMc/n4tszaRvHQ/4W4EgiY1w+sdDp4Lb2kGUpnHETR
         Eh2SzKrkDg+pULU1MptZaIfo1N1JsKqITusmnA2+zzCUZrD+wVgR9k0PGHiHfZz7fgD5
         NI39/+p6H9pjaeUtquDOoDFYwB2m8pC371wFd1S3uaCcS8Lj2aZ3jkCgxrcd13AQgxFh
         DKI7tfESC4eeitgXY++wkuEGMYcFgHxKuy+9ZAvNuJZhws74L5J+O15KCF9IMZ3MZfSC
         efLMCqMFYYPdR5fA6A9VSrtjA6fRDj4awdi2K0MPIZsB62SEtF/r/VLWhwfM4l3Gbjag
         ddtA==
X-Gm-Message-State: AOJu0YzjT/01OcAqdLVMHcvLJFwJHTlf0hz8WDiyM3ADW6Cww4RNaPoP
	CSqhWQx9WvJCwALIQxk2MBclcxvJ31CSMxCEMnREBzKMelUzSmKtCwDRa3akhUJ46m78yB5WQ4T
	HALZLr/dAXCh3AIjQqCUNZgBSldBTTMxyPUurLObP0FmA/S5kKUYsjMZ14w/lVohtCQPUvZysQg
	SPqjplNll3ZpDfjSA8N2wrqs22mfaLqA==
X-Gm-Gg: AZuq6aIkkRuUuDcpXqfF476n1EA6JmBms0lUb77uZAB9/Hmg8/fO3N2vK2EnSRUiDM6
	dkKtIv37roa+yhYCYbR1cpAFPZp72weyohhqBxMKVpWNSP25R4pZOzBIQrIvtErH97Y9E70mDRU
	b+f1gBpomNj+YdrWCcp9ntpBi05+3gvaHrIb/sqYfob1YKH5vbv3W75dU4lgeR3NzFZ7cTndURw
	8eic94uzi3SKWQjnPBUdOs4AmQ6gzaWuf/hObRd1UNMFPmcUcbTzw==
X-Received: by 2002:a05:690e:1186:b0:64a:cdcb:95a7 with SMTP id 956f58d0204a3-64acdcb9819mr6791238d50.22.1770555326864;
        Sun, 08 Feb 2026 04:55:26 -0800 (PST)
X-Received: by 2002:a05:690e:1186:b0:64a:cdcb:95a7 with SMTP id
 956f58d0204a3-64acdcb9819mr6791225d50.22.1770555326441; Sun, 08 Feb 2026
 04:55:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260205135318.5346-1-wangqing7171@gmail.com>
In-Reply-To: <20260205135318.5346-1-wangqing7171@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sun, 8 Feb 2026 13:55:15 +0100
X-Gm-Features: AZwV_QiP2TzJbgMyMedgJDgLc1ksYHBK9Xd9m91Ug6I-9L4WOOcZxwBAbNWvBmc
Message-ID: <CAHc6FU6qN_ddCOMpkdow4k21=DjzhUVdY-rgy-7Zb8_SwTz-bQ@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Fix memory leak in gfs2_make_fs_rw()
To: Qing Wong <wangqing7171@gmail.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+e57495fb65020ac7bca4@syzkaller.appspotmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ks2Xp_J2SywGMiKg-4-vO7Fh-hsl8-TBden4Mva11vY_1770555327
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 2:53=E2=80=AFPM Qing Wong <wangqing7171@gmail.com> w=
rote:
> From: Qing Wang <wangqing7171@gmail.com>
>
> If gfs2_quota_init() success and filesystem is withdrawn, need to cleanup
> by gfs2_quota_cleanup() to avoid memory leak.

This is already taken care of by commit da6f5bbc2e79 ("gfs2: fix
memory leaks in gfs2_fill_super error path") now.

Thanks,
Andreas


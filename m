Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F50FE579
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 22:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7UU+N4S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698876395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jAzM3pOoT7hQ4jm+lXFrfYAdWH+vbaVmh3FgC8WXiPE=;
	b=I7UU+N4SQ3JJ8zocv5tb2OMGsDsNb+iXcA/fxXM4WYTkLdJETDPxdQ53T+ARhrws3DcUkx
	Y7wUuv6wukOpu2i3IPHcgHicfuO9agvuv6/fQKAqsZOh0f7VtocPbXe0Gil/4OcmigZXxG
	tLnaafYDsr17NUHRFIkX/q8V+0h5gfg=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-BNsHfQDMPD21zY9vLakMkw-1; Wed, 01 Nov 2023 18:06:33 -0400
X-MC-Unique: BNsHfQDMPD21zY9vLakMkw-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6b6f4c118a8so339762b3a.3
        for <gfs2@lists.linux.dev>; Wed, 01 Nov 2023 15:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698876392; x=1699481192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAzM3pOoT7hQ4jm+lXFrfYAdWH+vbaVmh3FgC8WXiPE=;
        b=Rorss1pn4jHx6yEV3F/2BpqnUXTzeonicw8kXrR87tgjMa63MRGQjWx3Ku6d6hAGgL
         NmVefeokeqaXM8VETkUK9DkIJO4g4RS1qRgug7XzoHKynL5JEt4Dgw1cJ6yQcG6K+ojF
         grlieULAxVRDZOUcFHoe+Hb5Ovht3ESujB3zRUD5yRx58JGQNGcwMGo5itBlryIneIRr
         l7xOkSglG1sNucupz7eJKx9kFSjVtRGrxC78fR/r7DuFTQfPvyttVj9IZE05InNOYqtV
         lv3Tw7ho4len5Oiei4w2BXNIKqaNDI8vjrn0KiTGvElioEKq8kXvU+GroWYg+rLjqFbS
         ZFmQ==
X-Gm-Message-State: AOJu0YwUN21RMQBmmGhKqZQvw87zlNXwWFluhu5q6LYoVHrchP7Dvktu
	qmrXVXCO9m+fq3/SxW3r6KCv19UgJ/wu2eneoJ8H/UEtIS006xLMAzL6n1fnvHGeZqrBdaoOA3j
	FZBOtQ+ywW9fVIWLtvjIxhAgH4VQH7AaYeCDJQDgB
X-Received: by 2002:a05:6a20:938c:b0:14c:d494:77c5 with SMTP id x12-20020a056a20938c00b0014cd49477c5mr22307521pzh.13.1698876391898;
        Wed, 01 Nov 2023 15:06:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLm8hR0cNPmV0sEacckpAbC8xrgsXjeil5wOzGtmWGyXhIIzhEMb1V79lemGWBlkhLgDI5MWk3hB5Ua/hMs+4=
X-Received: by 2002:a05:6a20:938c:b0:14c:d494:77c5 with SMTP id
 x12-20020a056a20938c00b0014cd49477c5mr22307509pzh.13.1698876391663; Wed, 01
 Nov 2023 15:06:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231101164615.1138692-1-agruenba@redhat.com> <20231101164615.1138692-11-agruenba@redhat.com>
 <c512895f-5d97-4227-9885-6948f5bbbe9b@redhat.com>
In-Reply-To: <c512895f-5d97-4227-9885-6948f5bbbe9b@redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 1 Nov 2023 23:06:20 +0100
Message-ID: <CAHc6FU4Tz-M7uYaKy3vw9ycrqOiS6B_cHys0=txNvTHc3P+JZg@mail.gmail.com>
Subject: Re: [PATCH 10/25] gfs2: Two quota=account mode fixes
To: Bob Peterson <rpeterso@redhat.com>
Cc: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bob,

On Wed, Nov 1, 2023 at 7:19=E2=80=AFPM Bob Peterson <rpeterso@redhat.com> w=
rote:
> This doesn't look right. I purposely avoided coding my patch as you did
> in this patch because it breaks -o quota=3Daccount. I admit I don't know
> much about "quota=3Daccount" but it's coded into gfs2 and this patch
> changes its behavior.
>
> The way I coded it says to return if not "on" or "quiet".
> With this patch it returns with "off", which means it proceeds with
> "on," "quiet," or "account."

you've said exactly this in a related conversation, and my response was:

> According to the documentation, the "quota=3Daccount" mode is supposed
> to do the quota accounting while skipping the warning and enforcement
> logic. How is it supposed to do that when it bails out of gfs2_quota_chan=
ge()
> immediately? And gfs2_quota_change() depends on gfs2_quota_hold()
> being called first, often through gfs2_quota_lock_check() gfs2_quota_lock=
(), no?
> So at best, the way you've coded this leaves "quota=3Daccount" mode broke=
n,
> but the code actually makes no sense.

So how do you think this breaks quota=3Daccount mode?

Thanks,
Andreas


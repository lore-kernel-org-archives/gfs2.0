Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793225386;
	b=n3WHVxGmpyXXYcdHQMje/0ofG37wOt06WJZ5KvRjeIEB2HhzoI0slitJ5XG6ibnE4IHz
	 JZH0bG6CNIOOEg/vLlyw+Iuolr7bDziT9uXW0mVGvuyWFx19SXeKrBHRvxiDTzrXFMEQo
	 E5/8VTIA3+K/yJ7cc4rLuB157pEmZwbO/oy+SVbqg3r4RYAydlnjBZce33iK05pKavB13
	 v36rRrnJUdqosSYEMvyMuzJgsGMWmGa5AYnDzt/0n4DMPBoOxT4yoftCYSYOMriyxGHvS
	 fZi0KHAKgGzu7ltwMU/Kt9+h91n2yND4WdkQOMZytyoq99RLEZ9Qa89lgfuHoJaQ8uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793225386;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=j5xHrk121VJ6jsiOiBImMpaem11Ex15L22vqkzMRx+Y=;
	b=2QjZWWclA2NaPI1bpSs+MEFQ/VCHnd1qOordXodJu7yg61Xprze4Lk+986qd9DaW9CvO
	 rsk9djVMQ3QMQD2kvGYfvbFcZ+wJsqWKm7sPYMClx0iok2GpbfpAwm9OJcld7CjPST2Ya
	 3k6ZLZy3IuDxWG0K4nrTdA4qW2dYfzmz1R9Yu/fXKkHd9aZJw3XoG0xE9jJZeaquuKNSR
	 BiPDjGvflm5O8QBbG1Z0dfTO9VEoRrbcIrMfUF6brLCre8D4cOyWLuP/y+0nRexiJMn58
	 Mv+gdVEOjKdgqmyVSksabaCVc3EsuREZkW3bnvH5ZRblsVP9bDRicV+gsCy2r9JU1gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TedXizmB;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFD6606A323
	for <gfs2@lists.linux.dev>; Wed, 28 Oct 2026 22:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBFD6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TedXizmB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793225385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j5xHrk121VJ6jsiOiBImMpaem11Ex15L22vqkzMRx+Y=;
	b=TedXizmB7pROzC9yt8Z7ACZA27xmpwy51y1aiuneppXqSiGKuR4aEsoOr5xdk5Ne2ImeGL
	TD0uumQBds8lae5xyjeYMpYLNeI0EGFYWRwMn0ARRw517Vnw/+0vjBkglsRXZYrpE3z08j
	IwWw0vrVGXZU3PtiX9cbWcUB9LBKFA4=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15--AhNslWaPIuUweRIq29SUQ-1; Wed, 28 Oct 2026 18:09:43 -0400
X-MC-Unique: -AhNslWaPIuUweRIq29SUQ-1
X-Mimecast-MFC-AGG-ID: -AhNslWaPIuUweRIq29SUQ_1793225383
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-6795a39e53fso247617d50.0
        for <gfs2@lists.linux.dev>; Wed, 28 Oct 2026 15:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793225383; x=1793830183;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j5xHrk121VJ6jsiOiBImMpaem11Ex15L22vqkzMRx+Y=;
        b=1fJTxhGc3t/+xNKhL02rXADjgOh8u/xEi6lhmVPHWyyTmRlwJM3WWI5G7FUVMH81pl
         teqByno88CxzhncW8EyHZ+R0IJht15X6HT9y+xWJIMIhGnBtpoqyaIdVMdO/a3azDycK
         5Pqv1BKLyT6gUG/nKV001un9OqGuWZqDzCXdZp1whdnUd1w1TUYQTwYFhUqLzO/A/VtA
         AjPbCOwxN1v3Z23jEaQ6zsWVxS0DD5I4++JLhCoFlmjaqUYo8XlDrkNq7oLYZBGWUY/C
         EjTv017ZAMKplgniMdPuz9LW/X03i2FyB4/LA+qQcU/DCLSNka+qIp+CYYY5hQoKRj7r
         h4PA==
X-Forwarded-Encrypted: i=1; AKwUvBzh2axnYovDuTdwclrLAgeLVXoLoahvzZSPlhu545D4SjQg+w6g+GLXwp8znoRfKlLvdpJt@lists.linux.dev
X-Gm-Message-State: AFq9FYKovTyLp0e4lZpdHYi3OvVJZ7b0BiuvZQqFMzdASADFxm3cY8an
	99970NqhbLfuMFS9BRlWptP/rb28TviVSZe7uNlbdNDD504gNcG0oX++vd994coazrqejaQI+Io
	n5BDYsesgTWQNhiuOeg5F7O5JFxkTHdPA9xPi9f6Z6o9ULrdRpRn4sLZFEMt4BQqHYS1KI5gx8c
	vVYwvaJhiQM0R3sgnBZab9kEB/HinvyA==
X-Gm-Gg: AYBFou1exnyEkp/cuJ0Axs3MCvcWOrgrp3msp/46xLzZdFnHdJz0WS1blh5xKV0vzwB
	Eo4g9HOzGJcKfyGtuAEiItTORnemsVD36pSHkiqMnvXEDGRk8d2bC01I0uSHhU0rEx/QCC+vHnh
	C4u0VrfYDXRispPwDWsQsTWzSpJsniOlWB7JtRPcxJQh/8EOkgvSyYe3al8p3imSS6qCNuqpHsq
	pz8XeawBTKa+UPO6KMREd6f10BmiSB56XMyReiH4hnupg==
X-Received: by 2002:a05:690e:1918:b0:679:ad2f:3fbf with SMTP id 956f58d0204a3-67a8d0047a5mr704874d50.8.1793225382857;
        Wed, 28 Oct 2026 15:09:42 -0700 (PDT)
X-Received: by 2002:a05:690e:1918:b0:679:ad2f:3fbf with SMTP id
 956f58d0204a3-67a8d0047a5mr704846d50.8.1793225382297; Wed, 28 Oct 2026
 15:09:42 -0700 (PDT)
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261012-work-fs-sb_rdonly-v1-0-60743a3dc326@kernel.org>
 <20261012-work-fs-sb_rdonly-v1-21-60743a3dc326@kernel.org>
 <CAHc6FU6z4kX5R3Og8m0dYOHsjFcw+4Btvfe87AGPxy_EWs0E7A@mail.gmail.com> <20261028-zurschaustellen-okkupieren-inkompatibel-d11525ce88b8@brauner>
In-Reply-To: <20261028-zurschaustellen-okkupieren-inkompatibel-d11525ce88b8@brauner>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 28 Oct 2026 23:09:31 +0100
X-Gm-Features: AclHuK9MzobLdiG2EG9M5KT_ibZzYxdrTghiXff6ZlesOE7YSK8Ag_RtXekxyZI
Message-ID: <CAHc6FU6VSAWQ4RJTO_eLnpqN5qvrShbJeT+ADwiA6ohpq8dO4Q@mail.gmail.com>
Subject: Re: [PATCH RFC 21/28] gfs2: don't set SB_RDONLY on withdraw
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, ecryptfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	linux-nilfs@vger.kernel.org, exfat@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, ntfs@lists.linux.dev, 
	ocfs2-devel@lists.linux.dev, linux-btrfs@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-efi@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-xfs@vger.kernel.org, 
	stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0Y2P2BlD6wKgOs-hf4IXY-vTSqxIsoJXlEJeFAhtezU_1793225383
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 5:02=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Fri, Oct 16, 2026 at 02:01:00AM +0200, Andreas Gruenbacher wrote:
> > According to commit d564053f0746 ("GFS2: Clean up freeze code"), the
> > idea of the freeze sysfs file was to make it behave like the FIFREEZE
> > / FITHAW ioctls. This isn't what the code is doing at all.
>
> That's a pre-existing and separate from this series. freeze_store() calls
> freeze_super() and thaw_super() directly with FREEZE_HOLDER_USERSPACE and=
 never
> goes through gfs2_freeze_super() and gfs2_thaw_super(). So it never takes=
 the
> freeze glock. I don't think that's for this series to fix.

I mainly wanted to point out that this behavior isn't intentional.

Thanks,
Andreas


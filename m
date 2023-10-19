Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32729225D6
	for <gfs2@lists.linux.dev>; Thu, 19 Oct 2023 13:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IHTWBXfB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697721149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=barqOmA/SQxO6U0jPws3Gbb0YFu10fiYYunptNSgLxc=;
	b=IHTWBXfBVOsL+7ojiSOlR64r6PbLtDQmHs0UuPFrbFlwZibi42ax9n/AxYuqt0V1V5u6YC
	zB7cKEYcM0WbWUV+3Q5x7bBR796zzPQXJYwe3aBy3Wq/fwk7jcRkCnisaq+7svkj6AD7o9
	/nHq3Z9Ua24cMLI87kRSlxCKNdHkuLE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-CXxpYC7uNCGrSXpqSHF7CA-1; Thu, 19 Oct 2023 09:12:28 -0400
X-MC-Unique: CXxpYC7uNCGrSXpqSHF7CA-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1c9e1b431d0so56806255ad.3
        for <gfs2@lists.linux.dev>; Thu, 19 Oct 2023 06:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697721147; x=1698325947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=barqOmA/SQxO6U0jPws3Gbb0YFu10fiYYunptNSgLxc=;
        b=D3T+FiHWtvDne/id2VA2Hv5lLyeWqJZAaqJjuaFCaSl7ebrhtpRJhZKXbMQbG5d4bk
         jAw/q31uLnKkWDlu/08EIM3li2s/QUw+6BZg1cvjxfVdUd66lGaGuug8IOKOKCc7WkDv
         q5we7QlCqE2p7JXv16xxkoEQ0UvgmPAluvUFEMoprVE6/VZ7pNlnWFJpPYqPQxqjer2Y
         ESZ5x2OM/ITnudd/7Yt+ifZyCJj4YmO8XrPB5P06IK9F6zFfvnSMx1JsQoUl1G6WQP0t
         JHAA3BZOo0qMDMRx3FnDosN7V4g4PpHM5+kK8BjYr8x60cU9j5jyuF8JNx09YWEnlUus
         v/CQ==
X-Gm-Message-State: AOJu0Yxvx3ati6FkJTefTwI+F8tTC0GYka44TlXC1UwOI5zDml/6kouJ
	ZAa3JBlYTv7r9gDwLaJdLHo4NKLqAfWJgDtlF6qCFZpMQKFGM1m1ZqnqkbDgi7OvwgcAuGgdHae
	c6WXgboCpkZMOfgt8WfJufwmOsycU0g==
X-Received: by 2002:a17:902:f312:b0:1ca:8b90:1cbd with SMTP id c18-20020a170902f31200b001ca8b901cbdmr2079990ple.0.1697721146988;
        Thu, 19 Oct 2023 06:12:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfcYxDrJRl9Hw2YCkxmlS9Ekn3Uum6GR8tBCcFh8z3W/F9rriGpLEWzwJ3lK2JvpHz9hBjrJfbbVgdpRoK3Yw=
X-Received: by 2002:a17:902:f312:b0:1ca:8b90:1cbd with SMTP id
 c18-20020a170902f31200b001ca8b901cbdmr2079972ple.0.1697721146674; Thu, 19 Oct
 2023 06:12:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <a8791f89-ed7b-1649-3b53-72349899c5d@inria.fr>
In-Reply-To: <a8791f89-ed7b-1649-3b53-72349899c5d@inria.fr>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 19 Oct 2023 15:12:15 +0200
Message-ID: <CAHc6FU4+Wv1YZUDmU_oHaEe2bY7-uAzbKj6UMGem9kcw55qfaQ@mail.gmail.com>
Subject: Re: [gfs2:extents 14/14] fs/gfs2/extents.c:123:23-27: WARNING use
 flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
 (fwd)
To: Julia Lawall <julia.lawall@inria.fr>
Cc: oe-kbuild-all@lists.linux.dev, gfs2 <gfs2@lists.linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 7:28=E2=80=AFAM Julia Lawall <julia.lawall@inria.fr=
> wrote:
> ---------- Forwarded message ----------
> Date: Thu, 19 Oct 2023 05:56:44 +0800
> From: kernel test robot <lkp@intel.com>
> To: oe-kbuild@lists.linux.dev
> Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
> Subject: [gfs2:extents 14/14] fs/gfs2/extents.c:123:23-27: WARNING use
>     flexible-array member instead
>     (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-=
length-
>     and-one-element-arrays)
>
> BCC: lkp@intel.com
> CC: oe-kbuild-all@lists.linux.dev
> CC: cluster-devel@redhat.com
> TO: Andreas Gruenbacher <agruenba@redhat.com>
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.g=
it extents
> head:   86474c69cac46872bd311318c02fb8e9e25abd10
> commit: 86474c69cac46872bd311318c02fb8e9e25abd10 [14/14] gfs2: Add some i=
nitial extents-based inode code
> :::::: branch date: 9 days ago
> :::::: commit date: 9 days ago
> config: x86_64-randconfig-101-20231018 (https://download.01.org/0day-ci/a=
rchive/20231019/202310190541.0impmnL4-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20231019/202310190541=
.0impmnL4-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Julia Lawall <julia.lawall@inria.fr>
> | Closes: https://lore.kernel.org/r/202310190541.0impmnL4-lkp@intel.com/
>
> cocci warnings: (new ones prefixed by >>)
> >> fs/gfs2/extents.c:123:23-27: WARNING use flexible-array member instead=
 (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-lengt=
h-and-one-element-arrays)

Thanks, I've fixed this.

Andreas


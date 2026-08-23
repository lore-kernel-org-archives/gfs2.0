Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3046F1A6809
	for <gfs2@lists.linux.dev>; Sun, 23 Aug 2026 20:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787517744; cv=none; b=iq9HNwawt7iumniL1MOsT9+MsWt4GMb3uF15RwAnMeCahrJmp3/AK4jCuTWBgTd6/MznzLH7gWTfuce/DpWZuweEhzEIv83edbH9Bj1q6JffT6rWFdJtd1nweO+u562MX7Gcn7vSNKmpDQxgsGVZDi85oPWzJFw2LXFyeG4s2lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787517744; c=relaxed/simple;
	bh=vKoGYx02yUp02Fqx1Q+rUvb2y7vn6u8WMxdUGNWmMEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O08U1/FiQOGkeVxw4NmeWhjkIPyoKKLgFEeluHDr83OhP6W8iMfVHx/MRl3CAEwF2KKFcII+A3PgMenwcDxFgvILd46ph9iSgTTDwisL75iiRj+m7J0XTIkard1IxaZxEujbiTXN2zqUY3q1GvW0OqiPSDRyIbkHx/BdiYI8+K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S7GPdhyu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S7GPdhyu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787517741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SFDV+7W8DGFkHuzF8rYKzLPJzOVSHo8h0lJMwZdjIRY=;
	b=S7GPdhyuDZbkBClJMNShAHkXl6axIOCSAE6Fl+WS0vNB4O1e+mTKW1QcE2nQzLgVVyL5K/
	Ut6d0FtSsBz2jZOQR7bkynZ6U8Rw3ZxxSRK9qG5XkykaGpoqHvcmkpM9eJEJ/Ih7DirZhF
	GDOQIzLAqWiP8enV5D03ABSFkl++GAs=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-j1n0D7i9MZuJ3jOtjyiojg-1; Sun, 23 Aug 2026 16:42:20 -0400
X-MC-Unique: j1n0D7i9MZuJ3jOtjyiojg-1
X-Mimecast-MFC-AGG-ID: j1n0D7i9MZuJ3jOtjyiojg_1787517739
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-66c9841d667so4341827d50.3
        for <gfs2@lists.linux.dev>; Sun, 23 Aug 2026 13:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787517739; x=1788122539;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SFDV+7W8DGFkHuzF8rYKzLPJzOVSHo8h0lJMwZdjIRY=;
        b=PLjVyvUoY8z2WUj7UDHcOf2obQ4jgJGVXiW8/QpMTM9MBP9Cz+cYTP4JUx8+fi88oz
         NICD89osldoR+aTZBEwkxqFEqrhBEgyjCDmbJzFVffHsKPr6VzXxERrjMQCKxZD91+gw
         sWmcVfKmBzBe2shdasHZzQdabHD1tQX3O0f8LAFJtTUDNHjiNDKQpAYoPJ2u+nh8XsMr
         dd++SUI1MGc7oKPCrN6Qhn8Op66svZ/Xmjee/ysbaMcM6XxSTJe+ev2bqAkyHPqG7unj
         6V2nk8lUvNlgOf/+IlCe3B6ERb9VomEP/Q2u56wwMS7dSc2UzbfF6EhOL7GpbCzxIdd0
         Y5xA==
X-Forwarded-Encrypted: i=1; AHgh+Rq7xNPusjbCWP0/YaVgZ0l3IFSnDg2vvoJg8/nxuXubLEj/Yp+2FTFM8zifKrs38Tol/4OM@lists.linux.dev
X-Gm-Message-State: AFuF++lXp9TjEGmIwZtB37TGF7o4C6VmDpTIGLSOObMhB+XjkRsBkLI6
	wGdNVs4moIBPWi6jKjYsW9EQ/YfliOfQPu67KsnHids60r15cIbCWLxuCKCr3rzK6sya6cu1OHr
	vG7P+sWwldyT2dJk+wWZ0fE9eHHMoJN/FQu0vfSaMnHN00EewatAXScpkTKcbRBk8+T5jgXNX3l
	e1NvjnfMTgMkc/GYDR3/Crylk0VPKRKA==
X-Gm-Gg: AR+sD12GLx6eUBXPKx9Ka8LA5LK4FG6grZo7CmXeSiF3Lzz6DUbWXL6EmwTlFQl9Av2
	vywYRWAsgynRhSN3d9HFAx+qsVOBx+5FZRHsSF4rsvbdPoJUoj6FWTgzIVVH49SSwHougdlO8i2
	qZXrZSlkQr9q0PVERnkUSyUrM6U7LA3dDxhWDwfKzawv/Ao3szgNqZjn4a/c8PYd6MhWCW+SCki
	RhATm1XG+zurnsWuanYtU7TWAoEVwR1V+yNOwawcXb8
X-Received: by 2002:a05:690e:12:b0:667:e855:ecdb with SMTP id 956f58d0204a3-66ce49d4b1fmr5604258d50.3.1787517739056;
        Sun, 23 Aug 2026 13:42:19 -0700 (PDT)
X-Received: by 2002:a05:690e:12:b0:667:e855:ecdb with SMTP id
 956f58d0204a3-66ce49d4b1fmr5604246d50.3.1787517738603; Sun, 23 Aug 2026
 13:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <6a74d41a.f3f7def5.e164f.560e@mx.google.com> <202608240109.e8n1gQMm-lkp@intel.com>
In-Reply-To: <202608240109.e8n1gQMm-lkp@intel.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sun, 23 Aug 2026 22:42:07 +0200
X-Gm-Features: AcwNN1UeCLf-8yi08Yx6qdKDCYCeST64r39VmSBwQ5AuetcO8mC9dd_i8vStyuY
Message-ID: <CAHc6FU6Z=LbnW2UNTgORQKV2e7=sFiOzv3+0qLkULxiEKdz+Aw@mail.gmail.com>
Subject: Re: [PATCH v2] gfs2: annotate i_gl with __rcu and convert to accessor helpers
To: Dan Carpenter <error27@gmail.com>
Cc: oe-kbuild@lists.linux.dev, 
	Adrian Garcia Casado <adriangarciacasado42@gmail.com>, lkp@intel.com, 
	oe-kbuild-all@lists.linux.dev, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Vc1T8ZaMUP8lH00C-Ix9seZTmAwTalD_jI6-dJ7tOxg_1787517739
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dan,

On Sun, Aug 23, 2026 at 9:02=E2=80=AFPM Dan Carpenter <error27@gmail.com> w=
rote:
> Hi Adrian,
>
> kernel test robot noticed the following build warnings:
>
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Adrian-Garcia-Casa=
do/gfs2-annotate-i_gl-with-__rcu-and-convert-to-accessor-helpers/20260806-1=
13610
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.g=
it for-next
> patch link:    https://lore.kernel.org/r/6a74d41a.f3f7def5.e164f.560e%40m=
x.google.com
> patch subject: [PATCH v2] gfs2: annotate i_gl with __rcu and convert to a=
ccessor helpers
> config: x86_64-randconfig-161 (https://download.01.org/0day-ci/archive/20=
260824/202608240109.e8n1gQMm-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> smatch: v0.5.0-9187-g5189e3fb
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> | Closes: https://lore.kernel.org/r/202608240109.e8n1gQMm-lkp@intel.com/
>
> New smatch warnings:
> fs/gfs2/inode.c:150 gfs2_inode_lookup() warn: inconsistent indenting
>
> vim +150 fs/gfs2/inode.c
>
> 194c011fc4650d fs/gfs2/ops_inode.c Steven Whitehouse    2011-05-09  127  =
struct inode *gfs2_inode_lookup(struct super_block *sb, unsigned int type,
> 3ce37b2cb49176 fs/gfs2/inode.c     Andreas Gruenbacher  2016-06-14  128  =
                               u64 no_addr, u64 no_formal_ino,
> 3ce37b2cb49176 fs/gfs2/inode.c     Andreas Gruenbacher  2016-06-14  129  =
                               unsigned int blktype)
> 194c011fc4650d fs/gfs2/ops_inode.c Steven Whitehouse    2011-05-09  130  =
{
> 194c011fc4650d fs/gfs2/ops_inode.c Steven Whitehouse    2011-05-09  131  =
       struct inode *inode;
> 194c011fc4650d fs/gfs2/ops_inode.c Steven Whitehouse    2011-05-09  132  =
       struct gfs2_inode *ip;
> 3ce37b2cb49176 fs/gfs2/inode.c     Andreas Gruenbacher  2016-06-14  133  =
       struct gfs2_holder i_gh;
> 194c011fc4650d fs/gfs2/ops_inode.c Steven Whitehouse    2011-05-09  134  =
       int error;
> 194c011fc4650d fs/gfs2/ops_inode.c Steven Whitehouse    2011-05-09  135
> 6df9f9a253c7dc fs/gfs2/inode.c     Andreas Gruenbacher  2016-06-17  136  =
       gfs2_holder_mark_uninitialized(&i_gh);
> 5f6e13baebf31d fs/gfs2/inode.c     Andreas Gruenbacher  2021-11-29  137  =
       inode =3D iget5_locked(sb, no_addr, iget_test, iget_set, &no_addr);
> 194c011fc4650d fs/gfs2/ops_inode.c Steven Whitehouse    2011-05-09  138  =
       if (!inode)
> ac3beb6a5de048 fs/gfs2/inode.c     Steven Whitehouse    2014-01-16  139  =
               return ERR_PTR(-ENOMEM);
> 194c011fc4650d fs/gfs2/ops_inode.c Steven Whitehouse    2011-05-09  140
> e97321fa095f1e fs/gfs2/inode.c     Bob Peterson         2016-04-12  141  =
       ip =3D GFS2_I(inode);
> e97321fa095f1e fs/gfs2/inode.c     Bob Peterson         2016-04-12  142
> 40a4c512ad2564 fs/gfs2/inode.c     Mateusz Guzik        2025-10-09  143  =
       if (inode_state_read_once(inode) & I_NEW) {
> 194c011fc4650d fs/gfs2/ops_inode.c Steven Whitehouse    2011-05-09  144  =
               struct gfs2_sbd *sdp =3D GFS2_SB(inode);
> 5f6e13baebf31d fs/gfs2/inode.c     Andreas Gruenbacher  2021-11-29  145  =
               struct gfs2_glock *io_gl;
> c412a97cf6c525 fs/gfs2/inode.c     Bob Peterson         2022-08-22  146  =
               int extra_flags =3D 0;
> 194c011fc4650d fs/gfs2/ops_inode.c Steven Whitehouse    2011-05-09  147
> 2c5f4a53476e3c fs/gfs2/inode.c     Andreas Gruenbacher  2025-11-13  148  =
               gfs2_setup_inode(inode);
> f7e98cd66761db fs/gfs2/inode.c     Adrian Garcia Casado 2026-08-06  149  =
               { struct gfs2_glock *gl;
> f7e98cd66761db fs/gfs2/inode.c     Adrian Garcia Casado 2026-08-06 @150  =
               error =3D gfs2_glock_get(sdp, no_addr, &gfs2_inode_glops, CR=
EATE, &gl);
> f7e98cd66761db fs/gfs2/inode.c     Adrian Garcia Casado 2026-08-06  151  =
               if (!error)
> f7e98cd66761db fs/gfs2/inode.c     Adrian Garcia Casado 2026-08-06  152  =
                       rcu_assign_pointer(ip->i_gl, gl); }
>
> What's going with the indenting?  This looks like debug code
> accidentlly escaped?

this patch can be ignored; it has been superseded by the following patch se=
t:

https://lore.kernel.org/gfs2/20260820142129.1327413-1-agruenba@redhat.com

Thanks,
Andreas

> 29464ee36bcaae fs/gfs2/inode.c     Andreas Gruenbacher  2022-01-24  153  =
               if (unlikely(error))
> 29464ee36bcaae fs/gfs2/inode.c     Andreas Gruenbacher  2022-01-24  154  =
                       goto fail;
> 29464ee36bcaae fs/gfs2/inode.c     Andreas Gruenbacher  2022-01-24  155
> 29464ee36bcaae fs/gfs2/inode.c     Andreas Gruenbacher  2022-01-24  156  =
               error =3D gfs2_glock_get(sdp, no_addr, &gfs2_iopen_glops, CR=
EATE,
> 29464ee36bcaae fs/gfs2/inode.c     Andreas Gruenbacher  2022-01-24  157  =
                                      &io_gl);
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>


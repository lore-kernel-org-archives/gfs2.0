Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795047181;
	b=bbzWz7x+I3WQW18QTzHlT97RXSitp3U9FjGBV+8yGnkZij2L9wmfsbgtK+V3Q10NmXJc
	 xR1A6USO7RVM+NKdV/bWh1lATgpiXLDrao8BGTpx3Sbg5oVXYEkACZKFvFswKszSd4vPn
	 WV7Id0rnXH/J+JUTGIHUS6V/rLDVzG/DCy1bx+RIAaZIpV8oiVyz/Yz3C1pmVqOm+fy9x
	 40LH55Ea1Y8q4G9CPiEVk1dYc8eea4+QlKZ/WzklIBjhm3nOSCFZfhYo8ff0tNoaynEKy
	 tWm1Czm0nFzcDW+Nb7sExBudqju8l93Pbtt3Mw8mesPv2Vc1DA8TdF03SCp5j1obguA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795047181;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=077/TizvhH3iQcetqO0vvepvTnfIkqb5hqSDa7XFIt8=;
	b=5T87qk2TLLha8ZA0aCU0ZgLQbz9TKXTRz0Xjhj079gHrmWFZjJiCs/bt2EIhGsaXYmg1
	 IjnGOW0Uy4KanFIt8l4jLlcKb4/vUk+fq9r96ycZYVuEENYhxu5h5lglGU0OHYbSPGej3
	 o+EhP6smY9289a+QrI2a9bsBMxIo+uEBKxFDe71Pl/8/Mt+2hXWC7ie8kVELUd3GMkr7t
	 bx6w7HeuGpHvGP5QapvcFIVOkZJlYXCNBATVic7Uafb11ByQu82Va61TVG52ETS8nzaHJ
	 4foIZ4O7NZEy5yscp2bDIuzje31LIxv/4MkAT+rvSGzAhl8ZtpGCLkM+RyHWmBrcuNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DkK0PJGZ;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA12A606A330
	for <gfs2@lists.linux.dev>; Thu, 19 Nov 2026 00:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA12A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DkK0PJGZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795047180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=077/TizvhH3iQcetqO0vvepvTnfIkqb5hqSDa7XFIt8=;
	b=DkK0PJGZuU6xjETr8IRYKlcNarjz50cFTcBVw20h8LQ8DbaJqNlOkLygouqeiVQ6f9BAMj
	hlYkXzCB5swKDdnXWJS9JX5e2ITrFTcvHgf++ruGyd2Z7eCOMQtCTwwievMnz3V803ec/q
	h8sgZGiWP9NInZCCic8F2tddi1D6QTY=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-CllCRc_MMUSghXEJYUn2bQ-1; Wed, 18 Nov 2026 19:12:58 -0500
X-MC-Unique: CllCRc_MMUSghXEJYUn2bQ-1
X-Mimecast-MFC-AGG-ID: CllCRc_MMUSghXEJYUn2bQ_1795047178
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-67be4f2f42eso2524929d50.0
        for <gfs2@lists.linux.dev>; Wed, 18 Nov 2026 16:12:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795047178; x=1795651978;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=077/TizvhH3iQcetqO0vvepvTnfIkqb5hqSDa7XFIt8=;
        b=tX2C2QegsOroIlTDUqXpYDEmCXaUkjcw6wscGuCzXffur38mkLVK9TrwIDE0l4Yv1S
         x24XBRNH7ZthiVGFykEfrRJoCJxn0rEBEWOVFcaDj/IF7nvEERukirQJEkKIb9fEZCbl
         bLPy9UImC6CBdjAn+pIwC/kGyLKB88dClO9ty7PbT3sBgHrFkTXRQ5zq9JoFBowMw23M
         81k9nsyNvgJelvj/0+04jpu1YdNqNngUh0YPCbmilGU0Bne7p8hCuiC7dM7UxsTpt6CN
         zlvcTiNzMYJdWD/0h3bU3egZXb0TORSamaFet0bHY+fAO5QD+INYtgIxhmIUeJ5U51pv
         wVJA==
X-Forwarded-Encrypted: i=1; AL+hErFIkiuv6n0hcIUo80g/jlKf+okMHdvaZL4C/GZ5YflpKZ0Da+mupTSR8traSuunB3Ft6m18@lists.linux.dev
X-Gm-Message-State: APuU4Z+wbv32MH7MInN+yZctORzYOqa7AVMgq0LjhZqQHT03tyn7w4Dz
	LFLkjqE98+IcuqPw3Z0ezvyWzl5AVcY5k3pmBs+vEcevajtjGiLAv7BkerVrXR6fU7JxeidrZJw
	xZxX9fSDivjh82ROROxwIn5h6VbQX0W/NjfcsDU+Xkm0+JCeqxy5r2jhUHcNwCS0v5Z9ocUGc3f
	W+RaTAE/49cvvYsH9hsxwFDckQuouP6Q==
X-Gm-Gg: AZFdTZekuLsDqlTuWu2cq73Ay4/dGpXpWIIgeO9c50jPpTt8TcbSp5zQEfq2cMiP6mU
	INZOwL/rGKxlLsdQmgN8LO68iRA7nRYegaSpq88cvlDLkb7NwkALK/kENgWkZsZSr8av2s807zO
	5JGd6oFI/aBIkXWK68a9/x0vC5E3F/xKqK9ubNAhV1JZcxdKsyEuiZ//7kahVPwgoJeNJ11TzwQ
	SU0eOO2586M5zosLMUYrFKRFjJnXf1p2xjqudGMZktUQw==
X-Received: by 2002:a05:690e:1907:b0:67d:b34c:9f19 with SMTP id 956f58d0204a3-67dd3fdcc80mr1565904d50.106.1795047177738;
        Wed, 18 Nov 2026 16:12:57 -0800 (PST)
X-Received: by 2002:a05:690e:1907:b0:67d:b34c:9f19 with SMTP id
 956f58d0204a3-67dd3fdcc80mr1565894d50.106.1795047177150; Wed, 18 Nov 2026
 16:12:57 -0800 (PST)
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261116171044.6938-1-jack@suse.cz> <20261118145941.1063127-22-jack@suse.cz>
In-Reply-To: <20261118145941.1063127-22-jack@suse.cz>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 19 Nov 2026 01:12:45 +0100
X-Gm-Features: AclHuK8R-2iEv0c9btS3snfH7Yzq75Yl9vf1mN1FPuSVCWTRM2Ut7aYcwFy-L9Y
Message-ID: <CAHc6FU4+FV=A2UK1oPejHSt5XQ2Ox+CyvZfT4Q17YaceJ+NJ1w@mail.gmail.com>
Subject: Re: [PATCH 09/13] gfs2: Fix dirtiness checks in gfs2_write_inode()
 and evict_linked_inode()
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, devel@lists.orangefs.org, 
	Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net, 
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	linux-afs@lists.infradead.org, Miklos Szeredi <miklos@szeredi.hu>, 
	fuse-devel@lists.linux.dev, linux-block@vger.kernel.org, 
	Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, 
	Eric Biggers <ebiggers@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-fscrypt@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tVdb2VaW1itiNgmqeAAAZGfSIEnIWUOGTIkzhTDuAj4_1795047178
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ja,


thanks for catching this.

On Wed, Nov 18, 2026 at 4:00=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> The checks are bogus because they check against inode->i_flags instead
> of inode->i_state. Use the inode_or_folios_dirty() helper which actually
> checks what was intended.
>
> Fixes: 957a7acd46e6 ("gfs2: Remove inode from ordered write list in gfs2_=
write_inode()")
> Fixes: bd67f17718cc ("gfs2: Fix data loss during inode evict")
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/gfs2/super.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
> index 04bb4cf787d4..9b723dd591a5 100644
> --- a/fs/gfs2/super.c
> +++ b/fs/gfs2/super.c
> @@ -460,7 +460,7 @@ static int gfs2_write_inode(struct inode *inode, stru=
ct writeback_control *wbc)
>                 mark_inode_dirty_sync(inode);
>         else {
>                 spin_lock(&inode->i_lock);
> -               if (!(inode->i_flags & I_DIRTY))
> +               if (!inode_or_folios_dirty(inode))
>                         gfs2_ordered_del_inode(ip);
>                 spin_unlock(&inode->i_lock);
>         }
> @@ -1418,7 +1418,8 @@ static int evict_linked_inode(struct inode *inode, =
struct gfs2_holder *gh)
>         struct address_space *metamapping =3D gfs2_glock2aspace(gl);
>         int ret;
>
> -       if (!(test_bit(GLF_DIRTY, &gl->gl_flags) || inode->i_flags & I_DI=
RTY))
> +       if (!(test_bit(GLF_DIRTY, &gl->gl_flags) ||
> +             inode_or_folios_dirty(inode)))
>                 goto clean;
>
>         /* The inode glock must be held exclusively and be instantiated. =
*/
> --
> 2.53.0
>

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

Andreas


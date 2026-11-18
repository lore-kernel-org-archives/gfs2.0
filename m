Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795044958;
	b=KIKSqtuyKc+dY+nOqkHz0Wfk6JtOxr8WBEiPRmw1o0ay1QToxxq6tC+QiiOh4XbSZVzK
	 6De9S6hDLYooO1BBmxc/pQRVkSfsaNhsK2QbbRqWerUkptx2YM7CAEwJhLu7GuO8zKxZj
	 UKYJvGnVu1FrwjYmyXs8x4eE1SxSseXFQJcEMoH7/Vx1/9FYZ6v8gXSIXLGZ1hFaYmzp4
	 3NOMT55TCP3QgEv3bltqa2TMWh97u4SiwLTUwcWbwsb2pqAi+wVWigqKfxVN3GePrE8VF
	 qfeGRAlPQZLo5hhLBjgdjMpSqH3GrE3G1IPh6iKRs5hQO4ELvU6n5cigcAD20NPzt7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795044958;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=1sqaAoxbPYdo18ldNOsiM1TbcJ03Gv+SVlc5ayXI+nY=;
	b=vnOcgXBLvKHK/Z8Pre15cFgQTmcgNnb2HmEGIOx3WOyMf48gqnd4jJ/xOOCvrrQO6KwN
	 lj5AUcJ/u4j2HnYiKq2wZDbd1LqsiHMZqcrKQJ2LcQ0nK9n/EPyAhlhZ28ebuSFxMErx7
	 lxHwV2zLtFcXVyG8JsLzyAPptl8Gw0L90QpDtSAEK833vzvr2dlPlGjEmeRZtNa+R8T+f
	 DzbVXJpLLin4Jm7+rrXJIxdAV/t3uqCUgwEa5bMGq22qLT9KyTX2/Yjb+3ilUfRqYz52F
	 ivTeydfc/4rcunStydjs7ffrWUR2UKr/1YXqu2FdmUY3GfmY9kSJ6fr3+rDr3V8Nn5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OeZtfPG5;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB72606A32F
	for <gfs2@lists.linux.dev>; Wed, 18 Nov 2026 23:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDB72606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OeZtfPG5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795044955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1sqaAoxbPYdo18ldNOsiM1TbcJ03Gv+SVlc5ayXI+nY=;
	b=OeZtfPG50Fjqj40s6Sj+6Did4ufEl3tVHRxceE+mdWNbGwx7fNYk44K7y6G04p78xFCD/R
	1kv1BumxCx310EyVnA8d4SqhUasQR7TMJCm7IYNKBrDLFc8ygMd69JH4NPy4EA0UV5oaOI
	oaiqNL+fbnuAUb7jfi3vcX/vMHMt/3w=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-NzMtl4FwPem6MxxBd6FHSg-1; Wed, 18 Nov 2026 18:35:54 -0500
X-MC-Unique: NzMtl4FwPem6MxxBd6FHSg-1
X-Mimecast-MFC-AGG-ID: NzMtl4FwPem6MxxBd6FHSg_1795044954
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8b4b2b422c5so16167257b3.1
        for <gfs2@lists.linux.dev>; Wed, 18 Nov 2026 15:35:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795044954; x=1795649754;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1sqaAoxbPYdo18ldNOsiM1TbcJ03Gv+SVlc5ayXI+nY=;
        b=enTVWmaryKK1Ve5DTSZcdxzdgTarUHQgSL9AdCOERboOooaFODefCVFKTiFtA86oGv
         cmgLzSL7CDZ6wCcrLChaibLo6oy1IMpVLnXMZ/OpB73yAg0MHycJipV0uB7E+lTHdMUi
         92ovgGN+mnvoCPT0HDIF5YyegkdPlh44uCIHwqTLwXR+FJc8Ad/vpoxfU6AtqmUmrPWO
         dsptMpMHReUBwWP7kmhonJWgHjTlINVu7cGKMlPaL8LITpL+PqMYHDBb3C4OjxBVuCap
         rUAnyBD1ZPaOEDvnlJdAvUUXUvgEr5P6fNFRcBueF1OVnj0j3iWdI2DKb0Rs4o5hjX1+
         /Ybw==
X-Forwarded-Encrypted: i=1; AL+hErEKUGiMaNH67FJqdTwosISFM96kOW8Gp6OK0ST39Yy+DgxOkGRDZjvlY/FQ/fyf7t4m8DXn@lists.linux.dev
X-Gm-Message-State: APuU4Z8b/BqSMjKwJG0uF66TuFoi1w0Wks4gFIgSC/8WBPrIEzeamNvh
	VCsvcUTolJ8F3HZYalktfjZ7kkoW3eztAi47MbBJD1ehVJR+T7KTPvO7Flz1hGArlvZRwxooC9o
	IPNRf0QzHYYkS5hT75X5jGYrWZ4J7GxKZF4J/ytgNug/pHKl398whK8m5R4P+3N8UnJ2eRJfcE9
	Rv+9vq0Ba66I6lf8WXPsWBjar5FcFZTw==
X-Gm-Gg: AZFdTZeWf57dxSpaLU1qwAPW5sVQWS33teGQnDpt5I8zFSwtfryrzwqVZm6ml42yv8t
	p94YYxOLgmE5AmR+VsaMovlETPgVypVp+d6KkP48zF1sKpn48xFSCoKuPMkZyqae2QqZB3ph4+6
	2MTVFIvFRHq9/npnbCHxFjQbHIlyIY1qU64qJ0ESugHRjocn/+PuIaNDtS9w0BPg1UHCaOKuGxu
	vzcSSHGZ8xr5B9CJDBWIaWsbvX4w4lZS48ikhEf+LkjBg==
X-Received: by 2002:a05:690e:128a:b0:679:2a90:d3ad with SMTP id 956f58d0204a3-67dd403bf8cmr1618042d50.102.1795044953778;
        Wed, 18 Nov 2026 15:35:53 -0800 (PST)
X-Received: by 2002:a05:690e:128a:b0:679:2a90:d3ad with SMTP id
 956f58d0204a3-67dd403bf8cmr1618023d50.102.1795044953295; Wed, 18 Nov 2026
 15:35:53 -0800 (PST)
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261116171044.6938-1-jack@suse.cz> <20261118145941.1063127-19-jack@suse.cz>
In-Reply-To: <20261118145941.1063127-19-jack@suse.cz>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 19 Nov 2026 00:35:42 +0100
X-Gm-Features: AclHuK9zTsUN7zuq72-DSL1ny4jnrrzy1tFjBUU4DEu6A9maK7lyiUQZqwV6vuE
Message-ID: <CAHc6FU7NoZua98SGP9Kuga58gAcco6X__u=kOPfsUqbefAKLFQ@mail.gmail.com>
Subject: Re: [PATCH 06/13] gfs2: Avoid racy dirtiness check in gfs2_fsync()
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
X-Mimecast-MFC-PROC-ID: cxMfVxtx6ItOkKsdbVlH93nXgQfOjklUJNkj_kra8Sw_1795044954
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

On Wed, Nov 18, 2026 at 4:00=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> Check for I_DIRTY_PAGES state in gfs2_fsync() is racy because
> __writeback_single_inode() unconditionally clears the flag and
> reinstates it only later based on PAGECACHE_TAG_DIRTY tag. If
> gfs2_fsync() unlocked read of i_state hits in between, it will not see
> I_DIRTY_PAGES although there may be dirty folios in the mapping. Check
> for PAGECACHE_TAG_DIRTY instead and use inode_is_dirty() helper for
> inode metadata dirtiness check.
>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/gfs2/file.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> index 1efd0679badd..f5532f72ab99 100644
> --- a/fs/gfs2/file.c
> +++ b/fs/gfs2/file.c
> @@ -749,7 +749,7 @@ static int gfs2_fsync(struct file *file, loff_t start=
, loff_t end,
>  {
>         struct address_space *mapping =3D file->f_mapping;
>         struct inode *inode =3D mapping->host;
> -       int sync_state =3D inode_state_read_once(inode) & I_DIRTY;
> +       bool dirty_data =3D mapping_tagged(inode->i_mapping, PAGECACHE_TA=
G_DIRTY);
>         struct gfs2_glock *gl =3D gfs2_inode_glock(inode);
>         struct gfs2_inode *ip =3D GFS2_I(inode);
>         int ret =3D 0, ret1 =3D 0;
> @@ -760,12 +760,8 @@ static int gfs2_fsync(struct file *file, loff_t star=
t, loff_t end,
>                         return ret1;
>         }
>
> -       if (!gfs2_is_jdata(ip))
> -               sync_state &=3D ~I_DIRTY_PAGES;
> -       if (datasync)
> -               sync_state &=3D ~I_DIRTY_SYNC;
> -
> -       if (sync_state) {
> +       if (inode_is_dirty(inode, datasync) ||
> +           (gfs2_is_jdata(ip) && dirty_data)) {

this adds back the I_DIRTY_TIME check explicitly removed in commit:

3aac630b5ce1 ("gfs2: don't worry about I_DIRTY_TIME in gfs2_fsync()")

Could you please clarify what's going on?

>                 ret =3D sync_inode_metadata(inode, 1);
>                 if (ret)
>                         return ret;
> --
> 2.53.0
>

Thanks,
Andreas


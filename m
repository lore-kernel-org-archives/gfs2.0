Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795090692;
	b=0z26+OcMH7hoIQmR/kVexNJQxNHFSal1BAbOHGazh4DIOp0bzE94VKtmtIhvgkhPnyr9
	 xvj27DmbPe+T6bEzG+xA7AsWfvS/+prMKNkkvbs6g3b9guvooMdai5RZZsYKkRNLw+k1+
	 XZZLv7NNO0IBPMJ6LrU91wZtbXJ0hKKK1oQhzk52tKTLuBqnGPQXCzUdU8y/4CyGb51os
	 6l7ShEa5uA8wh5I8wj6s7ygqF7eG96QpSq08j0hl4yBSRuhW9czFtElXhIIsXrQc8Yfcf
	 /3ocalMS1JuMF385XxSHq7yNqJ47Z1rGI0NcHsglqI0+KjSLShJ6n/+NIAizCpvDdfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090692;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=gqZVLpTgCP2ySw8awFBFsKWriU/az/ZtPImm1nmYhzQ=;
	b=N/7A11dlAtkUIkE83af7qUqBzX3MmslXfeiEjBn55oucdrGu42NIDL2avoCo4ld/hm+S
	 ivG+ST7n0LqqR5yjIokP7FYEFnTLVtR8lSoZnwxTfFgSKCuGgfYF0fai/9hUSgEizjL5S
	 tUFtSaThDLr4DyWTkELpHDqLUXd+ICdUBg2zS97sewSt6EMRbSgOYRzrC3tACb3gNHYbG
	 MVkvVWppcM54iQr31F78b9qcn0GS+mYfYary2Fo3OyygqXppKbY63ujAXSzIQfMQLq7Ft
	 AxZQssQyou4u2ZDQsxpXVAgMroHgAG1XB4khqpHC5xkVi0TelTkPlRQiFSvRxCo5ujQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ifOPtyq7;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0AA606A320
	for <gfs2@lists.linux.dev>; Thu, 19 Nov 2026 12:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C0AA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ifOPtyq7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795090690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gqZVLpTgCP2ySw8awFBFsKWriU/az/ZtPImm1nmYhzQ=;
	b=ifOPtyq7o5N4Ryx1i6vms8hUs2TwLy/VT4TTh2PTFt5Ky+OtK2Z52Sg2aRI2r0PQwmRxBb
	acR+rLmvVt0D4OyixA7xHRuMWoYGjGUOCoPGcEsmuGXMRTaLIb6JOZFk6q6oA5x3CSRdRx
	qdccUlXVwKZytBZoZaDb4xPQUUNiPN4=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-fV0xql6SNreufFjQ0Q7Itw-1; Thu, 19 Nov 2026 12:18:09 +0000
X-MC-Unique: fV0xql6SNreufFjQ0Q7Itw-1
X-Mimecast-MFC-AGG-ID: fV0xql6SNreufFjQ0Q7Itw_1795090689
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-67994567a44so2821092d50.0
        for <gfs2@lists.linux.dev>; Thu, 19 Nov 2026 04:18:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795090689; x=1795695489;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gqZVLpTgCP2ySw8awFBFsKWriU/az/ZtPImm1nmYhzQ=;
        b=qvoU1prrfKxJXMZxjJs9PR9ckhsvEzzViuIgEs48F6boDWVHBitZuj3/AHJQTVo+gV
         vC3aN9Dpq7BEUne/HPd8Ix6QkiDg00235ktHr5YGEjtWxH/iA0jKKhuFdBmnL51UE8th
         c7VvXzZynN9gLL2uC+tGEQidEYLaLgYf2qwLYftwDZTX3EgzKde8hQL9xL+iElbF4m0+
         cDBx9fxqRqUYgphrzBUpxFqTvSHsoniOSWw4V+qjxEvs9Bvp//gtm3OAokP+LOhU1yl7
         +gvtzSiFYUPBZhOqxY37rbnIOD2fvvS5eO+/9jLDAmU6tntRnWVxxa+/r9GNEzWzo7KQ
         XroQ==
X-Forwarded-Encrypted: i=1; AL+hErFLAPAltp6mIhRan9YDAkStVlqnduTEQqROLrhTDwbooJNhBDVbz46+WGAcWtK0g++e0kui@lists.linux.dev
X-Gm-Message-State: APuU4Z9X4ortjFzYMceVDHDHICSKhR3T2CxTPEqn1Bdjujm49Hz4x/u1
	10bnMWzHWlbxZz04gCxkvTqd1z3c7AOOIwIMErX9uKLGqvoAXZqlRbv+RCHNFrBte0TEgWVNuh+
	Vgpyt2hSwcWO6ZmW20BU9oFegzwY4EW/tZaiKBYIWd7664SX6P5VnWkVf0cMfyUhY5SiYie3FOX
	ukW49ZnnOQ/lcSA6ss4ez12lVSGJ1T8g==
X-Gm-Gg: AZFdTZcQGoq3TDys9XZ59ZhXXAnnSVEm3pAaPoR9zGxNf+Wn4PkyAsRZONd8F8SWPda
	yByAS7MY7yjJZVFi9t1SeT/r0zJ/hDW+H+qFMXWsMIzhbsKCc58QYUCtCUxx8+o3/FzK/TxpO3A
	FvaMEwJGGXOUEWibyLxs5PkfeKwdG+MLn3sahupMkyGtLTDamQbhVkyXGh8zT2bnO8QemhSWVvV
	SiWAnICiC6O8Jl8qDAn0T1JZ31U7YriXYN3COwzx91Uyg==
X-Received: by 2002:a05:690e:806:10b0:67d:a6fb:ceaa with SMTP id 956f58d0204a3-67dd3f193f3mr1716879d50.19.1795090688828;
        Thu, 19 Nov 2026 04:18:08 -0800 (PST)
X-Received: by 2002:a05:690e:806:10b0:67d:a6fb:ceaa with SMTP id
 956f58d0204a3-67dd3f193f3mr1716866d50.19.1795090688232; Thu, 19 Nov 2026
 04:18:08 -0800 (PST)
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
 <CAHc6FU7NoZua98SGP9Kuga58gAcco6X__u=kOPfsUqbefAKLFQ@mail.gmail.com> <wo5723b7wrmu35q5qffzs7zzqwnojk3ireel2jkit2kxgv6bra@yd3gbigdmmdk>
In-Reply-To: <wo5723b7wrmu35q5qffzs7zzqwnojk3ireel2jkit2kxgv6bra@yd3gbigdmmdk>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 19 Nov 2026 13:17:57 +0100
X-Gm-Features: AclHuK-GbM7XVFxqU3dJAQePNml2N4MUSkkmDt3mktzVCdVYt3Td22WOXOu6yXM
Message-ID: <CAHc6FU5HY9x5ntTOz_xk36T0XTzjNc8R4jy2zzpQKo=19HNMog@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: qIFDp27QCt72JrRQkG1LiH0CIQdxdJVXU_vWwNzZ-vY_1795090689
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 1:05=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> On Thu 19-11-26 00:35:42, Andreas Gruenbacher wrote:
> > On Wed, Nov 18, 2026 at 4:00=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > > Check for I_DIRTY_PAGES state in gfs2_fsync() is racy because
> > > __writeback_single_inode() unconditionally clears the flag and
> > > reinstates it only later based on PAGECACHE_TAG_DIRTY tag. If
> > > gfs2_fsync() unlocked read of i_state hits in between, it will not se=
e
> > > I_DIRTY_PAGES although there may be dirty folios in the mapping. Chec=
k
> > > for PAGECACHE_TAG_DIRTY instead and use inode_is_dirty() helper for
> > > inode metadata dirtiness check.
> > >
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> ...
> > > @@ -760,12 +760,8 @@ static int gfs2_fsync(struct file *file, loff_t =
start, loff_t end,
> > >                         return ret1;
> > >         }
> > >
> > > -       if (!gfs2_is_jdata(ip))
> > > -               sync_state &=3D ~I_DIRTY_PAGES;
> > > -       if (datasync)
> > > -               sync_state &=3D ~I_DIRTY_SYNC;
> > > -
> > > -       if (sync_state) {
> > > +       if (inode_is_dirty(inode, datasync) ||
> > > +           (gfs2_is_jdata(ip) && dirty_data)) {
> >
> > this adds back the I_DIRTY_TIME check explicitly removed in commit:
> >
> > 3aac630b5ce1 ("gfs2: don't worry about I_DIRTY_TIME in gfs2_fsync()")
> >
> > Could you please clarify what's going on?
>
> I wonder how you remember this after five years :). Anyway, the truth is =
I
> forgot fsync path is calling sync_lazytime() as well before calling into
> ->fsync and even if I remembered that, then it would be fragile for the
> helper to rely on that (and there are already users of inode_is_dirty() a=
nd
> inode_or_mapping_dirty() which want it). So to summarize you are correct
> that the added I_DIRTY_TIME check is unnecessary for gfs2_fsync() as it
> should never trigger just for that but it is also harmless and the helper
> is more robust that way.

Alright. Could you please include that in the commit message?

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

Thanks,
Andreas


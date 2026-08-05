Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4333E95B2
	for <gfs2@lists.linux.dev>; Wed,  5 Aug 2026 20:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785962007; cv=pass; b=KjkqGZq2FPpVOCiVKS38UenFGpxUbMjmlINBOmJzpns0WGK5zFlg61BnPe3XtaITEHRkoI+yW60t1WBq7FS3NkMkkqk12j2gra1rZ2MBqEetfAbGgt97gGlt5PbIL2jfw/Y3WhVBdP1NeGqOpZbKhAQXUhy5R3J7HFHAyAGhfkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785962007; c=relaxed/simple;
	bh=GI8C7x7/1X74WCp4xq6Tj+lGkjg4R7DvkuG6i1NAga4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ns9cERsgP7CZjmLC8nzhCync8h3KUvPAyp3IsZjCnzYDV1AF6tP0SwUCJxlr8+YAoGU/Xmm2p6lWDrIijU8ve7GTJu91ixYAUYiko+q7dvYuZf2XU+fxfgfp+bg99Fop7i0bH8/ZtvpMAGXnIbedS6ugjJbJSTWwHCiEv8vMN2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbbKBhV/; arc=pass smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbbKBhV/"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6acc74fee76so577229eaf.3
        for <gfs2@lists.linux.dev>; Wed, 05 Aug 2026 13:33:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785962004; cv=none;
        d=google.com; s=arc-20260327;
        b=RFRgU8Pa64sGdPYmHmAU1s5TYMSpURqqQkqpSfBOKQzZ0/lAS+4vmiHXHvSUvUq8xo
         xV1TiIMds2ZefNJzRVNjFWgDut08ZMnY7mCxFfAdeSFE/BzNej8ttcr+wBjoggZ/DSTZ
         e+TModdNxVGqlxJ4bTZYONVWXYgBpgM5b/cxiWs2kNCTpSraVFzTzTUseBeiR7pLVHHg
         FNeSpWrR21vPqnKVpobscQjR1YtCFu9J2gbjk+DeX6NaWBkh+1umKQ6TimFvMoWF/zGn
         8Zdzq+7CevhWDyfP1URakgTHybCpGx8E8/Ajw0d+6nb+vso201wGoMsr4CGTv3nSZabd
         RJdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WXwiR/pZJKH9ofJG0kWfM6Ol7KNG5CJwWwWByT6iJt0=;
        fh=tDSLVT5OjwQstW7mCxO0punqT3pCM/5yWXMJHOv16uY=;
        b=dACFZkZDPcxB0B2lejfqxQST9eQacp+ry8QkGbwiiT4M2PlGJN3BeXWd3jc8knIdsf
         w2bwb37fH1XrTjw62YRTXmHM6HRk0I6WiaSfw/IZWRvSPVkEE7GvE7EpFysaadI6P9eo
         xECalftFXalAxBmtqISoL6RrHE8CjzZRpfSMAgwu7Z7swMelUYn177+btjrn87O+X5tQ
         Dn5RCfsrbB0aIQtU7LQqKjkI1MHBTqNakacwPaGLo0H4MTbB2Vv/jrZ+ivGLERKYCcL8
         Yk2+V1rwEyfyvSThl1GtXp6Yv3gW1aCeYem54rSy7964Ms2GqhLYfJ9VLzf/RZ801WC8
         9mfQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785962004; x=1786566804; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WXwiR/pZJKH9ofJG0kWfM6Ol7KNG5CJwWwWByT6iJt0=;
        b=GbbKBhV/OrNQVfArRmD3QM9PTcHB3r4N9zQwApY/SPDQ35qoUkyKdgd3pDYLW0ZDyO
         JTeNUXIulOdcRdx2g6IsTmaEyrlRlkOXNonq22RZlOWc91hY+odN2QCl83bJle0muYcd
         h2mt318drtTt0CsRUcgSkOc0LY8OplVWllUh8YaoVFv+N09/AsfLee3JwRO+glEjoHMi
         Z3RqeODIMTPN4BMBbMm+NEHdQyXx5BWUOsnXglf9lYAOZ07aDpURS8HQgIvBHINYd8HU
         jNUV1TkOAyvjidvqF01pTbqOJrvPPZyOa09NgilsiGxRfzfRpDm75ACVwAHplprsrJMf
         41NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785962004; x=1786566804;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WXwiR/pZJKH9ofJG0kWfM6Ol7KNG5CJwWwWByT6iJt0=;
        b=UgueIFnaoMRUZ8RVjJNp9kEcAnVLVCyDVefmcKmv0O6GH4ljCMWcgBagsGrUL+FoR/
         /9WiSZQzumgbeZWVZ9XIL1BO/WsGNjlqMjYH/7+b+eBZ35HaQl1nvB2BYbIqKgrUmRZt
         QYzWVGEMd4ZRT1mceT/Rlg1pdtOZw/sJ35bxkrUI1ZshVFIa5S84yYeRHx4WP41jTSWg
         0+4dBFwbnMaBizvwE1mD2PosaOrvU6jWju4D1VIPMI1TIV7+RJRAATQEKWQTqIdEPz6Y
         OvPbQapEb/fzcLn9l0eHfAqzk3WvvMuhw4YGd2KLn9wvjIa4B/ooUOHAlcKG+7JVCyy3
         EVJA==
X-Forwarded-Encrypted: i=1; AHgh+Rp16Px3P8fUVDh0JMipDUfT1vq2/X4YLxS5BoCNK5hggeKINkGPIw7X2Y4p0AV/Rc9VNRcm@lists.linux.dev
X-Gm-Message-State: AOJu0Ywoha6es59ikbMhsH/91nzKiHHEqHnLYTif4o119L5m4FQu5ENg
	kgzJ3wgQPhpx47es5GGNJgsjPrqWrtlR6eCTjtblrFlXM3Z44/mUTHM4Wr+LScNUi2hwTMeA1uy
	/VAUBNOo7oocGnNtzCZq06lXboToi/Y0=
X-Gm-Gg: AR+sD10Iud5PqnMes17Wb9DdOM6uKJF5nBqIsA1nel/ePErFk+EbYVj+J1joIw7wtXx
	t1X5h8B+zi+hf70T7I9Zkz9zjXYQ4+Ry5uzzmvSOLASXPH/aGEC5pQwNoQsmrV5IvTBr8cOw9SP
	cxoMBa5N9LWY0yzcVqQwgfrCe1vasnYNzOOSXZ2MuOIMBq9ll2dCnF0zV2tulc+DOjClYTGXhQj
	6YgmuC0aTkT3sopHiPwQeSzGkxruDUEPh43dXZT8JbxvGheNCTppSmt+c+8c2ojaJkNCOEFwGii
	LrmD3ieS0o6jHfu3Iy/DxBhZv5bg+eC+mCy8UEt85WSU
X-Received: by 2002:a05:6820:4b8e:b0:6a1:4a27:cd22 with SMTP id
 006d021491bc7-6ae968d0ddbmr5568777eaf.0.1785962002030; Wed, 05 Aug 2026
 13:33:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1785621505.git.coshi036@gmail.com> <f0e0fd8516487b774d8cf1384949a0c616921fbd.1785621505.git.coshi036@gmail.com>
 <ppnbgcljrjb5wqqvqiyh254wkunfutydykgbi7zheuf2mfdjqv@j6lngn5vywxj> <7qfbpj66hdtxc23lox63hqss42yo5xz2dazigf7nwdorplmec5@vv6jsnqa6viu>
In-Reply-To: <7qfbpj66hdtxc23lox63hqss42yo5xz2dazigf7nwdorplmec5@vv6jsnqa6viu>
From: Chris S <coshi036@gmail.com>
Date: Wed, 5 Aug 2026 16:33:07 -0400
X-Gm-Features: AUfX_mwz8K3T1Z_fWdMufWIMTQu1kthOhf45o3aWABfKf2Yu8afHwh21AjQl4bU
Message-ID: <CACd_6n2fBNVQF3UXth_WxGWHMLm7SysDbcQ3PrJc32nDfpMwCQ@mail.gmail.com>
Subject: Re: [PATCH 16/19] jbd2: report journal write errors with BH_Write_EIO
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Baokun Li <libaokun@linux.alibaba.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>, 
	Bob Copeland <me@bobcopeland.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, linux-ext4@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, gfs2@lists.linux.dev, 
	linux-karma-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Done in v2, and 'success' it is - thanks for the follow-up, that is what
fs/buffer.c calls it.

        if (!success)
                   mark_buffer_write_io_error(bh);

Patch 21 adds a clear_buffer_write_io_error() to the success side, so the
final shape has both arms again, but nothing touches BH_Uptodate either way=
.

Best,
Chao

On Tue, Aug 4, 2026 at 5:10=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 04-08-26 10:54:37, Jan Kara wrote:
> > On Sat 01-08-26 18:01:00, Chao Shi wrote:
> > > The journal's own write completion handler,
> > > journal_end_buffer_io_sync(), reports a failed write by clearing
> > > BH_Uptodate, and the three places that wait for journal writes look f=
or
> > > that.  This series is removing that convention: a buffer whose write =
failed
> > > still holds the data that was supposed to reach the disk, and saying =
it is
> > > not up to date makes callers rewrite, re-read or WARN over data that =
was
> > > never wrong.
> > >
> > > Set BH_Write_EIO instead, with mark_buffer_write_io_error(), and test=
 it in
> > > journal_wait_on_commit_record() and in the two commit-phase waits.
> > >
> > > The two changes have to go together, because commit phase 4 waits on =
a
> > > mixed list: descriptor blocks are submitted with
> > > journal_end_buffer_io_sync(), while revoke blocks go through
> > > write_dirty_buffer() and land in bh_end_write().  bh_end_write() alre=
ady
> > > sets BH_Write_EIO, so converting the consumer alone would keep workin=
g for
> > > revoke blocks and silently stop detecting failed descriptor writes.  =
With
> > > the handler converted, both halves of the list report the same way.
> > >
> > > mark_buffer_write_io_error() is safe on all of these buffers.  The sh=
adow
> > > buffers from jbd2_journal_write_metadata_buffer() have no folio and n=
o
> > > associated mapping, so it does nothing beyond setting the flag.  Desc=
riptor
> > > and commit blocks are ordinary buffers on the journal device, and mar=
king
> > > the journal's mapping with the error is what write_dirty_buffer() alr=
eady
> > > does for revoke blocks on the same device.
> > >
> > > Signed-off-by: Chao Shi <coshi036@gmail.com>
> > > ---
> > >  fs/jbd2/commit.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> > > index 60273cddf434..8912786ebebb 100644
> > > --- a/fs/jbd2/commit.c
> > > +++ b/fs/jbd2/commit.c
> > > @@ -39,7 +39,7 @@ static void journal_end_buffer_io_sync(struct bio *=
bio)
> > >     if (uptodate)
> > >             set_buffer_uptodate(bh);
> > >     else
> > > -           clear_buffer_uptodate(bh);
> > > +           mark_buffer_write_io_error(bh);
> >
> > There's no need to set uptodate flag here at all (all callers set it be=
fore
> > submitting IO). So you can just simplify this to:
> >
> >       if (!uptodate)
> >               mark_buffer_write_io_error(bh);
> >
> > Also I'd rename the local variable from 'uptodate' to 'ioerr' or someth=
ing
> > like that.
>
> Sorry, not 'ioerr' but rather 'success'. I can see fs/buffer.c names it l=
ike
> that.
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

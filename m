Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50DF3D7D6A
	for <gfs2@lists.linux.dev>; Wed,  5 Aug 2026 20:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785962138; cv=pass; b=iytNX0nDModP+JEtQDs8Gob30K4PDObZUzw/5/JY4igmuK4x82MYIJ6iOINW6rqKO33nJwRoHDSpKE0aJSyQvnj+utxgQ9idoHKiyFL803DqyJ7I9D7pEb2KPVpeBxOtEygWBe8Mo0PdVdoiXHY1geUK/nmtY79dlbIE0siv4zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785962138; c=relaxed/simple;
	bh=WSEBgYXrHwYXrkVW8w+RdPxc+qhI3MgH0bYqPdxwfqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SSP2mgxy6KL7ywQqGjOp05PZTsgI2oqq0YDlFlHAhraIZi7So1E8lpxoNm/mxXFaff1sgF4MqOIBqwltkGr3M9dgxdBQn1MiP45wnP4P7DVBQRg1ZbFmV4SsBUihbXi1Rt1iQGVYTa5NzCBiFIN9Ku4laSFbKuW7VKq2vevw8Cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qjqtGoMP; arc=pass smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjqtGoMP"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7ea9c6ea7deso1001141a34.3
        for <gfs2@lists.linux.dev>; Wed, 05 Aug 2026 13:35:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785962136; cv=none;
        d=google.com; s=arc-20260327;
        b=DYhJhRI0JEd+3XpD+XW4C2YJsoiaVup5tXdAnnzDLv0FhkTvsY65RCzmCPaS4Jgn9w
         CuuQIgEw8cNAlBFIFv8UevS963BFtPG/9m7dAHGOtRgvEF264H5DXfnJ8XP9vEW52a/k
         RKCrch8p7tc1WgcrkI/bndhpohekYh/l+BOsEM6CfsQt1noi29hOiIN/vyU+IlQmjmt6
         5nPdGmImaIw4FYvnueO170IxWS151fSTZbGDJ6/CRrkgspKxOjg4sELuxzGPCWBTz/VN
         ifgdplvDYGyGylFEJISwXZ+Y4PctOewFUXilUTDCiclrh3PicEr7nzq2VlzDg65yxTjG
         IP/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BQuE5p94CfqyEpHjKQoO3ghb1Rb0W+FJ1ncrC2gXf/s=;
        fh=n1qE1o1Bq/TvbdfeRijKkxeH7JqsCEV6Re2egIP5scs=;
        b=RpfZnw+d+64bPbR5wev9NTe68XO5CTi4X8s+KKeFWoFlt909x+01ZV6oNknQ0yHly1
         ddSS6bXhoB7sB8irexFxA6VrdFwzo5M+ok44v0rQc6ggnIKukY6I+FsR61XwGAe8oov4
         4VhhsSPXxpS/fDLnCLaZtN5KdDCh+0S3HDPFbBIMpZFT/5GuP2j1PCdpXLNCsQvGgHHV
         /marRPfeVw0nClgr/5RFhiH4STiQfKl3s0Pddo6pflY6aQLAvZy5w4jdPvQIxCNX6Ef7
         Z1Q6McoMlL/if6bdotBQWP1xfmR+Ih5d/AQO7nA6f/5Ji9my7gOFHntD8duJjcJhFjAB
         gt0g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785962136; x=1786566936; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BQuE5p94CfqyEpHjKQoO3ghb1Rb0W+FJ1ncrC2gXf/s=;
        b=qjqtGoMPXcXFCgW5+s5ZGuV1XDTs6JeSUabEUvmifiuzzjzJd43gWfGgL13OVGXKzf
         6TodvB4Wa1aJKNla+sz53gNLDllHxIfb/fSS5FVgTyBpFpJySxNCTS1xyxJE0x12j8tP
         bFNT79EW4MmrHpps81NWldOF31hGP2EnDJ/GqwfkwaBVi38bhMxuNq60Dim6AgpU8LzO
         +CtP4z/WwI44i4q1qvJO9+jJ2B3A/hcaj6ADYULpjTLk90+zTyKPuz5VI4ncK0uBzY3H
         +tchWcgROxHEUqI4xJrjUuJ2TfHMeNuWOxVovkFcWsKLPFrjMU8UHq6cX2/59lsas2dj
         KeTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785962136; x=1786566936;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BQuE5p94CfqyEpHjKQoO3ghb1Rb0W+FJ1ncrC2gXf/s=;
        b=J4JF2UtTY7XkvTfKcSSgG5Udqyx86JeodEtBHajncS6/b98FCr5WAaa9yW4/yQkDmc
         R1koTPA0FxsXuPoNbAtaxalvICPcDGw3XxJ0+tjC3DI46RMSl13yGaIKhJEqxkxCqxPX
         uTKNcEBAL30lx0vrMx0/vN+QF/plqFAqkyHwMyzXTD6dCJm6+7PmM48MN/UzCZ8nZooW
         Ihnh2f8H7BloGxbfDvSp7Y8UkWdz2xkfcxJB1SWVziaVVJbYoTxnYvyYirAhS1zrBU99
         YeSLMQSnqfoFpAKoZa0RfdWuGokBE6OZTCBWtZUzCnLYLUkPQ7eUuFrIKwIY9zksdqjN
         A7EA==
X-Forwarded-Encrypted: i=1; AHgh+RreOmtu1q1LeGwzdI1ROVOuc1BaNatkSO9Ewl8M5ibOHH+XamhjVW+mx7ueSjUAYrN2kinW@lists.linux.dev
X-Gm-Message-State: AOJu0YzUDT/4tppLveTF4GfPaYAUnY2PkdmxB4HU1L/sXMln9sev5E3e
	UpYQ5KQo9+pGf9AUDTk85a0HTiwvVRk4XCNP8iojL/LXym6MooX+0mSSTXXGGc9MzZk5BL7EuwL
	Qvq0Mk5nj/DZbPcdDvPZT4ytbt+kBNVs=
X-Gm-Gg: AR+sD13LTXri+M6l716HlFUfXvIPMQputmWVOXKw6aT3BbblUaxrnegsnJC/CDuGQOy
	iMZdunxRdOztI9xVRzrSdZbVqANAaLSYFDB1jWIXR3CPwviRT9v4TvGS47kn1po7DNKXUb0Rk2Y
	hAHln6i5xfIPdDgSVpjr0NAzddEMEVVR3uvTbuwDS91m8p/YusIHJb3dqFxf44KK1ssXCJmowv6
	4GAEIj0Yonmfgt9HRDFTfPEzW+th33mXz3K+WEnUcFF1dJNtXNHjTJjZf/Qs5dbZhaQKlxTxKrr
	yjpWOL76WChcLzFOnI7kejuqeDS6uAZPupUvi8JENiXy
X-Received: by 2002:a05:6820:4c89:b0:6aa:d97f:453b with SMTP id
 006d021491bc7-6ae96f98f86mr5123270eaf.28.1785962135693; Wed, 05 Aug 2026
 13:35:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1785621505.git.coshi036@gmail.com> <7f988ec74b5d1135d5d67771240639e57ba9e0f4.1785621505.git.coshi036@gmail.com>
 <liddhnv7367ifj3mk5qokdax5jexltpvbtxpkqpkt6qzolv7af@zll26cngckwl>
In-Reply-To: <liddhnv7367ifj3mk5qokdax5jexltpvbtxpkqpkt6qzolv7af@zll26cngckwl>
From: Chris S <coshi036@gmail.com>
Date: Wed, 5 Aug 2026 16:35:22 -0400
X-Gm-Features: AUfX_mzdjJBKSgnSNsYzRJsmY3qVZyWC6pZRSrcY0PRBQu9JTSn19N7htgMKD1Q
Message-ID: <CACd_6n0tmOQpams--XGDWcBWA9VTKgN1QOxU9i1FbbgnNCuqyw@mail.gmail.com>
Subject: Re: [PATCH 18/19] ext4, jbd2: report fast commit write errors with BH_Write_EIO
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

Done in v2 - 'success', no set_buffer_uptodate(), and the debug messages no=
w
talk about the write rather than the buffer:

     if (success) {
                   ext4_debug("%s: Block %lld written", ...);
     } else {
                   ext4_debug("%s: Block %lld write failed", ...);
                   mark_buffer_write_io_error(bh);
     }

Both arms kept so the tracing stays symmetric; patch 21 adds the
clear_buffer_write_io_error() to the first one.

Best,
Chao

On Tue, Aug 4, 2026 at 5:07=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Sat 01-08-26 18:01:02, Chao Shi wrote:
> > ext4_end_buffer_io_sync() is the third completion handler in this
> > series that reports a failed write by clearing BH_Uptodate, and
> > jbd2_fc_wait_bufs() is the only thing that looks at the result.
> > Convert both.
> >
> > They have to move in the same patch.  The handler lives in ext4 and
> > the wait in jbd2, but neither is used by anything else: the buffers
> > are ext4's fast commit blocks, submitted by ext4_fc_submit_bh() and
> > waited for by jbd2_fc_wait_bufs().  Converting one without the other
> > silently disables fast commit write error reporting.
> >
> > Signed-off-by: Chao Shi <coshi036@gmail.com>
> > ---
> >  fs/ext4/fast_commit.c | 2 +-
> >  fs/jbd2/journal.c     | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> > index 8e2259799614..8cd60c9f2272 100644
> > --- a/fs/ext4/fast_commit.c
> > +++ b/fs/ext4/fast_commit.c
> > @@ -213,7 +213,7 @@ static void ext4_end_buffer_io_sync(struct bio *bio=
)
> >       } else {
> >               ext4_debug("%s: Block %lld not up-to-date",
> >                          __func__, bh->b_blocknr);
> > -             clear_buffer_uptodate(bh);
> > +             mark_buffer_write_io_error(bh);
> >       }
>
> Again, this is only ever used for writes and buffer is guaranteed to be
> uptodate so please rename 'uptodate' to 'ioerr' and remove the setting of
> uptodate bit as well. And the ext4_debug() messages need slight update as
> well.
>
>                                                                 Honza
>
> >
> >       unlock_buffer(bh);
> > diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> > index 9e4cb04587b4..ffe7a22e6699 100644
> > --- a/fs/jbd2/journal.c
> > +++ b/fs/jbd2/journal.c
> > @@ -890,7 +890,7 @@ int jbd2_fc_wait_bufs(journal_t *journal, int num_b=
lks)
> >                * Update j_fc_off so jbd2_fc_release_bufs can release re=
main
> >                * buffer head.
> >                */
> > -             if (unlikely(!buffer_uptodate(bh))) {
> > +             if (unlikely(buffer_write_io_error(bh))) {
> >                       journal->j_fc_off =3D i + 1;
> >                       return -EIO;
> >               }
> > --
> > 2.43.0
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

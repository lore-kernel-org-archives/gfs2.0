Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F5A2797A5
	for <gfs2@lists.linux.dev>; Wed, 17 Sep 2025 19:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758139179; cv=none; b=P+1eq43+pZmR0rV8E8vg5L1LmU0u00lAqz52n5uGC0+Ry160f9mUbQah2vk/8UqjR5Ck7ShKv1bj949hsmSKUrBEeQY1LXisdKRWxd+PU//dyMZAKTlpZniocSEZ4zdSLYAbxrbqLoHGnPXDyNNwCAoUf9i+GjWq8LqSOGklZT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758139179; c=relaxed/simple;
	bh=lT+6fz4hGzB3x5TxZKL3rSaWn/F8+CECdWOTuWodsnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fcGF3ef2ddDC0JCZZ7q4+1Cqwx4ijkvD2RVHADlyNwXr7oe0NsBsIW/81Brr15Swmei9tvQtrXZBarVVcr8Fd8kdm0i0ifjCtmFeJqEqY21YOWuh9ItsIvHLxD/JT33ZpXS6IQtUM+dCA0qgDURtS08YugM30aEmOIthfWjdf20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2K9klTt; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2K9klTt"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b79773a389so2212801cf.1
        for <gfs2@lists.linux.dev>; Wed, 17 Sep 2025 12:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758139176; x=1758743976; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lT+6fz4hGzB3x5TxZKL3rSaWn/F8+CECdWOTuWodsnQ=;
        b=L2K9klTtaYyanFHDUOlG/auzSjIFdgfzi/ehGV97EpqZTh4+9gSzewjzjvz4XfEWfd
         FQ2CcTRFKgO4Kwsm/33dcFv8sSuqnPRbubznRyFUVosR7m7BCqhnRSNFvHuyF4DkCd4n
         FIhFcNIWWuQqWP6UsTq/A5X98OqOufJJtqiVntJQ0AF37k9yHYUZDzgDqMLRXasikk0Y
         8BALo8raw650GAZUheO+blopeCA2yvDzwVlT8GVrlpwznn81u6W5FXpbAB+5U8vZfuzt
         PBbw+kB4hgoG+Yng+u1Y3HtslWGFjAAkenNtLrZJmNwzbr9vOu2tNDpgZanO94agE0/B
         nogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758139176; x=1758743976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lT+6fz4hGzB3x5TxZKL3rSaWn/F8+CECdWOTuWodsnQ=;
        b=Ftedz18dFweHO7locZVJPhj40MSfZkOQm/hfjC56WfQhXNTxK/jZqqQkj2maCwZyLI
         xP5uf4eXCqiLd7wdXlQWOqpbGUiwnS8s5s7datFi8g0SC9zWrp602MqjHJKAJz2rtSvR
         jlaNdCrniEt0h+Xd8KtFQqWJwrqRahys4FnjjFAETOa4rsurAFx9yhLhvU+PyxOrUhm+
         gcxxLosJOWg/zPcx/RKO+pjyKr9gVRYypU4e7dAF3eEK8a1Tbyx+2CgScpAB6CWumOtC
         Itn0Rln4rutg8cwtuGk6ziZB5IWU5HQ1qZA4M5Fma2XrEKsdsgY4o2652T33eLQQZ55n
         5HeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw3K9Kr3ne0PmDXfFql5lFXO3dSHMskB4oVZkjXhgooJfAgqYoSloNVVf9Q3hGBGOFni1B@lists.linux.dev
X-Gm-Message-State: AOJu0YyxReNRxJEDX6wUoWTPowIpJPAoQ1AmPjzBnkEKNGsAPjAC8auR
	iEnpzmXeSg+pk89JZyJA+qIzvYZThhNPH8+ptmbLEuGyT7vO9c+3ZDPPYlgzCvM7yvLRESPvfFD
	+RIB/bDg/k3qpqqaq2ZlKfsLDK+vIwdg=
X-Gm-Gg: ASbGncsT9tXFR3JXy5ilk2+avCYcinS/9FGZ6fARS/APYWHHcLcvDj4+aynxK8GElRZ
	ud+j0nt61R6Yv1e2wv5eSgBDvLSWST4UWuca2NoagZIKc/+9bNFqoeyPgvpsOXhHWX7JFEHjLnt
	l4CtyDkhzWDDWv5OVtD96fun5LOOmMMYfe3ILgSA7IeP+jZ5N7D4whFwnWWCkS/fyf4JM4lvFaE
	aowyxZgLy7BV8gtn1lX8Q7Y6k9rD1pwTHwSPjxk97GIemAyiDIhkiwAu04=
X-Google-Smtp-Source: AGHT+IGMvsb9hFrlxwdIt/gNCY+ZXtdov7G+eqQ0YehxgnuYGPrrjhUsF8j6K/mIV15UQttqUMf4NVIbg9l0zFWT/EU=
X-Received: by 2002:ac8:5a03:0:b0:4b3:10f0:15ba with SMTP id
 d75a77b69052e-4ba6a20181amr52761081cf.39.1758139176357; Wed, 17 Sep 2025
 12:59:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250916234425.1274735-1-joannelkoong@gmail.com> <68ca71bd.050a0220.2ff435.04fc.GAE@google.com>
In-Reply-To: <68ca71bd.050a0220.2ff435.04fc.GAE@google.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 17 Sep 2025 12:59:25 -0700
X-Gm-Features: AS18NWC14gUDKzQcBj3qPbZdYHs2cE9cQhtC5cBOuvB6NHeNGl3mJTY7LRXGD5w
Message-ID: <CAJnrk1YKPWkaBXe7D2mftN2DMEBqFow80reUGE=2_U8oVFc1tQ@mail.gmail.com>
Subject: Re: [syzbot ci] Re: fuse: use iomap for buffered reads + readahead
To: syzbot ci <syzbot+ci9b5a486340e6bcdf@syzkaller.appspotmail.com>, 
	syzbot <syzkaller@googlegroups.com>
Cc: brauner@kernel.org, djwong@kernel.org, gfs2@lists.linux.dev, 
	hch@infradead.org, hch@lst.de, hsiangkao@linux.alibaba.com, 
	kernel-team@meta.com, linux-block@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, miklos@szeredi.hu, 
	syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 1:37=E2=80=AFAM syzbot ci
<syzbot+ci9b5a486340e6bcdf@syzkaller.appspotmail.com> wrote:
>
> syzbot ci has tested the following series
>
> [v3] fuse: use iomap for buffered reads + readahead
> https://lore.kernel.org/all/20250916234425.1274735-1-joannelkoong@gmail.c=
om
> * [PATCH v3 01/15] iomap: move bio read logic into helper function
> * [PATCH v3 02/15] iomap: move read/readahead bio submission logic into h=
elper function
> * [PATCH v3 03/15] iomap: store read/readahead bio generically
> * [PATCH v3 04/15] iomap: iterate over entire folio in iomap_readpage_ite=
r()
> * [PATCH v3 05/15] iomap: rename iomap_readpage_iter() to iomap_read_foli=
o_iter()
> * [PATCH v3 06/15] iomap: rename iomap_readpage_ctx struct to iomap_read_=
folio_ctx
> * [PATCH v3 07/15] iomap: track read/readahead folio ownership internally
> * [PATCH v3 08/15] iomap: add public start/finish folio read helpers
> * [PATCH v3 09/15] iomap: add caller-provided callbacks for read and read=
ahead
> * [PATCH v3 10/15] iomap: add bias for async read requests
> * [PATCH v3 11/15] iomap: move buffered io bio logic into new file
> * [PATCH v3 12/15] iomap: make iomap_read_folio() a void return
> * [PATCH v3 13/15] fuse: use iomap for read_folio
> * [PATCH v3 14/15] fuse: use iomap for readahead
> * [PATCH v3 15/15] fuse: remove fc->blkbits workaround for partial writes
>
> and found the following issues:
> * WARNING in iomap_iter_advance
> * WARNING in iomap_readahead
> * kernel BUG in folio_end_read
>
> Full report is available here:
> https://ci.syzbot.org/series/6845596a-1ec9-4396-b9c4-48bddc606bef
>
> ***
>
Thanks. Do you get run on every patchset that is sent upstream or is
it random? Trying to figure out if this means v2 is right and i just
messed up v3 or if you just didn't run on v2.

Thanks,
Joanne

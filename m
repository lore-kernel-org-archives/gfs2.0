Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EDA26A1AF
	for <gfs2@lists.linux.dev>; Mon, 23 Feb 2026 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861016; cv=none; b=k9lfa4lc5wwEoDMCD9TZXU1es5S5JBr95BmJf5yut8xRqyA/Hl8X4hFlfoYy+dcRrvg9RZ6jh2buqy9W6ROvV8twUFRx0UQifM0U5ilaoNGLN+QLwj3RAeSZsLzyFWv6UuJCg5lBImkr7hVX0UQijrUkiWfuNSDhRvZ6jkFmoxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861016; c=relaxed/simple;
	bh=QgzwhWHfL5HE5kt8p7liWozM4mZ4QkXl1YM7DII1drc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i5GZU1PPOjZV6esV+7Vqis1QYTzrLmPLLX2XLF/2jFeNXM2LnBIuVDOjIQ0NqalmymnAO3GxyEQ+TUC1wTsCCsBSS+t7hmw1+BDSWOfbOWdMtvq6FutVpBf03iZgehF6V5INFgU964JXU985VHiVYTQx1kpuRlDrYKfeMepWQQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZEjb/jJU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZEjb/jJU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771861013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Ya8PzuLzaDTAGKlZ38+DN9SYivC4DKKpFUaUgf5j0k=;
	b=ZEjb/jJURKcLPiDBaPpKhWjRdFBidLVcZ+OBlEehSodSwCuT0TFBKqaqBOVxPmCZVh89lk
	glZH4IAKzkakLUnVlvaG8QvwNO4IATJH7Wdta5SrnrSE1RSbukqASgv/SFYjnIjUUyxTnc
	focdxFQ0+1U8cFVct9nR5jWgGQhq3hs=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-JWlJElaIP9CH_FeFSykJ8A-1; Mon, 23 Feb 2026 10:36:52 -0500
X-MC-Unique: JWlJElaIP9CH_FeFSykJ8A-1
X-Mimecast-MFC-AGG-ID: JWlJElaIP9CH_FeFSykJ8A_1771861012
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7985333d204so4463487b3.0
        for <gfs2@lists.linux.dev>; Mon, 23 Feb 2026 07:36:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771861012; x=1772465812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Ya8PzuLzaDTAGKlZ38+DN9SYivC4DKKpFUaUgf5j0k=;
        b=PZrwYlQaRKXS4n8OjSCOm8PwE5Cgen9NY3xbFMwwYGg2JVJlGYqzZa7jo7opeywxd9
         k3AwsmafTZUDzB6WiOEj0q9lCAwj+SXNC9pBkiPmjrlytImM0a+atRyE45FVCtT0fkCq
         yyGIKg4r4OYKLWin8nSX57Sb70hSjghpQQ34q5z+vEZRJooGu+mIzxQ78Wore5U5J/os
         cjzw2Y8YI2S8rNhKx0nzC369s1trP3pGoSlvAi4jMyEYn3ZQTBvimnVlCfqz/YoSrkQB
         lvWwFqodmZj/+VXfgAkuIgszMgqx4uylbjAvxW/QipI1PVR+XPEfvo0nGEQVDwEa3wUZ
         ZScA==
X-Forwarded-Encrypted: i=1; AJvYcCVLEc1tT3n7+7xIkWJ6hOhhIyWX7teCqDR+9MVynBOutFIqxG8AEtJxiICwgLaQ6qT0+xmt@lists.linux.dev
X-Gm-Message-State: AOJu0YyUDAsZHytWDtOuOW685lgmpg7PRMV3I5c0TS7dfnMKHtLNaZF9
	MyV78NuSUlK0Q4OFE9U5SuTs7Jzdp/Z55zhnulh4E8ndaNYs+Tv0MvjXJMUXlK9ZEQSbshBiK8o
	7FJv/ugJqiByMrvjAUO9k/k4gevCRoN27p9c7ynTGXjFL2TbYtCvcNtTO5Gzv1tlI+raPm5ccwh
	ybIojFcjt9XVsZqqsKZq9uwNYzU3ozWQ==
X-Gm-Gg: ATEYQzyWMRmTPTJKZSnp/LzE9GhjlBUbw+fl+ojDslhDEFCZn7vMBIpX5n61qp2AsXm
	AbvRlUDfnnwZ58YCT5qnTuuaWo6B7IakQs9EJuYkF5feSreUWi9Vsy/bLhHW7hLq6k2j+uHM42v
	w4jOWoJjCL7yp+gZcCbssgFCtiGNoRje+nZIUd+/ikdpA76xukvIN6R3NKgtsNvaTlbWQbASPGI
	AsP4pa3xIlt1NaYEfEZ/fX2mSZM/TBaJrMqT2+YCzI/cXnyAEkjddY+2mq1NtKP6w==
X-Received: by 2002:a53:ac8f:0:b0:64c:9750:6b1b with SMTP id 956f58d0204a3-64c97506b96mr860691d50.40.1771861011978;
        Mon, 23 Feb 2026 07:36:51 -0800 (PST)
X-Received: by 2002:a53:ac8f:0:b0:64c:9750:6b1b with SMTP id
 956f58d0204a3-64c97506b96mr860664d50.40.1771861011520; Mon, 23 Feb 2026
 07:36:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <6993b6a3.050a0220.340abe.0775.GAE@google.com> <20260217-fanshop-akteur-af571819f78b@brauner>
 <177131956603.8396.12634282713089317@noble.neil.brown.name>
 <177136673378.8396.7219915415554001211@noble.neil.brown.name>
 <20260219-kitzeln-vielmehr-22b6ce51bf5a@brauner> <177153754005.8396.8777398743501764194@noble.neil.brown.name>
In-Reply-To: <177153754005.8396.8777398743501764194@noble.neil.brown.name>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 23 Feb 2026 16:36:39 +0100
X-Gm-Features: AaiRm53sUjN8-cTwnNFToBiYpkAXEz9qZd9i7Z7AVLKQMvcvaqFgVcKnPAsHhs4
Message-ID: <CAHc6FU4jJ16g8nLdBdUhZDa+q0P2BJqU-5BxLAF0xWgj4ZpixA@mail.gmail.com>
Subject: Re: [syzbot] [gfs2?] WARNING in filename_mkdirat
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, gfs2@lists.linux.dev, 
	syzbot <syzbot+0ea5108a1f5fb4fcc2d8@syzkaller.appspotmail.com>, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WXVzA25eSxzcoIPnB9niQIAdck2M8RCEY4Bj2UVVSQs_1771861012
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 10:45=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrot=
e:
> On Thu, 19 Feb 2026, Christian Brauner wrote:
> > On Wed, Feb 18, 2026 at 09:18:53AM +1100, NeilBrown wrote:
> > > On Tue, 17 Feb 2026, NeilBrown wrote:
> > > > On Tue, 17 Feb 2026, Christian Brauner wrote:
> > > > > On Mon, Feb 16, 2026 at 04:30:27PM -0800, syzbot wrote:
> > > > > > Hello,
> > > > > >
> > > > > > syzbot found the following issue on:
> > > > > >
> > > > > > HEAD commit:    0f2acd3148e0 Merge tag 'm68knommu-for-v7.0' of =
git://git.k..
> > > > > > git tree:       upstream
> > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D153=
31c02580000
> > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dac0=
0553de86d6bf0
> > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D0ea51=
08a1f5fb4fcc2d8
> > > > > > compiler:       Debian clang version 21.1.8 (++20251221033036+2=
078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> > > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1=
46b295a580000
> > > > > >
> > > > > > Downloadable assets:
> > > > > > disk image (non-bootable): https://storage.googleapis.com/syzbo=
t-assets/d900f083ada3/non_bootable_disk-0f2acd31.raw.xz
> > > > > > vmlinux: https://storage.googleapis.com/syzbot-assets/b7d134e71=
e9c/vmlinux-0f2acd31.xz
> > > > > > kernel image: https://storage.googleapis.com/syzbot-assets/b186=
43058ceb/bzImage-0f2acd31.xz
> > > > > > mounted in repro: https://storage.googleapis.com/syzbot-assets/=
bbfed09077d3/mount_1.gz
> > > > > >   fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.lo=
g?x=3D106b295a580000)
> > > > > >
> > > > > > IMPORTANT: if you fix the issue, please add the following tag t=
o the commit:
> > > > > > Reported-by: syzbot+0ea5108a1f5fb4fcc2d8@syzkaller.appspotmail.=
com
> > > > >
> > > > > Neil, is this something you have time to look into?
> > > >
> > > > The reproducer appears to mount a gfs2 filesystem and mkdir 3
> > > > directories:
> > > >   ./file1
> > > >   ./file1/file4
> > > >   ./file1/file4/file7
> > > >
> > > > and somewhere in there it crashes because vfs_mkdir() returns a
> > > > non-error dentry for which ->d_parent->d_inode is not locked and
> > > > end_creating_path() tries to up_write().
> > > >
> > > > Presumably either ->d_parent has changed or the inode was unlocked?
> > > >
> > > > gfs2_mkdir() never returns a dentry, so it must be returning NULL.
> > > >
> > > > It's weird - but that is no surprise.
> > > >
> > > > I'll try building a kernel myself and see if the reproducer still f=
ires.
> > > > if so some printk tracing my reveal something.
> > >
> > > Unfortunately that didn't work out.
> > > Using the provided vmlinux and root image and repro, and a syzkaller =
I
> > > compiled from current git, I cannot trigger the crash.
> > >
> > > I'll have another look at the code but I don't hold out a lot of hope=
.
> >
> > There's at least a proper C repro now.
> >
>
> Yes - and with the new C repro I can trigger the bug.
>
> The problem is in gfs2.  gfs2_create_inode() calls d_instantiate()
> before unlock_new_inode().  This is bad.  d_instantiate_new() should be
> used, which makes sure the two things happen in the correct order.
>
> Key to understanding the problem is knowing that unlock_new_inode()
> calls lockdep_annotate_inode_mutex_key() which (potentially) calls
>   init_rwsem(&inode->i_rwsem);
>
> So if anyone has locked the inode before unlock_new_inode() is called,
> the lock is lost when i_rwsem is reinitialised.
>
> The reproducer calls mkdir("a") and mkdir("a/b") concurrently from
> separate threads.  The second mkdir() often fails (I assume) because "a"
> cannot be found.  But if that second mkdir() runs just after gfs2 has
> called d_instantiate(), then the lookup of "a" will succeed and so the
> inode will be locked ready for mkdir..  Then the mkdir("a") completes
> calling unlock_new_inode() which reinitialised i_rwsem.  When
> mkdir("a/b") comes to lock the parent, it finds that it isn't locked any
> more.
>
> There is non-trivial code between the d_instantiate() call and the
> unlock_new_inode() call which I do not understand.  So I will not
> propose a patch.  I don't know if that code should be after
> d_instantiate_new(), or before it.
>
> So I'll leave that to Andreas.

Thanks a lot, Neil, I've added a fix to for-next.

Andreas


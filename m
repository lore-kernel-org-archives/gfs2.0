Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EA043550A
	for <gfs2@lists.linux.dev>; Wed, 23 Sep 2026 05:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142891; cv=none; b=U6uiJJQPre3GZ+f+N3kOGJK4oyijEOILR7BxnuEJMkNiL1+fqOIIfGZIJzscFuDI1fvEG4Qw1puOPO2kKSvTjGOs5ddF2bqunNYoZUX2LBGx5FKv1+J0FBY8VkCMvRp2EamiBq6RTuGPzYX5Z0nzdXmg4KJYJvmXafiv39EIW4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142891; c=relaxed/simple;
	bh=LgWVLK6gvdnHJpUDwHlN4pWuYgqNDy3TE0yb4Pj2fOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ik5UUVYQULXVtA5mVlc94RGcxrwHwMnGVHViUAdXKkfmvxq92ZrUV+gjpKbQOISZa5tzKzjETTrbX7yv1OM9phSuzGkYx+sVQnBUNyMTL2Mq7kKDAob1fhGd86KPJXJGYxucxYkowU0Mbr6AQLPDaxsogvTtR4ymgz9yrxCnzvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V99dB3Jr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V99dB3Jr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CCE1F008A2
	for <gfs2@lists.linux.dev>; Wed, 23 Sep 2026 05:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790142890;
	bh=5PfmXhl6pDJmGcZOb1arBTuyqaLDSoD3cVhEOoKPAdQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=V99dB3JrkZhguCQMe73DpkKm5ga/wgdhAeU10Odkp5oidtzXF+GobjFN4c6raj2FF
	 d8CCEPgDU/9vILbZ+Y5suPYhGuEUvAoVPTRwSuJMFGbvxtRYrqGncE9/V6iG4OrRA1
	 nb2vgLQfX/BMPWGrd5oWhhYUfG0TsmWLiNFZXOkSaWy7i0n5O7Ie9W+eW4bWpwCZvI
	 OWwo4+BmZcDQAtweiYHT6NtphmBiH20ohuKpJ4FbFp9HMu/Vas4SV7XgAw5SxW1cXY
	 YKRYJbC49vEZVfi8du19hFgFi/0/vFZrFqs6vlwmESvEiZOKyref2uEpgFBjHfnu9y
	 vP2Dj7Gies+xA==
Received: by mail-ej2-f36.google.com with SMTP id a640c23a62f3a-c254f9f0b1eso77155266b.1
        for <gfs2@lists.linux.dev>; Tue, 22 Sep 2026 22:54:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzUdj/pcKHtvrUaXa8wUCOiS4lfveInb5M1npl0BoweniBdoVAK3xbw/kH4TTtfPClYIpxL@lists.linux.dev
X-Gm-Message-State: AFuF++nQsOnnvMHjJn5VC1A72G273nSn6JQg7fbAs+QhPWoxXODMENWN
	7axUULuURNxFsWPle44lTmc+G5qQMlwOa19RWh5AvtjgGqq8tOtoDBK5O4N6vjBbB5LjlGV08z7
	YSior0WGe28Ynvm3ef9gBFsEguPGhKZY=
X-Received: by 2002:a17:907:ea93:b0:c29:4490:50c8 with SMTP id
 a640c23a62f3a-c2aada6a9c9mr122986066b.8.1790142888439; Tue, 22 Sep 2026
 22:54:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260919022441.3305170-1-neilb@ownmail.net> <20260919022441.3305170-6-neilb@ownmail.net>
In-Reply-To: <20260919022441.3305170-6-neilb@ownmail.net>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 23 Sep 2026 14:54:36 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9W3O=Dsavu4=XUp+3SyFWOL3Bs7fbzg0YBFpwk4-TCAA@mail.gmail.com>
X-Gm-Features: AclHuK8GYgU6BX6NCq2-6QNZx7GNKhZ3196sjTH0JZehxyF3dSZODayjCY9JTRw
Message-ID: <CAKYAXd9W3O=Dsavu4=XUp+3SyFWOL3Bs7fbzg0YBFpwk4-TCAA@mail.gmail.com>
Subject: Re: [PATCH v2 05/14] cifs: allow -EISDIR precedence over -EFTYPE in __cifs_do_create()
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, Jori Koolstra <jkoolstra@xs4all.nl>, 
	Mateusz Guzik <mjguzik@gmail.com>, Dorjoy Chowdhury <dorjoychy111@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev, 
	Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	Paulo Alcantara <pc@manguebit.org>, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 11:25=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrot=
e:
>
> From: NeilBrown <neil@brown.name>
>
> If atomic_open is given __O_REGULAR, we now would prefer -EISDIR
> if a directory was found.  So move the S_ISDIR() tests earlier.
>
> Also don't return -EFTYPE for S_ISLNK() - that should get -ELOOP and only
> if O_NOFOLLOW.
Simply exempting symlinks from the __O_REGULAR check in cifs is not
sufficient. Once this check allows the symlink through,
cifs_atomic_open() still calls finish_open() on it, setting
FMODE_OPENED. open_last_lookups() then skips symlink traversal, so
do_open() returns -EFTYPE before may_open() can return -ELOOP. This
path also reaches cifs_new_fileinfo(), which pins the symlink dentry
with dget(). The symlink's file operations do not provide CIFS's
.release handler, so the failed open does not call cifs_close() to
release that reference.

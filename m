Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3A9FBFC
	for <gfs2@lists.linux.dev>; Fri,  2 Feb 2024 04:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706848482; cv=none; b=Y+MtXdVoNtksVr2xbhvDszQ2s2ezCbGJngT1H9e3lDISdURfKCrTU+AlsU/HkE+uQhbBW9wmmdAciahIESvJNQcU6RRbPGqEditP2kXVca9DJS4NdMvdT4eytBUYZlFgdoFpDOfD0n1l3dmko43/Gb854ulFT6PLRTfPakmAUQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706848482; c=relaxed/simple;
	bh=hgL9YkagckXzBKYyYP5dgicZLWlJMtpbHI94lESSGP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YakOuVwlFqckYgL2mrJB9dRLClKVVMnVRdEsBgxGCpVzBS7ypNMm745XEFqfx1MxU1vsiJm3TbCvKYQAMn23EImw4Ag8X+5KK7plTOyTe+P1cKzQVimAG3dk5Tr/hr8H5t0kL/JfCLdVsb9VH2YwCpmD/Wx0CZYqZSIuwv0bZkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=R7sHMUq4; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="R7sHMUq4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9wGTNx8XIpjkPZzcOIUbsKBNUD/48xuX+ePmIu/z/bw=; b=R7sHMUq41VH4oX4k/GohsRqOih
	08nEJstnqCqptJ/SpmOGM8+500XXreVFeEUGTUR7rzvyld77ZiItYKv5lbrmC/7geBE2E93Y5DpRg
	j36bypPwgc7li0UbFW4Qx6B4aOlDn7LMTc7ctdr/1ut6m31PWs/pzRlmaLgj8Ev4gUTfgBJETV0SG
	XARq8ipXAWw8pOXxmuiTn2NAr6GOmZdQb84I8JfGV3BOBSoNPovY5/zTpxlh+LDTcOFfH8cSQ1Are
	8GSVNq4Kbg9lOYXcFaw+YUnRRN+wg0HOVapT8p3+5w8cjD2m+wV5Gn2LNYZkmY7begeMrz4Quh2aI
	GXhrl2Sg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rVlGA-003f12-2a;
	Fri, 02 Feb 2024 04:34:38 +0000
Date: Fri, 2 Feb 2024 04:34:38 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev
Subject: Re: [PATCH 0/9] gfs2: Bugs in "Use GL_NOBLOCK flag for non-blocking
 lookups"
Message-ID: <20240202043438.GA871762@ZenIV>
References: <20240119212056.805617-1-agruenba@redhat.com>
 <20240202042312.GY2087318@ZenIV>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202042312.GY2087318@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 02, 2024 at 04:23:13AM +0000, Al Viro wrote:
> On Fri, Jan 19, 2024 at 10:20:47PM +0100, Andreas Gruenbacher wrote:
> > Hello,
> > 
> > Al Viro has reported issues with commit dd00aaeb3432 ("gfs2: Use
> > GL_NOBLOCK flag for non-blocking lookups"):
> > 
> > * First, parent can now be NULL and dereferencing it in
> >   gfs2_dir_check(d_inode(parent), &dentry->d_name, ip) isn't going to
> >   work;
> > 
> > * Second, gfs2_dir_check() can still sleep, which breaks LOOKUP_RCU
> >   mode.
> 
> Looks sane, but there's another piece of fun in gfs_permission():
>         gl = rcu_dereference_check(ip->i_gl, !may_not_block);
>         if (unlikely(!gl)) {
>                 /* inode is getting torn down, must be RCU mode */
>                 WARN_ON_ONCE(!may_not_block);
>                 return -ECHILD;
>         }
>         if (gfs2_glock_is_locked_by_me(ip->i_gl) == NULL) {
>                 int noblock = may_not_block ? GL_NOBLOCK : 0;
>                 error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED,
>                                            LM_FLAG_ANY | noblock, &i_gh);
>                 if (error)
>                         return error;
>         }
> 
> See the problem?  In RCU mode we carefully fetch ->i_gl and verify
> it's not NULL.  Then we proceed to dereference it again.
> 
> IOW, these ip->i_gl below ought to be replaced with gl, or you are
> risking a compiler fetching the sucker again and getting NULL this
> time around.

fix breakage in gfs2_permission()

"gfs2: Use GL_NOBLOCK flag for non-blocking lookups" has
reintroduced the bug fixed in "gfs2: fix an oops in
gfs2_permission" a while ago.  We still fetch ->i_gl carefully,
and check if it's NULL, but then we proceed to fetch it again.
If it became NULL in the meanwhile, we get trouble...

Trivial to fix, fortunately.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 6bfc9383b7b8..d045562bf08f 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1882,9 +1882,9 @@ int gfs2_permission(struct mnt_idmap *idmap, struct inode *inode,
 		WARN_ON_ONCE(!may_not_block);
 		return -ECHILD;
         }
-	if (gfs2_glock_is_locked_by_me(ip->i_gl) == NULL) {
+	if (gfs2_glock_is_locked_by_me(gl) == NULL) {
 		int noblock = may_not_block ? GL_NOBLOCK : 0;
-		error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED,
+		error = gfs2_glock_nq_init(gl, LM_ST_SHARED,
 					   LM_FLAG_ANY | noblock, &i_gh);
 		if (error)
 			return error;

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795205552;
	b=T5jFXj/HhncsakV3DRHVGLCRj/PXWKUc4V6hpLxPPsmqyaNdtCDWq0StlDNpdgQLzuZD
	 u3z9djovh3Hp0vho6nBxdn6h8dFB9sTq5MzM72Awnvx9tk8GLOMyZOxoMEXigl0AwrS8q
	 RXpS92MA4fTs/eHWALH57L4HYL1wcm/zahYM8L2O0CJ3eVYACi5ZBtzKlOCi6mLNUjdyA
	 /ZA+VITJ/8esy23nCI2KgkMN1tU1msbTXcpXExPRdPsjsOAeKbbPeE5e6aOcrDkBukvJR
	 PD0GumWrL2biCFANEdjulImdginm2ROOXwgGTWOSX3brC92O9mWblDLL5rSkuv19ZtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795205552;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7ilVvSg7iJtnInS9D81qUJjJeJBId3XAEWRAFvFdydM=;
	b=n6Ku9/jgVfSJN2f7Ze4I6bxBODYFF1hCHW5HzJwNbfjG2DmIM7+c+d5pfUfNVdO/Zn40
	 hLiEkyqpwykQ9nwaK65Z5TCY98FvtaBdvXKYwDFVawqVldSPNvuoEA/8TqpzYM+9pBaMg
	 9KDpIqrySJxgQbWA6LxpT2IjSa6Zx/2hdWHgNUtZbz9Rls73AXwZs8cFD8akfgkeGI46u
	 pwq8iI7SaIW06ZwI+5rgrrlYP9ZfrO/44T6+9BwJEAPjMXYEoUmStuK6z42dqFJNXJzrB
	 FCkgN/Ukerf4UdwlQbj0dWg21exu5BAMFJCjIqrRf/quNBp+RbZZY+UE245Uk8GD1gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FArlZniC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A5B606A6FC
	for <gfs2@lists.linux.dev>; Fri, 20 Nov 2026 20:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FArlZniC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE801F000C0;
	Fri, 20 Nov 2026 20:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795205551;
	bh=7ilVvSg7iJtnInS9D81qUJjJeJBId3XAEWRAFvFdydM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FArlZniCUObJgaMIMX7i9OBz+FvlBepGgYEzQl7ur1wmWYtl536q5wfwzVWu/vJ2H
	 IeCcKbm1vHhJGDkCifLrSC9QJQKdqjA6hKylV5X3XVBw9B9zzuhGnQiRC5NgLZNzGR
	 LP4W1Yknkg4bj4JPpVq1pm7yoMj3/8NBMWJsTERsUJ5LfAzV1n+i9Pmvy+fU8rJiGO
	 YI30oeXQlrgqGxkR5Hw47YgoXIl48LpHFs7gb60HAUsf+Qahd3djunQ+7+Bf3ahKRv
	 B/FzIeA8tydB1N+CMxwmUyIi310L4X/JhDUaL6GqL5571I1zrH3iOhAWzctbeppOjo
	 lS5qyBJKBw+cA==
Message-ID: <sashiko-outbox-226014@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 RESEND v7.4-rc3 3/5] dlm: don't publish a lkb in
 ls_lkbxa before it has an rsb
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Aring" <aahringo@redhat.com>, teigland@redhat.com
Cc: gfs2@lists.linux.dev
In-Reply-To: <20261120200040.257152-4-aahringo@redhat.com>
References: <20261120200040.257152-1-aahringo@redhat.com>
 <20261120200040.257152-4-aahringo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 20:12:30 +0000
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] dlm: __put_lkb() erases active ls_lkbxa entry on find_rsb()
  failure
--

commit c68d5fa6b30984a97220ff35d349c3276a988660
Author: Yogesh Gaur <yogeshgaur.83@gmail.com>

dlm: don't publish a lkb in ls_lkbxa before it has an rsb

This commit moves the allocation of lkb_id and insertion of the lkb into
ls_lkbxa from create_lkb() to attach_lkb() so that find_lkb() never returns
an lkb with a NULL lkb_resource.

> diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
> index c715e171bab7e..3b3e15157f4c9 100644
> --- a/fs/dlm/lock.c
> +++ b/fs/dlm/lock.c

[ ... ]

> @@ -6300,12 +6324,14 @@ int dlm_debug_add_lkb(struct dlm_ls *ls, uint32_t=
 lkb_id, char *name, int len,
>  	if (!lksb)
>  		return -ENOMEM;
> =20
> -	error =3D _create_lkb(ls, &lkb, lkb_id, lkb_id + 1);
> +	error =3D create_lkb(ls, &lkb);
>  	if (error) {
>  		kfree(lksb);
>  		return error;
>  	}
> =20
> +	lkb->lkb_id =3D lkb_id;
> +
>  	dlm_set_dflags_val(lkb, lkb_dflags);
>  	lkb->lkb_nodeid =3D lkb_nodeid;
>  	lkb->lkb_lksb =3D lksb;
> @@ -6321,7 +6347,15 @@ int dlm_debug_add_lkb(struct dlm_ls *ls, uint32_t =
lkb_id, char *name, int len,
>  	}

[Severity: Medium]
Can setting lkb->lkb_id before find_rsb() cause __put_lkb() to erase an
existing lkb's entry in ls_lkbxa if find_rsb() fails?

attach_lkb() clears lkb->lkb_id on failure for that reason, but if
find_rsb() fails first (for example, with -EINVAL when len >
DLM_RESNAME_MAXLEN), dlm_debug_add_lkb() calls __put_lkb(ls, lkb) while
lkb->lkb_id still holds the caller-supplied id, and xa_erase() removes any
live lkb already occupying that id from ls_lkbxa.  Setting lkb->lkb_id
right before attach_lkb() would avoid this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120200040.2571=
52-1-aahringo@redhat.com?part=3D3

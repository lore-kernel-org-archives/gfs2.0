Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C91521C16A
	for <gfs2@lists.linux.dev>; Thu, 29 May 2025 09:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748511197; cv=none; b=M5d3lNjtoblBvNXqGxdkCon0E61mUAnWKNE044aMCwnvaSty/U2uxefct8XfsKGKukFfxGyy7ZT4bX3zkLX44eIOkNniyFnStSbFE3cuyJzUSw/ccHExD++GT2+VIR8G6dzd3nozylvLtD+fctjYsKo3nsbLONtHnN7dXTzxp0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748511197; c=relaxed/simple;
	bh=FHrzivjelgW1YaMIYFcCeYmEkFrLISnEhXErpQBccUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=qIVv7mCPSqi+Pagy18SAaA/9xm9NEjKvomeKr8XwjEpl/FiergmUKjOFx3meoGaFaAVnWuLdL9Mg5lQIwyfTknvunopHEP1mFhIKbz3/XaRsseKEDHf224pgpynrfXQIPjqfcQY1vRbQQr9126X0L+nYEdywIQWTcF6aD/obOOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NGUldi8X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NGUldi8X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748511194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=527ljAkexsagpGwYiYlvEBczn5yffazhdG6BiSCtuas=;
	b=NGUldi8X3gVUtBroDN6J0rxdERv3UsX73rCzdwGszV73AZ9OAFySzeV7q9rrlY8AIepa91
	nn1+Kluct+fGA76E/GdgfNVznZVhBj6TgjXV2idNfd3/8e2rNUhuX4qJhz7378rR/NszyS
	e3sgNIV+rj7WhgNdPmAbpUw/hVIoH5g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-Ii83f9udOD6zBf5gxHGLiA-1; Thu,
 29 May 2025 05:33:11 -0400
X-MC-Unique: Ii83f9udOD6zBf5gxHGLiA-1
X-Mimecast-MFC-AGG-ID: Ii83f9udOD6zBf5gxHGLiA_1748511190
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EFACC1956089;
	Thu, 29 May 2025 09:33:09 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.167])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1CA3D18001DA;
	Thu, 29 May 2025 09:33:07 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Andrew Price <anprice@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev,
	syzbot+b12826218502df019f9d@syzkaller.appspotmail.com
Subject: Re: [PATCH] gfs2: Don't clear sb->s_fs_info in gfs2_sys_fs_add()
Date: Thu, 29 May 2025 11:33:05 +0200
Message-ID: <20250529093306.2049425-1-agruenba@redhat.com>
In-Reply-To: <20250528150237.171254-1-anprice@redhat.com>
References: <20250528150237.171254-1-anprice@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4Agz8RPPqn6DZibC_XtDwYm8WN9NWwjkUMtsaS6eFiU_1748511190
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset="US-ASCII"; x-default=true

Hi Andy,=0D
=0D
On Wed, May 28, 2025 at 5:02=E2=80=AFPM Andrew Price <anprice@redhat.com> w=
rote:=0D
> When gfs2_sys_fs_add() fails it sets sb->s_fs_info to NULL which results=
=0D
> in a NULL pointer deref in gfs2_drop_inode() when iput(sdp->sd_inode) is=
=0D
> called in the gfs2_fill_super() error path. Remove the NULL assignment=0D
> from gfs2_sys_fs_add() and let gfs2_fill_super() deal with it instead,=0D
> after the iput().=0D
>=0D
> Fixes: ae9f3bd8259a ("gfs2: replace sd_aspace with sd_inode")=0D
> Reported-by: syzbot+b12826218502df019f9d@syzkaller.appspotmail.com=0D
> Signed-off-by: Andrew Price <anprice@redhat.com>=0D
> ---=0D
>  fs/gfs2/sys.c | 1 -=0D
>  1 file changed, 1 deletion(-)=0D
>=0D
> diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c=0D
> index 748125653d6c..c3c8842920d2 100644=0D
> --- a/fs/gfs2/sys.c=0D
> +++ b/fs/gfs2/sys.c=0D
> @@ -764,7 +764,6 @@ int gfs2_sys_fs_add(struct gfs2_sbd *sdp)=0D
>         fs_err(sdp, "error %d adding sysfs files\n", error);=0D
>         kobject_put(&sdp->sd_kobj);=0D
>         wait_for_completion(&sdp->sd_kobj_unregister);=0D
> -       sb->s_fs_info =3D NULL;=0D
>         return error;=0D
>  }=0D
>=0D
> --=0D
> 2.49.0=0D
>=0D
=0D
This is interesting, thank you. I've been puzzling over the same bug=0D
report, but didn't get as far.=0D
=0D
Looking through history, this assignment was added in commit=0D
0d515210b696 ("GFS2: Add kobject release method"), and it should=0D
probably have been paired with the kfree() but not the kobject_put()=0D
right then: the idea seems to be to clear sb->s_fs_info before freeing=0D
the object sb->s_fs_info points to. The freeing is meanwhile done in=0D
free_sbd(), so I'm wondering if we shouldn't clean things further, as=0D
below.=0D
=0D
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c=0D
index 8a4cdd961e5f..a19d7e431c8e 100644=0D
--- a/fs/gfs2/ops_fstype.c=0D
+++ b/fs/gfs2/ops_fstype.c=0D
@@ -64,7 +64,10 @@ static void gfs2_tune_init(struct gfs2_tune *gt)=0D
=20=0D
 void free_sbd(struct gfs2_sbd *sdp)=0D
 {=0D
+=09struct super_block *sb =3D sdp->sd_vfs;=0D
+=0D
 =09free_percpu(sdp->sd_lkstats);=0D
+=09sb->s_fs_info =3D NULL;=0D
 =09kfree(sdp);=0D
 }=0D
=20=0D
@@ -1314,7 +1317,6 @@ static int gfs2_fill_super(struct super_block *sb, st=
ruct fs_context *fc)=0D
 =09iput(sdp->sd_inode);=0D
 fail_free:=0D
 =09free_sbd(sdp);=0D
-=09sb->s_fs_info =3D NULL;=0D
 =09return error;=0D
 }=0D
=20=0D
diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c=0D
index 748125653d6c..c3c8842920d2 100644=0D
--- a/fs/gfs2/sys.c=0D
+++ b/fs/gfs2/sys.c=0D
@@ -764,7 +764,6 @@ int gfs2_sys_fs_add(struct gfs2_sbd *sdp)=0D
 =09fs_err(sdp, "error %d adding sysfs files\n", error);=0D
 =09kobject_put(&sdp->sd_kobj);=0D
 =09wait_for_completion(&sdp->sd_kobj_unregister);=0D
-=09sb->s_fs_info =3D NULL;=0D
 =09return error;=0D
 }=0D
=20=0D


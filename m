Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA011CA95
	for <gfs2@lists.linux.dev>; Mon, 30 Oct 2023 21:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zpni/Q2b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698701628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZCwIol1O9emLb/xQkMl+VRVpgLA1EX0Lzk5DoGLZD/0=;
	b=Zpni/Q2bbq5aGId9J1XRzhjKrkJrBZKlhrOBjWhCUZyANMhabQQR5fVa4N3Q6kJlqX/xcS
	mTxySmsFb7lOravobzG7pgXop2I8xUDTbqTOG98iCe3rkFDNA/5hEwFHx2LD+YGrQG/CnH
	/i39rJ7y45UDiVu+X0QLQEPjiEcr7R4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-dEZ_t_cXP567Tjxtl3-f3g-1; Mon, 30 Oct 2023 17:33:35 -0400
X-MC-Unique: dEZ_t_cXP567Tjxtl3-f3g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A3E69101A529;
	Mon, 30 Oct 2023 21:33:34 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BB7675027;
	Mon, 30 Oct 2023 21:33:33 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev,
	syzkaller-bugs@googlegroups.com,
	syzbot+3e5130844b0c0e2b4948@syzkaller.appspotmail.com
Subject: [PATCH] gfs2: Silence "suspicious RCU usage in gfs2_permission" warning
Date: Mon, 30 Oct 2023 22:33:31 +0100
Message-ID: <20231030213332.793030-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Commit 0abd1557e21c added rcu_dereference() for dereferencing ip->i_gl=0D
in gfs2_permission.  This now causes lockdep to complain when=0D
gfs2_permission is called in non-RCU context:=0D
=0D
    WARNING: suspicious RCU usage in gfs2_permission=0D
=0D
Switch to rcu_dereference_check() and check for the MAY_NOT_BLOCK flag=0D
to shut up lockdep when we know that dereferencing ip->i_gl is safe.=0D
=0D
Fixes: 0abd1557e21c ("gfs2: fix an oops in gfs2_permission")=0D
Reported-by: syzbot+3e5130844b0c0e2b4948@syzkaller.appspotmail.com=0D
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>=0D
=0D
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c=0D
index 79e96130ef9e..425bf4e90448 100644=0D
--- a/fs/gfs2/inode.c=0D
+++ b/fs/gfs2/inode.c=0D
@@ -1867,6 +1867,7 @@ static const char *gfs2_get_link(struct dentry *dentr=
y,=0D
 int gfs2_permission(struct mnt_idmap *idmap, struct inode *inode,=0D
 =09=09    int mask)=0D
 {=0D
+=09int may_not_block =3D mask & MAY_NOT_BLOCK;=0D
 =09struct gfs2_inode *ip;=0D
 =09struct gfs2_holder i_gh;=0D
 =09struct gfs2_glock *gl;=0D
@@ -1874,14 +1875,14 @@ int gfs2_permission(struct mnt_idmap *idmap, struct=
 inode *inode,=0D
=20=0D
 =09gfs2_holder_mark_uninitialized(&i_gh);=0D
 =09ip =3D GFS2_I(inode);=0D
-=09gl =3D rcu_dereference(ip->i_gl);=0D
+=09gl =3D rcu_dereference_check(ip->i_gl, !may_not_block);=0D
 =09if (unlikely(!gl)) {=0D
 =09=09/* inode is getting torn down, must be RCU mode */=0D
-=09=09WARN_ON_ONCE(!(mask & MAY_NOT_BLOCK));=0D
+=09=09WARN_ON_ONCE(!may_not_block);=0D
 =09=09return -ECHILD;=0D
         }=0D
 =09if (gfs2_glock_is_locked_by_me(gl) =3D=3D NULL) {=0D
-=09=09if (mask & MAY_NOT_BLOCK)=0D
+=09=09if (may_not_block)=0D
 =09=09=09return -ECHILD;=0D
 =09=09error =3D gfs2_glock_nq_init(gl, LM_ST_SHARED, LM_FLAG_ANY, &i_gh);=
=0D
 =09=09if (error)=0D


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.26
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794852023;
	b=wpPcsUqgTcyLoYnarwL8qu9uXRca7LcjbJknHwqKc70OtIvx3O517ap7ugUXTTGg/lOu
	 9acp4PwBiPjeKc+tu/DPeZjTgRxg47PP5FLTcBCtXYDdaJPblyS69mt885+iOAOC1xnCQ
	 ZUYUCQELYhTJf8o3oQ8cFEgNMYbrk13NBl6QZQrTgtBvFBh7aUO+tkj6wmfV5Q8nhAuz2
	 eSVBmUFSIrIRIUYF9oNPr8+pqjhJ3EBfq7oWBn9WD/L+qlKRE9QNlj1TX/tacJR/ej2V6
	 3tb1vpVHs1r8VSI4owo2NGFWMZcgd0zDLaJAH+BnZCWlTnCiD3Ec+PDoQ6xnq4Z8GrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794852023;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Z9itY3sFaKo4aFamvcDFo7fjuWWUI0oOdPWW++KRUSA=;
	b=UK0qwLuOM6i2ZNWSwxIQupsV7FTDEA1pRby8tVtafRXd9mS9TRLNhWiYxYxZrzDIZtU4
	 xRVJaSGtDAKXuM/sU/sr1pMhZTMss0psvFTEr0aYcH+fe8Px65LJ95LN7GVpqCg0ztosK
	 LekjHzqaGEwx5F/eKFP2jp03u+9ku5+X8v9hB//HbhK9IZI35qfnAyErpwVE0KSokvHKK
	 rVesGhsACqiVSztMs5/p4wKRKk0bKtUsBIl8o2xkk+UTVZmoe8RdOJz1GJ5x15tY2CQz4
	 44okC0nX9dh+wZT4AAr3B3Lq2D5RchcAXYPakMKCEElJZh6z5u3EJhgfYUppsDxMG7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=logarcheon.com;
	spf=pass smtp.mailfrom=logarcheon.com;
	dkim=pass header.d=logarcheon.com header.i=@logarcheon.com header.a=rsa-sha256 header.s=protonmail3 header.b=JfIPx31E;
	arc=none smtp.remote-ip=79.135.106.26
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch [79.135.106.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681EF606A882
	for <gfs2@lists.linux.dev>; Mon, 16 Nov 2026 18:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 681EF606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=logarcheon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=logarcheon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=logarcheon.com header.i=@logarcheon.com header.a=rsa-sha256 header.s=protonmail3 header.b=JfIPx31E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=logarcheon.com;
	s=protonmail3; t=1794852016; x=1795111216;
	bh=Z9itY3sFaKo4aFamvcDFo7fjuWWUI0oOdPWW++KRUSA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=JfIPx31EMnRMdkJD7PAIr22ncUpj2cfU9NiajYlpI8IrBYnXaVPmMeJEaK66ckOQT
	 dFpeWU9W1GP0AF0xA35fTR61V+HFLKYfDNYimilNhXafx9YWyM3EjgFLjN1P8whuJS
	 T3GWbO4vDGrblkKe5lVr/6eg62bQ+mbLWHqZjOAJcgdRTNKhVoL/+RqgACTr3C7R7A
	 IeNa/Tsw+HHLZCMuaXa4uJF1z8TrYplNzE38NazTvqBVVtUKmsbtsIdAPxRApqBPvd
	 r/dhMAqiaNhir5dfi7l3F/QSKrDK9PI++G95MhioHHEy3pDAj//PWfcUxFa5gmyHfL
	 XyvHdFdYLm82Q==
Date: Mon, 16 Nov 2026 18:00:11 +0000
To: Andreas Gruenbacher <agruenba@redhat.com>
From: William Chuang <founder@logarcheon.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, William Chuang <founder@logarcheon.com>, syzbot+5a5f492ccae698fd7434@syzkaller.appspotmail.com, stable@vger.kernel.org
Subject: [PATCH] gfs2: Fix NULL pointer dereference in gfs2_seek_data/gfs2_seek_hole
Message-ID: <20261116180002.44336-1-founder@logarcheon.com>
Feedback-ID: 145408520:user:proton
X-Pm-Message-ID: 1b394b004e1d598caff714f572707eece21ebc06
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

When the filesystem has been withdrawn, gfs2_glock_nq() returns -EIO
without queuing the holder, and gfs2_glock_nq_init() then calls
gfs2_holder_uninit(), which sets gh.gh_gl to NULL.

gfs2_seek_data() and gfs2_seek_hole() call gfs2_glock_dq_uninit()
unconditionally, so in that case gfs2_glock_dq() dereferences a NULL
glock when it takes gl->gl_lockref.lock, causing a general protection
fault.

Only release the holder when it was successfully acquired, matching the
pattern already used elsewhere in this file (such as gfs2_fiemap() and
gfs2_getattr()).

Fixes: 3a27411cb4bc ("gfs2: Implement SEEK_HOLE / SEEK_DATA via iomap")
Reported-by: syzbot+5a5f492ccae698fd7434@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D5a5f492ccae698fd7434
Cc: stable@vger.kernel.org
Signed-off-by: William Chuang <founder@logarcheon.com>
---
 fs/gfs2/inode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 75fb1a0c91425..4110b2d0b549c 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -2255,7 +2255,8 @@ loff_t gfs2_seek_data(struct file *file, loff_t offse=
t)
 =09ret =3D gfs2_glock_nq_init(gl, LM_ST_SHARED, 0, &gh);
 =09if (!ret)
 =09=09ret =3D iomap_seek_data(inode, offset, gfs2_iomap_next);
-=09gfs2_glock_dq_uninit(&gh);
+=09if (gfs2_holder_initialized(&gh))
+=09=09gfs2_glock_dq_uninit(&gh);
 =09inode_unlock_shared(inode);
=20
 =09if (ret < 0)
@@ -2274,7 +2275,8 @@ loff_t gfs2_seek_hole(struct file *file, loff_t offse=
t)
 =09ret =3D gfs2_glock_nq_init(gl, LM_ST_SHARED, 0, &gh);
 =09if (!ret)
 =09=09ret =3D iomap_seek_hole(inode, offset, gfs2_iomap_next);
-=09gfs2_glock_dq_uninit(&gh);
+=09if (gfs2_holder_initialized(&gh))
+=09=09gfs2_glock_dq_uninit(&gh);
 =09inode_unlock_shared(inode);
=20
 =09if (ret < 0)
--=20
2.43.0



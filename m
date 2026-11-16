Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866934;
	b=IjRAstI5isGur0l/euTrjxBV1X1GEm84dWTxn91pS2SD4S/ppjYJZzjfvKdBirzm2mfL
	 vwwNzbQJB7T5SJ+yjhlQlWjbvuy5PZPXuJJDBBZQauXn63Mj5BMUs7ltDabFHGznw6LIi
	 G3/5C5EphBgfV8jGdEo4j9HutVe0H5qYzjg3zErccT6SH+anWCBuyyHuqvLzzZ4+dwBs5
	 2cuCoeTjlC9UFgRW+hTBKI6osNYb7HzGZIby2aXbdvXyocSdjzJf7ZeYnJ6j5Sfkp3Dss
	 GEbbs3aMYk4z92p/v7B6yEdirFixUHpupbSS4uGG+W7FRDc3QIdXWYtz8nas2mWScOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866934;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=FkxAzsjJNf+C3xwo+IqzVffQESsTNH6DaVyjsMO+ATA=;
	b=u0tsfSPgtB23HkwpXAxJZjoj72MGjvO2j29PeHDcMchTmimBh3M3I2xpRjqVA/e3PlG0
	 zfjotj8Pn+Ghcpq2q7UBnKclZSkcb7vhWPrzz/fcDLw/2a8IX57VHbXFMfDT6goZnzBw9
	 EiRYCBUujjQnVjaQrKKnRKHIvVMtpwTiyrPfesXj290YjQR+P4LdyvLycBFo0zyeJTb3u
	 yeYO92ah/6+B8uXnM+Lwp/Tw9VqtVizCM3SSDb0WgSQ0UZ9qlYmUmMgwTOGmfRI/ZKFDv
	 0vC6+NZPRS3S9k6Z8yvoDlRYGbJtj0QsD/5NwXlw+vjWrfu4z4f6pnzafBMtRWI2qVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Bx8Y/56U";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F9D60A261C
	for <gfs2@lists.linux.dev>; Mon, 16 Nov 2026 22:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3F9D60A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bx8Y/56U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794866933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FkxAzsjJNf+C3xwo+IqzVffQESsTNH6DaVyjsMO+ATA=;
	b=Bx8Y/56Uvk3EF4vdtXFLhmbOrXmPSKfT5jCYTatm7JMdRf8HJsz0DaZDpziTqvXlmk6bTD
	HZt5O0BM5k2p5ayhvxINJ1MleVCZlbNPJ0esLtiI5bSMJbChPI1PLVmXs5k9iri3HFDzO3
	ljpfG0corvbbXEJbm1PYcpGVgrkeV3w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-T1Jv61UwNK2_6-JrnCTAuw-1; Mon,
 16 Nov 2026 17:08:48 -0500
X-MC-Unique: T1Jv61UwNK2_6-JrnCTAuw-1
X-Mimecast-MFC-AGG-ID: T1Jv61UwNK2_6-JrnCTAuw_1794866927
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A1B0195D01E;
	Mon, 16 Nov 2026 22:08:47 +0000 (UTC)
Received: from agruenba-thinkpadx1carbongen9.rmtat.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 215C31956047;
	Mon, 16 Nov 2026 22:08:44 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: William Chuang <founder@logarcheon.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+5a5f492ccae698fd7434@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] gfs2: Fix NULL pointer dereference in gfs2_seek_data/gfs2_seek_hole
Date: Mon, 16 Nov 2026 23:08:43 +0100
Message-ID: <20261116220843.378480-1-agruenba@redhat.com>
In-Reply-To: <20261116180002.44336-1-founder@logarcheon.com>
References: <20261116180002.44336-1-founder@logarcheon.com>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: 76Pyyh3xMsJdSwIUdl3AfLF34Nbk1h7dZwniaXdMBOo_1794866927
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Nov 16, 2026 at 7:01 PM William Chuang <founder@logarcheon.com> wrote:
> When the filesystem has been withdrawn, gfs2_glock_nq() returns -EIO
> without queuing the holder, and gfs2_glock_nq_init() then calls
> gfs2_holder_uninit(), which sets gh.gh_gl to NULL.
>
> gfs2_seek_data() and gfs2_seek_hole() call gfs2_glock_dq_uninit()
> unconditionally, so in that case gfs2_glock_dq() dereferences a NULL
> glock when it takes gl->gl_lockref.lock, causing a general protection
> fault.
>
> Only release the holder when it was successfully acquired, matching the
> pattern already used elsewhere in this file (such as gfs2_fiemap() and
> gfs2_getattr()).
>
> Fixes: 3a27411cb4bc ("gfs2: Implement SEEK_HOLE / SEEK_DATA via iomap")
> Reported-by: syzbot+5a5f492ccae698fd7434@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=5a5f492ccae698fd7434
> Cc: stable@vger.kernel.org
> Signed-off-by: William Chuang <founder@logarcheon.com>

Thanks.

Could you please replace this with the following fix and resend?

Andreas

--

gfs2_seek_data() and gfs2_seek_hole() call gfs2_glock_nq_init(), and
independent of the outcome, they call gfs2_glock_dq_uninit().  When the
gfs2_glock_nq() call in gfs2_glock_nq_init() fails, gfs2_glock_nq_init()
returns with an error code and gh.gh_gl is set NULL.  This causes a NULL
pointer dereference in gfs2_glock_dq().

Fix that by only calling gfs2_glock_dq_uninit() when
gfs2_glock_nq_init() succeeds.

Fixes: 3a27411cb4bc ("gfs2: Implement SEEK_HOLE / SEEK_DATA via iomap")
Reported-by: syzbot+5a5f492ccae698fd7434@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5a5f492ccae698fd7434
Cc: stable@vger.kernel.org
Signed-off-by: William Chuang <founder@logarcheon.com>

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 2c2dc459c037..d4678e4832b3 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -2253,9 +2253,11 @@ loff_t gfs2_seek_data(struct file *file, loff_t offset)
 
 	inode_lock_shared(inode);
 	ret = gfs2_glock_nq_init(gl, LM_ST_SHARED, 0, &gh);
-	if (!ret)
-		ret = iomap_seek_data(inode, offset, &gfs2_iomap_ops);
+	if (ret)
+		goto out;
+	ret = iomap_seek_data(inode, offset, &gfs2_iomap_ops);
 	gfs2_glock_dq_uninit(&gh);
+out:
 	inode_unlock_shared(inode);
 
 	if (ret < 0)
@@ -2272,9 +2274,11 @@ loff_t gfs2_seek_hole(struct file *file, loff_t offset)
 
 	inode_lock_shared(inode);
 	ret = gfs2_glock_nq_init(gl, LM_ST_SHARED, 0, &gh);
-	if (!ret)
-		ret = iomap_seek_hole(inode, offset, &gfs2_iomap_ops);
+	if (ret)
+		goto out;
+	ret = iomap_seek_hole(inode, offset, &gfs2_iomap_ops);
 	gfs2_glock_dq_uninit(&gh);
+out:
 	inode_unlock_shared(inode);
 
 	if (ret < 0)


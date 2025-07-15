Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41DC2E7BDD
	for <gfs2@lists.linux.dev>; Tue, 15 Jul 2025 13:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587535; cv=none; b=DWXw43jo+VJdPsBGL1NIFYcZcO+EO4N6GcGY9haz+zQp3iMCvcbM0/+jnpxHV0hA3dP9m0Lr6GtSlMKLOhE1VzWS/3H7Fp5yHotvXILYpwhtE24SgGGUvqA4bWKhCA61FDUqMTiCCoYxcDCA5ZnQYOj0X24NuwCEDgi984iNraw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587535; c=relaxed/simple;
	bh=NOgfkANSMqP/o/1XGlgUkP8qf0ZkBRaK7Y3lJuCFe4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=M3xRJAUyR+IEdihUqP7Jacc96XSKXbeJAzjdaVvvtVoQAuClYxZqu9cZ+hsotObf4hVKp9vZaqPmZ7200t3z4ueYScQAb6X3AEDog4TRbM4YSyd1wW856Mf8VLNy237T5Wpa5xggShM1QEBXs6nCBceZp5M2FGoh+QqUowr+obc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aOctNRHl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aOctNRHl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752587532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LWweotF1wFeHlazxkLMOgPpvz+xpTr7ShDBEpFhnuyM=;
	b=aOctNRHlMqM23NXNdLQgaFF8PI1vLljfvfYPF3WdENgn76hA99F+8AUW7mzFYWpIIztx9x
	mSeiEmsyVadAwpzw3o/okmpEOPlLq1dxKROiiqAWN8mxOL4vUSg3LJMKUw8rYrNL4NBINY
	WIUDK/KxtqMB6t42SF99L5bBnpBHmpM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-AsU2PCJKPt-ieqPS00k4Hw-1; Tue,
 15 Jul 2025 09:52:09 -0400
X-MC-Unique: AsU2PCJKPt-ieqPS00k4Hw-1
X-Mimecast-MFC-AGG-ID: AsU2PCJKPt-ieqPS00k4Hw_1752587528
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B3FA1955F65;
	Tue, 15 Jul 2025 13:52:08 +0000 (UTC)
Received: from b.redhat.com (unknown [10.42.28.184])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C0D7A1803AFF;
	Tue, 15 Jul 2025 13:52:03 +0000 (UTC)
From: Andrew Price <anprice@redhat.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	syzbot+4708579bb230a0582a57@syzkaller.appspotmail.com
Subject: [PATCH] gfs2: Validate i_depth for exhash directories
Date: Tue, 15 Jul 2025 14:51:59 +0100
Message-ID: <20250715135159.87679-1-anprice@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lg_IWEZEXylQ8egx9mB_E_DuKta05mMZkydr_dJcw7s_1752587528
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

A fuzzer test introduced corruption that ends up with a depth of 0 in
dir_e_read(), causing an undefined shift by 32 at:

  index = hash >> (32 - dip->i_depth);

As calculated in an open-coded way in dir_make_exhash(), the minimum
depth for an exhash directory is ilog2(sdp->sd_hash_ptrs) and 0 is
invalid as sdp->sd_hash_ptrs is fixed as sdp->bsize / 16 at mount time.

So we can avoid the undefined behaviour by checking for depth values
lower than the minimum in gfs2_dinode_in(). Values greater than the
maximum are already being checked for there.

Tested with the syzkaller repro.c and xfstests '-g quick'.

Reported-by: syzbot+4708579bb230a0582a57@syzkaller.appspotmail.com
Signed-off-by: Andrew Price <anprice@redhat.com>
---
 fs/gfs2/glops.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index cebd66b22694c..1109459cdca77 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -450,6 +450,10 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 		gfs2_consist_inode(ip);
 		return -EIO;
 	}
+	if ((ip->i_diskflags & GFS2_DIF_EXHASH) && depth < ilog2(sdp->sd_hash_ptrs)) {
+		gfs2_consist_inode(ip);
+		return -EIO;
+	}
 	ip->i_depth = (u8)depth;
 	ip->i_entries = be32_to_cpu(str->di_entries);
 
-- 
2.50.1


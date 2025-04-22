Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC4720127B
	for <gfs2@lists.linux.dev>; Tue, 22 Apr 2025 09:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745314843; cv=none; b=Yl4xSMZA3IYLcdtoEjCm+MeARAoV8BYWleJlRp2be1d2+HLSo8zK9pEDnQcrCsAv2clbJpZwXuRW1k19Uz6qyjsdugd0RuqOlaz836EpQHvtbh06l+UdkqMBAQEKCAQBFp1+F1gY6Gmr2oLd7uNqcimWzZ0AXUI6gGDKb/7Qv08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745314843; c=relaxed/simple;
	bh=w/JybX0yjkXfVOs2KZ/IGVWFwN0WRNfyr+ZD3COUMT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=mXzeUa6yqOB3440QoxDlX/SLaWlAvo0xp/TYKdQQVvAi1WLfFTIl6HPOCTDzB8fFX9HuiXJrfTNMpkKVZC4Q9craCQ3BZBkB4HyGnnQM6Eq4+vXDSD7lm5F0hT3PwHbCyYBDrOd9uF6J630eVy73tfeoweuMM3S6EstUnwe3C/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NIktFxoG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NIktFxoG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745314840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SuQFrvW6PKOcpta26OjInUM6ReHdA7yH9KFqwB6RUYg=;
	b=NIktFxoGQNWP8A7fLRCSKRblXOyiiBeSfHJmy0jG0ywQ910Y1/+9O3xrL7PBfXbpw3U6p6
	zXEHwq+/zFGcUay7CdTSEgmp91up+Lp3ltn0man4hzb8ecxA/Xrtr+uKbxTkdu4z40Dls5
	UyDZvjkGAnpdepZzCQNX7bgjZ++xTcg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-1Z7p-4zzOxCh1nHsBBYwTg-1; Tue,
 22 Apr 2025 05:40:38 -0400
X-MC-Unique: 1Z7p-4zzOxCh1nHsBBYwTg-1
X-Mimecast-MFC-AGG-ID: 1Z7p-4zzOxCh1nHsBBYwTg_1745314837
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D11D1956094
	for <gfs2@lists.linux.dev>; Tue, 22 Apr 2025 09:40:37 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7BFE7180045C;
	Tue, 22 Apr 2025 09:40:36 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] gfs2: Don't reread inodes unnecessarily
Date: Tue, 22 Apr 2025 11:40:35 +0200
Message-ID: <20250422094035.1221174-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TWR_0M3NhQAP1CDAg2oruzdO5zCvyHLZ2nnYDcS3l4w_1745314837
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

In gfs2_create_inode(), we initialize the inode from scratch and then we
write the result to disk.  Clear the GLF_INSTANTIATE_NEEDED glock flag
to indicate that the inode is up to date.  Otherwise, the next time the
inode glock is acquired, gfs2_instantiate() would reread the inode from
disk, which isn't necessary.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 9621680814b8..62ff09264f0f 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -768,6 +768,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, GL_SKIP, &gh);
 	if (error)
 		goto fail_gunlock3;
+	clear_bit(GLF_INSTANTIATE_NEEDED, &ip->i_gl->gl_flags);
 
 	error = gfs2_trans_begin(sdp, blocks, 0);
 	if (error)
-- 
2.49.0


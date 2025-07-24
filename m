Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAE62D63F7
	for <gfs2@lists.linux.dev>; Thu, 24 Jul 2025 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753362641; cv=none; b=bONru5+6Ite28Uw6U5cLryXIJUxBdeQthtpj3rwihXi/7FnxcKqWXXUxMDnwCs76+L2TjoILT8EP9pVVJT4NVIob7ekOH5KktYSdosOA/XsZp9NXZooV6GB4Z/Gg1uChiKPy3HZs+1NGI2SzwAE6hi2NWuvwwWOq255/vhUYhew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753362641; c=relaxed/simple;
	bh=gaKTdLloitTgLE18sZ0yv1XQOlNUlQTpUbt0DY3r9Yk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=bhd+ELbFF2+EWTqwIxctYx67Q+KUaoF4eoBL3M8oX8691Jrk9iIz1w1AYSpOyuKg808/FASTPNoyKmZ3ktVvmn/EROFVjR0NRpGTesHyt5wz/G64FApf6C/BAwoVgpuEkTG3ONCFDkybIN+GsE0WGSjZxj9XakaqtoIvfF7YIx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ws9/jEEJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ws9/jEEJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753362638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o3HKx2M5lCFTAKkl9Vho8iPrNZEK3clBNFWt9QE70Yg=;
	b=Ws9/jEEJpdrneK8oUS3h+G6q4OPpPHdiMC+JQtD2V2E9laKOKKKGj0K+PJ5/MRTwgpwOzO
	PocTemehANq6EPdTfHWsWRcja7k96oMxcGnm/74xI25TOk+PuptNe8uiVbKNcBqrwHHNZ9
	MlmK6IbQwyuBmNMMM8TD6qXFB0OcLaA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-2SfjSPCbNH6MgzQlyfNSeA-1; Thu,
 24 Jul 2025 09:10:35 -0400
X-MC-Unique: 2SfjSPCbNH6MgzQlyfNSeA-1
X-Mimecast-MFC-AGG-ID: 2SfjSPCbNH6MgzQlyfNSeA_1753362634
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 30F921800447;
	Thu, 24 Jul 2025 13:10:34 +0000 (UTC)
Received: from b.redhat.com (unknown [10.42.28.191])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C2C5B195608D;
	Thu, 24 Jul 2025 13:10:32 +0000 (UTC)
From: Andrew Price <anprice@redhat.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	syzbot+42a37bf8045847d8f9d2@syzkaller.appspotmail.com
Subject: [PATCH] gfs2: Wait for gfs2_qd_dealloc() before freeing sbd
Date: Thu, 24 Jul 2025 14:10:29 +0100
Message-ID: <20250724131029.169196-1-anprice@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s4iJ7bFy_l7WvQ2IbOyxOs0Qx196dzVZua1QIP_x5EA_1753362634
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

gfs2_qd_dealloc() is called asynchronously with call_rcu() in
gfs2_qd_dispose(). It uses the sbd so it can race with the sbd being
freed on unmount. Add an rcu_barrier() to free_sbd() to make sure it
completes before the sbd is freed.

Reported-by: syzbot+42a37bf8045847d8f9d2@syzkaller.appspotmail.com
Signed-off-by: Andrew Price <anprice@redhat.com>
---
 fs/gfs2/ops_fstype.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 85c491fcf1a36..0385807d79ab6 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -66,6 +66,8 @@ void free_sbd(struct gfs2_sbd *sdp)
 {
 	struct super_block *sb = sdp->sd_vfs;
 
+	/* Wait for rcu_call(gfs2_qd_dealloc) */
+	rcu_barrier();
 	free_percpu(sdp->sd_lkstats);
 	sb->s_fs_info = NULL;
 	kfree(sdp);
-- 
2.50.1


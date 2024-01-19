Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDDA5789A
	for <gfs2@lists.linux.dev>; Fri, 19 Jan 2024 21:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705699273; cv=none; b=kCoqovRBsEy9Cmal1pP9prwA2AgvC2D7oPriJ2HynSXu6lXBOXSc41wn7r0MP73Kv1W3mBnL/62sYCBTGDGwVOwhn8PaHSW3y5vP6308jdeEQaBhA6BltEfyer/u1oeTM8dXxbr6rsh6u0CVlQ74YXXHWaZedwMrEQA6jTlAThk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705699273; c=relaxed/simple;
	bh=PBJyyLNHdOiZCn6wdTU7OjOzf8G/+3GJe4pfSuB6N04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AveNFN6z8MlLp1Q9qKaM34USOzzCyp4OrH2VgBCksa+0W4knEbWPtRW6vGLiYCH+kRuUwy3FTMRu2QhO9wPlLWuZ638OzqurZVuEYzpaTUdbgjdyLY6N9h4Q8q5GG9bxMT0AtRWuSPLevz5bYKPTnMCbqxNkbsfBroo4HXQRRN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fMfQCj+S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMfQCj+S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705699270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yusACiKuitu6DnaEHLe24tcRTYsAEN48bcjV+caMBVM=;
	b=fMfQCj+SJEhoodvBtFeeILigGE+E7pCb4bb8RUOJq2xS028Jr1lHSWi9jNdR9w+xZYNcEU
	uBS3I9ElFgP2qxdm6xgRVgUtNSbSKTK4/vEP2++Yg9ybMIdKRo7bnVOgmGJBWvhvSMxeSZ
	EwTDyam253qBvqnZsPzVVfZ8tPPhxto=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-FT39UQJXPOuGkf897s7hKQ-1; Fri, 19 Jan 2024 16:21:05 -0500
X-MC-Unique: FT39UQJXPOuGkf897s7hKQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2DDF683B82C;
	Fri, 19 Jan 2024 21:21:05 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.226.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8C4A440C1430;
	Fri, 19 Jan 2024 21:21:04 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 9/9] gfs2: Fix LOOKUP_RCU support in gfs2_drevalidate
Date: Fri, 19 Jan 2024 22:20:56 +0100
Message-ID: <20240119212056.805617-10-agruenba@redhat.com>
In-Reply-To: <20240119212056.805617-1-agruenba@redhat.com>
References: <20240119212056.805617-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Fix non-sleeping lookups in gfs2_drevalidate() by passing the FGP_NOWAIT
flag down to gfs2_dir_check().  This will cause gfs2_dir_check() to
return -EAGAIN when it would otherwise sleep.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/dentry.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/dentry.c b/fs/gfs2/dentry.c
index 99239d80982b..b14956cdab0e 100644
--- a/fs/gfs2/dentry.c
+++ b/fs/gfs2/dentry.c
@@ -74,12 +74,20 @@ static int gfs2_drevalidate(struct dentry *dentry, unsigned int flags)
 			goto out;
 	}
 
-	error = gfs2_dir_check(dinode, &dentry->d_name, ip, 0);
+	if (flags & LOOKUP_RCU) {
+		error = gfs2_dir_check(dinode, &dentry->d_name, ip, FGP_NOWAIT);
+		if (error == -EAGAIN) {
+			error = -ECHILD;
+			goto out;
+		}
+	} else {
+		error = gfs2_dir_check(dinode, &dentry->d_name, ip, 0);
+	}
 	error = inode ? !error : (error == -ENOENT);
 
+out:
 	if (gfs2_holder_initialized(&d_gh))
 		gfs2_glock_dq_uninit(&d_gh);
-out:
 	dput(parent);
 	return error;
 }
-- 
2.43.0


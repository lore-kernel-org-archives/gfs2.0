Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBABF2E629
	for <gfs2@lists.linux.dev>; Mon,  5 Feb 2024 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148122; cv=none; b=HdGIzgZtYzoxK63yPUp+CpCzYW3NRP5KrMpYf28o97euL/VHJlqRSQEZPuX81BFS+Nq5pTsSQ1ZMqPxyNZ6t2clUSpwDfEegIlWr8uJ7v6wwIKhVqTYxi8Gpy2pVFJYZEn9HYICU12/tX7G5dV+Fo7gbpXmsl3wyBjtWF68kexw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148122; c=relaxed/simple;
	bh=vrdez0L5tIcAR2ey6kFkzUZKNUIy0IfUlqczBNcIcpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qy16N2bkeDUfH+5NvzsnQOjWvrQ1WN6YbhdhUOsvOpZCPSYB1pZ8dkM+k4M/P/cH8fbwi9c0KVgneNw7xf2hMgQ02wPSkoolFAmefcirfWS3pZqdHA/W3Pt9sfAoFhv/35HZ9NZja+iZYGDbnKZWVE8zxbb92WDtnJy0SHT93hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e6DupGfq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e6DupGfq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707148119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7/3d8T+eb9hJ60CvN5Bd8QYnRgS9ZnzJk8Ite2+KscU=;
	b=e6DupGfqgSjGVwZp1b2QU+u1EQ4ZGoJjdVJsEjGhVqVvdkovy15YhxhiRyJIn19nmVues9
	sEioQNd4nUnVxhhIY9wrRHfBr+sun9wIJ9csrBPZyb0REisBRx+SVFE1jGHt4z0kN6xWk1
	XJavpHN9q4h27F18R0jQNOZACORhpFg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-e8BHfB0qPGS6yxMMU7weyg-1; Mon, 05 Feb 2024 10:48:38 -0500
X-MC-Unique: e8BHfB0qPGS6yxMMU7weyg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 02153185A788
	for <gfs2@lists.linux.dev>; Mon,  5 Feb 2024 15:48:38 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.fast.eng.rdu2.dc.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EEB471121312;
	Mon,  5 Feb 2024 15:48:37 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next] MAINTAINERS: update DLM git repository entry
Date: Mon,  5 Feb 2024 10:48:31 -0500
Message-ID: <20240205154831.1462530-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This patch updates the DLM git repository url to the new one that is
created under the DLM shared space to join the effort between the
current DLM maintainers.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 960512bec428..05a201bb296a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6244,7 +6244,7 @@ M:	David Teigland <teigland@redhat.com>
 L:	gfs2@lists.linux.dev
 S:	Supported
 W:	https://pagure.io/dlm
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dlm/linux-dlm.git
 F:	fs/dlm/
 
 DMA BUFFER SHARING FRAMEWORK
-- 
2.43.0


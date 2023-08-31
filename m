Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9B879F8
	for <gfs2@lists.linux.dev>; Thu, 31 Aug 2023 09:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693475873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ik+Jfzu4U97Qcaeok6+TTXkBn94B/cKiyKy3mBd7lPM=;
	b=QWgIyhp9g9jJIuJTahu7SFnas1wdSF6rqsSHk9ot/k0deJkfgtWeDiW7Nho8c/vbtXE30R
	4QrIyhRuClgtgjdWaTc9s7piunWpqN+JMBsK13y4PefUr6TOox1yhDh24Rf63sI1mxwikM
	IZW7sBKc/r0stxopqAwbBdU/xHoP8nk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-PeIYvwi5NlK9looHeGSMrA-1; Thu, 31 Aug 2023 05:57:52 -0400
X-MC-Unique: PeIYvwi5NlK9looHeGSMrA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B90AC801005
	for <gfs2@lists.linux.dev>; Thu, 31 Aug 2023 09:57:51 +0000 (UTC)
Received: from b.redhat.com (unknown [10.42.28.73])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BB960C15BAE;
	Thu, 31 Aug 2023 09:57:50 +0000 (UTC)
From: Andrew Price <anprice@redhat.com>
To: agruenba@redhat.com,
	rpeterso@redhat.com,
	teigland@redhat.com,
	ccaulfie@redhat.com
Cc: cluster-devel@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH 1/2] MAINTAINERS: Update gfs2 mailing list
Date: Thu, 31 Aug 2023 10:57:48 +0100
Message-ID: <20230831095749.9616-1-anprice@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: Andrew Price <anprice@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b8d634f3a4e..caae31fb9741 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8725,7 +8725,7 @@ F:	scripts/get_maintainer.pl
 GFS2 FILE SYSTEM
 M:	Bob Peterson <rpeterso@redhat.com>
 M:	Andreas Gruenbacher <agruenba@redhat.com>
-L:	cluster-devel@redhat.com
+L:	gfs2@lists.linux.dev
 S:	Supported
 B:	https://bugzilla.kernel.org/enter_bug.cgi?product=File%20System&component=gfs2
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
-- 
2.41.0


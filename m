Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A7479F8
	for <gfs2@lists.linux.dev>; Thu, 31 Aug 2023 09:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693475876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=viO3SJjbFB105P6FPaGzg3wrck1TKvHJHqSm+oj8dF4=;
	b=CIa3F1gKsMPmGw8+UaqG9XHGPQX08eMwSBg6ZvFIhP89KQFr034WrFURs5awvgZCmB9bKF
	o8xpCyKxB9HBGwR6l4TsSgj5PQSeVYsM/30o97YABlv/L0KPXWzFWKoKROMxnMisLPIlMu
	Gm2lbY7ynFR2hm4SCW226Fxb+TndNx4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-211-D3VpdbI4ODq-x10jls7jKg-1; Thu, 31 Aug 2023 05:57:53 -0400
X-MC-Unique: D3VpdbI4ODq-x10jls7jKg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D0EE980027F
	for <gfs2@lists.linux.dev>; Thu, 31 Aug 2023 09:57:52 +0000 (UTC)
Received: from b.redhat.com (unknown [10.42.28.73])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EB7E8C15BAE;
	Thu, 31 Aug 2023 09:57:51 +0000 (UTC)
From: Andrew Price <anprice@redhat.com>
To: agruenba@redhat.com,
	rpeterso@redhat.com,
	teigland@redhat.com,
	ccaulfie@redhat.com
Cc: cluster-devel@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH 2/2] MAINTAINERS: Update dlm mailing list
Date: Thu, 31 Aug 2023 10:57:49 +0100
Message-ID: <20230831095749.9616-2-anprice@redhat.com>
In-Reply-To: <20230831095749.9616-1-anprice@redhat.com>
References: <20230831095749.9616-1-anprice@redhat.com>
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

The new gfs2@ list will also be used for dlm development.

Signed-off-by: Andrew Price <anprice@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index caae31fb9741..946fcf6c8d77 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6093,7 +6093,7 @@ F:	include/video/udlfb.h
 DISTRIBUTED LOCK MANAGER (DLM)
 M:	Christine Caulfield <ccaulfie@redhat.com>
 M:	David Teigland <teigland@redhat.com>
-L:	cluster-devel@redhat.com
+L:	gfs2@lists.linux.dev
 S:	Supported
 W:	http://sources.redhat.com/cluster/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git
-- 
2.41.0


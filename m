Received: from mailo.com (msg-1.mailo.com [213.182.54.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDDC8C17
	for <gfs2@lists.linux.dev>; Fri, 29 Sep 2023 06:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
	t=1695968086; bh=sUtnhl+BN0pAXgvT1VA9dfcxtXJrnbj9wF0wciOqpdA=;
	h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 Content-Type;
	b=BT5FFlQpPpYYiLWCg0obrQwHB6L2jyl1IDQj4NY5PfCuvzM71FERDYaVd2NdJ48Pq
	 Cchkcw4ji4i6zgQbnC7a3yMpUUgBsHN/bIIiBwonfYk/btOo0uizwSWjwhn7wzkPOl
	 G7fnpFFwQLvucAEwRU5T1RZn/pRHsU9gHvLyAhiw=
Received: by b221-3.in.mailobj.net [192.168.90.23] with ESMTP
	via ip-20.mailobj.net [213.182.54.20]
	Fri, 29 Sep 2023 08:14:46 +0200 (CEST)
X-EA-Auth: mJrxcB5o/rp3CdNHoV+lGMylfQKBbaAvaC4JHT2Uwm3geFEykZ96si8l7FTXLh3ZxpTAt34dRlCrz8K4QFKtJ4AC9NHhu1Tb
Date: Fri, 29 Sep 2023 11:44:40 +0530
From: Deepak R Varma <drv@mailo.com>
To: Bob Peterson <rpeterso@redhat.com>,
	Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	Dan Carpenter <error27@gmail.com>, Deepak R Varma <drv@mailo.com>
Subject: [PATCH] gfs2: Set error on error path
Message-ID: <ZRZrUMzweaJeEJuD@runicha.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Set the error variable inside the error path on failure. Saves
unnecessary variable assignment during normal execution.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 fs/gfs2/bmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index ef7017fb6951..93bd8ea34444 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -162,9 +162,10 @@ int gfs2_unstuff_dinode(struct gfs2_inode *ip)
 
 	down_write(&ip->i_rw_mutex);
 	page = grab_cache_page(inode->i_mapping, 0);
-	error = -ENOMEM;
-	if (!page)
+	if (!page) {
+		error = -ENOMEM;
 		goto out;
+	}
 	error = __gfs2_unstuff_inode(ip, page);
 	unlock_page(page);
 	put_page(page);
-- 
2.39.2




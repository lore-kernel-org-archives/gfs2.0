Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B4B37EFF3
	for <gfs2@lists.linux.dev>; Sat,  1 Aug 2026 22:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785621683; cv=none; b=mbMH/7APK7j4CANwpZR7oc6qn4vv8H34C6mQ4Q10/plsieGLWwJEVo/EIV3xyx5UahN25cM7RtvOMU62MiY3Wq4cf+QJxcvhwdTiGjgPlsaZycP9k53cXyTsFsgF5PZ/mT0bq3WtFzAeLdESK3pFNNujUywHGaaVuIXsRNr8IQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785621683; c=relaxed/simple;
	bh=rmASDDjzyu7ORP+REJJAPqpbg4Lkmrb9SobBQ2fdR4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GNy69yMLpoyax5DTFGRNrsw5XJpAxjpLoVJ0o5iJsy7zEM9xYwfAjh+iQ80C2x2ZkBgRqMx/LQGzj4DYoMYL8TJ2JAZPJzCZf0WNXSnDz2NVAm4+gKKIPGy27bogOpt/9MuIyO/jGB5XlxlXiEimC6di9D66NaIWChov3HXF8kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isyW+sg4; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isyW+sg4"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6680ae2031fso1791630d50.3
        for <gfs2@lists.linux.dev>; Sat, 01 Aug 2026 15:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785621680; x=1786226480; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CmPK9JWvOViXyoDvMWnuptWNftqO/5jbHBuyoy5p9Iw=;
        b=isyW+sg4exUe0eJuoaiW1IG3vvGFE7BuzcE5fB7mmZ+segKul8vWhmoQFyCM1rLE9A
         tznsrrqV4k5aKG5qeq9cMq/HN0hJzNTfMwCjjEpNdgpKc8zv1C35wrqLjp9JhDSYMgLu
         i2bDZ7rvnGGd5IQjYkJDV1OgquFK+UncJC+fasbpDTOOwo2z2Wtrss+7PghJctVkbtXq
         QwW8rIA60spW6MHQIbvp1A8ePv9hYgK8Ql2pHI1Lp8thZH0RIXOJqdOk8rda8h++Iy75
         fEw+pJ/aWyd7uiZSiXQDqyWKmFvs/dAtFG8EKvLeZqaAeKGqjwVO1fk2xbVgHI7o2bHK
         GNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785621680; x=1786226480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CmPK9JWvOViXyoDvMWnuptWNftqO/5jbHBuyoy5p9Iw=;
        b=Sx4ZRPL54UK2i63XNdNrvqx3mi3X4riyNgng7j/C989lmMFtBvyl1EvDNx+kS5SyhZ
         oS9tvSgu/gbD0H5RYqQss95IZTZmDEBbSk0tHxOh8kgFG+9dcyOaipf/HBT2AEg8LadQ
         Z5I43Z+3K1sIxe4WT6Maoz6GWEZZDrZPA4Ox2Sb1eoyfx7N7ZI1TIT9gmQ1AL28s9cIe
         0nZIRavZ+X0Ao/poYjzugmqOqYtCyShijWVYFB3J6y71rPgaRPbtDRhqrApSOdvJNuSH
         5FWAcfNshIjNrKln/FIqhO3Jehd5IWShirQ1sCIKzXrryoN69CRovXGiUNu/0MvpJUIm
         aOzg==
X-Forwarded-Encrypted: i=1; AHgh+RrGJKKJ8/rjlZQdMla8pAPzAUMO2YudEhJlhuHx21NidXUTCS/W7Xc6KnlBZt4mLb2hTyMr@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+3SDuXScIcN17tOGFzcJ2NQlr3QNzAwHE8nWAiUUvIhVv/bR3
	xYz0gphOlOakrrkAQSnlW+95R0LkkP0tXv34drC/pnB6iaA4AeJGIFVx
X-Gm-Gg: AR+sD13I1C0kBLYtBeOXg5R7nb7LINkDafdAqh7ALZJRZnneyzjFTUUedIIdNBS61O7
	5K8+aU2llSR5BdEf0OWpa6nI2k8ncn5nMSHAj9fWEHRYMmvdE1NzbmWOM5ag4+FnpQWD5HzywwM
	FdRdyrKXKz4A0NP2jV5n9GdWc/hu4Wr7aYIQCOwksDgYjj2X+L0DVckJEwXzVjYeXGb8k8tH933
	2VLd1y7rGhhHKm0QNJ//15tJoR7I1dtLyMusHhzwvdt5p1i/q5/UWsuD1z45ryolwJsasouQgm8
	QihS1Q+CwYOmNRX3y7KQ+8k1y18z02ArM+/CiqiCCCX6WMiE6bZQwvJ+QDDT5ravhEAUDbE0e4e
	kFE2kbuk0yJv0pijY9ZC6fFQ0q+LGf3ONUNxFv5qLa6ADzpLvAcAPutkvqLgFDiT61qT3xAKvD7
	qLAXtTZ19wyGadXVYbwYg7TFU1RJHBIm/hGwRUHZDeYzvPJ+ACv0Y4o6aLxzC+/PdaFZd3TLI/J
	0ak3Eo=
X-Received: by 2002:a05:690c:dcb:b0:81e:d009:1956 with SMTP id 00721157ae682-81fd4a21566mr79336867b3.12.1785621679620;
        Sat, 01 Aug 2026 15:01:19 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd0d6fbbsm29903767b3.25.2026.08.01.15.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 15:01:19 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Bob Copeland <me@bobcopeland.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-ext4@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	gfs2@lists.linux.dev,
	linux-karma-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Shi <coshi036@gmail.com>
Subject: [PATCH 07/19] adfs: check for a directory write error with buffer_write_io_error()
Date: Sat,  1 Aug 2026 18:00:51 -0400
Message-ID: <b688ce1ef8805684f8c529b8934406ddf6e34da5.1785621505.git.coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785621505.git.coshi036@gmail.com>
References: <cover.1785621505.git.coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

adfs_dir_sync() spots a failed write by testing BH_Req together with
!BH_Uptodate.  That relies on the write completion handler clearing
BH_Uptodate on error, which this series removes: a buffer whose write
failed still holds the data the filesystem asked to be written, so
declaring it not up to date is wrong and makes callers re-read it.

BH_Write_EIO says exactly what this code wants to know, and it implies
BH_Req, so the pair collapses into one test.

No behaviour change today - a failed write sets BH_Write_EIO and clears
BH_Uptodate together.  It stops being a no-op at the end of the series,
where the new test is the one that still works.

Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 fs/adfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/adfs/dir.c b/fs/adfs/dir.c
index 11afa9e157aa..b8cc6a697a05 100644
--- a/fs/adfs/dir.c
+++ b/fs/adfs/dir.c
@@ -191,7 +191,7 @@ static int adfs_dir_sync(struct adfs_dir *dir)
 	for (i = dir->nr_buffers - 1; i >= 0; i--) {
 		struct buffer_head *bh = dir->bhs[i];
 		sync_dirty_buffer(bh);
-		if (buffer_req(bh) && !buffer_uptodate(bh))
+		if (buffer_write_io_error(bh))
 			err = -EIO;
 	}
 
-- 
2.43.0


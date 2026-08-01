Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13753367B97
	for <gfs2@lists.linux.dev>; Sat,  1 Aug 2026 22:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785621684; cv=none; b=BpK5e/z3DNuL0jsh4ziipD5dih+AVPv4UL/scNlmBVhqRjXuOBAFTscKEAsshva9m/XfzEp1UXPwYg+WD28TJxM3PSHkLOabifmmjBR6ViLmZp1T6yZDEWWckQ9NkwwmC1+gkB9O1GCEukvbCSrk0bDHDjpAVkvn/0XRpz4iPp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785621684; c=relaxed/simple;
	bh=0GZwqUy172rmUBMrDMV2vQcxlGBw18Y+h2pa3/xDLGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uNm8XTmvvVJXm7fzVziOjti7lUMwEuXeurZ6bqWBazCKQTwi1thux4IPzvnUGFnGnCdsEVf241CLtyTCh5tjcIUuhngFJbri+ovW0018+2bye+ZXagpEpxHBAxVc38H9K+56z4JvcKeQS/wzKHxBwkrthATjQzktsLDZYdRHO3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y222FXJV; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y222FXJV"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8143daf89c7so20626587b3.1
        for <gfs2@lists.linux.dev>; Sat, 01 Aug 2026 15:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785621681; x=1786226481; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZTD9K6oObS45hnhRjtGbn2SpngZimROJJDwLscvqzbo=;
        b=Y222FXJVEM6vCRKGYZPQtb3YRdw77oqGc9UVY24gtvOq36mdHMw3PFYkKd1c6rXt0H
         eh9xodWItLZFgXPvggFehOSsgOWqDdRHJpfo7wSsvYzd8fZFjoNwaE+twsKdifWAvWGv
         MprAJILsC3FQaG64+FQuUcZEO+rU57Er2UVRR7bSY7J7oF/qdjqlu29us/n8TOk76aB5
         Ge1CvBGA0vLaw0AJLZPamJxHE2QuW7tLx1Peaf4vx5m6xlNT41G42HRN1UrEDfiwsL7+
         crNhRs8MhNdUwskc/yPv4nn08hFTriSeDzMiRUM7HEXauQeDhEDVe54os7j8uNJB5JGm
         iRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785621681; x=1786226481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZTD9K6oObS45hnhRjtGbn2SpngZimROJJDwLscvqzbo=;
        b=IAYs2B+8R4qa7SsCL/IZDrV7BfGO/On/ObSSD5Wa107wTPMFRfkIv3QVMIFOlwUJAm
         ZazX4JntXSIzCUOuyKYQc0H8u+pvqjU4SzokJyEJcptnNrwcGzkele2udoNhNCf7NqNJ
         PD0PXuXsJxwe1ZUe05DQDa44atKPeqqWkGWBm2KXRWvkLFuecd7mXZEHr67cwQxeng2B
         bdyCWj9TIkiEWAuf+v4ACB44KaDmC28UCH+s9KDs6hRnsByfCIsqOxHLhpsMPv1EMQlJ
         mHLZTdQklCiAuIPDXgL1+sS4+/EIqhA5vDz5QLTjfE9Xca4YuVuoQwywP7bKVU3cY1EU
         6WRw==
X-Forwarded-Encrypted: i=1; AHgh+Rq1znGdzICDw7Nm6SuxYbOWNXeaLy50adrmjqWdP/ensmwIRuuWy0zrdmXmQePvXAsi5qVt@lists.linux.dev
X-Gm-Message-State: AOJu0YySSOPMPoAu6cuE0CyAuuyXQPX7H/PM6wEYRNyzoeaOlLGcTYvq
	k44sLUTSQAajdh7+jiIf2JYbN+El6L0ag5Wwze8UnzSbiLbGrF/jCxWe
X-Gm-Gg: AR+sD11Ylt02shJC6fK4cOMFhyYz4gBQ8hNtfld7+NbvIM23BL0vA13aLa4RQdlePhp
	+Kop/XdTbfBierMWRqVOJOvReHmo8Ow44vD4VlHON4ykeUsjsKNu33vXN92t8w9Q3o8T9qSWrVk
	XW1GAF003d3UM8ViB8OBBLODgBHXjhkC7C3NjKLY1zBDzd2tYIe3mB7Wu1ESOPUUFxmj1zi2q66
	eq8/Q41906T2R1VQKSO+jESnScqaPkTJNSyw+E/fOcOqhYq/WLaa1bmT5XGX3Ed/c79yQs7pfUU
	tRSkCMbgP23gn6858fS+7yYhCRYLwQ9xknwjY+bGPnwkiHfSt+TxHz1QorohCjVT3/93JFC0NXS
	NWDxkImYuQkql1gV6dt/RYyHUwdap116jJnjNk9xw/gobg4/2Tbbva//Fv5fhYPkPhSPj0clUum
	Q2qNEgMhm/thpk4tQ5JZWTpQ35h28Y4FhuWqSxE+Un69OgMLGmWXF6DKN3HBPoL1eHKYVbYtSfE
	Aw4zNo=
X-Received: by 2002:a05:690c:6ac9:b0:81e:ae6d:caed with SMTP id 00721157ae682-81fd4bf66c7mr72228817b3.34.1785621680760;
        Sat, 01 Aug 2026 15:01:20 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd0d6fbbsm29903767b3.25.2026.08.01.15.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 15:01:20 -0700 (PDT)
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
Subject: [PATCH 08/19] ext2: check for an xattr block write error with buffer_write_io_error()
Date: Sat,  1 Aug 2026 18:00:52 -0400
Message-ID: <f4c58a745b508ba79c114a3467eceaeb08647385.1785621505.git.coshi036@gmail.com>
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

ext2_xattr_set2() spots a failed synchronous write by testing BH_Req
together with !BH_Uptodate.  That relies on the write completion handler
clearing BH_Uptodate on error, which this series removes: a buffer whose
write failed still holds the data the filesystem asked to be written, so
declaring it not up to date is wrong and makes callers re-read it.

BH_Write_EIO says exactly what this code wants to know, and it implies
BH_Req, so the pair collapses into one test.

No behaviour change today - a failed write sets BH_Write_EIO and clears
BH_Uptodate together.  It stops being a no-op at the end of the series,
where the new test is the one that still works.

Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 fs/ext2/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index be63f89402a3..39005ec23fe5 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -769,7 +769,7 @@ ext2_xattr_set2(struct inode *inode, struct buffer_head *old_bh,
 		if (IS_SYNC(inode)) {
 			sync_dirty_buffer(new_bh);
 			error = -EIO;
-			if (buffer_req(new_bh) && !buffer_uptodate(new_bh))
+			if (buffer_write_io_error(new_bh))
 				goto cleanup;
 		}
 	}
-- 
2.43.0


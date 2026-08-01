Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07083BBA1D
	for <gfs2@lists.linux.dev>; Sat,  1 Aug 2026 22:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785621692; cv=none; b=qXxybtPX/MhVAoWv78/CgkkXzK1/3qE/7b47XKsDDA7HyoeK/LFgv+bIY73ciU/df++6MTp6Dpuwz1D/uB8J3Bf+gvu2gbFJQdTMEhWJwmce8dBK9ME84uElGmiNuGo6QwicLku8yQ7UKiyoIhMubSWISHtIydb4RDp+GZEI1HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785621692; c=relaxed/simple;
	bh=8eaNHjlxdd2m/7vaM8HHzpWZ1ndxEHRbTTCO2KCwplQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdcVUth1IcC3R2c6CXjQ7nuAo8SiGniwbxeJGV8W4t/80LEDKQlm/P27wmP/J2jK0CA9nd/t7qayyCwJTQ5P3h7IGThMn3v38NTVA/kAO8tgs5oHOQpoCltTGOwIkdYWlj+c+uFU29MoetHO/IgbyOUExtkcx3IPApEZ1+rgY2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxeRteRz; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxeRteRz"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-80cebd41372so32695817b3.3
        for <gfs2@lists.linux.dev>; Sat, 01 Aug 2026 15:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785621686; x=1786226486; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3pK8MlUvCqFzPv9m7RxaKBOJ8dELfs23G8cRNXDTowI=;
        b=IxeRteRzuvDRh6EaNFcvv7wOvyGKQbdN+6K+NyZ979d82C24Cy+DN3uSks2h7Snv/v
         rtu5xSHGIW4Pyes/sVRJLUjZ0kSeE0bZ5E86Kn7DsOT5/OT+wWeWP0GddvLbKS7MMY65
         nvwsQGPKsvKBLYFk7lMc1qkim2n8e2NeBrnidle3GB/TqVpu8/4MuGisMCCbGyws38SJ
         fjTTyWCRPldNxaG4tbJQzDDioRcUWrF7CNUaowKu4WnQRaYZA+KAyPebw8ZO71apwCeQ
         nM3c9nX8ucljRRdgyEWYNuEoCcYCSmP4nU3SGsL/8FenAvRTBjmjLoAV1z81krsx1p6S
         7zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785621686; x=1786226486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3pK8MlUvCqFzPv9m7RxaKBOJ8dELfs23G8cRNXDTowI=;
        b=l6sZ+ptYjNYoCtU8Yym859KZ2VOq3eAhnnQscw4Yk6A0xrkRUuCcQTTEcr24JxsK1p
         TEl56ibm+VeiW0GwVTutZNKcpcLllaPO7ddLYssSuDv8C6x8iKyB3k9v0S5G2zEaAEgj
         8xk6MdxWf+T487WekcoHrePnCAHr5LWpF8ru26Y7DFRCSpEfkhxeoDskltftmlRicO/m
         uFkIFXVcOXebNWMb8EpI4zUU15nMHMUKBCA3Gfwh0S/hh5uDJKhMLjXVCHDM2NapK4NI
         PVjNufD8zQR/CLdvxujEXnK+UGC+Ewya7nsua7M7LYhYdCdxCFC6TtgLRzWM+YPzbD0t
         6D5A==
X-Forwarded-Encrypted: i=1; AHgh+RoEmJE4KmIjWRwqu+Va4kgdISaG+Vrv726QBc9CIbsXAqRMDRhI3Wm71D7aLxqsjogr0kxM@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9j4rPVxsC5c37h/pFPKwp62vAMKZa26tK+FqUCs2PHbi6IZJn
	FVQGzOBXOvg043V8r/THIF3x4+hLcmZB6DV2HOkKkE/hVXRMN0U/nz3o
X-Gm-Gg: AR+sD103nA0G13ATUg4BGOOBCP9Lm1vDFnZWg0S31n68ZbYwKvHMcNk1N+QFcFbz2rJ
	g8A/qGEOeDDVjGZsD9tFHypt3NWUkmTbsxKgMuhGna+TLu+fM6pTOyDnVOFwRJIH1VdFnbbk8vg
	o/T2ERJaoB046rP/M8Y6VCMEPdgEvBmC6HvxgVF1vY571kmGxEcHrwr3fFNBK0jfNNr1loNMQK5
	yZf0KpmKJ1fjyuAJEvUzzGaYkmw3aPPTGBnW0T2SimLWFULNwewa5CgpE5q6DIMiiXXisMVdl+Z
	kSG64MMstsYY+wB/C/kpOlMHOtzOq3hXOKUirJUEtG4EXhYG6lZRmUzcOEXf0amVsBUDh3vDf+o
	lvFFMoFkPZl/Yb0ejZFc7MjspppjKsRxzv/mqN3pW2ank3TUputfKjx/y2cJnc1VbZUzo7lvKj9
	3VMLdhuXePrYOs0sJrb/rAPwpN8rvaxTMop+wjEyPlc4M/+VKlXLqruQ4DYBM63PQqKSfTuqrWg
	vH8lI0=
X-Received: by 2002:a05:690c:6f10:b0:80e:5236:b930 with SMTP id 00721157ae682-81fd4c9064cmr74857937b3.36.1785621685651;
        Sat, 01 Aug 2026 15:01:25 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd0d6fbbsm29903767b3.25.2026.08.01.15.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 15:01:24 -0700 (PDT)
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
Subject: [PATCH 11/19] fat: check for a metadata write error with buffer_write_io_error()
Date: Sat,  1 Aug 2026 18:00:55 -0400
Message-ID: <202c109fe73ff6899235aab9dc19ba15eeda0d5d.1785621505.git.coshi036@gmail.com>
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

fat_sync_bhs() waits for the writes it issued and then tests
!buffer_uptodate() to find the ones that failed.  That relies on the write
completion handler clearing BH_Uptodate on error, which this series
removes: a buffer whose write failed still holds the data the filesystem
asked to be written, so declaring it not up to date is wrong and makes
callers re-read it.

Test BH_Write_EIO, which is what the completion handler sets and what this
code actually wants to know.

No behaviour change today - a failed write sets BH_Write_EIO and clears
BH_Uptodate together.  It stops being a no-op at the end of the series,
where the new test is the one that still works.

Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 fs/fat/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fat/misc.c b/fs/fat/misc.c
index be18f6b5819b..4a4cd0111e47 100644
--- a/fs/fat/misc.c
+++ b/fs/fat/misc.c
@@ -356,7 +356,7 @@ int fat_sync_bhs(struct buffer_head **bhs, int nr_bhs)
 
 	for (i = 0; i < nr_bhs; i++) {
 		wait_on_buffer(bhs[i]);
-		if (!err && !buffer_uptodate(bhs[i]))
+		if (!err && buffer_write_io_error(bhs[i]))
 			err = -EIO;
 	}
 	return err;
-- 
2.43.0


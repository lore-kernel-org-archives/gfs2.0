Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA0A3BB69A
	for <gfs2@lists.linux.dev>; Sat,  1 Aug 2026 22:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785621695; cv=none; b=uJF5rla3dAsD+yqXyt7XkuCJLsEmAwevZ74d37Y21F38Xn0hbvZqg5LoLYBDzw9GXO4eHc5safVmRxJtJZBO2lZ5cDLbqZTjxbZXvdNmkzbmI2aIGfh1noJXpDAAkXsyLgxycLcqL+lnhEtESK1mvKyKZ+pN3cHsRiTuNrZ2dyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785621695; c=relaxed/simple;
	bh=luLrRtkts7duEn4/GPgzY7ldWmmHGqiqpJhG8wUqy44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SOhQGM92G3pTLzZ6drokTN9DTFxrFRdiLn0B9eaywGsk3uT1jwlq5tVswF0iH8LRGNmBzjwVadKuhUfrXIm0ZXo4ON+uRiMdgTZccHW56rUJwu2JgIEE9lRKwGvLCP3RzER+L5w3viHvSRoaluzLCLJ17C6wL7cYhI4ThCMIQqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUrx8jJL; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUrx8jJL"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-81fc442789cso32955377b3.3
        for <gfs2@lists.linux.dev>; Sat, 01 Aug 2026 15:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785621691; x=1786226491; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0pFv0xCjYx7PImBsEcBITOWzdrDyUn6BmUrT79FEDLI=;
        b=QUrx8jJLOjBH6ykZCJIgmuNv6MeUe3antSFNYo2lrPpboVzQvl4JH4oIc1eeGeIxPE
         jW6f19zdxzh8Tfwn5CHE45FxpvMaJFy+FXUyysVNbzq/6EeM6gpvqY1PtQbZVUmpqT5f
         HybV2gl71Qet4Er+fdDJMQrzePBsr9dsmBoHeJaiJIjpGcTfvJPPEZ+WNvdUJGWAnxql
         asAUlWgtdcmmzeAS6ATytAShseE6XZOfZxuiYgxj0raIaHA6MpLRHlzk6lYqVK0mfb19
         oogGJfN2D2gCxwNcoy9O/+EcST/xGB/GucZPEOjTV8RsiLLO6akJVbsvZcxITUPtjSxj
         IJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785621691; x=1786226491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0pFv0xCjYx7PImBsEcBITOWzdrDyUn6BmUrT79FEDLI=;
        b=EQzeCzJ0msZd6ltZXBdnkd+daSNfrIlNQ+XA85X6NNJcxm7LtxUYuMwwNj7O8pInBe
         2lPi3GurT89FCapZu7UClQYgA7vHJ5sdvTbIyah6M54vf4PhgAtv7WrLvDoiWgnZPFgZ
         GbXF9F5RPh2TVycdsb3y7bGCDb/Rm1ToaRlOuZXcuBoUP6fR2nIEcNm0aTeV5+TRHHo3
         7o3AES7OoRcNUapYQ71e/vCeop5SQBMpRLuK35jyfgQustY1MZDe6OyutWgzfejvbEX8
         6LQvW1hayVQFcc+YTxrm4OfCB5Pz/J8ueOdWqvJ1bOMWpb3Q3ZIBV6Q+kTrA69p7dW7X
         5xmg==
X-Forwarded-Encrypted: i=1; AHgh+Rp1mg5Nv6MolD7EN9x8v/3ibw4nSLM3kn+adHm3DI8ezmLuzOBrCwJkqOP4ItP+3usYEGLi@lists.linux.dev
X-Gm-Message-State: AOJu0Yx82DiWlF4+xLbppdRJ2fbqAGijTxZJ+kkeiH8M3BHtWCNYD82W
	b7I0rnws4C71k134Havgo7HUHIQRaQ2FcF9cTGPjR9wOVUVjfxwMn0I9
X-Gm-Gg: AR+sD122im+HCT3uwrqZ1HwAQ3R+0TI1ju8Z3QLWVhSLMuwNDnesnogpp2pbSxhOVgF
	+LbAEul4s45NRfTNPynqQck1eEAfCZnjEl1cpdPt7BmvXYEE43TSh+XcB530T+/8FlcStB0Rub5
	XKgpAQJN+trOk8MMXSnwXQexei4LIkvyI7mIF+3Qz7DTOjsh2/CAlwIVbwmcYZwIcoezSYy1X1g
	dJvbRO6N76/7OKmP/Hy6QAcbtcup6OnwZ16o+p/Co03u74X9LZC9j/b3hG+eFSObMeKJbt/FzH+
	TA5PnjoPugE8u49pRIzno6ZS8QhDiaeAIr1jsKo74k1QtI9KkY1j9KpSSGzrhMHgjR7p2gQrJjd
	yodtGfONRF8x5PBDeG9qxg4nrqnfKPfyjI0TdE9W9oakoL9o46xYjCwC5+/I9ldWBh9rRVqkj6m
	63YmJ+iTcSiiLiQQNqgTiZrIPUtpjlKkUuQ817uS9MsGjREYv0+XIlvQVcGuItYGdcUqNd98LSz
	yh+8DI=
X-Received: by 2002:a05:690c:368a:b0:81f:64e8:cac5 with SMTP id 00721157ae682-81fd49cbf8dmr71805897b3.7.1785621690658;
        Sat, 01 Aug 2026 15:01:30 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd0d6fbbsm29903767b3.25.2026.08.01.15.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 15:01:30 -0700 (PDT)
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
Subject: [PATCH 15/19] gfs2: check for a metadata write error with buffer_write_io_error()
Date: Sat,  1 Aug 2026 18:00:59 -0400
Message-ID: <2a0450b24c7e6c8d7a2648196f51852c45bfae33.1785621505.git.coshi036@gmail.com>
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

gfs2_ail1_start_one() and gfs2_ail1_empty_one() decide whether a buffer on
the ail reached the disk by looking at BH_Uptodate once it is no longer
busy.  That relies on the write completion handler clearing BH_Uptodate on
error, which this series removes: a buffer whose write failed still holds
the data the filesystem asked to be written, so declaring it not up to date
is wrong and makes callers re-read it.  Test BH_Write_EIO instead.  In
gfs2_ail1_start_one() the test is the positive one, so the sense has to be
inverted rather than the flag simply swapped.

This is not a pure conversion for gfs2, because gfs2 already has a private
write completion handler that behaves the way this series is heading:
gfs2_end_log_write_bh() calls mark_buffer_write_io_error() and leaves
BH_Uptodate alone.  Buffers completed through it are therefore invisible to
both tests today, and start being caught once they look at BH_Write_EIO.
That is a real behaviour change, and it is the one gfs2 wanted: a failed
log write now withdraws the filesystem instead of passing silently.

gfs2_pin() is a different case and gets a different treatment.  Its
!buffer_uptodate() test is not only a proxy for a failed write - a buffer
with no valid contents at all is equally a reason to withdraw before
pinning it into a transaction - so the write error test is added to it
rather than replacing it.

Left alone deliberately: the BUG_ON(!buffer_uptodate(bh)) in gfs2_unpin()
and the two WARN_ON()s in fs/gfs2/rgrp.c.  After this series they simply
stop firing for write errors, which is correct; turning them into
BUG_ON(buffer_write_io_error(bh)) would newly panic on an I/O error.

Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 fs/gfs2/log.c  | 4 ++--
 fs/gfs2/lops.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 78bba8cc10b8..e3e0dcb1f567 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -107,7 +107,7 @@ __acquires(&sdp->sd_ail_lock)
 		gfs2_assert(sdp, bd->bd_tr == tr);
 
 		if (!buffer_busy(bh)) {
-			if (buffer_uptodate(bh)) {
+			if (!buffer_write_io_error(bh)) {
 				list_move(&bd->bd_ail_st_list,
 					  &tr->tr_ail2_list);
 				continue;
@@ -321,7 +321,7 @@ static int gfs2_ail1_empty_one(struct gfs2_sbd *sdp, struct gfs2_trans *tr,
 			active_count++;
 			continue;
 		}
-		if (!buffer_uptodate(bh) &&
+		if (buffer_write_io_error(bh) &&
 		    !cmpxchg(&sdp->sd_log_error, 0, -EIO))
 			gfs2_io_error_bh(sdp, bh);
 		/*
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 6dabe73ad790..3df6e4b7e8b9 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -48,7 +48,7 @@ void gfs2_pin(struct gfs2_sbd *sdp, struct buffer_head *bh)
 	clear_buffer_dirty(bh);
 	if (test_set_buffer_pinned(bh))
 		gfs2_assert_withdraw(sdp, 0);
-	if (!buffer_uptodate(bh))
+	if (!buffer_uptodate(bh) || buffer_write_io_error(bh))
 		gfs2_io_error_bh(sdp, bh);
 	bd = bh->b_private;
 	/* If this buffer is in the AIL and it has already been written
-- 
2.43.0


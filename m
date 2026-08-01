Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93683D2FFC
	for <gfs2@lists.linux.dev>; Sat,  1 Aug 2026 22:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785621700; cv=none; b=hTOKeywuvVNnH7zEpJ4LpgNte1jfqN6d2NDCB9ozck6A6Wjamd6kZYlqVplamIPjonywep7xF4ele909LINk03EOv17tBMTRQX4dpbbW0Tk9B3IWC7E3H2Y9QcWIagwvs7gTsX+FtaeIzkDym9NDDseBnvz6Mao9WIIJKwH7T40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785621700; c=relaxed/simple;
	bh=EXr243hgt49VO+NVV7qJVCHwNBqwGmV0A3daLRpsT44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0rDarxQAakNaUYm4V7kUmvv/cCwFIW91REFcwXx5iZTxBLjh4S2ebuFCnR9gKSBqWADAjJ38o45FnLh88UpiXIIn112KvlXvZkK1a3M6fKONQqT74v+dDJn4gBJfH0QqsdEI0d+ngIdSCdRkOoWw0vQQJzAQ+E6hRSbODZpnUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXek0qee; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXek0qee"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7dbcb505578so19120427b3.3
        for <gfs2@lists.linux.dev>; Sat, 01 Aug 2026 15:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785621697; x=1786226497; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/eXvH9gfEzZ90R61WLxV17LvM97s4H8IYIhHdEQdhoQ=;
        b=fXek0qee6qabBs3XBEa7UxPPHb6bKEsGisza2jbAqMHSRc/h0Yraje51JL5+x3oYpq
         VEScjDf7CTtoGsv0bxutzk4Hz4YTpQXqwT89Gv9w5nKexFDW1gS5zI8I3v0M1TLS4RUa
         ko0LI6/CHeKMO+6no0MB9nk+CV+AoeIK/4wFMvAqVbLjW1i/BJ5FcfDXwxjqBOD2uh9M
         whadCi+nhTMxCMEqN/TdsI3ChrcDGe57SX/scGCqkTeNDyPE/nnIm2Hoa3gJIEHweGp/
         czeQPB0cwOc1tmk+2ft/OSRqgrPqUNFBZn/ytpjpVKz5htu00yabZfYjbjhYC0PBIhwG
         s5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785621697; x=1786226497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/eXvH9gfEzZ90R61WLxV17LvM97s4H8IYIhHdEQdhoQ=;
        b=lY2WU20vcgYnmF6PzlI4MV3D2jh21KTMLqxH84/Dxk3BfPyzCF7xPJC2WW7T1sdy4r
         tKED4Tc/U0Q+ztfuiFCr9YWRti7akhWdFkUAiti69kjLYXlaesD/5V3oOb97MeN4/zUh
         GfUDRa4XGf1lRhFReeCZD8g6BGSX8yAokjov8oIGsrKBhPUlaT20YkcKa33AojOUFZuc
         2CPKXgkjWOMCLk/vN8anO5xOlz+mUzT/wUO4OnJ1sPxfBPV8L54RiGgiY46SHAONkyWV
         kAuOyui93S0jh5iMO3AROmenakkjVPOeSyvkBg1Egh90aZUEcP02PGQJqDov6LGckOqR
         CI4w==
X-Forwarded-Encrypted: i=1; AHgh+RrOc6t+60q1X49eoBcAUAkPO1INmnhrE/XkHg8ALvIZWSl35UUPHoubp6S7HSzI7RgEs5eB@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9cSnzWP91DlusoHQsnQ9xvjBKFkG3+fcLbq0FQX9FhBKtD6KS
	yAYHsWN0Kufy21eDXA+L1D6+FMQtSxOgsjRhj3BP6H3LUVhDYgaahEpH
X-Gm-Gg: AR+sD11mZ5I4qTaoqiU7BbwqTFL2ZT2Qa1z88ue1MqHqRbcXzHrv+D2T81gHLtt7rGI
	svb+xM+mvtmxZ/JLG+fVwm8zBV5JAgJGTJKId+OZXILJVa2Ya8NNCu5SDLSJf1UpEdJb3Vwr66n
	zXMQsAjRxbWNyUbZpk2Jf2bEQNu7zmNQYr1ANyjFbyKNbC36Co7iknJXAf0XpiQvcs18lnT6K/t
	217XjbOnrDJ5XWe5nZSbO42UCwo29DmxJzYW4bFCVPXgOvTyZnhG03XnIx1mPoPUkLM5l0uD3mC
	jbCtCc5e7F453g9zhzM8Aco9Eq7hRKdOGhqt57v5G7l0sURc/as6I+bx3fV6YasTU37V15cnvUX
	5hKE7xqHrXZiikPMqPsma9oOeO3uICcTnNvSfNCk984jX2w1AuMdl94oxrmVctfCqApdNOJku91
	DMBOcrpYp6OqHTpSC5rjqcCbl32c4zjoj//2TeRxLPBsOBDQFoJp8nwEXWyA4jLElJMyrGVbuyh
	Q39BcD4ZmHkyn7izw==
X-Received: by 2002:a05:690c:6601:b0:81e:c7e5:df5d with SMTP id 00721157ae682-81fd4b51de3mr65716127b3.17.1785621697195;
        Sat, 01 Aug 2026 15:01:37 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd0d6fbbsm29903767b3.25.2026.08.01.15.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 15:01:36 -0700 (PDT)
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
Subject: [PATCH 19/19] buffer: stop clearing BH_Uptodate when a write fails
Date: Sat,  1 Aug 2026 18:01:03 -0400
Message-ID: <3aa278c3b75de2bca8a94ec0c0e40922b1170881.1785621505.git.coshi036@gmail.com>
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

A buffer whose write failed still holds exactly the data the filesystem
asked to be written.  It is the disk that is out of date, not the buffer.
Clearing BH_Uptodate says the opposite, and callers act on it:

 - mark_buffer_dirty() has a WARN_ON_ONCE(!buffer_uptodate(bh)).  A
   filesystem that dirties the buffer again after a failed write - which is
   the normal way to retry - trips it.  That is the warning this series
   started from.

 - a buffer that is not up to date gets re-read from disk, which replaces
   the data the filesystem was trying to write with the stale on-disk copy,
   silently.

 - the window between the write completing and the buffer being marked not
   up to date is visible to anyone holding the folio lock, so the state is
   not even self consistent while it lasts.

BH_Write_EIO already records the failure, and by now every place in the
tree that needs to know about it tests that flag instead: the two core
helpers in this file, adfs, exfat, ext2, ext4, fat, gfs2, jbd2, ocfs2 and
omfs, converted one filesystem at a time in the preceding patches.  The
private completion handlers in jbd2 and ext4 fast commit were converted
along with their waiters.  Nothing is left that reads BH_Uptodate to find
out whether a write failed, so the clears can go.

Found by FuzzNvme.

Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 fs/buffer.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index ac978d9090c2..0002f0736398 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -207,7 +207,6 @@ void bh_end_write(struct bio *bio)
 	} else {
 		buffer_io_error(bh, ", lost sync page write");
 		mark_buffer_write_io_error(bh);
-		clear_buffer_uptodate(bh);
 	}
 	unlock_buffer(bh);
 }
@@ -441,7 +440,6 @@ void bh_end_async_write(struct bio *bio)
 	} else {
 		buffer_io_error(bh, ", lost async page write");
 		mark_buffer_write_io_error(bh);
-		clear_buffer_uptodate(bh);
 	}
 
 	first = folio_buffers(folio);
-- 
2.43.0


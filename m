Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1FB367B97
	for <gfs2@lists.linux.dev>; Sat,  1 Aug 2026 22:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785621681; cv=none; b=tShyymRGaiP/qR/mY/YBmme20LQCHpqagGByy3qnLJ5nTk1KONVvwlc3N2ugpnjsA0iC5/VHdaQqDoDhsEbyZY0KScHiulwSQmoNjWcsPLLHrsTfS+KV/QwXMoPBY6AZB3amVgEnx7U3VN1KpuLzjbG397dMEzvmkuotyuk+30g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785621681; c=relaxed/simple;
	bh=nTKqFaIO4eWueECCBUw01WYSenLBpxO8tTFhLp4DI8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jBQfu1cckFxHkISFIMBwS9+jshhve8ygftzhcL38rA/Cc2BI/xczd40ojRo6hiszJvHKx9bL32xtrC7Ymo68Cz4r6Xt3Wf8gm/A9TkKj+OFNpIp4SBFPMmxa9cvlKnJkr1fspMPWdvO9ePNB6veBq/RpRu/rih3FnqH0OCNkzC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpM4sW4Z; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpM4sW4Z"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-80814edb536so31512007b3.2
        for <gfs2@lists.linux.dev>; Sat, 01 Aug 2026 15:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785621678; x=1786226478; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Vy4j4aElKFiT0ILAbTnwQA9DPnzOxaRGdQq6jv8GAw=;
        b=gpM4sW4ZZdhY2bs8Mqv/V1/ZFCISkfm72dsOh/IEoQMF4gjsDhivz/dhadFSAeNEqK
         qOwdEAbEWl+bxjea1/+au3Nu3EvPziTHvNrGWvahyOrvE2irkbpFM8Xi24Ly39VkBm5o
         dGCoIZxV2lJIMkf8dG7FnV0f9HOxg5pHC4/iz9CATxxShIsAfR+GeIeQLWeLDnZW9gPc
         GXOlcA1aQeWWiBU0VhWGgqRBYbLbuYnA8mpOQbPfSf9D8pyfnD3JD4ebf4IVDZZdyP6D
         n+4GGfhUX7UUrN8Fo75Zq+BhYjIIjEMhdaXElU0modtpbuvk1o4ecB04px9kteoHziPU
         g//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785621678; x=1786226478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Vy4j4aElKFiT0ILAbTnwQA9DPnzOxaRGdQq6jv8GAw=;
        b=WPN5GTdLuriiyA3xJU6qC8X5igHiLOPDId+LmCrmoOX2Oig/fngHKvBlJCWgikwTZ9
         bEdPWCTbRH6nQazi9VTn+dhkaxvmAcVnRLonvPL+RQLEi17yAw51SoV/dp4WWG457om0
         FO9E3dZNgACRNV+oeL1E3VbEVzdMNNmYruiRYehVt/1h2BriWbJTcvteq1jm/o0OSWfy
         uLClhxLAbynqo60DoGWBL3Ka6bGqRfQRahS9qd+LZ92rx+C+duuA4SBKNm9mXvp7AT4f
         30c3nvotpe4IwKoOZMIllHskL153aH3hZL6bQv5+2msiwPfcMGo//7cABg5RGK2KFPQJ
         5p0A==
X-Forwarded-Encrypted: i=1; AHgh+RqbuVIlJEfD5o6wPTflewx/n3jjQZm4ONESWin83oIy+8Ie4+Q8GMJNJgyoWNTchQHow+8W@lists.linux.dev
X-Gm-Message-State: AOJu0YwRKiv154aEcDhE0s1zaJX0rcd06A5GNeb8TpA05zQgL3ZI9yqi
	7tGsD6zIQZhQV4h0DZIF09fZHejraVUUIPDLYZ8AcMjnuZG8YR5EMESi
X-Gm-Gg: AR+sD11K86cfPawxBwbqa/N2rOiAmx97SC1zRxf1D2+baa+gLI96zB5Rie3rTf68Mk8
	x1g2vC2VrHCTOI6Fd4WhlF95o4s8Xie9OMorbsr+yEcUFQPh7xWH2RR9drVW0s82vdQvYLaKh2I
	kGA6MD+vXLwElZzt9R0jx3SdFEbiYvanvNUSVqQli/d8IyJs4KFuM66K6f1hdc5xAbkyja5WpCj
	ntUzJI7J2bFXU0lf6ySCAmm9oZ9YUhYScnej8gL7cla6QsM/UMxnN+bCGmOPVfcKWqUGWxxLO7v
	2L3Upj2NWjsbZnGNT8a1G5svMTsKyAWxIl7QdvzKdVp4HFeJE9t9bEFs6JwvYIBvivS6Kgi/G0Y
	c7ceyO13hWoPbYR4MHq+MPngjbIb7eavjFA3wOqYAtkYKQMCpN5ZpsOKPsTjP57MIpAesZlmztI
	tLN6l/5aZt24VWV458U4dS2Uj4h3frb4FWGMIlDk3ToEIWxUz0CIJLf8VgUdh0c7emjLnC24EZm
	QpbPPk=
X-Received: by 2002:a05:690c:4442:b0:81e:c972:e8c3 with SMTP id 00721157ae682-81fd4ba85d1mr75578147b3.29.1785621677847;
        Sat, 01 Aug 2026 15:01:17 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd0d6fbbsm29903767b3.25.2026.08.01.15.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 15:01:16 -0700 (PDT)
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
Subject: [PATCH 06/19] buffer: detect metadata write errors with buffer_write_io_error()
Date: Sat,  1 Aug 2026 18:00:50 -0400
Message-ID: <adebc1e3de48c3e997057d10cb78756dec03b800.1785621505.git.coshi036@gmail.com>
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

Both places in this file that report a metadata write error to a caller do
it by testing !buffer_uptodate() after waiting for the write.  That works
only because the write completion handlers clear BH_Uptodate when the write
fails, which is what this series is removing: a buffer whose write failed
still holds the correct data, and saying otherwise makes callers rewrite,
re-read or WARN over a buffer that was never wrong.

BH_Write_EIO is the flag that actually means "the last write of this buffer
failed", and both handlers already set it via mark_buffer_write_io_error().
Test that instead.

No behaviour change: today a failed write through bh_end_write() or
bh_end_async_write() sets BH_Write_EIO and clears BH_Uptodate together, so
the two tests agree.  They stop agreeing at the end of the series, and this
one stays right.

In __sync_dirty_buffer() the flag also refers unambiguously to the write we
just issued, because __bh_submit() clears it when it resubmits a buffer for
write.

Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 fs/buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 50a63d964815..ac978d9090c2 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -618,7 +618,7 @@ int mmb_sync(struct mapping_metadata_bhs *mmb)
 		}
 		spin_unlock(&mmb->lock);
 		wait_on_buffer(bh);
-		if (!buffer_uptodate(bh))
+		if (buffer_write_io_error(bh))
 			err = -EIO;
 		brelse(bh);
 		spin_lock(&mmb->lock);
@@ -2743,7 +2743,7 @@ int __sync_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags)
 
 		bh_submit(bh, REQ_OP_WRITE | op_flags, bh_end_write);
 		wait_on_buffer(bh);
-		if (!buffer_uptodate(bh))
+		if (buffer_write_io_error(bh))
 			return -EIO;
 	} else {
 		unlock_buffer(bh);
-- 
2.43.0


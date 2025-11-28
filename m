Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B8E2E8B8F
	for <gfs2@lists.linux.dev>; Fri, 28 Nov 2025 08:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318765; cv=none; b=Iu7b0vLKzkAwEZu4WRRjzZhondmF8wgsj/Ju8aPmArD2WhWtZzYoFJ3l8eP/PiNV+c7hD4eKQRQRlm4PQ98c3boFrTKfN3lOjn4YL018tGZW+3tn5wBhnzunP+2NU7sHMpcPypM+9yI7+MH9OUTkgazacvmBpgvSaGC7zKpgl4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318765; c=relaxed/simple;
	bh=nbYby2EM9de8liKCH6EPXwLAr+CXSG8jGQgCdHY1huE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n4rwibzc1cwO66wQiWoFspK68W2NsyQz/h/OMBzU5PjK4Mkfyzuik8CrKzYHmNxziIS7YDJe7f381+gAReT8pFRRkdAepeWS0mtMdP+DABbqMz+kxb+l9K3f57V1yMmfhuLTZhND+0lBv3w8Lk8NiMW7KFE+Lkkj/LkJKD1k324=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3BtgFLq; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3BtgFLq"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7aace33b75bso1542900b3a.1
        for <gfs2@lists.linux.dev>; Fri, 28 Nov 2025 00:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318763; x=1764923563; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEXNzDk3PZG7Vl6bACrm82r4Ym6fDNxq87feOMpROvE=;
        b=N3BtgFLq/cvdaTHlVBJ2zwKAGS734L+NqR0I+kXcichDYbnjBlJjiURhOHahW1oKjL
         DbEF0raZm3LgoFJL+gpA5O3PU3k1gLRs/IiWClPGJgP31coEUAolCu+lwb92LlB0LrP7
         +Yw+IJcsyjhfdn4Eg7zLIp0QMvvAtkwHvUnJk7BVwpcIS4tDUtbHs6wobiDET4T6pOjH
         Vzq6PENS5HQ21n4EbxasHxfYEk3EV5rvZpGXsLGDT9HI7fXWAwR1QUeexCy95VqstBUC
         7qhaFiOz5GYvG1yHaNFW3Dz9uGSfENUIplIXP+XklRMYJ6m17jAWUYhTBcc4TLjCdN5y
         YgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318763; x=1764923563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wEXNzDk3PZG7Vl6bACrm82r4Ym6fDNxq87feOMpROvE=;
        b=DWul3Vvm28+XjpDFrsQOmh++/+tP15Z3Ra+ZdEZP4frQZ07zO7ryRLywkanMt6AdZD
         LLSR+r3sbUpnbxkeZ0Bzar8uRFLXfNVCVRwBFf5d97LKnD7odpyMzEbGhAt4GSrEIWp5
         h5zMoEyWWkEOWrAlOA7huw/j8OneZ833Ul2tKReSCiYmx3laAuWOkCtoRpGFINP2sml1
         WD/mgyaVS6VqkUzZ1GWkJOjwLonFTL4kfnchsdAsSeAKjXbH9kKgL2d4ReeTJzVBhDdT
         t9Xjv8Vjy6QIVOomwiXHtMpCOALyQBaRGdgGPkpDlnf5oJTqYSVhYLk2B0tOlGqX+wsR
         OJfw==
X-Forwarded-Encrypted: i=1; AJvYcCW4H+Q5awsQN8Gx5/2V3n2mZGIekv/KBgRgVPqQImoM8WEwhxrHOlODBzLuUzXreiqUwfbJ@lists.linux.dev
X-Gm-Message-State: AOJu0Yw925x9jLd3+L76VIY+VZr9kSUXOp5Ek3ILEpBiNzkqTKzMrhpC
	5kOccJoEh9yxnlqq7ckMraU0++9Bowi0HFrDznJyAtT+ytAUactSlTHB
X-Gm-Gg: ASbGnctm/3u19z8FdF9o3RA4M6NFKxMD0jQm6ZUzIHApZyCTjBo+MgTkuUJTCmqYNUu
	mQzRGLn9xF7mO3/Q0BwvKwTnKFC3hr8c4x7EzQPSrnqBncLfb3psm837xaxdNGsMrKjRM492oek
	fGfUKZF5gJMlLqp34Aj4UV1Wuu/qARn8SxckiS5eE3dsmbRkjwpmWJfiNE9kzZR4kQ+ZO776g+T
	9y6Ybuq2OQutI86NRR5IafhxNdCZ7TQ19kay8q7c1pe4SuUSrDLz7NdJR+PbVPoyA6mt8ocIlXJ
	+ff+dBptnTLyESpmPW+p0+f/39xUkn9YZLQoxrUU/cP5b0l234P6Q9SyqS+ZQABEm9CrNCvT/+X
	7lyNcM3iXrMoTD/Y/1bVWfllSUJimiSW0nDRR5/68jZBS+sbg0dWjEJ126KK3C1/MkxmWSkL3aM
	XgAuZFUhbZ5Fk8XzyfKzKxz5XGIQ==
X-Google-Smtp-Source: AGHT+IF16ld9QNCqaVETJUBsXYjs2kY4Pw4mcEH3R6jDofKcar8TG/UX/uqF2Rs9fZ+s8kH1ElEzpw==
X-Received: by 2002:a05:7022:7f1c:b0:119:e569:f615 with SMTP id a92af1059eb24-11c9d712704mr11436137c88.14.1764318762983;
        Fri, 28 Nov 2025 00:32:42 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:32:42 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	gruenba@redhat.com,
	ming.lei@redhat.com,
	siangkao@linux.alibaba.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH v2 01/12] block: fix incorrect logic in bio_chain_endio
Date: Fri, 28 Nov 2025 16:32:08 +0800
Message-Id: <20251128083219.2332407-2-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251128083219.2332407-1-zhangshida@kylinos.cn>
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

The `__bio_chain_endio` function, which was intended to serve only as a
flag, contains faulty completion logic. When called, it decrements the
`bi_remaining` count on the *next* bio in the chain without checking its
own.

Consider a bio chain where `bi_remaining` is decremented as each bio in
the chain completes.
For example, if a chain consists of three bios (bio1 -> bio2 -> bio3)
with bi_remaining count:
1->2->2
if the bio completes in the reverse order, there will be a problem.
if bio 3 completes first, it will become:
1->2->1
then bio 2 completes:
1->1->0

Because `bi_remaining` has reached zero, the final `end_io` callback for
the entire chain is triggered, even though not all bios in the chain have
actually finished processing.

As a quick fix, removing `__bio_chain_endio` and allowing the standard
`bio_endio` to handle the completion logic should resolve this issue,
as `bio_endio` correctly manages the `bi_remaining` counter.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index b3a79285c27..55c2c1a0020 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -322,7 +322,7 @@ static struct bio *__bio_chain_endio(struct bio *bio)
 
 static void bio_chain_endio(struct bio *bio)
 {
-	bio_endio(__bio_chain_endio(bio));
+	bio_endio(bio);
 }
 
 /**
-- 
2.34.1


Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEA62FF64D
	for <gfs2@lists.linux.dev>; Fri, 28 Nov 2025 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318818; cv=none; b=jhFhMORNPSW3Sg6vj4vI9IexHiBxINjnCmqXR4m8W87wOgm9CW+d+9XzXm0InOCQ9aS41r1Uo0eclZb1O8eeYKi+8r+9KSmdpAINyRVFwQMkT87R+kYuWOdF9ff0h03Y0bdFK3NpMVPBGKvuxGcLe5xDQQvAYOSMkB6x4rggI4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318818; c=relaxed/simple;
	bh=MIUxfeIlXsLJb7D1x07khmxiQaV6FMQZLzsNI6cDMOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pQ7iKFzpBOYysl7Q99UvFtFSdWBoCjlqtjCI8uxba6Hfl8t5zcgchNGXL6VMenreLsljsrROBh/E+JHSNXcZ3mCvsFlOpxF0UN6Lq9XGb8ZrK1x+U0e3YAYPMf8bWoepXvvBES09ZXSG5Rho7nIcDR8kVtCF5y9L7aE/WK7qwl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H97JsPo1; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H97JsPo1"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7bb3092e4d7so1643039b3a.0
        for <gfs2@lists.linux.dev>; Fri, 28 Nov 2025 00:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318813; x=1764923613; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZsPDOjyUTRUehf6LhbOb026Dy93eapwVzPzgOc2prg=;
        b=H97JsPo1LV0dEJ3lm1aMvcWUzzRN9xS2cObapnNjcpA3VW9LbbgDmGMoiXLcZSoOpi
         JRyi7/VdLgs1QpfW5b1MEZ/EBaO0tfnwAIvAiGSEgI2SswH5RYqc0VhsC+KgeqS551bf
         1h1Xjso8J8yvtkuee3N5VTm9s1bFBoccdp0eflPRPCKijwWPPWmMG8KXmCS3pyWOpUgE
         D5q3O/GV5lK4A48yOVngdFyx5xRn1nriqI2bl0shQdRBlnlfZDx8jQKHjfqf/1Jm8vut
         2G93wRuffSM3+xsXnwEm4wTAZEAZD5bLOgCxvdtgEHYsDJTm6eln9M8RGVKPNqHhoVLG
         X/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318813; x=1764923613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rZsPDOjyUTRUehf6LhbOb026Dy93eapwVzPzgOc2prg=;
        b=IiBnETONziJV9iX9svalRtp6jFazHZ+vkLhFT18GMWG60IgFYqku0TuTUO4tEed9B/
         FiBL1G73Ou0R4dZsix5pE3wVC5KWNdwKoO3v+pQ6DhXw43wxryzTfIoka5uaJX1yUCw2
         BXc2wPIwQr5RB02CwwlI+SMqUc/k1Pe19bzh9xSaW6UL69XaVIF040yb3RXxJnmwhX8W
         80+ExPVASm2QOcyfJ1CmMfRqBFrkbE82xt8EgIRGO0xklZH1eIa1FurF6KIRwcfmcDPv
         WOm1qYgqk3HkoJoDZbzLlBE6M1fdGPuB7wK+1ojebpIcErdKubzcTVRDUKfpHA48h/Qk
         muiA==
X-Forwarded-Encrypted: i=1; AJvYcCX6FhmrsY3bfJTSmBLpneKEHUv7YzCMNbodf05tvC6hbp1KuRfV8xEYQlBVawUn7H54D2aN@lists.linux.dev
X-Gm-Message-State: AOJu0YwvwwOVhpUndS6HXigpw05IcrxuGAD6HF+AALppJuWKpiiTMJZ1
	DBiKQxlWmkBmfT4GnNuiIakIF09Tz6/P2DvOaU+gCp7E5MvNP2qhWf0y
X-Gm-Gg: ASbGncsnYVXkgEPqp6BhTltYKVYSDGGlR8f+33cK8LAFru7DhGUJsodd2YHircOP3hc
	lfr8366ro6YmcP4HFyMsYgoo90ISHY11Ys2O8qNfcAOtFJgWWkn9pwtdnpU6Tk72WhlEcvXLpux
	0e4P6HKSp6M65ETI2P39zHEmqEgKD4msWRRydCQkVkXoDEShqi3Tc1Ev9M3f0+fuFt3EajAj3Ub
	AnEdPchXkj7zkwYkvhP2NHz4l1sUupXmHljcIDzlUYPcIyyTI53mQUrbgzxxPT6q7jiGXfz5ks5
	LvRdYcSTViddEVUYRWTF/iD4m1/QAIweurpk0oWaw8v7UA1I+6S956apDC7nBMQvkexmz2gJi05
	XMXQFhLMU1AF1jHNTDVmag7z7vm4NFsudxLCFiLA5kgyUm6BT+Sf7agKT2FJN57lWpQbGnTL5/g
	TKaSCkkaAhhHFGgkKvfrRtlFGmuM/CVKmrkzql
X-Google-Smtp-Source: AGHT+IHqHdLof6s224+GbtnJAk22/n625R68t5gW5XXJrnH8NN05gDy1A3OVkHY/4+FwyWeG7e9t0g==
X-Received: by 2002:a05:7022:3886:b0:11b:9386:a3c8 with SMTP id a92af1059eb24-11c9d867ff0mr21572562c88.41.1764318813388;
        Fri, 28 Nov 2025 00:33:33 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:33:33 -0800 (PST)
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
Subject: [PATCH v2 11/12] nvdimm: Replace the repetitive bio chaining code patterns
Date: Fri, 28 Nov 2025 16:32:18 +0800
Message-Id: <20251128083219.2332407-12-zhangshida@kylinos.cn>
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

Replace duplicate bio chaining logic with the common
bio_chain_and_submit helper function.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 drivers/nvdimm/nd_virtio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index c3f07be4aa2..e6ec7ceee9b 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -122,8 +122,7 @@ int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
 			return -ENOMEM;
 		bio_clone_blkg_association(child, bio);
 		child->bi_iter.bi_sector = -1;
-		bio_chain(child, bio);
-		submit_bio(child);
+		bio_chain_and_submit(child, bio);
 		return 0;
 	}
 	if (virtio_pmem_flush(nd_region))
-- 
2.34.1


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792750727;
	b=xMjg6TWOzvH3l4UZaBpMogEufsikiAs3oAOICpBA7qHbjm4f9eGHPfACfuU7VL5yTJH1
	 UjBaf13dlHmJh4V/u518G8MimvIltfW/phurWN9i9BSUJnqCAx/Y8M70doulrihwjTqtQ
	 VXD0+pHoJJUJO60YMRzGLV2MHTbUvFPbqgO6xGt3mP8TPBwmLE0vTKIIj3P2ZJGnlelM8
	 5jnZIbh1y/eFr62tgeo8Zc9m95bJOUdfINVfdnLtxVbAMh1+S3r3Q1M1Drq+nim3UzLSl
	 0cWkqHPXyjfCr59PWFxg8oXXR6k+1rKlH+qDg3xqCFlgM59VDOXbnshmNu4YRMIHqjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792750727;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=9bxByH0D1K6wGDtk79VrVN4/d3/kh7LLNLXD7fzdbok=;
	b=oGbVmDQ+4BFl0q+OiRyRlSkry4op7ER+7lM3Oim7uEKivzDXa7OpSL80UWFPyeKZKsQd
	 xDfJPxWX3rwXuKV7WSDV27v837d+C8mW6kXxmRUEhBsnWQzW4x6gNHobTCDtSuMcWkklA
	 IgKVFnK/62ADy8KLPoCOEme1VbZ17azeDSIIYpZQ8JuEit6RWux8QLpKUMYItzBUEgPzQ
	 3u1855ad9vlgTLKVxqr1d5VR9DNPBe/s+P8aOpV6FVbcL7hn6VgkaLtOCPItEGpRUO4HA
	 4qDv7tloR/Yh/zz1Ao0quAaSRUSqvCTKxLG9LTW73Yh/RJ+odPs9NOJlo+ps9xVe3tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kMXmYA+u;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DAB60A2614
	for <gfs2@lists.linux.dev>; Fri, 23 Oct 2026 10:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7DAB60A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kMXmYA+u
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a2072b9832so8758135e9.1
        for <gfs2@lists.linux.dev>; Fri, 23 Oct 2026 03:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792750725; x=1793355525; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9bxByH0D1K6wGDtk79VrVN4/d3/kh7LLNLXD7fzdbok=;
        b=kMXmYA+u0fPDgGNLFsyQDeHGGxZ7uwtha064lB9h1hYz026iLb1qAXBov9TRlvQtKy
         xbLpjf+tzr3aOu07kXLPS7zyIphsWb8FzFFL915xrK5MaJq9GMZUcqSKa7Ttr93Wv0E3
         7mCUkf5Atzv1uPIEXPZEh5W/QeiC+PcroihWjVDC/ErCqQZtDbpz5U7kQWg/oJ+h+HAV
         j6niXfj4X62UhnGz/0ayPAQHvvmxkxt+upxFZd7JxhHAi684XccU+kU9euTaNYmYrcjy
         N/osswAGC1x1C4zqofKIfTAW6xPkytJKCrtfVrIC4l+P2+Kx4d1ApSmIS1DO1n2NrKiE
         dqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792750725; x=1793355525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9bxByH0D1K6wGDtk79VrVN4/d3/kh7LLNLXD7fzdbok=;
        b=HTYXx3i3n08f4PHMjuVquJ4Eyx18DnldV47/BJV7pFj8MNQ+Rc/VQYf8/AAuP2p2d1
         7m31VSklQwoe3pKosJIBSt3VyB0fOlremiBqX903a7YTb589Y0f9VbvE6Cus+vTIQFEj
         4yyGQCyFLnprazKkVsnv2eQJOc3O/0HPSryxLs2Cs6qDrdGRsIv+mE5K+5BPyin6WnWv
         T4Fb9FaRk65ljXhdHanAWGm2TRnMqGjuwG/7EQ/BvMeDYwZaqyShJN63R4l3YphaHGnp
         wY41tgzDMz68CXO1mVLh2awE6rMlKYra+p7q4ljO32Z1rYSGYlBrdjLEwzZB9vfU7KOf
         G+rw==
X-Gm-Message-State: AFq9FYIo10IbuzFpOrABgwx7A71qW8owxcdUYTIZTG/2Kfp6bctVV6Gd
	AUP7wO79WjZmxcMOX3NVZgiozBH7xlmaRd9PqtMVsJD4bFnT9r1BTpfK
X-Gm-Gg: AYBFou0A+jodZJK/iXfDvDWj/ojEs7eOwnH5DPu3sjJ8DoonFzFtnmmSs6hK1oss4Dk
	E0+Xsl/8bFVSTQid9w/B1R8a9lI4yJ/PaIVyqYpkPcIpndslASsdj14r0hEpeknksg7Nz3i2tQ4
	rji6X6na6BO9q4z3CrWH1ZlolLzSHgmvUYd6J9PbYmXnsQaVrZ5I2daMrRtYfZ0CYOOqcwwFTzX
	15TU5WW3VF8IA/eqiFjK/PW/Cv3/N0Jaicl46sIX7CyOhuiU8efwKTFqT+YI85ZjI9jS3wdrXBd
	j+y1f1oH+G4TaSoTJDH5fKXho0wYp54NU2BrzheFI2U6wDk6WRP7vD+vbQJiPJioh+U9Uzsbd0w
	0kJRZdSjFs227XkorANByFfNZE18nvJUApsrlLseuGGxYvu4XXetGFXcUiAPZikkqysxfDLLWaf
	bZhW+ts8NFPPSHJYC8IQUE/ef9qjmLeyQsd9ShhSh5iZOW+JQy6SKROjiOlCK8+ytLPPo/BdhXq
	rEVzxxPxZ+q8oHvWuhF0IvASpRVNfetjDch54rHJdQ8+aQEEMDgEvwz8g==
X-Received: by 2002:a05:600c:1389:b0:4a1:c6f5:2450 with SMTP id 5b1f17b1804b1-4a211cac456mr28283135e9.17.1792750725077;
        Fri, 23 Oct 2026 03:18:45 -0700 (PDT)
Received: from localhost ([205.147.201.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a211bda212sm53656575e9.12.2026.10.23.03.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 03:18:44 -0700 (PDT)
From: Eduard Zateev <hackerowskiy@gmail.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Eduard Zateev <hackerowskiy@gmail.com>,
	syzbot+ab91b239b20ae188b9cb@syzkaller.appspotmail.com
Subject: [PATCH] gfs2: keep glocks alive while AIL entries exist
Date: Fri, 23 Oct 2026 12:18:30 +0200
Message-ID: <20261023101830.139094-1-hackerowskiy@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A buffer on a glock AIL list can outlive the glock reference held by its
inode. During withdrawal, gfs2_ail_drain() later removes the buffer from
gl_ail_list, which dereferences the freed glock.

Hold one glock reference while its AIL count is nonzero. Acquire the
reference for the first AIL entry and release it asynchronously when the
last entry is removed, since AIL removal runs under sd_ail_lock.

Build-tested: x86-64 GFS2 objects with W=1; arm64 GFS2 objects
also compile.
The syzbot report has no usable reproducer on current HEAD, so a runtime
test was not possible.

Fixes: 864174f97647 ("gfs2: Don't cache unreferenced glocks")
Reported-by: syzbot+ab91b239b20ae188b9cb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ab91b239b20ae188b9cb
Assisted-by: LLM
Signed-off-by: Eduard Zateev <hackerowskiy@gmail.com>
---
 fs/gfs2/log.c  | 5 ++++-
 fs/gfs2/lops.c | 3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index b55daf1e638..aa5f2a9a94f 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -74,10 +74,13 @@ unsigned int gfs2_struct2blk(struct gfs2_sbd *sdp, unsigned int nstruct)
 
 static void gfs2_remove_from_ail(struct gfs2_bufdata *bd)
 {
+	struct gfs2_glock *gl = bd->bd_gl;
+
 	bd->bd_tr = NULL;
 	list_del_init(&bd->bd_ail_st_list);
 	list_del_init(&bd->bd_ail_gl_list);
-	atomic_dec(&bd->bd_gl->gl_ail_count);
+	if (atomic_dec_and_test(&gl->gl_ail_count))
+		gfs2_glock_put_async(gl);
 	brelse(bd->bd_bh);
 }
 
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 341f5bb844b..c4e63fb375b 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -120,8 +120,9 @@ static void gfs2_unpin(struct gfs2_sbd *sdp, struct buffer_head *bh,
 		brelse(bh);
 	} else {
 		struct gfs2_glock *gl = bd->bd_gl;
+		if (atomic_inc_return(&gl->gl_ail_count) == 1)
+			gfs2_glock_hold(gl);
 		list_add(&bd->bd_ail_gl_list, &gl->gl_ail_list);
-		atomic_inc(&gl->gl_ail_count);
 	}
 	bd->bd_tr = tr;
 	list_add(&bd->bd_ail_st_list, &tr->tr_ail1_list);
-- 
2.55.0


Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6496728E61E
	for <gfs2@lists.linux.dev>; Tue, 29 Jul 2025 11:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753789037; cv=none; b=Pzn5E69ryci15HFJqBo7UmKoPuyEJ4UBHvvlEBKx67nPol1gQWxuHtbSIlWNWXh+vftUTGnEJ5QdTY1TALDppqlc0YqT41BDbxBeklp7WGx3s+APl0zbm2s2seqb0tCtGqA2ZKEMqXaPlUjWcQZupRXi3VxAfm9aiThMLQ0zdaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753789037; c=relaxed/simple;
	bh=/I/3lRQllP72A5X0WY0LzC9VCCzliPkA8YXx4zJGUak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ODNBh05dpViEMOCIGpNKYxs5LoxZoU7Pcmdf5kQgEeZTS1X4PF2j2lq3h38YnRK3t53nl4asNxoZIYunaCgx/c6GF0fU9cF0kGkZ+sp5HJViCnCXwfpuEgqGmDhy/bzeLS/1kotTm50jh6AAQS0kJ93u3wJc2YR8tRPfWVsT0bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjfQLJ1u; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjfQLJ1u"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b7823559a5so1458525f8f.0
        for <gfs2@lists.linux.dev>; Tue, 29 Jul 2025 04:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753789034; x=1754393834; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=82PZg+jn8HogNdX1n55QmpWvuIVlwiMmxAyRaB0Qomk=;
        b=CjfQLJ1ulUVfuqPlVlIMtpzqWJCahK4kTj+yBIDWtlZMq5d5RUEjCCdpLWObTji9lp
         A0lJWkICSzjbfmevpcHvmR/owhgPAtYp0neDpx+OwKpp4qmf90yDqB2BQGdHxp6PXwfk
         j/mGlLvRhkw2qRYXgv9CobDT9UMuAU31M9EMq2aziqNrbp2N0bNkCaMVdfeHy/HVpI4L
         Y2VvaM218RmrvpNPH3MH1UPezAC7fBzGLwXKX7EWLrsMoWq+l6QMy5KBmM9+61ffyu/W
         gRE+3XkfN4T7TezWeHW5uNw091nibSjrIZJg9Xk3Ww6xeprCFxlbRyqI/nSrEjzdDbYu
         Syfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753789034; x=1754393834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=82PZg+jn8HogNdX1n55QmpWvuIVlwiMmxAyRaB0Qomk=;
        b=QFmf4LoFhkgmNUfRItydJjKbjIrQViVsMewB7286pd5vvtu5mGd3XP0+jjZUfGyrJK
         unZukaCJQcXI5r/qt5K8X6k8znDVTZ5LOMn6/b1PH775YlqQCuuAcha5MEhNp1hmpehE
         GULOvvIz8lcbxPDZtw5y5+5noN+uAGUsBYvZlZZMWxSWo0aT6xWO7MAx1digwmyohtjZ
         KbKca2Mng/xjbMlCkA/44m8gMWFMd1pvREgTfJc1r4D14nb6OS44Zptp0w/PGLd+Er3G
         6T5NG2a8T/kZGpLuZK3o8EauHrqiuShLFfTEFJG+uafHUNMrDjAXnw+HphTQNys9UC1F
         hCfw==
X-Forwarded-Encrypted: i=1; AJvYcCVDLfovSJkaeoBpGVTwSOWuiC4qh+9rSREz3rj6bL0m/8jUwAj/nWh5KA3KJHQGVO8cTzR1@lists.linux.dev
X-Gm-Message-State: AOJu0YxLlLtAf0PifbQw58WYMdYLEgMQBYXv8+D/2fBfLxBMBAlDJeUf
	7VJaezOEn6LsWFiJw4yUwTvPblM1HifBq8HPGY62LYi305n++q+WIIrK
X-Gm-Gg: ASbGncvXacMYkvR1g6aH5qtMQaAv0ymc8RFi+xVB1yCdk5kYjdLuloqYmnT3RfKlu6u
	GH7mgk+adWXfqF2edNpPdfz5WEB6RIBOvr4VgjEDxaL8seJOAns/Mu35SwHSDCfNbkhEY7r3GDC
	QrYocqTksqHr1LlW81KFa57hHGfOFjB7BFu1WfsRAKWRoJt4GdcKQNotbOcHgJdlBXD7qFc34hg
	u71fO9hUeRv6hlJqfXSqHTJ6i5N6H7eREJCyG59AUcxvaHm6EAFOjsXIYHtAn8wMgEN68obf1x3
	tA2z9WjmCTqdVKHxzumZe+wONB1TCuKqmDhdehvuIT86S9fcWSyfeZV5o4tNAkaS6NA24xLide6
	9MWMeNLwNEzIrxaQlPLGL
X-Google-Smtp-Source: AGHT+IEDa+buDa8F4eLuKsd3bGhw5GsImGtsI1qdvYCFJXRYtIm/Nzj869XsubZtjNbfKnoTVeiz7Q==
X-Received: by 2002:a05:6000:e52:b0:3b7:942c:5452 with SMTP id ffacd0b85a97d-3b7942c565cmr296610f8f.41.1753789033650;
        Tue, 29 Jul 2025 04:37:13 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b7887285e1sm6621429f8f.65.2025.07.29.04.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 04:37:12 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] gfs2: Remove space before newline
Date: Tue, 29 Jul 2025 12:36:38 +0100
Message-ID: <20250729113638.1925201-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is an extraneous space before a newline in a fs_err message.
Remove it

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/gfs2/glock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index b6fd1cb17de7..09af1fe12503 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -733,7 +733,7 @@ __acquires(&gl->gl_lockref.lock)
 		 */
 		if (ret) {
 			if (cmpxchg(&sdp->sd_log_error, 0, ret)) {
-				fs_err(sdp, "Error %d syncing glock \n", ret);
+				fs_err(sdp, "Error %d syncing glock\n", ret);
 				gfs2_dump_glock(NULL, gl, true);
 			}
 			spin_lock(&gl->gl_lockref.lock);
-- 
2.50.0


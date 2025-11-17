Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850CC2BF3DF
	for <gfs2@lists.linux.dev>; Mon, 17 Nov 2025 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763395410; cv=none; b=oNU4xble1SVZbL2qX8DwE0i2yyT99Sti9AW0VRNiZW28fc/R8hmEAt6BsmigtoFMsvSPnN5wzsEwOEN2jSJ3wTmeNOnOwJb+x7+HBrycKbv+wydKErkKARWPfgRkl9cZtvLUimIlekEY4LV3C1NfyD9KbPkA/sfQOTnj/o94sls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763395410; c=relaxed/simple;
	bh=fgJ0oKsC9Wor3hmAIYuRl3neqoNHP68eMnlZ9qGuNDk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=acH5e8/CDnNb0LLu8nnVi8eUnmavbxJDe2YtZ8pAs8jJS+keSswiAaCa7yb6Z/ZEsqJ0l2NAqjHmHJTt9bnSUS/4Qs1x3wihbGaq8n+iC8/prlaLjTqueAwPx2gm6S0xbqeLA4if7Y/zYASFAJWB8QwH4MbVer0mMI4q+fMf3fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=Rb/Hjlgt; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="Rb/Hjlgt"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7b852bb31d9so4973332b3a.0
        for <gfs2@lists.linux.dev>; Mon, 17 Nov 2025 08:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1763395408; x=1764000208; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MzuQNBYv7NArFgr3nI31Kpsin1xb7tC1caQ516ufUgk=;
        b=Rb/HjlgtkkElOhOnZP5m/vkRY+omy12zOmYg7gVJcJGq0OU5otNhGmBgRW9pWYurIH
         V1NPRLFM1OAUL7u3iYcShVpvKgVNskN4mkhP7FxWQVKBO7/Jh6Q68/auv3jwqjhzZnkE
         1sDB1L/GjLD8b6A+ET8pFHfoRhPW6OjtgrNvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763395408; x=1764000208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzuQNBYv7NArFgr3nI31Kpsin1xb7tC1caQ516ufUgk=;
        b=Nxjl5pUKY/6eQGY4+KmHxWcAgfLmQDUkx+WBg1YCyNgC2qp1su9UH7dQ6EcZadGmgG
         acfKbZVRA17DB6h1fdDmyCC3gWM+BsEwEcxmGKu/9XSFl+F6aBSy4Ve/8wy9bDyQEeum
         DNiuHsN4CEJ/f20RrdPTghaRkTvaecw95ZGVSmedcfNWOeeojnSNnQGe/+eK0qDgpey+
         Y4yEFfbtEFVxbZqACh/Zufkgyx10L2O9pTW9IOLWzdczq6CQx2ftLePdgN/vpiMgVw8q
         wDNXm1ERqDY0F03/4v5sE1sVTxal1bMigWqwmw84yPM6xgwan36ZppxhRv5s9t+01l54
         F/vQ==
X-Gm-Message-State: AOJu0YwF7rBu112I91IJgy0LkEC7sizB+MIKwiG2UGFS2xrNlZisjif/
	fvcKS4AtrFNGWeuV/3c1/o7taKc2Rlxk6jXBgXJECt2/RqbKXhP0AQF0fMm72TmDjSI=
X-Gm-Gg: ASbGncucejf4yewSbJ9RROXMcx3v/LajVeXCdUKszJpStzRGJZXM79me7It1AvO1bwZ
	muCfcoZnxtGIUmscf+cQa42ClX6dKAzWLDwlEUIuyXQ1vPJWs2OCxm8V7AL+fn62CMeyMD8+tOr
	wgWNJKV/W+QdeaefI3vEMq+4Gx4g9zFqOEa5ikjhSPSbpNEDG2kCvJSOwqY8XhmBOKqKRMTkPCT
	zAa3WrhXdwQNkAsb+AS4xsRzZlVveM/W1N4KK+jPe7qBOhC+PLpW18p721yUapZyOiftSO0iZOC
	U95eRxDmc3/C/fuylHAzFtTzowFi/lcvdlBqzXR6u2x3kMOspCmtZML3iFEQCUQas0BwoJpg7r/
	4/zweCJ8agY3Ts95fXiNALEnTcPHMBwuSO8wy9r7Xb3ZG6+lesQChZcPGm/7QVBIDXi6FQ/LQY+
	SzvQbtgr4RUGJZDhsxUqO1fV2+2QdJFSM0+dlYWLSjn0AUhA==
X-Google-Smtp-Source: AGHT+IGzL0bWnsq4FmPBdu27yCBxXs0Itdf427kC3rxQ/PwsLSeCU9RA55OJf17K9TLaawcbXmCoXg==
X-Received: by 2002:a05:6a00:3cc8:b0:7a2:8529:259 with SMTP id d2e1a72fcca58-7ba39b918e8mr13828046b3a.9.1763395407352;
        Mon, 17 Nov 2025 08:03:27 -0800 (PST)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.. ([2405:201:31:d869:b34f:a9d1:b2ea:512f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9251c9a50sm13561566b3a.27.2025.11.17.08.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 08:03:26 -0800 (PST)
From: ssrane_b23@ee.vjti.ac.in
X-Google-Original-From: ssranevjti@gmail.com
To: aahringo@redhat.com,
	teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Subject: [PATCH] fs/dlm: use list_add_tail() instead of open-coding list insertion
Date: Mon, 17 Nov 2025 21:33:17 +0530
Message-Id: <20251117160317.127978-1-ssranevjti@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>

Replace the manual list pointer manipulation in add_ordered_member()
with the standard list_add_tail() helper. The original code explicitly
updated ->prev and ->next pointers to insert @newlist before @tmp,
which is exactly what list_add_tail(newlist, tmp) provides.

Using the list macro improves readability, removes a source of
potential pointer bugs, and satisfies the existing FIXME requesting
conversion to the list helpers. No functional change in the ordering
logic for DLM members.

Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
 fs/dlm/member.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/dlm/member.c b/fs/dlm/member.c
index c0f557a80a75..c1b5598997b7 100644
--- a/fs/dlm/member.c
+++ b/fs/dlm/member.c
@@ -299,11 +299,7 @@ static void add_ordered_member(struct dlm_ls *ls, struct dlm_member *new)
 	if (!memb)
 		list_add_tail(newlist, head);
 	else {
-		/* FIXME: can use list macro here */
-		newlist->prev = tmp->prev;
-		newlist->next = tmp;
-		tmp->prev->next = newlist;
-		tmp->prev = newlist;
+		list_add_tail(newlist, tmp);
 	}
 }
 
-- 
2.34.1


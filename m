Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358FF3191A0
	for <gfs2@lists.linux.dev>; Mon, 29 Dec 2025 18:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767031905; cv=none; b=haxKQyxjdwjJ8fzgRqIFhunz8pqZs0aAWvCkTkz+iGa/QPT15XhDrUpyiZW6AlN/jtjWiAzYS1jdNVlv/ulSEQ1IICIKc3AmEW3RFivEuoDuwvmDJ2xxjUrL4kdrZ1SJAohPyomXS4kwOaEmjjBs2nmF44gByiiXfwskxA52k8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767031905; c=relaxed/simple;
	bh=3mxvxrp4wY/3uGpZuzNNr+dKx2oGx7/JyRyOy5FqYfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YEBNNJ1s0GHRWCX4nUfG/szB4OszG25N+O58SC5Ud/XNEyHMYLgXazPltEt+fpToOZyW3nGvLBKHcWqCml9SS6vk/xhhKYTxVNQOMiKDGRqem5lesnlJnS1Z5YKLrClrzvNc0WBc0YboAX7I97jUD7r+632jpbMQbGiP/PpA3Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtuH6lH3; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtuH6lH3"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34c902f6845so13069194a91.2
        for <gfs2@lists.linux.dev>; Mon, 29 Dec 2025 10:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767031903; x=1767636703; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ViypW+a/MB+nsvvfZGHfmVvZeQI/Iv9ibJjlMSavIV0=;
        b=KtuH6lH3VSanzg+kYMWsXOT1rTWEzbXVlz1SbVsv0CtnfMjAmxLEe0EWKpywJ7UOlb
         6FOB4dWWtGsYm9yQd5YFGwGiw80hNXcG+J5IZVZC/EJDnrKV8IhfjGFK5FFFeqVxVPSq
         yBqiL3yjz9cuSpMdyonecSLvd0JR3kQ/S096KXjFZa5UGfCJJTbDXgrF7vbjm/46gpuU
         8RCy7ilC41U3A7GNi9MDEcuKttNucuwP0X8Kvlfy5RmsMyor/jrdAOZlYs3cqXH9pg7w
         FPT9LvbPKyD/u2LVny/n4nJyLkgwnx7pML4YxBhgOQVHvJfSiHXH18Vo5UgHPFv3k7cW
         cLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767031903; x=1767636703;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViypW+a/MB+nsvvfZGHfmVvZeQI/Iv9ibJjlMSavIV0=;
        b=j1QjoP6FhP8jAfKA5jq2nXGp6b4TYUio8kFR0dEgUfkRJLGJkuuIAkz+TAFb2bXk2a
         kP3F94/NZsicxvZ8y27jFAv1jNNHyZzmfnmZDX3Qo6zBuzR0lZoaYve/YXnp6N9m1Orp
         bwNC01W3HVEhQoqTTCejeY0T42oaIwLVd65VD+WT3Z3Sc4xF/1RZc6jaEVj2fl+xiT8Q
         ENmPgNxTyAUmmKfsAsF6/CMyWivFOOOCcMuF57njjZVp91th8GY2S/8HI8aArqCyxpB/
         mvJg03ohmhfLwCGUyhdvULHlUmnINHpeFTwQa7KxQaa4/7uXcNQnr4bH5WNJusZJjOe9
         +Byw==
X-Forwarded-Encrypted: i=1; AJvYcCVcLrOuK3loJ3Uv74JaF/BxT966n+97h8B21HvNaF49wf88VJZdMuj5VcQezfcQOdxSP12c@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0ZjVlc9SCzD9Kmz4Ncygl34eaQ5GjZvXxasui5zTAID2CO/bn
	82UCZJUHUE9zaJ3EzfNgevbkFppTCm+zuxLJ5gVw48V8C8fvVlABnA25
X-Gm-Gg: AY/fxX6I0UTJpyPrgyRvRE85m1j+OcGpUKfDFf39FJdIIWsXAmtkAwwO0tSVtDAeyzI
	UxJ9uMRQMijEK7kZvri8vIqxPrqS9RZzp4D0vNQJWGToBagzfS0S0P+FOru/D1Z/+wpp5eH2him
	1yMcIkzVTB+80KGe64R1gyCCHYK3v4BrG3ZBy5KElC2y1fX9bVa7tcOxr586bNpEpK5BoAumwik
	ZLHintIX250zBQa+rCAOVYzW2VvchaPKvrkUacAaoinktChDjz+tc+MUrmikTbP8qt6o+TQneNS
	WShsq/hnZPJxIQKwnDaYjSJSxO+to+m/Uu3OSD7zU7eQvEIwYjx7gZ9FzI12/MTR/4d6ItJPPWY
	WOn+TVhJ/hN1VR3UrTsmKCoaFKbB7s9JHyJnlSU2gWtOVCPgvWrkGEQnKKjDHW4fSSfGF5nJ1sS
	xL64TZOjX0/BFJTdgbbxY=
X-Google-Smtp-Source: AGHT+IFp7RHj+un7puWHRl+h8lj4aFf3vhZWRP1VkW5p0M/OCRPHRXaSCSd7ytGI3VvKtAwTrRlq2w==
X-Received: by 2002:a17:90b:49:b0:343:5f43:933e with SMTP id 98e67ed59e1d1-34e921afaf8mr23802102a91.19.1767031903383;
        Mon, 29 Dec 2025 10:11:43 -0800 (PST)
Received: from [172.16.80.107] ([210.228.119.9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e769c347asm16353246a91.0.2025.12.29.10.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 10:11:42 -0800 (PST)
From: Ryota Sakamoto <sakamo.ryota@gmail.com>
Date: Tue, 30 Dec 2025 03:08:46 +0900
Subject: [PATCH v2] gfs2: Fix use-after-free in gfs2_fill_super()
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251230-fix-use-after-free-gfs2-v2-1-7b2760be547c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQ6CMBSEr0Le2mdo0UZdeQ/DopQpvER+0iLRk
 N7dygVcfpOZbzaKCIJIt2KjgFWiTGMGfSjI9XbswNJmJl3qs9JVyV7e/Ipg6xcE9gHgzkfNxjj
 fQFeNtRfK6zkgV3fzo87cS1ym8NmPVvVL/ztXxYrhS5xM2xi4670brDyPbhqoTil9AeWwjhq+A
 AAA
X-Change-ID: 20251230-fix-use-after-free-gfs2-66cfbe23baa8
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, gfs2@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 syzbot+4cb0d0336db6bc6930e9@syzkaller.appspotmail.com, 
 stable@vger.kernel.org, Ryota Sakamoto <sakamo.ryota@gmail.com>
X-Mailer: b4 0.14.2

The issue occurs when gfs2_freeze_lock_shared() fails in
gfs2_fill_super(). If !sb_rdonly(sb), threads for the quotad and logd
were started, however, in the error path for gfs2_freeze_lock_shared(),
the threads are not stopped by gfs2_destroy_threads() before jumping to
fail_per_node.

Introduce fail_threads to handle stopping the threads if the threads were
started.

Reported-by: syzbot+4cb0d0336db6bc6930e9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4cb0d0336db6bc6930e9
Fixes: a28dc123fa66 ("gfs2: init system threads before freeze lock")
Cc: stable@vger.kernel.org
Signed-off-by: Ryota Sakamoto <sakamo.ryota@gmail.com>
---
Changes in v2:
- Fix commit message style (imperative mood) as suggested by Markus Elfring.
- Add parentheses to function name in subject as suggested by Markus Elfring.
- Link to v1: https://lore.kernel.org/r/20251230-fix-use-after-free-gfs2-v1-1-ef0e46db6ec9@gmail.com
---
 fs/gfs2/ops_fstype.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index e7a88b717991ae3647c1da039636daef7005a7f0..4b5ac1a7050f1fd34e10be4100a2bc381f49c83d 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1269,21 +1269,23 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	error = gfs2_freeze_lock_shared(sdp);
 	if (error)
-		goto fail_per_node;
+		goto fail_threads;
 
 	if (!sb_rdonly(sb))
 		error = gfs2_make_fs_rw(sdp);
 
 	if (error) {
 		gfs2_freeze_unlock(sdp);
-		gfs2_destroy_threads(sdp);
 		fs_err(sdp, "can't make FS RW: %d\n", error);
-		goto fail_per_node;
+		goto fail_threads;
 	}
 	gfs2_glock_dq_uninit(&mount_gh);
 	gfs2_online_uevent(sdp);
 	return 0;
 
+fail_threads:
+	if (!sb_rdonly(sb))
+		gfs2_destroy_threads(sdp);
 fail_per_node:
 	init_per_node(sdp, UNDO);
 fail_inodes:

---
base-commit: 7839932417dd53bb09eb5a585a7a92781dfd7cb2
change-id: 20251230-fix-use-after-free-gfs2-66cfbe23baa8

Best regards,
-- 
Ryota Sakamoto <sakamo.ryota@gmail.com>


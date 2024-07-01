Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D0D82488
	for <gfs2@lists.linux.dev>; Mon,  1 Jul 2024 21:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719868595; cv=none; b=ApcCBM56Jkp7jYkVw90JLUTv6dEB7x/3IVM5/XfcswpFSISdZj7kwhfAj8Wmi2nLKTOUYJ4P3j8WGH9ttU9SSCYacSnHHro0NBo7P+CyHxPAvKRsxtVvyirtwO6jZpStsMaf37EQgoxWEdGjkZut1JnCFNYQgOotLdeNyAVMlTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719868595; c=relaxed/simple;
	bh=7nMZ2tCrAtpBSjMrAZ7ZJ8ydZg3/kINamfdDl2KGcPM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=I01qK7tKVAS/P6kx/9IHnawixeNlMUuDdofJgCWG9/z6ACTKBhocGwV2Dm9mVWZb4S8xuiW3gxJd6BdD3ZeTcHsrg8oGKgF6jd8cv3Qzi4ldq7L7OHXzsJk3FtdR/UnwK4y6lXn02dtqs8QnWS6oVLwMcMSectau2Mf/ZcyK7z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDJ1y11L; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDJ1y11L"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-36dd56cf5f5so14628855ab.3
        for <gfs2@lists.linux.dev>; Mon, 01 Jul 2024 14:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719868593; x=1720473393; darn=lists.linux.dev;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFX7hMxMhb8ZW+qkz5U4LMK6KRkXqQ2yOHaete5Gdn8=;
        b=XDJ1y11LUlvSVWATPvjDPg/hrx00TP3/tj4yhpNeEBTKxN1BY8H2JG0vdLHtyN55ze
         KQkaUF7YgOJewRfE6gjpdzrZjDwrHwU2e42TDaYYATgik4oklAA8rhfZAn5tE29cso23
         EMtvZe7c9ZolEEtrPZmvyQvKBkug8+J/ciSDt738G8gwWJ9B40Wpg3JoH/jOwd5MC1UC
         01q2sKx+sF1It1nop6oDtwcu4qCduQBV0IW9L8jLE3SNayjjeirBf2Ro/B/FZeMTPin/
         b3EzHeuMfcQR7BeIcBFI4d2pKmHnsuZPI3DOqXKakPDR0z8xD6E713G248x3v5qORVWR
         sNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719868593; x=1720473393;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mFX7hMxMhb8ZW+qkz5U4LMK6KRkXqQ2yOHaete5Gdn8=;
        b=f4WZgm7peHlujGEcXCwQk1ZO6bIrgFYoJeLLq1+jR/sg4YIOgWRWLO2feWgwWiZJZ9
         NMMiRLlL665Z5kuqDxW9UJi3oYb3YNaF8Lo3o9kjU+neeIkS2ZVZ+a6NpJd/B/KN7AWf
         yt0qfdnS552HFC/haE0tEdngPJIQbH4bWilRKBL0Bbvgj16tcDCUVvxkFx5v6yMW3FLY
         PvhRxJYnl9/6kPa2ImoL4GH9TSQHrPLpGLw7Uy3DNv+ox3MQ9hAPVTHXuWamhA7P5qu5
         iXBgXJHnTuhA0jY0U2xoCyyKLnPcYxIlV3Dm9m0OY7n0VN7fZlECsr8KlSkc9PXJ8cv1
         UGfA==
X-Forwarded-Encrypted: i=1; AJvYcCWPqhUWq2t9LoXxQln+5OczBShL3FCrNkRZbmWCUxxLg5RMehRTM7KeCwRaIIbvUmVzf9kQA213z/3tIRkF+3uk0EmBjg==
X-Gm-Message-State: AOJu0YwxyXUX4yEAHfPESVqtJr65VX86VXL37jINLAI3tSyoVieaxhIG
	qrkaTkas3prGH1Ri8p3exZJCXzhHnjhCiINqfAsCie6G/OdCi82itK62TEQk
X-Google-Smtp-Source: AGHT+IGIoxEdYNhr7j7xixxldN0KNtT+OAeuPX7bGKBYu5RX66KVvINc1UE60DOZnUsYKXcNfNswZw==
X-Received: by 2002:a05:6e02:1d8d:b0:375:c443:9883 with SMTP id e9e14a558f8ab-37cd2bedf81mr81683095ab.21.1719868592894;
        Mon, 01 Jul 2024 14:16:32 -0700 (PDT)
Received: from [172.26.252.3] (c-75-71-174-102.hsd1.co.comcast.net. [75.71.174.102])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37ae2586a3csm20319535ab.70.2024.07.01.14.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 14:16:32 -0700 (PDT)
Message-ID: <58396eb8-145c-4f40-8387-efdf45c8b9db@gmail.com>
Date: Mon, 1 Jul 2024 15:16:31 -0600
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: rpeterso@redhat.com, agruenba@redhat.com
Cc: stable@vger.kernel.org, gfs2@lists.linux.dev
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [PATCH v2 6.1.y] gfs2: Fix slab-use-after-free in gfs2_qd_dealloc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[ Upstream commit bdcb8aa434c6d36b5c215d02a9ef07551be25a37 ]

In gfs2_put_super(), whether withdrawn or not, the quota should
be cleaned up by gfs2_quota_cleanup().

Otherwise, struct gfs2_sbd will be freed before gfs2_qd_dealloc (rcu
callback) has run for all gfs2_quota_data objects, resulting in
use-after-free.

Also, gfs2_destroy_threads() and gfs2_quota_cleanup() is already called
by gfs2_make_fs_ro(), so in gfs2_put_super(), after calling
gfs2_make_fs_ro(), there is no need to call them again.

Backport notes:
The origin of a cherry-pick conflict is the (relevant) code block added in
commit f66af88e3321 ("gfs2: Stop using gfs2_make_fs_ro for withdraw")

There are no references to gfs2_withdrawn() nor gfs2_destroy_threads() in
gfs2_put_super(), so simply call gfs2_quota_cleanup() in a new else block
as bdcb8aa434c6 achieves.

Use else braces for consistency with the if block.

Reported-by: syzbot+29c47e9e51895928698c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=29c47e9e51895928698c
Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
v1 -> v2:
Remove invalid tag
Add upstream commit's tags
Use current mailing list for GFS2
Use branch fragment instead of Git tag in subject
Differentiate upstream commit body and backport notes
Make body more imperative

Sponsor: 21SoftWare LLC
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 302d1e43d701..6107cd680176 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -591,6 +591,8 @@ static void gfs2_put_super(struct super_block *sb)
 
 	if (!sb_rdonly(sb)) {
 		gfs2_make_fs_ro(sdp);
+	} else {
+		gfs2_quota_cleanup(sdp);
 	}
 	WARN_ON(gfs2_withdrawing(sdp));
 

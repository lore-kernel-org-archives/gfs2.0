Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629013;
	b=SMeM0rB6I7eNOCcOvmP9RLUGSqz/pkbwYLjHouIihSnISiSw+8oQFGPBtfkIEOKb+PVx
	 EIXbDSN0k4Dy+EQYk3ubJ+wCQTcKnn2HlXnMUd3MDAf1y43trTQxwi7YTbSLLYwXHrd9B
	 rSdtNhMEEUavenFhiBv33lRq+mKXIhCSm0jFsQiTjc1rXxpBxGZrG8FC0/BW4ewxZjj3c
	 HrzIpmd8mzeiFK72kYfEcxAsRsp1JwQPQ2dUaWhM2muwAfmKldzLnQaBXHgAAhLIk/5Vs
	 BWrCf+octx1Azz0DhbAnZBUxJu0V6JBptD/u/WMc1R9D6H1YE5U8ZnMIahLO+iSsUHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629013;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=iVdPOcw1bs6hdzSnoCmlTQe9oM25xdIMmK+wXSHKTBo=;
	b=aObSlkJmUy+NKAwXQ03yKIc4b03j8pApvi6Z0aDnGzOM7LQ8sH0ZqlO7FG67iG09Sydi
	 q8MQB7OrUrGTT7nxPkez5IyEFuCLlyRWgvhC26hXvBOG+noozkUCu+kPNEKYuusyqTT67
	 5c2Kt+2vXE5OMR4LGHDOIOs9S5cQtpMFS1FIMSAudqEnKppoXhmVsAg/hOVTzIlM7fJIg
	 WT2L4xDv8WbAK9gMbZm+LeKnPsr2lIwmmWHgVxxGP75axEqeLouKITnGMQ1bU+hYHatSg
	 C4B6xrPALtRjDRCdQZxekieEX4S6aBYmg/EZ00hoM3Ew4rBTAasj6St9EPXKgNyhWjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=hNDzuKQI;
	arc=none smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9870606A323
	for <gfs2@lists.linux.dev>; Wed, 25 Nov 2026 17:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9870606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=hNDzuKQI
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b335eeb340so53707957b3.0
        for <gfs2@lists.linux.dev>; Wed, 25 Nov 2026 09:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1795629012; x=1796233812; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iVdPOcw1bs6hdzSnoCmlTQe9oM25xdIMmK+wXSHKTBo=;
        b=hNDzuKQIVp/z/iTsmlPH9HMapl7NKJPmoGW7LAGleiQKZ67NmanhnqgzleENR3DXSQ
         7aJGn87+o42nchxWCh018wt0IXOci0tTKdX/p3E8tUsLl8LQHByloNlzGxw7VO+xPUQQ
         uBzDGHnyxiSQiKlJ2HQFjTApvpZJm4/g0mzJ+TUVdFPNx00I86rW0U/yd0JleMBdxoZB
         uE4MKcq0YmVBdumv6BS56F4kHizgSjyV1X5jhpmTS4njBjWKIkNuUu5MWbz1Jn2uCIJq
         Pt843yXnAfprB2j+uddLpNww5xl0EFmjT8AHWrWgsjd4+5nAFbYvCe7/oKlzUcvMAVei
         Jqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795629012; x=1796233812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iVdPOcw1bs6hdzSnoCmlTQe9oM25xdIMmK+wXSHKTBo=;
        b=OkuMMluzHXn15WIIqycJByUOUQ6COqNxj6s/AklCJGoNnQLgCYKs8MNuzZTbhC1BjS
         7dGyuPJcNoSKQRlqFcc/rbQWfIeHbwuxG40BOqGN7doLSsRwY9bdLZjq0CRrGKZiVaZy
         LurVSBMypHKVT3cknaRBaFVSHJj1c7tcUT0qtPoAVfOzUDonr1IfrSsTVquHK1QKkCYU
         9YcqVZqndBHTsnp6piT8LOoNYTcxkpQKAJyAFP648Faur1QIgbdFJIcwc47xBXsQRFig
         w/gniiloRFfUw6ddu1tE9G7mBzpsda/3e2vAf3qUjuUBKku2JPXSokNDoW6vtX7K86lk
         rGPg==
X-Gm-Message-State: APuU4Z8QFmpA0XNtitcb5VByX6lQViUMX+X0RlDYTEl822TbRhJsLerb
	oxEip1Y9kSGX/pZudxf6GXnT5rGE9DxjDGv8Iyh1RcKLlbI1m0Wt0omB5t87prHEcg==
X-Gm-Gg: AZFdTZcvechPayIA2XnEvcGkHMub7LodVOus9bstR2Qoz82NVQuxLPgemdRZ14cPKj9
	UtrsmX9X2GS85+kfLwYSmv+iRdaHWBiPBuA/EG99R8I9cDwnJsjsAR/cyxPRyw7e7GA+9uz9r3N
	3XnAfdMcGoiY1hFE+oO5wagW4u+mTyQYl7iVcPKbN3E+zFrSAZkSe9pZNtUIq+NhXEFvEqRIlXD
	YR9uSmX3Me4Sb9qAF/CljcNIZfyIl3wexufHEzUWorhtcM78WcuE8sA4kcArbze9Elu1cE8KRbl
	PsZeljdV3vi7MCRTCoLiL80A35UZyC8DZIxbwIeZuCaTX5D85JYRFJc3aeIxu3Y+1jGaVs3DSsy
	Itv5LLCPM6owax28LdlHZrxAqxXDD6GWFFABw3ShvSft6CA5L8rHPQLBHkNXsDKatbpj2UPir5A
	7k/GRM4XsssPLoXSTMybqRbbNYGn8jp2fL1lHvpdR3AeTv6TVO6lBTa3ZOGEwEzcMFpM3tRxO8D
	MqmFivhvy8ps60DNZAZRr7LF2zSPkXjP60xXGa8CY1AXosNQbHMcGOpJzRXLkdbYPQBhwqaVbnS
	R8VQwsoXGR5gbb2mFaJcBlgp2k2kasbjG3EXgAuWYL4NyttZo+w=
X-Received: by 2002:a05:690c:4448:b0:8b2:e4cf:c399 with SMTP id 00721157ae682-8b520435b9emr76177847b3.18.1795629011607;
        Wed, 25 Nov 2026 09:50:11 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52034f7absm75322567b3.41.2026.11.25.09.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 09:50:11 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] gfs2: restart rename when a signal interrupts the glock wait
Date: Wed, 25 Nov 2026 12:50:07 -0500
Message-ID: <20261125175007.3659558-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
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

Commit 11d763f0b0af ("gfs2: Retries missing in gfs2_{rename,exchange}")
made gfs2_glock_async_wait() interruptible. It returns -EINTR when a
signal is pending.

However, -EINTR goes back to user space as it is, and the system call
is not restarted. As of now, rename() and renameat2() on gfs2 fail
with EINTR when a signal arrives while they wait for a glock, also
when the signal only stops and continues the process.

The issue can be reproduced with:

    mkfs.gfs2 -O -p lock_nolock -j 1 /dev/vda
    mount /dev/vda /mnt
    mkdir /mnt/a /mnt/b
    for i in $(seq 12000); do echo > /mnt/a/$i; done
    umount /mnt; mount /dev/vda /mnt
    mv /mnt/a/* /mnt/b/ &
    while kill -STOP $!; do kill -CONT $!; sleep 0.005; done

Before commit 11d763f0b0af ("gfs2: Retries missing in
gfs2_{rename,exchange}"), mv moves all 12000 files.

After that commit, the result for 783 of the files is:

    mv: cannot move '/mnt/a/10' to '/mnt/b/10': Interrupted system call

With this patch, mv moves all 12000 files again.

This patch will return -ERESTARTSYS instead, as gfs2_statfs_slow()
does for its glock wait, so that the system call is restarted.

Fixes: 11d763f0b0af ("gfs2: Retries missing in gfs2_{rename,exchange}")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
I found this while comparing the behavior of different kernel versions.
I used an LLM to analyze the problem and to draft the patch and this
message, and I analyzed the result myself.

Since commit a098f26d3b80 ("gfs2: Get rid of sd_async_glock_wait"),
signals are only checked while a glock is still pending, so fewer
renames fail: 60 of the 12000 files on gfs2 for-next. The stable trees
that have commit 11d763f0b0af do not have that one, so the change is a
single line there.

Application impact (Ubuntu 26.04 user space): rsync 3.4.1 updates
12000 small files on gfs2 while its processes are stopped and
continued every 5 ms (kill -TSTP / -CONT). On v6.19, rsync exits with
0. On v7.0, it exits with 23 after 267 "rename ... Interrupted system
call" errors, and those files keep their old content.

Tested on gfs2 for-next (9aa0082cf969) with lock_nolock, KASAN and
lockdep: rename, RENAME_EXCHANGE and directory renames no longer fail
under a SA_RESTART handler or under stop / continue. A handler without
SA_RESTART still gets EINTR.

 fs/gfs2/glock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index aa11168255e9..05e6b0f6ccc7 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1318,7 +1318,7 @@ int gfs2_glock_async_wait(unsigned int num_gh, struct gfs2_holder *ghs,
 		if (!glocks_pending(num_gh, ghs))
 			break;
 		if (signal_pending(current)) {
-			ret = -EINTR;
+			ret = -ERESTARTSYS;
 			break;
 		}
 		ret = schedule_timeout(ret);
@@ -1329,7 +1329,7 @@ int gfs2_glock_async_wait(unsigned int num_gh, struct gfs2_holder *ghs,
 			break;
 		}
 		if (signal_pending(current)) {
-			ret = -EINTR;
+			ret = -ERESTARTSYS;
 			break;
 		}
 	}
@@ -1363,7 +1363,7 @@ int gfs2_glock_async_wait(unsigned int num_gh, struct gfs2_holder *ghs,
 	return ret;
 
 interrupted:
-	ret = -EINTR;
+	ret = -ERESTARTSYS;
 	goto out;
 }
 

base-commit: 9aa0082cf969a9973ec6554586753c53211ab799
-- 
2.53.0


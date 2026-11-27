Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795772684;
	b=e5PuC09n52ef7RisA0GhO8+n5/Zt1AwIq50sx/WVy05/BtrKvFbdJndVrLgPdVHvwmLq
	 AGzystkQSewc29HmvhZREu2ULCPtZ3tavV89MOjadQHbMgADUZH4O4Xd8mupzyjKCtxEi
	 m0XTzM+k1agZBNOU/3i/qtktIdI1zxHvj6M/s28YuSiC6/qwb8G2HdiaRS+Q5aX8OlSR6
	 hAtSdFVwaRmE58hAutxNMLURUJw5eErQ7BTu7U7f5bRpDsTpy0J5fAdX1UCMfAC6Vp4Kv
	 VGE2s4B1B5wr+IGyQ7Aw943do2vdpYPtMkGNi54qJJF6gadUk589k+acdw1afOEUsAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795772684;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2AXdsYqzJ/4Ge1n4R0RB4I2MudVnosImi/2iRiqd2Lc=;
	b=nQwIsE9Y5/uBJoIj6sOAmxI4j3WuO0WzoJIRmTs90QtKHsXg6wfP2OMXdObLTonkzWLP
	 oi/rzhXRb5+BiCeACVpjAjGr3KEqv9Qe4vm92xrmnWpcp0vCx84BbUGzi65yxCcDMMvSL
	 vUatrMdKJiWt4to9PjY3VyKkWvr+fPxIH3JCPuO+KlcROx4O/TdJKN/h2gzOotBIO0v4C
	 nFTv0kRncXz5B4SvjSHxGU2Z7FmRrgL7WbfyDPUwyplKtKsnVH7FlbWtbZheQcTXq2sFa
	 rhFKQ84C5qRG9Nce2teZYLQW63UL5k3jmZnfJAW7lsnHOaC+kNlB1ekeZak71Myos/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=GGfAq59v;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B48606A321
	for <gfs2@lists.linux.dev>; Fri, 27 Nov 2026 09:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32B48606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=GGfAq59v
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-53634b8328eso74295361cf.0
        for <gfs2@lists.linux.dev>; Fri, 27 Nov 2026 01:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1795772683; x=1796377483; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2AXdsYqzJ/4Ge1n4R0RB4I2MudVnosImi/2iRiqd2Lc=;
        b=GGfAq59v/GaMKadQPUxNB5QEpQ/ybetrxZBbgiieo6byPzhQWxO00BYZvmFoKID8kX
         fcwTxqVL4i5TuxBysCl3PsT2g8tF44NwfANEeO2UOxQVaEGQoqOBRxWyuVAWwfU+inQm
         v61q5yz+4FHvsmisAIrGG8mmUziw31ns9eKsHbATjnKUi6Oh/l0ZlQyv/PoJOGE6y9YA
         7NMBfzAdZ68lufzGjqEdqRGQhiYK5br4H1LsiNh+2kvroDlN7LUnL5B8EPeAyK3QKiAY
         gr/3bNM1azSi0zRsob0uFKK0N5x34UTKuesQw7bZ2Bu8nGv3m8S5S4W7z6AbKLiYprA6
         ptVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795772683; x=1796377483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2AXdsYqzJ/4Ge1n4R0RB4I2MudVnosImi/2iRiqd2Lc=;
        b=I8klSdbz/jBOiPt8SWyH9tKzhs58gOy9tAVyhDKS4dAlrwFfAJo1fy2CySxwvguzQY
         O0hfNNz/GyXYR9xE1pJdO7Hi4O2f2Xn0uRuRRvYE4qm6ZaWEHhI9APxY7lUnhji+5mVX
         f9+Onk154BzzVzSfeOODLUDj0K8t7LisFFV9SsK3mJjB8upBzCzkl/EOV5/DDsm+2uH8
         2q/x5J6mqXtlv/LO5O2k3sUuOZHytc27JLPTqmIX62GvcNJbnmTrsrif8plkWLgIyFPH
         lwnGC0Ee2QwU2XxR50Q8dIS92F7omx1OsHa8RFW9PSh41x1U89sKYoXARvnSRuaipNJP
         B7Ww==
X-Gm-Message-State: APuU4Z9kJdVzq9okpVx+D5c5K8def9lRLKwuJfVCHyvg9wvCIlU2jWGY
	qsrEvVYdjSF/b1zsCOFEns1P4vd8V8omLSJcCAhu0ekVd8SJmgayp+Jm4INW67YU2w==
X-Gm-Gg: AZFdTZc1ITGuBv7DpZG6OVgx4QAXx8+6uXA8ta1AViV9ug8PII1m0emaRIja0ffKdxR
	0jU6ox7yaG3qOsXqXY8IICTdhnNckicCrxyq/iPuc+GS1VZ6XocwX38YfDMb/4zLYCIIkPHwOmt
	sw0Lmlq/fvVHdG/Szrby5NgioZG4pD9K6aDV+PIA3WOKXo561vLJclzva06EgqN9AajfUhfmVs3
	bgppT/GDIdBHPEtxdSfwhpcr7vlhwmlDkhqKUu0mspl7ZsfAC76mOJWOP9K3sBxiVGM3fMwHnA/
	bqR0bOZkioXhVBsCsq9hqvwIPJfe+2jqQxHQvJ9xu6ktKXBuHUVl46j4Lc8eP+HeVDdo8itts0/
	VIjlnfIh2sCgbIxTzyky+h6SUSu084sVjm+VboBW5vV26IsLHeg+iSOtDwo27xK0aeQc33ByU4H
	9IpA02A39eWg7AyPhGe/iw5RcLZS6fOx7bLZ8L74ZA0HUnNec9Sc6/g6k3dGr7JZE/t+wCsm7Um
	VHla+jxV7hux1HhmUHztl0o5e+6XnVBCgDH42IHdm5woBYX5uZggs6yDk1/Fb5tUFwL904KqKJN
	syIKA7KIK+EPQRolTEKjoo5YsCcI4WqOis4YM1x94/WigSCsDwY=
X-Received: by 2002:a05:622a:120c:b0:535:a5f9:752e with SMTP id d75a77b69052e-55d76aed568mr440022791cf.77.1795772683004;
        Fri, 27 Nov 2026 01:44:43 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7889f8absm200058121cf.27.2026.11.27.01.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 01:44:42 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] gfs2: make the glock wait in rename killable
Date: Fri, 27 Nov 2026 04:44:27 -0500
Message-ID: <20261127094427.1370216-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125185332.2549812-1-agruenba@redhat.com>
References: <20261125185332.2549812-1-agruenba@redhat.com>
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

Make the wait killable instead, so that only a fatal signal ends it.

With this change, mv moves all 12000 files again.

Fixes: 11d763f0b0af ("gfs2: Retries missing in gfs2_{rename,exchange}")
Cc: stable@vger.kernel.org
Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
I found this while comparing the behavior of different kernel versions.
I used an LLM to analyze the problem and to draft the patch and this
message, and I analyzed the result myself.

v2: make the wait killable, as Andreas suggested, instead of returning
-ERESTARTSYS.
v1: https://lore.kernel.org/all/20261125175007.3659558-1-hengyul@cs.unc.edu/

Tested on gfs2 for-next with KASAN and lockdep: no rename fails under
signal handlers or stop / continue, SIGKILL still ends a waiting
rename, and fsck.gfs2 is clean.

 fs/gfs2/glock.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 21b71fe286b7..5068b680606c 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1298,8 +1298,8 @@ int gfs2_glock_async_wait(unsigned int num_gh, struct gfs2_holder *ghs,
 		max_shift = BITS_PER_LONG - 2 - __fls(GL_GLOCK_HOLD_INCR);
 		incr = min(GL_GLOCK_HOLD_INCR << min(retries - 1, max_shift),
 			   10 * HZ - GL_GLOCK_MIN_HOLD);
-		schedule_timeout_interruptible(get_random_long() % (incr / 3));
-		if (signal_pending(current))
+		schedule_timeout_killable(get_random_long() % (incr / 3));
+		if (fatal_signal_pending(current))
 			goto interrupted;
 		timeout += (incr / 3) + get_random_long() % (incr / 3);
 	}
@@ -1311,10 +1311,10 @@ int gfs2_glock_async_wait(unsigned int num_gh, struct gfs2_holder *ghs,
 	}
 	for (;;) {
 		for (i = 0; i < num_gh; i++)
-			prepare_to_wait(waitq[i], wait + i, TASK_INTERRUPTIBLE);
+			prepare_to_wait(waitq[i], wait + i, TASK_KILLABLE);
 		if (!glocks_pending(num_gh, ghs))
 			break;
-		if (signal_pending(current)) {
+		if (fatal_signal_pending(current)) {
 			ret = -EINTR;
 			break;
 		}
@@ -1325,10 +1325,6 @@ int gfs2_glock_async_wait(unsigned int num_gh, struct gfs2_holder *ghs,
 			ret = -ESTALE; /* request timed out. */
 			break;
 		}
-		if (signal_pending(current)) {
-			ret = -EINTR;
-			break;
-		}
 	}
 	for (i = 0; i < num_gh; i++)
 		finish_wait(waitq[i], wait + i);

base-commit: a009501c151f7d19519312ccfa2070d30d62b249
-- 
2.53.0


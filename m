Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795632823;
	b=ih9WOfrbgtSlG8QHRJUCngTgMc9oiGxVLah/LE2l2x2c3/L0HZxbXE7Yx+m1iDu4AF3O
	 /uWWNe9uEqLHnncbYS47CJif3YJ9GnhePYCytwVRqBCNTWuIaAxFjPrex9ZeO4A1TNJo6
	 y24l6d16uw9y3fWGM5cWjlXF0Tv5E4BR97NpFFnGyx6eRbbRF7Ma+EENON8B6PzDSis6P
	 YJPc7CZRgtqdwNs3GzpKQE5/raorwLjyIEdWOq/u8Mze0MbeTCJr2oZfIMO26yQ6Uf/cV
	 i/JI4WZaY6svZAHjrkYiylwO+AjD/BHh04RZDrE3zRgbzhpZBrX+1+kN00eLQwr8zJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795632823;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=b0tmLXZBY761qj9gCg3aT/iWAmSW/9QbUZuBe8w4Uhw=;
	b=XgncoJApx8oBMbSb74BxZueS/vCbrzE+CuVMTknxNMuaxFNCSPnHXNPchVc0efDUZixA
	 dibSbypGIJQXkh/NhbDOHtb3dfgmGX97iwuC8RQHGbNb6WfozSVGaZX2aUT+wJHEgcuRO
	 zAW0xaoGdSBX+LB4OomJxivjTYI3XgXlJk51Ka4RTQLbSs3OdxmlOD0tsEFbQi53X6YG4
	 2xEinFjWgr5MsQmTPiMSWYiTA5ORRSaJqweAurnSdmKlGiP3lQu8+k3O6DCHPlkBrehcq
	 y1lHuh8a5pn/QHdC2ViBfB5sysJ6V595n521/hawtAT+55eeoUskeI5izIh53jRteQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HIRJj5q9;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87252606A31E
	for <gfs2@lists.linux.dev>; Wed, 25 Nov 2026 18:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87252606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HIRJj5q9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795632821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b0tmLXZBY761qj9gCg3aT/iWAmSW/9QbUZuBe8w4Uhw=;
	b=HIRJj5q9lMqZ1a4tCC1F0UmXuWh5xL4hu7czcdaWvepn7YOu/8G2froWgIEsWkxo3CAmz7
	nsMyOCEhffajhNWwGf79evHWx5IF09jNnPek0qLGMcmzwP3LbfKFO+AC7dVkCPoff/rJgn
	zfjoKCqkzv0Ji23Tj8mh2wfsCaa7+EI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-XidFufOUOEWYRGWrk-af-w-1; Wed,
 25 Nov 2026 18:53:38 +0000
X-MC-Unique: XidFufOUOEWYRGWrk-af-w-1
X-Mimecast-MFC-AGG-ID: XidFufOUOEWYRGWrk-af-w_1795632816
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C9D061802140;
	Wed, 25 Nov 2026 18:53:35 +0000 (UTC)
Received: from agruenba-thinkpadx1carbongen9.rmtat.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1CD9C41F;
	Wed, 25 Nov 2026 18:53:33 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] gfs2: restart rename when a signal interrupts the glock wait
Date: Wed, 25 Nov 2026 19:53:29 +0100
Message-ID: <20261125185332.2549812-1-agruenba@redhat.com>
In-Reply-To: <20261125175007.3659558-1-hengyul@cs.unc.edu>
References: <20261125175007.3659558-1-hengyul@cs.unc.edu>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: TWITdT_9RdrhkTyUlX_r59ghbHf1HG-5xfTyD7sRCa0_1795632816
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

On Wed, 25 Nov 2026 at 18:50, Hengyu Liang <hengyul@cs.unc.edu> wrote:
> Commit 11d763f0b0af ("gfs2: Retries missing in gfs2_{rename,exchange}")
> made gfs2_glock_async_wait() interruptible. It returns -EINTR when a
> signal is pending.
>
> However, -EINTR goes back to user space as it is, and the system call
> is not restarted. As of now, rename() and renameat2() on gfs2 fail
> with EINTR when a signal arrives while they wait for a glock, also
> when the signal only stops and continues the process.

This is indeed undesirable.

> The issue can be reproduced with:
>
>     mkfs.gfs2 -O -p lock_nolock -j 1 /dev/vda
>     mount /dev/vda /mnt
>     mkdir /mnt/a /mnt/b
>     for i in $(seq 12000); do echo > /mnt/a/$i; done
>     umount /mnt; mount /dev/vda /mnt
>     mv /mnt/a/* /mnt/b/ &
>     while kill -STOP $!; do kill -CONT $!; sleep 0.005; done
>
> Before commit 11d763f0b0af ("gfs2: Retries missing in
> gfs2_{rename,exchange}"), mv moves all 12000 files.
>
> After that commit, the result for 783 of the files is:
>
>     mv: cannot move '/mnt/a/10' to '/mnt/b/10': Interrupted system call
>
> With this patch, mv moves all 12000 files again.
>
> This patch will return -ERESTARTSYS instead, as gfs2_statfs_slow()
> does for its glock wait, so that the system call is restarted.

Why not make gfs2_glock_async_wait() non-interruptible instead?
Something like the below should work.

Thanks,
Andreas

---
 fs/gfs2/glock.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index d22a088c66cd..3a49699ba9cb 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1284,9 +1284,9 @@ int gfs2_glock_async_wait(unsigned int num_gh, struct gfs2_holder *ghs,
 		max_shift = BITS_PER_LONG - 2 - __fls(GL_GLOCK_HOLD_INCR);
 		incr = min(GL_GLOCK_HOLD_INCR << min(retries - 1, max_shift),
 			   10 * HZ - GL_GLOCK_MIN_HOLD);
-		schedule_timeout_interruptible(get_random_long() % (incr / 3));
-		if (signal_pending(current))
-			goto interrupted;
+		schedule_timeout_killable(get_random_long() % (incr / 3));
+		if (fatal_signal_pending(current))
+			return -EINTR;
 		timeout += (incr / 3) + get_random_long() % (incr / 3);
 	}
 
@@ -1300,21 +1300,17 @@ int gfs2_glock_async_wait(unsigned int num_gh, struct gfs2_holder *ghs,
 			prepare_to_wait(waitq[i], wait + i, TASK_INTERRUPTIBLE);
 		if (!glocks_pending(num_gh, ghs))
 			break;
-		if (signal_pending(current)) {
+		ret = schedule_timeout_killable(ret);
+		if (fatal_signal_pending(current)) {
 			ret = -EINTR;
 			break;
 		}
-		ret = schedule_timeout(ret);
 		if (!glocks_pending(num_gh, ghs))
 			break;
 		if (!ret) {
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
@@ -1344,10 +1340,6 @@ int gfs2_glock_async_wait(unsigned int num_gh, struct gfs2_holder *ghs,
 		}
 	}
 	return ret;
-
-interrupted:
-	ret = -EINTR;
-	goto out;
 }
 
 /**

base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
-- 
2.56.1


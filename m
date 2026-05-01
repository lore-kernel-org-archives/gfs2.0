Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03E735A38C
	for <gfs2@lists.linux.dev>; Fri,  1 May 2026 11:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777633329; cv=none; b=LbawwPYA+NRpwSo76OpHbKRtgCxbaxbhpT7QQm0kVmHmRPbIbw9emKREquwsJ5JYLzL5QFgB0uPvQ3spUR72Ttf9hyFMjfvf+lE7YAv6boZnJIkB3zkVBTD5/apKImigfCS5xNdr/KcNATlK5cnYMdFy4QWnbWMtWlJpCcFFTyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777633329; c=relaxed/simple;
	bh=i9aHcnR3UfI48HD1OS5y0W5JFsKaLanCbnnKA7TqlGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mrs1dlNUgh8oao5qZOoRgTDoc0pSaLqKS+CNOEXf6Ui23z1MuU8ZyicackKhI2HkUcKN1iGzPUxmT5+RJ63GwjA9i8Ft1FjHf4LVi7+0r1e5XCM0vcKXGT7k/gP4Du3g9CTyEXANLitxPU2tyIm6ZedgF4erpf/qOdVogHM3a4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxxJIbuS; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxxJIbuS"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d7645adbdso1230808f8f.1
        for <gfs2@lists.linux.dev>; Fri, 01 May 2026 04:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777633325; x=1778238125; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vqZidDCn5y4gCrfLbOWYKSzW8HkTpyANFAvcSFhaUEo=;
        b=XxxJIbuSB2gC0rvHA5CHsacVhCgYpAQlq2icNVmzvYBXGrw/GogUGjDeghDnNC0Z4c
         aJ6vbHJMTdQns96uUncSo1jstTwTlLgOju+U0NQjgUvdXgdvXZ9DihRLLKycCZpC6mtB
         31V7Y/mHzmRWIDpQx+rngze4ufGxG/5sObyzsMvuoFrMDEUe8OFR7CaM7gkX4KmKDlZl
         u+DykJ8g43HF/LtwOIqwZeBn1qBSRBy2KVfVOXwt3NVVy8Nn33bubWTmOF6k+Eetsecc
         9IZrPQ5lJubBRgI8ksEgDDu9q+H6P6+OLvtR79ImqILWY2/9JaDSnizjWvWZoYeB3vQg
         +PRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777633325; x=1778238125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqZidDCn5y4gCrfLbOWYKSzW8HkTpyANFAvcSFhaUEo=;
        b=jhxGT0K9t0IbpNc5TYMslFp5W72yAr9WahoBZ+StQEYP2BhQtTEO0TLTrzM1ceFW7N
         1q+bys6fLnDlh4/LaOs5HaTgqqNVluWO19lp3cb4q6gJaQWjK8xkAYKmIxnn3w+9wvXt
         GVkmcTbKtqr/Tjn/a7HZSBVf04a7E8gxSB+fNdBidCYPUnUn51HCKVvPksy3VgfwMpf7
         N556yX77WP1HAvTGmB3RQbJsYgPMW+rjR3PRF4pD8GqySB0RJ34YCrbmQZiC4Q3Mbhhv
         qisxwzAwf1bFTlZMsmx0Ng9qJHJ8vl8jQ08zRqQuMQivjAZjvAxHlHoKRiFvBNzWGwHm
         q2BA==
X-Gm-Message-State: AOJu0Yz0bFGbDPvVLfQhm+qBezZja68hLg3iyS1mnvDgPlmCy1AdP5+P
	Rsd4LZgrlEZSV/DZ8Q11Nj+GqabedbeBDowT0zuUiKjeNLvqztIe/2QYvL0n
X-Gm-Gg: AeBDieuM50t/O15N31oeKn5R58bAAhCK73NVwwm+tZvtQS6xN7D5wje6jyRMqtaVPDL
	d+ztAw5/8SYlqv/5oullBnxlIWmoKHqRTAC20X6j+/wEH6rls2gQ2LEnT8fXZMpvAzwMvKKBvFi
	gpjHHajLU1xja8TCAGaeSBKw2tFXpOzHlFefsHJ1NsJ5bHRp3BcQQMi7/snaV1V/hoQpGcU59UW
	ZXvh1j1BM8VLMmM11RoaP/7T2JIurvnoReKpzbU1m4S2k7c8q3ETpH+i1MHowe+hGczLI+FD8LD
	KhD1vSkA+FPmlGQDgvpSYIkotoIUjKVwctMcsq0mCZEOZr85G2rmNSbCx5hiaLstawE7ge8lmAP
	qypOakMAdQftr7cDcuyact2CCBq6xIFONThaRRbsSsUtO9g2Mh1HC0i5cLa7cE5Q7LH1mg3sZnF
	rutf8=
X-Received: by 2002:a05:600c:4fc5:b0:488:a723:ea53 with SMTP id 5b1f17b1804b1-48a83d77ec9mr115852605e9.7.1777633324796;
        Fri, 01 May 2026 04:02:04 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fede418sm13928485e9.6.2026.05.01.04.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 04:02:04 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	syzbot+42a37bf8045847d8f9d2@syzkaller.appspotmail.com
Subject: [PATCH] gfs2: fix use-after-free in gfs2_qd_dealloc
Date: Fri,  1 May 2026 11:02:03 +0000
Message-ID: <20260501110203.18771-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

gfs2_qd_dealloc(), called as an RCU callback from gfs2_qd_dispose(),
accesses the superblock object sdp through qd->qd_sbd after freeing qd.
It does so to decrement sd_quota_count and wake up sd_kill_wait.

However, by the time the RCU callback runs, gfs2_put_super() may have
already freed sdp via free_sbd().  This can happen when
gfs2_quota_cleanup() is called during unmount: it disposes of quota
objects via call_rcu() and then waits on sd_kill_wait with a 60-second
timeout.  If the timeout expires, or if gfs2_gl_hash_clear() triggers
additional qd_put() calls that schedule more RCU callbacks after the
wait completes, gfs2_put_super() will proceed to free the superblock
while RCU callbacks referencing it are still pending.

Add an rcu_barrier() before free_sbd() in gfs2_put_super() to ensure
all pending RCU callbacks (including gfs2_qd_dealloc) have completed
before the superblock is freed.

Fixes: a475c5dd16e5 ("gfs2: Free quota data objects synchronously")
Reported-by: syzbot+42a37bf8045847d8f9d2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=42a37bf8045847d8f9d2
Tested-by: syzbot+42a37bf8045847d8f9d2@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 fs/gfs2/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index a2ea121331f18..4d854556b5299 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -643,6 +643,7 @@ static void gfs2_put_super(struct super_block *sb)
 	gfs2_delete_debugfs_file(sdp);
 
 	gfs2_sys_fs_del(sdp);
+	rcu_barrier();
 	free_sbd(sdp);
 }
 
-- 
2.47.3


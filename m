Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E83391859
	for <gfs2@lists.linux.dev>; Wed, 25 Mar 2026 07:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774425021; cv=none; b=dJxbzuNx6FANdRRtKGGFm14u/VIZIHvKAn2TkvAWagbdHtI3Vxhvc6jKC5bXcj88+uOdjk7+kYEhwiCWvv6BWZ1KE/tLSIoqBJgwIt+gl/x0LSIUfTYwc4EcDvtmhHSPmaW2Gx5oWnQ5nCX2v1LGstzQGtfC3ihuuycSKiYr86M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774425021; c=relaxed/simple;
	bh=ItR4Wz7mDYFAFoOIGIFJiYRlLqBqysbkbQMGJz1z0zY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=cWXLp2Rvd8wY2L5erS0D29pYOxBtySvzupJfYzBYTxNE+xpv8em4zMpuBV1eQknhcK+FqerG1NPiFDr3JojVX0XcTfz04Pagg8A6Xc0K4hjg3UsgHPc8MlQxvK61lHg8KBjCuiJK2wcRQ5FUF3Kz9O0FOOUlou8zJ25rrpfVwGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=hr/nFKn+; arc=none smtp.client-ip=43.163.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="hr/nFKn+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1774425012; bh=9TGlAf3iCc70mwjpK02mImjzBwnDXECSAylRTpPKB90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hr/nFKn+3UBa+ldK3rk/Hh7eLIcrtPEtRI1gwEvSEkqiYIXKylGixp3XLXPCWuIE+
	 FG08q3mEKXe2kAeDhIvG3PMqmtzh/jdAAJBlX1AYUIdCU32FzqpKi1li5bwlU8TShX
	 kqCfO+yVjxk2AyLMLUYJeresoDqnFtdwli6JMRok=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id C89BC431; Wed, 25 Mar 2026 15:50:09 +0800
X-QQ-mid: xmsmtpt1774425009tsca3qcn2
Message-ID: <tencent_2F5364A365496603BEE4457766F76146C505@qq.com>
X-QQ-XMAILINFO: MJf32pulH481ViaztJ8HG2MpkX4jXOOqQXSxDw5o/+14xUaPhwRWgCtWj57fQn
	 QcPTX6TMx3/NcZY9Xj66zBKN4WfPxkRifJV5YE6V2EH/fUi4ASLmvkNtT3eTdpwLKcwAgjCNhb8e
	 ndyIuZhqFOG7hrl2rRwYe+8GBeJ1RS3deH/uf0RM4zjSbvKyDLm595R4mNTWvT0isFR7devlm6YY
	 sjCgy+yR8UepR32E+/9XrlzG4Au1CVhqaWD7/s5qAisRUeq4hJU10Z52A6QP489GkkbVH/jxuolL
	 fyjS4tHt5gjQopylMJuFIN/QYNlWIPehEaeKiQILp8ksdO+CqUgCdccKU8CtNQA3+8YYtDCG/VZ3
	 2b2EepAVFaQKpr3g7cd4S2ybqldR9L+HPDXo8UhYqqjzng2vEZAsl03m6esRDASEUm2sQDdxJ5+P
	 1K9FOEtiWVh9eIhbaU5Fqttn97sXIWWkyYIoOJ4Psp2Lmpew+FbGBEXYlJO0Uvz3bqn0/Ye7WuDv
	 ahLq51QrMvZtzxkxbebBoDgFtqBNNrnWiRBT2KORGuHKH9GVxK3Yfb7sN11F93xML4RKQVhe8HY/
	 v4bqd6T3S0Y3T218dcX2szfiHi5RxOK+S6ZUZqmBi9MXtjHi+GUrgCXvMrxPw0XkfUijb/64Fla2
	 7fbdCJN708XGPs7YOPcS76/aGDrF4124ixS5s43+9KhyK14uUHt5y0E6cjVODd7tlAqJ0EDuLdua
	 5TM+0TO2Cs0HY0HCvKsU/UeNggp/cpjM0uCMcqdm+daVlANRI0JmgK6iAjpQqG30nKHgTijn7PsL
	 JlnTywJ3VUSbCKnVqa33VKKC9KT6Mcv1d+WugrByBnPeSSKluEMcbn+ijGOwSX0Qn8fRzx1dgFBC
	 f5Ll1W2H5jwcdU1yUn+vdTPINHhEIkFeNjEwvJQvHumDjVb9FtJh1IKqzCm5maglXoo8inS/h0zQ
	 9dBt6OJ0CNvkrnk5HX3CrSEAstsTxCyitU+y0g/CkE6oQy+fn9XoeYejGgc9uo9m/un5Hg+DxinH
	 Om3GXUdezBVrKluA1qzCLXXJ76/Kk=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+9013411dc43f3582823a@syzkaller.appspotmail.com
Cc: agruenba@redhat.com,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] gfs2: prevent corrupt data from entering jextent
Date: Wed, 25 Mar 2026 15:50:10 +0800
X-OQ-MSGID: <20260325075009.486224-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69c19ef0.050a0220.3bf4de.00a9.GAE@google.com>
References: <69c19ef0.050a0220.3bf4de.00a9.GAE@google.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During the mount process, when the journal recovery is executed, the
system blocks and waits for the recovery to complete. The issue reported
in [1] involves the kernel thread responsible for journal recovery
becoming blocked on a specific folio that had not yet been fully read.
This folio was submitted via a bio chain containing an excessively large
sector value; however, the submission failed during the process because
the end-of-file (EOF) check for the bio failed. Consequently, the folio
was never unlocked, which ultimately triggered the timeout issue reported
in [1].

To address this, a check for the blocknr value has been added during the
loading of journal extents from the disk. If the blocknr value exceeds
the maximum sector value supported by the disk, it indicates that the
data on the disk is corrupted; in such cases, the loading of the journal
extent is immediately terminated.

[1]
INFO: task kworker/0:3:5963 blocked in I/O wait for more than 143 seconds.
Workqueue: gfs2_recovery gfs2_recover_func
Call Trace:
 folio_wait_locked include/linux/pagemap.h:1245 [inline]
 gfs2_jhead_process_page+0x175/0x670 fs/gfs2/lops.c:470
 gfs2_find_jhead+0xbd2/0xd30 fs/gfs2/lops.c:586
 gfs2_recover_func+0x6cf/0x1f60 fs/gfs2/recovery.c:459

Fixes: b50f227bddf1 ("GFS2: Clean up journal extent mapping")
Reported-by: syzbot+9013411dc43f3582823a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9013411dc43f3582823a
Tested-by: syzbot+9013411dc43f3582823a@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/gfs2/bmap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 1cd8ec0bce83..d42307ab0684 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -2266,6 +2266,9 @@ int gfs2_map_journal_extents(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd)
 	u64 size;
 	int rc;
 	ktime_t start, end;
+	struct super_block *sb = sdp->sd_vfs;
+	sector_t maxsector = bdev_nr_sectors(sb->s_bdev);
+	u32 bshift = sdp->sd_fsb2bb_shift;
 
 	start = ktime_get();
 	lblock_stop = i_size_read(jd->jd_inode) >> shift;
@@ -2280,6 +2283,10 @@ int gfs2_map_journal_extents(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd)
 		rc = gfs2_block_map(jd->jd_inode, lblock, &bh, 0);
 		if (rc || !buffer_mapped(&bh))
 			goto fail;
+		if (bh.b_blocknr << bshift > maxsector) {
+			rc = -EIO;
+			goto fail;
+		}
 		rc = gfs2_add_jextent(jd, lblock, bh.b_blocknr, bh.b_size >> shift);
 		if (rc)
 			goto fail;
-- 
2.43.0


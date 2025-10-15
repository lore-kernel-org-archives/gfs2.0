Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E0631B124
	for <gfs2@lists.linux.dev>; Wed, 15 Oct 2025 10:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760523078; cv=none; b=Ajc6IgPqkE7aKnNCw7atqbxTj253KKhDdPjdAzxQl0y/JRKz6+fSJucqRKk6/9xgPriKrItMNwWpuV9gN0u5eQX6RtjdlQHiOhDeysbi56ASfvyo354GAqcRK9UqS9mdaFqhMF208qouGlCW4mIt8QlRz23sgSHq3hAT9zPUeLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760523078; c=relaxed/simple;
	bh=u9b8lQWDWi4borJH07FOiSYt57nMAH9veqhXc/w4Q3w=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=AoWou9eHyqM0Wqr8XH4OIo9svtvsNbgN77yoIndZO3F4es5siz6kJsHB69+Obw79yq62YoKXQxLIf1cwmA81kO0f7DGhH3Ec6j+25KWWWyzxMGn9H4M07jvfQRH0Ds3GlZln3kNqqkpQT9BJNVKvNm0pUaZgCEMNS87jO82U5S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=z6NvG610; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="z6NvG610"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1760522766; bh=N4lziAz0p8/npj+8XxDM6gQAxJFJVrwubEq800Q2rZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=z6NvG610DPHz2lO4AoHFbXgddqJb95cC1Aq0qScvQmUpp6nyoTVmW+8XGyBOlHyKp
	 mUMjypu8LyHztwpfTwKBZR4kqGFUdnuuVyy4gdRcKT/WrMdNMjdpolAVm5X10a/8Gs
	 fCFGFyIoIg6pKmSS39mUUTY0/2LnmMMTStGdO53I=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id EEF09E46; Wed, 15 Oct 2025 17:59:47 +0800
X-QQ-mid: xmsmtpt1760522387tqr846sxi
Message-ID: <tencent_9FC786C5D2D3067449AEEED16EE6CC8BA706@qq.com>
X-QQ-XMAILINFO: MFZ9kh0LMtuHRtdv7MGfJoe/TmjeMUc1OD1hTSGeoObME/8KsPDRON2Z0sgLP6
	 nkCJHuHuuaoZpd8agk82gu0R8isGlQM+EiRWspWVG33u7hgQU5yf03HyrHSL0EwPUJDpPEy+6j9f
	 yHicbvRvlU2GVDCV1s9qitmHRm2CIAy63RX90WDP0YmMyZAL0M3EN4H9mLip+VnD2pNMCgn9FVyu
	 3J1oqGpyjFiJn/G6iQo09gFHo8e7vr5SzAgIOVJqXnkaJX0NVnN1kgCsbPQVfytBZwpfBd+lf0jm
	 QFmq0TcSxkQ9r+1otqZn8sV6CQJkH1INgAU3xE8wk0z752h7jMHbP4CUeUDq+iugDBgmMAuX58gU
	 4zt971z3iiBK9ATZsnDkSGstQ/hsleb61QZ1yPHzPpahhfErzc4XTwoFcpDljYmUS+64pusszbsQ
	 HrGwhfP74lnrTcdMJFbmJzgnp/YtGY/0KEXo5QdLFQIvCX4lodDz0iMaM2zZaHsVX7ckwUR5iTV5
	 hdTWipU/fg0hU37DdxykwnmVnsQoFH1RZtDnzzxeBhB0O2hB2pz4V77nO95GYhLb/Mw6/heuOxzF
	 yBXsNuv6GX0kfkBffwcXJVL+9vToHD59BuM130iAg3P86U5aDfvFIixIwii/FdocMFJ83bl/b7uM
	 6YaMC1wiP3dlUVQakvhDLb+f+NrsQbivC9187wyNAgFxq9rc7vI+UotReiLj3zIK7PLECnKyPUi/
	 y7vv+v84qbGdxAETSyZ626wS6E+X1HB3He6OmyJCmOqJzLkY4cThg6D/kI8Iyn4BGP1wxFyupL1x
	 GSDbkMJO0RD0jzUqTQLRDDxC9VNcAJF1pJ72in8o8pUB2PD/Y1SmT773Upb2mUF4thCBJqqhHetg
	 lfnkAyN4PdOrte1ewkzRKfbo5YnmOxgPVrPbayy6lGkikp83tJuvqa3+XsUBVWe5wtQ0C+bkOXOP
	 0+KXB6hRmxhdh9KEovP1LZHCvCpf2WveXtqoJl9G/IZ4W1XD1vwb587ETHo6NX6mEpmmWSeke+K2
	 T0uebggkzO1sVX1KKbcfRl9jua4p+J3YMA1CF08g==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: eadavis@qq.com
Cc: agruenba@redhat.com,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+6b156e132970e550194c@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH next V2] gfs2: Add sanity check for sd_jdesc
Date: Wed, 15 Oct 2025 17:59:47 +0800
X-OQ-MSGID: <20251015095946.1091541-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <tencent_9C66663DC537949618361A4B5E750576B309@qq.com>
References: <tencent_9C66663DC537949618361A4B5E750576B309@qq.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Asynchronous withdraw, when sd_withdraw_work is scheduled later than
put_super, will set sd_jdesc to NULL when clearing all journal index
information, triggering the syz report null-ptr-deref.

Reported-by: syzbot+6b156e132970e550194c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6b156e132970e550194c
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
V1 -> V2: Updated the issue reported in the comments

 fs/gfs2/log.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 8312cd2cdae4..433a3a11a2f5 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -427,7 +427,8 @@ static void ail2_empty(struct gfs2_sbd *sdp, unsigned int new_tail)
  */
 
 bool gfs2_log_is_empty(struct gfs2_sbd *sdp) {
-	return atomic_read(&sdp->sd_log_blks_free) == sdp->sd_jdesc->jd_blocks;
+	return sdp->sd_jdesc &&
+	       atomic_read(&sdp->sd_log_blks_free) == sdp->sd_jdesc->jd_blocks;
 }
 
 static bool __gfs2_log_try_reserve_revokes(struct gfs2_sbd *sdp, unsigned int revokes)
-- 
2.43.0


Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2907E36E46D
	for <gfs2@lists.linux.dev>; Thu,  2 Apr 2026 07:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775115365; cv=none; b=t/QiuPW4Paazgx4abU+ywUP27ZX4j9zeal5tpmabo9uCOk3kjVjlmO7QE/RgzC1dTlLbtxbSZcKX5/lz8Jac8+GtqTBGxM3SFXVUx/rOB9xkUMsnYXKajCohimJcbsjtVe4Ll749HA93NaBpnS0AVzCWaXwQHntAITL6oOTpOeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775115365; c=relaxed/simple;
	bh=voZxXb0nzUYMSaDpByUiiWHoQORZIN6uR+pGlzVG9GM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pJzA2ZPUchRoQaymHbjINPI2az0QcYvHM38fMmpGlE49taTwXQsdMyAI+7nwYY9mkSpm90VzIby+2ayAj5gC3txCHQrRyWyBubUYRHF7JcPJZbguKQewuC0F3b/vgk42eHctH6jsi7SMQpBnB3gfKyOGgTm/ZuCdCyrgGhK+rB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=OqnNNQRf; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="OqnNNQRf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1775115351;
	bh=gvrzPZvzUWNx+NmbMapce3hFaFvLUroRIvga08y6Ud4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=OqnNNQRfokoXpjlEa1Sl2pOMgI4mEmnrp5fWr6rpvF57pgoZxVoifGPj3A9EwnUA6
	 VyR6u5VwGk6/3tcQXWF5KbL8Y+OV5CjXdW+FnLOWpGIlGLnkNqCtKWzeVRMTxzEMZa
	 nSU1dK+jmf4g/3GuaV6xmy1BzmZsp8Eq5qhW5RF8=
X-QQ-mid: zesmtpip4t1775115328t2fea1b7d
X-QQ-Originating-IP: ylAYJahzFHRQmjephlvyKCnY9w2X+XwtGq+AX+Kp83k=
Received: from uos-PC ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 02 Apr 2026 15:35:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13073563863070807553
EX-QQ-RecipientCnt: 6
From: Morduan Zang <zhangdandan@uniontech.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+b17a83b050e9617376f0@syzkaller.appspotmail.com,
	zhangdandan@uniontech.com,
	Zhan Jun <zhanjun@uniontech.com>
Subject: [PATCH] gfs2: fix kernel BUG in __gfs2_ail_flush during withdraw
Date: Thu,  2 Apr 2026 15:35:24 +0800
Message-ID: <90A5E3D4005798DC+20260402073525.24496-1-zhangdandan@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NJdlL7FGabLoH5uRkO0Aj6SGDsgWdWAbJIefsFMbesSoCru6RLmmM+4v
	86eXQTEr+34Y9COAU+7AIIPqPBEEebJZWfxJDtTVy5VeSaZiMczoD0YQ9G+h9MCasACvFJa
	BxCcIljyy4FdWWzuKRCKtR4Glzbi3zhQ50pZY4+gDP4dknMge76/sHgKjQmBGUsfLy1EfCH
	UUbtcrr7FEb/LpRHLtl7qdVo2ff/va9AYiHtLAkyNOheyt3owpr3iH+1jBItJx57V3ghgi7
	8hXG5amJnYvfXeeElrH+aKu6XtuF2/hsVkSBClfntCri1ZjA9mbZny8m5P4AqTYrWV71jzL
	rMBcRO14j5sgugu/dDyAhqOeCh4wr5VkkmKfoVnvCfX47zb5t5dutneXzcf7zkFASZj6HMo
	po5nn127PyGLBNrmi+743k9yRTeT6cPg7tg5aLSwbi5ZdpdotGrD21Zx6FI5AUc0glxxKH0
	GO3MAvDivztxv9X85qIWiA3w2eOXLg1V0DSc1OImgCR0qYPWLTTrWnil4PEuDovzP//1gaj
	Q5FYJJFkl+JzhIdqmYM+fm8MF3CqbreNDIXnT+5tW6PwsovRNcQL+jxDCIaDDtuDK4u3GVZ
	7mP8/82djVAMMj47CjOezm9vfmHrRg//O0GcxUNV9eWKUx7sUbnnc3kdz6Kf2OoIQNw273d
	9vWkVy4idYEP25ikA02myssxykFXbNcwlztLqz7HwBLode+EcZL/2ObXdn3QeBQrNdJgpFv
	ao+aJcC34ybbDH/7EZJAwPIuKmMBqYdc0AUMzf8w8dlMHu91mAk+WdhgR/zhiwfvWLStpob
	WE3BACackVNoRMOPY54+5bVbirRvCTmqgXGusFJBhN5ONmXB1OWCIgkBHM12JX5Q97wazrY
	SAWwj1xMInAcas6e0DfhHfwyBApvJ25/BFUiSml6c7QKtK50FIhKvz6wEQ50okhMk1Ncvzl
	PYLOiluFAKriUm4XDFCwlp+BHmrujRnduv9rHEu3VzPzAiuJeWH+UgkFaa9cN2Sr9xAo+kA
	DdAZkZFm371yky1ZWSWHHBQAhlKkIy4Tcp5qtierGZyRj6IZKJa25Fn5Iq1MJdfZQp5ba//
	SxMqjmef/naVSGjCssrhkw5j5ElyBm1NQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

From: Zhan Jun <zhanjun@uniontech.com>

When __gfs2_ail_flush() finds an AIL buffer in unexpected state
(dirty/pinned/locked) and fsync is false, it calls gfs2_ail_error(),
which withdraws the filesystem.

However, the code then falls through and still calls
gfs2_trans_add_revoke(). That function asserts that bd->bd_list must be
empty:

  BUG_ON(!list_empty(&bd->bd_list));

During withdraw this can be false because the same bufdata may still be
on a transaction buffer list, which triggers the reported BUG at
fs/gfs2/trans.c:321.

Fix this by skipping revoke addition after gfs2_ail_error(). Also avoid
asserting gl_ail_count==0 once the filesystem is withdrawn, because
buffers skipped for revoke can legitimately remain on the AIL list.

Reported-by: syzbot+b17a83b050e9617376f0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b17a83b050e9617376f0
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev
Signed-off-by: Zhan Jun <zhanjun@uniontech.com>
---
 fs/gfs2/glops.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index ba61649368bf..70c998b80e86 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -74,11 +74,13 @@ static void __gfs2_ail_flush(struct gfs2_glock *gl, bool fsync,
 			if (fsync)
 				continue;
 			gfs2_ail_error(gl, bh);
+			continue;
 		}
 		gfs2_trans_add_revoke(sdp, bd);
 		nr_revokes--;
 	}
-	GLOCK_BUG_ON(gl, !fsync && atomic_read(&gl->gl_ail_count));
+	GLOCK_BUG_ON(gl, !fsync && !gfs2_withdrawn(sdp) &&
+		     atomic_read(&gl->gl_ail_count));
 	spin_unlock(&sdp->sd_ail_lock);
 	gfs2_log_unlock(sdp);
 }
-- 
2.50.1


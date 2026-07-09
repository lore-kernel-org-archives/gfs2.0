Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82F837E2ED;
	Thu,  9 Jul 2026 17:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783617497; cv=none; b=fVQ1z0CSTooEv8KuKrkrnQWRZAU4ttIxYgppgNNXHsntxGlo9buhKURc9Kyw8TQyMhJsps+F8pf1oG/SsSfgDkLn52g2QzCc4tvNZNLBdvgWRzNkRp7n9AZLUFoKP50xetYvitI9qGaP4O+X0g79X3qeo6KT1vBiD++VXQ4G/0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783617497; c=relaxed/simple;
	bh=EDml9+yLb7KvSQ4ExyRapJFRk09w+I2HIzMY6E8/d/I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nCcim2Gwuz3AcIEABElWyj3p3JKevLi1rFViQMUwdPtvY2oUqBi+7mYF5CUSvKy+OSPNyzAR2GT3v2Ez1DewP1K2OAV0e9cwSexXTE1fb34A2o6m4GkaBN+DN0l2HBnV5pEiD+kEH2VlCDjMaGbLb+U6aRGz9ty4Cmtz44LacKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=BNIJQpUi; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="BNIJQpUi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=RqWFlb67Z411Z3PW1TRg1W15WBVzrq3Lw+hVqIxsOHY=; b=BNIJQpUi+iCYFO8KtqzMxmZZ0b
	M9A0JUIpmscwIFxVgoX/4ErbOMTq+D60wyAfUyBC0HXkuqGWUHDIT0LbgTkx1NMbSvyfeOhdRLRSa
	/c2tzOGfoi81YdGXp8k7g+oGLe8yeprnF8tuFyWmp50EgFbn5zCsLnu5eiM+T8y/Znu0LBOIljWiZ
	SrSbkwsgesWnTtor8zUhuxySYnIvF7xtoYpOfd9bgILsOShD1NNgY40biq3tWMEULvgxXfqsgnU36
	ZcxEr1Yzr49hPG9LnUHtr+SRq58ygANqoKVTruqnAxDVmMqRxL7GGJ5m/Cf3keY5kuO/5cHsyiazB
	UwYdzxyw==;
Received: from [179.96.247.152] (helo=toolbx)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1whsO2-00CL19-Do; Thu, 09 Jul 2026 19:18:11 +0200
From: Helen Koike <koike@igalia.com>
To: agruenba@redhat.com,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	koike@igalia.com,
	kernel-dev@igalia.com
Subject: [PATCH] gfs2: keep LRU glocks with pending AIL during withdraw
Date: Thu,  9 Jul 2026 14:17:57 -0300
Message-ID: <20260709171800.1650232-1-koike@igalia.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The shrinker can queue a glock to be demoted while racing with a
withdraw.
Then do_xmote skips go_sync() since the fs is in withdraw, so the AIL
list isn't drained and it proceeds setting the glock to LM_ST_UNLOCKED,
the ref drops to zero, and the rcu_core eventually calls
gfs2_glock_dealloc() freeing its memory. And when we are unlucky, the
rcu grace period + mem free finish before do_withdraw finds the bd
during gfs2_ail_drain() that points to the freed glock, causing a UAF.

Prevent the LRU shrinker from evicting such a glock; leave it on the
LRU until unmount.

Reported-by: syzbot+84a21b16aba9f279d96a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=84a21b16aba9f279d96a
Fixes: 767fd5a01607 ("gfs2: Revise glock reference counting model")
Signed-off-by: Helen Koike <koike@igalia.com>
---

Hi all,

I was investigating the mentioned UAF issue reported by syzbot.
After some digging it seems to me this is the cause of the issue, but I
couldn't validate 100% since it is hard to reproduce, even using the
reproducer from syzbot.
The reasoning is mostly based on static analysis of the crash log and
the code paths. Please let me know if I've misread the race or if
there's a better place to intervene.

Thanks
---
 fs/gfs2/glock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index b8a144d3a73b..0d81f3c40165 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1896,7 +1896,9 @@ static bool can_free_glock(struct gfs2_glock *gl)
 	return !test_bit(GLF_LOCK, &gl->gl_flags) &&
 	       !gl->gl_lockref.count &&
 	       (!test_bit(GLF_LFLUSH, &gl->gl_flags) ||
-		test_bit(SDF_KILL, &sdp->sd_flags));
+		test_bit(SDF_KILL, &sdp->sd_flags)) &&
+	       /* Avoid racing with gfs2_ail_drain() during withdraw. */
+	       !(gfs2_withdrawn(sdp) && atomic_read(&gl->gl_ail_count));
 }
 
 /**
-- 
2.54.0


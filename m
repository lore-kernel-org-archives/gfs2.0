Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F95E1A290
	for <gfs2@lists.linux.dev>; Tue,  3 Oct 2023 14:27:06 +0000 (UTC)
X-SMAIL-HELO: pek-lxu-l1.wrs.com
Received: from unknown (HELO pek-lxu-l1.wrs.com)([117.61.243.122])
	by sina.com (172.16.235.25) with ESMTP
	id 651C242100003B31; Tue, 3 Oct 2023 22:24:38 +0800 (CST)
X-Sender: eadavis@sina.com
X-Auth-ID: eadavis@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=eadavis@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=eadavis@sina.com
X-SMAIL-MID: 42884334210357
X-SMAIL-UIID: D5BBD074262E4212B04A778A6CBDCC90-20231003-222438
From: Edward AD <eadavis@sina.com>
To: syzbot+29c47e9e51895928698c@syzkaller.appspotmail.com
Cc: agruenba@redhat.com,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rpeterso@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] gfs2: fix slab uaf in gfs2_qd_dealloc
Date: Tue,  3 Oct 2023 22:24:31 +0800
Message-ID: <20231003142431.250548-1-eadavis@sina.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <000000000000fe5ae806067f6d39@google.com>
References: <000000000000fe5ae806067f6d39@google.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a probability that gfs2_put_super will first release gfs2_sbd,
and then execute the callback function gfs2_qd_dealloc of call_rcu to call
the already released sbd opportunity.
Therefore, before releasing gfs2_sbd in gfs2_put_super, execute the rcu
callback function gfs2_qd_dealloc by waiting for "sdp->sd_quota_count == 0" to
avoid such issues.

Reported-and-tested-by: syzbot+29c47e9e51895928698c@syzkaller.appspotmail.com
Signed-off-by: Edward AD <eadavis@sina.com>
---
 fs/gfs2/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 02d93da21b2b..86b68f0eadae 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -649,6 +649,8 @@ static void gfs2_put_super(struct super_block *sb)
 
 	/*  At this point, we're through participating in the lockspace  */
 	gfs2_sys_fs_del(sdp);
+	wait_event(sdp->sd_kill_wait,
+                atomic_read(&sdp->sd_quota_count) == 0);
 	free_sbd(sdp);
 }
 
-- 
2.25.1


Received: from mail.nfschina.com (unknown [42.101.60.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118921396;
	Thu,  2 Nov 2023 01:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 72A4A60292B89;
	Thu,  2 Nov 2023 09:52:00 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: rpeterso@redhat.com,
	agruenba@redhat.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	trix@redhat.com
Cc: Su Hui <suhui@nfschina.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] gfs2: remove dead code in __acquires
Date: Thu,  2 Nov 2023 09:51:42 +0800
Message-Id: <20231102015141.1355762-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clang static analyzer complains that value stored to 'gh' is never read.
The code of this line is useless after commit 0b93bac2271e
("gfs2: Remove LM_FLAG_PRIORITY flag"). Remove this code to save space.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 fs/gfs2/glock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 3772a5d9e85c..347f8a020c82 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1524,7 +1524,6 @@ __acquires(&gl->gl_lockref.lock)
 		return;
 	}
 	list_add_tail(&gh->gh_list, insert_pt);
-	gh = list_first_entry(&gl->gl_holders, struct gfs2_holder, gh_list);
 	spin_unlock(&gl->gl_lockref.lock);
 	if (sdp->sd_lockstruct.ls_ops->lm_cancel)
 		sdp->sd_lockstruct.ls_ops->lm_cancel(gl);
-- 
2.30.2


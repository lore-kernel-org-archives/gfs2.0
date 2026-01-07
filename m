Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7722225A35;
	Wed,  7 Jan 2026 07:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767771050; cv=none; b=hOVJH8J5o24pahVLP5Ybwt0v6jntZ50PJA9KuRt5JuHLIZMPLDGu/Fcu3+JzANNlbQormluCKPhpLhMVGbXDlErENWn93T0Fh0Wd6br85RqHWKlA7e9y0Zy0sXBuignfg1MCtphe8wN1wf6baKXKd1TYh5DikDkxL1/aFdZTnJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767771050; c=relaxed/simple;
	bh=DrtYMI4Ej5hB1qGekufnysvZNKSPAiI/xDXdjcKQs30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TUlhnFsMEvxzXeLKfvbRLfP/yUAAIQTnVjZ5O7Cws3gWPoET6A66pjPvOF6TGU4zHW0f/hAbn/ynAbR3PzqUGPHkgEODC3p14DOG1Fri2HKAieJWUcC+oBSNcCZjmBCCB0RB6zqKa0x9NuduHqap2Gz+Qx+jADVIo0TsTpCFhhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyE8UKfp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyE8UKfp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4881C4CEF7;
	Wed,  7 Jan 2026 07:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767771050;
	bh=DrtYMI4Ej5hB1qGekufnysvZNKSPAiI/xDXdjcKQs30=;
	h=From:To:Cc:Subject:Date:From;
	b=SyE8UKfpMymsaI43GVSN2rA1aqIZ0N93nEc5EWqG0c6eB5PRF1j7+LFeeoZIzt7eF
	 EW7UgrAIToYL9DcNlkbiHwqdVkuCzVCjscFBdykJEufJKx609dJseoqNB6z2vhvL+7
	 LB+ZntgafVGz4b1Ym1LHAGN4lj/V0+JSK9waA6Ny5eO2vyT6TXJYE9WdewW1zYGxNG
	 G6YHPXfhfQxNR1avVgo1jjowiZbF1N893Bn+vnf5ltFxboRNXOmiubuSJ9IAhI/uvB
	 h+Ehv0c4cSCOkkXUdTlBKOBQElfSrhd3QoYbl8AN0Ut4TvNHFYtInn3GTtgB6gYKTM
	 9seARjn5mYEKw==
From: alexs@kernel.org
To: Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>,
	gfs2@lists.linux.dev (open list:DISTRIBUTED LOCK MANAGER (DLM)),
	linux-kernel@vger.kernel.org (open list)
Cc: Alex Shi <alexs@kernel.org>,
	gfs2@lists.linux.dev
Subject: [RFC PATCH] fs/dlm/dir: remove unuse varible count_match
Date: Wed,  7 Jan 2026 15:30:14 +0800
Message-ID: <20260107073015.16562-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

The variable was never used after introduced. Better to comment it if we
want to keep the info.

fs/dlm/dir.c:65:26: error: variable 'count_match' set but not used [-Werror,-Wunused-but-set-variable]
   65 |         unsigned int count = 0, count_match = 0, count_bad = 0, count_add = 0;
      |                                 ^
1 error generated.

Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: gfs2@lists.linux.dev
Cc: Alexander Aring <aahringo@redhat.com>
Cc: David Teigland <teigland@redhat.com>
---
 fs/dlm/dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/dlm/dir.c b/fs/dlm/dir.c
index b1ab0adbd9d0..01c292379f5b 100644
--- a/fs/dlm/dir.c
+++ b/fs/dlm/dir.c
@@ -62,7 +62,7 @@ int dlm_recover_directory(struct dlm_ls *ls, uint64_t seq)
 	char *b, *last_name = NULL;
 	int error = -ENOMEM, last_len, nodeid, result;
 	uint16_t namelen;
-	unsigned int count = 0, count_match = 0, count_bad = 0, count_add = 0;
+	unsigned int count = 0, count_bad = 0, count_add = 0;
 
 	log_rinfo(ls, "dlm_recover_directory");
 
@@ -157,12 +157,12 @@ int dlm_recover_directory(struct dlm_ls *ls, uint64_t seq)
 				}
 
 				/* The name was found in rsbtbl, and the
-				 * master nodeid matches memb->nodeid. */
+				 * master nodeid matches memb->nodeid.
 
 				if (result == DLM_LU_MATCH &&
 				    nodeid == memb->nodeid) {
 					count_match++;
-				}
+				}*/
 
 				/* The name was not found in rsbtbl and was
 				 * added with memb->nodeid as the master. */
-- 
2.43.0


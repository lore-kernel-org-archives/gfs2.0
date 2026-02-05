Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386F53D9033
	for <gfs2@lists.linux.dev>; Thu,  5 Feb 2026 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770299608; cv=none; b=qMmgF9gyKPgnoZyiFG6a6Lz05Xv8G5CkiJT9iBB2Pan+ofQd5mZBCYeWQKNjVH1sRgAdGdrQf5lbXBtslD0FhOjBr7znNSb6nxYP2XMU3cuQkSERLsvizUCwfb1uGCJOvNIz7Fc+FsL4Zf2/gFVVJyvXkU1iMKST357Qnds9GNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770299608; c=relaxed/simple;
	bh=eLdJY5LzD0R48n+KWjg0ZTjc8vtgnc06t8anjYdR/cE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nsLwCnvIlqBEa2dlvkh0u+eEwviK/U1YMViIvQrSVNlzISossuldB5NfecmfkCffH26ZzwVLQxI+mwkLREs2Gmj2yA4XaNqQns0JvjD6boMkaj/L1tTIxVcjG2biNvD2YU6afsSnwI9pquUr3f6G4ZOPEBADVhMDlqX+r3mOfbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qqv2pccl; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qqv2pccl"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-81f39438187so744956b3a.2
        for <gfs2@lists.linux.dev>; Thu, 05 Feb 2026 05:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770299608; x=1770904408; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G67yzkdvTRO2cFHYjLbr/NtY4aKeltlmQbsZf9oJ+Ks=;
        b=Qqv2pcclLcNnU64Bu5rnAUwK0yYKqEFpBE43Xuh/o0Uz6cPD+ix/uXpsiJWouXFQvM
         iHgyl5resXdwQK0f31ot5u9d3dnaJFAwNnZ3YZUw4638NC2W7DH+c7UERZyBqvzklp9G
         Bcq9cd/zcRcw0GMGX922BaqJ5w3Q8iS8pU/54avo/voCY03X6MB50gNJOKyuCYQX0dLH
         HXxU7u87qD0A/IqNCvEGnO+8Gl2V4VfkG8vNqHqoMP7oxeJinLH4d10EZCg4TP4dthtd
         ETT0sSoQO3+WR09/f4lvLdCA8N83omlyZBNAKfZkW+QvDV8f/2JQndrJblYkQJbZxXxh
         9lVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770299608; x=1770904408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G67yzkdvTRO2cFHYjLbr/NtY4aKeltlmQbsZf9oJ+Ks=;
        b=qm/7RD6KopsysFjEuFH9u3uGgZcr5ST6/Co03B5ctXi/KF1Qfg26M8xpaFtd8KlZ/Q
         9y9Edo378rnyLpkXYGWDufG73yntqX9U8c99YCuiXEv+MFC1HYE1AcPHtrNlMkdo+R3z
         NYoo0Z6gi4GSPkLAOkxujkwxJ7eL0tynRL3F2vQuJXE097ioe+sBw5K5QGE7e0sxGhQX
         pF21WwZpgMkHc2KJflajou/sIjfDZmqPpUnZjxOa4tqkkqN/QADIvIPav6nvJKe7O659
         7ivilTwcY9gmW3VHP8XBTEhoCsfIKk3jIkmwxqAddT+oOUVwY/qBC2MQPMdNAjN6GDOO
         QSuQ==
X-Gm-Message-State: AOJu0YzcFq+Ny/u9U8Vx6JKbYpBFHQGdjfKgVlt09XhbWJmohku1XhRk
	MtxzaFrXhMXR1v2mEWWENDSoie/QBFCbLj39uXL/0b7ekN0zje4BJY2w
X-Gm-Gg: AZuq6aKc/EOWmI+bgxrJdlNo5rkyQuyHPjLlxwMWxxM1+hOGmwvLcDgIxCMtuSiLcv9
	8bX9dWcgDjQkTS6lUWaL+F+7Rh4zAC3iEd7Rs0SgJdaZB0QsxYrn9tSnRywhD8l20u5NmENk4HD
	nNFjvKEqiTfOcUhY17oPoWwvlFDHcWxYpFfVq+BqFBRqhGZG38XELcJX4G6EdSLGhC+huSSWQV5
	3Y7RL+3yq27jWI5MMHBfN2tGbFbRN+94FqdpBRHe5FmZllHqjqwOZNXQbuTOKD0gq+nPn39VYXE
	n9WoSJVoItIoiLEznHsyX7Z9/nUKPQ1csUrmEpLsQUe7uXsULNT0VuwAXVlQEkiRfvy+2S8D91C
	BYn9cmgniK/MqBzw8cnp9sooDZJ32BmyCzLxOz65eRkd412lIdIfrjIGwTpqZDH+a8kwtE6p7n6
	t6K2DVRQTMspZYZsX94BTvcTSv1CaY2xc34OSU
X-Received: by 2002:a05:6a00:1485:b0:7e8:4398:b369 with SMTP id d2e1a72fcca58-8241c68909dmr5883516b3a.60.1770299607494;
        Thu, 05 Feb 2026 05:53:27 -0800 (PST)
Received: from DESKTOP-ILBT5MC.localdomain ([175.152.118.238])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d435128sm6016847b3a.38.2026.02.05.05.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 05:53:26 -0800 (PST)
From: Qing Wong <wangqing7171@gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>,
	Bob Peterson <rpeterso@redhat.com>
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Qing Wang <wangqing7171@gmail.com>,
	syzbot+e57495fb65020ac7bca4@syzkaller.appspotmail.com
Subject: [PATCH] gfs2: Fix memory leak in gfs2_make_fs_rw()
Date: Thu,  5 Feb 2026 21:53:18 +0800
Message-ID: <20260205135318.5346-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qing Wang <wangqing7171@gmail.com>

If gfs2_quota_init() success and filesystem is withdrawn, need to cleanup
by gfs2_quota_cleanup() to avoid memory leak.

Reported-by: syzbot+e57495fb65020ac7bca4@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=e57495fb65020ac7bca4
Tested-by: syzbot+e57495fb65020ac7bca4@syzkaller.appspotmail.com
Fixes: 601ef0d52e96 ("gfs2: Force withdraw to replay journals and wait for it to finish")
Signed-off-by: Qing Wang <wangqing7171@gmail.com>
---
 fs/gfs2/super.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index f6cd907b3ec6..efa0e2452bc7 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -147,8 +147,10 @@ int gfs2_make_fs_rw(struct gfs2_sbd *sdp)
 	}
 
 	error = gfs2_quota_init(sdp);
-	if (!error && gfs2_withdrawn(sdp))
-		error = -EIO;
+	if (!error && gfs2_withdrawn(sdp)) {
+		gfs2_quota_cleanup(sdp);
+		return -EIO;
+	}
 	if (!error)
 		set_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags);
 	return error;
-- 
2.43.0


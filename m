Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D53926ED37
	for <gfs2@lists.linux.dev>; Mon, 29 Dec 2025 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767028469; cv=none; b=UyqEe/D+ikvTqLJangGdi4TD2rEWx2Ai29bgwyGKhOyKXkUHS9gQ23yhbYZvIKAOyQfi+FKJ/wirIAxFScjHyaJb8z98EJRnNTVEzM4ly3aLIRHAidIOx7BLv6fTYQmnz7zj1qxdMDfEjgP/inQz31bdTo/CgVPULF6PdqVAa9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767028469; c=relaxed/simple;
	bh=W6aUeOEN1SgFtWQZemlJwqK1F1smQGCcFNxoAevcZJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tsOzQJ+MpnZE1cUrqAe5ERpzNiGIrRXAWeGFQugPzjmgaF2tVEnHAGtH6X1w8mmQlnBdGnqu/kPw7AfC0kKuHa9UeRcGP+6hMRQZzCOyRxbFNDG3GF3scFacw44/baWOqwzK5lI1Xo2O7XMopGSep7iCH2jJ4W0lR0YxXBb1uTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJ/MdmW/; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJ/MdmW/"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so7953872b3a.3
        for <gfs2@lists.linux.dev>; Mon, 29 Dec 2025 09:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767028467; x=1767633267; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5NK6dp2s8X6NtEpLJQM+0l1rM8deukQbR1S/tTFRVRA=;
        b=eJ/MdmW/EXkim+QdfzAEZCx4qGlaabo0upG7bYl3L+FlB8ig2+e0Qsv07h96fzkq3B
         1MKWCGFfIfDnygYHXIJZM6fEy0woqYV79dWkwrBblYP0cFGpxLw7vbTHDcSR5z9fHn7f
         0LvKgClliCeiQZ0uBaDvs/co/G//+eIag8+QSzqRPfQnC1XqnfTuz1JCpT+gaAw2ENrp
         6qfv/gS0FxIiU6ihpLJMtiHIOjYfoW6+PZMUOl1WtEzB5K/B5Guj6sTxdS8i1rlhqbvU
         B8iwNMWyWEfWrJ3M7+sZWzNPgzE2AkxGOyjO957g/GC4S0uOMBb+LxEOySyZ//VbVXJJ
         O6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767028467; x=1767633267;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NK6dp2s8X6NtEpLJQM+0l1rM8deukQbR1S/tTFRVRA=;
        b=LPYwwHTLeKzye0g0frEuYFID76pj+YMgbAN6XUHN3obzPe0sSyklRcVV/QP6h1nFWl
         Q5gt3JHNLeTNoR2w9lveVj/IaodClQNoZ+DRHqhbDEAHBKex9vgWndBdoNPX+mc/nBi+
         NpbVx4wr2Hex/mTaYRefcOWdLLqCh9KJNo2yzSDMhvy6DPvPhwwM6Q0nLVmkunt9FU9r
         dLM3v14vahg0iJazjqwCCl1vTh9nwSYGWuVKg+ejK1NtsgRlSp2NAIFpOb075AG6EfkR
         YwnUtSIKsEqpY2MYrIYCsEoYZJCQsoCxnh1jsW9RvVPaLCETRLuV9CiS+EACAXQfzPMq
         k5TA==
X-Gm-Message-State: AOJu0YzjS1ZSltqPngJ9IPAmcMZzCR2S4ZQmbmLr969kEtWjBc3vFTcS
	5Aj2lXNoAJ6c7DIbrEWGRaoIDqLL9atM2ChvBqxSiRRl0xGpdZ2UV5CztAQ0RgW3
X-Gm-Gg: AY/fxX7/EQybLx5eimeG5RwURTSWWAja0vg4Io42mq43bdgNJ1PZ1DleaMi2baKG81q
	L4CW1rVXg3bn9pBIaX3hryc7BNbod7Ql6G4zuRm4CBnTh5+yyPK6xk6REokhC4qRBguMINhYZ1f
	agKEr6ro2N3QL56sfbaY4bgtMseBHcznZLkf/cAUNhGA1NvtgvszYW8mjn14KrzX7ZFe6A7snz/
	r9y9je+K8BhhylWrIIQVt+DkPPA7tOVBv2KZ7tZp2T26QozYmfU2VoQaPlBsOh+ZoLQLH1t3rXN
	vExoIQyUsF8WD4DBRtxX6WoyH5VGjfG7CtI60hRoH6D53j6LiTfAzxks5roFwuw2y1146WalAK0
	P1PFrAYJBP5ixFf0fJBKy/T9OUZG0uiIjImDfxdRqLYJG+WSDIAdD1D4RFGgYMBmfsoolwkn1d+
	+QmjPMdUkylayowM9a9po=
X-Google-Smtp-Source: AGHT+IE0UQafWJtzQnLvkcd4tjvwk6WEjuZXQW80bW7BYX7qVp8/RiTlljt2VidyeoCSfiVHLlor+g==
X-Received: by 2002:a05:6a00:1f0c:b0:7e8:4587:e8c4 with SMTP id d2e1a72fcca58-7ff66479a55mr26456010b3a.55.1767028467371;
        Mon, 29 Dec 2025 09:14:27 -0800 (PST)
Received: from [172.16.80.107] ([210.228.119.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48cffesm29656429b3a.49.2025.12.29.09.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 09:14:26 -0800 (PST)
From: Ryota Sakamoto <sakamo.ryota@gmail.com>
Date: Tue, 30 Dec 2025 02:12:51 +0900
Subject: [PATCH] gfs2: Fix use-after-free in gfs2_fill_super
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251230-fix-use-after-free-gfs2-v1-1-ef0e46db6ec9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqDUAwFryJZG9B8lOJVShdf+6LZWElaEcS7+
 +lyYGZOCrghaKhOcuwW9lkLtHVF05LXGWzvwiSNdK2khtUO/gU46xfO6gDPGsJ9P+kISWPODyr
 15ijq//x8XdcNrx2XbmkAAAA=
X-Change-ID: 20251230-fix-use-after-free-gfs2-66cfbe23baa8
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
 syzbot+4cb0d0336db6bc6930e9@syzkaller.appspotmail.com, 
 stable@vger.kernel.org, Ryota Sakamoto <sakamo.ryota@gmail.com>
X-Mailer: b4 0.14.2

The issue occurs when gfs2_freeze_lock_shared() fails in
gfs2_fill_super(). If !sb_rdonly(sb), threads for the quotad and logd
were started, however, in the error path for gfs2_freeze_lock_shared(),
the threads are not stopped by gfs2_destroy_threads() before jumping to
fail_per_node.

This patch introduces fail_threads to handle stopping the threads if the
threads were started.

Reported-by: syzbot+4cb0d0336db6bc6930e9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4cb0d0336db6bc6930e9
Fixes: a28dc123fa66 ("gfs2: init system threads before freeze lock")
Cc: stable@vger.kernel.org
Signed-off-by: Ryota Sakamoto <sakamo.ryota@gmail.com>
---
 fs/gfs2/ops_fstype.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index e7a88b717991ae3647c1da039636daef7005a7f0..4b5ac1a7050f1fd34e10be4100a2bc381f49c83d 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1269,21 +1269,23 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	error = gfs2_freeze_lock_shared(sdp);
 	if (error)
-		goto fail_per_node;
+		goto fail_threads;
 
 	if (!sb_rdonly(sb))
 		error = gfs2_make_fs_rw(sdp);
 
 	if (error) {
 		gfs2_freeze_unlock(sdp);
-		gfs2_destroy_threads(sdp);
 		fs_err(sdp, "can't make FS RW: %d\n", error);
-		goto fail_per_node;
+		goto fail_threads;
 	}
 	gfs2_glock_dq_uninit(&mount_gh);
 	gfs2_online_uevent(sdp);
 	return 0;
 
+fail_threads:
+	if (!sb_rdonly(sb))
+		gfs2_destroy_threads(sdp);
 fail_per_node:
 	init_per_node(sdp, UNDO);
 fail_inodes:

---
base-commit: 7839932417dd53bb09eb5a585a7a92781dfd7cb2
change-id: 20251230-fix-use-after-free-gfs2-66cfbe23baa8

Best regards,
-- 
Ryota Sakamoto <sakamo.ryota@gmail.com>


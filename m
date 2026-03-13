Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD177299948
	for <gfs2@lists.linux.dev>; Fri, 13 Mar 2026 22:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773440870; cv=none; b=nsqUvDPecAwDooi4cSHQN+pHb4DluvELjFVDZYSEoQhnHxCHPVuqlDXUaTqIjnqPo5JDdkLtBLXyjveqZ7r98Edq1N1E+AzFDFSzK6fOM+3wjGJ+HURUBo+h/xoLCltk8aDkojRxASBSRG+22erQKww/pfJaI9iW+u01oTNXS5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773440870; c=relaxed/simple;
	bh=Hk1y1xAXjcWQY6HMqIwMsdin9uzdDSmmOdRhch+8UGI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XuBZMzFxZ8dinYHTaG9E0TYX8HOeYfAVIe/FSZRjQnOuprFGLtiWzSCt3c3nw7oyOERw8HTfJy1faJQAAoeYNpnwVJDmAxYRuizHhMti/iyDW2lcmeinDwvRWnC9P2TB7Ls+QtoTzR5Ny6OlvI5VOheY2oeBiJdUtAihpNE4P84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6scJM/W; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6scJM/W"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-899fb2b94c1so35596426d6.3
        for <gfs2@lists.linux.dev>; Fri, 13 Mar 2026 15:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773440868; x=1774045668; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8BvcT1IIS7Jlps7RPg5UaDsWaD7mJeuEz9vHBDI8e5M=;
        b=A6scJM/WgiO4ioseegTTDqPkkp3XxcZKC8xFdmHhiJzbhlYsSCSgJBBvlPupr2hnYQ
         LdBos9BHNIDDKv7W9NoOKbxI10a04qhCxUeNEZvy7deT6YD0pDOOt6fwzap28iHAP05b
         uOPAHPGVZJ+KUPPydbWjQ0I548lV/vHHIaeH3qHAxVY5Zhj8JHocQsZr/9TinX93Yllo
         WKXpcFgXSt6x/FnqKwjcJRBROLz8U9Hszk3tAfBFmv58tjVV3NUftkwXyzJpjE2FLcqD
         CoyL58swc32J0LpA7PZ7FxhL7aEKHu70sgvz5vbDP8HMHD53i2Qcof5Xu6j8iwZEze2V
         pNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773440868; x=1774045668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BvcT1IIS7Jlps7RPg5UaDsWaD7mJeuEz9vHBDI8e5M=;
        b=BexMACX2FOkuBqhJ5JwD+E94qRvPwq+ZXeMc7G20DOJCyce81tMJPI6nC1C4p5V45g
         5HGH/C1bJvZz5PEnwdf9wkkCkBy8ilUpLy4lsJMwIbXcK0wNOcoYte3o2KxT3dfQEBVr
         lIArVFRL5VlRzTKoJ0t5iuyK3MbC8qL1sTtRaZdnnRe67cacaLq+WUlu+f1rO8CDHcJo
         kKAzAQ23y+Ql7IuRud6vXvHsr5yMTbUzTen/rFQKLso8C4/F1HFTBGrSUTXQ4TpES8Md
         pGBYjBHSXlXUiO1ZKhXCwWzXlBfwKqbTmjDQdtQBqj9hkIm0aShlZjXOUGzBBK5vd8rN
         zViQ==
X-Gm-Message-State: AOJu0YwxU4TYHY7o8eZ0l7+ZxsM3NRMDd37JrM8MZzm8+h3Ab6RtBm5n
	+aaM8vlIVh1hJoa76ZCYJoYblGv93kVzDMEhNF845G0iiC34uRzYhY2f
X-Gm-Gg: ATEYQzyBe4Xtb5RUsuIj1w1DPF/Msx7bEQzSEFvaVkjqmvZxcVJp4PeQ+o7Fuey4tOY
	elUQBPjzdNFhixEm9x5DGJLHdBYvayTFmlV4Y+wxEAvYFqaJdyo1l78Iayum0yE+uo5N+emlX+X
	aM5FFmRfP3b0CWlOPIbxqYx1c9uzQFvglHiCjBaCJFRsFCEY8buTlO8wJpTmowLD4N8943bmxCy
	XCSoATQE3zV8Tlx++tksglXCj3QLTtZojR+Ed3xaYSzyXyduBsgRtc20lWooqNuylQcwY9cJgo4
	Gs7n7S1bMqefFqbrI9oqsjeoHYHp0Jza1DZkIx0OmgsrQXYC7vz4EQclQCAR/TJeQ4avhOmNYc5
	dAdaj8PuoY9ll0UZEKhmMLUU/O4h/M9rAE9JtHkXUuziYlAzzOKzrZRpe6i9UdNqvGqG2c/0DCO
	v16ep2lrtez1cE2UhjvzU4o9IM7LpcUP1QoA==
X-Received: by 2002:a05:6214:1242:b0:89a:3ad:8bd9 with SMTP id 6a1803df08f44-89a81fe3deamr73175976d6.50.1773440867672;
        Fri, 13 Mar 2026 15:27:47 -0700 (PDT)
Received: from 192-222-50-213.ll.local ([192.222.50.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65bcd06dsm65606006d6.7.2026.03.13.15.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 15:27:47 -0700 (PDT)
From: Jenny Guanni Qu <qguanni@gmail.com>
To: aahringo@redhat.com,
	teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	klaudia@vidocsecurity.com,
	dawid@vidocsecurity.com,
	Jenny Guanni Qu <qguanni@gmail.com>
Subject: [PATCH] dlm: validate message length in receive_rcom_lookup and receive_rcom_names
Date: Fri, 13 Mar 2026 22:27:47 +0000
Message-Id: <20260313222747.4004072-1-qguanni@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

receive_rcom_lookup() and receive_rcom_names() compute a data length
by subtracting sizeof(struct dlm_rcom) from the network-supplied
h_length field. If h_length is smaller than sizeof(struct dlm_rcom),
the subtraction underflows to a negative int. This negative value is
then passed to functions that cast it to size_t, causing massive
out-of-bounds reads.

For example, h_length=16 gives len = 16 - 48 = -32, which when cast
to size_t becomes ~18 exabytes. The subsequent memcpy in
dlm_search_rsb_tree() triggers a slab-out-of-bounds read.

Add checks for negative len/inlen after the computation in both
functions.

The OOB read was confirmed with KASAN using a test module that
reproduces the signed integer underflow and subsequent memcpy pattern.

Fixes: e7fd41792fc0 ("[DLM] The core of the DLM for GFS2/CLVM")
Reported-by: Klaudia Kloc <klaudia@vidocsecurity.com>
Reported-by: Dawid Moczadło <dawid@vidocsecurity.com>
Tested-by: Jenny Guanni Qu <qguanni@gmail.com>
Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
---
 fs/dlm/rcom.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/dlm/rcom.c b/fs/dlm/rcom.c
index be1a71a6303a..406a100a5887 100644
--- a/fs/dlm/rcom.c
+++ b/fs/dlm/rcom.c
@@ -343,6 +343,8 @@ static void receive_rcom_names(struct dlm_ls *ls, const struct dlm_rcom *rc_in,
 	nodeid = le32_to_cpu(rc_in->rc_header.h_nodeid);
 	inlen = le16_to_cpu(rc_in->rc_header.h_length) -
 		sizeof(struct dlm_rcom);
+	if (inlen < 0)
+		return;
 	outlen = DLM_MAX_APP_BUFSIZE - sizeof(struct dlm_rcom);
 
 	error = create_rcom(ls, nodeid, DLM_RCOM_NAMES_REPLY, outlen,
@@ -385,6 +387,9 @@ static void receive_rcom_lookup(struct dlm_ls *ls,
 	int len = le16_to_cpu(rc_in->rc_header.h_length) -
 		sizeof(struct dlm_rcom);
 
+	if (len < 0)
+		return;
+
 	/* Old code would send this special id to trigger a debug dump. */
 	if (rc_in->rc_id == cpu_to_le64(0xFFFFFFFF)) {
 		log_error(ls, "receive_rcom_lookup dump from %d", nodeid);
-- 
2.34.1


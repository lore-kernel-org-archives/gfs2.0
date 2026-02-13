Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C95334D4F5
	for <gfs2@lists.linux.dev>; Fri, 13 Feb 2026 10:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770976865; cv=none; b=oZ+2GtJBzRTxnTUAmoRLJUsBtM3PmiJSJhaG83TlCrK5aTJvDkvkT0Mr7fHk17cpi2GDsSAF4zkNb/RdNTlpEX3E7sDKRIBi2vCZQvf55zR9kYhvQJv5mvEQLJBPUJ6zW1lfJyBbkGl/5HNvj3hfyZlH3zoB4GIvQ26GMGgAZWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770976865; c=relaxed/simple;
	bh=OdRA4DG5OOf+5AnhZfSl4AISrH0uQ/SUrYRi2Dd9XK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bTAXIXTLEMUwyMXyfE7LNQMeceFfCUUm/vC9TlVV2theE4k7gEir8WaaTbd8HG50d0wphPSJgby2POTjF0+9HtT4fNIr2ZC1PuSi0EztaWh6yWdS6QTEEs2LKNv7ZNBKEXo0K5nd8oP4eBiwge+kMKF/gJkiHyMtziPnpRaKXCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aq/614Ol; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aq/614Ol"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2aad9b03745so3893745ad.0
        for <gfs2@lists.linux.dev>; Fri, 13 Feb 2026 02:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770976863; x=1771581663; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mXtU2ce2k7fXz2CpTEP52iCA/+RFfW2aqzRrKiZWDo=;
        b=aq/614OlkY/1NX6AaTkAjz+9r/JAYzNVYBafC90z00P9bpjfjLkd/Gcx7qI8wwYYOa
         E5EMkCTwnHqmPnZfQIBH8WjXNKckwwFe/172zNHyFBw90/RHd4HA47l/xnR98dc6GfIg
         UdnHAF42Sso5XYWSXtCcsqAw2Bf2kfq/f0nT9l1a0i+7EwuPi5Ko/+jOJBaxTByU72Y9
         Qc868uGb6Wx5fud94PkYhPnebC1HBjBlbvkbEFfrsvvuNPKMugHz2FSirVzXid37VRRw
         M6KOymQD5NGTrIvjwQ8wkakEx4AQsWS0PeI6kpw6xPDBcxHQE/GlqzuPHjxIRVrbCko0
         bYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770976863; x=1771581663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1mXtU2ce2k7fXz2CpTEP52iCA/+RFfW2aqzRrKiZWDo=;
        b=VS2P1G/eEyU/5pse4M2j8Vqo6Vf1pfmNJmMYfynLQRX7Vj1sfEnMBrwTHmXSsQoJYe
         vpaEGufAHjsMrAmuJA5bdubcnBzw1CbIjmH3fYMNXXFjtzrJRAXJBEO2Mpgjihx6yMRF
         lFphgR5RnlGm67st13jchNnuWFaJrEYWHVjLakRCXEwIKKusPM0TP4N12dbVfQpVoyUG
         8Ssw/scHnTKdzjilQG3J1YwmHtkznQ+Rzj9cKZ2INokWsmyur3y8899v3YVy5kkVjCrX
         eQZMYyx+EOdLhFUORpDseK58iA6SwmgT5Q6TrWr+KgLZ9nRPZXiS1OaHncvQbXquxMd5
         nVKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXEng91St3l5mWkUxFmKTlQSYSIhGevcQvZwjkZTGUud/gMq/mBevnh+SZNTMww1Nb6mPV@lists.linux.dev
X-Gm-Message-State: AOJu0YyD1h30QY1al5e840j0T1tm1XqvgiLVARoXnpP6ykqEAQBTf9LR
	7gK8DeXtNtw1s43d9EEkegN2EUtTKo/gIxsI0qaBijBJkoXu2lrVtnN7
X-Gm-Gg: AZuq6aJgeuZ5vycp0Y9rQ1PQfDskz/NGWyHGGMgdL1ibjOMYuV7QC2UoYurBgWwRNPe
	Td/CTUADqSUgV05DdBTr6nuxOijZCmMHyxukXSPA8HDoUkmWmhsyOUOSzYJNm0c2rwA47xSXszU
	u1hdHBBSFC2ZIASDQv6F2QjM8c3txp3wXKi39jzZ/vPquuzWo3UXZKU87ga3ujktqx+E3t6RTRP
	kYqAYfrUTT3mOE+VbGYl+FJIZkpjWuvvgU0uy8Et/wUE4SjZRQmluxQKXeOUh8Jz6RlBKBtsKOo
	BTr7Ycn28udp4rKl6LkmF+Z3ALTfa5e0+A0bGbZwi/aSHzmtIsRvUEZv5iV01oq0y0NbekksZ3c
	+6Fhz2Nrt5MNyYopTedSOYYgr8ZH+5KgvK5Y8mTEbF2zyLDNoQRzx6dEXmmv6Ejrf+wE2gENX+n
	h2R7Y2Vzjkkag4JDnB+2iVC6zXM6coVCum2qjqZfrC/g+wV/P3Rw==
X-Received: by 2002:a17:903:3bcf:b0:2aa:e238:e20c with SMTP id d9443c01a7336-2ab4ffa4ecbmr14086605ad.19.1770976863205;
        Fri, 13 Feb 2026 02:01:03 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.214])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab29998c45sm77240755ad.88.2026.02.13.02.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 02:01:02 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+cff8e1b82d7911dd051c@syzkaller.appspotmail.com
Cc: agruenba@redhat.com,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [gfs2?] general protection fault in gfs2_remove_from_journal (2)
Date: Fri, 13 Feb 2026 18:00:58 +0800
Message-Id: <20260213100058.2457892-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6978bb60.050a0220.c9109.001c.GAE@google.com>
References: <6978bb60.050a0220.c9109.001c.GAE@google.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index e4356198d8d8..f459ad89b641 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -350,11 +350,13 @@ void gfs2_remove_from_journal(struct buffer_head *bh, int meta)
 		trace_gfs2_pin(bd, 0);
 		atomic_dec(&sdp->sd_log_pinned);
 		list_del_init(&bd->bd_list);
-		if (meta == REMOVE_META)
-			tr->tr_num_buf_rm++;
-		else
-			tr->tr_num_databuf_rm++;
-		set_bit(TR_TOUCHED, &tr->tr_flags);
+		if (tr) {
+			if (meta == REMOVE_META)
+				tr->tr_num_buf_rm++;
+			else
+				tr->tr_num_databuf_rm++;
+			set_bit(TR_TOUCHED, &tr->tr_flags);
+		}
 		was_pinned = 1;
 		brelse(bh);
 	}

Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4352F5321
	for <gfs2@lists.linux.dev>; Fri, 13 Feb 2026 07:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770968502; cv=none; b=IpwD6DuL9yVlAmOzjGrqxeLo9l++EXguROk6MMEACy5PWkwLgCvBoN14eGQ0TCoDzRazBmBcM7ms7jzjwmvlLxuGkHBnaXwomI3I+KXURIJ1wHW304R4Gt0q4cm0Iv0Bb6VME40nVn4Xw79/cb3LfUW+Zf1ahsh5q2qYg6f9rnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770968502; c=relaxed/simple;
	bh=z54r9BiaBtrqmr0blO/Ckj//Ge6xUZCgVsY4BmUDmdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b6KclpFtluCsKWyE7TjTXHkoOtWTZcHERm88HpTtgfMDWyKZLCvRyTNjTqxKhB8DPAg6kbN5ulZjv31DLy1siPUaR7siQ7P20gSiJ68srJe93UHhmDo4tJ/mL4H/gNpWdehi4gS+iKT0O86FyYgsgwE1ubZ/NQtzq4yX4z6JgBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFtaTC5u; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFtaTC5u"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2ab3b0e49a8so3008625ad.0
        for <gfs2@lists.linux.dev>; Thu, 12 Feb 2026 23:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770968501; x=1771573301; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woL8X4enbfD6EKj11BHDMpTNsFBM7WNAUYZ7xSdzqf0=;
        b=UFtaTC5u4m5dLwvwaWc+a2mQkrkMX7u6dH8xATQGXCwlcgEbijClo+rFMp3tWNfpOk
         nE5XBwjBhfo99Lu2qA/qq/+VWVYs2b0eKsC/uEi8HrQfMF0QGKvv6uw5kmu9zqn7l6fN
         i32tPMNP6JncPRG0wQhtdqQkFyOls2aIh5HxiGX1uChkPErm6xTclNdkdxfk1d4drawU
         L83leACImFuMqY4B67uFJRNIL/AD2VVcwln2eMM5pjarERnkK+LH90QY+L16RIb+gQOH
         ISz5gqp3Z/JZ51mdEVwFuG7fza+XUPAppu+Jz44OuigbRGkWKuOBkmbcTdUkOIKBbW/y
         dQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770968501; x=1771573301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=woL8X4enbfD6EKj11BHDMpTNsFBM7WNAUYZ7xSdzqf0=;
        b=t3Pc90hIfrCLu583mX1orCB1zXm25wYIDNo8MRMwhaMynBNoLVhzYzfTkeyxwsfphP
         wZwUlJFkpZBU50P+GVCj76WnFWkoDxAwCrtu2EXH/pDdWgyrwmzv8vfRgpYK1af91FD/
         GQnBadY4r8e7XLGENKA8nkdcQV5hGVSbwS0NBSAnA4cZxDi6PSndjEca+YLoqEIb1jm3
         vYHG/GGXGw/18h+vU2prF6P+yKx8Vx+t+220T8bOyFzeIDlQ8tgT2vAek8dX7Sc2WTYR
         2qgbpcg3zq4Zhz+9EQJ+9uAIQbrGaw8Dewi8B+0rfVj/V/da/M3PGPaxOgbGnjph7ykJ
         R75g==
X-Forwarded-Encrypted: i=1; AJvYcCXPpTlsTvj0cwikFKvqKc5XVU6ScM2iNJoE4psplshNvmESLeWrZ0QZUIG2aPLJQG92FFjh@lists.linux.dev
X-Gm-Message-State: AOJu0Yxi8tC0PSU6Zi+g9g1Xq7ZPqXlUjmM5zQJ3H07G3W5sRoOg3W7y
	pQ6W82Iu9MsoUmpEYsVSGJZroe8C2O/yH1XHifbN5Pi1CvBzc2negsbI
X-Gm-Gg: AZuq6aLd8gTOGSGnBK2a2jT03SJp2ci5QO+kvLlhrqwzJsTNOAEjeDqhX7ytXcyTeuH
	ad9GG9q/V068Pqn/1uMUkxHkM32P4Wp9jdyOtxBzZXQ/Z8jRm7+t7QWVjPRbS73n7aPxNAGY4NN
	7tq+w+gEHJOSAuQcjbXfjs1SLJnNc29OLwkB1KaZ9bnVpG/zqHd2wd97YgJeyS8K5cKa53WhcNF
	B9TrBeXoBnpgZr9ANtEvq+aNs5Cq5xL/Ccx4NhZhfeUNtvDEYH+ITjORsrvbuIePgD1zjcJMoFy
	m+3FBney3P7NljglNgbNPC4Bvzh3CjM7voJYGoeARe8uUc26vpdq9cpgbWA0uMKfaj+CLjffKoB
	xeSEXIIldqTS02vd+l1L09yL0byeTcsx0duQtwqZIcalCpwVcWfBPotHoV7FLUX1L2ogoQDaIrQ
	HlRX33Zff98f+qJwlEtttIWjs01qngWIXVJvP202i0CNsYGK23hA==
X-Received: by 2002:a17:902:fc45:b0:2a9:4316:7557 with SMTP id d9443c01a7336-2ab5057c597mr9850765ad.33.1770968500705;
        Thu, 12 Feb 2026 23:41:40 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.214])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2986efa0sm70939225ad.32.2026.02.12.23.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 23:41:40 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+cff8e1b82d7911dd051c@syzkaller.appspotmail.com
Cc: agruenba@redhat.com,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [gfs2?] general protection fault in gfs2_remove_from_journal (2)
Date: Fri, 13 Feb 2026 15:41:35 +0800
Message-Id: <20260213074135.2389369-1-wangqing7171@gmail.com>
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
index e4356198d8d8..8c3d0a83cb98 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -346,16 +346,16 @@ void gfs2_remove_from_journal(struct buffer_head *bh, int meta)
 	struct gfs2_trans *tr = current->journal_info;
 	int was_pinned = 0;
 
-	if (test_clear_buffer_pinned(bh)) {
-		trace_gfs2_pin(bd, 0);
-		atomic_dec(&sdp->sd_log_pinned);
-		list_del_init(&bd->bd_list);
-		if (meta == REMOVE_META)
-			tr->tr_num_buf_rm++;
-		else
-			tr->tr_num_databuf_rm++;
-		set_bit(TR_TOUCHED, &tr->tr_flags);
-		was_pinned = 1;
+	if (test_clear_buffer_pinned(bh) && bd) {
+			trace_gfs2_pin(bd, 0);
+			atomic_dec(&sdp->sd_log_pinned);
+			list_del_init(&bd->bd_list);
+			if (meta == REMOVE_META)
+				tr->tr_num_buf_rm++;
+			else
+				tr->tr_num_databuf_rm++;
+			set_bit(TR_TOUCHED, &tr->tr_flags);
+			was_pinned = 1;
 		brelse(bh);
 	}
 	if (bd) {

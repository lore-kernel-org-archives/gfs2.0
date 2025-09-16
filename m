Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B85C31BCB6
	for <gfs2@lists.linux.dev>; Tue, 16 Sep 2025 21:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758057118; cv=none; b=hmYWRP7oJQJSbWRn7e4YhsWqrjpyg+m8aZsHb1xJ3ydGKbZc1StGOSTugliFyMFSwFFSh03ptC9WpYo+4eZpy1krb87RVwCWYLiWZiFLDQQUQkNuZuS+irMKATdzak5O5fHkNsguSKFsX2eoHo2HAJJlvXS+GCxo4UxPAZeCZts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758057118; c=relaxed/simple;
	bh=/X1+d4fPZYg5WlY3eWsxQCEy33DoviSKQ12bu1Rup9s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qjE7ZHqt3qCfvnFPBis0qvZuSRRCeXxqIf1pfgP0tfvQLf+itodGaq7uRZYWhlApY0irDTKgIIBAIpxzg1jy0X5KQHQ6pS/8KZWfAgtEC8L1KXMMeTCJGdlZ6QBLH1etAmdV5HXYgfBngOyqi8bP8/pEcZttf1jHlM64O9vgsJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GiIe7e4E; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiIe7e4E"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b5488c409d1so3937376a12.1
        for <gfs2@lists.linux.dev>; Tue, 16 Sep 2025 14:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758057116; x=1758661916; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W+ixVYr8upbpH7CrsttocUgzYRa/3ZZldB6b9tE52LA=;
        b=GiIe7e4EwyTs2+sObk69XFLBWXz8J+20qu9RXfZkemeuHMi7OyolXdGyAZdFFRU8B8
         24Q4gk3h5PuKaSFY6Fl2FTTEcTP7HS6sb1M7E/8ME6brJ13A5r137cmUEP7xxart7xTc
         QZyUi/46Wrsq3fDLe8TkOYZi7DSh4ZLryCuSe5Sj/pqMTFctJDpPn+HRiG2TT+ZbHKOH
         x6X3pSOj/fxvfVfPDQHnHrNea7l2UZSEbSGc8yjnge+4Nl6onervdkr7MW30X3u0h4oQ
         VLKJkmi92+xDClR5BZPHya4iGGtIuM/mpteXrwGlirEs6gEWQAUKj1XUw4AYfL5ElRni
         8K3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758057116; x=1758661916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W+ixVYr8upbpH7CrsttocUgzYRa/3ZZldB6b9tE52LA=;
        b=k4OJ8Okath6ZWHjBEOUaImqbZDUAY+TVl4+k7rELXeqXo/U3NtBzhEKYApK0RUxZzs
         k6KPd8ldpgKQBTm1LprimqT9DshfRGjwo9/dQkbPzE3/YL1hSq353lC9rmcj7/9BgYqA
         yp9T9RzA9KI4yKq0nGZJaICHL2CiLm4bDBv64nSJGU+wvxMwf7NPj+ElZJOdYM5k3gXg
         5CM3TG/Ih2tt9L4U622vmj4E18XSTP+PaDLKs0cDYFNe/fFgmGkfTLoZh2DxY2+cY8h8
         y+jjWFoZg50FijDkW+tOZhK9k/Aiv6P307qE+ZAPgpoZgcn0LbKdD48tq4TFg13t5tJn
         YvYg==
X-Gm-Message-State: AOJu0YxNapSd6hjwG/OAHRr6Bsir2SoaQnEsXMDreQxOOjolH0wsVgEe
	yOt85l4s/RzObFevjEKlA9VWAY9tj71mwg0d0N42cC06+8Sf/4pXOfvX
X-Gm-Gg: ASbGnctCYI2fnrOOB4Fz9B4fYiYLKC8FAWRu/vxLauUY7vaNwXTnskPzsYSITijCQfX
	8WdiqUnOR4JJr4r/CZIGbZShaNHx/gR7zsZL8F8tvRnhpQl0zeFVySHXBVSg3eS6Q5vnTHF3R6a
	hbBLwgKtsiIF3Wvi9cNv1LgB87TPOyzU5sI5kHa1xsPLcXukLZNM7kvFsXkbXzWP5qbNC99A0G9
	Ue5wxRsGmNGcy0fj5lfEWnpI9okkshnNkMRIHWce9ljJHogXlXyq4AZjyiWUrwwR3a2cJsq14/f
	5mLlgq/EudHDznCEGhwSMsdpa8lACIterS940Q51IzlWjxGJJSGBrwe83I4mGwE7fs87K/HmgHb
	jViJq1lAUPGadKplaQUO4H3uIDIPCOvNxyHpKLjmoT7/cqLCFb0MFRWPIp+PtCfTnNLyxSn5vF7
	rPsZfGgYArcRLUpqEeZnG3TQHOgA==
X-Google-Smtp-Source: AGHT+IGco/HQJ2rpL6BeHKbb2Of3KcipzzfaGC3skxSIK0EMw9tQi0DGONyvjGFnhtZVrjzGBluKKg==
X-Received: by 2002:a17:903:1b4c:b0:24b:640:ab6d with SMTP id d9443c01a7336-25d26e4872dmr240903115ad.49.1758057116364;
        Tue, 16 Sep 2025 14:11:56 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a36c78b5sm15524738a12.21.2025.09.16.14.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:11:55 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>,
	syzbot+fa7122891ab9e0bbc6a7@syzkaller.appspotmail.com
Subject: [PATCH] gfs2: avoid %pS in pr_err() fallback to prevent vsnprintf crash
Date: Tue, 16 Sep 2025 21:11:08 +0000
Message-Id: <20250916211108.1243390-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While debugging a syzbot report, I found that the %pS format in
dump_holder() can trigger a crash when we end up in the pr_err()
fallback path. This happens because %pS goes through symbol resolution
inside vsnprintf, and in this case that isn’t always safe.

I switched the seq_file case to continue using %pS, since it is useful
there, but changed the pr_err() path to use %p instead. This way we
still print a valid pointer address without risking a kernel oops from
within printk itself. The idea is to keep the debugging value but make
it more robust.

Fixes: 590b221ed425 ("Add linux-next specific files for 20250912")
Reported-by: syzbot+fa7122891ab9e0bbc6a7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fa7122891ab9e0bbc6a7

Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 fs/gfs2/glock.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index b677c0e6b9ab..903844a6ebbc 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2284,10 +2284,18 @@ static void dump_holder(struct seq_file *seq, const struct gfs2_holder *gh,
 		if (gh_owner)
 			comm = gh_owner->comm;
 	}
-	gfs2_print_dbg(seq, "%s H: s:%s f:%s e:%d p:%ld [%s] %pS\n",
-		       fs_id_buf, state2str(gh->gh_state),
-		       hflags2str(flags_buf, gh->gh_flags, gh->gh_iflags),
-		       gh->gh_error, (long)owner_pid, comm, (void *)gh->gh_ip);
+	if (seq) {
+		gfs2_print_dbg(seq, "%s H: s:%s f:%s e:%d p:%ld [%s] %pS\n",
+			fs_id_buf, state2str(gh->gh_state),
+			hflags2str(flags_buf, gh->gh_flags, gh->gh_iflags),
+			gh->gh_error, (long)owner_pid, comm, (void *)gh->gh_ip);
+	} else {
+		gfs2_print_dbg(seq, "%s H: s:%s f:%s e:%d p:%ld [%s] %p\n",
+			fs_id_buf, state2str(gh->gh_state),
+			hflags2str(flags_buf, gh->gh_flags, gh->gh_iflags),
+			gh->gh_error, (long)owner_pid, comm,
+			(void *)gh->gh_ip);
+	}
 	rcu_read_unlock();
 }
 
-- 
2.34.1


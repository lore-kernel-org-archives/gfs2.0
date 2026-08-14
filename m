Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF4427F4F5
	for <gfs2@lists.linux.dev>; Fri, 14 Aug 2026 02:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786675814; cv=none; b=ESHI3kL4NJuih0dwqEYIqPDo2uba4LYPWadISTe1s4p3kln5eLjwgejNAFHOyjHLzLcrE9jN/5UftGLaCmI8MiKI/flvcXtu/iauhc/1Di+B+lajvhm6/LbHi5faOSZfc2GjUUXGhuOSksLutTDiSPlng/RSkMnzIGe3UC+E3pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786675814; c=relaxed/simple;
	bh=eR3jUjuO1Za+ASq0DovLqz8rhT6iu8+6w/M182r1Rhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lzvhThsUreTT3bojtK4NQ3Bw9XF7zT5OZuIkuHXOck3b3Sa5TlOLnknm9lslFgoGpeJ62B1f9qVzy9xWwEDELOmBurVCMUZSda4dBoMypwPzTaFS1GWO513Ff0Im0Nbu6v33PrtistuQLsm4ihVSz/QzH4i5uLbYUbQyOyqLCYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qICH6FeF; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qICH6FeF"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8efbafa1bacso2861726d6.1
        for <gfs2@lists.linux.dev>; Thu, 13 Aug 2026 19:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786675812; x=1787280612; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LRwc7YlERJIorjY1Ibj5XixURn1upo7Jd/C+eZrxYAo=;
        b=qICH6FeFHJoVjIE1GaZ3gTh4FXjM8hX5cat4+JfXkiMVBxPc5exSDdOAg5rtOVgSEj
         a4CT/tBH39Ohb0dedloa7EsRs1mx4H8hxF8detohMx7Z4eZ+6u28lufBlg4a+0FCxDkY
         q1uEOSYlBrNLKioUhOQ0LZw2SCx094wn2llbyeM7T6LWMnJjc4nOisWlajm0LSLqgS+m
         H4uap4odB355Lo9Fues+tInKd5zyRpw5eJJT77axStd17KyMKBym8zlqHfIAJCjpC1HX
         EbNkDPoH1yGFM6p8rWTDOoWkMJteNJN5BhOjTEJu4EoErr8imPQRt04LvsUwMyS8WAnT
         xI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786675812; x=1787280612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LRwc7YlERJIorjY1Ibj5XixURn1upo7Jd/C+eZrxYAo=;
        b=Fdkl7Bq1mmloEh6R7ZTtPWjSLZnwAnSrYTjm2yYYEQ4A/Xi63TlVMvUt88pj/i+GA9
         8ci1qZsjjPXL6p2vBdmCdonofP0QdA+UrWmS14v9qsUR1kTyk3jCI1mxqeJKJmVbAGkF
         XCHhR8MqAnZOy5dwtaa5jot4piXLe94KHqy/iq+NlVBdJtbs4m+xpXjowX5eAUIwJHd2
         Vo5OZMrtohrgCn38s5RKsB8zHE28ARjjcEYPX7aH2CTHTULLoQkSvSDrsLAbY+hrv7Ho
         nAj9XhubD8MlpD4ZcZf91KBmjWB6WWcLR0c0nLqtTQCcQfe6cr8YkekagsHfJYEgMsUr
         stZg==
X-Gm-Message-State: AOJu0YxKsHM2stBYtodmJeZQmes3HSssWMZpmHdgZoeDRrkjNmwHie4S
	kLl4/Z5mgLLPDP4iWNkmvfA8may1Ieu/zhYbDE3nJpAlHWbmStjzUh97
X-Gm-Gg: AR+sD11/PVCX54gJro17PfAH4590hgBz2LLDLIThAeSsx9aC20iGm7O+3jy3xV0Oe6+
	+vQkrSuIvbN4RrYaEsftVS9Ty8weTb3LrXildEh+o5Kib49L7aJjRigVLE8dusJOG3jZ+p3/rJi
	X8cPSevWhybHcsg7P5HjmH3cpD09AIFeTK65lghlVMhp8wzd2pe6pCHWrjpPr7NR48VGfvOCT/I
	4mtNf75BpquKQfjmBuuD0mb5U2xyK6rHOVzbc+F2qBwNpmqPs5MyQpBHn0UnvFk5uqoobqN3VJJ
	6TndIHlXcbniOET7ygZpOSi4heAY3cJDjNgdbd6iZ2CVgDmmWvRL69lOqzZzhLjTZIPakt63+XI
	YQlC35mA/yI177iFJYyrFn6gk+vCSDh1Lw59PHHWQi0RTcgd6JlL58oRLNmQajkFJ8VbwrIszxo
	AZHx2SD6rNbnARW+QYce8Rlc9yOkJHoOsJxq8dIEQQysfb+GvtnSUj3XXyyPZOWWx90WKW+76rG
	V36Q9ctNRfP5M8apg==
X-Received: by 2002:a05:6214:5402:b0:8ef:aad6:dada with SMTP id 6a1803df08f44-90a91d4a10fmr34127936d6.20.1786675811868;
        Thu, 13 Aug 2026 19:50:11 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a935a2bf4sm4949026d6.49.2026.08.13.19.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 19:50:11 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Subject: [PATCH] gfs2: Fix use-after-free in glockfd iterator
Date: Thu, 13 Aug 2026 22:49:33 -0400
Message-ID: <20260814024933.2791706-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gfs2_glockfd_seq_stop() drops the file and task references held by
the iterator, but leaves both pointers unchanged. seq_file can invoke the
iterator again after stop, for example after a bounded read followed by a
rewind.

The next start then drops the stale task reference again in
gfs2_glockfd_next_task(), and can similarly drop the stale file reference
in gfs2_glockfd_next_file(). A duplicate task put can queue the task_struct
for RCU freeing before fget_task_next() uses it.

Clear both pointers when releasing their references so later iterator
callbacks cannot put them again.

Fixes: 4480c27ca3ea ("gfs2: Add glockfd debugfs file")
Cc: stable@vger.kernel.org
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 fs/gfs2/glock.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index b8a144d3a73b..283c5701dc1a 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2734,10 +2734,14 @@ static void gfs2_glockfd_seq_stop(struct seq_file *seq, void *iter_ptr)
 {
 	struct gfs2_glockfd_iter *i = seq->private;
 
-	if (i->file)
+	if (i->file) {
 		fput(i->file);
-	if (i->task)
+		i->file = NULL;
+	}
+	if (i->task) {
 		put_task_struct(i->task);
+		i->task = NULL;
+	}
 }
 
 static void gfs2_glockfd_seq_show_flock(struct seq_file *seq,
-- 
2.43.0


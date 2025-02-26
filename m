Received: from valentin-vidic.from.hr (valentin-vidic.from.hr [116.203.65.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F77275600
	for <gfs2@lists.linux.dev>; Wed, 26 Feb 2025 20:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.65.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740602297; cv=none; b=mHCR5ZwoxlIBrZHs69kboEHMxo0sRWZpiwZBde6II4uTow+whmUTTnDluXjRg/lDLgAoDNmjNDgXFC5OsIVQkSIoUr70VbRHxmUYx0us94XfmnKGgfqyTwDWsMMPAYhIG8NT32kE16Pizv7gEUtMH2KG97bwjOnX3wU3YHcXLRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740602297; c=relaxed/simple;
	bh=GMTaZc48PKwKMuL1zdX4JuNhOwQYnqmtYnJ4ruDRZHg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xq/Al6+Ig+QRT6+FCAIViPR7s4a2jZl8wgrBnvHRf5G/27jXgGRm3NeYwLj0f1VzyHbfB7pUvw9dWK8G+WyYE0kRTQiB43wDfu7EtyzHxs9QPTWehEf05rkZQR3YMn4AxyyzVbLvZc+b7LGP7wr/Gk3HkQ6qMntvBHXAn5+dE3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=valentin-vidic.from.hr; dkim=pass (4096-bit key) header.d=debian.org header.i=@debian.org header.b=CM79Nsdt; arc=none smtp.client-ip=116.203.65.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentin-vidic.from.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=debian.org header.i=@debian.org header.b="CM79Nsdt"
X-Virus-Scanned: Debian amavis at valentin-vidic.from.hr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=debian.org;
	s=2020.vvidic.user; t=1740601819;
	bh=GMTaZc48PKwKMuL1zdX4JuNhOwQYnqmtYnJ4ruDRZHg=;
	h=From:To:Cc:Subject:Date:From;
	b=CM79Nsdt8PuM4V+lVXgMXP+FeubYnLFPjGLfeKto2HEA7oVkzKpo8Q+stfWY84BZU
	 czm6229Rsdep0DkJ06fIm0d4m40TZyDa8StB8H4xy+jexYaiQDbuxIIJ6jkNM/RWEf
	 WTMRWfY8zGYhbr0j8RnR384UnzolgTr3uwqQqU7x8qfODPAtGsVeBal60OeuO/SNTt
	 LioL3B2sCOqCyhU1VEEfEDflLd3xzMt9XSWtpSpHBWrdcXwUCSBbwsl4v033MsjHc9
	 Xx9VG0cI+oDETYg0hfdtmyY4mOQWCoO3IqkRRaZS2PTGUefqCIYee3XfA4CaQAJbGR
	 A3NVmzKmXhFbqn3oH5x8WQggxvd7FUQ5o6qWCnhRmIUIC6aQNUOLz9RNDGgLb5rVOz
	 eCIanPWyUk/pzPWNGFfxl5d5tVPVO+gm3Pj+DQJ6VL2cAJn3180Cfb90yuxXUwh3SD
	 WYbxFqHhw8HFBsM/oWOInu1zKbaFyx1ko1eHSFUKVlXD93i1ntofEFwRBrEcCf5zs/
	 2jHRSOjWH+3ItONoDZjfr8p/JwXDAdni6pwtVPpTqxTfmnw64YjzyaM0ehfxk7pY3N
	 QBG86YnDf2sCVzg8TPxB13QT4HvVEKAYnQ7H91oZbXQO/FqJ3My8suS0t60ho47SHS
	 xtdp/5w7J9TQmu00zLENdpHk=
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
	id 2339C30A01; Wed, 26 Feb 2025 21:30:19 +0100 (CET)
From: Valentin Vidic <vvidic@debian.org>
To: gfs2@lists.linux.dev
Cc: Valentin Vidic <vvidic@debian.org>
Subject: [PATCH] gfs2_edit.8: Fix man page warning
Date: Wed, 26 Feb 2025 21:29:55 +0100
Message-Id: <20250226202955.1936682-1-vvidic@debian.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W: gfs2-utils: groff-message troff:<standard input>:124: warning: cannot
select font 's' [usr/share/man/man8/gfs2_edit.8.gz:1]
---
 gfs2/man/gfs2_edit.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gfs2/man/gfs2_edit.8 b/gfs2/man/gfs2_edit.8
index 1a5ccacc..1e9a11c2 100644
--- a/gfs2/man/gfs2_edit.8
+++ b/gfs2/man/gfs2_edit.8
@@ -121,7 +121,7 @@ for example, to artificially change the di_size field for an inode
 in order to test fsck.gfs2's ability to detect and fix the problem.
 
 .TP
-\fB-s\fs [\fIstructure\fR | \fIblock\fR]
+\fB-s\fP [\fIstructure\fR | \fIblock\fR]
 Specify a starting block for interactive mode.  Any of the well-known
 locations found in the -p option may be specified.  If you want to start
 on a particular resource group, specify it in quotes, e.g. -s "rg 3"
-- 
2.39.5


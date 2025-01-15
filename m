Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17704240236;
	Wed, 15 Jan 2025 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736934438; cv=none; b=gv/D7Xvc8DJV1iNw7iK9yZnSHF9ohU+Vl5jKqcKz2Opa+q2gqRBsdcD4PM4+KDJOzKGryGUNtxkdSSTInRV9Ng/a7wy6c29961Dxj2fzrAZ73V/heKbLnglUk9R7Rid6CRuign+PGX19V2brWeM8mU9o4w5QSi6DKM8bB3VgUo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736934438; c=relaxed/simple;
	bh=IAXBC4NsvtqDtM3nwM97Eq8GWUMsR+akBkMhgU3Bef0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYAXjMjatxGqApt6RMDz/+2Ogu8/ai6QVlCnN+QUhchMEp3+mMYdb1f2XSOQGxbTnBVRTMrrgVAo8k635fs/UNWt2q8yZX5XCJ+abO7xpA/p18ekIFLA/CaYkBlNMfQo3j7deaYROZXqRCZuPKkDRa+lZCOosHpJIvJG5JDGagc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4iDLRR/G; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4iDLRR/G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ohLiAdYSUOhMrwWdrrwT+bNxgt2i6mB7od5qyPwAJhc=; b=4iDLRR/GW8kspoqoiyDTuPao8Y
	WIozGp4pjDbQ2H8yjOVwxYmknSOFPaJ6ob/dBmRjS+k4aJQN1oK2txhY6VdW6M/RMF3WaxJQKbBii
	QQYfCRR6Wb+w1z48a6o+zs8H7qyzlKg5uo/Zy0Z0FRzKH5ZcMHnRDfGL0qQbGLA9MMdc9q68b6jlP
	vrcMY1G+9FtoFApiVT/H0yS0jqe4FeLLN4u7HANOflLA/4WWISoK18iZltCo4B0f9Jb2YpxSiTzyA
	zn9IAV1dhLtlogt3nrNBCpTqzClssInH/vQWcUccM3Ph9cv0JnPWx1G0bwYIAkwmp3rVMjBqonbz9
	6OdXLL3g==;
Received: from 2a02-8389-2341-5b80-7ef2-fcbf-2bb2-bbdf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:7ef2:fcbf:2bb2:bbdf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tXzzX-0000000BOfO-3ZBc;
	Wed, 15 Jan 2025 09:47:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	gfs2@lists.linux.dev
Subject: [PATCH 4/8] lockref: drop superfluous externs
Date: Wed, 15 Jan 2025 10:46:40 +0100
Message-ID: <20250115094702.504610-5-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250115094702.504610-1-hch@lst.de>
References: <20250115094702.504610-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Drop the superfluous externs from the remaining prototypes in lockref.h.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/lockref.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/lockref.h b/include/linux/lockref.h
index 3d770e1bdbad..f821f46e9fb4 100644
--- a/include/linux/lockref.h
+++ b/include/linux/lockref.h
@@ -34,12 +34,12 @@ struct lockref {
 	};
 };
 
-extern void lockref_get(struct lockref *);
-extern int lockref_put_return(struct lockref *);
+void lockref_get(struct lockref *lockref);
+int lockref_put_return(struct lockref *lockref);
 bool lockref_get_not_zero(struct lockref *lockref);
 bool lockref_put_or_lock(struct lockref *lockref);
 
-extern void lockref_mark_dead(struct lockref *);
+void lockref_mark_dead(struct lockref *lockref);
 bool lockref_get_not_dead(struct lockref *lockref);
 
 /* Must be called under spinlock for reliable results */
-- 
2.45.2


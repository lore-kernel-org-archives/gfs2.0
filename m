Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B928218C031
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 00:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757551489; cv=none; b=H/iPHM65/vDfIBdJwkSxJYJcRdIsgC47MVuDz1lLkcVh1HBWKJGVJ3h5y9uIwgDUJuWMESqbFmSjf7qJzoZMYLwO/UJ+bWYm3QJDlywZIBRoPOZEUpMFRL96RdfvOoltzH7K2NkGgrKI5bQqgXUAs2hglKh65+JLcNhIWbwkOUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757551489; c=relaxed/simple;
	bh=HCW13knBhT7RFy7HDKQQcC+dfTeWFpruSeLFZ+02xhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fo4mZ7iGCzLjAWe+nLP4Eyz6K1ANh9be9lSJ483HSn7fU9oG1sKp3jV2ig8GGaPJbylhqcliJJR9tjO9389HYWmtP+O34jrdVwmRHyhu1LMGCE6XFSIHVU6TEn6wwmVyBsM/MhcJq6Iix3bEbKiTIP5xR5wLxzqX3Me7W+WqKgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXPh6wRb; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXPh6wRb"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-329e1c8e079so99192a91.2
        for <gfs2@lists.linux.dev>; Wed, 10 Sep 2025 17:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757551487; x=1758156287; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BpySo3NLnF3NQPlDF6BjVjWyIhuBi9Js7xK/Y+fCdkg=;
        b=gXPh6wRbiz1qXPz6lsR3As5nv1blFdMq7XbgGsvAEfPYJf16JatOMPkwbET/FBhR87
         7+7SE1o8UWbP545qFqT6qLJPmx88/hStk0YsszCUs7GnwHNJgRRxZvybXjGnABUfOeKY
         GFUBZn8AZpjCjoAg75bqM3CMogOtP6FDTm6WwD5VkHeHVamJgoOM/f5rdgSFGNuz7Z1I
         CnNTOSS7iVsr3GqsaLQxDNyso+kdyf7j+5ZMz+8ch/F/J9YN1m/Xzwnmx1YvwBEAQVCy
         Y4vGe9Y6eUTDd7zYnxgSu3v9Bti8GbOptgSjCRP6p33lUbqgVzdEF/7L1RhWb8viFSrY
         LfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757551487; x=1758156287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BpySo3NLnF3NQPlDF6BjVjWyIhuBi9Js7xK/Y+fCdkg=;
        b=ipM98jv5H9KSPkKKFiJ75BijB9Rti2XSgtxILtMpN9zrmnZYM5lqplX2DJ/st7YJpy
         N7P0SUo75Xt5F6H3wgRYtf85S7/eJVSVlyCFMQUMB5PqE37rL1sjmHhfsM949LTC+vhT
         Zx+nVPNrWFWmxb0yBn17kTKUxlE/vuZo4baIX5CanOf+trOQV/O1uSGlMYNbaT6ZM+4W
         4lWZQQ7YV58BhZo0eoSC4xoITe+Czrs4+tyZZI4zSlMtuseIUgAweHSXJXI8LAQ7Q0mN
         +ZBWmxyX8Cv2rcrRNwOFqjnfo3WQSd0gODEK1TqeEoP2a8BgUYQhODByp5DmtZggnOeT
         /5IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBmmQCeFl2optGqIsAf4qmAuyP1sqckmnpNHytwMJpqdUrMagRH0Agx11WJzwn1YL4y6lP@lists.linux.dev
X-Gm-Message-State: AOJu0YzI4MZ6cO/und2bxomK9rDi1ZS+YSI3zfhE10uQim3ZBOeqpZPw
	ApsYBVmRmroDDGq6uwa5Pi+LEpkDm8JWmirsBf60eDzzHL9oBtSVwKUJ
X-Gm-Gg: ASbGncsQ+HXQi6sXDYnEENXvwJ//1EUnL0r2TWn/q/A9ieUvn5GPAsiV0O1wkJ4gCrb
	+Ybq3OqAqQE4oetzjsQvWB656a/TeuyV3Oq6R2xnsUTmbvB0ypR8pgrbcoP6jiLARqFWpfYqUI5
	wFgyXnHSb4DOpqCL8HXbbgSoSN7d59amJFNFWu0Ii/H1Gc9rRehHSBGTXaAINJBL84dxU339lKy
	Q0pkhdp+rOc55odDiCvJvqIB1ll1XEF+uRb2DhxmUkChbdXEpdYFm11/EDrhhOG2tBRT1HV+94z
	IPGAnJXxA3kzy1rjuKM0DtTK1Hbd1727VGmqKUXbRQN3eid8f5/YGrX/9jfTWRQQx7eTarzpVQ8
	rpIlD6R+wcd48BhIOFBQlBZtyNI7QXqbRpvM5
X-Google-Smtp-Source: AGHT+IHjmPZWDl9vb0uIHl2eRmaTWkqg9sSefNMn2g+fVPHeFXt0Fk772YcKBqrgPaf3/cb0zvSmbQ==
X-Received: by 2002:a17:90b:1f8c:b0:32b:9bec:158f with SMTP id 98e67ed59e1d1-32d43fc44abmr20864742a91.29.1757551486936;
        Wed, 10 Sep 2025 17:44:46 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd54e6e0csm293105a91.0.2025.09.10.17.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 17:44:46 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 62C4B420A6BE; Thu, 11 Sep 2025 07:44:43 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux GFS2 <gfs2@lists.linux.dev>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	James Morse <james.morse@arm.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4] Documentation: gfs2: Consolidate GFS2 docs into its own subdirectory
Date: Thu, 11 Sep 2025 07:44:17 +0700
Message-ID: <20250911004416.8663-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3561; i=bagasdotme@gmail.com; h=from:subject; bh=HCW13knBhT7RFy7HDKQQcC+dfTeWFpruSeLFZ+02xhI=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBmHpM7/Ed5mkx2surRfe7aD0Ioqxcnzb5/Zyl/q/P/4k usswg3MHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZjI1NWMDFMfeuy2nlZv5LZS XGmKxtV7fKyG5l9eJyekqLlwirLnFTIy/GLZd+3tzgDx2f6XF5TlNE93WcPp7bND8vP8nMP5ZfL ujAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Documentation for GFS2 is scattered in three docs that are in
Documentation/filesystems/ directory. As these docs are standing out as
a group, move them into separate gfs2/ subdirectory.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
Changes since v3 [1]:

  * Merge original gfs2.rst contents into index page (Jon)

[1]: https://lore.kernel.org/linux-doc/20250909014606.15043-1-bagasdotme@gmail.com/

 .../filesystems/{gfs2-glocks.rst => gfs2/glocks.rst} |  0
 .../filesystems/{gfs2.rst => gfs2/index.rst}         | 12 ++++++++++++
 .../{gfs2-uevents.rst => gfs2/uevents.rst}           |  0
 Documentation/filesystems/index.rst                  |  4 +---
 MAINTAINERS                                          |  2 +-
 5 files changed, 14 insertions(+), 4 deletions(-)
 rename Documentation/filesystems/{gfs2-glocks.rst => gfs2/glocks.rst} (100%)
 rename Documentation/filesystems/{gfs2.rst => gfs2/index.rst} (94%)
 rename Documentation/filesystems/{gfs2-uevents.rst => gfs2/uevents.rst} (100%)

diff --git a/Documentation/filesystems/gfs2-glocks.rst b/Documentation/filesystems/gfs2/glocks.rst
similarity index 100%
rename from Documentation/filesystems/gfs2-glocks.rst
rename to Documentation/filesystems/gfs2/glocks.rst
diff --git a/Documentation/filesystems/gfs2.rst b/Documentation/filesystems/gfs2/index.rst
similarity index 94%
rename from Documentation/filesystems/gfs2.rst
rename to Documentation/filesystems/gfs2/index.rst
index 1bc48a13430c1c..e5e19540356138 100644
--- a/Documentation/filesystems/gfs2.rst
+++ b/Documentation/filesystems/gfs2/index.rst
@@ -4,6 +4,9 @@
 Global File System 2
 ====================
 
+Overview
+========
+
 GFS2 is a cluster file system. It allows a cluster of computers to
 simultaneously use a block device that is shared between them (with FC,
 iSCSI, NBD, etc).  GFS2 reads and writes to the block device like a local
@@ -50,3 +53,12 @@ The following man pages are available from gfs2-utils:
   gfs2_convert		to convert a gfs filesystem to GFS2 in-place
   mkfs.gfs2		to make a filesystem
   ============		=============================================
+
+Implementation Notes
+====================
+
+.. toctree::
+   :maxdepth: 1
+
+   glocks
+   uevents
diff --git a/Documentation/filesystems/gfs2-uevents.rst b/Documentation/filesystems/gfs2/uevents.rst
similarity index 100%
rename from Documentation/filesystems/gfs2-uevents.rst
rename to Documentation/filesystems/gfs2/uevents.rst
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 11a599387266a4..897eabaa30d65d 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -90,9 +90,7 @@ Documentation for filesystem implementations.
    ext3
    ext4/index
    f2fs
-   gfs2
-   gfs2-uevents
-   gfs2-glocks
+   gfs2/index
    hfs
    hfsplus
    hpfs
diff --git a/MAINTAINERS b/MAINTAINERS
index ef87548b8f88c6..1b19137f50a6b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10336,7 +10336,7 @@ L:	gfs2@lists.linux.dev
 S:	Supported
 B:	https://bugzilla.kernel.org/enter_bug.cgi?product=File%20System&component=gfs2
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
-F:	Documentation/filesystems/gfs2*
+F:	Documentation/filesystems/gfs2/
 F:	fs/gfs2/
 F:	include/uapi/linux/gfs2_ondisk.h
 

base-commit: f44a29784f685804d9970cfb0d3439c9e30981d7
-- 
An old man doll... just what I always wanted! - Clara


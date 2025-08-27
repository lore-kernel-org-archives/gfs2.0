Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A3327707
	for <gfs2@lists.linux.dev>; Wed, 27 Aug 2025 02:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756261290; cv=none; b=N06qLf3MXYLgbtfLeye9RTN1Z3sSiKTVSzPP+vjAO3XfW0ZBam31A4e8/U9kDn9sFf1YK6PjZxnW7P3fZaPVmMdlInysHC6NLl3Pgqf1+q2ieBG8xIlBQShu4ozXeHxu0U50vhMgmLavFWhqoHAvreGzDl2cteUobIicA1DE/X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756261290; c=relaxed/simple;
	bh=+ZVR9Ppk28E2J4qnPmkr6EkpyP7ccUanbegMHUGq/KI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QX4rAeOeHYyn431eJU3Cld1X4VEfFqTZn6aAIXrBvBHxFCwgscsNWSoStfn5YmJPo+QTTTspFB2yjkn+ZebkpDC0ysFm325FLBqg185IP9U5i/hmKChoXZlXxwIzc2qHXX0uBnzkgdshwQ4M5wyKCnq8B0gFRLivLDLmdffZl5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/TkT2P3; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/TkT2P3"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e2e89e89fso8444990b3a.1
        for <gfs2@lists.linux.dev>; Tue, 26 Aug 2025 19:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756261288; x=1756866088; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qibv7r9QH5jVvZNBeRJTT/rC//28RtGqi+oX6/1f72I=;
        b=K/TkT2P3OUeE8082tTJXdSRGhtm5MPwf2xGv/2+jvKDtOXCFZm3Rbefv1KwwZukmDK
         InfZReJpT6zzfFMizGX72QkGk2BP5l0Eq6w9yRvei3rEt8ZYbBuCav1PcLB4DhY7XeJ6
         ONqtpmC3b92T8BRUGHet+ZQ+3CzBQmx6IT/PN4ABpdtLWoUOoALWaIufk3tY9oqEgGqF
         mpVFrwg2ooJPX32mrR1lgEmINw42mw/wM026KQlcVu9IkyrPjy3aiz4Y0Qp0kK2gC90/
         m9rooq14jrtbn4Ce3tl4Gxti3Cry0Kijs/lySQcyx/Yp9zgj+m7TZnmjItIfpyfGxaJT
         9ATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756261288; x=1756866088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qibv7r9QH5jVvZNBeRJTT/rC//28RtGqi+oX6/1f72I=;
        b=NBpG1rHJ54wXo0BR/0vfEkZOTk+qcOzPh6PrAi5t9z4DZDO/iZFeqLyzv4zvK9PH+c
         lbA2ZsgjGA7N/ugvu/99sHLUbkAHd47k1Y6NExeXBja6i+W3cJQL6381gNn38I1Z3SV5
         ViTDimt3b2nWn4fkppWL3x+9GI3+S0Qy/gcgt24dpu9wJXo7pRufojU3R09i8UaUJ13y
         sUGVpbCGWT21XvqsBlB15QFAi5gDP5GocMPNJO6/Jpu9ZAn4gMscLj3xB2pbyBwntAwO
         MYg5ctVkxT5wlrg8TyqKrVjegJ+ivUPrwiPYJUGlZIUF67j4I9LIq/Ug8zAPubYFeKF+
         uA8g==
X-Forwarded-Encrypted: i=1; AJvYcCVkIYMOHS3+wWFPzlWI6JWh8Xx1GlI5nr7R+ar+cwAkJ86VjteJPu5bYseqXfQ02Fb5DtxS@lists.linux.dev
X-Gm-Message-State: AOJu0Ywx5zwYegIYWnl1EcTOa/hvWfsFGcCBumEA/+rNdq5eK+mfcOY4
	bL6U7nZaCgOrWz+WVu+Z5oyMWIEKYa1HNyX98GWAktnJPwobWJFzYiil
X-Gm-Gg: ASbGncv7ZIot6T5KmvDJtRWQcko/x5lRIjcsIPqBdTYoU3H4xVPixkBoalW2EhM75je
	WFtrmmendvJVxDPN1GLyR873oGXKbQkGe489wt+uiD9NdtG09PRuFNhpca9hNdQLaeClL76VV+o
	cwSY2I+Lj7IzLiTQqiE9BGp5/KKo/YkhoMfaOFHlQfLZflBefC921GnYdAg1cvIBSaYYxLUbYyO
	Na+NkdCDInb12aa6tX4DHLBhNRFYiv3DRqe67iwpfUM2ypuT0Z3wlQ30G3u0H3jl75y480hY+qD
	CJ3TZeyn/sYoBCTvIIRQboSXuzo7HM0dETB8T6y4CgVh8yKH2RF9KfY1/RikTXc7CWwjaqfkJ1m
	EEUELai1sDSVIBWphUn3cVA==
X-Google-Smtp-Source: AGHT+IFjTD8x2VGb975Gtlblzp8JBLZaUMkNK+9zmVIvPYqOW88mYas5zqSDQMegGiWkV9iU9pcz5w==
X-Received: by 2002:a05:6a00:1793:b0:771:f852:4529 with SMTP id d2e1a72fcca58-771f8524884mr7535006b3a.13.1756261287905;
        Tue, 26 Aug 2025 19:21:27 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77040215c40sm11656556b3a.96.2025.08.26.19.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 19:21:27 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 2CF59424BFD0; Wed, 27 Aug 2025 09:21:25 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux GFS2 <gfs2@lists.linux.dev>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	James Morse <james.morse@arm.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2] Documentation: gfs2: Consolidate GFS2 docs into its own subdirectory
Date: Wed, 27 Aug 2025 09:21:22 +0700
Message-ID: <20250827022122.12132-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3716; i=bagasdotme@gmail.com; h=from:subject; bh=+ZVR9Ppk28E2J4qnPmkr6EkpyP7ccUanbegMHUGq/KI=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBnrsgWX3s1xPTdBZvu9zRvNBYXmvaxWfp1et+qIY1fdp L0RD39bdpSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAiLbsZ/tc8WXouaFFW3dSG rXVmrwXPN/ntCPiy8dUag6kBd9+8XF7EyHBzAmdobrHGqSvNodLXHm7+PnPrxyfrtxyZrfF/58P pH5dyAQA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Documentation for GFS2 is scattered in three docs that are in
Documentation/filesystems/ directory. As these docs are standing out as
a group, move them into separate gfs2/ subdirectory.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Changes since v1 [1]:

   * Strip gfs2- prefix (Matthew)

 [1]: https://lore.kernel.org/linux-doc/20250826023913.14888-1-bagasdotme@gmail.com/

 .../filesystems/{gfs2-glocks.rst => gfs2/glocks.rst} |  0
 Documentation/filesystems/gfs2/index.rst             | 12 ++++++++++++
 .../filesystems/{gfs2.rst => gfs2/overview.rst}      |  6 +++---
 .../{gfs2-uevents.rst => gfs2/uevents.rst}           |  0
 Documentation/filesystems/index.rst                  |  4 +---
 MAINTAINERS                                          |  2 +-
 6 files changed, 17 insertions(+), 7 deletions(-)
 rename Documentation/filesystems/{gfs2-glocks.rst => gfs2/glocks.rst} (100%)
 create mode 100644 Documentation/filesystems/gfs2/index.rst
 rename Documentation/filesystems/{gfs2.rst => gfs2/overview.rst} (96%)
 rename Documentation/filesystems/{gfs2-uevents.rst => gfs2/uevents.rst} (100%)

diff --git a/Documentation/filesystems/gfs2-glocks.rst b/Documentation/filesystems/gfs2/glocks.rst
similarity index 100%
rename from Documentation/filesystems/gfs2-glocks.rst
rename to Documentation/filesystems/gfs2/glocks.rst
diff --git a/Documentation/filesystems/gfs2/index.rst b/Documentation/filesystems/gfs2/index.rst
new file mode 100644
index 00000000000000..9d9ca84d45a7ae
--- /dev/null
+++ b/Documentation/filesystems/gfs2/index.rst
@@ -0,0 +1,12 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================
+Global File System 2
+====================
+
+.. toctree::
+   :maxdepth: 1
+
+   overview
+   glocks
+   uevents
diff --git a/Documentation/filesystems/gfs2.rst b/Documentation/filesystems/gfs2/overview.rst
similarity index 96%
rename from Documentation/filesystems/gfs2.rst
rename to Documentation/filesystems/gfs2/overview.rst
index 1bc48a13430c1c..f971353d23611c 100644
--- a/Documentation/filesystems/gfs2.rst
+++ b/Documentation/filesystems/gfs2/overview.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-====================
-Global File System 2
-====================
+=============
+GFS2 Overview
+=============
 
 GFS2 is a cluster file system. It allows a cluster of computers to
 simultaneously use a block device that is shared between them (with FC,
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
index dafc1171254406..c685140f78c4e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10335,7 +10335,7 @@ L:	gfs2@lists.linux.dev
 S:	Supported
 B:	https://bugzilla.kernel.org/enter_bug.cgi?product=File%20System&component=gfs2
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
-F:	Documentation/filesystems/gfs2*
+F:	Documentation/filesystems/gfs2/*
 F:	fs/gfs2/
 F:	include/uapi/linux/gfs2_ondisk.h
 

base-commit: ee9a6691935490dc39605882b41b9452844d5e4e
-- 
An old man doll... just what I always wanted! - Clara


Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2374236A73
	for <gfs2@lists.linux.dev>; Tue, 26 Aug 2025 02:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756175970; cv=none; b=gi6znU9K8qDJ0r8IVitskI290qNIsfTh2Y8HnMh6uuq8j8qbD+k3VV9XvC9r+VMhTBfe1J3G0j5WhfwbalBl5W914UxEZ9O+9S+Vb50XYVMjdwjU8rIlCWJGbNe2eIhaH+NOqGh3pCRubYtAXAn6PbTaIf/b/Ryo8DxbS+vNiBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756175970; c=relaxed/simple;
	bh=xHs+l2pfnza2uc+5614jN3sm82wrUYBarOeH9qm4DmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d/+BHHhd5KmnxMiM1RCW4CyfuLbvJr9eZVGekVrUY4/2hvc2iMzsGNrFaQmJRiI4ZWGboDtJdGFFpnVvoduu+aLuHBxpS01HrJkyDFq4E7iqwXhNny9GMgpmw4wdYGuwgYCiO5XKLbgZ656+0WS+5b8GwksvyeKmRKLEa8IV7go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIa/gmC7; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIa/gmC7"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-246fc803b90so10926485ad.3
        for <gfs2@lists.linux.dev>; Mon, 25 Aug 2025 19:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756175968; x=1756780768; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GQynW9QiNkC8m7UhwgLmWwZBf8g2MjsE/2KafsbAG70=;
        b=FIa/gmC77OuFYo02FMU/o45aPrazpHmL4uEtlPWXY3azfBmfXkWjkXrqfw+3cO4h9a
         RPwvvyfTYKWVnDN5TvUMWJHJLqdoDQ9wA6/ILdnYLdrPOfFHa5GW9Lfg5BAifmLrhztO
         sMQXSK1hSgRkORyzcKN7m1U3xvHJEo3MlNZawlOn+1nMAoWTvnGUW1ogiksROm0cAJZA
         r004SaUGBxZzI+Vv7j4Tj+dI2ZQveb/tX7P+L6fWXtt3NRJtax35eNhokYbNJN4HD61V
         pq7IH87GSRmGKYMzwm5/zrnx/mQzQyIeBoPQmqPvB9/7uI/iVL+MU/dNdyKmSi4zwEvY
         Jnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756175968; x=1756780768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQynW9QiNkC8m7UhwgLmWwZBf8g2MjsE/2KafsbAG70=;
        b=wFTEFNwh/K3y+L12L18LE6MqRSrW2tLNu0TK4y6HZ3+DZZUFXvhRiZyFMi/6rWswdV
         DYwozbGK+sfLxCD7A6LiCdawBG+BdE9i7W6Uu0Xbi5iIe4+3ZBradbFdI6Yy1GqiaO/a
         IdfijeRczyYZYuTTIqvJMlxLnh3hmHHqWRaOmWtTmASOCaa0LeG31FbuHo1B5JKsS9KX
         C+rssdHN78CL1jUxfv5jAOkwd67OwoQ7vUE7aaIWGxNmlTKydk7ZrVp248bCgPQl+gFz
         ij8Ffh7dyx3sYh3SkltbFWSoV7UsYdLZTYQZkmygpona4XKoOXgdnXv9FigbTHmDp0Wr
         fDqA==
X-Forwarded-Encrypted: i=1; AJvYcCVoUMANZJaAh1V0BEY+f/dRxJeGww1sY8vV2orJLCNUaasYnmL3JLnmVQN3SvQsikWQ9aNC@lists.linux.dev
X-Gm-Message-State: AOJu0YyBIEppZ8dF/kzmrU3ZsKK2o6u30Yx/nWhP2XRLuTj1OzT128a0
	J/TXkceObwCU6Aqvhfi+wtLjYcoao9Up1I37GOmSXM+g2q3VqM6TCnVj
X-Gm-Gg: ASbGncv5/Xbk/l2fRTP3sYeTKKkiNDmM8T+BMLrtlhvAachTkIKjc6pTYtQ9f0G0LX1
	/DtDgNezPalbYMOcYoUP3cNHXQ/JNUkJeYcPc3x/n96N8DgCjAw+qnJZLbIYOZP1MiTA/LEenUW
	nM0dNnfbpHNME0vQttUhP++DayKZoP1bLER/9C82zNOVrYFYVNxyBciXUvOFulVOKMlOi1vEo96
	zH/QoJVBsaUe7oBUFREXD0XPPSEzaVjvFcRMkOXP4fkP8sSOeTOdPTy/H6MGVDPeXmM24myZMF3
	iZBkeOI6D6/Z3p8QcFvYGVIUmTJMlspaOcx8XigcoUrD0C/y0G0hH3HgfNvhvtp+dghAZDHJTgz
	QsVFE2jR3wIAfQB3mFbGx8SxNvZXCofLW
X-Google-Smtp-Source: AGHT+IHmEMMHHRcOtgYg4LZPSqkm+z1dB2t0mOOt5Ny373ENmShez272ct4ZPtzZLFkpespJvpgnXw==
X-Received: by 2002:a17:903:40c5:b0:246:cc19:17eb with SMTP id d9443c01a7336-246cc19229dmr84410505ad.19.1756175967819;
        Mon, 25 Aug 2025 19:39:27 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246688645e1sm81074495ad.79.2025.08.25.19.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 19:39:27 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id F1D89424E25B; Tue, 26 Aug 2025 09:39:24 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux GFS2 <gfs2@lists.linux.dev>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	James Morse <james.morse@arm.com>
Subject: [PATCH] Documentation: gfs2: Consolidate GFS2 docs into its own subdirectory
Date: Tue, 26 Aug 2025 09:39:13 +0700
Message-ID: <20250826023913.14888-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3546; i=bagasdotme@gmail.com; h=from:subject; bh=xHs+l2pfnza2uc+5614jN3sm82wrUYBarOeH9qm4DmQ=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlrpc+b6eVttHk4QULvlVNuZ8DC2+fO26vuzpz3WOHPu 3nM6mZ6HaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZjIE26G/8GMYY3fpk2Ikrjl 8Fm9ni3414OjBUtvaHLs1Dq/+setVXcZGV6pcTkd2HVnS7nYYlbDKZdWaVaHvn8UuU/wP/PptsZ b01kB
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Documentation for GFS2 is scattered in three docs that are in
Documentation/filesystems/ directory. As these docs are standing out as
a group, move them into separate gfs2/ subdirectory.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/filesystems/{ => gfs2}/gfs2-glocks.rst |  0
 .../filesystems/{ => gfs2}/gfs2-uevents.rst          |  0
 Documentation/filesystems/{ => gfs2}/gfs2.rst        |  6 +++---
 Documentation/filesystems/gfs2/index.rst             | 12 ++++++++++++
 Documentation/filesystems/index.rst                  |  4 +---
 MAINTAINERS                                          |  2 +-
 6 files changed, 17 insertions(+), 7 deletions(-)
 rename Documentation/filesystems/{ => gfs2}/gfs2-glocks.rst (100%)
 rename Documentation/filesystems/{ => gfs2}/gfs2-uevents.rst (100%)
 rename Documentation/filesystems/{ => gfs2}/gfs2.rst (96%)
 create mode 100644 Documentation/filesystems/gfs2/index.rst

diff --git a/Documentation/filesystems/gfs2-glocks.rst b/Documentation/filesystems/gfs2/gfs2-glocks.rst
similarity index 100%
rename from Documentation/filesystems/gfs2-glocks.rst
rename to Documentation/filesystems/gfs2/gfs2-glocks.rst
diff --git a/Documentation/filesystems/gfs2-uevents.rst b/Documentation/filesystems/gfs2/gfs2-uevents.rst
similarity index 100%
rename from Documentation/filesystems/gfs2-uevents.rst
rename to Documentation/filesystems/gfs2/gfs2-uevents.rst
diff --git a/Documentation/filesystems/gfs2.rst b/Documentation/filesystems/gfs2/gfs2.rst
similarity index 96%
rename from Documentation/filesystems/gfs2.rst
rename to Documentation/filesystems/gfs2/gfs2.rst
index 1bc48a13430c1c..f971353d23611c 100644
--- a/Documentation/filesystems/gfs2.rst
+++ b/Documentation/filesystems/gfs2/gfs2.rst
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
diff --git a/Documentation/filesystems/gfs2/index.rst b/Documentation/filesystems/gfs2/index.rst
new file mode 100644
index 00000000000000..3875b9e1bb5cd7
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
+   gfs2
+   gfs2-glocks
+   gfs2-uevents
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


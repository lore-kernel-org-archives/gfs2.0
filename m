Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3E43D6F
	for <gfs2@lists.linux.dev>; Tue,  9 Sep 2025 01:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757382380; cv=none; b=B5ngLD32giVpj/sto6ZeUawMQ3EBrztah/SyxpVNgNx+iv/POKKKAFLyntWjNK6J5kfP+6ZAe7eZThFi6ieS1YlIAXke3BorYU9P1aFciu/ywYD4VIAfspUjg6LdlaEjTltY0iBKfPj+GbM4Mdet7XIhxXkO2/Pi8TMZf1+kmmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757382380; c=relaxed/simple;
	bh=Mgm/f/dyyNj+1Olh/CY02O9anr2CSratmtmw7/rayiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lxbT2eXYulDXF6tOr1U/h8UsuVUIfrb9HVkbDDOiGu2lQ9hDvVepiL3ixw7xy/o9MsMsz0D10krIX7OmxLeHk1TIlm3eEolja2UiPdKQMNrGCdhwJ5NzPtDD9GbiNIJosF6EMqctnjzIdpv5KwScNJS6eGl12FAfzVVg9YuCcoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyLL68kq; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyLL68kq"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24456ce0b96so54699725ad.0
        for <gfs2@lists.linux.dev>; Mon, 08 Sep 2025 18:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757382377; x=1757987177; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KuiOo15AG4OXtbWW33TbGP3QjJoF6Rgu6PmjoTlWNs0=;
        b=FyLL68kq6iF3ly+Vkv1Cw2aBvH/mvmesJtSzNgaD1FSozg6xv/bWHZ3iJ3ukerYQAI
         KHbrhJBH+u4QicyU6lcQDNdOvuwRtGQqmQKfHIjbEXkoh1sg2sqXkqhh0zmlaKfpE754
         o+20YpU+x3NlqukTf5A+1+EnWP0soCdOTlG0sw9dUTT5QsPg4MlEqD6AbH2xcUI8zniE
         pP7SsOAbMOL5qohF37MqThHm4eWg1sqF2MK6y7tj2+xwFGAFJucSPRd3f83v/NlWFWBf
         l0g0L+CHoCpSZ6W+6eMbQcTN59QekZJbm0+YBzCZ8UkEw8Ofeho6wPbtM8Sx4iVRGQmM
         okBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757382377; x=1757987177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KuiOo15AG4OXtbWW33TbGP3QjJoF6Rgu6PmjoTlWNs0=;
        b=bxDSm8fx+pJ5syIiEfGyAhJ0QwojT7pdoAh306r0nCuKVPLca5FNTllQXlnojBXNlF
         gfWqTQfCVPNTcC+3c6OXSnuzCV3dlZ/cKVsuB4bNyCq/zpJXsbrV1ihas1DKYCN/4jSi
         K0Rh4cd/UycO4sRujLBw18koALnWpshZeEWXYJTog4yXsZiXnH5FmSyG2MUKyPs43Ztu
         Lg07T3l5e82FkmgnR0uLUK1/1vpO0SPE8uo6rJeqGLPAyIQ9Dkw1SnaSSYNlL+ADaQyw
         aoxWoQKP107F1SgSZCSk3YGI8L9eM0PFqIKxkd/TSg9ZNa3qcDYbEQ5KMo+zaaBxKM+b
         JvPw==
X-Forwarded-Encrypted: i=1; AJvYcCWLWvUjTQTKbrZN0M5a9yTsRdCVDedSsCokeSzyXZelgtaVKvES/rHTtUJSIDVdGQt9+NUR@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5y9WIZOXN9jiAmLbmVx4y83kBNO5cPhPiDW/eWMu7WWAYMiN/
	8f/tNdgpJVWeW2JV5MKP4NsdaC7Q44I0+eFJQmuVSpcrI5ajFUVsYm/g
X-Gm-Gg: ASbGncvWRbmJHHLA3S8VNhd+fvmYBA6VfWfH6EVfkOJeqgzo5NF435ZAxMsWxtL133q
	T/kjHBLkDtuYXjdoqusWO7y8lhsNMViH0VE7lBhNFnDPqFoDaacmxSxanN9Eayq2SSfeX+qJWW3
	bsbRdsbLJ0XSjqZiNANpQbRVFRsQ17Cp3ESwRqJgGYzg4p626pdTPvrW6cCq6/oRNA8Sk9m4+iB
	XzQeW4290XMfjm3yh7YVDSYMbFFpsfZuEcTY0SYzKrX/BKrjiHD4PytVHdaWoXzUwl1NcBdlW7c
	41HijYDI77ODXSCsCb1zsMVLChxOEM31A+q+Sh3frFnuHp4Rc4ebiaLAlSncsRDe8uuB+KCYzFa
	laDizb4bsCWNIeURo1ciueuNVxA==
X-Google-Smtp-Source: AGHT+IGXoxvJ02bO5wRwlNWwxniZMYMlgSaFXoJXpCTp4h8dPraKosEMNBMembTfFIeOUDc1sptulw==
X-Received: by 2002:a17:903:2f92:b0:249:37b2:8629 with SMTP id d9443c01a7336-251759a97e4mr123230625ad.9.1757382377180;
        Mon, 08 Sep 2025 18:46:17 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b11448a5asm189941315ad.54.2025.09.08.18.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 18:46:16 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 54E17420A80B; Tue, 09 Sep 2025 08:46:14 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux GFS2 <gfs2@lists.linux.dev>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Bernd Schubert <bschubert@ddn.com>,
	Jeff Layton <jlayton@kernel.org>,
	James Morse <james.morse@arm.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3] Documentation: gfs2: Consolidate GFS2 docs into its own subdirectory
Date: Tue,  9 Sep 2025 08:46:06 +0700
Message-ID: <20250909014606.15043-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3807; i=bagasdotme@gmail.com; h=from:subject; bh=Mgm/f/dyyNj+1Olh/CY02O9anr2CSratmtmw7/rayiA=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBn72wI3PP566pbttS3uO5jZTBQ+Tv034/xDNfcOiWzZK MdnScESHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZjI4xaG/77Cn2t6OVh1V+lu /a0jvWYBX2PxlwcLpt65wj3txWemGWsY/tkmGz3coi12z2FhY/IEjXtc+x7dEfbK3Grup5jSfar 2HBsA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Documentation for GFS2 is scattered in three docs that are in
Documentation/filesystems/ directory. As these docs are standing out as
a group, move them into separate gfs2/ subdirectory.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
Changes since v2 [1]:

  * Do not use wildcard on MAINTAINERS file entry and add review tag (Randy)

[1]: https://lore.kernel.org/linux-doc/20250827022122.12132-1-bagasdotme@gmail.com/

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
 

base-commit: 7e5a0fe4e8ae2eb341f8ebbee2b24231a58fc28b
-- 
An old man doll... just what I always wanted! - Clara


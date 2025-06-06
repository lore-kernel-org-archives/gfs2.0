Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAFA191F7E
	for <gfs2@lists.linux.dev>; Fri,  6 Jun 2025 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749203299; cv=none; b=ltGFWKVtP/LdkLfnpcSYEOM4r2GtFq0mMEMl26BcpBhuFJt/eYh48SVd4CVY02xHnchqhVa2FNF+I9M/MV62HXeTWg1SmFSszl6oTMb0juVOOpJzBTleIq/NeH0QYFqxy85OFKipTGo9ZJLuTlbqjgqNGrZDauxuNVSzwo0o1Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749203299; c=relaxed/simple;
	bh=3T72iyLdIZhCCNi9UoES7lgwInksCSNzRZnJQmsUojM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S2UG8UgmJM3BYtC2rPKvgVfBA7M5Ptbb2Hu+OcUEyv8ppOwAuu823+qjlwimp/35s68urkx1g94byxAJCLndqSu0wY1HiTyPK86bEUudn0tKJEQwqcKYbmu/Ivm6JJarZ5BlFow5Bt7feaP9UeecKIj0yS2oDWXVHXrhoGiObYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aGBblbt2; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aGBblbt2"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a51d552de4so1085268f8f.0
        for <gfs2@lists.linux.dev>; Fri, 06 Jun 2025 02:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749203295; x=1749808095; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I27iGtn/FZ4vt81Dk4W+hcmgG9uhaK8rNlRIBMOjVfk=;
        b=aGBblbt2pH4ZTOyYGOoMpwPZN3MsaLxBWzYEhevZE6IUWZVRJb3ByeBq8pllNLifzv
         o3HgEEWA/Nhbi4bpUO/hZBgV0NVgR22nxM1Mp+RROpoJamwwcYidBRPi0MwCaH5ZhLBs
         RjOqz06A/AY0bluxE/pluF5G/OFy9GOf6Nf8L1EnOXghAqYpb2XeO9RWTakTYNzZgMFe
         HrRvvyHI2/NdamkgcPgLL6+BA/Y8LrTK3gYzpyLGK5rhlX6rjXjJ8AkVRAnJDdGkjoej
         QeMPNmBF2NTfyxzPZNKDrnaKC3EAt06Ttf5XZDycuptBt8zCvMfiNeK/5SFKBMB4h3wX
         y/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749203295; x=1749808095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I27iGtn/FZ4vt81Dk4W+hcmgG9uhaK8rNlRIBMOjVfk=;
        b=TEoOzdq28Y5bdiP+lsHuAizda4N4sSOVZfEq7nz9aB/l22SXgU24UUhrO85A0qrxwM
         qE3VoVEgBCAsYS6X+k4WA3btPzVHX3dBolbVKMrkqkgsAL1JuvFN6uXBruy0m/vtwvmB
         fwgQk/sOU+U+Q+g7tdkxqkFd3XT/QdWvZIApzvPRM5Gj0o/P5Fc4yv+kkiBweURArlGg
         unJCQlHjzPPXrSU3POsC/7ggVP3See/K7HTmri7AzEPjsuBP0N/bTd+Tjo9XdACQlVYg
         30tWfVoVUToj5CoIZwGc3tomqMWCvoZdeMbJLyNQ0hTscZo2G6BfdB7mkSprWfTqWR9R
         esCQ==
X-Gm-Message-State: AOJu0YwtfmHDVdzhY25O7vXRHOwzKS1cKEqPSjJ8MHImjrhz6Z4IFkUn
	VB3ZIDmqMr2WvqNtUAf39gmc99uwcTKAuL54BvNvrfd8zBXfXmB/KMTrd/6mAJr4VaDafgq8cdJ
	qEBXVqoMuX0EM
X-Gm-Gg: ASbGncua/CArYwef/Bh+RhKKcwO/de1p8Q9iGKjiYMcnctNQRr2+CP+pma7+38whiy0
	8EvOBWDWZNmKgYHOgj+h4TTcCyC9cM8iIs/LuH1hwWaPaajdaGWahB80DI5ZUrIqN0zH2zWUmsq
	0d4jQr2JnNcneIo/Y+aGh0nTzTeuE0yr/Tj++HWMSHqfHapfVG2hIBYY96W48+GjgBK8U47GqJw
	vFLu5Ya80A93DUdHXOSYuHeE+CAtQ4ObdumrICqADU2NTQxdpCmtAKINy5ODU/1KMC4xQYS5Oqv
	8tOejz8h7VsqX7X00L7Q8irjPYJJd2WaeJb+HQ8J7/bNjYD2k2OPyv7hkD2jvw==
X-Google-Smtp-Source: AGHT+IHygd31wJQH8G8p/8FdU8nhtN8LoeYoNy5fV8mRk5GpqQrnFdlNO+PWgcdotT04LwX6ieinGA==
X-Received: by 2002:a05:6000:18a5:b0:3a4:e082:c8f4 with SMTP id ffacd0b85a97d-3a5319b47a3mr2604038f8f.47.1749203295546;
        Fri, 06 Jun 2025 02:48:15 -0700 (PDT)
Received: from MacBookPro.lan ([5.255.111.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482af3859csm936348b3a.36.2025.06.06.02.48.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Jun 2025 02:48:14 -0700 (PDT)
From: Su Yue <glass.su@suse.com>
To: gfs2@lists.linux.dev
Cc: l@damenly.org,
	agruenba@redhat.com,
	willy@infradead.org,
	Su Yue <glass.su@suse.com>
Subject: [PATCH 1/2] gfs2: rename gfs2_write_jdata_folio to gfs2_write_jdata_full_folio
Date: Fri,  6 Jun 2025 17:47:55 +0800
Message-Id: <20250606094756.95958-2-glass.su@suse.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250606094756.95958-1-glass.su@suse.com>
References: <20250606094756.95958-1-glass.su@suse.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the functions calls block_write_full_folio(), gfs2_write_jdata_full_folio
is more proper. Reserve name gfs2_write_jdata_folio for futher use.

Signed-off-by: Su Yue <glass.su@suse.com>
---
 fs/gfs2/aops.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 68fc8af14700..1a9e4ed33911 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -82,14 +82,14 @@ static int gfs2_get_block_noalloc(struct inode *inode, sector_t lblock,
 }
 
 /**
- * gfs2_write_jdata_folio - gfs2 jdata-specific version of block_write_full_folio
+ * gfs2_write_jdata_full_folio - gfs2 jdata-specific version of block_write_full_folio
  * @folio: The folio to write
  * @wbc: The writeback control
  *
  * This is the same as calling block_write_full_folio, but it also
  * writes pages outside of i_size
  */
-static int gfs2_write_jdata_folio(struct folio *folio,
+static int gfs2_write_jdata_full_folio(struct folio *folio,
 				 struct writeback_control *wbc)
 {
 	struct inode * const inode = folio->mapping->host;
@@ -135,7 +135,7 @@ static int __gfs2_jdata_write_folio(struct folio *folio,
 		}
 		gfs2_trans_add_databufs(ip, folio, 0, folio_size(folio));
 	}
-	return gfs2_write_jdata_folio(folio, wbc);
+	return gfs2_write_jdata_full_folio(folio, wbc);
 }
 
 /**
-- 
2.48.1


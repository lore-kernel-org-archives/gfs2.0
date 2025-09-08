Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF1B31E0FC
	for <gfs2@lists.linux.dev>; Mon,  8 Sep 2025 18:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357546; cv=none; b=Qi4M+9eAuNxxTxztDnomD+f8+skQ17OrCfQqlf2+H7f+zn30vIR9fiH3K9iRubpv1/TFbb9tZa//MAEfh3pnnf/GVqwlMVkEBx8wfY0GZizjoOn9ZYLSV7egTTvzSgQhu542DA0NMhmQp/CV1b28ZE2/zb25kIs8OVrlCGQwVNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357546; c=relaxed/simple;
	bh=AzP6wIhsfCMv6GgiBHJJ9xI5qf9k06WzrDIB8putFD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8l7dAnUV+K6mrYbrc8ljMCs4c2/e4/+a+J0537cAEo0BpkwPv7RD5lXILZ+VRNCWRHy/JMj8zCEzmfz3RFNKajckAgl1OyANzseWeXMEhflQww2iiyt3GYmOP2u+n5DKgEdjwNsn3TqomjKZKYgd1RUuNbgRs3FUamtsuL57gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T27HPne/; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T27HPne/"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b475dfb4f42so2840326a12.0
        for <gfs2@lists.linux.dev>; Mon, 08 Sep 2025 11:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357544; x=1757962344; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXe/e51gNFNgtjm8LXJWMHURg7TDHqHIgvxmJBN741w=;
        b=T27HPne/MThbtWg8j5ZmvJ6y7s6LbyDUKZFbmoyrlCCCNKLjMHhLAXkG9bZa3IKePa
         fXVuBj6Km6XHgzVIrJ6mOnYFuJEQxDpW/UMovS1nBYcOkIzvQOaMbLdpUydyfZsUwWfE
         mgvvga/MAyHiSSf85u/7V6D7NVCvkNNf3NIZVNaooZAp8Wzlw/GyYXjfBH9oIOv5hB8M
         uqVInSzwahjGU9SQizOdlJc248S/eEvBrf9UUcKyepWuRLwzpTp7k0rl9xDQXpjU9OBu
         ItjQQreNkCMjBV+AGCSJDkAJfZS0nI+qLHClw/q7ulwTyHlbC3v+aiROBdwAcDXtrEUb
         Ahcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357544; x=1757962344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXe/e51gNFNgtjm8LXJWMHURg7TDHqHIgvxmJBN741w=;
        b=ALgOxmWK0iJ8W4i5gRN9XgBC0Ara9gC/CMpE9C8pz5LcjE+zJ4HsU9AFBE/xUfvY6f
         PXqR3x/kKl/nKZ7H0OQB7z6SPoTw9OaGb4ADTgOml1N4hhEeTv+EMbALSF3xW8g8QWeh
         vYh+gaHOTSMrJx5u15WH6ksGB0vfUa6/XShWbwIq/AWwuqY6ILDCbrPgnNe75ShYK3w6
         a6gd/+0buH9aaFYc/uNxbd5/FfbvI4FNwMdo5twppQ5lcxScpnLfTZAa/gYM0FwUbuJ0
         V4lMhXX4b7zYClvqWyUB69mFx7FiQrWmGZMGH3cal2xOrwCXR0BSPJ9Fy+2dVzgWJ9Bc
         5DKA==
X-Forwarded-Encrypted: i=1; AJvYcCUyH8wrx8mPC7BumtY6BtB6BaiuTzAiaHG9c0vv9T3E6rI88hlhiLt0aUV3VlsTuTbBSvGI@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6vxjfdSnzpSMMHQssmST3x6bkBfvZijmyWQluKycePy+615Qh
	UWjMgMXUglV6/aTTIuLWHrwGSVPLjrFg9IJqL1Wn6sGEi01GZ+V/y9dvtS1ruA==
X-Gm-Gg: ASbGnctIWB3yhhqPZVDIXnyrQPxklSymCxhXIRNV0rWlizVWhKVHazU5f2gVfM3DHPQ
	nkQnRMqWmL7R/57LcWAgFz+KOBVz02GLRM19LdMm/j3LfUYWNOYqRIg94kENbYwEZ3h8XPxpCPj
	yTZ3JoEvbxUsNFl6c71gM0jLJ4HStomzDmS3rybhUx8kGH1TOk3wD5rTHK3tTicjyjHgTf7AjQ6
	uG+NBmorBg+cxdexeMVwxS3f7fwm0nTAxbmjCHUCD3/J8hrwVz/tl2/V4/YRWGVdfOzoL7UOngy
	gluftzR4sW0dnc7JKy2Pj2S0iMznM13mk5CWNBLEilSLfmKuT63mSH1IDASEvOUZDmDnbOq4dYF
	6YiNJ4ST+bl7XisTkF2+8ewr8T+IA
X-Google-Smtp-Source: AGHT+IHfaouKKNXgATrlBmub3luWLowfDYAilRWQ/VG6KFRMkRa972NbFxFR3iGutKYJlxXCE9pMJQ==
X-Received: by 2002:a17:902:ce03:b0:24c:bc02:78a4 with SMTP id d9443c01a7336-2516e98142dmr132772265ad.24.1757357544102;
        Mon, 08 Sep 2025 11:52:24 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7726a3fbb32sm20348401b3a.53.2025.09.08.11.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:52:23 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: hch@infradead.org,
	djwong@kernel.org,
	hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 05/16] iomap: propagate iomap_read_folio() error to caller
Date: Mon,  8 Sep 2025 11:51:11 -0700
Message-ID: <20250908185122.3199171-6-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250908185122.3199171-1-joannelkoong@gmail.com>
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Propagate any error encountered in iomap_read_folio() back up to its
caller (otherwise a default -EIO will be passed up by
filemap_read_folio() to callers). This is standard behavior for how
other filesystems handle their ->read_folio() errors as well.

Remove the out of date comment about setting the folio error flag.
Folio error flags were removed in commit 1f56eedf7ff7 ("iomap:
Remove calls to set and clear folio error flag").

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index a83a94bc0be9..51d204f0e077 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -500,12 +500,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	if (!ctx.folio_owned)
 		folio_unlock(folio);
 
-	/*
-	 * Just like mpage_readahead and block_read_full_folio, we always
-	 * return 0 and just set the folio error flag on errors.  This
-	 * should be cleaned up throughout the stack eventually.
-	 */
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(iomap_read_folio);
 
-- 
2.47.3


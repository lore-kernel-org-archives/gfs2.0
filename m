Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794EA3FE4
	for <gfs2@lists.linux.dev>; Tue,  3 Jun 2025 04:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748923829; cv=none; b=OLuSYoiBYmk8R3EbPBsihIzrRs9GhMYvbACm6LkytDqLx+s7y3S1muHYYIy3ZTskvmIuI2ylb3W5lwhqwYDRRGmLMoPPX8cV9Y0n46E6jrr12zr9emgx/R79t56BdsgcWhZ10yuO82Mtx8J97UgZ3XlrgnsOkm9RzkhaRTkhiAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748923829; c=relaxed/simple;
	bh=mWKW1BZiWQdg5ZGyvvansCbXzzKjs6P+f7nmIjIRSFs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f/lQPKrcH+It6+aaFGMim8wraSjy/ZM0GPY3nn78/h/K7Su4rHVcxzFsNiGE/eEpjgcrmyssx5EuBsDw4loZoZcgQCWoaIOJnvmP1kn/UeK/U/0tE9Tu+XanvV5laC37WYHFv1O1vAplDLRUMZDlJThAJGcgEVSSevrTCGGrPwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SsYuejeC; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SsYuejeC"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a4f379662cso3976245f8f.0
        for <gfs2@lists.linux.dev>; Mon, 02 Jun 2025 21:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748923825; x=1749528625; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vsip5heoQfOlVVanshNnzNCVpVKbPMgYCx8wxtCCQPY=;
        b=SsYuejeCLpE4FuAtWpKo1uV9eU5PHc6O7b8m195xwo/22Fy1g54eWy/3AHIXGbG5TD
         42YUyQ8QtvWC5HtAB9GwBiM9Z44iryZTvFJgV+Ulye9JFwEK0AkGX42TpV5PaQTRCO8J
         8keij+nN/8Q5N918i7lD452A06RxG696drnFAZnt57ocXVMtOOcJLaFcvQ3P52qIcjNC
         PFbDSEqgYvZZGFDbrSBcx08Rk8Wq/AIoX4P9I8rXQnmdK/0UF2ShQ1lTNZgJk+qGUw5h
         +nAjn5jYxHuwiQad+eboMPbBsu1WDNduohvMUdpf4RIGi6IGy0MUwq8hfgHE+TjPpqBZ
         kCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748923825; x=1749528625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vsip5heoQfOlVVanshNnzNCVpVKbPMgYCx8wxtCCQPY=;
        b=pWroxZcc4JdQOwYxjhtEivng7XZztD/sQnJvvI7VnRQNvftSZiopazmSOWnpAyFM1v
         ZnfQsmI6W/vS4b8+jYaxheQUrbHrhzyUPeqqcDMdbaMibycO46lYbU1I8eF/oCYsz3WM
         rJvD+GCLVB3CCGP+U0LIdXpqcuOej3m0L4ZaQOiWb9M4oA7KJhPRy8Ach8yJALFaclo4
         L4sxHTIGGxmMyYa2uroLPAioGgC7NlDMfZO3Q1yhZKJof8OPhQGuWrAk8jJJPNhzXQjd
         cHTFxUkfw7GjNWLr0QtNVvWI2/kBe0UnZJQRYtzWt/xe8fakmKGrX1JY/C9Ts1PWgjMV
         iwLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGcSuoYXF68FyqzBMlC5zxiJgNENhfcytVejb4vWejjd//oEhgDuWyPpSCQIfMWsrTtifT@lists.linux.dev
X-Gm-Message-State: AOJu0YxCE3h0DzfgIIuTfCeOvY5Mw4PdCXCp0fsTQ/36qy5Q93DEy2vj
	zOvwp9MuxxO7jUlF1xSpZT157t6RfU30sIiz2uyeAoVy4CqtAnqONUDmNeuK0UsfFSo=
X-Gm-Gg: ASbGncsC9s+P7F0y6U02BkToVcttJ4eJtEGbAVCP7coc65KGg7vG+hGSf6SrhFiYbLB
	zn7EC2uobWA4xWjgTk3KzHK8SyBWHaeT5IFRV0ZgoXusp5TtCLX6jNHZhRjsZtq4iY/zoCX+tqI
	s6YEQ3ublNAH3uqstZetKeWOBjOoSG7v39fT99WwNJlqIXDDbCN+SBc9nLpIMMhzvUdF9DW3ars
	nUvwbzDIbt9Lqnd0LtQAoyXB/okWWIjalbkw1/yWR0yYAq3OaIg3IYR7YZGzSh+k1uS2Kl170bZ
	xyZS/W+tThzFjBsWmEpr1tz7CGGP2R1YtfCd4v8ppOFNVsMf71k=
X-Google-Smtp-Source: AGHT+IHXiNSm1xbktSoVTeEFqtz86yosyFGRGmS6MYGmA+3pl9em5SkbVzFGQnlHyudvGkSUlboU4g==
X-Received: by 2002:a05:6000:1a85:b0:3a4:d367:c591 with SMTP id ffacd0b85a97d-3a4fe154d16mr8982375f8f.10.1748923824709;
        Mon, 02 Jun 2025 21:10:24 -0700 (PDT)
Received: from MacBookPro.lan ([5.255.111.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf47c0sm78297245ad.175.2025.06.02.21.10.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Jun 2025 21:10:23 -0700 (PDT)
From: Su Yue <glass.su@suse.com>
To: fstests@vger.kernel.org
Cc: l@damenly.org,
	gfs2@lists.linux.dev,
	Su Yue <glass.su@suse.com>
Subject: [PATCH] common/quota: adjust _qmount_option for gfs2
Date: Tue,  3 Jun 2025 12:10:09 +0800
Message-Id: <20250603041009.59811-1-glass.su@suse.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gfs2 supports mount options 'quota=[off/account/quiet/on]' but
'usrquota' and 'grpquota' are unsupported.
So in _qmount_option, transform $OPTS to 'quota=on' first.

Signed-off-by: Su Yue <glass.su@suse.com>
---
 common/quota | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/common/quota b/common/quota
index a51386b1dd24..4b8052e07dde 100644
--- a/common/quota
+++ b/common/quota
@@ -283,6 +283,12 @@ _qmount_option()
 {
 	OPTS=$1
 
+	if [[ "$FSTYP" == gfs2 ]]; then
+		OPTS=`echo $OPTS \
+		| sed   -e 's/usrquota/quota=on/g' \
+			-e 's/grpquota/quota=on/g'`
+	fi
+
 	# Replace any user defined quota options
 	# with the quota option that we want.
 	# Simplest to do this rather than delete existing ones first because
@@ -300,6 +306,7 @@ _qmount_option()
 		-e 's/\bpquota/QUOTA/g'    \
 		-e 's/prjquota/QUOTA/g'    \
 		-e 's/noquota/QUOTA/g'     \
+		-e 's/quota=[^, ]*/QUOTA/g' \
 		-e 's/quota/QUOTA/g'       \
 		-e 's/uqnoenforce/QUOTA/g' \
 		-e 's/gqnoenforce/QUOTA/g' \
-- 
2.48.1


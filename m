Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C284C2C11EE
	for <gfs2@lists.linux.dev>; Sat, 11 Jul 2026 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783782494; cv=none; b=PEV2MgDUyfRc/TR+fey32gGeGWtfPPlrxPRCpdOoTy7LKVJxrGcBKzNhcqsuYfIJq4lxs68CsflSE73EZWeMfREFG0Iii9UYmDie7ENZs9wb5UY0t6vweHKluefda98IZSNEaVifIZ3capclXvzhADYrjXX6ed1kzIbggcc3AgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783782494; c=relaxed/simple;
	bh=CdhefricwWhFH7olfPqmXW38H4i9Ji9hk0aWVmUDFfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EUUnHdfLDpSLC7ngsN4hsmAYcHgks/F73OIanW91QSoMNu6kweSWNXUiF1cKdFuwhw/hQuuHwQuwkAfuL45Y+JFn9jPzLCjUFqdNDW9husCNoub33/W9oFi+BAJDEUFgbwEgW4KKu93ZizGREwfAhFRT6J2+copwgtkEOo05ftU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8kjEu9V; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8kjEu9V"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-902f92b8504so10192666d6.2
        for <gfs2@lists.linux.dev>; Sat, 11 Jul 2026 08:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783782492; x=1784387292; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Typ9h20vIh7Ab90myOn31vTAuGHIxFcn9F7x3mbLByY=;
        b=j8kjEu9V7vmm5nD42mLw9bxzCARkb46OeRYmvvy5VRTPGk1jh4+spx4kW+0F+KWYJt
         7B8Pe5j+fz5qmbdyX/RuTa5D8rLOInysBU46uOoY1WtXorEKOQRxGn+oVqiKRuW0/PFj
         4nGj3z86GdUA0BINZ8w1s4raLOKaaez6cBGEE16NQL6YZYaQ+e6y80N7m8wW8yYolsTh
         bysoz3pDapD/VL3RKtPb+s7BkPuhA2EB8J0QHvDcOPEkBIzXoBaPvxj5iOAoOIFaEWed
         y6jL7CXimqyPDiw9U9TnwKpqX7+4WnLliSHyJ6bIgWeffjVVMOrAkwgdrbJNBc2uYRzW
         Tr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783782492; x=1784387292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Typ9h20vIh7Ab90myOn31vTAuGHIxFcn9F7x3mbLByY=;
        b=FV609VW1HyirQVuG1oq2udFqXE/cjQwoGGSidpPefr2s/mVlu0QZ8YerwX4PYyXTE6
         Ripe3cRAN6YuVlvXrhykaIB+jqiyAmBdUQg5A/O+7U8kKSbl0SHLXNc39i5ZKYmPNG+w
         qPJeec81TaPjlTjcYLDSgezsbkqY0RCSQP3nNsDe2r7JjL3LErJFnUIry5kjQjZxy1SV
         KpAjUlBplLYeHtnSGfaHPU6+EOWJWBuK91jYPsCYaeMbQokH4tXdm5n+Iu3/22d6y1+F
         fQMLO0sBMq6sgTChJYkhIkydgSxb+/c0IP7NTqEzerj728A5uXWBg5K+YMTqZg45KDQX
         ZBZQ==
X-Gm-Message-State: AOJu0YxhJyIbWqBZweBZzBbSGNd4mGM/Cu7AKL+IseuH370s+tbsW08a
	Q97GQreOVWcSxB31ckm7MwQm64OmSvWE2+2LnIsXaWAtaOXowLoDJ5j7reCEzoCI+w4=
X-Gm-Gg: AfdE7cmA5xd1GWNZhVyueRQGM7+w050IZGAvx1qZr51ml0JLAs2p3iBwcxMxVCVA/Ua
	zWhoaQcF/bFbEf2qznP76TiP3cPcKB0JJxm7ozyskUvFI7meVeIZ79xCnyMJhXDZUlF9ufWXIWt
	LMmDhPudGjZzRKXmCtedlw46ayD+5aVktYL9OpGo/TXJf3I2l0Rjx2YbFhBTlZnTZUpqtSjQhqx
	pyHhboQGudPaaBPS+bq86KE/x/vh5StYPnHwRHgg59pCL9OQ3zSCoFyDdWmzdxFtAyrDGsILTbg
	hfnpMw70jVlg6ytgchNvRskMsapXsC7foRBsYZyH7YCjyzoIx/1VGPt//1FcuuTrvQ8L4g7jUwE
	Wv/J47HmRT5L4BFO8UxS16A7pXWSrAw7dWtwL11NgJu8IqYe9a1Md/KaER8I/vqhwweGJ9to2iS
	OH44az7lUw0D3pczpB+zlyIHgfsGARSjfJ+3gm8DR5pEkb1oMI7AHwGQTMDaUQAZaSPF2GvqUrl
	r7Ym0PtwQ==
X-Received: by 2002:a05:620a:608e:b0:92e:93a6:4eaa with SMTP id af79cd13be357-92ef2b567c1mr345018485a.32.1783782491736;
        Sat, 11 Jul 2026 08:08:11 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd57baf98sm69401616d6.17.2026.07.11.08.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 08:08:11 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] gfs2: reject an over-long name in get_name_filldir
Date: Sat, 11 Jul 2026 11:08:08 -0400
Message-ID: <20260711150808.2919076-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

get_name_filldir() copies a directory entry name into the caller's fixed
GFS2_FNAMESIZE-byte buffer with memcpy(gnfd->name, name, length) without
checking length against GFS2_FNAMESIZE. A gfs2 directory entry whose name
length exceeds GFS2_FNAMESIZE, as produced by a corrupted or crafted
on-disk directory, overflows the buffer.

Impact: an out-of-bounds write past the GFS2_FNAMESIZE name buffer (KASAN)
in the NFS-export get_name path, reachable when a gfs2 filesystem carrying
a crafted directory entry is re-exported over NFS.

Reject entries whose name length exceeds GFS2_FNAMESIZE before the copy.

Fixes: b3b94faa5fe5 ("[GFS2] The core of GFS2")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 fs/gfs2/export.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/gfs2/export.c b/fs/gfs2/export.c
index 3334c394ce9cb..7b28f1eb9ad0d 100644
--- a/fs/gfs2/export.c
+++ b/fs/gfs2/export.c
@@ -76,6 +76,9 @@ static bool get_name_filldir(struct dir_context *ctx, const char *name,
 	if (inum != gnfd->inum.no_addr)
 		return true;
 
+	if (length > GFS2_FNAMESIZE)
+		return false;
+
 	memcpy(gnfd->name, name, length);
 	gnfd->name[length] = 0;
 
-- 
2.53.0


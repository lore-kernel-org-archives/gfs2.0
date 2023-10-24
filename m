Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F0815484
	for <gfs2@lists.linux.dev>; Tue, 24 Oct 2023 07:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMp3SRcJ"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40859dee28cso22627395e9.0
        for <gfs2@lists.linux.dev>; Tue, 24 Oct 2023 00:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698134141; x=1698738941; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y+18Cg9WmaAh8a3daasUHdD04vDnvoaOPywc9c9gIuw=;
        b=OMp3SRcJ8GDaKCJtB6bTWLdrG2rjh5TjG3P+Hu8X9eQWI8TR2vV7E15STdmWAvWNth
         eRdDg6hEgVe5bZvhX7zK04pTOIgpjO1KgIdsy49wGQGxHM1PRAvrO8bZAe/qmNXCKyRU
         I7Fo0RN3TqQDD6ElPKKc6MGowsna4UoPYXTzpXRGYQm3W+XmHoBA7KnOJKZkzQ00okmc
         vd5aCCUG4o7gc/zSouitqg0e5LXH9I+d6sKievtr60oyjnmGrCzgzlffxpUYiBmXMm+k
         j9dlQPteG3Qb9CGhVvQ4mTt+vyNb5OKdd/w112VF78xo+PP7AC5GXq9IlHfO1QIxRFSM
         pwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698134141; x=1698738941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+18Cg9WmaAh8a3daasUHdD04vDnvoaOPywc9c9gIuw=;
        b=e9C0w0rCUf0sqJjSKc/W7/jgkN4/FpqAGsRGZq5A2fWpyGCC8k/z5DRI5Pa7tDI1h3
         Kx4PdRJkIP0OXDc5sJUehk+5Z+QM5Vdg1k0m6IuvX2a9GoHs1Y8W0RXJV/fvnnfV6Qk7
         dZL1+Q4VnASUKFWn+XY4r9hQhuE8dq0Ukka5YrUIGX5XeOOz3WL8V1pTC6CuFsE8mdrB
         2z4XFr6CY5HIHpTYAlF139f51A8oXYVWhmUHC7c5wj1kW90MFYM5daBh4EKtHbEmS1qD
         5dZjKHEeezPMiwHAHMY7br32rloCEsI3oixRAmfaLfTf2WE8ALy+tfcuUT5gHcfoPX1b
         4adA==
X-Gm-Message-State: AOJu0YwI7c9GtbyDiGzsjkU5dpQfYb8DbgGQvdLbK198V9nKL7SysX5H
	Z1cItApPdHwOoE+TwqafWkE=
X-Google-Smtp-Source: AGHT+IGHTmUr+pgzGDmBFz1x75w99MYvBGvhAeWEJxniTpOSArnqI1lUIZkOJfE6woIeL+zwVQwkKw==
X-Received: by 2002:a1c:770a:0:b0:406:53e4:4d23 with SMTP id t10-20020a1c770a000000b0040653e44d23mr8604561wmi.23.1698134140800;
        Tue, 24 Oct 2023 00:55:40 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id iv15-20020a05600c548f00b00405c7591b09sm11376199wmb.35.2023.10.24.00.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 00:55:40 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Bob Peterson <rpeterso@redhat.com>,
	gfs2@lists.linux.dev
Subject: [PATCH] gfs2: fs: derive f_fsid from s_uuid
Date: Tue, 24 Oct 2023 10:55:35 +0300
Message-Id: <20231024075535.2994553-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gfs2 already has optional persistent uuid.

Use that uuid to report f_fsid in statfs(2), same as ext2/ext4/zonefs.

This allows gfs2 to be monitored by fanotify filesystem watch.
for example, with inotify-tools 4.23.8.0, the following command can be
used to watch changes over entire filesystem:

  fsnotifywatch --filesystem /mnt/gfs2

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Andreas,

I do not have a test setup for gfs2, but this change it quite trivial,
so I am posting it only compile tested.

There is no need to test fanotify. It enough to test statfs returns
a non-zero f_fsid, e.g.:

  strace -e fstatfs du /mnt/gfs2

Thanks,
Amir.

 fs/gfs2/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 02d93da21b2b..ea769af6bb23 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1006,6 +1006,7 @@ static int gfs2_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_files = sc.sc_dinodes + sc.sc_free;
 	buf->f_ffree = sc.sc_free;
 	buf->f_namelen = GFS2_FNAMESIZE;
+	buf->f_fsid = uuid_to_fsid(sb->s_uuid.b);
 
 	return 0;
 }
-- 
2.34.1


Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E20A358D2D
	for <gfs2@lists.linux.dev>; Fri,  9 Jan 2026 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949603; cv=none; b=tEso2xQZzN/EFA2A30od1/uPXbfwQ1QB32gbFI+QHAsB/sLn6rcRzdJ+nQj2axeRWikGbXnb0hvr4YtJYIsax8HvKCdtk+6DszTFGsDc8vc8zHr7d6B08hunyGaS/s3tq1PdOImmP6c8egNFEbKlNgwN0fFKJtkIkwD1Wdrbz0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949603; c=relaxed/simple;
	bh=ZeGpXnjcrTtobO6hhK0nwB8JMXXLrCTQ45sGSxN/d9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lMzcGMM9a2Q5ksqUWJBklOXDg8qmNT87koGZk8kMOakAvu/SZzSsl/BawG9ANLnNCXZD0RdKKkG8jdFI/i5PodZlg7ILlh61CgqMfxDEfRRfTOO+P0TJpcT7BN8MALjvIgjdNjtR8E1mxDs3skOBNobnmsx0xp6OxTz0exZsAOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMivrKB5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMivrKB5"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a09757004cso38930005ad.3
        for <gfs2@lists.linux.dev>; Fri, 09 Jan 2026 01:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767949601; x=1768554401; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zHdwqOtUpAqHW0rJJcMYRLOZO0S8eE+97yQEJQIbqms=;
        b=VMivrKB5nLncbPGRXeF1brcqigCKy8WukwCMCc9vi/Di6M8Cm7OAquGn0kB5GmGKD3
         HqM6iTIftNIBwx0abNU+qZLQnAP7I4B71Gy15OSPdBb5HvziDiOzQR1FvyCBZVljjiUP
         3lCUCYj/JQ6vAx3qXk9w3JSVymuKhrRI99C7PWCOealpRUhgVPjeiZoWFbfOz60+K59D
         WDqK/wR6vjMr8jzicHDy003lhyTEeAdM3eBPK9MOvusIgdaWSZq72zqFDPVb41QYgivE
         Y7xywkJ3Z3mvjOcDmp9uRDFOm2GUaKo8a7FUMdN7q9nNQSjdZ/jCtbs0ZCbIZGRCuF+0
         eMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767949601; x=1768554401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHdwqOtUpAqHW0rJJcMYRLOZO0S8eE+97yQEJQIbqms=;
        b=LjSn5x6Mfc2gGqrUJCiJv9kPE2voazCjrLBD9wsO0KhJS/K7SLTkrviL0PEuzxS49e
         IJfi4lnTe1sO3AojZ9OXa1g9CB5UZ5D3dFq2eHGMxT3Gh61IqfqBtpzezomo6/Di5Gl+
         DRJrKFHll8e7mJtuSfV3sTJxx5lQpvNPZJTgcQ9beUQWz/Y1I5O3Qj0lFA5OBYxGnVpB
         sWphPX3D7d6hbHkBL9ZxYNeLaW5VxyBNCyb5O9DwBwCkc82bUaXo4xGjrG0uiYLX46xI
         KpEvL1SzAw+tXNh9gMsLQjqx/eVpoxETmznSmp8CzddTcBcJBD4suUcCcu4I7oYr56kg
         AVtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFhv58smP2VjlPOLh/tUwRprJOOOnwZIvIM1EmBJKTX3C7ghD608WCx/De5ylOtFapSwUG@lists.linux.dev
X-Gm-Message-State: AOJu0YzLAoVEEDFhPP+3TnC4VNELxg3noV29BzggQl3heAO2q/hT+tRM
	uWn3vAtqTim5DT/sNPdvRjffNVCxswpMgS+hYL/ocS4Whj+b8b1hC8z/
X-Gm-Gg: AY/fxX5CfptG1Ry6g7UAvVjoGUwLJuMuUXJpZpVjsv84JyONLQ3HNz6GZJJYe+ZVRPW
	LLi2XVlmaeI9Z87DbFraJ3zxizxrFlxHI7KKq+UKJWh7SrB2gO0vRYraA3IjcEBwziTPbIfn3Zi
	DT4qkh/N7vwiRSRYx/I3xbGORK30oKBSmXPZoPW9we12+dvcJUbesSRXEQA6+JjSYBxUz7AUxym
	9Qcbks8T4/TyC3w/y1pt3sFhGdpPeU6K8+Xb0Jc5f56kzoh26mrtSX6ROp7l9/jtC7rzPOslUI0
	+Lnsbx+ICn6C6VjIiBvm8dFyW4jO/VZsz5gbXcYW+5NYZAMh2SKPzr/Z2QfBbkbfo/W+Rh6e4vw
	o1+HAfJDSsYbASJjR2C+gVHYlvCCjUWbaAGEZa7t570TwvPloxmZ6zvnYTtHIdS+9DvDW21uwup
	wM8/KgYIyNJa0FDA==
X-Google-Smtp-Source: AGHT+IGd/fVnZk/mW4OzifvSyAq0m9cCwEVZ09jkUi2uhYlbtTbqjUnefYPEx8kI1lVi9cI5NZ3AWA==
X-Received: by 2002:a17:903:234a:b0:298:2e7a:3c47 with SMTP id d9443c01a7336-2a3ee49c6cemr88131595ad.42.1767949600794;
        Fri, 09 Jan 2026 01:06:40 -0800 (PST)
Received: from localhost ([2a12:a304:100::105b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c491e7sm100826195ad.38.2026.01.09.01.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 01:06:40 -0800 (PST)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>,
	syzbot+092ef2e75c24d23f33c4@syzkaller.appspotmail.com
Subject: [PATCH] gfs2: prevent sysfs duplicate name warning on mount
Date: Fri,  9 Jan 2026 17:04:45 +0800
Message-ID: <20260109090451.1464893-2-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When mounting a GFS2 filesystem with a locktable name that already
exists in the gfs2_kset, kobject_init_and_add() triggers a WARN()
and a stack trace. This can be reproduced by a user attempting to
mount two different images using the same fsid/locktable name.

Check for the existence of the kobject using kset_find_obj() before
attempting registration. If a collision is detected, return -EBUSY
with an error message instead of allowing the kobject core to
generate a stack dump.

Reported-by: syzbot+092ef2e75c24d23f33c4@syzkaller.appspotmail.com
Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
Note: During testing with syzkaller, I noticed that after this fix
prevents the sysfs WARN, a secondary "withdraw" warning still occurs
in the GFS2 cleanup path. I believe this is a separate issue.

 fs/gfs2/sys.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index 7051db9dbea0..06035e3d5829 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -720,6 +720,21 @@ int gfs2_sys_fs_add(struct gfs2_sbd *sdp)
 	sprintf(ro, "RDONLY=%d", sb_rdonly(sb));
 	sprintf(spectator, "SPECTATOR=%d", sdp->sd_args.ar_spectator ? 1 : 0);
 
+	/*
+	 * Check for existence because kobject_init_and_add() warns
+	 * with a dump_stack() if the name exists
+	 */
+	if (gfs2_kset) {
+		struct kobject *existing = kset_find_obj(gfs2_kset, sdp->sd_table_name);
+
+		if (existing) {
+			kobject_put(existing);
+			fs_err(sdp, "fsid %s: sysfs entry already exists\n",
+			       sdp->sd_table_name);
+				return -EBUSY;
+			}
+	}
+
 	init_completion(&sdp->sd_kobj_unregister);
 	sdp->sd_kobj.kset = gfs2_kset;
 	error = kobject_init_and_add(&sdp->sd_kobj, &gfs2_ktype, NULL,
-- 
2.43.0


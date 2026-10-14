Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E294921BB
	for <gfs2@lists.linux.dev>; Wed, 14 Oct 2026 09:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968570; cv=none; b=sFwaetROgcdYbaBUO2txbL+keHfr9WxQjJT1WYVV/wLJYXhSI0sY7x3ZrYQSkQHlz72KfY4WCQZa9rnNoOmLJizAQCALLBP6l/4YmihtW7WDvjgTBZNYmIs4c7taCupo0JOTG6tVDSbN4x+hBkkYL3GPqKAyj4MqVDdUOXMVTyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968570; c=relaxed/simple;
	bh=lHYdUy+fPjbDIamKXXSZVXQStz7GcmUwURwRKXS+W7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zy+f/FdqiWdF5mgRlAB5Tcm+w+gdaUFRcN9vQBpt7MgvauN3MObeZDRL2v3iXkb83Pi9IIVkTihAGongX+i/zKNuhlC+CBrDXw3WJmAs8w4O6NLoSe+zur8APrfO/dFUxkue7Pm3RyrAsxX9K6Du7y6cQY9imxi0vObFAydgeCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9d9GKoV; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9d9GKoV"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3a4b9732d5aso2941476a91.3
        for <gfs2@lists.linux.dev>; Wed, 14 Oct 2026 02:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791968563; x=1792573363; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mvGRNBwDPobPO7nwXeOj3RUpnQAXQpmRmyxD4LJ1RXU=;
        b=D9d9GKoV0WLoJdcbKsyU9zL7ewfcecH/f5P/vrnKju4Ao3aRQcqGddsLaEh9uWn0cV
         eVetFOZcEHDquNWsaMD9cZ/W/QSrXXmg+yPwOh98REwEzGM2h7yyRIttZEDKk2Wpw5/l
         QcCcCSzisWJzi2DZ6LZjxX93QUMvFSWnmFQSSUWBcBMyKykhI/d1RlMIIWcXLTkdmAhC
         TfW6KHGkZxZ/jdwvMQUydIkIGZ80MNBjyZhVykv7+ZDG6sS/k9tKSwgRkIcnxOsBbQte
         O+5PrGco5re4w0BxFsZ5m1ZGkzrJmEcZ83+L2VYjeIvMdeZl01xa0owfA75VPQ9MaOoP
         K4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791968563; x=1792573363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mvGRNBwDPobPO7nwXeOj3RUpnQAXQpmRmyxD4LJ1RXU=;
        b=AAj387QWkzakVa6Twm88nsC7nD1UFM0E1ZdajT1foNbO4H9JU2xJMSmXDawzJDmdr6
         2vJPMEJUZg1HCm/WMPkpqOdGuf6VMXWzKkidh+8K6BCDihGx1dOXCQgj8a3/zzg6z8hs
         HkyapVvdZNaK6af9R5aX5zIgtKDria0MCxiFl1xqnhcEMivk6/OKbHm2QBafnth/tDll
         noQqk2II/eHlVaIgpfotAVDJSWmLK9luzKjwt7y//qB7/teZ6WreRjWZPfKGQu6y6MwG
         RsqjiQg5xJ5YH/jy8OBM/6KRgsSra1YBf6M8+l8IPfHEaWjC9ps3rOtJ72c3sloSWkhH
         zjyw==
X-Gm-Message-State: AFq9FYKKIhRIRciEOZSpX2hvG5+bvhRsllxC9hJQAMPIjTnp8TEVeYtU
	42JfBqZT7lUHRLU7IWtiC0a1AX98hbA4YL9p1D9OqZUY44+pXJaGB19Q8rGAOEjC
X-Gm-Gg: AYBFou16lkskdMSL3Yw+jS3+89JoI8nkqBjYeyeie/5ILA0e+2IbsassuzQfGF2TISi
	Vp4nAv1QiKi7RJuvSCwHau9G1wH2yFX0svjniqZi2g2A24lVC5mftSO1H+qcn8XEZcs24FdovZo
	AM+VfWTkBXf/xiiDbi1KnooE6ZUqKpTMT6zooXzy0+nFBxClY8NRtGM+ugAu1emnJFshodQxfWB
	ZULymrIDqZ4fSmzoph5y94s3OOGoxAzVTEqauU2dFWVB8v271zjoZRTM1lyxlg14qX3TYyIRifm
	KwwAWzsBp6VE4sVfOzlFGjQQ5B33usDL2kJ19qdPeYW2a8ewkdJO0RUXLsTwVhi+cEzKFXChMLP
	NnRyWjLqRJsCu61HJqxLZncf8J+LeYAnhgYjGC3J/GjHfwK1+7Y/K8QlXN+wuDwHyv4/5/qRdHe
	tnwBeQEiIrHG6qxyIB1i/F8/alT8PuTHQoqCKk9d7BU98GbIEeLGWm1f0u0posV3Mr1Q4+dapHz
	tMXUh1E2o773PajMOrPhCMWiw+8v3dCPQ==
X-Received: by 2002:a17:90b:4b:b0:3ab:1e1c:837f with SMTP id 98e67ed59e1d1-3ab3ac59383mr11813233a91.47.1791968562735;
        Wed, 14 Oct 2026 02:02:42 -0700 (PDT)
Received: from DESKTOP-UCPRL76.localdomain ([113.200.174.120])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac84150036sm440921a91.17.2026.10.14.02.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 02:02:42 -0700 (PDT)
From: vienna-0FFH <viennaoffh@gmail.com>
To: Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	viennaoffh@gmail.com,
	syzbot+04dfbd15d442517e713a@syzkaller.appspotmail.com
Subject: [PATCH] dlm: don't warn when closing a node without a connection
Date: Wed, 14 Oct 2026 17:02:37 +0800
Message-ID: <20261014090237.395-1-viennaoffh@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Opening and closing a configfs comm entry without ever configuring an
address for it triggers the following warning:

  mkdir /sys/kernel/config/dlm/cluster
  mkdir /sys/kernel/config/dlm/cluster/comms/1
  rmdir /sys/kernel/config/dlm/cluster/comms/1

  dlm: closing connection to node 1
  ------------[ cut here ]------------
  !con
  WARNING: fs/dlm/lowcomms.c:1455 at dlm_lowcomms_close+0x12d/0x470, CPU#1

Since commit 6f0b0b5d7ae7 ("fs: dlm: remove dlm_node_addrs lookup list")
the lowcomms connection has the same lifetime as the configfs comm
entry, but a connection is only created when an address is configured
via the addr attribute. Removing a comm entry for which no address was
ever set up is valid and the resulting close call has simply nothing
to do, so it must not warn.

Reported-by: syzbot+04dfbd15d442517e713a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=04dfbd15d442517e713a
Fixes: 6f0b0b5d7ae7 ("fs: dlm: remove dlm_node_addrs lookup list")
Cc: stable@vger.kernel.org
Signed-off-by: vienna-0FFH <viennaoffh@gmail.com>
---
 fs/dlm/lowcomms.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 2aff1c7..86c7af9 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1452,7 +1452,11 @@ int dlm_lowcomms_close(int nodeid)
 
 	idx = srcu_read_lock(&connections_srcu);
 	con = nodeid2con(nodeid, 0);
-	if (WARN_ON_ONCE(!con)) {
+	/* case of dlm_midcomms_close() for a node which never had an
+	 * address configured, so no connection was ever created and
+	 * there is nothing to close
+	 */
+	if (!con) {
 		srcu_read_unlock(&connections_srcu, idx);
 		return -ENOENT;
 	}
-- 
2.43.0


Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85422392800
	for <gfs2@lists.linux.dev>; Thu,  5 Feb 2026 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770282394; cv=none; b=XQtBzsHNJusDh2UfEqOKEhcYImQDSCfuqt/634yCQgH2iGc3H1ZxpKm0c909nVTlhbu4kjAdvgTJQR4G1K0AKAuvv/NXlSr+lKwkgYKn7noRCkLbu7J5yb5JVR81edotrYcyaCrYkg4tDTuAlPQLBFPySdL11ALDHv3qWaYbAXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770282394; c=relaxed/simple;
	bh=lyo6nqDDqj6b4jw4yDLe1kuUBI4lfxRinrjxZ6Tk6R4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WhuTDxfJzbJMaOKhn4+fAD3aVqj2nkiY4aX+QFPIpsFkJwshaN3CDP3+XhnjWwPsjD0UTJ6X8wXxac2cChXYGGfQyboGH1CKm9bkqn6dB08fCDdF318Upcc3OlNnX/sRDk2T+f9koOo92wYcSlA5awlgBARjSCV4pFoMf6TqiKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaR8mw4v; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaR8mw4v"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-81dab89f286so370943b3a.2
        for <gfs2@lists.linux.dev>; Thu, 05 Feb 2026 01:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770282394; x=1770887194; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hNpFgt4G3myXpb9M3EBnCESjMOaUpwOG54Qogd9Uao=;
        b=aaR8mw4v6yo/+g9X9LUYHAUGGaOoZvP+7J6qYbaKTU1W1vgMdpI5R3Z9rmbBSqy63Y
         hujlgPbR3u17R2vj4LgbtvY2gGhIht3bcFMjXh8lmo2chh0EgjukGwqfe5szJIAZj9M8
         QV/ulFJcuBNPoqUz3HA94P8Di93en7JFC43dXkqs0x9p6piDms45iVAygH6tuVceocnj
         GiQx/8rETFbBu0yAHs5BylBDPZieKKaNTQeM6OauH6BMvuOyzVhkGtvC3v7iHzeHcYeC
         2/lQB/HULZjqHzCKqMa9KziTkUsDWlP83k7xUy004pHfGa/IoSeYL+m55prNVlcug71x
         m++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770282394; x=1770887194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+hNpFgt4G3myXpb9M3EBnCESjMOaUpwOG54Qogd9Uao=;
        b=mF7fNUf/lX1m88r4wSi7X831fta76YMuQHlVvSMqUvmRrVRbysstfVOTe+4Vu+O77+
         yKzcdYAFOmce+5rfIqm/IDQb5g/iTRqkEV1efHhMymI3syhAuQ03/L/bQomYF3lkj6OS
         3YSgna6AaCxF9x/bHqorIz1bKdh/Li4woNI8t8NG+fpWKUOY764kDueLS4Me08lvit1T
         EKJxkArEJ8jFK8GSLtii3CCUUIxzeZyYAjsTCty2HqMtPiioO0+PjsOodC2ftNblMXbQ
         kZbw3qx91KrMmahsFHSk6ZdCSn9v+t1xnRCE5pyghZVOBQ75ReSlULgYDtQpvyjTJ0dj
         U6zg==
X-Forwarded-Encrypted: i=1; AJvYcCUaAe5VWTemMeHc6GnhW1WKDTxnSFU2uAjHHXXrzzUGISrmNH+RF7wsmhb4rYVpZsQAVilT@lists.linux.dev
X-Gm-Message-State: AOJu0YwFxNUSjNeLx1PdFOLKgczDHv2qSw/DxXBurMKL5sMVHmfFCHz/
	wx7laR2Pb7AtRu2i915B/UbeTcTRwkZ0KkfaVHSceJVdljsZBByXfSmR
X-Gm-Gg: AZuq6aLf8XuBXjaiFDkMzP094lOf6H38dccGVyRThsciq7fFIsxpdW9pxrP7iRn6ef9
	d87agoq+J0Ik438vIgXo9subWiCCKPqO2uo8NU2yvOq+zL3/LEft1PHtyeHgZE5s0ksHEABdUb/
	nHeDZgsb8VqV/9aHcRyA94tJc0ugIfHWohDbuYwz2/H9Lq32osrrIE+Un0BGpbXHeO50UOjR52e
	r47iNCor8xgg0MpiGmDRC7R+XKs7yGmRpR2RMQH2q6xKueN4H/b+hJLC7dcOJe6IExeVShIbB8+
	5xAMU91JSoylYwpcuWw89k50JxzXF+EEXA4TMY/FNYNw5tdIjr8Vp508q9JbAhOc1uYXB5fmKNy
	BX7NmoZwReaL6U4dMAIA10sC1gVvS/2nLVik0uc9ZI8IeOFHapqCcSyYDvJvPdkp/xVi9QFCW2W
	LGkx0VlC810ReOITTd2qoUzD4N6bO0n3sHq+WrMJJ4NaNccMBH
X-Received: by 2002:a05:6a21:3513:b0:38d:fe2a:4b0a with SMTP id adf61e73a8af0-3937211de01mr5900451637.33.1770282393777;
        Thu, 05 Feb 2026 01:06:33 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.212])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a93397c2fdsm44397615ad.87.2026.02.05.01.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 01:06:33 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+e57495fb65020ac7bca4@syzkaller.appspotmail.com
Cc: agruenba@redhat.com,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [gfs2?] memory leak in gfs2_quota_init (2)
Date: Thu,  5 Feb 2026 17:06:28 +0800
Message-Id: <20260205090628.1105496-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <69837ac0.a00a0220.34fa92.0011.GAE@google.com>
References: <69837ac0.a00a0220.34fa92.0011.GAE@google.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index f6cd907b3ec6..efa0e2452bc7 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -147,8 +147,10 @@ int gfs2_make_fs_rw(struct gfs2_sbd *sdp)
 	}
 
 	error = gfs2_quota_init(sdp);
-	if (!error && gfs2_withdrawn(sdp))
-		error = -EIO;
+	if (!error && gfs2_withdrawn(sdp)) {
+		gfs2_quota_cleanup(sdp);
+		return -EIO;
+	}
 	if (!error)
 		set_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags);
 	return error;

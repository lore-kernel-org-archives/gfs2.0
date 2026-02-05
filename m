Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB08275844
	for <gfs2@lists.linux.dev>; Thu,  5 Feb 2026 06:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770273112; cv=none; b=U1+X/gFuX2LEpO1iv3hPPZfU7cIk0dGWMBTXw8QMdcxbyqFetGOTfIbbRrlTKauFjXuBCrl5jgG+CUv3CKR9cl2we4zlaA2twqf8xWTrzKSdv8voCC1d2qtrRC8MzLtLouSOOA8PyOjxRI+JNIues6hVTPNjJ3QO1eXYHbmZj5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770273112; c=relaxed/simple;
	bh=D2FZGnks1mhd70ETt05smEqAwMkcsbqYZmg9z0sMIEs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hbTbmKMfFPRDEoii+NeanBaPXTcLqliq/grMTYeXWRIODaiY5rp+SmZCt4FVXbYvgdWwp1OFWRviOshrQF5FPkh8GrhJC9LWpyDfVnEQBm2YUFurtRrJVrkXOUhLGn4HTkgK4xyrgaY1nH7V8sNmiz9MZLOXTN9qRkw6Utksnpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0iMEBFg; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0iMEBFg"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-c61343f82d7so193862a12.1
        for <gfs2@lists.linux.dev>; Wed, 04 Feb 2026 22:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770273111; x=1770877911; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IzNoHDjJv8QcXTrk47DlqDi/FcMS1AAEpRJRBBFpgU=;
        b=D0iMEBFgSFDJwrdS7AsWF8e24WVmQ2ALoG2RgUGcXfpkgS4tT8ovO3awRFrFCtaGng
         TehOx7YPhmvsiFt2K7KnmZ0JqYy77GzK4f7z5l/8eY/POU7j8pjwvMf47o3UFhkq/Z/W
         frMFjEVmS6C0+XE8aOi97F/urjVvXRBdKzlvYpMAldZMt73oxbr11VQjmN6X2u1QDu/v
         KMkDc8vWKyvEgX4UDcQbBBorBxLYUiPxo09seOZMLCBW/dkQWMIJMk9PIZUVrESDqbLz
         tq85cGJIKiNo4r+4bK7WEkjNx1O+o7ONRRl4SqQ+dCnWaw7X0OrQg6pvAKG6Ibbq/Kh0
         5qzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770273111; x=1770877911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6IzNoHDjJv8QcXTrk47DlqDi/FcMS1AAEpRJRBBFpgU=;
        b=EEN5VjSdN8f/lymR9QJ6WRidmgMNIe+gPysWbeNBp16K8eTJw/AL925EXwsh7hr8kV
         HwzUIz6UDbB50Hkdl44TJYcKS8X38mozHvllsIGidqHEZV+ZXG24BaesF1bcHVEw4ASd
         dMDo0rWZskl3dGlaf8eGi7SINIfy0HX1GsEnXnHZ7LD1P1GojmY2XyOtsPACeMqfaEHg
         mQyY4Qg9sNxCqw1qmhw+72hkT6ce3JZAp2j7CRCdagEfoit9L4hxnQtCNZaFL321Y4es
         agjAo/EVGZlbsFYjcUNEq2fhtYSj35SE1UWYNiAEecLJ3OOjqsz5Uhsm916/zrf3E0ZP
         krUw==
X-Forwarded-Encrypted: i=1; AJvYcCUKMb06SLdc17hlMu3nM+kWBu5c0PYzi//yhXAnhzjfwprJVygnDDxwdGy0tba2L3Ea93lq@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2FDAE/x95OtxaAaFZBC1HrmjbqberDqCpcXtnm9chO58CqIys
	YNvyK4gas+rNlvMuJJnNce9KCeEV21py5KAbF9KpkxxvREYTCB+nlJNJ1T3BcWlBv1I=
X-Gm-Gg: AZuq6aIBloDx651UMeDEGDiXGd34PkBdregq7Zv4nFI1xLX0PKC2EypHiSzBEkpNNwx
	RIrnXC2p1HRwCIjWA4UXSpTwO20orMDXth3SeSvbDptRnfE+QXBAELE9FSXOAqfBsPRS1JtSd1X
	gqH7jZt1Mxp1zrwgqopqqz7hw9GKPlUb7O/U61PPraECZEJUSzL25EPdJjdjFZ+YkinrMdZNS1X
	QWqVQhtTyxdcO8zWV3gq4yXTrf9Ssct4iGjHm1FihwIGye0euulwL5DRDMWUaJwTf7Jk6Dy/iFW
	9Waalv9113+Lt+0M+KTPtEaaNqLJdhfFrldPQSWu3+nQt8QH0BtR9B8cy5ANKT/mDqki1Pwrzv3
	KDpBeQBm7fcvrY+nXxjXoOWPUB1YSyTBOONc8niJSNSLiaqp+oB+/BOaSlIgZQA1tGqHGr2GATj
	eWaNBszNmmbKlStd19d+vGLxJltcZSvBuYOLU74w==
X-Received: by 2002:a17:90b:5870:b0:33b:a906:e40 with SMTP id 98e67ed59e1d1-354870a5b6fmr4816464a91.2.1770273111310;
        Wed, 04 Feb 2026 22:31:51 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.212])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6c83127962sm3796413a12.10.2026.02.04.22.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 22:31:50 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+e57495fb65020ac7bca4@syzkaller.appspotmail.com
Cc: agruenba@redhat.com,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [gfs2?] memory leak in gfs2_quota_init (2)
Date: Thu,  5 Feb 2026 14:31:45 +0800
Message-Id: <20260205063145.1039526-1-wangqing7171@gmail.com>
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
index f6cd907b3ec6..1144720a17ff 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -149,9 +149,12 @@ int gfs2_make_fs_rw(struct gfs2_sbd *sdp)
 	error = gfs2_quota_init(sdp);
 	if (!error && gfs2_withdrawn(sdp))
 		error = -EIO;
-	if (!error)
-		set_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags);
-	return error;
+	if (error) {
+		gfs2_quota_cleanup(sdp);
+		return error;
+	}
+	set_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags);
+	return 0;
 }
 
 void gfs2_statfs_change_in(struct gfs2_statfs_change_host *sc, const void *buf)

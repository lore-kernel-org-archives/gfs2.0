Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793753735;
	b=pl+6n+r/EowVeX/dxNB5QdrWOydLAOT/Gmq0fQ6wuI4vUHNlXByHPDjKISn99b2MmgoB
	 ZzdKQTMXbo0YdKGI/hLSvs/lemf4BYzw5f2hvtv3J5G7gPsRskt8TqDhmz6v9OmMyD5Z9
	 Ue4XYgP42nJe+IP7DMq601z4aK29anhUapuwR2E9IzQRnnjkBDQavNPP8ooFUTjWxqY8v
	 +d6VEHSEYlMMYbWHajwP0+J2QzVqnDGwyrDKLVvzA4j8taSC9uSiJIFsrxa0Sc309Mo6m
	 mA9YHAowwJ2MaX4pNZlsn13iaqCuR7RoIq2eU5A1kPRx7PONKISap4PfmsvSYbfTttQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793753735;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=xG5t3xikeZrgWEXDIQ9E66WF0APj2TRUKkrk3j8LkpE=;
	b=BXn0dl2+516IJ894dBevE4plVt/AL0vl6HsfZhS9H4WGWXzKpUVgOCqfLj1vvcWPkZRS
	 pFDvsJD+5nwQ8YwK1EL6zkLqDnYG7yzLylecHS96QCdJFVoYu9UD0pjeXPgrRs31w5KWC
	 0fnICapoNp33xzaNgRrhQ/HQw6eeWtv0zyopeT+JLom9nnUDnFgBYkQDo76AdS9QoXkMD
	 EpaASiHDxhepMkeJp7qM5xj9e1/pFzl0GJ2/jJP+flsTKOnRBkGeHDK77yiVYmbaaYGzQ
	 ajmL2ALMMRVnZVzHUNWLJGS2NmyxFwAJUBR3D+7pOrbNepdMawVQGN7p7qgdBkmmErA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zuUpFt9J;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F92606A335
	for <gfs2@lists.linux.dev>; Wed,  4 Nov 2026 00:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71F92606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zuUpFt9J
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b07db03f41so137703a91.2
        for <gfs2@lists.linux.dev>; Tue, 03 Nov 2026 16:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793753734; x=1794358534; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xG5t3xikeZrgWEXDIQ9E66WF0APj2TRUKkrk3j8LkpE=;
        b=zuUpFt9J/cFubDGclKYU2ivE6da2df9R+LlsyBBxaOu0Pc9ckPYqOCKPk+od+eEdQS
         Vj2awdXKKArotuvNTgsp+OeUygUGbBjD5gI7w0wqelC8FVy61cDF8vIBT7NlJIbO6f/P
         fgO97Xns0J3oGOHTyzGdLIGWTZFn5JIKt56sDJZWC/Sve8OFGJDdFDaw1czs5n01rKOm
         chE1AxMCMbCl8jYcyeYll+b1NKrYFQQU00U11kFU0+Ko172o/EkR08ii/5ctiCTKHf+E
         XUF0+Jb+L3tr6/Ju/KRPYe1q+VvkAVEdwsbMEI4pirY/eypE9cJHCYXG2+MAawscXTIe
         GuKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793753734; x=1794358534;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xG5t3xikeZrgWEXDIQ9E66WF0APj2TRUKkrk3j8LkpE=;
        b=B7cO+q+eRKUrMdzgV5wxGjQlhs+SWwYppdFsYs+pkNn9MEKLUwIvFweawykYOujJgk
         OPSQswrn5E4A7Ha0e4KpHCRXfie53luwggfBIZ1FVAufns6//WCkIB++owK+sFUd/oI5
         0IBbD+kRgAVVlM0/ERcOyj6J2XG6xDXGa0bGBfFNI6QYcxC+p1O83wHO9CdTfipc8QBa
         GqcuB7snBPeI1URPRotomLSHxINc68MiQQUNmSON200Iuq+3Y1yfEd0G0DT8OjjjVad0
         kFLM6ut3FG3OHEKwBdxrcAQdxTinBoi1LPgOr0PZxPjF/X3IRJKOYashgHkowYez5aVJ
         dHvg==
X-Forwarded-Encrypted: i=1; AKwUvBwPAwS+AourgutlfwxTAU7n6qIqGUvjMVtcnqKF4G/d8Qi5B+Md1aYShVz4Ja3EtkVevFXX@lists.linux.dev
X-Gm-Message-State: APuU4Z8ZTR7gJyz79wY6aJ+Nc7JbinBsgAb7h4c0djOmWBmHF4uB0eCt
	p9fzZK5UPr++GvRBKMaalKfW8KyMslwewUIaW8N5VgFQ3JsQMEvR+Xnv
X-Gm-Gg: AYBFou2rn1pZF0cSRxlzhcrTX+xPx1Qs4nuTqMvWvhnstbwMwbIwYEjZdpAmwEF5bAt
	VnX3RBiYF+hmiJVhHVx+6dZdVlAgZg/pJATvF8HGjF7mSC0IwdFFTxMt/49KwNuif1AjYLA9InT
	7GH30cI9bdk2chV6w17iWEUttVnF9yiE6TroOJDAZEFuguuLtv1ss1bPEPxtpkmeDVV8yi1exKn
	Vv22/Ycg2T/5iTW/rNvPMq5bRU1ExxFKWgJH1XXl3TsezAhwUxuB5G4SvGT32FfmcWJLr1hZTBb
	0YFhILo5mNMv0PeL2C6dgIMhNZJ8ZdPzLK13vLuFpoecov7FBdFzBHTTT6ge7zLuZRQaMNiYBui
	L06vCOVOjKBSEZFFMwGVG6WsV4EtWo/2PDqilo+nPoXduAYJoxO6SKSbs3AmUYXBlx2qRina/go
	BIrQz3xroVpnWJDnHFGjBeEcl0NnrojFCshd6KMb293OUDpCNT/c4kfg9eDE9MuzJm6dI/9P0nx
	rS3fd4uaS2JRyBXda+dJ0KRCKrX6FlMBOmI2IPw4klMLpRNH/1dveRXySfF54E90QpAosdo3cwr
	+wW5joa/wYKp3F0YBA==
X-Received: by 2002:a17:90b:184f:b0:3ac:83c1:2c0 with SMTP id 98e67ed59e1d1-3ae897e06efmr11479861a91.64.1793753733906;
        Tue, 03 Nov 2026 16:55:33 -0800 (PST)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b09445f7b3sm1222403a91.5.2026.11.03.16.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 16:55:33 -0800 (PST)
Date: Wed, 4 Nov 2026 09:55:30 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, ecryptfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org, exfat@lists.linux.dev,
	linux-mm@kvack.org, ntfs@lists.linux.dev,
	ocfs2-devel@lists.linux.dev, linux-btrfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-efi@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 18/34] ntfs: use the generic emergency read-only state
Message-ID: <auqCgguXEsKCq9p2@hyunchul-PC02>
References: <20261029-work-fs-sb_rdonly-v2-0-2f44f64f0b66@kernel.org>
 <20261029-work-fs-sb_rdonly-v2-18-2f44f64f0b66@kernel.org>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261029-work-fs-sb_rdonly-v2-18-2f44f64f0b66@kernel.org>

On Thu, Oct 29, 2026 at 05:07:09PM +0100, Christian Brauner wrote:
> Set SB_STATE_EMERGENCY_RO instead of the NV_EmergencyRO volume flag when
> an error makes the volume read-only. ntfs_emergency_state() keeps
> telling a shutdown (EIO) and the emergency state (EROFS) apart so all of
> its callers stay as they are. /proc/mounts shows the volume read-only
> again.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

-- 
Thanks,
Hyunchul

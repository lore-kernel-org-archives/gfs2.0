Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793753392;
	b=LvCu2zanx3f2oO2DDq7AqIDO2K17h2iggdn0XLpPU5PRZGemNIOyEp5kArA2DLlNjJav
	 zGRs57fns2H65dyBijTZN4bq6966Hgc1IdcW2QbUWznIZ/eNWaWf91pBJlg3exj06qJYK
	 XIBVuHe7kynj50D4NRvyHU6Vb89fUBsTp5ea6iwvGsr2TbF9V1p1BHYNMUMeHN6xylNqs
	 ogDUpFpxhh7OG/ursLGEPK7zd7M/ftQq/+1dGIVoy052WZ/TpsAsLRy0ayPZPti8JwI/1
	 PNs5T0nORVVW7ELu1AyZ2/YaQl+TKyjnI/wahBur94NHc1RycPeZsQIJK/d1u0pmLJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793753392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=/bumM81nPiENiLh9PH/Fm40C+VENRMD3A/OuAfI8Z4s=;
	b=mfhJWy9u4rNhlaSknuNJVicqW3o2ajkTvIO5VHUJ52AI2KFteDLZXlm87finr+x+roYe
	 QaPF8/MAugmOE4mjmw/6tL0r+dU/W0b3+qgNoXZ6IUa1EMdjrF2cFvFUGNZJV0GX3nZoU
	 Z0Unzp/euzan5GyOsnutqQtLM0aY2X5+mqWH+I9wopv+4E4jX0+YCwAKgXs44E8uoFkOi
	 lNkqWs+wASf9CqVCLALjoukhBHZ2dj2FIO+qvk/QonCLS5z2wwDi7fYcyTp4LPeKrS535
	 taYW4iJJVFgAvZN90rbbpem+wlBROtmE48RMpuGhX/miOLIyTktzYuDrZUqkfJfoMjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oIYlTqWT;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACEF606A31B
	for <gfs2@lists.linux.dev>; Wed,  4 Nov 2026 00:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1ACEF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oIYlTqWT
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cdb15cd8558so62677a12.2
        for <gfs2@lists.linux.dev>; Tue, 03 Nov 2026 16:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793753391; x=1794358191; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/bumM81nPiENiLh9PH/Fm40C+VENRMD3A/OuAfI8Z4s=;
        b=oIYlTqWT09/SUly5k7UaCud1EeaQUvC7RMvXrFBnHL1wmqCrj3MF89C/VXUkjUE4MW
         MziXsexG5bZFD8/5ww69ukE2+IAW6248QEOegXPgkb4laWmAWO0mwI0jz3EE+tEVQ1jb
         Cfr9y2L8ivx3OiRBLYdUWMaYuAzn99jgCpRFzDU+cms5tT+mfREViht1fwtzFR7BmEUY
         Dk03HD8TwkWYMwWGJyQBLSx0XZUUmjmvUNI1ma0gO7kyaeuiYFznEyfPu3/P2SGS2yTn
         k3zcFNcDDLBq0JsK+rJh9aCed1fQkIO/CZh4Uf65Jxl0PqAvIJq2QDcMVS3yE1w4mgt7
         yQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793753391; x=1794358191;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/bumM81nPiENiLh9PH/Fm40C+VENRMD3A/OuAfI8Z4s=;
        b=p5gbYCyvXehF9AIzbuWkg3u0RYgHRjP83VBJCbZiFvMXatyFDRls2kWZz2DITg70vm
         6pYCgcyolSFqLPdoznz2GHm3SMkvVnTn8ppe654dK+PI5XtSDO1Olgk9fUSVTxXWfOed
         A71iG9z0KtddHbkXQ63Cp/kFU/HAmnXt5uk084qowl1MHn8zLgedB1/jbpe61vIs182x
         GHd2fV4SG+dpvuTnN04l6ZzSkelZk3xQzHE3Z18MSPEeb41hi2jmsJpYIqNSqcx6kJ4P
         /ENZS7DJDZsRw/m8NszBe/gICCiDlNlQUC7ysRXfb1GxPIMlpGRu5CsQGnSMID99Q8Ec
         MxoA==
X-Forwarded-Encrypted: i=1; AKwUvByYhy9crHoQYY21eBHFOc9mysXv3mfsGnxbWikA1idRqXxwi7pzx3nQmUyqRnA+GbTuOGCf@lists.linux.dev
X-Gm-Message-State: APuU4Z8f+It2Lj+rBWX75ufuJ06FNBtxLxjGTL5SVXa3U3H+Hx7gPH0U
	XHrD4qDRNcAbjNmlXx1Pa8u9bN41J60aYE2fBnBYEaqYvNABOZuSjtAq
X-Gm-Gg: AYBFou22qIi0IUFy2ptw1se/DIYr3vceVyF8bjLVrAkpLJilp3NAqoM5ekDClSxLUlX
	cZ43ORXd7Y4l5czW2bhuCAbj+ezHPbwoFD1holmxezvHfSumPlp/Pixup/MOi1MgImw91WxE+gt
	XpMdGhN/Lj0YDGKMPA87PNqOD6pGkVFViIXdrz6F4ZM99G3UTfLeG8hsgTlxmjIVmhDXjMaOEnl
	zuDNMF499zSR42zBN7l0tr37xTuTytpbgpGGETVRqJaCwUKtaf9u+Wk85EdWcvTypkaq5y0dj9P
	u0dTW1dfugqd42VnkOiCQISG8TqqH4VQjqiVq8bqIMMrNHVGWd0/xFLteD2t2FjbzlDNMW5KBL5
	MJ4a+GuSybhaVCt4rPYKYXYs8rVM7T/MtDk+kbvwTNqiV5OuHef8yQdgewzLgL3oZQYXrystQ3a
	v4JGcDLhL3e3oaOrB9gP5EV8eAYPRvhli6LxvWE4ZQWROuOoPPXexZMu3YMR4/aDvi2I38ohqgZ
	pLrDHTGVtwOSJyieFctk28eaGmb86zPZOuP5XQnQLcO0iCjBDcz4fpCDhvOG+nyQ3KLgozNWH/z
	hgKhSYMOPwvNx3FtLxIfIRWstvGWEtclwe0JWzg=
X-Received: by 2002:a05:6a20:914b:b0:3e2:9470:5303 with SMTP id adf61e73a8af0-3e928953948mr11828504637.15.1793753391239;
        Tue, 03 Nov 2026 16:49:51 -0800 (PST)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb46440cc7sm329325a12.3.2026.11.03.16.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 16:49:50 -0800 (PST)
Date: Wed, 4 Nov 2026 09:49:48 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, ecryptfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org, exfat@lists.linux.dev,
	linux-mm@kvack.org, ntfs@lists.linux.dev,
	ocfs2-devel@lists.linux.dev, linux-btrfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-efi@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-xfs@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 17/34] ntfs: don't set SB_RDONLY after filesystem
 errors
Message-ID: <auqBLEvcurRZfGj6@hyunchul-PC02>
References: <20261029-work-fs-sb_rdonly-v2-0-2f44f64f0b66@kernel.org>
 <20261029-work-fs-sb_rdonly-v2-17-2f44f64f0b66@kernel.org>
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
In-Reply-To: <20261029-work-fs-sb_rdonly-v2-17-2f44f64f0b66@kernel.org>

On Thu, Oct 29, 2026 at 05:07:08PM +0100, Christian Brauner wrote:
> With errors=remount-ro every ntfs_error() ends up in ntfs_handle_error()
> which sets SB_RDONLY without holding s_umount. If that happens while the
> volume is frozen through bdev_freeze() thaw_super() sees a read-only
> superblock and leaves the s_writers rwsems locked so every writer hangs.
> 
> So set NV_Errors and a new NV_EmergencyRO flag instead like ext4 does.
> ntfs_emergency_state() returns EIO after a shutdown and EROFS after an
> error and the write side shutdown checks use it now. fallocate,
> ->set_acl(), FS_IOC_SETFSLABEL, FITRIM and ntfs_mft_record_free() get a
> check as well. Errors while mounting still set SB_RDONLY, nothing can
> freeze the superblock before SB_BORN.
> 
> NV_Errors already refuses a remount to read-write and since
> commit 521978c4f444 ("ntfs: sync the volume dirty bit with the recorded
> error state") the volume stays marked dirty once errors were recorded.
> But the dirty bit may not be on disk yet when the error hits and
> writeback is refused from then on. So a work item writes it right away
> because ntfs_error() can be called with mft records locked, and umount
> lets a pending one run first.
> 
> Unlinked inodes are left to chkdsk in that state. Their mft records are
> freed with direct bios while the index and bitmap updates of the
> deletion can't be written back anymore. And writing to an encrypted file
> only warns now. It called ntfs_error() which let anyone put the volume
> into the emergency state.
> 
> /proc/mounts keeps showing the volume read-write. Writes through file
> descriptors opened before the error fail with EROFS.
> 
> Fixes: 6251f0b0de7d ("ntfs: update super block operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

-- 
Thanks,
Hyunchul

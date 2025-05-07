Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295C9289348
	for <gfs2@lists.linux.dev>; Wed,  7 May 2025 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746626518; cv=none; b=toIr4gC1qx3vBEc/+xMPEXpf8+rURLMa2b9DtKrnsWK/TavdAER17EaY4dkrjaAB5DHoy4PGrfILSeXunBRz2IktGiW638x3aVtCEoiR03qJtlgAnVj4XnCZtoG70Zv3AnTct1GpicFdxJkzeoq5QNzPGF1K/uNAJmIJ7fDysoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746626518; c=relaxed/simple;
	bh=riUohbe+nhSKSfWHET/Yt5mBIMTKqf2kkbHWdODQalU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ns+2Fa77F6W0X0ISPtujcUlNyX2RRbqARNZ7D1KENwhK70uNyMhNC8VMesNVGEHZerIsmn15w6JiaBt63DcoFJ2Kyxcgv/VKzaeO+OdJFMmBbflVEhpV3jiS5c7zpvCRsBctsyxxzQxbMN/MD4ScG3hq64wIy3TU/4pGLUWlmbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YwydcJ81; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YwydcJ81"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d9189e9a06so28736895ab.2
        for <gfs2@lists.linux.dev>; Wed, 07 May 2025 07:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746626515; x=1747231315; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=md71yFj7QjYOD6CmfKKjAp0TbUSgcGH/TtN+850EMGU=;
        b=YwydcJ81/7SuEotddKqoGeLcipVFSCCR1PBPlDmrz9gsoWqy3fLjGQ34YoOL5JPG8r
         l14+o4iM1yRtPfhCyAbbV7WeYpU59P6liw5Ar/Ezojp+FanlLO7krxJpdxZWBjNsp5l7
         UqinZtjVPVULrADHkdmZNz1/lZXTw6Z8oNgQUpmcopQbhjIcxvyXFRJl3ZjOmBUCSP+5
         eYJ2Bsx5Gp5jSUbRsH53aWbppRHFWzL/ruBXFVyw9QnLdkfZMKo4/3Yljjn2Y4a6+gp1
         Nvc7Wml1RpaqRjHjA4IrGmt95cSM9GEuVXd1NEtObrRm3eeTR6PREf6ocF2K4fbhFi5L
         XGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746626515; x=1747231315;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=md71yFj7QjYOD6CmfKKjAp0TbUSgcGH/TtN+850EMGU=;
        b=RETpdvb703UoW/ndoO9ZOHT4w37mH2sMPATbYJU0sgsB8CRIowAURuhmQOT1GRT44f
         /Vv8nfL0gG+3P+6jc5e/M4eg2P8KrdK00TfYLgYlccAmgWtpw6sjaKKsdO9/kNKpeGen
         4Lp2m4XwguH0T/UsQP5z5rPJe51OeOcSCGTsMhxckMQ3u5z97yWWSiVmgW2RFK8u7FLZ
         7zEWlpZgivwgFOy9K/u6beucF7a8xxapq2w6fXl3as4FFUyM2pcotyqPGS0dS8Jbld4e
         5lZ8IwkmpNiKxeMhct7uCDzyQVc0s867Uc/tlcmu/TZjB1A3Jfg+/BlZ60Kd5wDT4sJ/
         QLxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqKgxkf2/yNN5F0Eyj/cxwgqtVVMK+2CBmWpCE7ZWJy5ZgCT8VTo/UwhQ3G3/Vt83IgCbr@lists.linux.dev
X-Gm-Message-State: AOJu0YyVH2m27hHS8PG31RZlsSSTIxRozVJ2ZDpBkRHm1zOjrFFEOZXF
	AsQwnmGMNfH2ZcVfv17T62y8W4iF9E89/C1pWQQBdYi/aJIZHSHhjP8Z7r3tg9w=
X-Gm-Gg: ASbGncsit2JwFzqNBonc7OkoHYtWx518jkwBj8kB4lDVB21G7n4gYx1H0+Ms+AFrjZ6
	y7elMDex8uw2otk58V6SYI//GvKtxJPFLBuC2mMhR/2AgdWgBvhl2oj5bqgo3sGIdlOTghustkj
	8JbBpLWAnHrwd2NMSOFg0yEl5S1TpMfbVWFsEQkTHeVLeX825Us72CiC6iUDcabZDJ6Ml7fg1Km
	bPi15hY5AsRZdsFyZINst+U/R7ACsAr5GtwfDF4YDiXjPkJEmT0dEJ2qRtuAkpLaRlvBVdgIMXu
	ODlXsY9MJ1XXWJWW//C7kxlZi282BjJ6h6DH
X-Google-Smtp-Source: AGHT+IEPXkcUdjuoTWJKGESqgsxo1A4ob6I1ttYfFC6JrLgpCILRh6jZ2+LBOAWlTXtq2pbhrFyjbA==
X-Received: by 2002:a05:6e02:1529:b0:3d4:36c3:7fe3 with SMTP id e9e14a558f8ab-3da738e562emr32326165ab.9.1746626515075;
        Wed, 07 May 2025 07:01:55 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d975f6dd89sm31362225ab.66.2025.05.07.07.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 07:01:54 -0700 (PDT)
Message-ID: <a789a0bd-3eaf-46de-9349-f19a3712a37c@kernel.dk>
Date: Wed, 7 May 2025 08:01:52 -0600
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/19] block: add a bdev_rw_virt helper
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Andreas Gruenbacher <agruenba@redhat.com>,
 Carlos Maiolino <cem@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
 linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-pm@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20250507120451.4000627-1-hch@lst.de>
 <20250507120451.4000627-3-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250507120451.4000627-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/25 6:04 AM, Christoph Hellwig wrote:
> +/**
> + * bdev_rw_virt - synchronously read into / write from kernel mapping
> + * @bdev:	block device to access
> + * @sector:	sector to access
> + * @data:	data to read/write
> + * @len:	length in byte to read/write
> + * @op:		operation (e.g. REQ_OP_READ/REQ_OP_WRITE)
> + *
> + * Performs synchronous I/O to @bdev for @data/@len.  @data must be in
> + * the kernel direct mapping and not a vmalloc address.
> + */
> +int bdev_rw_virt(struct block_device *bdev, sector_t sector, void *data,
> +		size_t len, enum req_op op)

I applied the series, but did notice a lot of these - I know some parts
like to use the 2-tab approach, but I still very much like to line these
up. Just a style note for future patches, let's please have it remain
consistent and not drift towards that.

-- 
Jens Axboe

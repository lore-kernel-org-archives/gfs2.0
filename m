Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681B8381C6
	for <gfs2@lists.linux.dev>; Tue, 28 Nov 2023 10:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="gbsxpUZr"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-32fdc5be26dso3247144f8f.2
        for <gfs2@lists.linux.dev>; Tue, 28 Nov 2023 02:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1701165931; x=1701770731; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZKJsy/O9sQNKnNFyRJVuTOt01SElG6aFkPQ2+Lfq3iI=;
        b=gbsxpUZrUKvt80v2uspxP7Mi2cZiDtjZvlGzTpGqWYBMyKj+o5vxvc+1kxe/YRhCpV
         Mj5nruWnA3Mb5NTHKIFifxKrJTbZ9UQzOr7e9g7dPaFrQDYIcCJfgiyp4YQXHysdAilf
         VUmwpV+6K3JHK7uNldy1sWjpZvGaqstI+sFhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701165931; x=1701770731;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKJsy/O9sQNKnNFyRJVuTOt01SElG6aFkPQ2+Lfq3iI=;
        b=SeDWLFtnEWuRIW2BhI9nJZS6TWWqA2MlD/c8DLCs8+FHHbv4WXW39G8XH5EsqwWWt+
         WUMWviGAmdaicyGX4LFxuJ/NfcTnY4EI3ZYvy+XfveSHENN+ZFlLCTxAIem4/0g+vyUz
         xZxTiZLUqbCNlM7TfyFywGo997pGTdFFpTZZn5TOzkI7q06LcQAGdwY2wphzPHjnNs+h
         UGgsPizg/Yyy1HHNZ6lQbshFuUhbDsuBF1X4mMS79vVqMyLOhTPxjs53NmINzt0DgMxd
         TuyHuSvTjOIxXlAAW3I+4IUPLdaU+WV8C2uG9y5mQhLTx2u9YEuRP1AERZkygikSbnPQ
         /eAg==
X-Gm-Message-State: AOJu0YyeThRl7mdS5VyVh3ev/R/pbCkHxv0Cs+sgxIfxm1pxb48Agshw
	7bZayAsFZ2fK1jnWX9Hl66EArA==
X-Google-Smtp-Source: AGHT+IHso67qiRejATVe+y4q8GA8WkjBME6ZXNG2nx2AvipjQBf9Fe7u/GIhGV/RuBTAoKaGDDxyQg==
X-Received: by 2002:a5d:4bcf:0:b0:332:f81d:8dac with SMTP id l15-20020a5d4bcf000000b00332f81d8dacmr6833150wrt.67.1701165931581;
        Tue, 28 Nov 2023 02:05:31 -0800 (PST)
Received: from localhost ([213.195.113.99])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d674a000000b00332eef1ca7asm9779426wrw.80.2023.11.28.02.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 02:05:31 -0800 (PST)
Date: Tue, 28 Nov 2023 11:05:30 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@infradead.org, ming.lei@redhat.com, axboe@kernel.dk, colyli@suse.de,
	kent.overstreet@gmail.com, joern@lazybastard.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	sth@linux.ibm.com, hoeppner@linux.ibm.com, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com, jejb@linux.ibm.com,
	martin.petersen@oracle.com, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	nico@fluxnic.net, xiang@kernel.org, chao@kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, agruenba@redhat.com, jack@suse.com,
	konishi.ryusuke@gmail.com, dchinner@redhat.com,
	linux@weissschuh.net, min15.li@samsung.com, yukuai3@huawei.com,
	dlemoal@kernel.org, willy@infradead.org, akpm@linux-foundation.org,
	hare@suse.de, p.raghav@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org, gfs2@lists.linux.dev,
	linux-nilfs@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: Re: [PATCH block/for-next v2 02/16] xen/blkback: use new helper to
 get inode from block_device
Message-ID: <ZWW7ag6vIhc_Skh5@macbook>
References: <20231127062116.2355129-1-yukuai1@huaweicloud.com>
 <20231127062116.2355129-3-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231127062116.2355129-3-yukuai1@huaweicloud.com>

On Mon, Nov 27, 2023 at 02:21:02PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Which is more efficiency, and also prepare to remove the field
> 'bd_inode' from block_device.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Roger Pau Monné <roger.pau@citrix.com>

Thanks, Roger.

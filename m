Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF55763DDB
	for <gfs2@lists.linux.dev>; Tue,  5 Dec 2023 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-58d9a4e9464so2495519eaf.0
        for <gfs2@lists.linux.dev>; Tue, 05 Dec 2023 09:03:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701795835; x=1702400635;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Kxt6CKccKyM2aD5KqaYbJ+5NRAtsSu20TdTe87tfro=;
        b=Q0pCh9CmwfxFpeXet/0kGi2W/bqlc04h0shDOXYvn5VbcYJ9rZV05Ael5EG97ot2g4
         XrRqfyaxk2+asheUV8h7LpqLl2gnGnnve3x+j+W8pJU8vwtfiWCsybYSHUr0XlqtWu44
         Xv7lCDrdS9TN1Qtpkw370SyShwHCbnd+xK5NV9BamA2Ve9huNAq0pn9Id9I43ldIc5x7
         kWO0QpO4PsMgLPERnyoTcwBUnTjxj1rOSLyZ70UsX8YeMNR9gu9GjOVEORescZTFRmIY
         fZWsDAxx/vKUgoKLIUTSpzNKs1vZyP2nXjG92rqWGjF3MOakfunK3pbGCfPI54tUk/4r
         YDGg==
X-Gm-Message-State: AOJu0YyvsGYD6xm9wNTSUR5AAUJRxz5G1NKc9d5njO/66G+JmAoVnwcG
	NwyLSwn5k8GTZksmr3gwbeA=
X-Google-Smtp-Source: AGHT+IHREsBDTR/fguPuUAOPGrQJFqdX7+L934/9nqEfo9v3T6jgbM8x1qOuTAd7fOfx1S8tYfwMzA==
X-Received: by 2002:a05:6358:6f95:b0:16e:43a1:6881 with SMTP id s21-20020a0563586f9500b0016e43a16881mr2252180rwn.26.1701795834695;
        Tue, 05 Dec 2023 09:03:54 -0800 (PST)
Received: from [172.20.2.177] (rrcs-173-197-90-226.west.biz.rr.com. [173.197.90.226])
        by smtp.gmail.com with ESMTPSA id s25-20020a639259000000b00578afd8e012sm5146562pgn.92.2023.12.05.09.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 09:03:54 -0800 (PST)
Message-ID: <189fa9b2-bcc8-4839-ac04-33a29bba9aaa@acm.org>
Date: Tue, 5 Dec 2023 09:03:48 -0800
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 01/14] block: add some bdev apis
Content-Language: en-US
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, roger.pau@citrix.com,
 colyli@suse.de, kent.overstreet@gmail.com, joern@lazybastard.org,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 sth@linux.ibm.com, hoeppner@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, jejb@linux.ibm.com,
 martin.petersen@oracle.com, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.com, nico@fluxnic.net, xiang@kernel.org, chao@kernel.org,
 tytso@mit.edu, adilger.kernel@dilger.ca, agruenba@redhat.com, jack@suse.com,
 konishi.ryusuke@gmail.com, willy@infradead.org, akpm@linux-foundation.org,
 hare@suse.de, p.raghav@samsung.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-ext4@vger.kernel.org, gfs2@lists.linux.dev,
 linux-nilfs@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
 yangerkun@huawei.com
References: <20231205123728.1866699-1-yukuai1@huaweicloud.com>
 <20231205123728.1866699-2-yukuai1@huaweicloud.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231205123728.1866699-2-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/5/23 04:37, Yu Kuai wrote:
> +static inline u8 block_bits(struct block_device *bdev)
> +{
> +	return bdev->bd_inode->i_blkbits;
> +}

This function needs a name that's more descriptive.

Thanks,

Bart.

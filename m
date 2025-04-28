Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFB125F973
	for <gfs2@lists.linux.dev>; Mon, 28 Apr 2025 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745832191; cv=none; b=hkaaWZqT/yqMk3/sFNjRC4pNYlcgvbVvBNTmqptdXP/R59iYFDB/p7sswPQNndCbvLl1owwYUzgIJLX23uam0sg+M12OlTLzHOrSrsEL6pCMExi2R8bcWJbDPniH975S2OpvCT/2PggkMWFwyd7gVJpl7xN9G3wWXBMDQ0iHAkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745832191; c=relaxed/simple;
	bh=ni7iG0pcXMyEswEF3ky/1g9WXEzkF5I/Qctnd5w9rjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kLcsoxdoMDOyMeoJ5kJCdbwRu0a7QR6VKZ7EGUGQU70xzQBYqZYFsrKKFSTDQRj8hJzhkGUd67fzKGjp4fgXGuWeHFIAvFlPTkLfRmi0gPDCCj5DMZI3q4VoVnRZyQJgQQjBfdQ8KX3YTXaI7oqg8tK7EEr5zuL77N2+9O4MOPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AuqbU8x7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AuqbU8x7"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43ed8d32a95so39798625e9.3
        for <gfs2@lists.linux.dev>; Mon, 28 Apr 2025 02:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745832187; x=1746436987; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VTBfMMopJTyWHQSabpmNdAk0IJVlLoaLPW901ABYfPA=;
        b=AuqbU8x7KV9uBh2+30VZNCZ6b8jlYS+0xPNbllLlKm64HCmgn0UujiP9jEj//RStQH
         ME9LCnXp0af8a68WCafv6V9JhygW12HdtR/72yv2HtNkQwCBw2G1o+zz9mp1qVzWfSCF
         br/YgKvCsPNULuVlF0HYx9oyucrQaqAA02+2uz004fDmsLI/KBzJ5xv18rX5HXfn/o48
         Yyutfevl8cvyLZkU3li60k7GBj2rLERvA4DlQOLQa3VbOJOeQDXCFMG+ovsZ6hS0JlAx
         rpHFvTwxVM+uiiAJP57ZpcI4MEwng8v0d95YPw58LUea5uJqB6H2Z9BivQT8a8/UpV6J
         d1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745832187; x=1746436987;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTBfMMopJTyWHQSabpmNdAk0IJVlLoaLPW901ABYfPA=;
        b=RLzHReuQ7nXJejqqIT6CknhcX38/1I0k0viVWQ80V+BopmpuOaw9oIficJCFcStmvg
         lkZyZ6imM8drgFCOd3l6a7k5PJmxS8SEUev3EJeVm48YtqiloWifJImW0xnNuoUp1tGv
         6jWUcKYChDw4bahEATfG3BMWzf2q9UjdB6PrFcP51JJ/rriGVY+wgH7rTsN00Ll1A9P1
         53WFg4ss4kEMSMULUlo4EEItZPX+VFgX3Wic77knZGshFfqvnLGf/H0u57fFxA3feMS7
         7rLBD85Pa3qC7bCsIcsPPABFRf4MIndya3uZsp9l/5xk94NIBnd3X2O/g5elKkFCwCUP
         l4nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZIKQ+NUYU5WBJjxb61Po6Ej9ITJgM00nBvASmdaqAZguJcwczzwz7+0bfBxS49OnMbFCR@lists.linux.dev
X-Gm-Message-State: AOJu0YxuUYaQyl4wLYaAgEvw0VChpdx3/jkzQUYRXIgrYUeej33wVLdq
	/p2QiUV098R86SybUk2NTHtj3VjbD3CEIpbLV+tBdFcaMGHnaaA9bgQM62xgwWs=
X-Gm-Gg: ASbGncsDSGhhXmMkr1kViOT4wUlAU8TdYzh83Q8L1EqHI9xbddcpYQyqGSueYpS+Q+1
	1CjVcHSPSMe+qoF3pLhH6Pwhl5UJpS9tJX7a8yNz3YQY4+Y34LHXLySLUUVw7U7w2R+CvJJFvDp
	mLsaBOYenEA087Rf6yUmuXlbmipmHkyAaal+4FIPAOH07MgTYqMAu5wj96bif5FkkM2lIWnmSA4
	nQTJN2flQK2E9lvzobT2VNaPL61J0ROBp26/mcgQFBgmuJpmRy+UqyfCdwGbECsJC4OSgLxNOFQ
	SQUhDoubdtQkMBuwSGdoq9/TQSTL+W0U/znVqO2xQjKlsX0xjQe9VrSSArWJsQPZvFm6
X-Google-Smtp-Source: AGHT+IH37tTVSokimshgZW6lxGFvzF557LE6UTHnwllapDKuc5EV+Ab6vjHAVIVTRS0ttHZVKgcPlA==
X-Received: by 2002:a05:6000:22c2:b0:399:71d4:a9 with SMTP id ffacd0b85a97d-3a074f7f22amr8964485f8f.52.1745832187159;
        Mon, 28 Apr 2025 02:23:07 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25965b82sm7495040b3a.79.2025.04.28.02.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 02:23:06 -0700 (PDT)
Message-ID: <a90c9dcd-e0b0-40f7-8416-f30a3a6b26a0@suse.com>
Date: Mon, 28 Apr 2025 18:52:54 +0930
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/17] btrfs: use bdev_rw_virt in scrub_one_super
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Andreas Gruenbacher <agruenba@redhat.com>,
 Carlos Maiolino <cem@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250422142628.1553523-1-hch@lst.de>
 <20250422142628.1553523-14-hch@lst.de>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <20250422142628.1553523-14-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/22 23:56, Christoph Hellwig 写道:
> Replace the code building a bio from a kernel direct map address and
> submitting it synchronously with the bdev_rw_virt helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

In fact I'm waiting for this helper to refactor how we do super block 
read/write, to get rid of any page cache usage of the block device.

Thanks,
Qu

> ---
>   fs/btrfs/scrub.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 2c5edcee9450..7bdb2bc0a212 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -2770,17 +2770,11 @@ static int scrub_one_super(struct scrub_ctx *sctx, struct btrfs_device *dev,
>   			   struct page *page, u64 physical, u64 generation)
>   {
>   	struct btrfs_fs_info *fs_info = sctx->fs_info;
> -	struct bio_vec bvec;
> -	struct bio bio;
>   	struct btrfs_super_block *sb = page_address(page);
>   	int ret;
>   
> -	bio_init(&bio, dev->bdev, &bvec, 1, REQ_OP_READ);
> -	bio.bi_iter.bi_sector = physical >> SECTOR_SHIFT;
> -	__bio_add_page(&bio, page, BTRFS_SUPER_INFO_SIZE, 0);
> -	ret = submit_bio_wait(&bio);
> -	bio_uninit(&bio);
> -
> +	ret = bdev_rw_virt(dev->bdev, physical >> SECTOR_SHIFT, sb,
> +			BTRFS_SUPER_INFO_SIZE, REQ_OP_READ);
>   	if (ret < 0)
>   		return ret;
>   	ret = btrfs_check_super_csum(fs_info, sb);

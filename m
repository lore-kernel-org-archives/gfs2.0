Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198464;
	b=sGzjjeiDyJpmN3GBRvaq9NYMI50PrgFY/gWw9aGSoQHTZQy1WvEo3UJzmp3VeYZwF/tH
	 2DnGAnbojRBTbGWrWNv0NN8mpZcqYAvi6dPXOqKsOmdCHXvTEgPEMMD9/HIugtdlrF4hH
	 NIU4cN+AWoMbs8wrMJ2uH8wn/g29R7rsT8bcf7wL4sLzpIgXeDBV2SgXEy0iDtqyZDFdB
	 32l6dkjHzWXQuBgyCDY/OJHGTeyuzSEs+OKupeFQVHt3Q3ALuPtj3Ug65ZBHnOcLU/jZg
	 Ve2fMp/L1lu96kVyMKWmIZlDPdOI/gEbkrPsPUpYHh3Q36+V1F2r06crP2GqkrcvFYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198464;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=BjI4u2LzbK6WJBwWilztv44HxHxh38PntSdSS7hzSPU=;
	b=Pc4u1701HwOA0mwD3aFoyph0tnSKkmyatV83dIUf0Y6xl8qll5QCEJFiqQlsr561Pods
	 b9TrT6pQ5DHNuxJ4x+W3K0ONIEQH2XN0a/LeQBnqNPJjNHm1JDv55cwvBpbqxpR89eVPA
	 VBxKNTlW+lAj4W5iVErGuITy5C6L6sx55jipai49PYmwmjaNfR7uiO+sEY/23HK6tZq79
	 BWqvXJvbXt10+LvK7BmsJY15FKJ8uKvqR61RMorNDLyceu41ZnfaDxqlEMyY10PLZ5aLt
	 JXndcK7mSX47Tq3P3H298KcsKirx0EqNGjmbqxUdj0tElchabBqCP/k52rO7tCeqZ4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=fO2xwbrl;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=xEl6Jb82;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4696606CD0E
	for <gfs2@lists.linux.dev>; Fri, 20 Nov 2026 18:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4696606CD0E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=fO2xwbrl;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=xEl6Jb82
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKI5S5J1114067
	for <gfs2@lists.linux.dev>; Fri, 20 Nov 2026 13:14:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=BjI4
	u2LzbK6WJBwWilztv44HxHxh38PntSdSS7hzSPU=; b=fO2xwbrlFRvE9+ICMyHI
	V5PKEO4GMJbRXaAcirLWAK1E+FqnNsXusq4xCI4IKLY+JUYwcHqJBLIw2+wwZHL4
	wqgLdACedaFf5q74XY5m0+6ZCBqkz6/YYPnePC/iCxq6Cw/m1oZP6IsX7DxQa6eE
	AMZEUMTpwS2Jut82vopziRiPDaiJCsRtSd0Vr/Y8Sw8rRb9c4khANuP8O0PoYx1S
	QeAyt7EH3qRhFz8LCjE1m7VCtcXeBdHbVcxD9O6nSnQWE3bv6lesKLJI7wSRByZa
	LREJKUk3Bhtb/LitQJWljs8ruCfEWtw+wHg+sP9s7PPijC/c2iDN/H9vR6oj+wHR
	Kw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j2u69830p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <gfs2@lists.linux.dev>; Fri, 20 Nov 2026 13:14:13 -0500 (EST)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-92101559a2bso22099136d6.3
        for <gfs2@lists.linux.dev>; Fri, 20 Nov 2026 10:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1795198453; x=1795803253; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BjI4u2LzbK6WJBwWilztv44HxHxh38PntSdSS7hzSPU=;
        b=xEl6Jb82O9PVbMRSoaNhH+R5oYY11B0gvz0uQkoS/8RXVrg11N4WPbhVqYzRe2Utyg
         U8ctlYbT979VPssGmpSm/FnhuC+yFeVlvR/cFzQhyp+4GU73t3cCFuk1a9cSpJHeGVpa
         RffCadMdjRW66/udZLrjWWIGl9zH3bI57WddVWBAlW6Z163P6WvZSPPSAtB5GEaV5oVJ
         thVeRT5RC5uB112jahgXjoXKWNCi1rhc/rkWDE/rzqinHe45O/S6OwchAZVb6UXguibT
         gCro6rQJn4ZTOT9EcAsCj775fIi2cOUblp6f96V0FqW8LRKP37YXAxCrI/Zj1fthpswL
         KU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795198453; x=1795803253;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BjI4u2LzbK6WJBwWilztv44HxHxh38PntSdSS7hzSPU=;
        b=Exv/OMc0v+LL+kQPJT0lgK/rNzXNQBnn5a7tthy4h7obEEjjOMyhZPo5PM+O/6RYeE
         wrfKadMrrpCJwo0QNPLpyuLR9OibINrLEL3O5HLvhlqieyUZYvzJojmQFoH9MEWA6yf0
         GlTZz2rzIU6Kz4HFTKqFhbswiZUS/KcT98AM2BdgGpwd7VzidCmyxcGYV6KK7QUENVnW
         To8tCEZGY3hfhAnunaX3mMo6R1WDuFqCw6pGB10F9Eh/mQjaPTGtv2dz/zTMBLkUwJGM
         5JOXiOKBu/dWvWNt7pi5Cyh2Q4j9l+Rd72ne4kdlJ73VoVzUliCQnW/DHQVQPNw0jVQS
         Hh5g==
X-Gm-Message-State: APuU4Z8IAJeFitv0HZ/DHnqENIOWF8w1n1co+1Eh4zQNS+Pr30pblXI5
	4i68eoorq6qL314Rsaj1WmTJYHyqesYEF5bFE/GyYdRUVnUe8y9A/mj3iAyTIKz7BA5QhNwP3Ag
	ss36jsKSwy3UIwCjyDpP7PmvDI5CrGBEfH68KVPwzrtLhBdLbCa4=
X-Gm-Gg: AZFdTZcD7X4OO2v/Z4ETPUpJdqGfuZXcr3HKRjSJbJgi84CwP/Osj4B+mcZQ96tkMSI
	duvh9+WzZ02QbaNx6TTKAUzaTr086fij/D2mvu0AymCDjJdgsE1Ut0LXQ03f2NLOpqE7L08RRAk
	q4C2OjOIxt3ER3dTICKxTfJt6nAEChI9Li4lI6DuVduaUZM6Q3Pfe/HzkJ3PMVtZ1O2TRIzkl0R
	j+7qYGN9CwdIGkPlKVr5w5FidqTNGRHtfyPnQ405AMZUGxbnooukDA9LKJEX9gWGrQP/XJX00g0
	RLg8y0ZmOZpPlG7CHuTMc6VE0swoN4bf+PS3GoJ0nF3u9W6IX0DvCI9v0Kos0VTf0CjAY37DtCd
	Vihbv7IknrpOAKwM3WnpTOaGpXxBBcXJdfDtRHj3ORp/KR2MsAi3CTk6QIu3ISsMEie2CH+uI/C
	qUSSLzEk6fQBewRDdA5lxTsvXt
X-Received: by 2002:a05:6214:20a7:b0:920:e412:e3df with SMTP id 6a1803df08f44-92134a6caaamr65344466d6.18.1795198452866;
        Fri, 20 Nov 2026 10:14:12 -0800 (PST)
X-Received: by 2002:a05:6214:20a7:b0:920:e412:e3df with SMTP id 6a1803df08f44-92134a6caaamr65343996d6.18.1795198452362;
        Fri, 20 Nov 2026 10:14:12 -0800 (PST)
Received: from [10.207.2.125] (nat-128-59-178-217.net.columbia.edu. [128.59.178.217])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9213514d20esm29910446d6.23.2026.11.20.10.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 10:14:11 -0800 (PST)
Message-ID: <e3b26fcd-8309-448c-bd34-dbced0b50a9c@columbia.edu>
Date: Fri, 20 Nov 2026 13:14:11 -0500
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] gfs2: stop using pages for log buffers
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <20261117-gfs2-log-folio-v1-0-35db3db42e35@columbia.edu>
 <20261117-gfs2-log-folio-v1-1-35db3db42e35@columbia.edu>
 <CAHc6FU7adAS0f2BjU6iU3AUD6hAFF=2zOeCMkVvV88p4O-a6=w@mail.gmail.com>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <CAHc6FU7adAS0f2BjU6iU3AUD6hAFF=2zOeCMkVvV88p4O-a6=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=eOCGH3p1 c=1 sm=1 tr=0 ts=6b008df6 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=lnglQuR7XRqnmjDHco/WZg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=n50glJ6IDL3DvrYGJlgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3MSBTYWx0ZWRfX89EywVb5l35I
 hgwWbK7/eUi+iD2KfpMY5RfCuGANo2fMoWZlXcgVJWAQ4WWZNC8/NqMWjrqmHz6VXT6guHe2sKd
 ZrQAjWHsEkda5MmD04q9tFBs6u/wdlYcfvVRCWn8dX9BamqXfQhI9b30JQNTYSK9YXZZqhiQogo
 SNGbT6peOweKayZLgakS+tQGZuZyOrTQw73/MtUe/rCqd6hu6QMLcHPNuTwZlqY6FdX6nd5B9RB
 JVjTmUNcJC9o4vvV0sr+hsiSL2ZkYIEZKT485Z1mgJ7Ea6h4QIMR61fDDeHexJbACNdS8weX5nn
 NR4yS2+7dLG8VQfWgoSH1EYI5XaCdBD0IEUrAxkFdUpd3INb5bdiIe6fu18Khuw6c6HGHgSRhre
 h1Si4JaWVVpRUxEK1CJu2jewP2Y8rLG1yWp5hG5zl8tE0wcz28UjzjuoBlwexbxFW2bIZu83KgL
 gtWvZRC65y2EXfgPUDA==
X-Proofpoint-ORIG-GUID: nAETwla3Mug0a-ofkt4JlZPWXZp-q8Kh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3MSBTYWx0ZWRfX2+iJ599LGa9v
 QcYcjjFXMfltiqQFr0yAAvWGOAR17qS2/rEQxBKoKaGUj9X242UeFAT1Fdt5daybzsEQBSOV9ST
 mLYTxgIWj+E/jFeslq5cL2zZKuYivgImOiekrQIRLQVY5bEj3hQc
X-Proofpoint-GUID: nAETwla3Mug0a-ofkt4JlZPWXZp-q8Kh
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11972
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 malwarescore=0 bulkscore=10 lowpriorityscore=10
 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200071

On 11/19/26 7:08 PM, Andreas Gruenbacher wrote:
> On Tue, Nov 17, 2026 at 8:46 AM Tal Zussman <tz2294@columbia.edu> wrote:
>>
>> The log headers, descriptors, revoke blocks, and escaped block copies
>> come from a mempool of pages and share a bio with the buffer heads being
>> journaled. The completion handler tells the two apart by checking each
>> segment for buffers, which treats a pool page as a folio. That won't
>> work once memdescs give these pages a type of their own.
>>
>> Allocate them from a kmalloc mempool instead and add them to the bio
>> with bio_add_virt_nofail(). Give the pool blocks their own completion
>> handler, and start a new bio whenever the handler changes so that a bio
>> only holds one kind of segment. gfs2_log_write() now takes a folio, so
>> the log write path no longer uses struct page.
>>
>> Each descriptor and each escaped block copy is now a bio of its own.
>> They are contiguous and merge under an I/O scheduler, but the flush
>> path doesn't plug, so without a scheduler they reach the device as
>> separate writes.
>>
>> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
>> ---

...

>> diff --git a/fs/gfs2/main.c b/fs/gfs2/main.c
>> index a607e98eb45f..0da4cfbe54ea 100644
>> --- a/fs/gfs2/main.c
>> +++ b/fs/gfs2/main.c
>> @@ -166,8 +166,8 @@ static int __init init_gfs2_fs(void)
>>         if (!gfs2_freeze_wq)
>>                 goto fail_wq3;
>>
>> -       gfs2_page_pool = mempool_create_page_pool(64, 0);
>> -       if (!gfs2_page_pool)
>> +       gfs2_log_buf_pool = mempool_create_kmalloc_pool(64, PAGE_SIZE);
> 
> We actually need s_blocksize size rather than PAGE_SIZE buffers here.
> How about a per-sbd mempool instead of a global one?
> 

Let me give that a shot for v2.

Thanks,
Tal

>> +       if (!gfs2_log_buf_pool)
>>                 goto fail_mempool;
>>
>>         gfs2_register_debugfs();
>> @@ -187,7 +187,7 @@ static int __init init_gfs2_fs(void)
>>  fail_fs2:
>>         unregister_filesystem(&gfs2_fs_type);
>>  fail_fs1:
>> -       mempool_destroy(gfs2_page_pool);
>> +       mempool_destroy(gfs2_log_buf_pool);
>>  fail_mempool:
>>         destroy_workqueue(gfs2_freeze_wq);
>>  fail_wq3:
>> @@ -240,7 +240,7 @@ static void __exit exit_gfs2_fs(void)
>>
>>         rcu_barrier();
>>
>> -       mempool_destroy(gfs2_page_pool);
>> +       mempool_destroy(gfs2_log_buf_pool);
>>         kmem_cache_destroy(gfs2_trans_cachep);
>>         kmem_cache_destroy(gfs2_qadata_cachep);
>>         kmem_cache_destroy(gfs2_quotad_cachep);
>> diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
>> index 529c3ec37a18..1fd5f817312b 100644
>> --- a/fs/gfs2/util.c
>> +++ b/fs/gfs2/util.c
>> @@ -34,7 +34,7 @@ struct kmem_cache *gfs2_rgrpd_cachep __read_mostly;
>>  struct kmem_cache *gfs2_quotad_cachep __read_mostly;
>>  struct kmem_cache *gfs2_qadata_cachep __read_mostly;
>>  struct kmem_cache *gfs2_trans_cachep __read_mostly;
>> -mempool_t *gfs2_page_pool __read_mostly;
>> +mempool_t *gfs2_log_buf_pool __read_mostly;
>>
>>  void gfs2_assert_i(struct gfs2_sbd *sdp)
>>  {
>> diff --git a/fs/gfs2/util.h b/fs/gfs2/util.h
>> index ffcc47d6b0b4..399c20004283 100644
>> --- a/fs/gfs2/util.h
>> +++ b/fs/gfs2/util.h
>> @@ -165,7 +165,7 @@ extern struct kmem_cache *gfs2_rgrpd_cachep;
>>  extern struct kmem_cache *gfs2_quotad_cachep;
>>  extern struct kmem_cache *gfs2_qadata_cachep;
>>  extern struct kmem_cache *gfs2_trans_cachep;
>> -extern mempool_t *gfs2_page_pool;
>> +extern mempool_t *gfs2_log_buf_pool;
>>  extern struct workqueue_struct *gfs2_control_wq;
>>
>>  static inline unsigned int gfs2_tune_get_i(struct gfs2_tune *gt,
>>
>> --
>> 2.39.5
>>
> 
> Thanks,
> Andreas
> 


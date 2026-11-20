Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198317;
	b=lTsM77XpzGSqzhzTzm9MQkxVQcRELhhixvRFvyzNWMGC/3EhgKYh6HyQfXJvIT8Ats2n
	 RX3wNl+e9+UWfgWZmhWWsYSLkYXTbP0wJOa0qqaqREJqNb1mGAofAIqclRf54pg0w3fi4
	 eKD3bFYRZJAnHaGksk+yovKgQ5IayXS1PtHozxhmwORAsYkrOsBKBlMadg4ipQHd25X8s
	 yQjoveCjC19AMI2JzBuOy+phkFPy6juNWXYOl7KhGreBUWtJTYcYJKPpyLUmnFZ8SWDvq
	 4hMw96/EHQf/+rG2k+vhLx53Vy7Y7wdH7MNzNZavPp/shudaYwQZLZ9v8hW9sAr6j+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198317;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=/HbvaKlMReeywZEgtd1iTQw4wI48noFpiEdqJYMVx94=;
	b=i+zFzB0zDeUrgD/uTOYm1H5G+3yuuzeW45wc7BMR6vt3ed6/4xjVaN+lpRIGk+DAp56L
	 r79W8CBKMnc3A7Jx2pkPjo1m2/TCN9fh6JReG0HX9Mg9tj0zc6DJ18/gJjZMKV7tvRHfV
	 j5HkQD8vovhzqwoKui+D9w4MQEWELg5BJM9whlZqwL2Q6GBapnVEcl6cngYKk7Vg1N//d
	 rFdhQJC3RAt+5cIsvFdQHX2bEVu3SIaHdE4gTGcdud8+PB0GzDi5qhKpCcoxjjtDJrU1r
	 1tJbBt7AzcRohbpo1DScnV6HxyGVqZKWf0IppYpFQcG18SVhJp8Euictdz4RujXZrXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=httni+mV;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=TCRPP6NZ;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8F160A3834
	for <gfs2@lists.linux.dev>; Fri, 20 Nov 2026 18:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA8F160A3834
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=httni+mV;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=TCRPP6NZ
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKHYUR1310780
	for <gfs2@lists.linux.dev>; Fri, 20 Nov 2026 13:11:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=/Hbv
	aKlMReeywZEgtd1iTQw4wI48noFpiEdqJYMVx94=; b=httni+mVCXuCtLzKiwFw
	I3LKN37khKahrulF+Ibb9JlB9x+CeuPaqTemH2H+yRJGkB2SAsbW1B2qk3ZA7D6x
	p70p8zJlJ7iIJlDsU/spIc1f9ui+lydhJ1+qHK5pUvNQFGK4K+EPI6C7lHMBHbiy
	5jpKDxcoRKi9NeSavNQ/KtE/G5NBwrVTxA5eOz5gDrViGOAkyU5NlmKBmZ355TUN
	0Fbm988HbSsp2nfPCjrF3Xhf92k0cvvBXS+jIHjKNqBImnFbIy5vhVyoiquv0fPB
	mePQI8p8T5do6aKol4VvgyXawfe9tsV+M/gelCTgzSUqcFDaIdfZW/BevwYkem+A
	wg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j2se8h56a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <gfs2@lists.linux.dev>; Fri, 20 Nov 2026 13:11:50 -0500 (EST)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-55c5caceee8so21119641cf.1
        for <gfs2@lists.linux.dev>; Fri, 20 Nov 2026 10:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1795198310; x=1795803110; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/HbvaKlMReeywZEgtd1iTQw4wI48noFpiEdqJYMVx94=;
        b=TCRPP6NZPh8YLIFB6OypI47w+k7fdgKP+S50kOefoHtzP6XLh3KAmDZ0L9AjL4yDjt
         ZD1TWCv6zF95z+u5tgxTL9ghv7SafOMf7ZxC4ZPy651HTlcWB6fMFUWejc454FabE9m5
         Heic1kwJXFrCrnayYkv7f1S9kXxEBf8spgHrUulRnmqBPfr6I2ZM/91IxCasp5ct+giG
         LcFtTHkznSKdWrxCNXf9sZ1BH0BNY8hxoYodhspwIEDvs3xfDaQMmUp/j7OBnHp6MtmS
         /Qd8/m18f10BiMc0h5VDm0psyNm0i7VJ0p4CcIt13u8H6SwBBYp0gzFJiNiPAiTrSnjv
         rLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795198310; x=1795803110;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/HbvaKlMReeywZEgtd1iTQw4wI48noFpiEdqJYMVx94=;
        b=LOPCNmTYbmdOwx49CS4vVhsUlcSx+Ywu3A+Q1xD8G6lxf8ucfLeT15sER4EXSZcPFR
         407Ug1gUZD7J9bA1vudGXy8ESQ19IWOWXtAdm9pbeW6hB83+y1B0QJtY0Fmv3opx8mtG
         9ycPz1tVnXtKo8XrTSlL8xqV6/DF+5fGhO51xhFJU+ya8AHK+znhIEIBEKMt50rRFwgA
         AaD0tCEIACihtqkcFi8iZ2QzjVj3jR26D6g8VVVQwX5HdTVjsB1TxyO2RiUu5gMCmtoq
         UFZEMmmiFd3/aAHNS7VdWT7BOEnMX7Aum6cCo3i7jRIGKsl5Pu7jjmD4+tuH43P5aNJV
         YyJw==
X-Gm-Message-State: APuU4Z96ztGW01BOHyL8NtpHDOrTR6RwWANhc4IWqg0GnZ9shZyXr+i4
	Gc7To/JOv84R752JOTB2WE8aU9AO6qJ3EfUzN1F43qJfRB+kqKZ6yh0lVscAKIyIZfCns3f1/7g
	AsEWychVE0wkVKGO4Q6qLx5yebSaaQRiI+OzieKdTs4rogd6nu54=
X-Gm-Gg: AZFdTZelSlinIP/hNmtuxJpFfTSi04PZKJebPzpeABtPpu49hb6Run9vrE3P4laK4JH
	co2QtTSwaWDaa1chVsTBeyNIT35gOq7s3kk9Rz837MVooQl89LoMGELSCCAP7XoMXr+/HvCbDXM
	X2O+Z9z2z8tsBlxwGNsFaQr3agxkYLWBvpXLTZ0qqWHGdhrsdpBOXx/hFanT7PMD3vrw2Xh2LfX
	qkfE8VHKieFma+AvmqNwp1ZZGSM7ScocvwP/j+5u2S6+kCWPxtVfkA7lZ6ZitsXDLSjyFN46wOI
	Vek0gkJLbaT7kR9hnR05oQCD8PjaCfDRHHYmMTwW8fbxMXaTth8iG63ZnE1spRLqALTdNmU73pf
	D1xRrvTleQ7NYK0N03Z7/wvYtm5wsnpKAOfy9OYYt8hCVv74xPPd6zjHmtwH4X4y6owN1QpPMPt
	PSboyegPl4dgAJCaR9TYH2Lf4H
X-Received: by 2002:a05:622a:53c4:b0:55c:840:1303 with SMTP id d75a77b69052e-55d76a26216mr72225321cf.14.1795198309708;
        Fri, 20 Nov 2026 10:11:49 -0800 (PST)
X-Received: by 2002:a05:622a:53c4:b0:55c:840:1303 with SMTP id d75a77b69052e-55d76a26216mr72224831cf.14.1795198309259;
        Fri, 20 Nov 2026 10:11:49 -0800 (PST)
Received: from [10.207.2.125] (nat-128-59-178-217.net.columbia.edu. [128.59.178.217])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d788074desm28984051cf.7.2026.11.20.10.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 10:11:48 -0800 (PST)
Message-ID: <061b0cd2-8bd6-42fa-b716-b23cb3b0db33@columbia.edu>
Date: Fri, 20 Nov 2026 13:11:48 -0500
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
Subject: Re: [PATCH 0/3] gfs2: stop using struct page in the log code
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <20261117-gfs2-log-folio-v1-0-35db3db42e35@columbia.edu>
 <CAHc6FU43KTAm-VvYXrR19BE1Q--2aHL6UALG9cj1pgdeqB_tBw@mail.gmail.com>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <CAHc6FU43KTAm-VvYXrR19BE1Q--2aHL6UALG9cj1pgdeqB_tBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GRdxNzeIpyMSaZOk63I3eQiSsZBLZZGx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3MiBTYWx0ZWRfXwFKxNnur8O9N
 FueTbjFEckeUgdhqMhiG4o6ElPs4s8a7UKSNzrzW3W7B0ccXog4tC8jm165J6GjOfwVtQs4fcz4
 Rq6NapCG9ArlKVRwThDe/mxoPBYJhoFGjKu/lUraP8HcrRmHxfW7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3MiBTYWx0ZWRfX3+YLL+WdHfN6
 BRHnLzmAfUO2U901HhanilS4drQ6gO2qPVKOwPtjnkpMrMvcg8kr4ZFoZRj0ADQS8ZgqKUvybsw
 YTP+DQjb3RIuu1VGk4hqrL8EUntXqPj5XyPayAj0BcJNflPYkz2ZcYHi44DZNHQsLTY0jMlP2//
 wfc3pVy8P3CZYhKYRs/sFOzX4jw8JNp2ys8kWjB0K7VgG3OUrE562rcTlCXY88dlLX1aqAatsrL
 JFrlTSM/Iu0C4fdIyP/WRfQoirAhZjscBtX0+ZYLzow6cNhdyniO2Jm2xS2L6ZLCsVrZClJhFlW
 Gj92D+q7/iKUaCjNedTtY1b316xAHKgylK96nW2exarliXTuTpMuXCi3mtLiu36IV6OiPAvpWBf
 gUxuEv18ndeBfDhA8hymmHVDmDG1U0QGBzrSPy7/qpk2+q2ILQdlQjWgdE2MrisvtJUkUniRsLU
 AYCJ5IY8Q4DcLKRXVBA==
X-Proofpoint-ORIG-GUID: GRdxNzeIpyMSaZOk63I3eQiSsZBLZZGx
X-Authority-Analysis: v=2.4 cv=VsS2kO2n c=1 sm=1 tr=0 ts=6b008d66 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=lnglQuR7XRqnmjDHco/WZg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=K6asUsQ3W9vegPjSo-gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11972
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=10 bulkscore=10 clxscore=1015
 priorityscore=1501 malwarescore=0 lowpriorityscore=10 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200072

On 11/19/26 6:47 PM, Andreas Gruenbacher wrote:
> Tal,
> 
> On Tue, Nov 17, 2026 at 8:46 AM Tal Zussman <tz2294@columbia.edu> wrote:
>> This series gets rid of the remaining struct page usage in the gfs2 log
>> code.
>>
>> The log headers, descriptors, revoke blocks, and escaped block copies
>> are allocated as pages from a mempool, and they end up in the same bios
>> as the page cache buffers being journaled. The completion handler then
>> calls page_folio() on every segment to figure out which kind it is
>> looking at. That won't work once memdescs land and those pool pages are
>> no longer folios.
>>
>> Patch 1 moves these blocks over to a kmalloc mempool, with their own
>> bios and completion handler. As a result each descriptor block is now
>> submitted as its own bio, so patch 2 adds a plug around the log flush to
>> let the block layer merge them back together. Patch 3 cleans up the
>> leftover page references in the log code.
>>
>> Tested with fio 4K write+fsync on gfs2 over virtio-blk and null_blk.
>> Without an I/O scheduler, patch 1 adds one write request per log flush
>> (196.7k to 229.5k for 32k fsyncs) and ~10 us to the p99.9 fsync latency
>> on null_blk (41 us to 51 us); the plug in patch 2 merges them and
>> restores both performance numbers to the baseline. With mq-deadline
>> nothing changes.
> 
> thank you for these patches. Could you please rerun that test with a
> block size smaller than the page size?
> 
> Thanks,
> Andreas
> 

I ran it with a 1k block size on 4k pages, and the result is the same:

job (fsyncs)      sched        base      p1        p2
----------------  -----------  --------  --------  --------
fsync4k (32768)   none         199519    232296    199514
fsync64k (2048)   none          15445     17503     15441
create (2000)     none          12228     14234     12226
fsync4k (32768)   mq-deadline  199509    200016    199505

p99.9 latency results are also the same.

Thanks,
Tal


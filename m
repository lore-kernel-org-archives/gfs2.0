Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD69822CBE2
	for <gfs2@lists.linux.dev>; Thu, 27 Feb 2025 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655613; cv=none; b=lbLcv2NBIc2oDTr5N7yGTmJfEa/tymLxBvlaQL5Bl12XtY2CIzbm/MSyd9+WmtNYWwjib3ucTgmxV0yFKRe7bGbbgqHPAB/Y5IHTXyUC1u+y2yiDqkUOZvd8W6Yi1VDJjuB1N+VqUgP5ARRaHiGWcWL5oAmqyDfYbCN9VumXRuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655613; c=relaxed/simple;
	bh=EIlg+WbLA/YZBn8N+uqGE57qCCOFyEqyXqmu3orYU2Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=P/F8YfM/lD35yUpyY4YTzIklspD4ozMiEBWWTsKbgMJHoNmyE3/HZElEarFBOB7f2DA6B9MaM4fQw5DSTFzJRawtBIuQVJRZHjSHYiAtoKZPWmjPYDwkkw0m7KQAh6k31Ojd9I6D+VASyrdnCxrQPs9xiGTvUiRtk+V/On8DSKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FAs8Mckv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FAs8Mckv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740655610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8PoLOT72pJKa/atGq+ov0RJ2nnxV7za2ZRyWtXnuC10=;
	b=FAs8MckvoE2aWIXqvqjWIGzjBzZ/+OhcHgcDpI1mh6dfxoeo+k/5Ay0Fserzb0+F+uGI9v
	CppOk10x8QNASQ+LT+xQLtWucYW4WfAmvOpuzr5oEG2J9B33B1OPRkYy76KYlzhq9lEZ4j
	gflyGL/rg65evdBps9/rWzrN0OxqVOc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-q9siR2ASPsiquG7bB1WHEA-1; Thu, 27 Feb 2025 06:26:49 -0500
X-MC-Unique: q9siR2ASPsiquG7bB1WHEA-1
X-Mimecast-MFC-AGG-ID: q9siR2ASPsiquG7bB1WHEA_1740655608
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-390e5214efdso338824f8f.1
        for <gfs2@lists.linux.dev>; Thu, 27 Feb 2025 03:26:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740655608; x=1741260408;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8PoLOT72pJKa/atGq+ov0RJ2nnxV7za2ZRyWtXnuC10=;
        b=m/r5i3W5buU6TG/0b4f13l8+uD7CroDjb+HBgs110MV2nB52IrstnAEwvFx2WeZWNw
         gnwwvzew3DzghOTN8uHT/ukwJ70iNB4UFQ8ajXkunVZW61KtZoBIdV6DoeczsWkyJn2G
         pWFRMwrGdpTiyq7vF9IKbE6ln42B7d6sqe/n+C66ZcRbHcYeoswV0HjlTQM+xQbWmIPG
         +e0n8TCmcICzm7+8fSKwMD+tfbnvcM+sCTU0Hc3g8FVhJvtAP9IrdvePM35PHHo8Dl/Z
         8g5/+90E5OwQ6s0Gji2P3iDTr/hOJJdqTB+T6y85FRjRiy2A53xV651i7pqIddoWTCHh
         wX2w==
X-Gm-Message-State: AOJu0Yy/kQD515crL/CrxvGf7cG+nA6W8Chn/cerr7gBD6C7UWPNhngo
	2zuij66mdcj8oMyNTV/XcvaY1S+Nk+mscnNlO5teyMmGAyLmBA0S7gHnJcE45E6e999mi4t5KSS
	Mvz0EWeRVNSQ1yrks1rnX5ra15w8o5+WXEjiJocd53dEiw3C9Bm3hqfmU6B7ryS5l1owkrFEZ5+
	FtgNCIUr1FAe4mKpoPcOWVDmupwBdW80IiZg==
X-Gm-Gg: ASbGnctOJ32fDY0uVOUeYkwIOkB7fF6zHsF9WVGCHc8edayk8nQke1jwAFg/4AuDsi2
	7iOHey06Wv672+xNG49DC2/jrvKiIDWzjKzphiDm5GuEIhfqT/QeQlH5q/0nq7TmJvgG8lfIkdU
	29sP55xbbnITLTLBg4R0Qo/YxsIparYF89U83OrTal00XoG3WVYPK9ZUInllqg2l1Ssjk4VPzgo
	OTE3qqhememqNxulqo72FgyMdiMgJP3XCPago3YeKw2nT6jEkmFPSNZWRi8pdfwW6twLYsoIutY
	siqBAGw5ZcTlvEg79O/WgFCBpJM695Oz1FzMr+YlpxgQZahCDBivzdKPR79xCBaKKmmdQFPpyJg
	=
X-Received: by 2002:a5d:5450:0:b0:38d:dd8c:51db with SMTP id ffacd0b85a97d-38f70859603mr17784443f8f.53.1740655608071;
        Thu, 27 Feb 2025 03:26:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxhWaeK8z1nvlIhuqjjQPLXvF4lges3VO5IGQDHhEwxk/L1Nh1pSaKHt0PGka9q+ASOhySWQ==
X-Received: by 2002:a5d:5450:0:b0:38d:dd8c:51db with SMTP id ffacd0b85a97d-38f70859603mr17784426f8f.53.1740655607669;
        Thu, 27 Feb 2025 03:26:47 -0800 (PST)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844514sm1730410f8f.76.2025.02.27.03.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 03:26:47 -0800 (PST)
Message-ID: <797dc02a-3b93-4b5c-9ba6-b7514fa9cfb4@redhat.com>
Date: Thu, 27 Feb 2025 11:26:46 +0000
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: gfs2-utils 3.6.0 released
From: Andrew Price <anprice@redhat.com>
To: gfs2@lists.linux.dev, users@clusterlabs.org, developers@clusterlabs.org
References: <8f91c89d-609c-4398-b03d-49d3ff975f73@redhat.com>
In-Reply-To: <8f91c89d-609c-4398-b03d-49d3ff975f73@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0LB8hLBpZ1Q_pn41f6M25ZarqVn-PTetmIgzTfr7xi8_1740655608
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

It turns out that the .bz2 and .xz tarballs for gfs2-utils 3.6.0 were 
not compressed due to missing 'git archive' config options for those 
schemes. I've updated the release steps to prevent that from happening 
in future. As Pagure doesn't allow re-uploading release tarballs I'll do 
a follow-up 3.6.1 release today.

Andy


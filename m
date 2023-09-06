Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542D362B
	for <gfs2@lists.linux.dev>; Wed,  6 Sep 2023 08:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693989399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8kxl0a4T7fw0FkcqLI3LPI8DvJ1AdEWlSu5wSZFK0FM=;
	b=i1TxdcZcLFxLIFsvaKRsQNC5u2YG7E3kKOqkT1nPeuZKZES6osmxfUIcerPUK4cSKw5G57
	vUfzUaMVL1fsurnkxyDU+RCNJJdP1DZrzj204hxpc6BJtfVlLwt0wlCDl1OrGBo1+D1sGF
	GJcICoDUCLsZqHjzjs8BVt098X4p6m4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-PnDWEqYDNRG8iuFT_O0cWA-1; Wed, 06 Sep 2023 04:36:37 -0400
X-MC-Unique: PnDWEqYDNRG8iuFT_O0cWA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-2f2981b8364so1855055f8f.1
        for <gfs2@lists.linux.dev>; Wed, 06 Sep 2023 01:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693989397; x=1694594197;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8kxl0a4T7fw0FkcqLI3LPI8DvJ1AdEWlSu5wSZFK0FM=;
        b=goI5ETPGT0JYlllWVlspbedWNNkY7DY2VEUGIyOkyE3UgZN44jxTJPj6s/Lw6EGqea
         N5h6JvIfuRjBQIkC/xuIeoL8beYa1Fc0OVD1E+cm18f/A62tzwAXLJYY7TU1dyZQcNZZ
         ain4cJjTQHsauzB3TMbJ3wSRnHpNl+cH4T9/C9Km3HP+BdMNaleMcBGBKnJOKjudnrL0
         +VIp2Qj1o5DeBKS+xb1niSToRIIqrx1FaQgLP7IcTHfOKb1cqeuRGYchjWusxZbqwkdm
         x1tfRj8cKNcpFqUbm9OjJHb77gLNaZ3IweHxD4j1LXyS5Tqaf7woe8v9rCupRoMxXOlJ
         Dcyg==
X-Gm-Message-State: AOJu0Yxb9O1Eg4YoASFjNhE0kGTQGZPbTO3pi5uMkiMJHO9CfJ/JGF+c
	Y1rD+iJnRzdNufIJkfoODlHZAveDy/GMjS3/SMvQt0SRGS2EXBoGTjST3n/hR+tPl3c5gMuo3jE
	F6vg/olODvx8aNQ==
X-Received: by 2002:adf:f106:0:b0:319:6d20:49c7 with SMTP id r6-20020adff106000000b003196d2049c7mr1970072wro.3.1693989396876;
        Wed, 06 Sep 2023 01:36:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFovfwa+rNzl6czUglrSJTNG8ZOkBhlMPLZKJyE4MkoRjEEuhGKhjJyrYPse3cVSXxQhy3ecA==
X-Received: by 2002:adf:f106:0:b0:319:6d20:49c7 with SMTP id r6-20020adff106000000b003196d2049c7mr1970055wro.3.1693989396597;
        Wed, 06 Sep 2023 01:36:36 -0700 (PDT)
Received: from [192.168.1.165] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id s12-20020a5d4ecc000000b0031423a8f4f7sm19895490wrv.56.2023.09.06.01.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 01:36:35 -0700 (PDT)
Message-ID: <91aae40f-deed-1637-b083-764a5dff4a41@redhat.com>
Date: Wed, 6 Sep 2023 09:36:34 +0100
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [ANNOUNCE] Goodbye cluster-devel, hello gfs2@lists.linux.dev
From: Andrew Price <anprice@redhat.com>
To: cluster-devel <cluster-devel@redhat.com>
Cc: gfs2@lists.linux.dev, linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <9830d291-a86b-df63-0b03-c99c583609c8@redhat.com>
In-Reply-To: <9830d291-a86b-df63-0b03-c99c583609c8@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/08/2023 18:07, Andrew Price wrote:
> Hi all,
> 
> As cluster-devel is now only used for gfs2 and dlm development, we will 
> be moving them to a new list hosted by kernel.org alongside other Linux 
> subsystems' lists. The new list is gfs2@lists.linux.dev and it will be 
> used for both gfs2 and dlm development.
> 
> The Linux MAINTAINERS file and other references will be updated shortly 
> to reflect the change. Information about the list hosting can be found 
> here:

Updates to the MAINTAINERS file have now been merged into mainline so 
gfs2@lists.linux.dev is now the official mailing list for gfs2 and dlm 
development.

(CC+ linux-fsdevel for awareness.)

Thanks,
Andy


> https://subspace.kernel.org/lists.linux.dev.html
> 
> To subscribe, send an email (the subject and body doesn't matter) to:
> 
> Subscribe:   gfs2+subscribe@lists.linux.dev
> Unsubscribe: gfs2+unsubscribe@lists.linux.dev
> 
> If you prefer, the list can also be read via NNTP at:
> 
> nntp://nntp.lore.kernel.org/dev.linux.lists.gfs2
> 
> The archives can be found here:
> 
> https://lore.kernel.org/gfs2/
> 
> and filters can use the "List-Id: <gfs2.lists.linux.dev>" header.
> 
> Thanks,
> Andy


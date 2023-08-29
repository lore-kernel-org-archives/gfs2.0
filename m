Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CAD14F6D
	for <gfs2@lists.linux.dev>; Tue, 29 Aug 2023 17:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693328880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eQhFPjtlYLcoapnQI3+6tHLH2wsZNiQelrUO842diMA=;
	b=R5gN8P3KWTxt1Wjab9MBFWxMn4H6rFdMAbmqC/7ZmvqjgRIzaR7RWgD8mR6T5jwF7vgTVs
	gy/OQu72Cz1g6n+ZM3743MmEJUjHQRKxGAmlKYJWt2BDoQKGk9Vlxczaf5+2MWHrEe6yuk
	YyjOcwj9lx6AJf7t66kDWlpi4iH68ck=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-CdKDjuVHMCSFZrO7DaHAIA-1; Tue, 29 Aug 2023 13:07:57 -0400
X-MC-Unique: CdKDjuVHMCSFZrO7DaHAIA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-401db25510fso3256885e9.1
        for <gfs2@lists.linux.dev>; Tue, 29 Aug 2023 10:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693328876; x=1693933676;
        h=content-transfer-encoding:cc:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eQhFPjtlYLcoapnQI3+6tHLH2wsZNiQelrUO842diMA=;
        b=ICGpkNf9zcBpwCyaaK/ejBJt7tk7B96sYxjMn8Attk3NzgxsgO+6Yuty0Fo5h29rHo
         Sfb8i3np4EIdNQVYjML8RWOAoDzEjnm4ctsfJQzCvNHvZVOrjkxkcN/47Ho0C5oas446
         7p+OK1bj8RjTFzWJOuoDNx6EA/VCK2BfbW6GlT9t/NFdTwrFSuhqaz7pxNQ3ZfSidIay
         wK82Yv+AuJgNLjsAYBXFFU0Lc11MyMzlpvSadbktU8I2ZBYG85VjUTKm/A8lBnGCUcLj
         SVrL6JsDN5BFx03yoUh3pvlFLPkW+inGTsGRtlaVPIR3+hTL7JCB/V9929xwV08f1Qo7
         Y6jA==
X-Gm-Message-State: AOJu0YyggaLS4O+v5/tZJb3i/vU6BoB3jJI4NjGb2DNZNhQmdbUg+u1U
	IrrG4l62fPeSGKIbbSm/2PaUzN4IyBfKCzHg4Sgzu3qGcleSHPAeRkC5jTB1QBpX+kB+gLb2YKM
	viIZhto4eKVvY1w==
X-Received: by 2002:a5d:560c:0:b0:31c:488e:ff33 with SMTP id l12-20020a5d560c000000b0031c488eff33mr18720302wrv.58.1693328876670;
        Tue, 29 Aug 2023 10:07:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOiwWfCAox03zTNnyqyrD39seU9dX+QHTpK8wu08ArO4hFDxz2MDIhfyvTXp5zaPOTn66gTg==
X-Received: by 2002:a5d:560c:0:b0:31c:488e:ff33 with SMTP id l12-20020a5d560c000000b0031c488eff33mr18720293wrv.58.1693328876346;
        Tue, 29 Aug 2023 10:07:56 -0700 (PDT)
Received: from [192.168.1.165] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id y14-20020adfee0e000000b0031c56218984sm14221600wrn.104.2023.08.29.10.07.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 10:07:55 -0700 (PDT)
Message-ID: <9830d291-a86b-df63-0b03-c99c583609c8@redhat.com>
Date: Tue, 29 Aug 2023 18:07:54 +0100
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Andrew Price <anprice@redhat.com>
Subject: [ANNOUNCE] Goodbye cluster-devel, hello gfs2@lists.linux.dev
To: cluster-devel <cluster-devel@redhat.com>
Cc: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

As cluster-devel is now only used for gfs2 and dlm development, we will 
be moving them to a new list hosted by kernel.org alongside other Linux 
subsystems' lists. The new list is gfs2@lists.linux.dev and it will be 
used for both gfs2 and dlm development.

The Linux MAINTAINERS file and other references will be updated shortly 
to reflect the change. Information about the list hosting can be found here:

https://subspace.kernel.org/lists.linux.dev.html

To subscribe, send an email (the subject and body doesn't matter) to:

Subscribe:   gfs2+subscribe@lists.linux.dev
Unsubscribe: gfs2+unsubscribe@lists.linux.dev

If you prefer, the list can also be read via NNTP at:

nntp://nntp.lore.kernel.org/dev.linux.lists.gfs2

The archives can be found here:

https://lore.kernel.org/gfs2/

and filters can use the "List-Id: <gfs2.lists.linux.dev>" header.

Thanks,
Andy


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC0B5383
	for <gfs2@lists.linux.dev>; Mon, 21 Jul 2025 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753114084; cv=none; b=Z8N06ANEOBaPa33WOIlPQRBi+FXvUIQpTK1Kt3ZoJy/1k6XwABqZeHiw850CVdK68pQ6T6nyJ6/NN2By78XIkInrZpysptQbEteuskdmQEntG5zMiisA+7bODjgeZ/6yGBa0w1T3tLGRX2/xvgavu79yDmtZIxzLUCxgplM7Rzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753114084; c=relaxed/simple;
	bh=Qh7SUFf1B3cq7mTejXfSq7AWODMEWAbVmNisi4eu7ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rO3GDMwFqggzwwwvH/WTAKxFd2n2Av/CBn6405GiUlTKGnPH8ogOcW+bHgpL70KuDTn1EE5fkoylwLAfDUAyhscUCA5Jy9UA7jIxKeX1nAs0weocgedUFLxiEUASTeUsgPHryOnPkg/pgyndHu++BCt9ekM9SbPVJEmqnu+j0sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=flpK0BiH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="flpK0BiH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753114081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cu9wGNux++7JCsJCsDX3KrdXqV88PlQmqNNIUVitAj0=;
	b=flpK0BiHzwMngrmrCAgXqFwnWXg23aGs0JYsXJ1bMS+5QEHrunJBK5HYQ30XsKQADRNmrS
	Ni9kiCLYiKF5eEq2ZzTi5wmxA49WRknFjzAH95W/RjnW4kxqMa2we7phq4oaVQcliuqmZe
	HccHwfhp/RrMupa7m6fDPDCNZo6Pac0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-20_Sv-fpM8usP1d9g7nehg-1; Mon, 21 Jul 2025 12:08:00 -0400
X-MC-Unique: 20_Sv-fpM8usP1d9g7nehg-1
X-Mimecast-MFC-AGG-ID: 20_Sv-fpM8usP1d9g7nehg_1753114079
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4538f375e86so40996915e9.3
        for <gfs2@lists.linux.dev>; Mon, 21 Jul 2025 09:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753114079; x=1753718879;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cu9wGNux++7JCsJCsDX3KrdXqV88PlQmqNNIUVitAj0=;
        b=sqUB3iDsNQXJXJ4/5tdA5/nFsfnCvpCqs9sO+Catg/osO4k5SuRx3CJ6VEMFTL3VGl
         akgwJMw07A46yyfHTPzfhSd/tKWAmF9x4S4ILriEzgZ2/S1CaJx1fQ3ie1pxo3br1itB
         ABrn+WMNwzod5/3K3MfrFLx7KJRcuyckCHyR0sEJTgExDK22mMWi5ukJIgSuX8bwEqAo
         FxutcJBAKDNbURIWLGgHFlWy/UPtjpedeIm3B14oDm4s9ZPPwkPslLBYvvsbaZ4v6gW6
         64sFy6W+Kjloun9bEtvayYKAoldmBPpZMlGI9Fe/XY0EAX1aGPXIihzSlHuFB5Vv7hU8
         uzHA==
X-Forwarded-Encrypted: i=1; AJvYcCWEfQTkW9neeqNptRbkKu8kELT7wzJYJThw+xfVHcd4dg3eUFYVpj2DmJMlYXv8azClN1QY@lists.linux.dev
X-Gm-Message-State: AOJu0Yxqx2SJ6QzRuaU9oeH1qnKtqu58IGyVox1FGBAJ3rIHYLCwosNC
	5OBfArbn+/ZbS7RFShMZciKyS2H0U04MJ6WHbvM+TN2gJh8Op8kSHXf+IkbnH3lxXNyqy6ia2AM
	wThVOd1SHr3JqLJX42Iw4GzifQPM81tt6nrBvB24R9JSl745klChnvBk=
X-Gm-Gg: ASbGnctuTcceDhYKXR21PJc5FbUt53uKzvV7IzQK0JxiBSUM4fGN6+ct2QwfB8MHLZh
	1Ix1MyCsbp3Xne5r80fx18815ysbz0uqq+9I8Tl/T3SNJRL7xSAEMS3LML77OuQWdI5bWxwL6/b
	z7dMCPTlvAuM+Tm/XEjXL16lbcCCHuIIEmVJNp4OjYfrxi4zol05aKS8k0kjEr8ha/d3EkjYGW3
	OpnR7vp9n2zWWmDB4IZiRtW935DEZG2e59int6/6dKwl439UrRERy4pTHEreqpoeKfgANCYq2Uv
	jR+4PwR577FyX5x/jUFXQtXX2pFYYKOaZ4soUQkWi4TPFIgYi+m6m9q5TQnkyHkwb0peLBlQ+8f
	H5SO6t9iBEFx0B7oaiw5h2sY=
X-Received: by 2002:a5d:5d85:0:b0:3a5:39a8:199c with SMTP id ffacd0b85a97d-3b60dd88792mr18018359f8f.53.1753114079333;
        Mon, 21 Jul 2025 09:07:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrCA1pF8sImumfSHdQ2k+0yQLP5WebAAcanozxpaX2zPA+ngbvOPE0ORhEtm3FdkZUAB4rRA==
X-Received: by 2002:a5d:5d85:0:b0:3a5:39a8:199c with SMTP id ffacd0b85a97d-3b60dd88792mr18018339f8f.53.1753114078928;
        Mon, 21 Jul 2025 09:07:58 -0700 (PDT)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b74f5f3sm102754515e9.25.2025.07.21.09.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 09:07:58 -0700 (PDT)
Message-ID: <f9801a25-9338-45d6-ab22-344f4e8e77b7@redhat.com>
Date: Mon, 21 Jul 2025 17:07:57 +0100
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [gfs2?] kernel BUG in gfs2_withdraw
To: syzbot <syzbot+ed42f17ebcb58526788c@syzkaller.appspotmail.com>,
 agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <000000000000a7170b06211f16b3@google.com>
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <000000000000a7170b06211f16b3@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1xg8j7_HoLquzqNZK9AFaYpWloVh9KwTgtqpjXc1Kxs_1753114079
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/09/2024 09:54, syzbot wrote:
> 
> gfs2: fsid=_){&.s: about to withdraw this file system
> ------------[ cut here ]------------
> kernel BUG at fs/gfs2/util.c:340!

Syzkaller has been patched[1] to avoid using -o errors=panic with gfs2 so expected withdraws should no longer BUG us.

#syz invalid

Andy

[1] https://github.com/google/syzkaller/pull/6191


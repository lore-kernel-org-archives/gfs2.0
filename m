Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA5D2E11DF
	for <gfs2@lists.linux.dev>; Tue, 15 Jul 2025 13:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752584450; cv=none; b=Ji7FE8k5UvySc5iynkOzJkJuTITC2EkLY1EQfrFdCMYRioCT6JNv8GPAOwbSV0oU6UymPHaIVaU1bd++crC9XZKjZ/4/asYv2P7byrOJcY+uJirE3PzRAg2jxikQLKt8fhqC0L8kdEVIZSVtbWotiFLFmjGuZlh2rVi/bXreplg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752584450; c=relaxed/simple;
	bh=nRKeg8nDzlYWzE5XInGEwKQE3e+XD8za49IF5TuC6t8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=KRnwKnqkgl1nXYpg04jKRV0oXsVsG+6jhp92X/PpCwI+hmvjZYsHX5DSnMWbS+HGgPpvzbkjaTh7V+T4eFGgPlz3RADHhU2IAHN6cf1h35GV1c/P5DDmiOcmISu1QE4RBpFFik4EZtjZUKDvQO5Q5Eqls80PIrOFGfytC4zv+fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=axa5htBv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="axa5htBv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752584447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mTOb/M3X4bPhZw5/ISg0MVilrU9KOEKNMA4Ln3msvQA=;
	b=axa5htBv4m0aSjKB1VfkY1fVa016tKgRy93vUOzE2Twv1pHa7T6zz09/a2rqctDALyU2C0
	4uTrxUj4NZEi6VZu4rucFFxGFNFYUh45WP/XWAl5VzVkwOYPy/fVXVJtHMMhV4gtxYO24b
	yOFIrX1retDauph7+VkWibGAbM0XAQg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-pBBxAzmqPXyP1WgdXsZITA-1; Tue, 15 Jul 2025 09:00:44 -0400
X-MC-Unique: pBBxAzmqPXyP1WgdXsZITA-1
X-Mimecast-MFC-AGG-ID: pBBxAzmqPXyP1WgdXsZITA_1752584440
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a6d90929d6so2449340f8f.2
        for <gfs2@lists.linux.dev>; Tue, 15 Jul 2025 06:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752584440; x=1753189240;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mTOb/M3X4bPhZw5/ISg0MVilrU9KOEKNMA4Ln3msvQA=;
        b=hbCfM9oCopfK4ov0o4BsD4zU3S007wXKLztValXmbBMgfpP0x44MvSxk66Mf59ITzF
         FbBR3PgBx0hIG2CfYGkzJG/CX0iu4sPD5JCDSdaDUnD02G67U0KXkzDyHAQyq1Tqw7+R
         FjKxlDALKa/mVCrLBmtfYJt1B1Gbr66EZ9TiZtDsuSdYTXzONi2POoePnluDl+EO6cg+
         8H/XA7l232hFmv7OZWKqyMGrUzriUiDd/b6EgLIHiVl+z8HZ/akHAl5OjEqs6FbG3MzZ
         bQHrH0vTkirp/BhZlQp7Xqshksy/Pcs2FX3DEmSCyb4mznk+uWJ6R2MhZMYLWWobnHVn
         PskA==
X-Forwarded-Encrypted: i=1; AJvYcCXurM31Y52JPA4UeyojDJFmlF19gymLcevOQ342/zXyypBRkOsrjy+aA3azfKcJYXewS/Sf@lists.linux.dev
X-Gm-Message-State: AOJu0YyNrC2P/et5csK1Zi6Ho07WKTQWbD8Znu6gJpaFCkN+G57GFnJ0
	L2H0/zgT7F/sVPVlER7sB/E4reV8yloccgsTln4EvAb48OgN75fyuIC1HFSqgkXBf8VibFpW/Uy
	XwC6uXMsgl6c715SzZNmKFX2qSKhCnaok1HKCZYA8ufMxRyB6dYia2l8=
X-Gm-Gg: ASbGncvf2mUWnSA22w9Id07KURBgi+pGTeFDixHDcVUmjtg4RAQUUOR+PtzUjLHmsqr
	isRhV7cBhFmZeBiGBPkCASObb0TAvoaNG6XTA7UV3to+1ISW2WS8dR7tAfg9kZIK+vefnfpMWWJ
	rVnWB3ZgSio5v8X6vn9RnH02sRn1sg9YTRIR8QZxKVOX8IsOwM8aBL7AY+v+b9qDtWG2GibDsuw
	Q+bTNZzaJY54u8GZVhNbuZQaIso1JrOWS9vjzn14eYTUvLjvhvQr/kbRC82mbt5qow+VyLJ1SQy
	0gYXARQiZdU8dXeF31hH+Dazn+ephFF5lVpQKlQsROj8dTGb9z7BguJTY78UBjG5zD76B7ZsraI
	+omYRBsCfFYtTkveAIaR6+bM=
X-Received: by 2002:a05:6000:2884:b0:3a5:2c18:b181 with SMTP id ffacd0b85a97d-3b5f2e3a02bmr12684760f8f.53.1752584440015;
        Tue, 15 Jul 2025 06:00:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVnW72xbgDwMGMGrLLaIH2UN+xI4Nl02JsyqBjVGQk6nMJx7+WMekUv0v5WCGEQkp8RbKskg==
X-Received: by 2002:a05:6000:2884:b0:3a5:2c18:b181 with SMTP id ffacd0b85a97d-3b5f2e3a02bmr12684708f8f.53.1752584439527;
        Tue, 15 Jul 2025 06:00:39 -0700 (PDT)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e14e82sm15164588f8f.71.2025.07.15.06.00.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 06:00:38 -0700 (PDT)
Message-ID: <ea729bcb-4aac-48c2-9f9f-4eb8b59d1aec@redhat.com>
Date: Tue, 15 Jul 2025 14:00:38 +0100
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [gfs2?] UBSAN: shift-out-of-bounds in gfs2_dir_read (2)
To: agruenba@redhat.com, gfs2@lists.linux.dev
References: <68764d4f.a70a0220.693ce.000a.GAE@google.com>
Cc: syzbot <syzbot+4708579bb230a0582a57@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <68764d4f.a70a0220.693ce.000a.GAE@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dNNpYHmfA9GCwFkxjcKY8ufP3FDABgsc7ifCP1hXZ4g_1752584440
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/07/2025 13:45, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> WARNING in move_to_new_folio

Known issue, fixed in for-next...

> console output: https://syzkaller.appspot.com/x/log.txt?x=11eb8382580000

Looks like it's hitting the new validation instead of the UB anyway.

Andy


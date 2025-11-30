Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071F723AB98
	for <gfs2@lists.linux.dev>; Sun, 30 Nov 2025 23:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764543823; cv=none; b=WIjNj8IJIboZ9yiBDfc8yIuF+c4w0bgBb14J6KDq9YHAfHrcNqVVuFNxXVqUbeYob7LH260Hg7js6LpVPhwwvNRe6VxzpZSV5OOcIvQ4bZUDq+c1bgIrwvM4mIitqGua1/NduwB4ZaVpTHY1F62Mh0Iv6AsNV3bZegHOsqiRwgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764543823; c=relaxed/simple;
	bh=+KhrMhcJSvItbb/04gtqwcqQ9SN2qd7j6u0HCMyKS6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R6ubpOGQCBsiB4K6DO/Ns7Jq5daS3IUAXlPS7qFzap3CiOAc779seUlDNyRJGltkmqGq8GHrayi1SH6/sI+rayXLtaPB7oemax7OEhL/X5N0RkQmKA4PRNfUxF1f2Ls8GvCzMJQgJmxzhrI716EZSd8xjB1ikigrpEwCeobpEWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b3c5defb2so2538280f8f.2
        for <gfs2@lists.linux.dev>; Sun, 30 Nov 2025 15:03:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764543820; x=1765148620;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+KhrMhcJSvItbb/04gtqwcqQ9SN2qd7j6u0HCMyKS6E=;
        b=RASzL+gvUnrDHQKr+z5ODU/ho1Ac10cDPy/fZfo8IUQibiD6mmmEtg2yKnej7JXL4U
         AO7EjqawlGSiNOhYrSvGgZYAowgbq3ppbMOzIW4kazGie9EZSUZN8UXiJu6QVXZQroLI
         Qw60J9xfL77OGMUPHb9D7rxxIRudENQjf7y1ZspaHzydbJ42Trv/hdPvIHAGFKdv4cgs
         iXJcQtesTN6KFyvcrHMzvZvySSsttSqui78SjjcH/pCvqDR+M57BM3bXPLOzsgKUKr7q
         GEs6BtZZAuK9tF1rHEWtg9mlDpjz/JZwRpuw9HLlALVYLv0tTQt8Lt3pBnHDLitYeYNr
         loKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6AJ8/BlrHrnjdziJrLd6595s6b7bUSViCRCwpfclehWYaVb34IKohjYIfyTrEjvKET7JE@lists.linux.dev
X-Gm-Message-State: AOJu0Ywt3fs8wKBRcy918RxJuzGjMmj+hCCepfAvFcb9xmRlERM2vObd
	Fu5Lz6wfvscyomG2OFAp0tuw6/jMFTfDjDEdbPYi1rmhstVQZgc5oOPH
X-Gm-Gg: ASbGnctp2KVVjlvflC1A3+piTQTYKz5ShJe8P12L2Nk5Jpe+maL05WcsO2e2O2AK1yy
	LqkmgD68h0HOEDpA6637Wag2dpM7owFfKWpwiUg4BMv26XP5ffeLpmNiUFqcHQSQVEbXyuHDWIY
	KiIQDbYQ8HUbno0UoULzNEw1pglfA0pjROd9lsw5oJTrcxd1GwzJb9iNlZsNzKebmtVbJqul+bt
	+CqqSc89+ORK7OmCMNL43YAHZnXb4s4hRHdKgpsZCna8dB2mChcEYtVYEoltraFihAXBY5hQom3
	GcJ4+bFZjEtTij3cJrMrNdlLPNvm8NGTr6KdUsKYFzNo0+3jIk9imHKGSppmHP/fGysfy5o7zWm
	XdUZ2vuFxczEI6NeU3UrzhgSa3ppj7hwBkHxmASWxhq0w26F6gW2DSlij1IY9Kpe5iDTIeOCy1P
	wEgPuFf30xskpk3cavkeNS31SmzBYkE3q9I01zP1a1
X-Google-Smtp-Source: AGHT+IG0kUJO7SYN4V6YpXy8uJxkqAm9wDLe/yTWTady0nKXHIsEefrNGBZg2POKGw5qhetClLnvgw==
X-Received: by 2002:a05:6000:2484:b0:42c:a449:d68c with SMTP id ffacd0b85a97d-42cc1d0cf34mr37257663f8f.30.1764543820316;
        Sun, 30 Nov 2025 15:03:40 -0800 (PST)
Received: from [10.100.102.74] (89-138-71-2.bb.netvision.net.il. [89.138.71.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1caae37esm22401721f8f.40.2025.11.30.15.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 15:03:39 -0800 (PST)
Message-ID: <b33b3587-edb0-4f30-a8ee-baaa2b631ed9@grimberg.me>
Date: Mon, 1 Dec 2025 01:03:37 +0200
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/12] nvmet: use bio_chain_and_submit to simplify bio
 chaining
To: zhangshida <starzhangzsd@gmail.com>, Johannes.Thumshirn@wdc.com,
 hch@infradead.org, gruenba@redhat.com, ming.lei@redhat.com,
 siangkao@linux.alibaba.com
Cc: linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 nvdimm@lists.linux.dev, virtualization@lists.linux.dev,
 linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhangshida@kylinos.cn
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
 <20251128083219.2332407-13-zhangshida@kylinos.cn>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251128083219.2332407-13-zhangshida@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Acked-by: Sagi Grimberg <sagi@grimberg.me>

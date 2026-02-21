Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3509C35957
	for <gfs2@lists.linux.dev>; Sat, 21 Feb 2026 23:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771717567; cv=none; b=tr+Zf5B5BhsYTNx+eBWO9I8Qgy/6zlzANCmTfjanxoqvuEJ/FgMB1W8PNB0dev1Bx+//Idfw36szsbuHQY4Uwuxu8zBXvkI4Nh/knNjmNw4Tr6HD/x9fDNEieHD/+XJRBz+mIffQny4JsRFVyjKVk5Lq2DZ2zQz6Xxnj1ur6kXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771717567; c=relaxed/simple;
	bh=D8wEA4P1R/wLC0WQ2gaxmvJV8Zid0j4uMfM8HtVxkhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Txbe4BPIYiY4rEd06Io32cWgN/EVyCaGGpD2ehqwM4f2y2YBg7Etaw19yfLUeBIEkABybdgRNGURiHEwupLsNkUZ7liTPQih9sXzlRfs2/gGjFBFVLQ9xhCtxsFwhOkn2KMP4/bxuz05/9O+yH7moQkERCW7OsyK6kSDz96SDg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9B/4Vuj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9B/4Vuj"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso23839305e9.1
        for <gfs2@lists.linux.dev>; Sat, 21 Feb 2026 15:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771717564; x=1772322364; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6c+2c5A4IdcQR95bgfQZwtsMpRnSCzmv5kOunEAmnw=;
        b=U9B/4VujIwRlLWfCPD2INIQ63S6v6zaiqnE9wgd17tr5HulcxH5ZDaVx16F+8MYaIA
         OXyc7j6HOtiBEvYKETN3alL414e2amAN2+rd0jpuJEO1Xy5/Gh1+yPdwn/VYBSwqf8bx
         T2sgyHuZT2VSr4Ti87ONQg9b9voF2rN5crg/51U00ABNMaaItenTe0JJsLAKKWq5VN+6
         tuR1hG+nmydA9zfBp4B1+GeGQk++l/qjT+NXUvbZNlMlZejtEYbcU5PPyseMpaRNHssa
         J2nKj9pc9ah2lNhCWsoKSPRBn+kEcG84FIRVGhRVy/fsLHgY7wLWHnv23Wl4ZJmmOwrs
         aJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771717564; x=1772322364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a6c+2c5A4IdcQR95bgfQZwtsMpRnSCzmv5kOunEAmnw=;
        b=SEFh1yKbOI4+L3/QjNSu9wK1RRz2GLPfig2e5/aboavgXdn9DK23qIy9UQ14BCrxuA
         CG8rhIoo18rMyz/ksxU+OHSa1pAvymi1aF3wa1Z/EfGUWMDZKGZ6a1cw5Zc8t5eBCfTX
         fqdNPX+ath2m5cZGEQgkXPk9WyTQ0Quyv+XvS4/DteKmld/RxgUUtPCnVhN5Bd4HKWMI
         vLcHRoTjcwYqRpZjQBycewofyhuKdBLgy2bg4Px08eYwWVVLu3dxqAeGdO03V/5ue8Zp
         jGz5tgDa2i9+Bss6z3uAt22ZVv2GBZzCT6fyoIrD4AOWXdMiMcA62UfOQoWUxnnrTR5Y
         xDzw==
X-Forwarded-Encrypted: i=1; AJvYcCUOj2eBfaEvUODfvWQ6ELBcQ3816a7rfz0mmbL4AABvZ779uFclPzckG1MZuHS65/moZCfm@lists.linux.dev
X-Gm-Message-State: AOJu0YytBS+iNA3/LNMTw2CK1VnVWfRF0hfRU6FBwPRsspjVJLYVHqXj
	syfQ6jm2PNJkmvP/pbmNp/0J+O4zYBZEQIMb/KegO+LRpaop34cd/nH/
X-Gm-Gg: AZuq6aL8bvEksoQ5XE37OZemkE/BVvjdza8GtJevDPSTgC6YRpOrMT1IYpkr+cB0vLf
	5Hjhy0AD55MYSI3gRmdlUGL9i9I422yQno8SfJNaVXXv4oh40g7SuX7AJzYKEI1Vrj1dLuwHMln
	mKJMYObd+XGsj41Ri5g+Vb5StKQqzDYTqFvD8f1GVOGwurKUL/vWXaTR1ry35a0FiLYwjQ7Zyii
	4a8XCFRMZRA9/w1SggZwYuyfHvd0SsKskx1S2VwatyOsH6CJSluF8fLX8NVDf3JOm3PrdhKqRAZ
	GPrxaIDKFOLV8PQWlh/KI/Cc5RZ3iomejZnO89p8kAdTJj5pSjrqh6YZ8SiGSMO4qlGaNiJBi3E
	IjvIuOKIlbsLusYOEJxqxVMy7VGrLxc2G1TVX3PP0rFKXB8CgKYyofUgk1vNOa3ODc6536MVeya
	OjyAuzRwCcazp6nMt8gRi/VBCeWg4OVA==
X-Received: by 2002:a05:600c:4749:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-483a95e5ab8mr72338125e9.24.1771717564334;
        Sat, 21 Feb 2026 15:46:04 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-483a31c56d8sm251620925e9.8.2026.02.21.15.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Feb 2026 15:46:03 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: dorjoychy111@gmail.com
Cc: ceph-devel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	v9fs@lists.linux.dev
Subject: Re: [PATCH v4 0/4] OPENAT2_REGULAR flag support in openat2
Date: Sun, 22 Feb 2026 02:45:53 +0300
Message-ID: <20260221234553.2024832-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAFfO_h7TJbB_170eoeobuanDKa2A+64o7-sb5Mpk3ts1oVUHtg@mail.gmail.com>
References: <CAFfO_h7TJbB_170eoeobuanDKa2A+64o7-sb5Mpk3ts1oVUHtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dorjoy Chowdhury <dorjoychy111@gmail.com>:
> I am not sure if my patch series made it properly to the mailing
> lists. https://lore.kernel.org/linux-fsdevel/  is showing a broken
> series, only the 2/4, 3/4, 4/4 and I don't see cover-letter or 1/4.
> The patch series does have a big cc list (what I got from
> get_maintainers.pl excluding commit-signers) and I used git send-email
> to send to everyone. It's also showing properly in my gmail inbox. Is
> it just the website that's not showing it properly? Should I prune the
> cc list and resend? is there any limitations to sending patches to
> mailing lists with many cc-s via gmail?

I see all 5 emails on
https://lore.kernel.org/linux-fsdevel/CAFfO_h7TJbB_170eoeobuanDKa2A+64o7-sb5Mpk3ts1oVUHtg@mail.gmail.com/T/#t .

So this was some temporary problem on lore.kernel.org .

Sometimes gmail indeed rejects mails if you try to send too many emails
to too many people. So I suggest adding "--batch-size=1 --relogin-delay=20"
to your send-email invocation. I hope this will make probability of
rejection by gmail less. I usually add these flags.

If you still expirence some problems with gmail, then you may apply
for linux.dev email (go to linux.dev). They are free for Linux contributors.

-- 
Askar Safin

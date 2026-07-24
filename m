Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2FC427F99
	for <gfs2@lists.linux.dev>; Fri, 24 Jul 2026 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784911895; cv=none; b=cdlFeHqKiJMzsRl7KeyIS4/V5FFphmTTBs9g4tl+tiPl5TwYXGgFyYI96nse63sVvbgfDueEQYU6JdD1Wny/btGIlV7iv0aG3ylQ6AuuFTXB0WhY/qLvXyv+I2S2pBGoKBwxHKhuXvUpwpW5QFrRIVrdqGRu5uRhLW1xz9opgLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784911895; c=relaxed/simple;
	bh=N13xBVt6XSL5vGlO4q0GyWtXE+bm+Op8JL0GBdKR63g=;
	h=Message-ID:From:To:Cc:Subject:Date; b=SxKEgaygtiqtFOsP0j8XcnQ3IdnC9drTkPocu7Gl+qx2v7O2UWWNFljfSINt7oRzPV5zOQcZLTV/4EWTIitfuUCBjFFgIXvHX3hwCUkWrvJGdqcozn4IhKlDR3zB0YqBcsmtFVs1CZe8U9/bpSywyu/nNgTXdYcWO2wSyozs2VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ruh1RzWN; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ruh1RzWN"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f9ab7ee38so392246f8f.2
        for <gfs2@lists.linux.dev>; Fri, 24 Jul 2026 09:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784911892; x=1785516692; darn=lists.linux.dev;
        h=date:subject:cc:to:from:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0/X9wxda7hczNIya1cZLl5fDnIMlOEFDKzurgxQbKb4=;
        b=Ruh1RzWNR0ai2B/Yb3wnySsc/5itpgUN0c5VBEzpSb1yl+pKuyUBwtLPbaVGtAt3fa
         fE0GigiCiONKMW4r857J9K4mdIMtq1SXff1Baf9Oyjc3pv3mrTNWMqps7cQpJDTXsQOD
         zANnHrqonsNL+jYpeCv45EgQ7um8FtzpDeThHw+pvVtgLFAXeSeGvr8vU2/A+FDlHm+V
         aSjqLDUJUNRWh+v01Lw5vpm8Geq0rIk1NB2VRr17ZL6deuiG0pUuI5Lew6BPnkfilhHj
         0zq5Sp8Xhiahrnn2SDTltWw/QACZGBVdctMzTcsZRZj2Bl5kurIfniRMokCiObJnCNCT
         sELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784911892; x=1785516692;
        h=date:subject:cc:to:from:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0/X9wxda7hczNIya1cZLl5fDnIMlOEFDKzurgxQbKb4=;
        b=rUSAFIOjVXJS1b9LB0PwQalScPyTWMF/4Y0vuW7fiDEpXZUU5AF95RW0S3FsTt6zWc
         bvsKR15SXEtdV/UkM5AHL45eUVz0DjFZznJ149yNR1EzHk2pcmlOVy36UbNsQbbEVV+w
         QQPE5isE7vfF4d6r2fJO66qIdLHq1DtPciTExdCDwHszxKSGgdAoSRSdGIODor8jMItz
         0D+udTCI5psyagBbLmFMqNnAkBTck8pEukTIKDzYgxeuwNehyjsuGwzp8NJyoHOMQMr8
         3M3GUQmp04BLGdtZHsrq4sVhTKz9P0nftN1GcOiLM2GFe0SraoP8Yefl/FBKHcrqpLMe
         RYOg==
X-Gm-Message-State: AOJu0YwEJjMr8jfQ4F3Ny27sih7GlGM56UdkZMc4x3RaQXt6+G4e79Xn
	tE2RjYy4kSe4C3PhfD71eGakniE5aU+C/J98JlR/4rDU0JhKYGKRJQKnW3xy4yGRoYY=
X-Gm-Gg: AR+sD115F8nJ1pGpSUVA/yjm7D+/wYMwfVFKhTnVMh936vZfTSPcffD6SbldK+827PK
	YSHAqkK35zNxDK5wD/ES4PSvDiqsKuZtUY+O7tTUK4tpj3wj9SHUfnX5rFkpYvSVnbxcrHRzssL
	csCeKN7w4OoCITYZwEKEnKN40wsIsGpezkhF01I10T7Qqjtd70GS4w5E3gfzf/gEcVjwEjD1Ey/
	gXFasUn8aJE8MOIC8PoU02PKvJrWHDMmnRPEe4axV4dGwxgIgi0q6/O/CNtP/ZSUtJh/MwsKI6p
	JWnXwD6kJBM2nB+Cy9YhqZHjS5k+umITM6cZSb4bTRjZug09X2YsKRKboZEYyAwsNQPFbCOIsYo
	IBOu92RYJqBLMB/yg8LOnQZ+YH3L6f9JYTPBQQSg81oiuufY0rlERWn/AP3x3Bdq1mOfDhefGxn
	+Y2H4Gzcqt3UHyzVNGLAA4d/8=
X-Received: by 2002:a05:6000:983:b0:47f:89cd:b48 with SMTP id ffacd0b85a97d-47f8d76de31mr10406008f8f.5.1784911891547;
        Fri, 24 Jul 2026 09:51:31 -0700 (PDT)
Received: from disculpa_gfs2.eml ([171.22.87.132])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f96d4656bsm7728824f8f.21.2026.07.24.09.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 09:51:31 -0700 (PDT)
Message-ID: <6a639813.e862d496.345987.397e@mx.google.com>
From: Adrian Garcia Casado <adriangarciacasado42@gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gfs2: add missing __rcu annotation to i_gl in incore.h
Date: Fri, 24 Jul 2026 18:50:00 +0200
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>

Hi Andreas,

I am terribly sorry for the confusion and the noise in my previous email. 
I completely misread your message and drafted a rushed reply by mistake. 
Please disregard my previous "Thanks for applying" message.

You are absolutely right. Adding the __rcu annotation only exposes the 
200 sparse warnings without fixing the actual underlying RCU dereferences, 
which is indeed not very useful for upstream yet.

I will go back and work on a proper patch series to cleanly address those 
underlying RCU dereference warnings in fs/gfs2/ before submitting again.

My sincere apologies for the noise, and thank you for your patience and 
valuable feedback.

Best regards,
Adrian


Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E691B2193
	for <gfs2@lists.linux.dev>; Wed,  4 Dec 2024 11:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310308; cv=none; b=Nt3RlkEvZJBEOLuw4JUPwPi1Z6GjI10kVLVYE8ag2W8wKppnQmOJcu72zdiBqJMk/WvWiqzVxa4npJx8/YUoZG1pZCucc6QroYjndYrjAeDIfz2Xtu8OShMg5MG36Ytym9U8CKAd9hTtI0r0y6XYvjXEzMepg6xny29qbVTuIxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310308; c=relaxed/simple;
	bh=51TdTifeSvLvI83JsA7+gyBk7k4Ry9GmmMnPVzQefmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyruJTIhQCB3ZmuY55GcfFffu8Y74ClKNz3s4L44IJaFkg17zDU0b0rafcBjAZcKipoXnEL1rRIc+JIdkpTKroi/Xu/wr8QiMmEtU6rhfHLRXfSr93274O5c/Y10KOghKO3OvXO0M3euTukdZWCwJ4ofD+mRL+P37Iz0Qt0IqWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAz9Scgu; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAz9Scgu"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d0c8ba475bso5809403a12.1
        for <gfs2@lists.linux.dev>; Wed, 04 Dec 2024 03:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733310305; x=1733915105; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U8iOMTKaSNU+mizzDkRbhYPc/Yr2+80O2QZAV03wO8Y=;
        b=fAz9ScguH/9SSbrNR59w8svwzX60Cq1boGbL1hR0NlxuRWYe5++kdqAVTkJieW/284
         GH5zVp7L1JDneXVj1VfYNxRqvgy2a2/ojhDrKMmY+nOgRq26KnI8NudvHoufbpJ9DzzO
         7Y2nxpBqr/j6GkWGcmGX4Y8be6Rrm36R4SsstUo8MWYhowBYvtOPRVq8tzS568UWjZms
         0rXutDI80/RaJt7MHqesocwgouW8bMf3sbSufkvrBzKPAp3KBLd0j/c89XiIjP5zYej/
         sRg0NhL6nIjehlzRuhcn33NYt2YNcxSTnS8noOmzDw3SWyQ8XOJ7CHipA7Zxq5iz63Az
         S8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733310305; x=1733915105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8iOMTKaSNU+mizzDkRbhYPc/Yr2+80O2QZAV03wO8Y=;
        b=DUnBD/1sFMMGGCzdZftQYqJNYJCrh3ElZftWboDrYoDdgjv2h0rqhmMMxdm8xYAE+2
         /dbnGRRA8VzL+2x5c5bP9jR91uYcRSZ5Tx8SCbZx/y7A53QwRpY8e+pQDmjSnxiEM5RN
         /BSX6/Qh4mLO34WppJd7LEBv8KK8yl3vkWubdNtDBeEhR7lmKzs0NaK1VwQPx6OY/2Ea
         y8aygvEpog3vhZjN6cOXTAoevqDjL9U3HkGw2SQn8goRKLQNh9+ByrzdsA8Rz92tWTbK
         DF586rlxyjH0A8fAiiUZ65G4boA24GefFfkfl0kWY5NFZ7tA7Doq6tDFokwvS6uWejJH
         0Xcg==
X-Forwarded-Encrypted: i=1; AJvYcCVSau+Rc2EX70U2rrWvK5UGf3sVgPtPfGPMpW5xEEZRgu/QAs+rlYsM0FzV0d306jXHnkSa@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/XN2Y54FHMRyP0VLTPhi5T4kPADPmTX+d8nh8LGrwaXAI/ptI
	zJgOCWHHVeTJajOLkmJzP1vPaZWvbsp9cQfn/y6qyXhzxotEaMdO
X-Gm-Gg: ASbGnctZcbQ+bwmLCv+jxJMCfkYHUHcMsfif+CyVTJc6ggIZWL7P+B69KncUOFen4nB
	FnKGXQt7SfAeoZph+exQ7/z+BwekAaUsy0SKNoMqNb+0xrc9/JwhuV/ZIkAMY/JUsoEhOynjlZK
	bbsSoTFRbKGVFCH7588JeRxIDXUpfGUfNktk3YveQLjiV6ZgI5B355TsiL+VPm3LidV+QSAunFH
	OtxY1CCyKa9U2eCPvfQOb4HFVwfYKxiWjLa24wJ2ji1v5+ZNlnfCNnlti2JUEc=
X-Google-Smtp-Source: AGHT+IHKPs8LBcfpZx6PibQeJxtDt6cqZyCFXJ3okqVzv0rezJbiLU2OBMvmFMVtFGSmEBG7F0FqMQ==
X-Received: by 2002:a05:6402:2113:b0:5d0:d610:caa2 with SMTP id 4fb4d7f45d1cf-5d10cb81015mr6132139a12.26.1733310304739;
        Wed, 04 Dec 2024 03:05:04 -0800 (PST)
Received: from f (cst-prg-17-59.cust.vodafone.cz. [46.135.17.59])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0cfcfe774sm4701654a12.88.2024.12.04.03.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 03:05:03 -0800 (PST)
Date: Wed, 4 Dec 2024 12:04:55 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Ye Bin <yebin@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, axboe@kernel.dk, linux-block@vger.kernel.org, 
	agruenba@redhat.com, gfs2@lists.linux.dev, amir73il@gmail.com, mic@digikod.net, 
	gnoack@google.com, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, yebin10@huawei.com, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH 00/11] fix hungtask due to repeated traversal of inodes
 list
Message-ID: <7t3guwcsncthkznwxxhtfd73ihho55qwqcaw6pr7h5sqriylxc@vkf7fkbgk2cd>
References: <20241118114508.1405494-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241118114508.1405494-1-yebin@huaweicloud.com>

On Mon, Nov 18, 2024 at 07:44:57PM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> As commit 04646aebd30b ("fs: avoid softlockups in s_inodes iterators")
> introduces the retry logic. In the problem environment, the 'i_count'
> of millions of files is not zero. As a result, the time slice for each
> traversal to the matching inode process is almost used up, and then the
> traversal is started from scratch. The worst-case scenario is that only
> one inode can be processed after each wakeup. Because this process holds
> a lock, other processes will be stuck for a long time, causing a series
> of problems.
> To solve the problem of repeated traversal from the beginning, each time
> the CPU needs to be freed, a cursor is inserted into the linked list, and
> the traversal continues from the cursor next time.
> 

I'm surprised this was not sorted out eons ago.

My non-maintainer $0,03 is as follows:

Insertion of a marker is indeed the idiomatic way to fix this, but I
disagree with the specific implementation.

All cond_resched() handling should be moved into the magic iteration
machinery, instead of random consumers open-coding it.

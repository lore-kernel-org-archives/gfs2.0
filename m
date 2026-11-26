Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795663712;
	b=o9xcUiPv+qS/ZXbGEHl/D1YHYBup+rqkWLW1rH/7BnRWoYUe3Fy/XTMX3SrlzC8mp7nw
	 2f22RLONgs5fewfmtFZyMpNOkkZyRyZA65P4gEOsKHlEF6Fvhpf25FywoFlwsKDzH5lRF
	 WxEMnSRScbPWh71Vwkbct1d1gQAXJ0RLsmAIz4iBDL9UaXHA9sEhY3twUMOUBQtq74+QY
	 PRei+ThijNWwAltRZXj8AzzjmLXZoBCV3jrIVWf01b4aR2BMLfcNW9mMwRTGTgtQwy4EX
	 klTWXMDtYgLbz1AbGiDyKPJvFWLI6quRdwE7r4uP0LBPZnMvW7yYMBUbq5SxNL590Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795663712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HqIBIkYmDIeS5rS19uDkZorN+oiTXB7kdAGh3sJeepU=;
	b=QwPlO74UiLxvrjv6A428gqcfq/DLFHscUNKSXzdMvd6MkNjL9dD1IRfSlcftE3TIPB+v
	 1ikk2t1nY/eaKnT+kZY0BrsbiY67F8FZ/bRyk8oiJhGEymB28NLOJqw/OHYv9eliWkGFs
	 2tFqeqZCjD7tEhqvjscPufCrFylqaakURsFfvz5YGse3TAnplkoMjNgQo9ZX4cV146lJl
	 Fx9xJ89Iz9HgoFR0b6x4FtcjzNliWwwrrlTG0RCm25xkwcNpKb5l250auUo+7VWlfWQnP
	 sEmBETKUjtt521t0zUg8pB2FeM7l0+KCb+AgYDgXkyQ5jGrtlbDU7qr4XOT+DJbIjNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=kJvJZ153;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C4B606A321
	for <gfs2@lists.linux.dev>; Thu, 26 Nov 2026 03:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55C4B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=kJvJZ153
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-55d30c054dfso67838671cf.0
        for <gfs2@lists.linux.dev>; Wed, 25 Nov 2026 19:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1795663710; x=1796268510; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HqIBIkYmDIeS5rS19uDkZorN+oiTXB7kdAGh3sJeepU=;
        b=kJvJZ153cGeu4SZ515qRQu7kcp2qeSRze+6e++eAin29pcY0iXMxtzvDh1xb9/MLho
         RwFacUFDgU/lGIXzgHU7yuL7L1eJWDgldXQcU17wARB7eF5EWxc4R9AIpUcKTP0eNRCh
         KR7YfkB9b4UopMdX2JPEGXmAqM0yaJeqmBuSKCe7bRLBpng5ez6mp7AEGH8EE81oL2lJ
         u8AfGpyTwEX4uzgdYxt+yAWY+hb00cWgi+jXj1kMwKtGk2z4zRZXwqhIWEHVmgqgIbaF
         6KUqzkzo6vjbu2NxbtgXmrhnyAYPO5AOiLmCOPgcCiLiBw9aNRM380/W50q/BmkTDazm
         STjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795663710; x=1796268510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HqIBIkYmDIeS5rS19uDkZorN+oiTXB7kdAGh3sJeepU=;
        b=BU0lbTpxsJT91kuFRyitYGtjDgHyvkdPSeZOvCAgyzecuSGiefhWIzuAb8Q5MbIbSf
         LqfNkreP21XTshv8l96hnBM2+WVesdg65MPLP4u5CILzfSAx8qKrVB+0l/35dhyPkbKw
         PxNY+o+as4uqYfGPhDVFpCfik0P1di1vo8HdQfAFdv2rcWeNK4KgNEYpl8uR8KczQFl9
         yQxwiV17rm7kCLCxOJSoGHTDsylRAJx8niJu9hiKUU/gNDZGfEXgA3RryxJCQLMpT50n
         3GkvZchcPK95pD7YGZqbPuq6Si/nq7wT6W/SnWFBqlHi6lR3+eRZGQEgbqXZ/CviCLkr
         CIdw==
X-Gm-Message-State: APuU4Z/tmd2nYd/Jcsz58x9+1bWjfXE/0UZBy9c5tGbh0mBP0C+cf2Jy
	P3wHz466WR4xmLuZl3TYh8WvKc+VUSERXUhhomjVrnt0Ykwry809ts7y3ypSVDxf9w==
X-Gm-Gg: AZFdTZfdwXX5HOKtyDePzK0tbVlqJoJ9ccVurzUbmfJKmRMJOEgk1+2DCL+DTMyXY0S
	3FzTh0RrGhLGEYXE/XOwyWqlK6jySDSoRoJtVKIeQUowhZsPInYSCcub0IVKlHQX6U8/Th5lVrw
	Ex4bJtIP+0SfJBpKMBVYubwzpfskdCX+71EML7a9jpH3eg49Yl/hzy3D6/9pqtfcyu4N4nId3U3
	UxPXXrG7JMR9tblmqiCupCeZpJHzWY9vP3V22MD7zWv/c6vMGOuzMgvnuSAiZCZmYpVZRw9hMfg
	LqVpir9eamyLoZ4VhIQCwdc4v2nIDUEGLWO9ZNfkANEe+AqNPHOY9Ln8nhEro1OOcMsn3CNh8lY
	CA4qzA5hYLDxh78xRDqdnnfbfx+0CXLUp71NBu+70E6Dmu8Bdx78w1NUs1gHTv/R5ZOdSn+Xfli
	uYr56KMEp5BZ/zW7qhPP125eSPf+riN2RVTx/DPziiC8BKd+gAgTsFNuLy041LhNIh1GigIJH6e
	Oj5El4BezGLkrsZVjG0IutkANInsIeYSd8V6saIOWomhX/++zhmPOy63h5UBY4XZpdz5tO72MZ4
	Tc3PbgaIBBhyBn0dYNeLPB7ItMNnEV9vaUEfuMHvvMhSiTjx2OEZ
X-Received: by 2002:a05:6214:451a:b0:921:39bd:6d05 with SMTP id 6a1803df08f44-92139bd6d64mr355239416d6.6.1795663710198;
        Wed, 25 Nov 2026 19:28:30 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a16754sm177671026d6.39.2026.11.25.19.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 19:28:29 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] gfs2: restart rename when a signal interrupts the glock wait
Date: Wed, 25 Nov 2026 22:28:26 -0500
Message-ID: <20261126032826.4156477-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125185332.2549812-1-agruenba@redhat.com>
References: <20261125175007.3659558-1-hengyul@cs.unc.edu> <20261125185332.2549812-1-agruenba@redhat.com>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andreas,

On Wed, 25 Nov 2026 at 19:53, Andreas Gruenbacher <agruenba@redhat.com> wrote:
> Why not make gfs2_glock_async_wait() non-interruptible instead?
> Something like the below should work.

That is better, thanks.

There is one problem in the sketch:

>  			prepare_to_wait(waitq[i], wait + i, TASK_INTERRUPTIBLE);
>  		if (!glocks_pending(num_gh, ghs))
>  			break;
> -		if (signal_pending(current)) {
> +		ret = schedule_timeout_killable(ret);

schedule_timeout_killable() sets the task state to TASK_KILLABLE again
after glocks_pending() has been checked. If the last pending glock is
granted between the check and that point, the wakeup sets the task to
TASK_RUNNING and removes the wait entry, and then the state is
overwritten. The task then sleeps until the timeout expires. It does
not hang, but the rename waits for the rest of the timeout.

I would pass TASK_KILLABLE to prepare_to_wait() and keep
schedule_timeout():

	for (;;) {
		for (i = 0; i < num_gh; i++)
			prepare_to_wait(waitq[i], wait + i, TASK_KILLABLE);
		if (!glocks_pending(num_gh, ghs))
			break;
		if (fatal_signal_pending(current)) {
			ret = -EINTR;
			break;
		}
		ret = schedule_timeout(ret);
		if (!glocks_pending(num_gh, ghs))
			break;
		if (!ret) {
			ret = -ESTALE; /* request timed out. */
			break;
		}
	}

The back-off sleep would be schedule_timeout_killable() followed by
fatal_signal_pending(), as in your sketch.

I tested this version on gfs2 for-next with lock_nolock, KASAN and
lockdep. The mv reproducer from the patch moves all 12000 files, and no
rename fails with EINTR under SA_RESTART handlers, handlers without
SA_RESTART, or stop / continue. SIGKILL and SIGTERM still end a rename,
and fsck.gfs2 is clean afterwards.

If that is fine with you, I will send a v2 like this with your
Suggested-by.

Thanks,
Hengyu

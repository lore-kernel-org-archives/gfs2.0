Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793697903;
	b=Gb+3zGFNoyIPxeYdRh0mqCNTO7WsAJz3IkW+VeYb0Rmq+GsOs1PvsYllYLntciGbw0so
	 CZmE2ezJUjtgX/eHyAgdJxGm6SfK9e5IPyAGr8sue3Vxd1zWvZnq80qKXiLW8q0ZD3l7p
	 kK74Eg1F2fjSWacZUz0l60LTQQ+7mXxsYMzbEiNLZfDMZ6P7hweOIrnOLkuDKtzsmWYnc
	 8glDVAIWTUZ/Wq0brJdueCA0qoC0gnQfARCBNWb3wTGrQO1TpoTDp28WyMQqFJWgRACQb
	 j2QSoVp5JhG7niAuFbPTwlPdd+VQ4Qcd661vTLPmhCxHy/OapeWu8ETeyaxs7exW1eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697903;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=wbk0beb8505pKbqVSOAGuX9uXweKMLn5Ud0DHY7wulE=;
	b=Ipa2VuW0kc7oqy+nLJ95AtPTT9duVEZnGmaPa8TeReGp1NRKIBSZfanWQuPFV4pJBsCB
	 umscu8wdOpbSlPiSCITrJyLI+Ypk6gnxlM9ucQ0kfCWV7yOIlxbIHPyVvsSzGhdPWDbcN
	 /U0YZan8HyETPD/PtjPlffAKkBKCJeHuc5TGD7vCzVlgHyV8LEW+vI61bn4b1h60EJFIT
	 i5bN6EoPD/4aZoFwJkVaXV50hmWj7POV0Smv8ijwjiRZ0BBWgaNu58wCuR1mO6Zn1QwZA
	 V3Z+UbZw1wCNo/pAdQ9zC4i9gqI1CJKMakZLcMszZBQKvEF2nY+bOTT5TKn+SZIOuvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=truenas.com;
	spf=pass smtp.mailfrom=truenas.com;
	dkim=pass header.d=truenas.com header.i=@truenas.com header.a=rsa-sha256 header.s=google header.b="jR5fye/C";
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D14606A32E
	for <gfs2@lists.linux.dev>; Tue,  3 Nov 2026 09:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4D14606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=truenas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=truenas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=truenas.com header.i=@truenas.com header.a=rsa-sha256 header.s=google header.b=jR5fye/C
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48e47347279so2432017f8f.1
        for <gfs2@lists.linux.dev>; Tue, 03 Nov 2026 01:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=truenas.com; s=google; t=1793697901; x=1794302701; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wbk0beb8505pKbqVSOAGuX9uXweKMLn5Ud0DHY7wulE=;
        b=jR5fye/CjVpF1V5RBP3hE1LjfcoJsWAzB2/M6gBJXD7uuEvaTxaiX1pDW2IFWEGMvn
         xhSF98+xjKnkCKdGkQYlaH8KiL0gmyuaif5kdPan/iNRodYPBdCuyycUWiX9xrXf/Njw
         R+1YpSqUL89fhygRv2aHt6RPfSgc9GKIu6v7u5rgrts+H9jkboHPwia/CjenlCOKFvwk
         VZF/XTxomdhmYPoprQ16GWvIDI+sYz7BgPO+RYdDcDFv1VGIeHX9K6Jo9QB4EDhgViLY
         tdrxnTYvCZr3Zoy0zjqvqeBTqqqKeB5z0nviUGf3MbcW6donQXjtGkBWi/N5D/DOkBcT
         MxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793697901; x=1794302701;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wbk0beb8505pKbqVSOAGuX9uXweKMLn5Ud0DHY7wulE=;
        b=LecZNigzygUNYXj6brCZN0GHaV9En7TcYqUq5qURliGrKqsID4xcNqFjSn3f3kHUms
         pmgExvtrYBcolBmiHdh0hHQY2mzjOa0wfiIYFHkDUcNv+j3phwbqrP0e+odHTOnn0KLX
         tqXx2Y+e4dNWYPlphv1DX1MiyP3peGW/Gis/kOHs4Upyvu8U+nXNtfoist3t6n7KIje0
         ZdRiAzkzJHgNkWO0qOnCUCAflnzNY6vvsLoZLzcRyBAKZo+HFwB5rtdpD8EWTvtCFFQw
         yGlwGP7Mwel/b7yrttD/RB5mC4g/m53GlhjeCGfgXacqgneU/NHv/2YyZi17eVIcCOHX
         iyiA==
X-Forwarded-Encrypted: i=1; AKwUvBxnC2YxmvAnjzF7cS/JsLP8/vG2PgGPo7P7+xByplrxl1R35vzEKyqgGzlBcPlskXYMWMuv@lists.linux.dev
X-Gm-Message-State: APuU4Z/+PSIZdlQdgLAys2bbmF1SsAe18V+442HZwH89r1SJWtt5xi/x
	Q5VnM3/i38UTY2IB3Ls7G4FBQDMEbKuLPwdeFFHvCCsxB5aTxdGtQ2QdXguPh0aeRQ==
X-Gm-Gg: AYBFou0GwIgdOcoV9fnqmUNp9qUhitjlBvJj1FYWcIAdBmDDXkq8siN/1xQL6P2mHrV
	UvPhcANexcvUjy/yOmveligoBtnhSLDLWtofDFqmQGg8wf/Ng64tum4BxmptOy14CV1WL0GzCS3
	txW8XDSnErp3e/5Q2Bpc7nlO710ntza0g3zn352l3fPfYOb2zRbT4uGY3y8scIwPF8t1RGe52qG
	bN89VSXtCn38LHxukgV/mf8eIEvCmDunii8OcuAVhPQtduseddteIB2Msv3ZT5eqyde1UEIyQBS
	XWl+1567JNJftAo6/bnCwKkiQBn0qVfAaAQKJEalAfgNQYZlGm6015GjXcHD+EupGBlVGUXzSn/
	HxJFt+Wl+sYdV2FTiRSAcmcktyfOLSLJ1TAWThm3p9b+gaDfW/2uObwmcExq4Mxq3oRJ2wrpgLs
	pednKNK9zDnARJW61Q0S6SwNimedUXc5j2mjlpvNgdVqxC9Q9zDTCEkfadPp/zixxE3bPdRPWne
	H5sovoN8SxsHW1wOaM/bOzq6qIvoHf50gLpd6Z4kE7F1bBMOy2OoBJKmzqadxli6pU0A0I8YENm
	dbWfB8w5
X-Received: by 2002:adf:e18b:0:b0:48e:2949:439 with SMTP id ffacd0b85a97d-48e6e4f5647mr29617079f8f.36.1793697900790;
        Tue, 03 Nov 2026 01:25:00 -0800 (PST)
Received: from hamza-PC ([2400:adc1:158:c700::1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b9a3b1sm25873954f8f.44.2026.11.03.01.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 01:25:00 -0800 (PST)
Date: Tue, 3 Nov 2026 14:24:56 +0500
From: Ameer Hamza <ameer.hamza@truenas.com>
To: Alexander Aring <aahringo@redhat.com>
Cc: David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, caleb.stjohn@truenas.com
Subject: Re: [PATCH] dlm: don't set RSB_MASTER_UNCERTAIN on rsb with no master
Message-ID: <aumi85ZXHFQ_D5ON@hamza-PC>
References: <20261019151627.3324886-1-ameer.hamza@truenas.com>
 <CAK-6q+j64=mSzuufOaSGjsC2aSwhb0hs9MKxxaAhbwugdztHZw@mail.gmail.com>
 <aujr6x9t2gXbXfFw@hamza-PC>
 <CAK-6q+jBNKN=oSCmm+i011FdhPS+42BZc0iUfbqGiLDBc0Py5A@mail.gmail.com>
 <auj4LE0bq7w7lOF8@hamza-PC>
 <CAK-6q+gqM6O4h762H5NVJ_B==VL2zaBVTBDiwUdbf5zxGNEDsA@mail.gmail.com>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK-6q+gqM6O4h762H5NVJ_B==VL2zaBVTBDiwUdbf5zxGNEDsA@mail.gmail.com>

On Mon, Nov 02, 2026 at 05:22:54PM -0500, Alexander Aring wrote:
> Hi,
> 
> On Mon, Nov 2, 2026 at 4:03 PM Ameer Hamza <ameer.hamza@truenas.com> wrote:
> >
> > On Mon, Nov 02, 2026 at 03:38:12PM -0500, Alexander Aring wrote:
> > > Hi,
> > >
> > > On Mon, Nov 2, 2026 at 3:03 PM Ameer Hamza <ameer.hamza@truenas.com> wrote:
> > > >
> > > > On Mon, Nov 02, 2026 at 02:49:04PM -0500, Alexander Aring wrote:
> > > > > question:
> > > > >
> > > > > how do you "pause" anything in DLM?
> > > >
> > > > The nodes are VMs, so I freeze the dir node from the QEMU monitor. It
> > > > stays a member but never answers the lookup, and after the cancel I
> > > > evict it through configfs. That is what happens on our HA systems when
> > > > the peer reboots without leaving the lockspace and a pending request
> > > > gets cancelled before the peer is evicted.
> > >
> > > Still, do you just randomly freeze it, or do you busy/poll wait on
> > > specific struct field changes?
> >
> > I don't poll anything. The peer is frozen before the request is made,
> > so the lookup to it can never complete. Then the request is cancelled,
> > the peer is evicted and the name is requested again, and it asserts
> > every time.
> >
> 
> I see, do you use dlm_controld/corosync as cluster manager?
> 
> I would assume at some point they should fence the frozen peer.

No, our HA manages the lockspace itself through the same configfs and
sysfs interface dlm_controld uses, with its own peer monitoring. The
peer does get evicted, but the monitoring first waits about a minute
in case it comes back, and the lockspace keeps running until then. The
requester cancels after 60 s, so the cancel can arrive before the
eviction.

Best Regards,
Ameer Hamza

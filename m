Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879C246C4D3
	for <gfs2@lists.linux.dev>; Fri, 16 Oct 2026 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142083; cv=none; b=uSBAuT9VmbfN6k1m+3QQ3CZtbcubd77gvF+n/MJOnZdibocyzwktJHP3pxMAO3FGH3gO2d+iR1RTDFm9KvY5IsvOk4XjRWJRgR2fFSdFbvEDkKLxWSszrSzzRAfqQagkS4SK3SeWRZh+D7BBcm2uweym7r5jGUdoHvsrl/d1RGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142083; c=relaxed/simple;
	bh=RjrTG7dlCmvCQaNfHYqGMEjUUYG2no0tg2xElaQykwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWmJc77hCLoI4wKGLq3ZRz99DA33qnH6xYd1aon75l2SPn5GX3JOT1BsPhAe0WVNpGYhaPtaZ3o2BBcOLYiQ5afXVywrq0tBjHu9pCa7uutnHqo113T7BZFWyHPCU2abF1MkVAjpq3gCUGEAWly+I0RYjA0khfSRjVgZH2OCWtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T02cLoIS; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T02cLoIS"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48b042c0728so1487055f8f.1
        for <gfs2@lists.linux.dev>; Fri, 16 Oct 2026 02:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792142081; x=1792746881; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g15pUqXB/gZtkjFNMKlMPbbN6ka4f/G72oFikrT6H5k=;
        b=T02cLoISdtZChey57RzXhoH0AbhNNmlgtkGeIo54MUk5cg2NELb2AMkNV7uJWHX8qe
         dDUSFLtuee6hnRdZlyp+NopkJewr9+8nsOQCr2Ymf+hl6Aq23PYVseTQ/Zf/KpWBYEXo
         QopYUegZvHbjCODVqzg/W26BvdsI53PXE55XNovvUefP91TQzZbFw9oOA7cyR0CL+/9h
         IRhhXxiyyMADfsAl3aJxaFYF3WUAN9bBw0X2KuYZST80QIrT6sehUjJgZjQd38jTiWw2
         sr5y/4BAzJopNme6erm/BVgtMKyiM1E60sk1uAh2mZGH1kKGYrQcrcxMi7N8rQoPUswh
         NOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792142081; x=1792746881;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=g15pUqXB/gZtkjFNMKlMPbbN6ka4f/G72oFikrT6H5k=;
        b=qx1we22i4sO5KragfSr6FY1amqaD+1dlZOrxOaCwB9IESUVPVB95X/d3tkf36Yl2j3
         QgOsgfZWDxViKhOin58SWNIX++ojXG3xUE70bAtOJg09vpcoRu+0l041oTLf7j8EKBJN
         NAaMhSbsMdgjTZ1KhO0GcDs9+b5Q0neXaVmsic2Jd990VSc8A93KYN8rS1iDL9cumlKn
         quxHpN60DS3kfDUYTyG4KmCvxOymBi5+NCUSiaEqtDKSWr8x4ViVhG1NOEFQcxacSjIE
         Ia7mlja56JJPXdXOyYFQSF8QwpaeSyGWMK/DrSl2Q8LlAMXBgPIlq4E4OXKtIGunKd3P
         Yprg==
X-Forwarded-Encrypted: i=1; AKwUvByrQUVz4xKCHecz2/GQ5JzUhspz73obAuWscl7IdrYCxNHusOYBkoSTFbLv1Wm0t8CNKhKJ@lists.linux.dev
X-Gm-Message-State: AFq9FYJ6mdd0S5bLuH1JpJAHyr6BuoD8+1ox1Amwjcb6opitfkeE4mYj
	TMAq+Xzv8GciOVUvVkY6KSQ9QWHLKnb0VwqKyXbP3WIVWsSQniCL8IIKjMODZmhtnSP1ug==
X-Gm-Gg: AYBFou1VNTeZ86XQousUf1x+KNlDbjoFn+Bq4bkYgmrry52bgqUmQJrrIFfi7gaCjfV
	Y1p0B/mGOxVKZ2T9dalt3kMtldyaZhcAQK9CLwFxVDnTzaLbNakqQ8IScdUWi5td91P0s2PkpP5
	ziqSmAqRSHIrNe+Sw8uUl6GFSY8INwoUGnOabsDNmmp5FQgxnH9RJXKQUQZfgjsygJbIKuyIUfh
	EIR+OOIpZQehX3F100Qgr4XfEiGZtIbsWYxpRdZJLb+ZTstfJEAE7/j9odIDKHwEPWFTnxKLs91
	6oOcBpOiZFnyHe3CzRTyv3UFzv3yptBgjU7vR3awMpstqRpOPQO7gB+CyKf8v2r1wjEC8G6JAbx
	BFvp963jrn1Dor25JZnyr5DfcKEClnPmZ0mXbQp20ECHtkmgRTkNrYhtVIdkImS2QucQ+t95Xq8
	UqTLOCYEMljrloEh4Xkb8+LXYt+7SR99doe918SMYsLZw7bQ1+JsjkCU7oJKNEB6W10dA=
X-Received: by 2002:a05:6000:4694:b0:48d:e101:5707 with SMTP id ffacd0b85a97d-48de1015749mr17082052f8f.13.1792142080619;
        Fri, 16 Oct 2026 02:14:40 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4c4fc4sm3352171f8f.15.2026.10.16.02.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:14:40 -0700 (PDT)
Date: Fri, 16 Oct 2026 12:14:36 +0300
From: Dan Carpenter <error27@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Alexander Aring <aahringo@redhat.com>, gfs2@lists.linux.dev,
	kernel-janitors@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	David Teigland <teigland@redhat.com>
Subject: Re: dlm: clean up a type in waiters_read()
Message-ID: <atHq_LLtPx8SXMUt@stanley.mountain>
References: <ar4BZ26gjQEjZgIa@stanley.mountain>
 <ffeb3e5b-d9de-4337-b250-e27667024461@web.de>
 <CAK-6q+heOWNY8CY8dgotxzEeFC_-huHnnO2pgH8kJsJSGryOtw@mail.gmail.com>
 <c8b6843c-c87a-4330-b6f4-e556117a8026@web.de>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8b6843c-c87a-4330-b6f4-e556117a8026@web.de>

On Tue, Oct 13, 2026 at 05:27:10PM +0200, Markus Elfring wrote:
> >>> This doesn't affect runtime but "rv" stores error codes and so
> >>> declare it as ssize_t instead of size_t.
> >>
> >> Can a similar adjustment matter also for the local variable “ret”?
> > 
> > What do you mean by 'matter'? It's declared as cleanup.
> Can the usage of a data type like “int” become more desirable for “ret”
> according to the affected function implementation?

Either way is a defensible style choice for "ret" so I left it as-is.

regards,
dan carpenter


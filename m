Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D6331A049
	for <gfs2@lists.linux.dev>; Wed, 18 Feb 2026 21:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771451640; cv=none; b=ihtnOKvSitQ/6Bp/eC+LM+NNB7OXolWGaCbseZJGWxlTCUZKOzyUezBEBZ1/PjaCWMCLhzrM4ZtL69QNGFx3NcQNPixtJPmQPgaIGYJNG6ih2ONjgxr5u3ZN68GiSXAhCqfH4aRvm+azbZVDAXUPqNzPViMNSXbqmjO0TDMV+dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771451640; c=relaxed/simple;
	bh=yiZwkgF3kiNHaL7k0PdazEmxDginp2jVf72EIFLrFt0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Hp8GncJpUvXmkdlGe0BksjMHhvEj4Q+hReQOlYd+TfjLpMY/1uim2WXx+JP+NViv4Jd9jeQRPjyyzLzp/eHQ25FCU1MAWh8maWhGLHZ8MmYckmkXT3MtjKq40Xp7dlSMyJQ18qNBUUOYJWBOPpt5zMrFHWdscc0/BZs3xUo87Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVaCtfkY; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVaCtfkY"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7947cf097c1so3079527b3.2
        for <gfs2@lists.linux.dev>; Wed, 18 Feb 2026 13:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771451638; x=1772056438; darn=lists.linux.dev;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiZwkgF3kiNHaL7k0PdazEmxDginp2jVf72EIFLrFt0=;
        b=SVaCtfkYrjKKzhOyojJh/e+uRzx0KnyBhht9yIg+/K4lsZeTkTemp8oT3e14jYWYXY
         cAMpMTTODd5KunsCty6sI8mqDUaKg5y6HUgP+GUSpNE/ixOLJU9ECGh7so34hvX3hW6A
         znd0xEhc3CnpchlHQPwfuDeeRSum5r/zjqWm6bdtJ9iB/F26BG9u3J7Hg3nOZiIt6w/q
         Wb47Bvzw3KjAGoJqEV4Q+ShGoohvUhl8sK/014F/4SxXYGL+G+wHyrJqv4uAqwciYC9Q
         Emgwj7yY0rCBvbPwkVLcyCnQk5C1zAw+mEAPldDQLHgNeRlaROG5YKMHJA69CavU4IU+
         3ivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771451638; x=1772056438;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yiZwkgF3kiNHaL7k0PdazEmxDginp2jVf72EIFLrFt0=;
        b=kO247REY9Dqz5uhcntp1AT5ay3FTNJZJLCpVj4UEC245MPbJ01wPKjjpUCE6lKT3Wx
         LT5QUp5Np2qYEcmN4iyUf5ByWFKmZ5rXhwNlw076q/vivhPL1HwWBPupMdwHmEOzytk1
         iPeFtOo5sWhTOhLr1IhDOIsZ0h7f2PEnDxniMZViP2kSoGQMiwk90cFdCr8ZYZ1ucdZ+
         XYBpKZOD/W+DSwtbHLAKf7c6con3iuYs18O1IxriLX5NlKEpurg6wcjzWVy4Wo8XYn1T
         16TrBkOdho7pK0oj03v8WvLF7amxyxRAVvHBbH8bc0X7KWPxZY3Kbl75EpYRE0Nq8MNO
         GPKw==
X-Forwarded-Encrypted: i=1; AJvYcCWlFDOa1ZyguP8rFrZYSwhOIcANgP09GCAK8AasjGhSRwDvXL0kDVBaysGjlxmc6Eaeromt@lists.linux.dev
X-Gm-Message-State: AOJu0Yx6e66kwNwwL8rmPgxBn1p5x+pwIyV0EvGrFfnjA6pMRGIsYciR
	1lkeM5nbYtuyXDzLBoq0bNYg5fE1FGL7I0fDEp3L/Zly6SBm3i20w1rc
X-Gm-Gg: AZuq6aJtoIuc8vURJaKAQwHOcrCcSlOZ9Q/nBxgmp/uJlcOceXX51PzY7UMDhlQu9lq
	gSRHOwvZmm8NBgSV0XTaLPm0Ur6YGjN+GyVjLacPxwTDftIs7qlKTbGyZlZAUJW1ujjgltqzk0C
	2MeH7TKLd5nu79gdVj5YJDvS/sqsZvZTbIFXjWo42tvVobs/fI5ah4CSGO/5VtbxaoEdIoV6VI7
	FHd0WEhDHfrzv2uxVhIwEMks910R8odrb5cHo5fF+lobcKLbb/3zKoWzI6Gu8qxMaUvGLLy4bxW
	yWQ2CZ1LFoRIfacuvmz0qAiV/h+SE/zXnKt+jjNJK2Nc1fp4KES4fPRj9vyDapflf5mXhvk0xJk
	fszSmfg8xTcWGy85yrHUn6zGcOLvm1g7OOiAjMZwVf9V5z9XzNtsqNHV9ruX2NlE5cMYKkcu8pF
	zxzvBB0sWY8t5bg2gGfVGM6Rgbmsqu6Khnxi29b4QFNMg+00P+8YnNlV7RLJ16kbQS9w1kT2S07
	mvOtQzp1jtVeM6m6KUiihbw6N0pe6ffrYL0lZa3SZFG0ff2Xsg=
X-Received: by 2002:a05:690c:399:b0:796:5278:84f0 with SMTP id 00721157ae682-797ac61b556mr132033307b3.57.1771451638451;
        Wed, 18 Feb 2026 13:53:58 -0800 (PST)
Received: from localhost ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-798064888ebsm629497b3.15.2026.02.18.13.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 13:53:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Feb 2026 15:53:40 -0600
Message-Id: <DGIF6W2ADL8N.RRRHPABYOFUG@gmail.com>
From: "Ethan Tidmore" <ethantidmore06@gmail.com>
To: "Matthew Wilcox" <willy@infradead.org>, "Ethan Tidmore"
 <ethantidmore06@gmail.com>
Cc: "Andreas Gruenbacher" <agruenba@redhat.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, <gfs2@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gfs2: Fix error pointer dereference
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260218200645.15713-1-ethantidmore06@gmail.com>
 <aZYrw29iK1ak5Npw@casper.infradead.org>
In-Reply-To: <aZYrw29iK1ak5Npw@casper.infradead.org>

On Wed Feb 18, 2026 at 3:14 PM CST, Matthew Wilcox wrote:
> On Wed, Feb 18, 2026 at 02:06:45PM -0600, Ethan Tidmore wrote:
>> The function __filemap_get_folio() can return an error pointer and is
>> not checked for one. Add check for error pointer.
>
> Can you explain how __filemap_get_folio() would fail, given the
> presence of __GFP_NOFAIL in the GFP flags?
>

I hadn't thought of that, looks like Smatch gave me a false positive. I
just saw the same function being called a few lines down and its return
value being checked for error pointer so I just assumed this one was
missing. Sorry about that.

Thanks,

ET

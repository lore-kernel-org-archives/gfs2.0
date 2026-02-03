Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610F83A4F2C
	for <gfs2@lists.linux.dev>; Tue,  3 Feb 2026 14:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770127248; cv=none; b=s2wFIHbNGdsLne7enmLTgURZKyKo2rxdYpO2OtAojQQAwC06Yx2VPiDKnJWIJKjE766hVz4O7dbFKHKclx8TKvenzBtllpVYT7xTivpvDY14fe3diyqcDfqDd5T5MPcRTDGxyeem+SOmzQKhZco+uUXkYjQnpqI6k3oGojkpjo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770127248; c=relaxed/simple;
	bh=R+6kwNGd3gLsL+dkhY/xwLml2SgQbzN7YFWnTUlpPo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkjtjmlVFiIlnGy2AcClEnAN8xd/1VsHegPqw4MnwYugTsJk2XHe2ATEhI8Y77NKCBAAIsjpkynEU5XxJd5+KyVXN6IfdT+pTcbI8A1Jf255R1sBpnco0j1IGH5dBXH7X9RnfM16KOb3TKoy5HkeyqOUAMEOYSOYAYGuEJVd/80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8cgZVGl; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8cgZVGl"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-649bff225d4so2213872d50.2
        for <gfs2@lists.linux.dev>; Tue, 03 Feb 2026 06:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770127244; x=1770732044; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+tCSLyCDbpK03koWwWlEulMnOqXMu/KY0ai0EF+gkE=;
        b=Y8cgZVGluZkgIuYERe8j+v/TIzIUfqGYtWPE1OU0X40TB3MAsLZg7KQMgM/xbjeJqN
         c1phX5U4TQ6VSQOc5p3i+Iq5hNw3LivkbUkKCGwQbw8wp1BVaml52EisHnQR98W80N/z
         v7ZBuyU7/KquCVjWbNYi/ybxzDpKxm8oPS6Nu7Sg7cbsKVW+vVKi79YndkIqcFhWBqwe
         gKkz+uu56rwcrrEOAWeJS/Lo62eZmaELYe04v4AdyxtzKCX6kS7aGJlzq7IU7fEQnIlI
         ElvstcEk3Y8HDbFt3PkXVIrj6R5umtNBewD1lhsSM6zoF1blB03YWgbaab/XTMXRvWmA
         yliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770127244; x=1770732044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p+tCSLyCDbpK03koWwWlEulMnOqXMu/KY0ai0EF+gkE=;
        b=vqmveVaDKpGI0EMBMCWooP2cy+7VCbxEqIm0Vn5vADsWtqy2EMaIESwcMep8gPqs+i
         sY5i7ldIPGMqSOVd+snoB1ZQTcyyS2NIX5abDJgrk+oeQi8hmeoNNl3nmjQI+EAhS9c5
         yJoODsQWk6gWWmu5uSCu5qhPOVju560jLWyDfIZ/OrPyKWhbhWKk/7n6Av1Hzegn20/9
         94iFNt+LE09wI8c0Kh3nu7TJbdVlqOEbZWFd7764Ail6ZDNbf80d/zALveMTd92OEkLN
         1qGEhvZmdWxSepj8DkJPAhQ5QHwFUMOU0A1SWKs4nMfvuHmz5tKyO4dLL+5vv2qSHfyx
         p4Hg==
X-Gm-Message-State: AOJu0YwAi8VfmOPMEJjrM+lcR4n1IuxbKDIOZT0CDO0/eSjXli500CQr
	Un5ijgK5PuSIcVvZQb6XteHnoiHIkqGkj1ezx6/dFrS6MwlwzaBclJSV
X-Gm-Gg: AZuq6aJHwrXRJssh/ZkS3t1uKh6nl2EEFALaBiv+G+GBOGHQmOUtXutcYZ5GPeoQWct
	E/8ENH3lgJutjCEEB0FiOW/NKozUEGrHNyx3Eddkj7bdoaOUc4tXlf43DZIxtzDyGd/0bSvdzv6
	nsmxzeCVzL6M9mhO7IyfQQXNsjHNVuE9U8Vauoqy/VW8cJvF6tW3LEpVmzjsBj+/aVXKENHEibY
	xW5V2PohBAGewg9vu2XnXr3CIN4R4pZbqDRlwbmEZGJPWZidnOltrUab8FgxRbv+2usyqb5HXY3
	l23V3yM2kyKYx8/UG99LPuS+XuK1lrRARUNO2DGrnrFV/XbQijOWRvqzdSku6ld05jocvy224e9
	3UB1ih6m1Ut5HCsC0Ph0XkJTT396/ScKOK8nZJijuLasD5IFO6/DRZMMDFO/JzSOqTKc5ttoKGX
	wtd3HIedLQhHYSvrJ8N1CL
X-Received: by 2002:a05:690e:134d:b0:649:c36a:a9b4 with SMTP id 956f58d0204a3-649c36aad82mr5835694d50.36.1770127244061;
        Tue, 03 Feb 2026 06:00:44 -0800 (PST)
Received: from fedora ([187.120.156.78])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649da68046bsm36693d50.16.2026.02.03.06.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 06:00:43 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	trintaeoitogc@gmail.com
Subject: Re: [RESEND PATCH] gfs2: do not evict glocks with populated address spaces
Date: Tue,  3 Feb 2026 11:00:30 -0300
Message-ID: <20260203140030.36921-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAHc6FU5eRLt5X7T1BTK2jCuzKc8PHk7wy0UMCVyfBnerSUF7_Q@mail.gmail.com>
References: <CAHc6FU5eRLt5X7T1BTK2jCuzKc8PHk7wy0UMCVyfBnerSUF7_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Andreas Gruenbacher <agruenba@redhat.com> wrote:
> There are two GLOCK_BUG_ON() assertions in __gfs2_glock_put(). I
> assume you are talking about this one:
> 
> GLOCK_BUG_ON(gl, !list_empty(&gl->gl_holders));
> 
> This should never trigger because each holder has a glock reference
> (see the gfs2_glock_hold() in __gfs2_holder_init()), and so
> gl->gl_lockref should never reach zero while there are holders.
> 
> If none of the holders has the HIF_HOLDER flag set, we don't know if
> the glock is actually locked.
Sorry, yes has two GLOCK_BUG_ON() assertions. I talk about the second
GLOCK_BUG_ON on __gfs2_glock_put(): 
`GLOCK_BUG_ON(gl, !mapping_empty(mapping))`. 

NOT ABOUT `GLOCK_BUG_ON(gl, !list_empty(&gl->gl_holders));` (the first
GLOCK_BUG_ON())

The dump_stack() indicates a memory pressure and the
gfs2_glock_put_eventually() on fs/gfs2/super.c is called.
But when the __gfs2_glock_put() was called, the glock was has a private folios. 
I test by this way:
```
struct address_space *mapping = ...;
pgoff_t index;
struct folio *folio;
xa_for_each(&mapping->i_pages, index, folio) {
	if (folio_test_private(folio)) 
		pr_err("I have private folios")
}
```

And, I can see the glock is about metadata:
`gl->gl_name.ln_type != LM_TYPE_INODE`

the truncate_inode_pages_final() failed silently when the folio is private.

I guess maybe evict metadata (or locked) glock is not a good idea.

Thanks, Guilherme

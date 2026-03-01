Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD52C2D97BA
	for <gfs2@lists.linux.dev>; Sun,  1 Mar 2026 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772368562; cv=none; b=qZopZ4SYUrpDWFaDacBtVYhMU0UdL8B3+i03aB9aYbB6mos8vv0gG2QDywc+tdgfeDq0sx0kaTH5LDxk5R5ao/qDqDiJg/rqCnPkoDmBtb58tlxvFCDEPpvQ/9T32aw/eiV8ryKhGI9ifoxGvQDyzdS7ymAtI0Z9A8xc1LATspI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772368562; c=relaxed/simple;
	bh=YBF9BYKbYIlSAGru0TQQbtbsevPnAE/QxOrhYk4Ab6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KeCrEd0ntLLnLdYt78fnlGGLEXVLrY0PrDsbZaZfCkFC1oqweoNM8uhJpEdKsTF7caiDH+LHp6MdqzEoEpdjePzhZG9B4HX5kzlhn9epkoEek+P/blFmst/fMnqaQoKxTsARot0FaJOf/ZVeA7pj2dp6nb3gbxg8GWOOczU21JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVsdlpF2; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVsdlpF2"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-127380532eeso10246298c88.1
        for <gfs2@lists.linux.dev>; Sun, 01 Mar 2026 04:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772368561; x=1772973361; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzFXSy0QviyDiMF/kzMrH03+sliS+deFE1g+XpxSQKg=;
        b=aVsdlpF2Dy9JaGPQVZdNL32w+4UsnfNMBudiWR9Tn52Upsjrwr92+988yytjx1cs/u
         fWOfqxM4W0tCBakvOwdhJiBuRoqojnthRaeLkFvippZ0aeufTWw8feBd2eS5wj1zeTgZ
         3jKBI5zcMGMk7l6xU/AYhqqKUEiRXfA0HpjvBx5hSywD+mItq71cVGohkY03BhKeZUJy
         CaNlSA4KDTgUi7HBxtrfREozShA8U/aquUUkw3PIKxvLmxJakcOq2bvNnXvKQWml8p/q
         o1js9KVZXcoCgHH63epzz4BUXvbMAEXJiaeOumGQFHjgand5zQi0urgT7fq36D4Zo8zt
         aOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772368561; x=1772973361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BzFXSy0QviyDiMF/kzMrH03+sliS+deFE1g+XpxSQKg=;
        b=XFdAh3l2cqucAeXXeYJWeV44S40u7S7Iw0av3kdMcPweQC9Fxijdj/1ZlZRBYwqgTL
         VD4OuGHoBCvLqQlKHYSJKvgsCG0e8FWkxLaLFXDX4BYKyGPNSPQ1aARfe06gkLKPnmLR
         jUg84jIT+sG36AMkEM4zovkni9VBWSuMXJ1tZhPWE5pvCOUfRrwdnMKVE4JkKGWky1OH
         63hiDsHZW5OHCzfz+4t+skhlKFHJkwwerkHNM9tuwbsOOHX7MBczn2XZhTBv79+ov3Ya
         QY4HhaJbYqOUToOvkg0GQx8Hu+FjM/CRbvXIR7cTJkamY7C+7OnqWaYsu4m6xhy9oZ1y
         hnFw==
X-Forwarded-Encrypted: i=1; AJvYcCXIxqvnU7p2i7qVidXe4XRPDom3v7RWyKBXmlNk8N8WbtdQK19S7s96Zh/QJpp7B3LitZBr@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4kkVH4UNPJFwM0xWSKyHWmllQWdqLvEOVV2a6sZ1vSXkaprgP
	gk1gsWAWs/yJrk4bSrSIdHKxFzE/FDaHg5OdFAJ9vw/P+yrF4Shp7B2h
X-Gm-Gg: ATEYQzykxNh553up2Gg3efR9uDcWOSRUrWJec/A+tt6l3zhBdIZWo//DfvpCIAY1f3v
	23YbrhhZI2aeZfRE2gAeB7jItrJrWojGUEsuMss/ix4+NR76N1ypePjrf3IWSdU5Rn9nB4TuPns
	3P7BMNSQIB/rqIfGqBzFL+eREafRTnJRd0gS9BgdBsFTq1fGLEQjvrWvjLjuMuqBy1dLwSGw6Es
	mOGs5d3s1zXhpxAcOtdNhPygpxBzK4X1oRnZAP5PCkPu6mcD4W6ilhTvT80SWkUQsJb5VueGPVc
	90myg3SkP8qJM8uOL4HdjJA5WWXInAn/IlQBa4zLum7MDvDMQ6HduiTEVmV4jE6lUICI0OXNveo
	sxWo6pGJO570Qn1v89a0CbR44TrfORgh2rjaI6YVuoOW/3RTEo3GK90S1jaMqaupLdAgK2iLw+8
	mcQUBoKwDXXKfvsAWCTCWR/w==
X-Received: by 2002:a05:7022:609e:b0:124:9dea:188d with SMTP id a92af1059eb24-1278fcfdcf6mr3544073c88.30.1772368560788;
        Sun, 01 Mar 2026 04:36:00 -0800 (PST)
Received: from fedora ([187.120.159.36])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12789a32633sm11631217c88.9.2026.03.01.04.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 04:36:00 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: trintaeoitogc@gmail.com
Cc: agruenba@redhat.com,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] gfs2: do not evict glocks with populated address spaces
Date: Sun,  1 Mar 2026 09:35:51 -0300
Message-ID: <20260301123551.138132-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203140030.36921-1-trintaeoitogc@gmail.com>
References: <20260203140030.36921-1-trintaeoitogc@gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Guilherme Giacomo Simoes wrotes:
> Sorry, yes has two GLOCK_BUG_ON() assertions. I talk about the second
> GLOCK_BUG_ON on __gfs2_glock_put(): 
> `GLOCK_BUG_ON(gl, !mapping_empty(mapping))`. 
> 
> NOT ABOUT `GLOCK_BUG_ON(gl, !list_empty(&gl->gl_holders));` (the first
> GLOCK_BUG_ON())
> 
> The dump_stack() indicates a memory pressure and the
> gfs2_glock_put_eventually() on fs/gfs2/super.c is called.
> But when the __gfs2_glock_put() was called, the glock was has a private folios. 
> I test by this way:
> ```
> struct address_space *mapping = ...;
> pgoff_t index;
> struct folio *folio;
> xa_for_each(&mapping->i_pages, index, folio) {
> 	if (folio_test_private(folio)) 
> 		pr_err("I have private folios")
> }
> ```
> 
> And, I can see the glock is about metadata:
> `gl->gl_name.ln_type != LM_TYPE_INODE`
> 
> the truncate_inode_pages_final() failed silently when the folio is private.
> 
> I guess maybe evict metadata (or locked) glock is not a good idea.

Andreas, thoughs?
